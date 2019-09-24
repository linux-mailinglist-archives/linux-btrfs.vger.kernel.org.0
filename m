Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85C4BC4C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 11:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504181AbfIXJXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 05:23:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:49721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfIXJXy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 05:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569317031;
        bh=NhDZtgBwtjUJzSif6iUQyEm8yln4wghl2LBGkcImPWY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TRFQ1LGrDkvTh7D/VxewlS2/l3Gg3J1QpOymrnpVNgqdB8RL0oGmgyG4LGVOPgMCq
         X0X95tvDhvCJLv22rEmdUyRrlm+sJojYAZuZL8v1QSjgsGKbhh8uPFx+iW33+HfT1X
         /HJPSGzqRn5maubCvDUZu9kCrQVMF/7lKITQr+Eo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1hyUor1nTT-00zXhm; Tue, 24
 Sep 2019 11:23:51 +0200
Subject: Re: help needed with unmountable btrfs-filesystem
To:     Felix Koop <fdp@fkoop.de>, linux-btrfs@vger.kernel.org
References: <57e3a3a2c40fe7ea33ff85aec59ffaefdd20f3e6.camel@fkoop.de>
 <1af945c1-0e58-a6e0-477f-59e0900a0e6f@gmx.com>
 <1746580228.276165.1569313641249@email.ionos.de>
 <7ab6805a-f372-d5e2-04c9-51dc7cf51fbc@gmx.com>
 <1393339585.178213.1569316691139@email.ionos.de>
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
Message-ID: <eac5b055-3ec5-47e2-bf6e-d317595240ce@gmx.com>
Date:   Tue, 24 Sep 2019 17:23:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1393339585.178213.1569316691139@email.ionos.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V6Mc3rjUwsZpCBpUr0rWI5c6DemYIHssL"
X-Provags-ID: V03:K1:rY5h4ZeJKjd6D86/psSOtYPbUbHDgOOMHW+hpOQHI4tH+kfnvXk
 xF73B4iAlY+L5McvGoJGlizSfSvd92oh+/Y9CBySyTNR0NfoPmBiQYlhTeX5hRdA+NVmp95
 +ULTmI23beIIUxFxgtb4mCivvYbcObKw/zIpSY4B8UA5OTXI353gEVqTaGaFmTYCv0Jtba+
 FpC+bSZ/lyzvIiti2y8pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:189tIossYuA=:dMZuJXmfZea8RxvvFyD5m/
 UmWEdmY9yyZOLJXh9ZgIzmoktzJhLvRpQQftMSXn+e20tjfbymHVFTxKekoohcvGr2VbGipG9
 dKEDoBZxy8lWCco/CuH8pPSsDXzUwjgoXgQmEzkTxWaznZS8G39YOVuXZgCnlHUl/r4DXlHmd
 nQMJ1Ex7Loz/13eR96O0dsQDYfCT+sp8/xqFV0WW9TNoI61JfzikOeZeNQznxoeU6vlNhTajg
 lfj/nvlg2cIE90CkqpLKaGwpzfDlbeCHqFIAJf08FCCE4oziqFZE01OVzd1kllV9FhAzxO/BL
 wrOJEZxz0to8KriS9UX98dfP/iw0WRWjwwEia+KHEXEe95yrce8Osg/p5RnEkKyvcyHNW2IHQ
 LcI8N1zIPI2DouuE6fhEKZOxy0jF0mU8R49qHzaaMLo7rSj5i89jmpBZw+MOy6L/4/aVrQkjj
 DFi9AMMDaCCmTTMpOUwmLCXY57Pz4PtcdSSvt9Jty/UQcOZ86Dp6mViJvxiOMZ/5+WbrEwTTG
 yL/faUkzha435imZnwJzoccQN5TW+Kzbh3siEu9zlYcbbpo4F7nUf4ckqYrQtbftr/WvBeJnY
 hnNPOVJS3YO0v/hjSu5/zGF0cdGYZBliGPGy1DFpmwqyVSqrG29VgaNhPgoErCk1tVQa7+KCU
 YPakV12tKXc8I85cw7v7YLY00nPM474YWo9bAWLiW2HpDQ8XOMqKDMsPRTQypnkWR8s/c9onc
 /hIKqJ1bGcf1XmM41pdgIEEgHexxVL6UreK8xnOdbx/S9dMZJ/77yQIHjpylNebWmS7fPVHup
 UgfA7x8XCRTSVsmXdCmBAr7MItHKIGUu/CTQQJfPvrMthOSqvu7LK2/eMaJNWih4HgdEhSOcv
 3asrsoY7fhlZNhHcU2IkITWFiacCZ9kCup6HRR5Y8HhLbyOsfZyep8TQsHlC7SgRsug5x25VU
 BXh1C5050uHDNU4wGnifkEM2tVZxmB8JkIKJXzKs9NRgtgiB2wvf6ggtcKVZWYQOxZtR5MSkE
 Fz4h8r63cM22dSbU+R9R52HkMMqocI1RTnWTlBPnvb3u2L8gcJN2s7Az7ewb5umV9nUpobAyc
 2YSvAMGOw5MyVRixp5GeuZgPzdRt3RtGEzLriTXCtIMwEObSshqRxqrZYa/FAUOdg6k22K90S
 ZZtnaBf+py9UpApaakwp6AzsJAfMGZXavk3clOTdGzOkMphTFW1zeyeXNWL+j90z0UmyTcuer
 uK7eeOpwMv1v+Wv8zLFDMA9wb8dIgFbSN4redB4WcXKNyf7+Am0OCMlf1QVg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V6Mc3rjUwsZpCBpUr0rWI5c6DemYIHssL
