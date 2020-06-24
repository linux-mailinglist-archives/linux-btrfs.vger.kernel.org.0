Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3772072B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbgFXL6l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 07:58:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:54187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388491AbgFXL6j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 07:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592999916;
        bh=I3Vd4LmLaKrh6FTUghnoZsKxNqiPYKOhGyff2BzB30Y=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=ZtW3bs4NxnA/Fz3kLgixDd3Bz3AvasmuaZic9IsQNblmmMcgMIVNPPS2kS7sUxULn
         //iPDf5eo5mSB6IlZ5hbsl7RfQBfoUjARZPss4+MMTX8m5nHI7Io6mQkU0p1DmEHGi
         mj7kA7TgIPNchOfQu2cWcv9HKh8/uexnwaPFZrIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFvj-1jg39q37wL-00AGvR; Wed, 24
 Jun 2020 13:58:36 +0200
Subject: Re: btrfs-convert results unmountable fs due to extent "beyond device
 boundary"
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Jiachen YANG <farseerfc@gmail.com>, linux-btrfs@vger.kernel.org
References: <525158ac-813a-d533-f516-5d2acf9c068f@gmail.com>
 <274ff31d-3d93-7c16-6fac-75987fd371d0@gmx.com>
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
Message-ID: <739ee241-9b03-a9b1-6241-3a54c25a3bda@gmx.com>
Date:   Wed, 24 Jun 2020 19:58:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <274ff31d-3d93-7c16-6fac-75987fd371d0@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XWw3HF9AvZgSCpG32ssF3EjTWEAIGphUI"
X-Provags-ID: V03:K1:l+BmWeo1c32B+tNfYRh9cZaImTO0RJjkkm5VVH66Uf8tN0C7+67
 5hP7cQGWoPYv2MzGYaG8bgImM5uv8W4o43gtZ1ORlQ752lUrW2HQyVNm8gjC42i/x2jJX0m
 i6KYTD1z0bnErOK4sScBiJopegPdRguElOw2CN9UuczFKEBHE+UBsDHnpLng1HYRUZ3jrn2
 dnmBK2+PTlNJra4wpz7CA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0a9UhPRLzeg=:b3fOVfEJjFo1oF4K1nltx4
 wT7aqvJT1b3e2MRHLI4Sk7y/gTOuVdZFHIep5KuBR34IbSdNpM4Z2GC49Ro+pNr87jaF/41ar
 WcydBiNya/YMlcjmxD074XcYUWmiBjh2aX5+uq7KgAUVMU9oRAcy0xg5r0doTUkcELGc/ikMw
 BWaN+DUNhaU+qs9QHdBpW/cwZ2OSd7CkIhEXhpwNt/3YIypyp0u/nZwuCaxr1T7QeyOos9ilB
 DT3pHerpKtXgJ1oWmb/9JahShAuRANpx9qNDN1H5ka0HyQHmxlr2od+owsPJpqXa8C8wYPPnR
 5hLyEQ6213Sx2EIONP5cEn06ceF73mNBNxV36zxtJrFYB25ikTR48EM24esnrGdChx7JIu+fS
 yXdQwT0LsKPMrkM7vdcb6K0v8wtBNqKn+HSxaJ6+IbSdnmi58q3s4blqqbjwVJUwsPLiTQG+o
 Pkriu3yg/o0XTzuFIfV6OBGvBL6QCcVXy+CsX8sZta8DZp8Z/UeL0kVyOJN9//SfG/Jwi2KJT
 xJcv71+lEahS4Ti+yaXvIgy8u73EHMNo676KZqpc31RExK7WNu7x8hLkPuv16JqvLJrEwdz1O
 PoWkIk4eMOjqcrcbk2DouQcnG95iIBns1pjBiMTXM11o9TcKAKdyCfFHdaJUlCbUBQdrWHtNF
 +tVy0UHwSxkrzgSp3PwYSwdwKD3MztYs8/zbOUB9YJ4Ni4Gmba0e29BpL39d7oZMPgpHqeOVC
 mzcnaRQ4CRkrONVdC5VntyTukVKW8LrQpItAK8eJzWd+NRTvBQlbRLgB56xWXC/c8vXWOepdY
 XI57fMeBvKQCDwkp7uj8B4hxEzqljGrEAYJDxxqGUqABC/VdggbePAHmcQRvujbpBxFluYvHp
 akx7f+W+P29NnF3+vlbpdewqHwUmPDYAdM6R4cHDXTMa/Y01Hsmeaa3ZZ061opI1beDbc2Wuf
 P8zmuUpBIScBds3az2Q9tBsmaG7csIgV12Zegi2icg0eHCbGLt5oCHoZ8PFjTLZksUrooZ+CO
 IbLbb0ZlhDZ5jS4g8dzetewD4dtCTu2KnfupQKj9B1kvw/idEJs0HMap9iFNlmaHyUgBnEI/Q
 DvueZKk3gd8UpcJPTBI6izMEARVJHP8LCgVdQez30HP1RTZ+zlHe9C80KPyjzMMSvUPlojJZY
 X+PaXnZTd3cGMx6dHdBdrYvnjmB/2I4XBQMKDHZEg8xVTWonFtVytpfujN4ivRSNu6LMJ0FnX
 vhQBdjFYqDZ+kFAMt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XWw3HF9AvZgSCpG32ssF3EjTWEAIGphUI
