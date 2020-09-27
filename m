Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1549279D1F
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Sep 2020 02:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgI0ANB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Sep 2020 20:13:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:51297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgI0ANA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Sep 2020 20:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601165572;
        bh=uWmwGQGHPH9GqN1VnFEHfA1k+Z4rN82XQMllrZnXIgQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=A/4ZXyuTDEUkj5d9z3xkmy5gybAS68Mss5pWmwgeJUSELv40JU4mlLmuZlm2R0FIL
         XdQ5YTUDU1/9mR9JaXbCi2jUCNvcT5p+yK99lRI/IBfjdJhhVfWhlFdM1xEAy9EN3G
         ODWH3Lm2AuFTAGukKoK9Vchd+SX2pp23pQ4nu1+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mwwdl-1kf4QB0DRT-00yP06; Sun, 27
 Sep 2020 02:12:52 +0200
Subject: Re: Drive won't mount, please help
To:     J J <j333111@icloud.com>, linux-btrfs@vger.kernel.org
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
 <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com>
 <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
 <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com>
 <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com>
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
Message-ID: <1e6b7138-ad05-35d4-77e1-0239356b4542@gmx.com>
Date:   Sun, 27 Sep 2020 08:12:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hROzGGUsSJA7epilPl3GSlzhbaCy8SAeo"
X-Provags-ID: V03:K1:BYju2eQbQIwbfsylJn38Vg0SNuvViLXkVRj20h+pwymSR+alhJg
 xXWWxelZRu/OVHf//azB7bfJbK87LYPoowPAvMaiICilAveg1QI39H4F0V9XLNVYwgYncp9
 iTuuioMznxlBcbybhn6PqRoitn9cu4256tXes+w1ViIqTG8FKpH6qXZNrJjKdB5tfgbE+7r
 iftDSNGRYZr5H9CutNLrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O0lyTOi0H8g=:Id2RXegNXWkGhxUzoz/9TT
 3vrt9Bi/91dIkTvWzalpRGFMUKUjSg+prJ4I9xIL2T239jDTm8a5WSdLDeHba5qC9mEPhf+bY
 /6l7vvHFZQaxs3PiJ4OP+5NCS6h1oRRn8tDu6E7rfQT/PTevGpohcLrlj/DiT8TXYRDYImJyM
 hhCd0eYwir9QTm1NvnqR3rgXh2W9VkRsb3yZu5PKgMvAFEen3S26OcTe1FcEVDybTudfjujkW
 l9/YVdN95hcuaJsYZM+d53K3GDuu5aEa9DJjHDZN6qnPW3JlCXQc5y5iz5yFJXfmPPogrVuwG
 57vBE/FJIMqpgjOqb8wBtpqjNUhrJUGQKJv/WsMMXbb3WzV1sSYZIB43xy7Uz20VKFdMcufsG
 Zd7S9Ly5nc6qWIfmFUqel1PgWoN51xSla/Iup9hBLpuWBmucq3Rg7WV3IPxc9GB+D+X2RFRrW
 kHXMR/W3aU6TVclGi+foH36X5roa9A008M8SDyXppMzAP6U3JHylE6pZEIwVM5VIIaeLg9FkL
 +rEDJk2WXr+oPuMVYBbyBSviROMyc/QqJ98D7F92RuDnOfpCnCJlMsWbT9an+z3tALXHaTyIk
 mOMOkxFbb6fQgLmj1hzL8OBn9pWdld0WEnGvp6rASY9twXjosG31rsD3FS2mNF033yn3985PM
 tH08AzoQwrLYbgXrYSuPnOFqsjwwH+mbq8cxkwcav7GkcwYUdPJ6EP31epRvHgxUF38Q1j8uo
 se79iYDdj/5os2mTty3fwyOwLkMlRbZUiUut9ThylH8WZEFdu/KXkFDrhIFm/QAZuoaGKRYn3
 2D16ZHfuAFQ/qa8v+yiYeGBHM6umyWDb+kKSou0Oy0uWdiX8neG8pfnc9b/tqXh9zqoOtXiaT
 bi9XogHlW+l7pMkhh4kVo3LVJirH4WuqE+rouJdtbAzwyFta+VSg5A2nc70LkVeg48GkAv4dm
 3704/xyZ7eL59x0OVtu0e5Sm53ckzan3a+rEyVbWhnwoBs3KPexf9ajStHlMWxOWb/NYZhDlx
 m6ipeLktirkR6uZAYyArrOrmrDXOVcNvBhI4har8yHOm76T8+qot3Vmu+5TpM8aQamFdaYHiK
 glNOdIeCgA0Omud5NS1DvbCFqqsL6ycu6+gN1zDiW69aRvJMYiwk4/mDM216AS0Ufqpg5Ed1x
 ubaW6U5eYq3t1F5WJXYrDCYSjvcTtAg7B+tz7rmcQbALZj0s4DBEPQTp9chQi7b3Ls1rcHSo9
 eaaEoUVqzS27vr7BdHyJ8A78Fts6c0qmKnlAGOA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hROzGGUsSJA7epilPl3GSlzhbaCy8SAeo
