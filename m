Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 264B4115D02
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 15:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLGOLR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 09:11:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:45873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfLGOLR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 09:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575727861;
        bh=SdQQxOfubhmy6N5W4BcdnK15YDNQJz5a/w2txJfe9Ns=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FPfUAuwcNzlscrybOMsV1A9v0d0S5yGDjB3tpPM166VHVL4vzT2vDXlGBc8JTpe6G
         mZiAiGZwIuG3DORdPRut/QqceeowWQC6Lc4KZHt7My4eeIadDFeauQvz7GLNPcghep
         PrV9KzJow5MT8RNMXZjbCFokg+j56UGd6rCMac/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTAFh-1iBJbJ3oNj-00UWqM; Sat, 07
 Dec 2019 15:11:01 +0100
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <BF872461-4D5F-4125-85E6-719A42F5BD0F@icloud.com>
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
Message-ID: <e8b667ab-6b71-7cd8-632a-5483ec4386d8@gmx.com>
Date:   Sat, 7 Dec 2019 22:10:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <BF872461-4D5F-4125-85E6-719A42F5BD0F@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g6UWPhebb76VKhxmhLWBybLz6X2VfpFPt"
X-Provags-ID: V03:K1:2m1CWwFs+FZZgFs/IKV8WQJbSWoZNIodKpXiFB8t/8l4NA0IhWd
 5j9zO5fZxje9YPLi3EKZ5yQq3R3brjVFq6ZQ9c3qvTK7Ex2MV7qBTWgfutpJ4L88tI3Fd4+
 qSk2M3SByTbPmfkyc/rsIZfiJbv6eJeGPH5lyBxy4ftm0k4RXrhmTivKTZbgAtsYRQ9yYQ9
 kyGNdA05JDVVpmylubIqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sYhDOsVe8i8=:1YMRq3YpiaQmW42dWHnFCL
 q8UnRC2bryJMYZTNuU7NCs9MbD0nJp4pK9vGGAWokbMWrhNUOItgcuEzJenkyp5q4qlzc3/lK
 AwJMfRDrr3QOv9VMGDU47QDbwAERbPmGLvCu7bR0AArgCeszUl6CeJlhDq/GDQiHC4ov8a6y9
 FOMiQo9UPWPkjSRudcI+NeUeQbwtrg3lYJ6UgIuCMfBn65mf0CxolQfMCruJKivNEneXNVO2G
 nnI+HdmT4KErfuK2hoLMwmSqqaT/KxlLoKrU8M2OBfITuYJJN0qfPoikjzuRRNxHTG0ih6/mG
 mjBTe7eV50ZPWr6GEWaDjRAonpfCp5iSDAnjPUsJwO6+wdJmBECysns/NDwArHGZv4k0sjUdG
 OwXmZvL0fV/H0cFTgnKMo+1XTUu2MgA1mS9+VCCoaH6qH8UwBvZB0BoFbhh6ry2Ve8q2me7zI
 qEJmmbri55abHpPiGET85b1AKOJXN0xY329TKJ6QNDYuAD4sAmxQJKTZ7hZS0ETfRy0HzxTdr
 BGAoUVdiueTJ0nMH+z5I1+YzX1W06pbZ7IWZejvWaDu+VfmGvQqjT/gcF9/VtqJ/wXsD3aQ0K
 6Q3aawyU/wB7txO1ne8ZlPYFUitiFU/9eTcPwXXuXcDpkbHb8JmOMC9nueQJyRaUH8vkHycPO
 3y95YcTqs1h9l3Cbb+L9cN01zrEhSZTWdGIztv/wff/8PyK4ocSOoP7gs8Wju0rN/x0YTRd63
 4519nkHZuKJ690eHLWc+DS5/IsQtA0kYXOtf+dj7zDDvCuaFdSw5DCJyUKVDqK/0YEW8YzIAK
 anF8LE6HWwI0GOj9hBRYoh4d6iXfOt5OAuZaXiCQk5Vut/enG8IpCsbfFqyhw1/dRBTkV3fmT
 Fr9iebT37+JswKM3P0kb4jDaOFvaumqY9tJ2H8bKjm8sNYge4oDGaWtIC+Cdz33CZx5Op9oTn
 IKFablbPLSVzuVptFwOotC2zLXO++YUTtP/XyAOsQLLyOmxi6dsccic1Fza8MEHyWFlTumTeZ
 oZCDtQZtk03N4QsWPEoc237T/nCbZTRokGjI1VOFU/UqZkr7+CRXGz/QtLCRxk5SvNZEg0/eX
 T6sFxjqECaLPyl+1FO5tt+KjBV6XjrgZdNZ94Mcs2M1WpN4YZpVke1/CF8lIHnfe215dNZwHW
 HPfv5m4ZNBtO0oB25OweHfZ90Mq73MyFqkk/40uKNrbK8iDFIoB2kHShiviQZo3iXsgy2PnjF
 h4RotOtBCNSj5IMI42Z1xNQ1COiQjKM6LMkUr0dI2qyLKiwzHmJiN2Uacwmw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g6UWPhebb76VKhxmhLWBybLz6X2VfpFPt
