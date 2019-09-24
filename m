Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5586ABC41F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 10:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395022AbfIXIab convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 24 Sep 2019 04:30:31 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40017 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394959AbfIXIab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 04:30:31 -0400
Received: from oxbsltgw05.schlund.de ([172.19.249.22]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mleo0-1hmjNm3RDe-00inlh; Tue, 24 Sep 2019 10:30:28 +0200
Date:   Tue, 24 Sep 2019 10:30:28 +0200 (CEST)
From:   Felix Koop <fdp@fkoop.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Message-ID: <1779871020.276322.1569313828712@email.ionos.de>
In-Reply-To: <1746580228.276165.1569313641249@email.ionos.de>
References: <57e3a3a2c40fe7ea33ff85aec59ffaefdd20f3e6.camel@fkoop.de>
 <1af945c1-0e58-a6e0-477f-59e0900a0e6f@gmx.com>
 <1746580228.276165.1569313641249@email.ionos.de>
Subject: Re: help needed with unmountable btrfs-filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev60
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:1zYdyT1FFw5oB1jute/OlZDSDHh6FybMQnNXrah8+opI6r0Ksjz
 yNLkB2fSx4mvb8W0xKnbaMpIleFRrVfG/MG45RA5RVapk2ivu1srSZkZt6dFv0/CkhZ/SKY
 3qjbTeBIZ61rE3IGkmfRADLAk4BFZOUtGDjaqeMM1VXisivy3xJIu1WzGPvBYqftlvnGoOL
 EzveD+FBiYBThOUv+/KCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rfU3w9jf8fk=:f4iCzVFHqumFqGgo3SksNP
 GR39hmnWck8JOIkG+spxTznEOyRv8On5mZdeI6ecBeWZ5KLad2xQQL1StSJuiaGWM9IVCcO/6
 6enQ5iEcVQui/8recImSwUXjRzJ3MILmPZUPxRF/60eS3gukOfFG1aSttp2a6VhBNgYFwqasM
 Y7XNNx8UERE6OEcqoEc3eFzwBt+aHwgI3ss3EsRMSJss/KdSx80tgvphg2BJ2j7aSTyrH19Ix
 hQM1DBETVUa2CHBqh8PKVgmJ3zHuoknemVtpqvN+4si66flTqeO60tf6KzuQRnh7U1DDHoLOV
 /qG+9CnqL29l3mb5JsvgAA4U9PHwWKbiW474XK2C/E8m7EwcYaUhirZrrNXUDEHkWxitOag82
 ksvJks0dgeKMvgem+VqnDCDZUuXygk0d1VVvtF3hz2hYl0c8HO8OBE8MnGf0bHsQkmyXeQDfi
 QnTsrlvHIV+uRSWq2lmAvYLuoCNreIClZEqQor0Bkx+Axo8RNxhfsBhnm7Uzs5607TjKjWiAK
 ubViA2VMJ5x6p7rpeybk3i8N3JKGqoO3LDtfQwJhC6Y2npU5QkwZ1lCFMnND6plOB78mPMi0B
 8GU9DdVsztIyGSI4eizYPg0lALS4YLCh3njkf3g43xdku0AWkueV3v2bxVmurHqxS6Cn838zd
 TSQE/5H9t+F7z/i8Nqi2WE+22l4prCrGra43gYrWXW42mvT+4Xz91MR6O6Y1Vrmtw6RBVhg6L
 dLxabtk/JvUG/3CCvHx2N0SPVc6oWekqqPKGkutWIff45riGcOStEsRkisaTZVfeq7u1Mm1Su
 6e40MLDxWuuZGYu8sQ7/Lisu1T8vdkRcpiOYFsYu7MvE0Zun7Rs1NZy+iSseq64CCsclYAq/s
 uW69gtwjTNuSYKguAyug==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry, forgot kernel and btrfs versions:

root@tuxedo:~# uname -a
Linux tuxedo.fkoop.de 5.0.0-27-generic #28-Ubuntu SMP Tue Aug 20 19:53:07 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
root@tuxedo:~# btrfs --version
btrfs-progs v4.20.2


Mit freundlichen Grüßen/Kind regards


Felix Koop


> Felix Koop <fdp@fkoop.de> hat am 24. September 2019 um 10:27 geschrieben:
> 
> 
> Hi Qu,
> 
> unfortunately nothing under dmesg.
> 
> ~# btrfs ins dump-super -fFa /dev/md/1
> superblock: bytenr=65536, device=/dev/md/1
> ---------------------------------------------------------
> csum_type               48250 (INVALID)
> csum_size               32
> csum                    0x8e5542eb70bced2a96808253fcb7a73c6085b6e754cbc8e2fb89674e9f738238 [UNKNOWN CSUM TYPE OR SIZE]
> bytenr                  12181234483651309775
> flags                   0xd962ba5e4ef1695a
>                         ( RELOC |
>                           CHANGING_FSID |
>                           METADUMP |
>                           METADUMP_V2 |
>                           unknown flag: 0xd962ba504ef16958 )
> magic                   .#7"f..0 [DON'T MATCH]
> fsid                    a8da0ac7-579b-6d81-88cd-c933b794c785
> metadata_uuid           156aee46-b94c-b9ba-962c-b332ab4667cc
> label                   0...=.a..Z.Y.`..T.l.H.f?....AAkv9.........ZB.M...........2..;!8.g...i..t..l.*.x!....].=......b.Q^D..
> generation              12986127113123940026
> root                    13851558508265222271
> sys_array_size          1161401401
> chunk_root_generation   12667455870201283783
> root_level              5
> chunk_root              11926903618860088829
> chunk_root_level        64
> log_root                1841135978666913598
> log_root_transid        11002435440050228634
> log_root_level          248
> total_bytes             8158923876795838803
> bytes_used              17787222351354347041
> sectorsize              2669808347
> nodesize                4288500188
> leafsize (deprecated)   1806564735
> stripesize              4196907700
> root_dir                16118946364209963189
> num_devices             12936053495324799957
> compat_flags            0x426746ddc014497a
> compat_ro_flags         0x1a387ee25cbe0480
>                         ( unknown flag: 0x1a387ee25cbe0480 )
> incompat_flags          0x6e87d5eadcdc0552
>                         ( DEFAULT_SUBVOL |
>                           COMPRESS_ZSTD |
>                           EXTENDED_IREF |
>                           SKINNY_METADATA |
>                           METADATA_UUID |
>                           unknown flag: 0x6e87d5eadcdc0000 )
> cache_generation        10057603985414728634
> uuid_tree_generation    4068845440595781678
> dev_item.uuid           7b2ddb16-78c6-091d-d77f-37032bb24e6f
> dev_item.fsid           9c1be2b7-3fe4-29db-b0a7-b18caf3d3f5a [DON'T MATCH]
> dev_item.type           6604466414397713944
> dev_item.total_bytes    4621717855420266801
> dev_item.bytes_used     8342047778331657076
> dev_item.io_align       4279037902
> dev_item.io_width       1775887180
> dev_item.sector_size    2259074908
> dev_item.devid          18157633788844884947
> dev_item.dev_group      1667847581
> dev_item.seek_speed     63
> dev_item.bandwidth      207
> dev_item.generation     3594285136264646998
> sys_chunk_array[2048]:
> ERROR: sys_array_size 1161401401 shouldn't exceed 2048 bytes
> backup_roots[4]:
>         backup 0:
>                 backup_tree_root:       6970368790324777925     gen: 12598614702518465874       level: 78
>                 backup_chunk_root:      12185247256182217146    gen: 8294830950963298816        level: 207
>                 backup_extent_root:     1288338481765642561     gen: 9286345172685317925        level: 66
>                 backup_fs_root:         1024698212512227239     gen: 7381800784347480503        level: 173
>                 backup_dev_root:        7291763814382499783     gen: 16237858643413215931       level: 245
>                 backup_csum_root:       6458388087989564616     gen: 8793163284351336981        level: 197
>                 backup_total_bytes:     9073274160022698418
>                 backup_bytes_used:      18251414241723294857
>                 backup_num_devices:     4518080734946755492
> 
>         backup 1:
>                 backup_tree_root:       8259739005406706376     gen: 11190415651942675634       level: 248
>                 backup_chunk_root:      18248383521275344277    gen: 8975374588041967785        level: 77
>                 backup_extent_root:     8904246775283008170     gen: 10396757054042900315       level: 167
>                 backup_fs_root:         5396296792390782509     gen: 4442630659605843819        level: 199
>                 backup_dev_root:        16699734435861110318    gen: 15048997227385557306       level: 150
>                 backup_csum_root:       11341563417203940976    gen: 10565796296655441867       level: 147
>                 backup_total_bytes:     14154396027034184437
>                 backup_bytes_used:      4527608919712333479
>                 backup_num_devices:     16180777334101189082
> 
>         backup 2:
>                 backup_tree_root:       7234681543498250474     gen: 1426436775921748192        level: 22
>                 backup_chunk_root:      18299546316577055742    gen: 8457029571622666206        level: 190
>                 backup_extent_root:     938095847490098596      gen: 3561749671145080517        level: 110
>                 backup_fs_root:         16620609691604273391    gen: 13316231509064955595       level: 116
>                 backup_dev_root:        6546605238984936919     gen: 8637539137105119188        level: 30
>                 backup_csum_root:       4673665454181379707     gen: 2591971300734134658        level: 114
>                 backup_total_bytes:     7209206266924999293
>                 backup_bytes_used:      16310899366805622086
>                 backup_num_devices:     14495759847441176014
> 
>         backup 3:
>                 backup_tree_root:       16070221463289531118    gen: 12053826310892106180       level: 98
>                 backup_chunk_root:      4064898164871351729     gen: 15139400542209185938       level: 79
>                 backup_extent_root:     12602461080827122942    gen: 882859735452525139 level: 187
>                 backup_fs_root:         6147598603993586532     gen: 17537062445806784871       level: 17
>                 backup_dev_root:        17321276347622146300    gen: 3635482114765943339        level: 73
>                 backup_csum_root:       4762360560673113434     gen: 10797920740240765554       level: 167
>                 backup_total_bytes:     14240312077713093305
>                 backup_bytes_used:      10068420544575204023
>                 backup_num_devices:     11928987221309933272
> 
> 
> superblock: bytenr=67108864, device=/dev/md/1
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x636f9da3 [match]
> bytenr                  67108864
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    6bd5c974-2565-4736-815d-fe071f560e68
> metadata_uuid           6bd5c974-2565-4736-815d-fe071f560e68
> label
> generation              168
> root                    340721664
> sys_array_size          129
> chunk_root_generation   156
> root_level              1
> chunk_root              22020096
> chunk_root_level        1
> log_root                0
> log_root_transid        0
> log_root_level          0
> total_bytes             375567417344
> bytes_used              243939692544
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x161
>                         ( MIXED_BACKREF |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           SKINNY_METADATA )
> cache_generation        168
> uuid_tree_generation    168
> dev_item.uuid           d71e03b8-b353-4242-a65a-dc9d60bc46a6
> dev_item.fsid           6bd5c974-2565-4736-815d-fe071f560e68 [match]
> dev_item.type           0
> dev_item.total_bytes    375567417344
> dev_item.bytes_used     248059527168
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> sys_chunk_array[2048]:
>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 2 sub_stripes 0
>                         stripe 0 devid 1 offset 22020096
>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
>                         stripe 1 devid 1 offset 30408704
>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> backup_roots[4]:
>         backup 0:
>                 backup_tree_root:       350814208       gen: 166        level: 1
>                 backup_chunk_root:      22020096        gen: 156        level: 1
>                 backup_extent_root:     340721664       gen: 166        level: 2
>                 backup_fs_root:         338608128       gen: 166        level: 2
>                 backup_dev_root:        354140160       gen: 166        level: 1
>                 backup_csum_root:       353402880       gen: 166        level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
> 
>         backup 1:
>                 backup_tree_root:       57311232        gen: 167        level: 1
>                 backup_chunk_root:      22020096        gen: 156        level: 1
>                 backup_extent_root:     69419008        gen: 167        level: 2
>                 backup_fs_root:         338608128       gen: 166        level: 2
>                 backup_dev_root:        317472768       gen: 167        level: 1
>                 backup_csum_root:       345784320       gen: 167        level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
> 
>         backup 2:
>                 backup_tree_root:       340721664       gen: 168        level: 1
>                 backup_chunk_root:      22020096        gen: 156        level: 1
>                 backup_extent_root:     340738048       gen: 168        level: 2
>                 backup_fs_root:         338608128       gen: 166        level: 2
>                 backup_dev_root:        345358336       gen: 168        level: 1
>                 backup_csum_root:       353320960       gen: 168        level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
> 
>         backup 3:
>                 backup_tree_root:       57311232        gen: 165        level: 1
>                 backup_chunk_root:      22020096        gen: 156        level: 1
>                 backup_extent_root:     69419008        gen: 165        level: 2
>                 backup_fs_root:         352387072       gen: 157        level: 2
>                 backup_dev_root:        317325312       gen: 165        level: 1
>                 backup_csum_root:       343932928       gen: 165        level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
> 
> 
> superblock: bytenr=274877906944, device=/dev/md/1
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x9ee8cb92 [match]
> bytenr                  274877906944
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    6bd5c974-2565-4736-815d-fe071f560e68
> metadata_uuid           6bd5c974-2565-4736-815d-fe071f560e68
> label
> generation              168
> root                    340721664
> sys_array_size          129
> chunk_root_generation   156
> root_level              1
> chunk_root              22020096
> chunk_root_level        1
> log_root                0
> log_root_transid        0
> log_root_level          0
> total_bytes             375567417344
> bytes_used              243939692544
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x161
>                         ( MIXED_BACKREF |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           SKINNY_METADATA )
> cache_generation        168
> uuid_tree_generation    168
> dev_item.uuid           d71e03b8-b353-4242-a65a-dc9d60bc46a6
> dev_item.fsid           6bd5c974-2565-4736-815d-fe071f560e68 [match]
> dev_item.type           0
> dev_item.total_bytes    375567417344
> dev_item.bytes_used     248059527168
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> sys_chunk_array[2048]:
>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 2 sub_stripes 0
>                         stripe 0 devid 1 offset 22020096
>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
>                         stripe 1 devid 1 offset 30408704
>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> backup_roots[4]:
>         backup 0:
>                 backup_tree_root:       350814208       gen: 166        level: 1
>                 backup_chunk_root:      22020096        gen: 156        level: 1
>                 backup_extent_root:     340721664       gen: 166        level: 2
>                 backup_fs_root:         338608128       gen: 166        level: 2
>                 backup_dev_root:        354140160       gen: 166        level: 1
>                 backup_csum_root:       353402880       gen: 166        level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
> 
>         backup 1:
>                 backup_tree_root:       57311232        gen: 167        level: 1
>                 backup_chunk_root:      22020096        gen: 156        level: 1
>                 backup_extent_root:     69419008        gen: 167        level: 2
>                 backup_fs_root:         338608128       gen: 166        level: 2
>                 backup_dev_root:        317472768       gen: 167        level: 1
>                 backup_csum_root:       345784320       gen: 167        level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
> 
>         backup 2:
>                 backup_tree_root:       340721664       gen: 168        level: 1
>                 backup_chunk_root:      22020096        gen: 156        level: 1
>                 backup_extent_root:     340738048       gen: 168        level: 2
>                 backup_fs_root:         338608128       gen: 166        level: 2
>                 backup_dev_root:        345358336       gen: 168        level: 1
>                 backup_csum_root:       353320960       gen: 168        level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
> 
>         backup 3:
>                 backup_tree_root:       57311232        gen: 165        level: 1
>                 backup_chunk_root:      22020096        gen: 156        level: 1
>                 backup_extent_root:     69419008        gen: 165        level: 2
>                 backup_fs_root:         352387072       gen: 157        level: 2
>                 backup_dev_root:        317325312       gen: 165        level: 1
>                 backup_csum_root:       343932928       gen: 165        level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
> 
> 
> 
> 
> 
> Mit freundlichen Grüßen/Kind regards
> 
> 
> Felix Koop
> 
> 
> > Qu Wenruo <quwenruo.btrfs@gmx.com> hat am 22. September 2019 um 11:50 geschrieben:
> > 
> > 
> > 
> > 
> > On 2019/9/22 下午2:34, Felix Koop wrote:
> > > Hello,
> > > 
> > > I need help accessing a btrfs-filesystem. When I try to mount the fs, I
> > > get the following error:
> > > 
> > > # mount -t btrfs /dev/md/1 /mnt
> > > mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md1,
> > > missing codepage or helper program, or other error.
> > 
> > dmesg please.
> > 
> > > 
> > > When I then try to check the fs, this is what I get:
> > > 
> > > # btrfs check /dev/md/1
> > > Opening filesystem to check...
> > > No valid Btrfs found on /dev/md/1
> > > ERROR: cannot open file system
> > 
> > As it said, it can't find the primary superblock.
> > 
> > Please provide the following output.
> > 
> > # btrfs ins dump-super -fFa /dev/md/1
> > 
> > And kernel and btrfs-progs version please.
> > 
> > Thanks,
> > Qu
> > > 
> > > Can anybody help me how to recover my data?
> > > 
> > > 
> >