Content-Type: multipart/mixed; boundary="7ayZAdnYdCM4nvBaALFT7NeNRRrn2YykA"

--7ayZAdnYdCM4nvBaALFT7NeNRRrn2YykA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/27 =E4=B8=8A=E5=8D=881:27, J J wrote:
> I ran btrfs-restore and recovered some data, but not most, and not the =
most critical. Believe it or not, my other backup drive failed within the=
 same week (different file system, different location), so I=E2=80=99m wo=
rried I lost a lot of data.
>=20
> I'm Following this page https://btrfs.wiki.kernel.org/index.php/Restore=
, is this the best source for information?
>=20
>   find-root command did not help, It showed=20
> 	=E2=80=9CWell block 11516668403712 seems good=E2=80=9D  =20
>  but it didn=E2=80=99t show any of the Generation lines to choose from.=


In your case, find root won't really help, since it's transid error.

It now mostly depends on pure luck to get some data back.

>=20
> Any reason to disable the write cache now? Or did you mean for future w=
orkaround?

Disabling write cache is for the future.

If it's really the hard disks' problem (especially if both corrupted
drives are the same batch), then it could prevent future problems, not
only for btrfs, but also other fses.

Since the FUA/FLUSH problem is really the core mechanism for all fses to
survive sudden powerloss.

And, if you're not using the same batch of disks, but same RAID
card/controller, then it can be the problem of the RAID card too.
Then I'm not sure disabling write-cache would work for RAID card, but at
least we can try...

>=20
> Will btrfs-zero-log help?

No. zero-log only works if the fs is still fine, but only log tree is
corrupted.

In your case, your fs is already corrupted, nothing to do with log tree.

>=20
> How about these?
> 	=E2=80=A2 -s: Also restore snapshots. Without this option snapshots wi=
ll not be restored.
> 	=E2=80=A2 -x: Get extended attributes. Without this option, extented a=
ttributes will not be retrieved.
> 	=E2=80=A2 -m: Restore metadata: owner, mode and times.
>=20
> Should I move on to this advice? from https://ownyourbits.com/2019/03/0=
3/how-to-recover-a-btrfs-partition/
>=20
> 		If we are still not able to mount normally, we can now run btrfs resc=
ue super-recover, which will try to restore the superblock from a good co=
py. This is not completely safe.
>=20
> 		As mentioned before, if your metadata was corrupt there is a chance t=
hat files or part of files that are not damaged are not seen by the files=
ystem. In this scenario, we can use btrfs rescue chunk-recover /dev/sdXY =
to scan the whole drive contents and try to rebuild the metadata trees. T=
his will take very long specially for big drives, and could result in som=
e of the data being wrongly restored.

I don't think any of them would help in your case.

Your super blocks are all fine. Thus super-recover won't work.
The problems are the tree blocks, and a lot of your tree blocks write
didn't reach disk properly.

We may enhance btrfs-restore to do full disk scan to try to grab some
valid tree blocks, but that would be a big work in the far future.
Not something can benefit you right now.


So if current btrfs-restore doesn't work well, I'm afraid you really
lost the critical data.
The only thing we can help is to find some potential causes to prevent
such problem from happening again.

Thanks,
Qu

>=20
> Thank you for your time!!
>=20
>> On Sep 24, 2020, at 7:14 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:=

>>
>>
>>
>> On 2020/9/25 =E4=B8=8A=E5=8D=886:28, J J wrote:
>>> Thanks for your help Qu.
>>> So is the data lost? Should I follow the procedure to recover what I =
can to another disk?
>>> Any other suggestions for next steps?
>>
>> btrfs-restore is the normally the tool you need to salvage your data.
>>
>> Thanks,
>> Qu
>>>
>>>> On Sep 14, 2020, at 4:34 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>>
>>>>
>>>>
>>>> On 2020/9/14 =E4=B8=8A=E5=8D=884:56, J J wrote:
>>>>> I=E2=80=99m new to a lot of this, just trying to use a NAS at home,=
 single usb external disk, not RAID. Was working great for a few months, =
I=E2=80=99m not sure what changed today when it stopped mounting. Any adv=
ice appreciated.
>>>>
>>>> Transid mismatch, and the expected transid is newer than the on-disk=

>>>> transid.
>>>>
>>>> This means, either btrfs has some bug that causes metadata writeback=
 not