Content-Type: multipart/mixed; boundary="WfHgCp36q0rFx9r1kO6cw7okPMkIuEbwq"

--WfHgCp36q0rFx9r1kO6cw7okPMkIuEbwq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/24 =E4=B8=8B=E5=8D=885:18, Felix Koop wrote:
> Hi Qu,
>=20
> this is what I got:
>=20
> root@tuxedo:~# btrfs rescue super-recover /dev/md/1
> Make sure this is a btrfs disk otherwise the tool will destroy other fs=
, Are you sure? [y/N]: y
> checksum verify failed on 340721664 found EACFB938 wanted 24037BC4
> checksum verify failed on 340721664 found EACFB938 wanted 24037BC4
> checksum verify failed on 340721664 found CBE54D32 wanted 6010C3E7
> checksum verify failed on 340721664 found EACFB938 wanted 24037BC4
> bad tree block 340721664, bytenr mismatch, want=3D340721664, have=3D149=
69249826309169724

This means your root tree is also corrupted.

Any idea how is the fs corrupted?


It should be very rare to corrupt the first superblock already.
Then more csum corruption is even more rare.

It looks like the underlying device or encryption or whatever is corrupte=
d.

If a fs is corrupted to this extent, it's pretty hard to do any more.

Thanks,
Qu