Content-Type: multipart/mixed; boundary="mPwA7hb2ATwzZiIbGFbc5oOvbm6WkFozE"

--mPwA7hb2ATwzZiIbGFbc5oOvbm6WkFozE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/7 =E4=B8=8B=E5=8D=889:03, Christian Wimmer wrote:
> Sorry for the repeated post, I am trying to pass the mail server...
>=20
> Hi Qui,=20
>=20
> I tried what you said and I got at least some very small files out of t=
he device!
>=20
> Yes, I have sub volumes/snapshots.
>=20
> There should be a subvolume called =E2=80=9Cprojects=E2=80=9D which I a=
m interested in.
> Inside this subvolume should be lots of snapshots.
>=20
> Any chance to recover one of them?
>=20
> Here the output of the restore command that you suggested:
>=20
> # ./btrfs restore -l /dev/sdb1=20
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, ha=
ve=3D14275350892879035392
> WARNING: could not setup device tree, skipping it
>  tree key (EXTENT_TREE ROOT_ITEM 0) 641515520 level 2
>  tree key (DEV_TREE ROOT_ITEM 0) 5349895454720 level 1
>  tree key (FS_TREE ROOT_ITEM 0) 653901824 level 1
>  tree key (CSUM_TREE ROOT_ITEM 0) 658161664 level 3
>  tree key (UUID_TREE ROOT_ITEM 0) 657014784 level 0
>  tree key (315 ROOT_ITEM 0) 637386752 level 1
> checksum verify failed on 3542131507200 found 0000008C wanted 00000000
> checksum verify failed on 3542131507200 found 000000F5 wanted 00000000
> checksum verify failed on 3542131507200 found 0000008C wanted 00000000
> bad tree block 3542131507200, bytenr mismatch, want=3D3542131507200, ha=
ve=3D14275350892879035392
>=20
> And I tried:
>=20
> # ./btrfs restore -r 315 -v -D /dev/sdb1 test/
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
> bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, ha=
ve=3D14275350892879035392
> WARNING: could not setup device tree, skipping it
> This is a dry-run, no files are going to be restored
> Restoring test/1
> Skipping snapshot snapshot
> Skipping existing file test/1/info.xml
> If you wish to overwrite use -o
> Done searching /1
> Restoring test/4
> Skipping snapshot snapshot
> Skipping existing file test/4/info.xml
> Done searching /4
> Restoring test/28
> Skipping snapshot snapshot
> Skipping existing file test/28/info.xml
> Done searching /28
> Restoring test/52
> checksum verify failed on 3305202188288 found 0000009E wanted FFFFFFA9
> checksum verify failed on 3305202188288 found 000000FA wanted 00000000
> checksum verify failed on 3305202188288 found 0000009E wanted FFFFFFA9
> bad tree block 3305202188288, bytenr mismatch, want=3D3305202188288, ha=
ve=3D18446556327804403584
> Error reading subvolume test/52/snapshot: 18446744073709551611
> Error searching test/52/snapshot
>=20
>=20
> Well, I got the very small files info.xml.
> How can I get the rest? Any ideas?

I'm afraid there are too many corruptions in your filesystem.

=46rom root tree to fs tree, all had corruptions.
Thus really hard to get recovered.

Just curious, how this happened? Btrfs itself shouldn't cause so many
random corruptions. Looks more like a hardware problem or random wipe.

Thanks,
Qu

>=20
> Thanks a lot for your help,
>=20
>=20
>=20
> Chris
>=20
>=20
>=20


--mPwA7hb2ATwzZiIbGFbc5oOvbm6WkFozE--

--g6UWPhebb76VKhxmhLWBybLz6X2VfpFPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3rsu0ACgkQwj2R86El
/qh/sgf+O8Si5pO1XArsdkft2PjRBWysw2OhAkVcYybdc+MMj2lwHN2eTpcir/nl
UmpPN9wxX6w0KUVYh817BiaiaAdmt4Uyn0uQTUGQ+mEiFt4H57TvIvkE9eA4n94O
i07B8i4l6oYx1weJ1qVPFQU6LiwzI+FFqhnE2xuKjQqwP2FlIOwmgunOpmGLRsPo
c2oZPyo0xqvj7Iqd3bmwjnZbutmQaNnuFUJspW9jpYzpGpDREBxmXUji3HxIdGHC
PGcHpwLx35Z2oXHk15fcdBu2SSp7B1DJlNc9eK8DYu3fCDunyWbxKYh4+l42B3QD
gkL4DJBppnoP/nPsfqYqWKuJpieAeg==
=ppHJ
-----END PGP SIGNATURE-----

--g6UWPhebb76VKhxmhLWBybLz6X2VfpFPt--
