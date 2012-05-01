Imports System.Data.SqlClient
Module modGeneral

    Public objcnn As SqlConnection
    Public objCommand As SqlCommand
    Public objDataAdapter As SqlDataAdapter
    Public objDataSet As DataSet
    Public objsqlPrarameter As SqlParameter
    Public objSqlDataReader As SqlDataReader
    Public loginwithfaculty As Boolean

    Public Enum enumComboFill
        CF_SEMESTER = 1
        CF_SUBJECT = 2
        CF_FACULTY = 3
        CF_QUALIFICATION = 4
    End Enum

    Public Enum enumComboFillType
        CFT_BOUNDID = 1
        CFT_BOUNDCODE = 2
    End Enum

    Public Sub Main()
        createConnection()
    End Sub

    Public Sub createConnection()
        objcnn = New SqlClient.SqlConnection("Data Source=DHWANI-PC\SQLEXPRESS;Initial Catalog=DSS;Integrated Security=True")
        objcnn.Open()
    End Sub

    Public Sub FillCombo(ByVal objCombo As ComboBox, ByVal strSql As String, ByVal varComboFillName As enumComboFill, ByVal varComboFillType As enumComboFillType)
        objDataAdapter = New SqlDataAdapter(strSql, objcnn)
        objDataSet = New DataSet
        If varComboFillName = enumComboFill.CF_SEMESTER Then
            objDataAdapter.Fill(objDataSet, "TTM_Semester")
            With objCombo
                .DataSource = objDataSet.Tables("TTM_Semester")
                .DisplayMember = "SemesterName"
                .ValueMember = "SemesterID"
            End With
        End If
        If varComboFillName = enumComboFill.CF_QUALIFICATION Then
            objDataAdapter.Fill(objDataSet, "TTM_Auto_Qualification")
            With objCombo
                .DataSource = objDataSet.Tables("TTM_Auto_Qualification")
                .DisplayMember = "Qualification"
                .ValueMember = "QualificationID"
            End With
        End If
        If varComboFillName = enumComboFill.CF_FACULTY Then
            objDataAdapter.Fill(objDataSet, "TTM_FacultyInformation")
            With objCombo
                .DataSource = objDataSet.Tables("TTM_FacultyInformation")
                .DisplayMember = "FacultyName"
                .ValueMember = "FacultyID"
            End With
        End If
    End Sub

End Module