> Couldn't read tree root
> Failed to recover bad superblocks
> root@tuxedo:~# btrfs check --readonly /dev/md/1
> Opening filesystem to check...
> No valid Btrfs found on /dev/md/1
> ERROR: cannot open file system
>=20
> Additional tips?
>=20
>=20
> Mit freundlichen Gr=C3=BC=C3=9Fen/Kind regards
>=20
>=20
> Felix Koop
>=20
>=20
>> Qu Wenruo <quwenruo.btrfs@gmx.com> hat am 24. September 2019 um 11:11 =
geschrieben:
>>
>>
>>
>>
>> On 2019/9/24 =E4=B8=8B=E5=8D=884:27, Felix Koop wrote:
>>> Hi Qu,
>>>
>>> unfortunately nothing under dmesg.
>>>
>>> ~# btrfs ins dump-super -fFa /dev/md/1
>>> superblock: bytenr=3D65536, device=3D/dev/md/1
>>> ---------------------------------------------------------
>>> csum_type               48250 (INVALID)
>>> csum_size               32
>>> csum                    0x8e5542eb70bced2a96808253fcb7a73c6085b6e754c=
bc8e2fb89674e9f738238 [UNKNOWN CSUM TYPE OR SIZE]
>>
>> So the first super block is completely garbage, no wonder neither kern=
el
>> nor the btrfs-progs detects the fs.
>>
>> [...]
>>>
>>>
>>> superblock: bytenr=3D67108864, device=3D/dev/md/1
>>> ---------------------------------------------------------
>>> csum_type               0 (crc32c)
>>> csum_size               4
>>> csum                    0x636f9da3 [match]
>>> bytenr                  67108864
>>> flags                   0x1
>>>                         ( WRITTEN )
>>> magic                   _BHRfS_M [match]
>>
>> Still have a good backup.
>>
>> I'm not sure what makes the first super block completely garbage. It c=
an
>> be bad trim or whatever something wrong.
>>
>> But anyway, you can try to fix it by "btrfs rescue super-recover
>> /dev/md/1" to at least recover the superblock so that kernel and
>> btrfs-progs can recognize the system.
>>
>> Then you may like to run a "btrfs check --readonly /dev/md/1" to make
>> sure nothing else is corrupted.
>>
>> Thanks,
>> Qu
>>
>>> fsid                    6bd5c974-2565-4736-815d-fe071f560e68
>>> metadata_uuid           6bd5c974-2565-4736-815d-fe071f560e68
>>> label
>>> generation              168
>>> root                    340721664
>>> sys_array_size          129
>>> chunk_root_generation   156
>>> root_level              1
>>> chunk_root              22020096
>>> chunk_root_level        1
>>> log_root                0
>>> log_root_transid        0
>>> log_root_level          0
>>> total_bytes             375567417344
>>> bytes_used              243939692544
>>> sectorsize              4096
>>> nodesize                16384
>>> leafsize (deprecated)   16384
>>> stripesize              4096
>>> root_dir                6
>>> num_devices             1
>>> compat_flags            0x0
>>> compat_ro_flags         0x0
>>> incompat_flags          0x161
>>>                         ( MIXED_BACKREF |
>>>                           BIG_METADATA |
>>>                           EXTENDED_IREF |
>>>                           SKINNY_METADATA )
>>> cache_generation        168
>>> uuid_tree_generation    168
>>> dev_item.uuid           d71e03b8-b353-4242-a65a-dc9d60bc46a6
>>> dev_item.fsid           6bd5c974-2565-4736-815d-fe071f560e68 [match]
>>> dev_item.type           0
>>> dev_item.total_bytes    375567417344
>>> dev_item.bytes_used     248059527168
>>> dev_item.io_align       4096
>>> dev_item.io_width       4096
>>> dev_item.sector_size    4096
>>> dev_item.devid          1
>>> dev_item.dev_group      0
>>> dev_item.seek_speed     0
>>> dev_item.bandwidth      0
>>> dev_item.generation     0
>>> sys_chunk_array[2048]:
>>>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>>>                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|D=
UP
>>>                 io_align 65536 io_width 65536 sector_size 4096
>>>                 num_stripes 2 sub_stripes 0
>>>                         stripe 0 devid 1 offset 22020096
>>>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6=

>>>                         stripe 1 devid 1 offset 30408704
>>>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6=

>>> backup_roots[4]:
>>>         backup 0:
>>>                 backup_tree_root:       350814208       gen: 166     =
   level: 1
>>>                 backup_chunk_root:      22020096        gen: 156     =
   level: 1
>>>                 backup_extent_root:     340721664       gen: 166     =
   level: 2
>>>                 backup_fs_root:         338608128       gen: 166     =
   level: 2
>>>                 backup_dev_root:        354140160       gen: 166     =
   level: 1
>>>                 backup_csum_root:       353402880       gen: 166     =
   level: 2
>>>                 backup_total_bytes:     375567417344
>>>                 backup_bytes_used:      243939692544
>>>                 backup_num_devices:     1
>>>
>>>         backup 1:
>>>                 backup_tree_root:       57311232        gen: 167     =
   level: 1
>>>                 backup_chunk_root:      22020096        gen: 156     =
   level: 1
>>>                 backup_extent_root:     69419008        gen: 167     =
   level: 2
>>>                 backup_fs_root:         338608128       gen: 166     =
   level: 2
>>>                 backup_dev_root:        317472768       gen: 167     =
   level: 1
>>>                 backup_csum_root:       345784320       gen: 167     =
   level: 2
>>>                 backup_total_bytes:     375567417344
>>>                 backup_bytes_used:      243939692544
>>>                 backup_num_devices:     1
>>>
>>>         backup 2:
>>>                 backup_tree_root:       340721664       gen: 168     =
   level: 1
>>>                 backup_chunk_root:      22020096        gen: 156     =
   level: 1
>>>                 backup_extent_root:     340738048       gen: 168     =
   level: 2
>>>                 backup_fs_root:         338608128       gen: 166     =
   level: 2
>>>                 backup_dev_root:        345358336       gen: 168     =
   level: 1
>>>                 backup_csum_root:       353320960       gen: 168     =
   level: 2
