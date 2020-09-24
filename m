Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655C4277C3D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 01:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIXXO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 19:14:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:60713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgIXXO3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 19:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600989259;
        bh=pv47lmYEzJzivhusP2FEoUULHZ/cr9Vw3avxO/rPBQ4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LwEZBR0rIpHbHm4rY6N6xtcypWFQgBkrhMZI1DEDscjcIzpiJmh5WgtHYLKWPVJoA
         jszspr9Xz5CuhRI5LhCJ7Hhr1ujHvN3dqD6ip8yvCx3crpEbFT6ARggwrzirNvN5gM
         uy0q2YFRfb0KmsbEqalmVp3GK4MdEQjLDIqBotMI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNswE-1k6GTy1Gfo-00OF9W; Fri, 25
 Sep 2020 01:14:19 +0200
Subject: Re: Drive won't mount, please help
To:     J J <j333111@icloud.com>, linux-btrfs@vger.kernel.org
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
 <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com>
 <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
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
Message-ID: <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com>
Date:   Fri, 25 Sep 2020 07:14:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pcK4UcJR4MZ4hXr2vMR2mjYzDX8ablCzI"
X-Provags-ID: V03:K1:IgvuPJKEvEOfgisIDfOOP7NV+mQOWN5sQfY0TeY9pg3Avm14Rwd
 QFH8du8k+pq7iD5tUt+VAzBiIPpip8vL5Upvas/ATko75JfvHKiLvsyPDulVYpNDnOlT+bx
 L7W+MsakNwRxaoxzt2c1TekzsniL2tUcoChllArk+B73oe2feQvvV+J4N0WjTIHqkFUghrH
 uE09HSTWkUMvvyxEYH0AA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kc0vnpjqwvg=:0iDKSpG0cQWyFixAzK+quE
 xsjdKkuOGK6fA1p+Zr4GfYj4sFjpkt6SjCf0EJH/TVnUEO+g+DdulJC0LiZstYJhXFnl1Uh52
 vpPBi4M9RHBdnvg2x+Zg4RJzggEbrI8wXR0HRLi+0XPIN+J09ImXUKNR6UsWK5VQD5p6+eojZ
 Jn+L/qhC9RrEknZotri/G17YXnYqgy7xilDRG4hPP+5LTQuQgOyDjl5ySTqbRxBqgtQrECsQv
 wBscyxtHhz2lPItAEk1j6fDTYnMHptBVIABJDnb2+fTbnsKDDtv/RKlrivniRRM7D8FskAi6B
 MMgoVWTHIAltdMjW0q1mApDDBCViKVNmK91IQ6AJJpmRGIdJJ/JZXWnLq3orxK9FBEkGOE6RE
 qVo+RipUNfRPmB2jb7GBpcq1zenTnXhEDf3FYtFB9/pb3d7qOy9zPymUCaZU6lM0vVMaEQY/f
 qcICdwGV0HDrwbi2Epfz4jEoo/f9thNTccHIHkuX3NKSqEbM+ugXZXXV2ZXvqUvBkePnYqTIJ
 Md95PDtwetcl+VsOo/KY2dh44Wj5LKNIo8heKAAq8VTaqEYJKsjmm506/aC1kqga23ly+zx5F
 emf2Qa7nGWoaRaMi808H4ITHigBmgon52QN/7l5+Cea6Zcg/wftAkZk9nRHZTDAcgRXUMA8Tg
 MA03zSgUSfK0QYw4aing0wH03wt1t9YgwsxEk3LRVEtdkniL8twVtVisGRdJ78t5dtAH3KEIS
 biuTqxEukVvNDxndEHSckATnAxvpah5z4BfTU0NipBkm1XQxSQZK0Q2KEW6674MMhHVa5GwnS
 q2ltCKu2xuBzVb/2qq3XtI357+gZWWX0DaXX1ia8RGHs/CVgeTCsOX8X194J0y/cqlQ0OS+zQ
 ij2pafNnMZsj838Nqp3f0qXuxjgLljRHsxT5rYCanSEo7KMoAJrzVjNZJJiRYPR4D1qGq8BTl
 MxBuK77Wrj1D87Sq9GuJj+lIGnxfP9mvxZVqrMFkfkFqtEN0cW/z3O/o1Pi9yRl2es7wCDLEW
 A5B1/Xem870s0uPZ8UBs5na8mPpi8NZ5a1xuaCZvHcB0nhobLcVrPgqzMfOVRjPhYPozO5V8J
 HtvL2IXLRs04fQeiY5i0y5+GckM/my/9HkSe2JcG2v0A6/VmMvnW9rQ/oGpjiGqxDBQzO5t73
 r14Z868f/33y5JY24h04vMandVM0rJJoiZoPxRVPZRiS8l7PKOq6RdRs8NhZKAzq5ysL+Wh4h
 gw0nWQlfqSa8/EJMo9lwXly9s4izNbOe4e/roEw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pcK4UcJR4MZ4hXr2vMR2mjYzDX8ablCzI
Content-Type: multipart/mixed; boundary="p7b4O9yBDXIqjPyaxWQ3o2ycnJWItswSD"

--p7b4O9yBDXIqjPyaxWQ3o2ycnJWItswSD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/25 =E4=B8=8A=E5=8D=886:28, J J wrote:
> Thanks for your help Qu.
> So is the data lost? Should I follow the procedure to recover what I ca=
n to another disk?
> Any other suggestions for next steps?

