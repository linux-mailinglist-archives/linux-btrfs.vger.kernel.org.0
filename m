Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4991495F5
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 14:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAYNgr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 08:36:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:33335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYNgr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 08:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579959406;
        bh=FoVlQZhRhgP+IZ3SBDx1/w6XDQYU+Cq8K0lnWA1hHxo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lkbtBB2TYGunya9b/TK2P2CH8IF/ktBX21y1NjEvc1d+QdEGDEllVxRZZ6V6Z6gdN
         zMjry0scFB18O1JtBy3lXIC6UhPTEDkgesOFe3ZVr8mjm1nbzhanbehXn/PhnwZoPa
         /Z41MTrHngseFMxoNBQ/7JnBHONhNYwy2FV4t23M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbAcs-1jSUZZ2Ep6-00bXYv; Sat, 25
 Jan 2020 14:36:46 +0100
Subject: Re: Broken Filesystem
To:     Hendrik Friedel <hendrik@friedels.name>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <em16e3d03d-97be-4ddb-b4a4-6a056b469f20@ryzen>
 <887af814-cec5-494f-80b3-4c2e286dc1b1@gmx.com>
 <emeee471c5-e6f0-4503-8410-742b05f87305@ryzen>
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
Message-ID: <48707dcb-ed54-87bc-00a1-0885f8167fd7@gmx.com>
Date:   Sat, 25 Jan 2020 21:36:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <emeee471c5-e6f0-4503-8410-742b05f87305@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="371iT2DJAb08qcpFLQ92oKvrZTjH99sBC"
X-Provags-ID: V03:K1:nC7T9QhCISXCWeZXb9g3OmPMZdpwWTxXZzmeQEpFprOFpM2jCJW
 dPPguvQHeQVTQxIYjFBI33AV6VDbCi9qbq0OcVE8ZUkv/x08ZqIPIFMdaqZ5LPOEleJsSzZ
 R4SxTb+ad+7oKmrpoHf+0KT5eIkg93FjOcd2Gu2tow5279609PUOpl97iWVLsffnqlSWw1U
 kggoWYv0CQuK6Jo73fJ2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2+mW4bUqk7g=:WUhXbRuVYQ8bBe0Rbtd7hO
 PkkwRtqLhcN+TPXwq3GYHBle34XOR0cN0Q/i2oisxHYuercVPGy1SVh3FUkWt8tZTHnS1emfT
 dPFCnpdGfFMHpmSX90Speb9JW4QkWnqG73m1Vd2gM64/45w8/em109NFL/OKrce84EsBaWrEQ
 D4C+XAyC+kfQUEWnG63ToCwPhVp/Qmu83ZZG7KLoRJNaPcH1wiN7eEom6LNc0k33H8+IS99uI
 zXTnNVTCzUg3AsoR5sbCi/cmwDZlyvm7gnZnRyCRZf9s7OmmHH94OgeHRALCzk0PhBmtjWy7S
 YLBtBKiBTf66lg9F4LUD+l/F+05iyxtvCAUPUncbrQpo4MLSZM+c3KNWBvUjju72PD3XGvqIb
 jZcQXP7AvTAOrZRT+siqHjK86vvgfB419yZFg3Y/4uiXmFkOcfLwlSJ7c42v7OWQzf/ETFA3P
 eIe8dEiE/5+wQWPMZwBna7Ma3E+rFJC+d/u0kywZQ7aNU4jbN4hLV5NHDfWHLxwEGkVVbh7I6
 9S/g6TZSbzSVU2ilnSp6C926I26/QeI/688trern4XlfIiNV4hcsU9Fh8iNyyoAZ4QrPDtni7
 2138PhufC1DfOZT2wBDokfXubYU/0eZyOIoOCs7QnyfXpv/CIhUHbQs+rA4haHAqVWC+vrG5x
 sJDL2E4mF+BxnmIN3ZoNbFMeBsf/NHa12xPUUTKBJ4T0EoLASS4jAty55cJtkr3rrseOitEJV
 z4OaAZUTfUYiIKVfVEQQKF82dHfUOGX1LXzbcwKULh6W+mtjMb1ck84Dsjpdp9HT/Cf+pkJig
 E8eaSiw7WMvFi3CF251hwJMXtvjkVvR+mXMm5qbVzaHZtKCVx50rbnbSynmkZD21SZm1pgnDe
 nYDMPmgoc5/XxzE+Rkq7r/+UzVLAiKTmWoTDb2DhcrxP6VGQzgS7iA2ad+quY7+uLkiVE8aLc
 lwfn/eH5/C341mfRQutRR+lJRHMbydidmU+jC+6ftexRAMJuh0JMesgOQavI7317sPCL7xY6T
 gdcpU18CGgwWwqqiYKI3IRRlBYONJtTZ9QPDXwpDbDybZ9mdRSaYlUPdr5TsZAyxAgyeao1+Q
 QcPocz2Db2CuRaATTcyKcXI2RbgbdzXMuUf0BifDClnmwXwU2bHiPPsvKKCI/NFQsuk8o7JWa
 oj4TijgfoLnfd1Cl8Veq890cq5uUv8wl8HTAFiw3eAroqx+KQmCXEAx4GCKwPb5KV9q/d0tCk
 JY4l1a3XQoC0lrgTM
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--371iT2DJAb08qcpFLQ92oKvrZTjH99sBC
Content-Type: multipart/mixed; boundary="ei4ebjW0UPBvMqJlvZAFOFYOUXnWvrQLJ"

