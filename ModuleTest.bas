Attribute VB_Name = "ModuleTest"
Option Compare Database
Option Explicit

Sub �G�N�X�|�[�g()

    Dim mdb As New MDBManipulator
    mdb.ExportForAcTable mdb.GetOwnFolderPath & "\������.mdb", "T_�Ɛэl��_�U�������X��_�@�ƈ�"
    mdb.ExportForAcTableAndNameEdit mdb.GetOwnFolderPath & "\������.mdb", "T_�Ɛэl��_�U�������X��_�@�ƈ�", "���O�ύX��"
    
End Sub
