Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA058950B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 02:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfHLAVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Aug 2019 20:21:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:35113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfHLAVh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Aug 2019 20:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565569294;
        bh=0bIWHwP/Ef5GeUEfrkbeZViylgQ1pcIS0dbm7Mv0TvA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BB/xpjQE2M64VjVS9QfrTDI5zunnqXenXR5OMTcvGof9CYbwwNAYmVAPPpTMylajl
         iqeh6SWRJ+NCh65pu8Rx6S0RciZYJ9jmVs/drOUnocoqLmsmj3L9xZoAH9oavSCko3
         ZMBnEBLStDtRmoQzpt7MRqsty0DB8hJwpjhGdvUM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVHU-1hheA01IbI-00JoBs; Mon, 12
 Aug 2019 02:21:34 +0200
Subject: Re: Mount failure with 5.2.7 but mounts with 5.1.4
To:     Pete <pete@petezilla.co.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
 <9240f2ad-905d-533a-8bb6-55af0aaafbb7@gmx.com>
 <0bc24d6e-2f3f-c0b8-dc0b-59b162653d3a@petezilla.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <cd48f1e8-8fef-9fca-5013-e80909c9801e@gmx.com>
Date:   Mon, 12 Aug 2019 08:21:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0bc24d6e-2f3f-c0b8-dc0b-59b162653d3a@petezilla.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tdSusN3yRlhkxBqRz2Hsz5KcGnTeNod30"
X-Provags-ID: V03:K1:MEvhyhwULMW+cEFC3EG/mkFr5NMWypu0aYosII7o9tTiWYSMWZA
 Uu+kbh1itEjvqmi5kxA4nZLjszYlv7nqwTHKrhchKlttK9DNfdU0w02vODKWS2NSLVDRV/i
 YJcwHgrUxZeKZE7TS61Tlk1A40PkbPp0R1vu4wxftbR2mC/xgnIexGCxmfETjdODWlyHbUc
 pe7FERbQtOv40F6ZIUL5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Kv7pY+ySSM=:8qjLKcQHqKpMErUZv5/mIg
 H4QYEkjq5D25ZHn3U8XScTQ1Jqcv3PFelRPz6AlZ2E8gkSTmj2ulf1pCGut7kKCqIuuwz3wW7
 gkUMQknOHT2WgOM+juLptknD3xDkdVR6sNrrvkPf14FEDItdD3SnNgZORv3FWegg1kvUN0iMi
 uIVOiag46d99vft6fF5UeTPZnF4AvLQ+cJMOZ6iXVkQDbrdZQx4wDwhYkeB00Vyn6dUsekVq+
 94cjXIiwBS0izr5zLWkPcpd2HHHYJbhpGYzTz+ILrAwgNw5hKJESeMCAzykGaFSwP8C16+yq5
 UV12rjowuULHsPR1ufax+TFJrm/B7e4hIaPPwycfAwkJG41NActpGDL8qQGK3K7HnE/BKFQYi
 NLfrWFRUYFDTCgujS+MnT3/hukAamz29lrPYqFcCXxuZtI1F74aIABKNIdqf0b1/9wnuVKlnA
 j0chuJIhL2zbc4Vo1c4BblBBerAcuL2C5OfVzlA3lD66AVUzCxgJJ1ZcEe6F4e2A2vrNJ/+ga
 bUoI/vDqvnCzagCObGx8vNIRIJNTAw2Y9z83edwbTJG0rhQA5mdIORXChTWcQMdqyX6EHbN2J
 kVcf08b/Q4irt8vUoOeboPcaoYYsjOT38uLQEajEqqzWq2ep54Rl36u5zFzX1A41/h2VvkKm5
 SRWNld5sHEenV0P20hJinNrl5S3RJqWjAe8o4b/BtKN66ZIHFXg6BRRcGszxa7r5XdUS6iGPs
 LmjItyV2CMm3282g/tFwzgp+ZQBFbt6GPupu3WdsYwvFyb0/G+dH9H3xISTEBgwJfzY2uTPzZ
 zpnMm7eWqDfac/4vpjJjYvfDhBDJwNKV7meMrx41Ri/QN+wHurAWBR8DjZ5KZ0e8q4axNunQK
 1Qcm/tsMbJiQ8/iffgeSdmU5g3dxMkhvZYL3NCr82WdPzdYSnQnO8ClvDr9/h3vtP/YvDQt2a
 R/blPm4aZGIWceLTnTI9+hMucwRK5xWm744vlBaHeC/oizn2vsM8SSN0qFjZPteXjyvzCFl/p
 457SJhd4MF1V3y83has4BFyWkNBhdjHHvA5+RxUhrh3AfzXZ6yQ4eGsVfxxFiIZIGdSh1ngKO
 QJPRt/iPGs7I2qDbhkyxeiLrYmlnPsvFQSGfxI3aI6WTNhJ9PQuLd7Jfg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tdSusN3yRlhkxBqRz2Hsz5KcGnTeNod30
