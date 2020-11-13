#include "stdafx.h"
#include "FileOperation.h"


CFileOperation::CFileOperation()
{
	m_niiReader = NULL;
	m_niiReader_2 = NULL;
	m_dicomReader = NULL;
	m_medData = NULL;
	m_medData_2 = NULL;
}


CFileOperation::~CFileOperation()
{
}

//openNIfTI
CMedData* CFileOperation::openNIfTI(CString filename)
{
	m_niiReader = vtkSmartPointer<vtkNIFTIImageReader>::New();
	m_niiReader->SetFileName(filename);
	m_niiReader->Update();
	if (m_medData != NULL)
	{
		delete m_medData;
		m_medData = NULL;
	}
	m_medData = new CMedData;
	m_medData->SetVtkVolumeData(m_niiReader->GetOutput());
	return m_medData;

}
//openDICOM
CMedData* CFileOperation::openDICOM(CString filename)
{
	m_dicomReader = vtkSmartPointer<vtkDICOMImageReader>::New();
	m_dicomReader->SetDirectoryName(filename);
	m_dicomReader->Update();
	//int sliceNum = m_dicomReader->GetNumberOfComponents();
	if (m_medData != NULL)
	{
		delete m_medData;
		m_medData = NULL;
	}
	m_medData = new CMedData;
	m_medData->SetVtkVolumeData(m_dicomReader->GetOutput());;
	//int dimension[3];
	//m_volumeData->GetDimensions(dimension);
	return m_medData;
}

//open Double nii
medDataList CFileOperation::openDoubleNIfTI(CString filename_1, CString filename_2)
{
	if (m_medData != NULL)
	{
		delete m_medData;
		m_medData = NULL;
	}
	if (m_medData_2 != NULL)
	{
		delete m_medData_2;
		m_medData_2 = NULL;
	}
	struct medDataList list;
	m_medData = new CMedData;
	m_medData_2 = new CMedData;

	m_niiReader = vtkSmartPointer<vtkNIFTIImageReader>::New();
	m_niiReader->SetFileName(filename_1);	
	m_medData->SetVtkVolumeData(m_niiReader->GetOutput());
	m_niiReader->Update();

	m_niiReader_2 = vtkSmartPointer<vtkNIFTIImageReader>::New();
	m_niiReader_2->SetFileName(filename_2);	
	m_medData_2->SetVtkVolumeData(m_niiReader_2->GetOutput());
	m_niiReader_2->Update();

	list.m_medData_1 = m_medData;
	list.m_medData_2 = m_medData_2;
	return list;
}
