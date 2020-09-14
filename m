Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8495F268742
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 10:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgINIeP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 04:34:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:35169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgINIeM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 04:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600072447;
        bh=Jh8IvuMpuyoyTpRjPsQYe1IYbem5RP5I/ZuGleLUFtc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=D1RRNpRDuRzwc3K/2jeZjYPM3Qyb1wiyg2/Y2P4KJxky9+RwWEjPrHAjQrJ9+bDSj
         L5XoahWj4eu5bQComAM0TpEc4RkRC9FTBr0AiWetyu5wqjlWmZLWvAZA3rUqf9byzn
         sQGlVIvJyO85cs+yOtndv14XFEng4opKKNjDvPEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNJg-1k42Wa2JsY-00VQSJ; Mon, 14
 Sep 2020 10:34:07 +0200
Subject: Re: Drive won't mount, please help
To:     J J <j333111@icloud.com>, linux-btrfs@vger.kernel.org
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
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
Message-ID: <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com>
Date:   Mon, 14 Sep 2020 16:34:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IYRyfZeHt6qtxfs6Nddav8M2pmOqvAY4Y"
X-Provags-ID: V03:K1:+5dnwNCAL2U8pExS+qF6pevMgACJc2SVqlEJlWeH/QYDiOm+XbN
 rsEN9DnB+SRQJdbVYfG4XgbFykYrmKJluc31bYP8ktbkeXFBqyMV+tvRkC7e/D6JXtk95ds
 UeVObJcs4y5BGidLle9lgfU0WsREE+fLWBTnFijZ07mO7DPlxxF9xsk6d0lYpKR+vtYJS7v
 Ztz+xJoSfajhrVC+/WipA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:57+DaYqm+XU=:4HsYhKjATsmJCKwgqknXnX
 7AMUfU0Of61v4fMRdsZ9Xb562jLFwRSpoSd6Iaizww9Vmx/nPFOfpf5TBS+Zf5RdVHdezJgAo
 ZwDQogNhIB1pTaah7m7tBQiCxSugk9pEhT7TuY4mzOFw5PR7s1hnLY5qLd+nXBleSSQ/vAGO4
 1E+TC8Wp6LMATyWBZ6l60iF0nEr86R4+2pIwFkEyN+2LXbqKb96PLDgxBkCjtV/88hrY0mQBR
 YklmKF41lklbMZ/l9IWB5Ra9wQn4gx/iDGGqW+qlA/HiPf2TgmhTb/3Xg0lBzyD9nRWXaHfmX
 h4drsRX++aHx4ErR1enqY+OzgY043xdFUVR5uPrm4TNjDeLLI57zSYk4jkeBF1ruiJI5oR67x
 HGMRTijbkkoqtKS2cOouxGvxR7+HGlNZ00RxBtjnay2Up8CyEtbj9UtWaSbV9GqrCCC01kYJA
 40fMc4Dwh4+l0RjiEQiXOn9wQYbeeKZOIY9q7/O67GFrB4KtuBGQDCvYg3RIFiiUl4hybT+e1
 SQUlcGlhLJDa6xtVU3gBpxMyIlV9iLF6NZkAxrlbs/mjP5njuVrKwoGplsss9lsc60IxPTwVr
 TJEazT4wDbWPWOi2A/ibYVfjATNVaYNqTg1ENmEpGVL3qpKXbSQ4HLCcC4EZfP33IkeIANnSR
 JCDkR2Kn2JA+kFQxvb/sAtrgLsDx5mZlQxVEre3klbYHQvVKGUfWNiTyRjuUmM37wXqtVCRTd
 l41EL0pCiEOfSmnWifZOi/fvM4/tlIQuforsHqTdHgWLmW6rWtk4JehJ6Y09vm69Xin8kq+WB
 CHtOPqZ1iuJvWNuUs15rkQp9Fqx/CfXAEi1hYhv9z08LHX935PQ7xajtQeoZ5eEzFWh5EEFqz
 gNqggUKh2Lmtdm7+OlIkkqeMW1qcxEcGZh3M5ru6iqh44uRfTs9jHhzwEmEH6aTH0rGAVkkjN
 QhGg56A995tSw18UMWc/j5Jtha0vzpq6YHx9qOhldWSYYL5SY9SaStXGYQVd7D85cg+/vwshN
 AbBK9Gk/NjaBIytJd1v+Ze+FDp2+ohriWvdZpZbg+SdsHM0EL+F976lzsY2oxcnaIZ8hjax4r
 e2RzE9bsNilk5kyGdi8Y7m9C9CYxHX89DEYHGhiJnNFAuAHbPBBrqbaPCOMB8vXotZKFLl+6U
 lk/2xZSBTTfvoiDzLXPQGModlrMo8OoGcY1xagIFyVLvlgQ2kxitxWFhQrAPaK1Ya+4aVFpVF
 6UiEjqF4lnDrjNj0nHlEXWQPEY+nRCX97j2lYHA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IYRyfZeHt6qtxfs6Nddav8M2pmOqvAY4Y