Content-Type: multipart/mixed; boundary="eN9rFkXKKhsLFzpon42oTRy4VyLOphk1s";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Pete <pete@petezilla.co.uk>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <cd48f1e8-8fef-9fca-5013-e80909c9801e@gmx.com>
Subject: Re: Mount failure with 5.2.7 but mounts with 5.1.4
References: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
 <9240f2ad-905d-533a-8bb6-55af0aaafbb7@gmx.com>
 <0bc24d6e-2f3f-c0b8-dc0b-59b162653d3a@petezilla.co.uk>
In-Reply-To: <0bc24d6e-2f3f-c0b8-dc0b-59b162653d3a@petezilla.co.uk>

--eN9rFkXKKhsLFzpon42oTRy4VyLOphk1s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/12 =E4=B8=8A=E5=8D=8812:23, Pete wrote:
> On 8/11/19 1:13 AM, Qu Wenruo wrote:
>=20
> Qu, thank you.
>=20
>>>
>>> [   55.139154] BTRFS: device fsid 5128caf4-b518-4b65-ae46-b5505281e50=
0
>>> devid 1 transid 66785 /dev/sda4
>>> [   55.139623] BTRFS info (device sda4): disk space caching is enable=
d
>>> [   55.813959] BTRFS critical (device sda4): corrupt leaf: root=3D5
>>> block=3D38884884480 slot=3D1 ino=3D45745394, invalid inode generation=
: has
>>> 18446744073709551492 expect [0, 66786]
>>
>> Please provide the following output:
>>
>> # btrfs ins dump-tree -b 38884884480 /dev/sda4
>=20
> OK, it is long.  Took a bit of a while as I thought it best to build an=

> uptodate version of brtfs-progs.
>=20
> btrfs-progs v5.2.1
> leaf 38884884480 items 24 free space 1441 generation 62836 owner FS_TRE=
E
> leaf 38884884480 flags 0x1(WRITTEN) backref revision 1
> fs uuid 5128caf4-b518-4b65-ae46-b5505281e500
> chunk uuid 8d513d0d-28d5-44d5-9bf7-f3e9f65e68c4
> 	item 0 key (45745393 DIR_INDEX 2) itemoff 3957 itemsize 38
> 		location key (45745394 INODE_ITEM 0) type FILE
> 		transid 3486964995150852608 data_len 0 name_len 8
> 		name: F6259d01

The transid of this inode index is also strange.

> 	item 1 key (45745394 INODE_ITEM 0) itemoff 3797 itemsize 160
> 		generation 1 transid 18446744073709551492 size 56218 nbytes 57344

The offending inode item.

> 		block group 0 mode 100600 links 1 uid 1002 gid 100 rdev 0
> 		sequence 0 flags 0x0(none)
> 		atime 1395590849.0 (2014-03-23 16:07:29)
> 		ctime 1395436187.0 (2014-03-21 21:09:47)
> 		mtime 1395436187.0 (2014-03-21 21:09:47)

It's an old fs, maybe some older kernel caused such strange behavior.

> 		otime 0.0 (1970-01-01 01:00:00)
> 	item 2 key (45745394 INODE_REF 45745393) itemoff 3779 itemsize 18
> 		index 2 namelen 8 name: F6259d01
> 	item 3 key (45745394 EXTENT_DATA 0) itemoff 3726 itemsize 53
> 		generation 3 type 1 (regular)