Content-Type: multipart/mixed; boundary="CE5ojAN660uGzN4xX6YG2XQE4VWf0OoeW"

--CE5ojAN660uGzN4xX6YG2XQE4VWf0OoeW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/24 =E4=B8=8B=E5=8D=885:30, Qu Wenruo wrote:
>=20
>=20
> On 2020/6/24 =E4=B8=8B=E5=8D=884:27, Jiachen YANG wrote:
>> Hi all,
>>
>> I noticed in some cases using btrfs-convert to convert a existing ext4=

>> to btrfs will result a fs that is unmountable with the kernel error sa=
ys
>> something like:
>>
>> BTRFS error (device loop0): dev extent devid 1 physical offset 9931980=
80
>> len 85786624 is beyond device boundary 1073741824
>>
>> To understand the condition that leads to this situation, I wrote a
>> small script that can reproduce this problem using a loop image, both
>> the script and the result is pasted on gist:
>> https://gist.github.com/farseerfc/4bb173227f5147913ef5e5eaba582f7b
>> <https://gist.github.com/farseerfc/4bb173227f5147913ef5e5eaba582f7b>
>>
>> After the btrfs-convert, it is still possible to rollback to ext4 and
>> passes e2fsck.
>>
>> The test is run on Arch Linux with kernel=C2=A05.7.5-arch1-1
>> btrfs-progs: 5.6.1-3
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Start of=C2=A0test-btrfs-convert.sh
>> #!/bin/sh
>> set -x
>>
>> cleanup(){
>> =C2=A0 umount testmount
>> }
>>
>> # remove test image and recreate it
>> rm -rf testimage testmount
>> mkdir testmount
>> fallocate -l 1G testimage
>> mkfs.ext4 testimage
>>
>> mount testimage testmount
>> trap cleanup ERR
>> trap cleanup EXIT
>>
>> fallocate -l 200M testmount/test1
>> fallocate -l 200M testmount/test2
>> fallocate -l 200M testmount/test3
>> fallocate -l 200M testmount/test4
>>
>> fallocate -l 205M testmount/test1
>> fallocate -l 205M testmount/test2
>> fallocate -l 205M testmount/test3
>> fallocate -l 205M testmount/test4
>>
>> sync testmount/* testmount
>>
>> df testmount
>> # should remain some space for btrfs-convert to write metadata
>> umount testmount
>>
>> btrfs-convert testimage
>> mount testimage testmount
>> dmesg | tail -n10
>> btrfs inspect-internal dump-tree -t CHUNK testimage
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D End of test-btrfs-convert.sh
>>
>> The following is the result:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Start of result.txt
>> + rm -rf testimage testmount
>> + mkdir testmount
>> + fallocate -l 1G testimage
>> + mkfs.ext4 testimage
>> mke2fs 1.45.6 (20-Mar-2020)
>> Discarding device blocks: =C2=A0 4096/262144 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 done
>> Creating filesystem with 262144 4k blocks and 65536 inodes
>> Filesystem UUID: f4746471-fb36-4a46-8b05-258557c24a0c
>> Superblock backups stored on blocks:
>> 32768, 98304, 163840, 229376
>>
>> Allocating group tables: 0/8 =C2=A0 done
>> Writing inode tables: 0/8 =C2=A0 done
>> Creating journal (8192 blocks): done
>> Writing superblocks and filesystem accounting information: 0/8 done
>>
>> + mount testimage testmount
>> + trap cleanup ERR
>> + trap cleanup EXIT
>> + fallocate -l 200M testmount/test1
>> + fallocate -l 200M testmount/test2
>> + fallocate -l 200M testmount/test3
>> + fallocate -l 200M testmount/test4
>> + fallocate -l 205M testmount/test1
>> + fallocate -l 205M testmount/test2
>> + fallocate -l 205M testmount/test3
>> + fallocate -l 205M testmount/test4
>=20
> It's pretty interesting for the extra 5M extents.
> As if we go 205M directly, it doesn't cause the problem.
>=20
> Anyway since we can reproduce the bug easily it should be pretty easy t=
o
> fix.
>=20
> My first guess is the chunk allocator is causing some problem, will loo=
k
> into it.

The cause is pinned down, and passes my local tests along with your test
script.
The fix has you added as CC.

It would be nicer if you could try that fix and maybe hammer it more to
see if it can handle what life can throw to it.

Thanks for your detailed report along with you test case!
Qu

>=20
> Thanks,
> Qu
>=20
>> + sync testmount/lost+found testmount/test1 testmount/test2
>> testmount/test3 testmount/test4 testmount
>> + df testmount
>> Filesystem =C2=A0 =C2=A0 1K-blocks =C2=A0 Used Available Use% Mounted =
on
>> /dev/loop0 =C2=A0 =C2=A0 =C2=A0 =C2=A0999320 842244 =C2=A0 =C2=A0 8826=
4 =C2=A091%
>> /home/farseerfc/tmp/testbtrfsconvert/testmount
>> + umount testmount
>> + btrfs-convert testimage
>> create btrfs filesystem:
>> blocksize: 4096
>> nodesize: =C2=A016384
>> features: =C2=A0extref, skinny-metadata (default)
>> checksum: =C2=A0crc32c
>> creating ext2 image file
>> creating btrfs metadata
>> copy inodes [o] [ =C2=A0 =C2=A0 =C2=A0 =C2=A0 0/ =C2=A0 =C2=A0 =C2=A0 =
=C2=A015]
>> conversion complete
>> + mount testimage testmount
>> mount: /home/farseerfc/tmp/testbtrfsconvert/testmount: wrong fs type,
>> bad option, bad superblock on /dev/loop0, missing codepage or helper
>> program, or other error.
>> ++ cleanup
>> ++ umount testmount
>> umount: testmount: not mounted.
>> + dmesg
>> + tail -n10
>> [108720.796804] audit: type=3D1110 audit(1592986026.992:1462): pid=3D1=
223346
>> uid=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:setcred
>> grantors=3Dpam_unix,pam_permit,pam_env acct=3D"root" exe=3D"/usr/bin/s=
udo"
>> hostname=3D? addr=3D? terminal=3D/dev/pts/5 res=3Dsuccess'
>> [108720.797047] audit: type=3D1105 audit(1592986026.992:1463): pid=3D1=
223346
>> uid=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:session_open
>> grantors=3Dpam_limits,pam_unix,pam_permit acct=3D"root" exe=3D"/usr/bi=
n/sudo"
>> hostname=3D? addr=3D? terminal=3D/dev/pts/5 res=3Dsuccess'
>> [108721.091932] EXT4-fs (loop0): mounted filesystem with ordered data
>> mode. Opts: (null)
>> [108724.885590] BTRFS: device fsid 8c731320-4aed-40de-bdd7-c817217625d=
c
>> devid 1 transid 5 /dev/loop0 scanned by systemd-udevd (1223354)
>> [108724.887288] BTRFS info (device loop0): disk space caching is enabl=
ed
>> [108724.887292] BTRFS info (device loop0): has skinny extents
>> [108724.887295] BTRFS info (device loop0): flagging fs with big metada=
ta
>> feature
>> [108724.891277] BTRFS error (device loop0): dev extent devid 1 physica=
l
>> offset 993198080 len 85786624 is beyond device boundary 1073741824
>> [108724.891279] BTRFS error (device loop0): failed to verify dev exten=
ts
>> against chunks: -117
>> [108724.919813] BTRFS error (device loop0): open_ctree failed
>> + btrfs inspect-internal dump-tree -t CHUNK testimage
>> btrfs-progs v5.6.1
>> chunk tree
>> leaf 33619968 items 14 free space 14795 generation 3 owner CHUNK_TREE
>> leaf 33619968 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 8c731320-4aed-40de-bdd7-c817217625dc
>> chunk uuid a5a0638e-944a-4b92-989c-8cd252e427e8
>> item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
>> devid 1 total_bytes 1073741824 bytes_used 1023410176
>> io_align 4096 io_width 4096 sector_size 4096 type 0
>> generation 0 start_offset 0 dev_group 0
>> seek_speed 0 bandwidth 0
>> uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> fsid 8c731320-4aed-40de-bdd7-c817217625dc
>> item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 1048576) itemoff 16105 itemsiz=
e 80
>> length 32505856 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 1048576
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 33619968) itemoff 16025 itemsi=
ze 80
>> length 4194304 owner 2 stripe_len 65536 type SYSTEM
>> io_align 4096 io_width 4096 sector_size 4096
>> num_stripes 1 sub_stripes 0
>> stripe 0 devid 1 offset 33619968
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 67174400) itemoff 15945 itemsi=
ze 80
>> length 33554432 owner 2 stripe_len 65536 type METADATA
>> io_align 4096 io_width 4096 sector_size 4096
>> num_stripes 1 sub_stripes 0
>> stripe 0 devid 1 offset 67174400
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 134217728) itemoff 15865
>> itemsize 80
>> length 107372544 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 134217728
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 241590272) itemoff 15785
>> itemsize 80
>> length 107372544 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 241590272
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 348962816) itemoff 15705
>> itemsize 80
>> length 107372544 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 348962816
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 456335360) itemoff 15625
>> itemsize 80
>> length 107372544 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 456335360
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 8 key (FIRST_CHUNK_TREE CHUNK_ITEM 563707904) itemoff 15545
>> itemsize 80
>> length 107372544 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 563707904
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 9 key (FIRST_CHUNK_TREE CHUNK_ITEM 671080448) itemoff 15465
>> itemsize 80
>> length 107372544 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 671080448
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 10 key (FIRST_CHUNK_TREE CHUNK_ITEM 778452992) itemoff 15385
>> itemsize 80
>> length 107372544 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 778452992
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 11 key (FIRST_CHUNK_TREE CHUNK_ITEM 885825536) itemoff 15305
>> itemsize 80
>> length 107372544 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 885825536
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 12 key (FIRST_CHUNK_TREE CHUNK_ITEM 993198080) itemoff 15225
>> itemsize 80
>> length 85786624 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 993198080
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> item 13 key (FIRST_CHUNK_TREE CHUNK_ITEM 1078984704) itemoff 15145
>> itemsize 80
>> length 8388608 owner 2 stripe_len 65536 type DATA
>> io_align 65536 io_width 65536 sector_size 4096
>> num_stripes 1 sub_stripes 1
>> stripe 0 devid 1 offset 37814272
>> dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
>> + cleanup
>> + umount testmount
>> umount: testmount: not mounted.
>> ++ cleanup
>> ++ umount testmount
>> umount: testmount: not mounted.
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D End of result.txt
>>
>> Is this a known bug in btrfs-convert ?
>> I myself cannot fully understand why this happens
>=20
>=20


--CE5ojAN660uGzN4xX6YG2XQE4VWf0OoeW--

--XWw3HF9AvZgSCpG32ssF3EjTWEAIGphUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7zP+gACgkQwj2R86El
/qhhkQgAnUlG7TCegPC3k4Bi1/FrrmdhWRPyN35vnhBzzjOyyZRQvd0ioeDZHxaR
q5iOSrgZnWz0ZsI5uivI7e3tdKaIeuVIXQv2edG180tkEw/zXwk+J0zHrJzFJhFn
744HqcgP6+6N1eztEq4zjUlyhpsmE7Z8cIf372iDmWQwNCLBjO/5Pl5E8evxukDJ
HSHKSzqkHakpQA9V5sd2dMhty2bOVBgggXZHNLOiNWEygdjFXc7Cre+xkUx8llg9
8i0+xp/vimfJzwrjJnGqoCf3QWoB91JAmSNMUbcEgqFc7e54zn2qIdkc0ZLWV991
BGPajPWpgPOhZ7wAyfC069wG/o1COg==
=R7qK
-----END PGP SIGNATURE-----

--XWw3HF9AvZgSCpG32ssF3EjTWEAIGphUI--
