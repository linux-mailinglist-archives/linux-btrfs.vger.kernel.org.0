Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E3DDBB8
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 02:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfJTA0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Oct 2019 20:26:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:51521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfJTA0g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Oct 2019 20:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571531187;
        bh=MaqnFYR/17SiUmq9BOMjDR3qFzPBMn/YD0LU1afVMtY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bCLtA+WMUGYbBopCo56pyJA67bwbyGf3g33bNxHg7fNRh0wK8tWf4W7YZIhxuNPe6
         +mRubXDg7ZNpWdcSlyJCk6A7ATlm+j9FMpYz0lW+nUubwJbh5rjW/tz8epkzNCjSdi
         TBI3EBy8wbbRg6jf9Iw2sB2O668TKI79ToS9xIGc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mjj87-1hamWf2031-00l9wY; Sun, 20
 Oct 2019 02:26:27 +0200
Subject: Re: [PATCH 0/3] btrfs-progs: Add check and repair for invalid inode
 generation
To:     Ferry Toth <fntoth@gmail.com>, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190924081120.6283-1-wqu@suse.com>
 <36d45e31-f125-4b21-a68e-428f807180f7@gmail.com>
 <b1c32c4b-734f-0f4e-44d1-cb4ef69b7fe1@suse.com>
 <796be1b6-1f1d-7946-e53e-9b85610c7c65@gmail.com>
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
Message-ID: <c56c880f-22c9-4200-87e5-81e61a1ada0b@gmx.com>
Date:   Sun, 20 Oct 2019 08:26:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <796be1b6-1f1d-7946-e53e-9b85610c7c65@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r9mavPv4nClFlA4ubsdkMcBwD8v92yuPA"
X-Provags-ID: V03:K1:Hig4pD3Bwjub4fR+NAlp6U9atubBOOj0ZonxPLjfcOQI1P59NPz
 1EFto+/YsoOIljuXqagRymYj3iWD3KVtQI2BlM9j6Wk+ulOf1LADXtaXZ2qXLnMepe8etGb
 ZcSeNKqDAjRUdfFAuLgM4t3VJgXmzyHogmnkp36keG/jdY8xzIASFGNWtlKJ2vHOyDxV6k0
 JEY1jK2ptyqpKSL/a2Hig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H0WIl8Y33bw=:MtrCAspOquwyJii/lrtEnV
 F370hX0HrMM1lRWCEbEeE9ESyAnQLJwOdNlA3UvCB5oTw8LoUbpnXYP5oziVDvry7zvesDZQm
 ixIXkRPJoAg8MaoRuen8eQHc9eaaVq3JnyLu9tBfnethpjDVyGZW3hJnGCat/iGyA4QtEjjqs
 ovdJu1Crec8L2fHVIG4ZKQLgdM2QlbA9CrgxsMw4LNWRNt0/ny0oUB4jlZccDz8VDoVeUOg/P
 oI+6Wu5W35J1YkJigLsi2GfqOualHsW0L7Z6RMa3MPZACIzwJJ7JUG/3MWHnSBnkNbP58XSrA
 973v6TvGuN8SUCtGtupOGPZIOrLnCnq2aJWSa6I/isdaR4wVPFo6havVhcDn1G71Z9kmOVBMs
 6cT2o12a6FFfpeX0X1AcquIfjee/SjJRfenEuGwwdPhoJNlFVafRsX/ak4vMdGgIxdg1H+Bz0
 Kx9g+EtdvsDBL8TL57/zaIvij/y9dTdLXjgNrjjKOCk7gAYzOUQV/o6DLeVD5gXTGHhTjm/Nu
 68kX5gBSaTPIyu+WkE+1dbM/rfXh01ItqTC5UWfnUbOOviTxW2Hlnje92+1UzelPdw4l98NH6
 0vVDj0RBKfwFedV7uegF0LJ44rshFO3G9KotIy6lgCsfHAAZZijFKe8qPM6ZNbO6Vho3XaFwd
 KM+2hg/pQ+zMSz9WqITxd8NpAhFAcMc9iUwxbEMEt2xPKUYRenyalB3ipcBT6gT7EEFIIRCSx
 RzVHAH1QApxaEzEAbFwO0YpZMA4i4EtppyMuOE0ldk8fufUf4y+y2h0yoDkJ49gD9IAofiV9Y
 VcwF5LVRM81dX9oKzYnFv2VvDSEAcYvHe2Q0uz+4G/ZULwIjCFyRGydf83vVyqUNxypXRJ5Y/
 ABBOtEj5hVGh1g7i1Hb7RaizQAeFNHlUIBwWzr5b1k7yH9y959u9GFnxgFuUSrprFBWXA2Rh4
 vWwbniVrijxWyO1HH9cb3J7yUOrVrZbmapL2t/gEdjF/NkYUGfvrb/Ep5If7pNOT4045mkO5G
 vx01H4esOjAfQlCIa81bVUreHRP6ioTS39j/jXmPkk2lLaqTBRbW1b1yonaaXYM5sJN9SZn2K
 kA8y4DncyzX+Sab2SPsb1dGZf67d7voS4pMLG4VqMna0QKKbZkPgC9JAnbS3BikeuDyGQvjPh
 F83Gvcln0jO0Vpe+f6WBE2t8FGbKKxtHzCQeygdNzlRnArGcm/5O1axwScxEMfVVDkdAuVo04
 YBsVbZoGHtwYBPwSLYwV1od+5tIjQe93Kg73hnuqYj4G6Rb9ialucTAClxCg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r9mavPv4nClFlA4ubsdkMcBwD8v92yuPA
Content-Type: multipart/mixed; boundary="WXkf17NeRnHK8vneVJvXtWPTijGEdYzfR"