This looks like the correct generation, 3.

> 		extent data disk byte 747660742656 nr 57344
> 		extent data offset 0 nr 57344 ram 57344
> 		extent compression 0 (none)
> 	item 4 key (45745395 INODE_ITEM 0) itemoff 3566 itemsize 160
> 		generation 1 transid 18446744073709551492 size 16 nbytes 0

This happens again, so definitely not a false alert.

> 		block group 0 mode 40700 links 1 uid 1002 gid 100 rdev 0
> 		sequence 0 flags 0x0(none)
> 		atime 1395590846.0 (2014-03-23 16:07:26)
> 		ctime 1395436187.0 (2014-03-21 21:09:47)
> 		mtime 1395436187.0 (2014-03-21 21:09:47)
> 		otime 0.0 (1970-01-01 01:00:00)
> 	item 5 key (45745395 INODE_REF 45615123) itemoff 3554 itemsize 12
> 		index 40 namelen 2 name: E5
> 	item 6 key (45745395 DIR_ITEM 3983833095) itemoff 3516 itemsize 38
> 		location key (45745396 INODE_ITEM 0) type FILE
> 		transid 53756160 data_len 0 name_len 8

Strange transid again.

> 		name: 7EA03d01
> 	item 7 key (45745395 DIR_INDEX 2) itemoff 3478 itemsize 38
> 		location key (45745396 INODE_ITEM 0) type FILE
> 		transid 53756160 data_len 0 name_len 8

And again.

> 		name: 7EA03d01
> 	item 8 key (45745396 INODE_ITEM 0) itemoff 3318 itemsize 160
> 		generation 1 transid 18446744073709551492 size 16538 nbytes 20480

And again.

So the workaround won't work until you delete all those 2014 files.

I'd recommend to copy the data to a new btrfs using 5.1 kernel.

Thanks,
Qu