Content-Type: multipart/mixed; boundary="NHeFO872a5QIePyYFARGp14ggkAvbmbwL"

--NHeFO872a5QIePyYFARGp14ggkAvbmbwL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/14 =E4=B8=8A=E5=8D=884:56, J J wrote:
>  I=E2=80=99m new to a lot of this, just trying to use a NAS at home, si=
ngle usb external disk, not RAID. Was working great for a few months, I=E2=
=80=99m not sure what changed today when it stopped mounting. Any advice =
appreciated.

Transid mismatch, and the expected transid is newer than the on-disk
transid.

This means, either btrfs has some bug that causes metadata writeback not
following COW, or the disk controller/disk itself ignores Flush/FUA
commands.

Considering it's usb external disk, I doubt the later case.

In that case, any fs would experience similar problem if a sudden power
loss or cable loss happened.

You may workaround such problem by disabling the writecache, but I doubt
if the USB->Sata convert would follow the request.

Thanks,
Qu
>=20
> Dmesg log attached
>=20
>=20
> uname -a
> Linux rock64 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 #1 SMP Wed Aug =
28 08:59:34 UTC 2019 aarch64 GNU/Linux
>=20
>=20
>=20
> btrfs --version
> btrfs-progs v4.7.3
>=20
>=20
>=20
> btrfs fi show
> Label: '3TBRock64'  uuid: 71eda2e3-384c-4868-b5d4-683f222865e6
> 	Total devices 1 FS bytes used 2.48TiB
> 	devid    1 size 2.73TiB used 2.59TiB path /dev/mapper/sda-crypt
>=20
>=20
> btrfs fi df /dev/mapper/sda-crypt
> ERROR: not a btrfs filesystem: /dev/mapper/sda-crypt
>=20
>=20
> btrfs inspect-internal dump-super /dev/mapper/sda-crypt=20
> superblock: bytenr=3D65536, device=3D/dev/mapper/sda-crypt
> ---------------------------------------------------------
> csum_type		0 (crc32c)
> csum_size		4
> csum			0x9e8b0c33 [match]
> bytenr			65536
> flags			0x1
> 			( WRITTEN )
> magic			_BHRfS_M [match]
> fsid			71eda2e3-384c-4868-b5d4-683f222865e6
> label			3TBRock64
> generation		395886
> root			2638934654976
> sys_array_size		129
> chunk_root_generation	377485
> root_level		1
> chunk_root		20971520
> chunk_root_level	1
> log_root		2638952366080
> log_root_transid	0
> log_root_level		0
> total_bytes		3000556847104
> bytes_used		2729422221312
> sectorsize		4096
> nodesize		16384
> leafsize		16384
> stripesize		4096
> root_dir		6
> num_devices		1
> compat_flags		0x0
> compat_ro_flags		0x0
> incompat_flags		0x161
> 			( MIXED_BACKREF |
> 			  BIG_METADATA |
> 			  EXTENDED_IREF |
> 			  SKINNY_METADATA )
> cache_generation	395886
> uuid_tree_generation	395886
> dev_item.uuid		b7f4386a-18e0-437b-9588-6064ff483fd5
> dev_item.fsid		71eda2e3-384c-4868-b5d4-683f222865e6 [match]
> dev_item.type		0
> dev_item.total_bytes	3000556847104
> dev_item.bytes_used	2843293515776
> dev_item.io_align	4096
> dev_item.io_width	4096
> dev_item.sector_size	4096
> dev_item.devid		1
> dev_item.dev_group	0
> dev_item.seek_speed	0
> dev_item.bandwidth	0
>=20
>=20
> dev_item.generation	0
>=20


--NHeFO872a5QIePyYFARGp14ggkAvbmbwL--

--IYRyfZeHt6qtxfs6Nddav8M2pmOqvAY4Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9fKvwACgkQwj2R86El
/qiFmwf+NPsjh+twp1O8AKO71M+SPIbpXycPoJDNWKZg01btKTq1ZKECphMUemy+
HGpxl4m+1zJ52FOYTLX8iEC1de4AAWUVkIcUb+I4A0pUP+45EMCS2bqgqytHKECQ
4SJ/UjaoduHnkBugrwaiTJGbs3lh0xY5yvcnOo0GAf1wqutQSVR3VnTcrCTKPThP
Qi1/TT8AMzFof7tVJTDFH7NpI7roFWqqBe8pN68RdO0KVKd5KUzvBLxyk/FXhrtJ
bFMUlIpLmJVhXZzkW+UBUViMYCFpn86oM2ZEZxbIAiBs4wpp/sREvtyfYZdz6Rql
2rhxzff1F9qffXUQD5sp2cGXzQi42Q==
=kKGw
-----END PGP SIGNATURE-----

--IYRyfZeHt6qtxfs6Nddav8M2pmOqvAY4Y--