--WXkf17NeRnHK8vneVJvXtWPTijGEdYzfR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/20 =E4=B8=8A=E5=8D=8812:24, Ferry Toth wrote:
> Hi,
>=20
> Op 19-10-2019 om 01:50 schreef Qu WenRuo:
>>
>>
>> On 2019/10/19 =E4=B8=8A=E5=8D=884:32, Ferry Toth wrote:
>>> Op 24-09-2019 om 10:11 schreef Qu Wenruo:
>>>> We have at least two user reports about bad inode generation makes
>>>> kernel reject the fs.
>>>
>>> May I add my report? I just upgraded Ubuntu from 19.04 -> 19.10 so
>>> kernel went from 5.0 -> 5.3 (but I was using 4.15 too).
>>>
>>> Booting 5.3 leaves me in initramfs as I have /boot on @boot and / on =
/@
>>>
>>> In initramfs I can try to mount but get something like
>>> btrfs critical corrupt leaf invalid inode generation open_ctree faile=
d
>>>
>>> Booting old kernel works just as before, no errors.
>>>
>>>> According to the creation time, the inode is created by some 2014
>>>> kernel.
>>>
>>> How do I get the creation time?
>>
>> # btrfs ins dump-tree -b <the bytenr reported by kernel> <your device>=

>=20
> I just went back to the office to reboot to 5.3 and check the creation
> times and found they were 2013 - 2014.
>=20
>>>
>>>> And the generation member of INODE_ITEM is not updated (unlike the
>>>> transid member) so the error persists until latest tree-checker
>>>> detects.
>>>>
>>>> Even the situation can be fixed by reverting back to older kernel an=
d
>>>> copying the offending dir/file to another inode and delete the
>>>> offending
>>>> one, it still should be done by btrfs-progs.
>>>>
>>> How to find the offending dir/file from the command line manually?
>>
>> # find <mount point> -inum <inode number>
>=20
> This works, thanks.
>=20
> But appears unpractical. After fix 2 files and reboot, I found 4 more,
> then 16, then I gave up.
>=20
>> Thanks,
>> Qu
>>
>>>
>>>> This patchset adds such check and repair ability to btrfs-check, wit=
h a
>>>> simple test image.
>>>>
>>>> Qu Wenruo (3):
>>>> =C2=A0=C2=A0=C2=A0 btrfs-progs: check/lowmem: Add check and repair f=
or invalid inode
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation
>>>> =C2=A0=C2=A0=C2=A0 btrfs-progs: check/original: Add check and repair=
 for invalid inode
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation
>>>> =C2=A0=C2=A0=C2=A0 btrfs-progs: fsck-tests: Add test image for inval=
id inode
>>>> generation
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repair
>>>>
>>>> =C2=A0=C2=A0 check/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 50 +++++++++++-
>>>> =C2=A0=C2=A0 check/mode-lowmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 76
>>>> ++++++++++++++++++
>>>> =C2=A0=C2=A0 check/mode-original.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>> =C2=A0=C2=A0 .../.lowmem_repairable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>>> =C2=A0=C2=A0 .../bad_inode_geneartion.img.xz=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin 0 -> 2=
012 bytes
>>>> =C2=A0=C2=A0 5 files changed, 126 insertions(+), 1 deletion(-)
>>>> =C2=A0=C2=A0 create mode 100644
>>>> tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable
>>>> =C2=A0=C2=A0 create mode 100644
>>>> tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.img.x=
z
>>>>
>>>
>=20
> I checked out and built v5.3-rc1 of btrfs-progs. Then ran it on my
> mounted rootfs with linux 5.0 and captured the log (~1800 lines 209
> errors).

It's really not recommended to run btrfs check, especially repair on the
mounted fs, unless it's RO.

A new transaction from kernel can easily screw up the repaired fs.
>=20
> I'm not sure if using the v5.0 kernel and/or checking mounted distorts
> the results? Else I'm going to need a live usb with a v5.3 kernel and
> v5.3 btrfs-progs.
>=20
> If you like I can share the log. Let me know.
>=20
> This issue can potentially cause a lot of grief. Our company server run=
s
> Ubuntu LTS (18.04.02) with a 4.15 kernel on a btrfs boot/rootfs with
> ~100 snapshots. I guess the problematic inodes need to be fixed on each=

> snapshot prior to upgrading to 20.04 LTS (which might be on kernel ~5.6=
)?

Yes.

>=20
> Do I understand correctly that this FTB is caused by more strict
> checking of the fs by the kernel, while the tools to fix the detected
> corruptions are not yet released?

Yes.

Thanks,
Qu


--WXkf17NeRnHK8vneVJvXtWPTijGEdYzfR--

--r9mavPv4nClFlA4ubsdkMcBwD8v92yuPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2rqa4ACgkQwj2R86El
/qg1WQgAk0LtrtSF7csQ2JQ5Q3zhVqfn6OV3p3R2s7BDtSE0R0ByGinLWWY/JShW
/UE1TvFuAAyBij2H5ovYLlrXcfOBUWoWFxGKTpKFvGKU0/nYDjFNsFOXONhgI7sc
IFOQ9vG3OiAaAsLMSU1gfSZMYDqngvwpB7toNbu7Fq7+l3PYuB30La918gspEkfG
z+VdTKJ9oR653fdmsf5wN5CfwceAjnmwwfk6A1tPLxVas4XWKzPjlNtpJEGz8pbh
oDg9nedRLR5IsdaLEfZ3t7XpRRueIUShEjhroClC20JB6wG453wuEk3jWPErQGqz
MgPQQFKafFT5LLh5URl0EBzCWGr71g==
=m9kw
-----END PGP SIGNATURE-----

--r9mavPv4nClFlA4ubsdkMcBwD8v92yuPA--