> 		block group 0 mode 100600 links 1 uid 1002 gid 100 rdev 0
> 		sequence 0 flags 0x0(none)
> 		atime 1395590851.0 (2014-03-23 16:07:31)
> 		ctime 1395436188.0 (2014-03-21 21:09:48)
> 		mtime 1395436188.0 (2014-03-21 21:09:48)
> 		otime 0.0 (1970-01-01 01:00:00)
> 	item 9 key (45745396 INODE_REF 45745395) itemoff 3300 itemsize 18
> 		index 2 namelen 8 name: 7EA03d01
> 	item 10 key (45745396 EXTENT_DATA 0) itemoff 3247 itemsize 53
> 		generation 3 type 1 (regular)
> 		extent data disk byte 749606772736 nr 20480
> 		extent data offset 0 nr 20480 ram 20480
> 		extent compression 0 (none)
> 	item 11 key (45745397 INODE_ITEM 0) itemoff 3087 itemsize 160
> 		generation 1 transid 18446744073709551492 size 56776 nbytes 57344
> 		block group 0 mode 100600 links 1 uid 1002 gid 100 rdev 0
> 		sequence 0 flags 0x0(none)
> 		atime 1395590846.0 (2014-03-23 16:07:26)
> 		ctime 1395436188.0 (2014-03-21 21:09:48)
> 		mtime 1395436188.0 (2014-03-21 21:09:48)
> 		otime 0.0 (1970-01-01 01:00:00)
> 	item 12 key (45745397 INODE_REF 45744991) itemoff 3069 itemsize 18
> 		index 3 namelen 8 name: 20800d01
> 	item 13 key (45745397 EXTENT_DATA 0) itemoff 3016 itemsize 53
> 		generation 3 type 1 (regular)
> 		extent data disk byte 746701180928 nr 57344
> 		extent data offset 0 nr 57344 ram 57344
> 		extent compression 0 (none)
> 	item 14 key (45745398 INODE_ITEM 0) itemoff 2856 itemsize 160
> 		generation 1 transid 18446744073709551492 size 16 nbytes 0
> 		block group 0 mode 40700 links 1 uid 1002 gid 100 rdev 0
> 		sequence 0 flags 0x0(none)
> 		atime 1395590844.0 (2014-03-23 16:07:24)
> 		ctime 1395436188.0 (2014-03-21 21:09:48)
> 		mtime 1395436188.0 (2014-03-21 21:09:48)
> 		otime 0.0 (1970-01-01 01:00:00)
> 	item 15 key (45745398 INODE_REF 45615119) itemoff 2844 itemsize 12
> 		index 34 namelen 2 name: A4
> 	item 16 key (45745398 DIR_ITEM 3267253918) itemoff 2806 itemsize 38
> 		location key (45745399 INODE_ITEM 0) type FILE
> 		transid 0 data_len 0 name_len 8
> 		name: 21893d01
> 	item 17 key (45745398 DIR_INDEX 2) itemoff 2768 itemsize 38
> 		location key (45745399 INODE_ITEM 0) type FILE
> 		transid 0 data_len 0 name_len 8
> 		name: 21893d01
> 	item 18 key (45745399 INODE_ITEM 0) itemoff 2608 itemsize 160
> 		generation 1 transid 18446744073709551492 size 91218 nbytes 94208
> 		block group 0 mode 100600 links 1 uid 1002 gid 100 rdev 0
> 		sequence 0 flags 0x0(none)
> 		atime 1395590849.0 (2014-03-23 16:07:29)
> 		ctime 1395436189.0 (2014-03-21 21:09:49)
> 		mtime 1395436189.0 (2014-03-21 21:09:49)
> 		otime 0.0 (1970-01-01 01:00:00)
> 	item 19 key (45745399 INODE_REF 45745398) itemoff 2590 itemsize 18
> 		index 2 namelen 8 name: 21893d01
> 	item 20 key (45745399 EXTENT_DATA 0) itemoff 2537 itemsize 53
> 		generation 3 type 1 (regular)
> 		extent data disk byte 1797652480 nr 94208
> 		extent data offset 0 nr 94208 ram 94208
> 		extent compression 0 (none)
> 	item 21 key (45745400 INODE_ITEM 0) itemoff 2377 itemsize 160
> 		generation 20 transid 62836 size 297 nbytes 297
> 		block group 0 mode 100755 links 1 uid 0 gid 0 rdev 0
> 		sequence 11 flags 0x0(none)
> 		atime 1558793952.717852250 (2019-05-25 15:19:12)
> 		ctime 1395594875.621986903 (2014-03-23 17:14:35)
> 		mtime 1395594875.621986903 (2014-03-23 17:14:35)
> 		otime 0.0 (1970-01-01 01:00:00)
> 	item 22 key (45745400 INODE_REF 256) itemoff 2359 itemsize 18
> 		index 15 namelen 8 name: snapshot
> 	item 23 key (45745400 EXTENT_DATA 0) itemoff 2041 itemsize 318
> 		generation 85 type 0 (inline)
> 		inline extent data size 297 ram_bytes 297 compression 0 (none)
>=20
>=20


--eN9rFkXKKhsLFzpon42oTRy4VyLOphk1s--

--tdSusN3yRlhkxBqRz2Hsz5KcGnTeNod30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1QsQUACgkQwj2R86El
/qg4bAf8D/RC/QjjFMESvNfetq04Z81pe918oIh8OHEtiX9+c1zxGDtSxByW5FE5
djsL8iRWsxB+nRiie7WDc+m9PATaHhwqOm0LEVaiMImdeF+BJ/HI7fSSw1BHwSPs
+yoj/vxHDyQjuuOL3vMn/4cUvGahzy5yG4I9kdLOt90IO7GyyqkXnhgidsnl6XmR
NwUQrrsqlfK+OZ7n2OGh+UbG1QsnOh0teGCMWLSX/k2HDb/VTUtODZHl5pepehi3
I4ee3eLDhwBh1kP5Sj4ypLDBAJIfbwZOyHd7OmvYd3/RiGZkHmisU/xj6/jHbVVn
fR6FuzJ0qqClIHzSp6Xtprb8k+9eKw==
=jY6N
-----END PGP SIGNATURE-----

--tdSusN3yRlhkxBqRz2Hsz5KcGnTeNod30--