>>>                 backup_total_bytes:     375567417344
>>>                 backup_bytes_used:      243939692544
>>>                 backup_num_devices:     1
>>>
>>>         backup 3:
>>>                 backup_tree_root:       57311232        gen: 165     =
   level: 1
>>>                 backup_chunk_root:      22020096        gen: 156     =
   level: 1
>>>                 backup_extent_root:     69419008        gen: 165     =
   level: 2
>>>                 backup_fs_root:         352387072       gen: 157     =
   level: 2
>>>                 backup_dev_root:        317325312       gen: 165     =
   level: 1
>>>                 backup_csum_root:       343932928       gen: 165     =
   level: 2
>>>                 backup_total_bytes:     375567417344
>>>                 backup_bytes_used:      243939692544
>>>                 backup_num_devices:     1
>>>
>>>
>>> superblock: bytenr=3D274877906944, device=3D/dev/md/1
>>> ---------------------------------------------------------
>>> csum_type               0 (crc32c)
>>> csum_size               4
>>> csum                    0x9ee8cb92 [match]
>>> bytenr                  274877906944
>>> flags                   0x1
>>>                         ( WRITTEN )
>>> magic                   _BHRfS_M [match]
>>> fsid                    6bd5c974-2565-4736-815d-fe071f560e68
>>> metadata_uuid           6bd5c974-2565-4736-815d-fe071f560e68
>>> label
>>> generation              168
>>> root                    340721664
>>> sys_array_size          129
>>> chunk_root_generation   156
>>> root_level              1
>>> chunk_root              22020096
>>> chunk_root_level        1
>>> log_root                0
>>> log_root_transid        0
>>> log_root_level          0
>>> total_bytes             375567417344
>>> bytes_used              243939692544
>>> sectorsize              4096
>>> nodesize                16384
>>> leafsize (deprecated)   16384
>>> stripesize              4096
>>> root_dir                6
>>> num_devices             1
>>> compat_flags            0x0
>>> compat_ro_flags         0x0
>>> incompat_flags          0x161
>>>                         ( MIXED_BACKREF |
>>>                           BIG_METADATA |
>>>                           EXTENDED_IREF |
>>>                           SKINNY_METADATA )
>>> cache_generation        168
>>> uuid_tree_generation    168
>>> dev_item.uuid           d71e03b8-b353-4242-a65a-dc9d60bc46a6
>>> dev_item.fsid           6bd5c974-2565-4736-815d-fe071f560e68 [match]
>>> dev_item.type           0
>>> dev_item.total_bytes    375567417344
>>> dev_item.bytes_used     248059527168
>>> dev_item.io_align       4096
>>> dev_item.io_width       4096
>>> dev_item.sector_size    4096
>>> dev_item.devid          1
>>> dev_item.dev_group      0
>>> dev_item.seek_speed     0
>>> dev_item.bandwidth      0
>>> dev_item.generation     0
>>> sys_chunk_array[2048]:
>>>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>>>                 length 8388608 owner 2 stripe_len 65536 type SYSTEM|D=
UP
>>>                 io_align 65536 io_width 65536 sector_size 4096
>>>                 num_stripes 2 sub_stripes 0
>>>                         stripe 0 devid 1 offset 22020096
>>>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6=

>>>                         stripe 1 devid 1 offset 30408704
>>>                         dev_uuid d71e03b8-b353-4242-a65a-dc9d60bc46a6=

>>> backup_roots[4]:
>>>         backup 0:
>>>                 backup_tree_root:       350814208       gen: 166     =
   level: 1
>>>                 backup_chunk_root:      22020096        gen: 156     =
   level: 1
>>>                 backup_extent_root:     340721664       gen: 166     =
   level: 2
>>>                 backup_fs_root:         338608128       gen: 166     =
   level: 2
>>>                 backup_dev_root:        354140160       gen: 166     =
   level: 1
>>>                 backup_csum_root:       353402880       gen: 166     =
   level: 2
>>>                 backup_total_bytes:     375567417344
>>>                 backup_bytes_used:      243939692544
>>>                 backup_num_devices:     1
>>>
>>>         backup 1:
>>>                 backup_tree_root:       57311232        gen: 167     =
   level: 1
>>>                 backup_chunk_root:      22020096        gen: 156     =
   level: 1
>>>                 backup_extent_root:     69419008        gen: 167     =
   level: 2
