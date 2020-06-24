Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4378B20700F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 11:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbgFXJav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 05:30:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:36721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389192AbgFXJau (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 05:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592991045;
        bh=3jA3R2z4nCO5OwWUkLhYofgypG8sBbmdwGjwHU3PIas=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lC36VoeDm2izJz4M6ynakG9Fr3Nhx8IUFXgIyzVpLMtc5CbHa4fjCyvkc+xfQ+YDw
         CrA1J4V/X+Qj/izd+VmVn4wbT9e5YyxTSFVyN4dgdSEqWC4kDlPdFVUIYDMJRef1yy
         iBcepyMPt/bMcMsCNebHKVfvl8Sz3v12rpFbpEro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXuB-1jLmIN2xyR-00Z0aI; Wed, 24
 Jun 2020 11:30:45 +0200
Subject: Re: btrfs-convert results unmountable fs due to extent "beyond device
 boundary"
To:     Jiachen YANG <farseerfc@gmail.com>, linux-btrfs@vger.kernel.org
References: <525158ac-813a-d533-f516-5d2acf9c068f@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <274ff31d-3d93-7c16-6fac-75987fd371d0@gmx.com>
Date:   Wed, 24 Jun 2020 17:30:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <525158ac-813a-d533-f516-5d2acf9c068f@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bID8ez9tDX5qwjspxy4EZArXtUevkPWsT"
X-Provags-ID: V03:K1:j7AKxb5aY4cx5Fg9S8VSTBDJeDqoIMOBJAUl9y5IBW24fWfd2lW
 qWSobbuLgdfd/R3Z+U6TzymiNR+yM39T+00CTO/VvzUdxnieE0cpdheQ3lEGt2qIQaTYSfQ
 4PkMxFGv/87EcaDM/pgUTuGvLQ5lqJVILin/RA42f6ij1r50I0N+9u8JNonXFd9oimh4r7X
 4RJpYyW6tvvAMU9XS15Eg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+biDwxZTds4=:/nDfWe4hdfLhZMrcRqZ++K
 6TehaE+2/EIj7WPvmC5YgWn8jjSAeWXkuvGOVFPkqWn7P9dUOdoYOoUbzYVaMlQEZIYzFognw
 vpYjgrLoxr5DOcidf9grbfFLXV7X0J7SL17aHWdU/bDXdixYq4UxdAYo+GCmxll5nN5vj5bhS
 e8bDu7yjhAO/ewkF1xOgj4PK77vKqylvrXRFQAE4PH5IYdgcukWRtETJc+sc5njH/AotS9noB
 I28ACBIA8r+55caaOphbau/GOsN5k+Eb7KcBYHCHxBuBEZoBj+0W05eBvWSHndm2NplhqnNxS
 kIBkWVEZTCbCkSjHrIsxaazVF/EPjb++REDzUPZ8eHkZddAe6w28E8YjscXXTKxMMqBql8Fhq
 BLtCzbsBRuQKfhuUlW/hUQ9DsmXfD9ZzVvqfwj/t6oNUIKdkK+9uF4HPlIVKQESXnSfmiVllV
 0bDV35XcbZ4sMpIeSMW1nm2lT38PIRk8/QU+2e62Hn/vcc6TSHdd6VGLwIjco8+3rX7+e/0Bx
 fP4bD4BsjUDhns4VrxwakU8s+Y/apzk9ftyDNGIpc+wtFucMdFiaJBVJoF6aclXinwXHASoOG
 o0p6Ner4BjpqHbgEkDOw3is4sDF9BbhtZ7DQb1lpEoEcdKPTncLOCBw6JLqMU2bFYDwXgZoeu
 wN1+UsANNj9PP4C7QwDZ+0zcXBPULjLgyXRjGDTp+LsPxho02Bsw/7wkQYu5iTJ7jb6SRQEIR
 2+3fu9j15w7r7k3KVQvVJoL9aHCE/9npF1AzbNzlyx682wdwb+5n/YHDLYc5fqLCW3VfyPIyJ
 YgXM3m7O5bdatvuny2V79+8HvM593jAQr2R97s34u3t8auwJxMpPYNkfB78B1jbV0wwpoO2Kt
 nIbViVdsvuzsFiIjD2jSWS0HLSq6ASbCu+6uMM5J/kgTdM19vKDKJq9BCJ/jijUkIr4Y6CAaa
 /v5CM2QHCvaICEbTPuYq5V/LbLS/fkd31kbzLRO9PjaoviBlkVZ3uuKUWRG0Ejtnpp7J0Z79e
 c8DdPGtO26QprZeIdhz4DW0G4PSluCinl+3kCtXT9VMP08KTDU5GWqT0PMTDLbDli/1vdLInI
 xqQhytlvotAprbGUJL4X2h09dsGeLBBdwvJzD1ZlwVsyS0TZqWstJGf02yzjagfSdH9IuF/ag
 95hdoDb240TTuJ29aF32zgJahykcKwqQUDbGm3aVPFhxgvtgZkmGG16VYEclwhAmCLNUIJ1mR
 uRpln8DOSoS+Fnisu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bID8ez9tDX5qwjspxy4EZArXtUevkPWsT
Content-Type: multipart/mixed; boundary="khGJrWUHo8PFnapeqEo1ARwqcBn6bXRcQ"

--khGJrWUHo8PFnapeqEo1ARwqcBn6bXRcQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/24 =E4=B8=8B=E5=8D=884:27, Jiachen YANG wrote:
> Hi all,
>=20
> I noticed in some cases using btrfs-convert to convert a existing ext4
> to btrfs will result a fs that is unmountable with the kernel error say=
s
> something like:
>=20
> BTRFS error (device loop0): dev extent devid 1 physical offset 99319808=
0
> len 85786624 is beyond device boundary 1073741824
>=20
> To understand the condition that leads to this situation, I wrote a
> small script that can reproduce this problem using a loop image, both
> the script and the result is pasted on gist:
> https://gist.github.com/farseerfc/4bb173227f5147913ef5e5eaba582f7b
> <https://gist.github.com/farseerfc/4bb173227f5147913ef5e5eaba582f7b>
>=20
> After the btrfs-convert, it is still possible to rollback to ext4 and
> passes e2fsck.
>=20
> The test is run on Arch Linux with kernel=C2=A05.7.5-arch1-1
> btrfs-progs: 5.6.1-3
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Start of=C2=A0test-btrfs-convert.sh
> #!/bin/sh
> set -x
>=20
> cleanup(){
> =C2=A0 umount testmount
> }
>=20
> # remove test image and recreate it
> rm -rf testimage testmount
> mkdir testmount
> fallocate -l 1G testimage
> mkfs.ext4 testimage
>=20
> mount testimage testmount
> trap cleanup ERR
> trap cleanup EXIT
>=20
> fallocate -l 200M testmount/test1
> fallocate -l 200M testmount/test2
> fallocate -l 200M testmount/test3
> fallocate -l 200M testmount/test4
>=20
> fallocate -l 205M testmount/test1
> fallocate -l 205M testmount/test2
> fallocate -l 205M testmount/test3
> fallocate -l 205M testmount/test4
>=20
> sync testmount/* testmount
>=20
> df testmount
> # should remain some space for btrfs-convert to write metadata
> umount testmount
>=20
> btrfs-convert testimage
> mount testimage testmount
> dmesg | tail -n10
> btrfs inspect-internal dump-tree -t CHUNK testimage
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D End of test-btrfs-convert.sh
>=20
> The following is the result:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Start of result.txt
> + rm -rf testimage testmount
> + mkdir testmount
> + fallocate -l 1G testimage
> + mkfs.ext4 testimage
> mke2fs 1.45.6 (20-Mar-2020)
> Discarding device blocks: =C2=A0 4096/262144 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 done
> Creating filesystem with 262144 4k blocks and 65536 inodes
> Filesystem UUID: f4746471-fb36-4a46-8b05-258557c24a0c
> Superblock backups stored on blocks:
> 32768, 98304, 163840, 229376
>=20
> Allocating group tables: 0/8 =C2=A0 done
> Writing inode tables: 0/8 =C2=A0 done
> Creating journal (8192 blocks): done
> Writing superblocks and filesystem accounting information: 0/8 done
>=20
> + mount testimage testmount
> + trap cleanup ERR
> + trap cleanup EXIT
> + fallocate -l 200M testmount/test1
> + fallocate -l 200M testmount/test2
> + fallocate -l 200M testmount/test3
> + fallocate -l 200M testmount/test4
> + fallocate -l 205M testmount/test1
> + fallocate -l 205M testmount/test2
> + fallocate -l 205M testmount/test3
> + fallocate -l 205M testmount/test4

It's pretty interesting for the extra 5M extents.
As if we go 205M directly, it doesn't cause the problem.

Anyway since we can reproduce the bug easily it should be pretty easy to
fix.

My first guess is the chunk allocator is causing some problem, will look
into it.

Thanks,
Qu

> + sync testmount/lost+found testmount/test1 testmount/test2
> testmount/test3 testmount/test4 testmount
> + df testmount
> Filesystem =C2=A0 =C2=A0 1K-blocks =C2=A0 Used Available Use% Mounted o=
n
> /dev/loop0 =C2=A0 =C2=A0 =C2=A0 =C2=A0999320 842244 =C2=A0 =C2=A0 88264=
 =C2=A091%
> /home/farseerfc/tmp/testbtrfsconvert/testmount
> + umount testmount
> + btrfs-convert testimage
> create btrfs filesystem:
> blocksize: 4096
> nodesize: =C2=A016384
> features: =C2=A0extref, skinny-metadata (default)
> checksum: =C2=A0crc32c
> creating ext2 image file
> creating btrfs metadata
> copy inodes [o] [ =C2=A0 =C2=A0 =C2=A0 =C2=A0 0/ =C2=A0 =C2=A0 =C2=A0 =C2=
=A015]
> conversion complete
> + mount testimage testmount
> mount: /home/farseerfc/tmp/testbtrfsconvert/testmount: wrong fs type,
> bad option, bad superblock on /dev/loop0, missing codepage or helper
> program, or other error.
> ++ cleanup
> ++ umount testmount
> umount: testmount: not mounted.
> + dmesg
> + tail -n10
> [108720.796804] audit: type=3D1110 audit(1592986026.992:1462): pid=3D12=
23346
> uid=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:setcred
> grantors=3Dpam_unix,pam_permit,pam_env acct=3D"root" exe=3D"/usr/bin/su=
do"
> hostname=3D? addr=3D? terminal=3D/dev/pts/5 res=3Dsuccess'
> [108720.797047] audit: type=3D1105 audit(1592986026.992:1463): pid=3D12=
23346
> uid=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:session_open
> grantors=3Dpam_limits,pam_unix,pam_permit acct=3D"root" exe=3D"/usr/bin=
/sudo"
> hostname=3D? addr=3D? terminal=3D/dev/pts/5 res=3Dsuccess'
> [108721.091932] EXT4-fs (loop0): mounted filesystem with ordered data
> mode. Opts: (null)
> [108724.885590] BTRFS: device fsid 8c731320-4aed-40de-bdd7-c817217625dc=

> devid 1 transid 5 /dev/loop0 scanned by systemd-udevd (1223354)
> [108724.887288] BTRFS info (device loop0): disk space caching is enable=
d
> [108724.887292] BTRFS info (device loop0): has skinny extents
> [108724.887295] BTRFS info (device loop0): flagging fs with big metadat=
a
> feature
> [108724.891277] BTRFS error (device loop0): dev extent devid 1 physical=

> offset 993198080 len 85786624 is beyond device boundary 1073741824
> [108724.891279] BTRFS error (device loop0): failed to verify dev extent=
s
> against chunks: -117
> [108724.919813] BTRFS error (device loop0): open_ctree failed
> + btrfs inspect-internal dump-tree -t CHUNK testimage
> btrfs-progs v5.6.1
> chunk tree
> leaf 33619968 items 14 free space 14795 generation 3 owner CHUNK_TREE
> leaf 33619968 flags 0x1(WRITTEN) backref revision 1
> fs uuid 8c731320-4aed-40de-bdd7-c817217625dc
> chunk uuid a5a0638e-944a-4b92-989c-8cd252e427e8
> item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
> devid 1 total_bytes 1073741824 bytes_used 1023410176
> io_align 4096 io_width 4096 sector_size 4096 type 0
> generation 0 start_offset 0 dev_group 0
> seek_speed 0 bandwidth 0
> uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> fsid 8c731320-4aed-40de-bdd7-c817217625dc
> item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 1048576) itemoff 16105 itemsize=
 80
> length 32505856 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 1048576
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 33619968) itemoff 16025 itemsiz=
e 80
> length 4194304 owner 2 stripe_len 65536 type SYSTEM
> io_align 4096 io_width 4096 sector_size 4096
> num_stripes 1 sub_stripes 0
> stripe 0 devid 1 offset 33619968
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 67174400) itemoff 15945 itemsiz=
e 80
> length 33554432 owner 2 stripe_len 65536 type METADATA
> io_align 4096 io_width 4096 sector_size 4096
> num_stripes 1 sub_stripes 0
> stripe 0 devid 1 offset 67174400
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 134217728) itemoff 15865
> itemsize 80
> length 107372544 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 134217728
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 241590272) itemoff 15785
> itemsize 80
> length 107372544 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 241590272
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 348962816) itemoff 15705
> itemsize 80
> length 107372544 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 348962816
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 456335360) itemoff 15625
> itemsize 80
> length 107372544 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 456335360
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 8 key (FIRST_CHUNK_TREE CHUNK_ITEM 563707904) itemoff 15545
> itemsize 80
> length 107372544 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 563707904
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 9 key (FIRST_CHUNK_TREE CHUNK_ITEM 671080448) itemoff 15465
> itemsize 80
> length 107372544 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 671080448
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 10 key (FIRST_CHUNK_TREE CHUNK_ITEM 778452992) itemoff 15385
> itemsize 80
> length 107372544 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 778452992
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 11 key (FIRST_CHUNK_TREE CHUNK_ITEM 885825536) itemoff 15305
> itemsize 80
> length 107372544 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 885825536
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 12 key (FIRST_CHUNK_TREE CHUNK_ITEM 993198080) itemoff 15225
> itemsize 80
> length 85786624 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 993198080
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> item 13 key (FIRST_CHUNK_TREE CHUNK_ITEM 1078984704) itemoff 15145
> itemsize 80
> length 8388608 owner 2 stripe_len 65536 type DATA
> io_align 65536 io_width 65536 sector_size 4096
> num_stripes 1 sub_stripes 1
> stripe 0 devid 1 offset 37814272
> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
> + cleanup
> + umount testmount
> umount: testmount: not mounted.
> ++ cleanup
> ++ umount testmount
> umount: testmount: not mounted.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D End of result.txt
>=20
> Is this a known bug in btrfs-convert ?
> I myself cannot fully understand why this happens



--khGJrWUHo8PFnapeqEo1ARwqcBn6bXRcQ--

--bID8ez9tDX5qwjspxy4EZArXtUevkPWsT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7zHUEACgkQwj2R86El
/qiJLgf/WQF7KeAw/WM7QaXgXFKoMVpmBfXqpyqX32lpPDLzYmvA7bLmMp+wbmpx
DjQ6Ytw2Xd/v01s6bUC1MFQznDVt/46NO4jbc0raeJp2F6in26tKT2txNka6QK8J
Ly82WDfBOu+QTXBKFhRbaRZKbW8ONd2RFzqhCc243Ngshu3Ak8ewNJlbYfajcLD9
S18Two+Fg+mI6LeVAgYO2b0okvyeqi3B2WBpvPr/V6gfHTCLhWFF5XLDXIgvRZAm
nVR4eZBheKzXYOO3eAwkJwWVbzYPY+Vvs+q9KqeIN6NdufUF5VgihKYU8VAd7cVu
C67UiM6Wj4nAYYf8BWRkHcfPSQ9ARQ==
=xHSw
-----END PGP SIGNATURE-----

--bID8ez9tDX5qwjspxy4EZArXtUevkPWsT--
