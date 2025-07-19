# ����Rack�T�[�o�[

## �T�v

Rack�̓��쌴����[���������邽�߂ɁAHTTP�T�[�o�[�ƃ~�h���E�F�A�V�X�e�����ꂩ������������̂ł��B

### �����@�\

- **Rack�d�l���S����**
  - 8�̊��ϐ����� (REQUEST_METHOD, PATH_INFO, QUERY_STRING��)
  - IO�I�u�W�F�N�g�Ή� (rack.input, rack.errors)
  
- **�~�h���E�F�A�V�X�e��**
  - LoggerMiddleware (�A�N�Z�X���O + ���X�|���X���Ԍv��)
  - ShowExceptionsMiddleware (�G���[�n���h�����O)
  - StaticMiddleware (�ÓI�t�@�C���z�M + Content-Type����)
  
- **config.ru�Ή�**
  - use/run���\�b�h����
  - rackup�Ƃ̌݊���

## �T�[�o�[�N�����@

### 1. ����T�[�o�[ (rack_server.rb)

```bash
# �A�v�����ڋN��
ruby rack_server.rb app.rb

# config.ru�o�R
ruby rack_server.rb config.ru
```

### 2. �W��Rack�T�[�o�[ (rackup)

```bash
# config.ru�o�R
rackup config.ru

# �|�[�g�w��
rackup -p 4000 config.ru
```

## ����m�F

```bash
# �T�[�o�[�N����
curl http://localhost:3000/hello
curl http://localhost:3000/style.css
curl http://localhost:3000/input
```

## �t�@�C���\��

```
������ rack_server.rb           # ����HTTP�T�[�o�[
������ app.rb                   # �T���v��Rack�A�v��
������ config.ru                # Rack�ݒ�t�@�C��
������ *Middleware.rb           # �e��~�h���E�F�A
������ public/                  # �ÓI�t�@�C��
    ������ style.css
    ������ test.html
```