>>>                 backup_fs_root:         338608128       gen: 166     =
   level: 2
>>>                 backup_dev_root:        317472768       gen: 167     =
   level: 1
>>>                 backup_csum_root:       345784320       gen: 167     =
   level: 2
>>>                 backup_total_bytes:     375567417344
>>>                 backup_bytes_used:      243939692544
>>>                 backup_num_devices:     1
>>>
>>>         backup 2:
>>>                 backup_tree_root:       340721664       gen: 168     =
   level: 1
>>>                 backup_chunk_root:      22020096        gen: 156     =
   level: 1
>>>                 backup_extent_root:     340738048       gen: 168     =
   level: 2
>>>                 backup_fs_root:         338608128       gen: 166     =
   level: 2
>>>                 backup_dev_root:        345358336       gen: 168     =
   level: 1
>>>                 backup_csum_root:       353320960       gen: 168     =
   level: 2
>>>                 backup_total_bytes:     375567417344
>>>                 backup_bytes_used:      243939692544
>>>                 backup_num_devices:     1
>>>
>>>         backup 3:
>>>                 backup_tree_root:       57311232        gen: 165     =
   level: 1
>>>                 backup_chunk_root:      22020096        gen: 156     =
   level: 1
>>>                 backup_extent_root:     69419008        gen: 165     =
   level: 2
>>>                 backup_fs_root:         352387072       gen: 157     =
   level: 2
>>>                 backup_dev_root:        317325312       gen: 165     =
   level: 1
>>>                 backup_csum_root:       343932928       gen: 165     =
   level: 2
>>>                 backup_total_bytes:     375567417344
>>>                 backup_bytes_used:      243939692544
>>>                 backup_num_devices:     1
>>>
>>>
>>>
>>>
>>>
>>> Mit freundlichen Gr=C3=BC=C3=9Fen/Kind regards
>>>
>>>
>>> Felix Koop
>>>
>>>
>>>> Qu Wenruo <quwenruo.btrfs@gmx.com> hat am 22. September 2019 um 11:5=
0 geschrieben:
>>>>
>>>>
>>>>
>>>>
>>>> On 2019/9/22 =E4=B8=8B=E5=8D=882:34, Felix Koop wrote:
>>>>> Hello,
>>>>>
>>>>> I need help accessing a btrfs-filesystem. When I try to mount the f=
s, I
>>>>> get the following error:
>>>>>
>>>>> # mount -t btrfs /dev/md/1 /mnt
>>>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md1,=

>>>>> missing codepage or helper program, or other error.
>>>>
>>>> dmesg please.
>>>>
>>>>>
>>>>> When I then try to check the fs, this is what I get:
>>>>>
>>>>> # btrfs check /dev/md/1
>>>>> Opening filesystem to check...
>>>>> No valid Btrfs found on /dev/md/1
>>>>> ERROR: cannot open file system
>>>>
>>>> As it said, it can't find the primary superblock.
>>>>
>>>> Please provide the following output.
>>>>
>>>> # btrfs ins dump-super -fFa /dev/md/1
>>>>
>>>> And kernel and btrfs-progs version please.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Can anybody help me how to recover my data?
>>>>>
>>>>>
>>>>
>>


--WfHgCp36q0rFx9r1kO6cw7okPMkIuEbwq--

--V6Mc3rjUwsZpCBpUr0rWI5c6DemYIHssL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2J4KIACgkQwj2R86El
/qhnywf+OIzdduYXMvoMXEKJF712nrvyBQaR8XrGhLNBAkIGGf9zVyvBV1mgtRPu
zFc1cTV8PX3TrMyGxncdLHpF2uNPLKkPyL3Ky2kfD+PziKV/4Sh6Te2DTDOLcdQ4
LMSA1vN85wWIs7F4we8TY00vRgFpQW/Zsu4kVDmSW+/1Y/d4H4Rei57JjVJAD3OZ
90RXc2pJZ7YdAxH6T1Ux5o2iAfkfuseXBVUeSWZdwclFQO25nAU5kd9ZUvpmEGlO
8IYuKpTktf/I38gaGxVxH8ABo9rFpsG3kDBH/VIjMpupcN9CYJy6STmvGri2VCtG
LpJZnjDs9QrPM3Sgc0gM4cGxaEpe/A==
=vT1u
-----END PGP SIGNATURE-----

--V6Mc3rjUwsZpCBpUr0rWI5c6DemYIHssL--
