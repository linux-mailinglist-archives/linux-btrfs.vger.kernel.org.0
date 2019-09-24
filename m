Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0613ABC48B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 11:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504130AbfIXJMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 05:12:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:48207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbfIXJMA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 05:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569316315;
        bh=MxW/H9zrpBMfBnEQF0hnBVC6SeAaVrjwaUjN9SENBfo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Y0syMmdJDF0ukmuI0bxNqIMJ2fMmr5yvS0IpjkvubZd7O7qCkJhp0fXjHKiC3t4+c
         V/8hZw5ZqJhLYdypm+2hkyXORMVZ6fyBMMz1A5VDAg0taYx6YSm+4s8enV3yPHFGxs
         ozwwGLyKcIVCRaEfKeL3ADshba4dVp/pX/76+31k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8ofE-1i9kTP1aEA-015pxZ; Tue, 24
 Sep 2019 11:11:54 +0200
Subject: Re: help needed with unmountable btrfs-filesystem
To:     Felix Koop <fdp@fkoop.de>, linux-btrfs@vger.kernel.org
References: <57e3a3a2c40fe7ea33ff85aec59ffaefdd20f3e6.camel@fkoop.de>
 <1af945c1-0e58-a6e0-477f-59e0900a0e6f@gmx.com>
 <1746580228.276165.1569313641249@email.ionos.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <7ab6805a-f372-d5e2-04c9-51dc7cf51fbc@gmx.com>
Date:   Tue, 24 Sep 2019 17:11:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1746580228.276165.1569313641249@email.ionos.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X9lVb5Qsz3GTKeUWkdp3KyNGBkp142Zkx"
X-Provags-ID: V03:K1:20cpVaGE0FK9IY0PD4OwSWZk73i1I9EZ37iMOYuiuK7ILWHG8Wr
 hZ1HVMSSJpmyhCCPj7Dwvi6ihh4Rq7Ao0t74SH27YdwoXTyL33bhaQ+WZOyiO68ubDkbFEm
 ad3c0juQOenMgz2jE2dQfgU3On01+0gxSO/JcdtXp3890F9ussNUyTmIGK6BdSfiNkffR/L
 8nDS/JlLAWZ6Wx9/0rzBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gNavdl5Scw8=:7i79wfNNUf4byFgOr0xlZa
 THDqscR8e53E1YqrzptItui1zADW86Fd6t/jnTahIzFhntr8MSgnKphIeq1eEkT8p9ICdJiBk
 kYeatsB4NuhOvbVFxTJax6n3hvqFJqHrdJCtSH4SbgqueCk50tlYASCZhpgLFoI7wFIjUThdv
 1tozNNcxFXCwne2sX6XFh2zATnt70TUv99w0EhfX6CU1hFTVf/UQe4kN1hqPYnIiIF4o35ovn
 EZuuU0VD8BoFVvkQpzD2tJumkrKPj1PIJxk4SkkTrEzmdcf7rMzscBEUz0l2IDP5AcQVh4Nkc
 cQHOucL/q+nhN+Sz6wWoDrwUUL4Suc5KP2FprDxbZ/arBDSv/W11RReTAMVZgJOyIWPr2uN+o
 Y5kc2TfKrIPnx7/tXhYKVZr+WU3M9J0bUqoshILZeDhr6w1lENmzLazwzgaro05jyTOX97OiF
 v2l97TxymqIHkjil3vYaYioEcBfcfkqJMJzKP2TnpqIH+mtT2AKRGDnHF+7Q7+N+8QO58QQLw
 Jn1MCa4RQPePxPBB3UV6IRb2WEXWS8qwh/viAROXPzUtEqOowlDhvdu8PPl9BK0eRXh5orlw4
 eDKgkofX+n21+uWpkO5EMJEO6m53XfHsFCf5lcGKAyFSBV93mrsU7zWmhoyVVU5dO+jxppMm2
 EpuqK5Mj9TRvdV2aDuiM+NEvx1vU/Tbs9ZY/qFdajA1tK69/LkC9GwkPM8jhJp8AoHizR/Hy/
 TfF3FCdWX28UIu+VV2EGL4y6SS05B8JeLcl9ODaEcqFW57gGt8ytID23cY+PXVB2H/ws8vWsC
 YZuyU4LLS3a6NikdCCi6GyNalcEOhsx1K4PRxXu78mfFBYKS+H17TiX0clidm8Am/up1f/Fn8
 kn4WfnbrQXgS3fTpi1K6wS8XgccjsOqAJEdkhz3F39ClK5pbNQPYrm2WXRzd+FlDzRcCWeRFF
 ZLQF7xzOi1sVoa8obUIabImWBKQwnin/f/6TjmXBNhNldGUk6YiedfHa3crIP5+wm98wVDlYU
 OVlE03Uwz8G4dkFp5HA4gDtp9sC9MYU9VINhZF842PqfXGjW0g48AU6C5Sg6B62DkL5j33x5U
 EQcdXwWIyvV6LqH7IKvc1AZRkUhPnt5k1/rQwsU+/lzA2xMguU9x0Dcs41A+BoW2bzSYbdHH+
 e5wHIshK5/LlDSX6hFR6QS4EzMlZcB0P3hlGK8TPAq+QiA1Bu8wRg3iVR2A5x6Nig6UXPv3re
 gATgLDUZYdv0aUc/c/tSCecVX+yrehKf+Vt7hsXWYE8kudxVcym3+yETF+Sg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X9lVb5Qsz3GTKeUWkdp3KyNGBkp142Zkx