--ei4ebjW0UPBvMqJlvZAFOFYOUXnWvrQLJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/25 =E4=B8=8B=E5=8D=889:32, Hendrik Friedel wrote:
> Hello,
>=20
> thanks for your reply.
> The problem is, that no data is shown after mounting. Furthermore=C2=A0=

> devid 1 size 931.51GiB used 4.10GiB path /dev/sda
> The disk was almost full. Now 4.1GiB seem to be used only.

Then it looks like related subvolumes get deleted.

Without some exotic method like `btrfs-find-root` there is no way to
locate deleted subvolume data.

Thanks,
Qu

>=20
> Greetings,
> Hendrik
>=20
> ------ Originalnachricht ------
> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com=
>>
> An: "Hendrik Friedel" <hendrik@friedels.name
> <mailto:hendrik@friedels.name>>; "Btrfs BTRFS"
> <linux-btrfs@vger.kernel.org <mailto:linux-btrfs@vger.kernel.org>>
> Gesendet: 25.01.2020 13:20:14
> Betreff: Re: Broken Filesystem
>=20
>> =C2=A0
>> =C2=A0
>> On 2020/1/25 =E4=B8=8B=E5=8D=887:34, Hendrik Friedel wrote:
>>> Hello,
>>> =C2=A0
>>> I am helping someone here
>>> https://forum.openmediavault.org/index.php/Thread/29290-Harddrive-Fai=
lure-and-Data-Recovery/?postID=3D226502#post226502
>>> =C2=A0to recover his data.
>>> He is new to linux.
>>> =C2=A0
>>> Two of his drives have a hardware problem.
>>> btrfs filesystem show /dev/sda
>>> Label: 'sdadisk1' uuid: fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
>>> Total devices 1 FS bytes used 128.00KiB
>>> devid 1 size 931.51GiB used 4.10GiB path /dev/sda
>>> =C2=A0
>>> The 4.1GiB are way less than what was used.
>>> =C2=A0
>>> =C2=A0
>>> We tried to mount with mount -t btrfs -o
>>> recovery,nospace_cache,clear_cache
>>> =C2=A0
>>> [Sat Jan 18 11:40:29 2020] BTRFS warning (device sda): 'recovery' is
>>> deprecated, use 'usebackuproot' instead
>>> [Sat Jan 18 11:40:29 2020] BTRFS info (device sda): trying to use bac=
kup
>>> root at mount time
>>> [Sat Jan 18 11:40:29 2020] BTRFS info (device sda): disabling disk sp=
ace
>>> caching
>>> [Sat Jan 18 11:40:29 2020] BTRFS info (device sda): force clearing of=

