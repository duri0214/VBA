Attribute VB_Name = "�N���X�ɂ��ɂ������"
Option Compare Database
Option Explicit

'��notice
'�N���X�ɂ��ɂ����������ȁ[�E�E�Eutil�N���X�ł���邩�H

Sub �e�[�u���W�񌟍��N()
    
    Const TBL_PREFIX As String = "W_�Ɛѕ]��_"
    
    Dim ym As New UtilYM
    Dim stMonth As String
    Dim enMonth As String
    Dim crrYM As String
    Dim boundFor As Integer
    
    Dim sql As String
    Dim editSql As String
    
    Dim i As Integer
    
    sql = "SELECT " & _
            "Sum({TABLE_NAME}{YYYYMM}.�������ώ��v{YYYYMM}) AS �������ώ��v{YYYYMM}�̍��v, " & _
            "Sum({TABLE_NAME}{YYYYMM}.�ב֎萔��{YYYYMM}) AS �ב֎萔��{YYYYMM}�̍��v, " & _
            "Sum({TABLE_NAME}{YYYYMM}.��s�Ԏ���萔��{YYYYMM}) AS ��s�Ԏ���萔��{YYYYMM}�̍��v, " & _
            "Sum({TABLE_NAME}{YYYYMM}.��s�Ԏx���萔��{YYYYMM}) AS ��s�Ԏx���萔��{YYYYMM}�̍��v, " & _
            "Sum({TABLE_NAME}{YYYYMM}.�d�a�֌W�萔��{YYYYMM}) AS �d�a�֌W�萔��{YYYYMM}�̍��v, " & _
            "Sum({TABLE_NAME}{YYYYMM}.�����U�֎萔��{YYYYMM}) AS �����U�֎萔��{YYYYMM}�̍��v " & _
            "FROM {TABLE_NAME}{YYYYMM}; "
    
    stMonth = ym.GetPeriod_Prev_RetFirstYM(2)                       '�J�n���m��i2���O�̊��������j
    enMonth = ym.GetAddYM(-1)                                       '�I�����m��i�����j
    boundFor = ym.GetYMInterval(stMonth, enMonth)
            
    For i = 0 To boundFor
    
        crrYM = ym.GetAddYM2(stMonth, i)
        editSql = Replace(sql, "{TABLE_NAME}", TBL_PREFIX)
        editSql = Replace(editSql, "{YYYYMM}", crrYM)
        
        SummaryResultOutput editSql
    Next i
    
End Sub

Sub SummaryResultOutput(editSql As String)
    
    'editSql�ɓ��������N�G���͏W��N�G���ł��邱��
    '�o�̓t�@�C���͎��p�X������summary_result.csv�Ƃ��ĕۑ������
    '�g���͂͂Ȃ����A�܂����Ƃ���model�I���W�b�N�Ȃ��
    
    Dim mdb As New MDBManipulator
    Dim rs As New ADODB.Recordset                                       '���R�[�h�Z�b�g

    Dim report As New LogWritter                                        '�o�̓t�@�C��

    Dim msg As String
    Dim col As Variant

    report.OpenTextStream mdb.GetOwnFolderPath & "\summary_result.csv"  '�o�͐�t�@�C���̃I�[�v��
    rs.ActiveConnection = CurrentProject.Connection                     'RS�R�l�N�V�����m��
    rs.Open (editSql)                                                   'RS�I�[�v��

    msg = vbNullString
    For Each col In rs.fields                                           '�w�b�_�o�͓��e�����邭��W�߂�
        msg = msg & col.Name & ","
    Next col
    msg = Left(msg, Len(msg) - 1)                                       '�Ō���̃J���}kill
    report.WriteLine (msg)                                              'CSV�o��

    msg = vbNullString
    For Each col In rs.fields                                           '�f�[�^�o�͓��e�����邭��W�߂�
        msg = msg & Nz(col.value, 0) & ","
    Next col
    msg = Left(msg, Len(msg) - 1)                                       '�Ō���̃J���}kill
    report.WriteLine (msg)                                              'CSV�o��

    rs.Close                                                            'RS�N���[�Y
    report.CloseTextStream                                              '�o�͐�t�@�C���̃N���[�Y
    
End Sub