>>>> following COW, or the disk controller/disk itself ignores Flush/FUA
>>>> commands.
>>>>
>>>> Considering it's usb external disk, I doubt the later case.
>>>>
>>>> In that case, any fs would experience similar problem if a sudden po=
wer
>>>> loss or cable loss happened.
>>>>
>>>> You may workaround such problem by disabling the writecache, but I d=
oubt
>>>> if the USB->Sata convert would follow the request.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Dmesg log attached
>>>>>
>>>>>
>>>>> uname -a
>>>>> Linux rock64 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 #1 SMP Wed =
Aug 28 08:59:34 UTC 2019 aarch64 GNU/Linux
>>>>>
>>>>>
>>>>>
>>>>> btrfs --version
>>>>> btrfs-progs v4.7.3
>>>>>
>>>>>
>>>>>
>>>>> btrfs fi show
>>>>> Label: '3TBRock64'  uuid: 71eda2e3-384c-4868-b5d4-683f222865e6
>>>>> 	Total devices 1 FS bytes used 2.48TiB
>>>>> 	devid    1 size 2.73TiB used 2.59TiB path /dev/mapper/sda-crypt
>>>>>
>>>>>
>>>>> btrfs fi df /dev/mapper/sda-crypt
>>>>> ERROR: not a btrfs filesystem: /dev/mapper/sda-crypt
>>>>>
>>>>>
>>>>> btrfs inspect-internal dump-super /dev/mapper/sda-crypt=20
>>>>> superblock: bytenr=3D65536, device=3D/dev/mapper/sda-crypt
>>>>> ---------------------------------------------------------
>>>>> csum_type		0 (crc32c)
>>>>> csum_size		4
>>>>> csum			0x9e8b0c33 [match]
>>>>> bytenr			65536
>>>>> flags			0x1
>>>>> 			( WRITTEN )
>>>>> magic			_BHRfS_M [match]
>>>>> fsid			71eda2e3-384c-4868-b5d4-683f222865e6
>>>>> label			3TBRock64
>>>>> generation		395886
>>>>> root			2638934654976
>>>>> sys_array_size		129
>>>>> chunk_root_generation	377485
>>>>> root_level		1
>>>>> chunk_root		20971520
>>>>> chunk_root_level	1
>>>>> log_root		2638952366080
>>>>> log_root_transid	0
>>>>> log_root_level		0
>>>>> total_bytes		3000556847104
>>>>> bytes_used		2729422221312
>>>>> sectorsize		4096
>>>>> nodesize		16384
>>>>> leafsize		16384
>>>>> stripesize		4096
>>>>> root_dir		6
>>>>> num_devices		1
>>>>> compat_flags		0x0
>>>>> compat_ro_flags		0x0
>>>>> incompat_flags		0x161
>>>>> 			( MIXED_BACKREF |
>>>>> 			  BIG_METADATA |
>>>>> 			  EXTENDED_IREF |
>>>>> 			  SKINNY_METADATA )
>>>>> cache_generation	395886
>>>>> uuid_tree_generation	395886
>>>>> dev_item.uuid		b7f4386a-18e0-437b-9588-6064ff483fd5
>>>>> dev_item.fsid		71eda2e3-384c-4868-b5d4-683f222865e6 [match]
>>>>> dev_item.type		0
>>>>> dev_item.total_bytes	3000556847104
>>>>> dev_item.bytes_used	2843293515776
>>>>> dev_item.io_align	4096
>>>>> dev_item.io_width	4096
>>>>> dev_item.sector_size	4096
>>>>> dev_item.devid		1
>>>>> dev_item.dev_group	0
>>>>> dev_item.seek_speed	0
>>>>> dev_item.bandwidth	0
>>>>>
>>>>>
>>>>> dev_item.generation	0
>>>>>
>>>>
>>>
>>
>=20


--7ayZAdnYdCM4nvBaALFT7NeNRRrn2YykA--

--hROzGGUsSJA7epilPl3GSlzhbaCy8SAeo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9v2QEACgkQwj2R86El
/qhR4Af/eOd0v3WvVdIaYSdR++fR4Wu8WEq0R9U9xfNmDcwlUaOnv5k+aTKOsESj
WlRMi3mkzGOVcFO9lRMDfHSzYgb0R/n/VDKBlO8VKTpzNLAHi6GECbmcZf4Wzjef
tlRDEYmhdzaZlKKJZzSK2354WBWQCRb8SfDW08W/740cj3RZXFBtO7LI7Vk8uJUi
REbdNhDco4A0oxWUFOOPhfqmgjtfb4ebypcHFNbpmGAddVjtF9Ikz6klZahEyTlF
eF0WzHSphOo8yaXiUxVyBUXlpvExX6M6VIDAtv+PH4ehV2giu3IShKFkEECV4yvm
5BGU5A579GBFGVVtuHKGsRFyFEJHQg==
=CAo5
-----END PGP SIGNATURE-----

--hROzGGUsSJA7epilPl3GSlzhbaCy8SAeo--