btrfs-restore is the normally the tool you need to salvage your data.

Thanks,
Qu
>=20
>> On Sep 14, 2020, at 4:34 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:=

>>
>>
>>
>> On 2020/9/14 =E4=B8=8A=E5=8D=884:56, J J wrote:
>>> I=E2=80=99m new to a lot of this, just trying to use a NAS at home, s=
ingle usb external disk, not RAID. Was working great for a few months, I=E2=
=80=99m not sure what changed today when it stopped mounting. Any advice =
appreciated.
>>
>> Transid mismatch, and the expected transid is newer than the on-disk
>> transid.
>>
>> This means, either btrfs has some bug that causes metadata writeback n=
ot
>> following COW, or the disk controller/disk itself ignores Flush/FUA
>> commands.
>>
>> Considering it's usb external disk, I doubt the later case.
>>
>> In that case, any fs would experience similar problem if a sudden powe=
r
>> loss or cable loss happened.
>>
>> You may workaround such problem by disabling the writecache, but I dou=
bt
>> if the USB->Sata convert would follow the request.
>>
>> Thanks,
>> Qu
>>>
>>> Dmesg log attached
>>>
>>>
>>> uname -a
>>> Linux rock64 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 #1 SMP Wed Au=
g 28 08:59:34 UTC 2019 aarch64 GNU/Linux
>>>
>>>
>>>
>>> btrfs --version
>>> btrfs-progs v4.7.3
>>>
>>>
>>>
>>> btrfs fi show
>>> Label: '3TBRock64'  uuid: 71eda2e3-384c-4868-b5d4-683f222865e6
>>> 	Total devices 1 FS bytes used 2.48TiB
>>> 	devid    1 size 2.73TiB used 2.59TiB path /dev/mapper/sda-crypt
>>>
>>>
>>> btrfs fi df /dev/mapper/sda-crypt
>>> ERROR: not a btrfs filesystem: /dev/mapper/sda-crypt
>>>
>>>
>>> btrfs inspect-internal dump-super /dev/mapper/sda-crypt=20
>>> superblock: bytenr=3D65536, device=3D/dev/mapper/sda-crypt
>>> ---------------------------------------------------------
>>> csum_type		0 (crc32c)
>>> csum_size		4
>>> csum			0x9e8b0c33 [match]
>>> bytenr			65536
>>> flags			0x1
>>> 			( WRITTEN )
>>> magic			_BHRfS_M [match]
>>> fsid			71eda2e3-384c-4868-b5d4-683f222865e6
>>> label			3TBRock64
>>> generation		395886
>>> root			2638934654976
>>> sys_array_size		129
>>> chunk_root_generation	377485
>>> root_level		1
>>> chunk_root		20971520
>>> chunk_root_level	1
>>> log_root		2638952366080
>>> log_root_transid	0
>>> log_root_level		0
>>> total_bytes		3000556847104
>>> bytes_used		2729422221312
>>> sectorsize		4096
>>> nodesize		16384
>>> leafsize		16384
>>> stripesize		4096
>>> root_dir		6
>>> num_devices		1
>>> compat_flags		0x0
>>> compat_ro_flags		0x0
>>> incompat_flags		0x161
>>> 			( MIXED_BACKREF |
>>> 			  BIG_METADATA |
>>> 			  EXTENDED_IREF |
>>> 			  SKINNY_METADATA )
>>> cache_generation	395886
>>> uuid_tree_generation	395886
>>> dev_item.uuid		b7f4386a-18e0-437b-9588-6064ff483fd5
>>> dev_item.fsid		71eda2e3-384c-4868-b5d4-683f222865e6 [match]
>>> dev_item.type		0
>>> dev_item.total_bytes	3000556847104
>>> dev_item.bytes_used	2843293515776
>>> dev_item.io_align	4096
>>> dev_item.io_width	4096
>>> dev_item.sector_size	4096
>>> dev_item.devid		1
>>> dev_item.dev_group	0
>>> dev_item.seek_speed	0
>>> dev_item.bandwidth	0
>>>
>>>
>>> dev_item.generation	0
>>>
>>
>=20


--p7b4O9yBDXIqjPyaxWQ3o2ycnJWItswSD--

--pcK4UcJR4MZ4hXr2vMR2mjYzDX8ablCzI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9tKEcACgkQwj2R86El
/qjqIwf+MGeBZUl8EEfjki5RVuwb1Ny6BVpuRaTqDxWbZ51rb+Oov5X2WSnB2DEC
92DCkDWvLToerwmZgpGR6jz1UkGr8IOUMvTAtWGYf4f6Q4TSGfhSsudRERUvd6H7
iSYzh79ebmFJ3GhwlEFean2aS63Y+nbWoBDlJLH13IF+1yuY1Qnk9Cqr5X7LB9yX
AxSoRtNYhi/FWC9OXrkzt0EbUvUe/nsZiaYDQiFBUpmjpwmDYWURHcTrDRQwycy5
Xo1J//KyOHAjDtKt0C9wsE4jHETVWSTgCUmIC7sm2bQ11QCknVgp5yvqYBNWOJ4x
5XeaLpFKShQpe3GAyD0Q9Dou4eCx3w==
=3Z+G
-----END PGP SIGNATURE-----

--pcK4UcJR4MZ4hXr2vMR2mjYzDX8ablCzI--