Content-Type: multipart/mixed; boundary="7dafd6MvbAJNVt4V5tgwdV7Zr6BBPXvyV"

--7dafd6MvbAJNVt4V5tgwdV7Zr6BBPXvyV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/24 =E4=B8=8B=E5=8D=884:27, Felix Koop wrote:
> Hi Qu,
>=20
> unfortunately nothing under dmesg.
>=20
> ~# btrfs ins dump-super -fFa /dev/md/1
> superblock: bytenr=3D65536, device=3D/dev/md/1
> ---------------------------------------------------------
> csum_type               48250 (INVALID)
> csum_size               32
> csum                    0x8e5542eb70bced2a96808253fcb7a73c6085b6e754cbc=
8e2fb89674e9f738238 [UNKNOWN CSUM TYPE OR SIZE]

So the first super block is completely garbage, no wonder neither kernel
nor the btrfs-progs detects the fs.

[...]
>=20
>=20
> superblock: bytenr=3D67108864, device=3D/dev/md/1
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x636f9da3 [match]
> bytenr                  67108864
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]

Still have a good backup.

I'm not sure what makes the first super block completely garbage. It can
be bad trim or whatever something wrong.

But anyway, you can try to fix it by "btrfs rescue super-recover
/dev/md/1" to at least recover the superblock so that kernel and
btrfs-progs can recognize the system.

Then you may like to run a "btrfs check --readonly /dev/md/1" to make
sure nothing else is corrupted.

Thanks,
Qu

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
>                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP=

>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 2 sub_stripes 0
>                         stripe 0 devid 1 offset 22020096
>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
>                         stripe 1 devid 1 offset 30408704
>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> backup_roots[4]:
>         backup 0:
>                 backup_tree_root:       350814208       gen: 166       =
 level: 1
>                 backup_chunk_root:      22020096        gen: 156       =
 level: 1
>                 backup_extent_root:     340721664       gen: 166       =
 level: 2
>                 backup_fs_root:         338608128       gen: 166       =
 level: 2
>                 backup_dev_root:        354140160       gen: 166       =
 level: 1
>                 backup_csum_root:       353402880       gen: 166       =
 level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
>=20
>         backup 1:
>                 backup_tree_root:       57311232        gen: 167       =
 level: 1
>                 backup_chunk_root:      22020096        gen: 156       =
 level: 1
>                 backup_extent_root:     69419008        gen: 167       =
 level: 2
>                 backup_fs_root:         338608128       gen: 166       =
 level: 2
>                 backup_dev_root:        317472768       gen: 167       =
 level: 1
>                 backup_csum_root:       345784320       gen: 167       =
 level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
>=20
>         backup 2:
>                 backup_tree_root:       340721664       gen: 168       =
 level: 1
>                 backup_chunk_root:      22020096        gen: 156       =
 level: 1
>                 backup_extent_root:     340738048       gen: 168       =
 level: 2
>                 backup_fs_root:         338608128       gen: 166       =
 level: 2
>                 backup_dev_root:        345358336       gen: 168       =
 level: 1
>                 backup_csum_root:       353320960       gen: 168       =
 level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
>=20
>         backup 3:
>                 backup_tree_root:       57311232        gen: 165       =
 level: 1
>                 backup_chunk_root:      22020096        gen: 156       =
 level: 1
>                 backup_extent_root:     69419008        gen: 165       =
 level: 2
>                 backup_fs_root:         352387072       gen: 157       =
 level: 2
>                 backup_dev_root:        317325312       gen: 165       =
 level: 1
>                 backup_csum_root:       343932928       gen: 165       =
 level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
>=20
>=20
> superblock: bytenr=3D274877906944, device=3D/dev/md/1
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
>                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP=

