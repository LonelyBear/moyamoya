#include "stdafx.h"
#include "MedData.h"


CMedData::CMedData()
{
	m_vtk_volumeData = NULL;
}


CMedData::~CMedData()
{
}

void CMedData::SetVtkVolumeData(vtkSmartPointer<vtkImageData>	m_volumeData)
{
	if (m_vtk_volumeData != NULL)
	{
		m_vtk_volumeData = NULL;

	}
	this->m_vtk_volumeData = m_volumeData;
}

vtkSmartPointer<vtkImageData>	CMedData::GetVtkVolumeData()
{
	return this->m_vtk_volumeData;
}