>>> disk cache
>>> [Sun Jan 19 11:58:24 2020] BTRFS warning (device sda): 'recovery' is
>>> deprecated, use 'usebackuproot' instead
>>> [Sun Jan 19 11:58:24 2020] BTRFS info (device sda): trying to use bac=
kup
>>> root at mount time
>>> [Sun Jan 19 11:58:24 2020] BTRFS info (device sda): disabling disk sp=
ace
>>> caching
>>> [Sun Jan 19 11:58:24 2020] BTRFS info (device sda): force clearing of=

>>> disk cache
>>> =C2=A0
>>> =C2=A0
>>> The mountpoint does not show any data when mounted
>>> =C2=A0
>>> Scrub did not help:
>>> btrfs scrub start /dev/sda
>>> scrub started on /dev/sda, fsid fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
>>> (pid=3D19881)
>>> =C2=A0
>>> btrfs scrub status /dev/sda
>>> scrub status for fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
>>> scrub started at Sun Jan 19 12:03:35 2020 and finished after 00:00:00=

>>> total bytes scrubbed: 256.00KiB with 0 errors
>>> =C2=A0
>>> =C2=A0
>>> btrfs check /dev/sda
>>> Checking filesystem on /dev/sda
>>> UUID: fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
>>> checking extents
>>> checking free space cache
>>> cache and super generation don't match, space cache will be invalidat=
ed
>>> checking fs roots
>>> checking csums
>>> checking root refs
>>> found 131072 bytes used err is 0
>>> total csum bytes: 0
>>> total tree bytes: 131072
>>> total fs tree bytes: 32768
>>> total extent tree bytes: 16384
>>> btree space waste bytes: 123986
>>> file data blocks allocated: 0
>>> referenced 0
>> =C2=A0
>> Your fs is completely fine. I didn't see anything wrong from your `btr=
fs
>> check` result nor your kernel messages.
>> =C2=A0
>>> =C2=A0
>>> =C2=A0
>>> Also btrfs restore -i -v /dev/sda /srv/dev-disk-by-label-NewDrive2 | =
tee
>>> /restorelog.txt did not help:
>>> It came immediately back with 'Reached the end of the tree searching =
the
>>> directory'
>>> =C2=A0
>>> =C2=A0
>>> btrfs-find-root /dev/sda
>>> Superblock thinks the generation is 8
>>> Superblock thinks the level is 0
>>> It did not finish even in 54 hours
>>> =C2=A0
>>> I am out of ideas. Can you give further advice?
>> =C2=A0
>> Since your fs is OK, what's wrong?
>> =C2=A0
>> Maybe just mounted wrong subvolume?
>> =C2=A0
>> Thanks,
>> Qu
>> =C2=A0
>>> =C2=A0
>>> Regards,
>>> Hendrik
>>> =C2=A0
>> =C2=A0


--ei4ebjW0UPBvMqJlvZAFOFYOUXnWvrQLJ--

--371iT2DJAb08qcpFLQ92oKvrZTjH99sBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4sRGoACgkQwj2R86El
/qizQAf/S10yVzBhD7Uy1u8yNasTcRAlNmuqcl7/jeswmTHgnkfNbwWl2lxOED18
rBDDSJU9//XefqiG7QiZFV4K1rRndG2dC+3omMQTRW4iUHdhxDs1Ts67esVVixmX
VjW+EgOPlSTAsr6bWEksS4471nyItYb63mOrYXHvDPXn1wTJ08IXe1/vVF4DNt0v
T1SMiewxcDbOv7y3x8C8qLnfcrEw4umcv0XimL3K2i09JUFUCMl20stYpT3FjZVN
X8jl99H+QVRRSjx+Q7D3IlBhXti2TCJg6ArTZ9BaZxwKaEOKxyrICWZxnyONe3d4
jwojRAl1r4T+6LtRuf54GstRRtpZYA==
=wvyl
-----END PGP SIGNATURE-----

--371iT2DJAb08qcpFLQ92oKvrZTjH99sBC--