>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 2 sub_stripes 0
>                         stripe 0 devid 1 offset 22020096
>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
>                         stripe 1 devid 1 offset 30408704
>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6
> backup_roots[4]:
>         backup 0:
>                 backup_tree_root:       350814208       gen: 166       =
 level: 1
>                 backup_chunk_root:      22020096        gen: 156       =
 level: 1
>                 backup_extent_root:     340721664       gen: 166       =
 level: 2
>                 backup_fs_root:         338608128       gen: 166       =
 level: 2
>                 backup_dev_root:        354140160       gen: 166       =
 level: 1
>                 backup_csum_root:       353402880       gen: 166       =
 level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
>=20
>         backup 1:
>                 backup_tree_root:       57311232        gen: 167       =
 level: 1
>                 backup_chunk_root:      22020096        gen: 156       =
 level: 1
>                 backup_extent_root:     69419008        gen: 167       =
 level: 2
>                 backup_fs_root:         338608128       gen: 166       =
 level: 2
>                 backup_dev_root:        317472768       gen: 167       =
 level: 1
>                 backup_csum_root:       345784320       gen: 167       =
 level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
>=20
>         backup 2:
>                 backup_tree_root:       340721664       gen: 168       =
 level: 1
>                 backup_chunk_root:      22020096        gen: 156       =
 level: 1
>                 backup_extent_root:     340738048       gen: 168       =
 level: 2
>                 backup_fs_root:         338608128       gen: 166       =
 level: 2
>                 backup_dev_root:        345358336       gen: 168       =
 level: 1
>                 backup_csum_root:       353320960       gen: 168       =
 level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
>=20
>         backup 3:
>                 backup_tree_root:       57311232        gen: 165       =
 level: 1
>                 backup_chunk_root:      22020096        gen: 156       =
 level: 1
>                 backup_extent_root:     69419008        gen: 165       =
 level: 2
>                 backup_fs_root:         352387072       gen: 157       =
 level: 2
>                 backup_dev_root:        317325312       gen: 165       =
 level: 1
>                 backup_csum_root:       343932928       gen: 165       =
 level: 2
>                 backup_total_bytes:     375567417344
>                 backup_bytes_used:      243939692544
>                 backup_num_devices:     1
>=20
>=20
>=20
>=20
>=20
> Mit freundlichen Gr=C3=BC=C3=9Fen/Kind regards
>=20
>=20
> Felix Koop
>=20
>=20
>> Qu Wenruo <quwenruo.btrfs@gmx.com> hat am 22. September 2019 um 11:50 =
geschrieben:
>>
>>
>>
>>
>> On 2019/9/22 =E4=B8=8B=E5=8D=882:34, Felix Koop wrote:
>>> Hello,
>>>
>>> I need help accessing a btrfs-filesystem. When I try to mount the fs,=
 I
>>> get the following error:
>>>
>>> # mount -t btrfs /dev/md/1 /mnt
>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md1,
>>> missing codepage or helper program, or other error.
>>
>> dmesg please.
>>
>>>
>>> When I then try to check the fs, this is what I get:
>>>
>>> # btrfs check /dev/md/1
>>> Opening filesystem to check...
>>> No valid Btrfs found on /dev/md/1
>>> ERROR: cannot open file system
>>
>> As it said, it can't find the primary superblock.
>>
>> Please provide the following output.
>>
>> # btrfs ins dump-super -fFa /dev/md/1
>>
>> And kernel and btrfs-progs version please.
>>
>> Thanks,
>> Qu
>>>
>>> Can anybody help me how to recover my data?
>>>
>>>
>>


--7dafd6MvbAJNVt4V5tgwdV7Zr6BBPXvyV--

--X9lVb5Qsz3GTKeUWkdp3KyNGBkp142Zkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2J3dYACgkQwj2R86El
/qh26gf/ZCnp5eJx2mOTD13DNDegFn4gnzze2t7MiGNzA6AUg8AYyL/Hfu7yx3+r
Gc+FYYsCUgZ6Kyi9bOvnVA3ymP5D3WxuNtswMgBdsHtMcpP43wfacwyjwZq7DL2X
zwp/susBmUiqeIJfb+/fccni/8g1AuCwL7yXmgrxLeozwWRVOLtoKOlxnkR66+Aq
7tZAdgbyUUFO6YhZQcqPpSkXeeK2NIEVphcs84xhgZouOVGbGZgGmPDDLkVGF4pb
hcH6nniB1POTJjWr1Fnfyl0U02uiQyARyDmYo9RHd69azWf3cNOfVWpIoqfjeD4M
Tps1mcFZeukVNRSkZMhXe5CaCtguhQ==
=ccHT
-----END PGP SIGNATURE-----

--X9lVb5Qsz3GTKeUWkdp3KyNGBkp142Zkx--
