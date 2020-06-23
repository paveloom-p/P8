ECHO/OFF

! Создание копий
COPY/TAB result_J_P J_P
COPY/TAB result_J_A J_A
COPY/TAB result_H_A H_A
COPY/TAB result_H_V H_V

! J (Павел), H (Викентий)
COPY/TT J_P :vis_mag H_V :vis_J
COPY/TT J_P :data H_V :data_J
COPY/TAB H_V J_H_PV
COMP/TAB J_H_PV :J_H = :vis_J - :vis_mag

! J (Павел), H (Александра)
COPY/TT J_P :vis_mag H_A :vis_J
COPY/TT J_P :data H_A :data_J
COPY/TAB H_A J_H_PA
COMP/TAB J_H_PA :J_H = :vis_J - :vis_mag

! J (Александр), H (Викентий)
COPY/TT J_A :vis_mag H_V :vis_J
COPY/TT J_A :data H_V :data_J
COPY/TAB H_V J_H_AV
COMP/TAB J_H_AV :J_H = :vis_J - :vis_mag

! J (Александр), H (Александра)
COPY/TT J_A :vis_mag H_A :vis_J
COPY/TT J_A :data H_A :data_J
COPY/TAB H_A J_H_AA
COMP/TAB J_H_AA :J_H = :vis_J - :vis_mag 
