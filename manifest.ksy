meta:
  id: mltd_manifest
seq:
  - id: header
    contents: [0x91]
  - id: file
    type: file
    repeat: until
    repeat-until: "_io.pos + 5 > _io.size"
    
types:
  file:
    seq:
      - id: file_test
        type: filetest
      - id: file_name
        type: filename
      - id: file_hash_sum
        type: filehash
      - id: file_hash_url
        type: fileurl
    instances:
      name:
        value: file_name.value
      hash_sum:
        value: file_hash_sum.value
      hash_url:
        value: file_hash_url.value


  filetest:
    seq:
      - id: file_test
        type: u1
      - id: file_test_unknown
        type: u1

  filename:
    seq:
      - id: unknown1
        type: u1
      - id: size
        type: u1
      - id: nsize
        if: size == 0xd9
        type: u1
      - id: name
        type: str
        terminator: 0x93
        encoding: ASCII
    instances:
      value:
        value: name
        
  filehash:
    seq:
      - id: unknown
        type: u1
      - id: size
        type: u1
      - id: hash
        type: str
        size: size
        encoding: ASCII
    instances:
      value:
        value: hash
  
  fileurl:
    seq:
      - id: unknown1
        type: u1
      - id: size
        type: u1
      - id: url
        type: str
        size: size
        encoding: ASCII
      - id: unknown2
        type: u1
    instances:
      value:
        value: url