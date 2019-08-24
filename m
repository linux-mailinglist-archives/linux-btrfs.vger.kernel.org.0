Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2A9BDF6
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2019 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfHXNYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Aug 2019 09:24:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:47841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfHXNYf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Aug 2019 09:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566653066;
        bh=bEAC7PeNZlzwWQIMHsXEhIxqoMrlKCroAq0/kBWTQAc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XzHDqbCp1h93+jpf8Bdw0NOjT8Bnv9dmwXqjDyf/dVNvT6c17MzY1FhnsEnIFkvpH
         QWsBqflfc/3jSpzDs3+OhfH5J6BMvR2yntSK3wVYKUSlK64X+l7Fkts/IgFSN87onV
         cPOqh2u2gqyXSrM6tWzU8Ip8Uh92QfWgJ7Uo19uk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M5tU1-1iPcWW2XYf-00xqMv; Sat, 24
 Aug 2019 15:24:26 +0200
Subject: Re: Need help: super_total_bytes mismatch with fs_devices
 total_rw_bytes
To:     Patrick Dijkgraaf <bolderbast@duckstad.net>,
        linux-btrfs@vger.kernel.org
References: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
 <211fbb73-6a16-a8a6-e2b3-a0799216fe9c@gmx.com>
 <579f07cdb257e15e9f79f501600ce8033353db91.camel@duckstad.net>
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
Message-ID: <2e471646-7201-f33d-a9c7-ecbe19b73a58@gmx.com>
Date:   Sat, 24 Aug 2019 21:24:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <579f07cdb257e15e9f79f501600ce8033353db91.camel@duckstad.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O4x4XQTjWleQEoSbp6OZ2RvuTUUBFqoXf"
X-Provags-ID: V03:K1:rdMtOEMYqkseynzJAukDfhRoPjJa7p6bcmNmCaMrhV7IObxjl80
 yC8XWQM7FoiPoeci1N7flj/2AUVxZQCboQdlB8T7FAiyO5RKaQCjkaaW5dw5cgq7aAtTmqJ
 SXZiiExQCzDTtwC9kbpb7jStuBmPqfcfr2c9FQXnfRKrVZCowNXeuBl0/1NQSUqXTl9n7Qv
 AmC9fzvU6pF6Y66+elq+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E4ehckCimT4=:jcG0YS0vnQNDNbMSNKzzcI
 n9EHzgtBSX1Ep5XvrKncUZs4dym3olMcjlfsanpGdP+eGySzU1BlS4IQ2RyBvt3FdBNTRuCCk
 LAdgl1ZGpwMbjmD175sgih/5KHs/1mNkOFTXsep1ffjNiS2192iBdsBP/KsSBULH7ZRA7tdlK
 R0GhOEjBTtNf+3L0nldycknIfWJ+oxBW5UFXQQc96KuuyXbca75SuFZurBk6mYcl9Lv3YzUHx
 DkGcNlaLeTKS2Llkrhd1UHd1QFAEVaQd/0fQAeZfsmLKRLI4WQG3rOLU9X1YhDnw7o1trVS6x
 eebOtLwxcg5wygwKw7cC78mHKWW8qv9h7ErYpBZO4R0wFzUYsuEOj2FLj0BFVBXSY1bqc0Osu
 gp9Uo3AbEvW0S9oc05AFRGHrelFZAT967526iMpJJnNVcO+pMH28MLouOR+W0/CX8TR0SZwZ3
 nORFTxfxSdGNZ29V47Pf7gVRSqdVwSyfwRPojnWzm3kmmcpsv+V+bTRl3ZM5oixbrgmbKhp5R
 EKCXITzpmKLjimqUjGN6R70oPb2INJWtcLSj4JCYs1WyjrFmuMsHYOq69xBL4mwv2azz4RRtX
 7hYWwmf3LctZ02xZ/j7ZdeH6NsZLG4JYcxZDZnLpnqRHhh1EkZylCq7/wKtu8eeCBWWVVDonJ
 4+o3ytl0b4NFCL1H/akOOZGDKach24NPFpiI2i70Fyou0y98lbvc/lCRzbOLyvM4RbAReCe0K
 /gyGBYOOUb2lqh5jsfWD29djP43sNIUgj387XSXp9wXztqaaAzqb+we/Iz2s6OUSFOYktIsjG
 WjF/LiTcu0jKRY/nIjh4TZx3/LbkRDeUzZBmaUvu+gPSZ/vteXcpxecvTjAyguaCXf1IPzlYo
 e9Si2TZ0JDVlr839aF728+GxcZ2ADZtWtKLaxyEO4TLdkmCy/tC+gfMkjOG+MSkYE8TGpsqLh
 Z6mLoCXWgKAJakiF5545L/KQAM+dGXhoE0/EQQGLFMkgvlttMzR246FcM39F7ZS0BsDHlUgcp
 Oh748Vuh2VwplQJoqC+cfFC/Bxb0bje/8RgRirYmTQZlHO308U2O1yTSFApwF1Pl+DwtR868z
 u7DlJfuRijDoLRy9Ki1IfeVwulcJVwrZx+ay3hHiWq/+08DFz2c8ABbg0HxdwXDhF+sj1rgqC
 pnTcB8PsXlMW2IeFlesSo+ZOPUlSsmbZMJTiFsX0/GAKh7Zg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O4x4XQTjWleQEoSbp6OZ2RvuTUUBFqoXf
Content-Type: multipart/mixed; boundary="T7V6QDyrhi3OaUB8GCnbOoolyAXfvESFp";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Patrick Dijkgraaf <bolderbast@duckstad.net>, linux-btrfs@vger.kernel.org
Message-ID: <2e471646-7201-f33d-a9c7-ecbe19b73a58@gmx.com>
Subject: Re: Need help: super_total_bytes mismatch with fs_devices
 total_rw_bytes
References: <42e408bdd5b38305358c961e06c0afe250a00a90.camel@duckstad.net>
 <211fbb73-6a16-a8a6-e2b3-a0799216fe9c@gmx.com>
 <579f07cdb257e15e9f79f501600ce8033353db91.camel@duckstad.net>
In-Reply-To: <579f07cdb257e15e9f79f501600ce8033353db91.camel@duckstad.net>

--T7V6QDyrhi3OaUB8GCnbOoolyAXfvESFp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/24 =E4=B8=8B=E5=8D=888:05, Patrick Dijkgraaf wrote:
> Thanks for the quick reply!
> See responses inline.
>=20
> On Sat, 2019-08-24 at 19:01 +0800, Qu Wenruo wrote:
>> On 2019/8/24 =E4=B8=8B=E5=8D=882:48, Patrick Dijkgraaf wrote:
>>> Hi all,
>>>
>>> My server hung this morning, and I had to hard-reset is. I did not
>>> apply any updates. After the reboot, my FS won't mount:
>>>
>>> [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2):
>>> super_total_bytes
>>> 92017957797888 mismatch with fs_devices total_rw_bytes
>>> 184035915595776
>>> [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): failed to
>>> read
>>> chunk tree: -22
>>> [Sat Aug 24 08:16:31 2019] BTRFS error (device sde2): open_ctree
>>> failed
>>>
>>> However, running btrfs rescue shows:
>>> root@cornelis ~]# btrfs rescue fix-device-size /dev/sdh2
>>> No device size related problem found
>>
>> That's strange.
>>
>> Would you please dump the chunk tree and super blocks?
>> # btrfs ins dump-super -fFa /dev/sdh2
>=20
> See: https://pastebin.com/f5Wn15sx

Did a quick calculation, from your fi show result, it's 83.72TiB, thus
the super total_bytes is correct.

It's the kernel doing incorrect calculation for its
fs_devices->total_rw_bytes.

This matches the output of dump-super. No wonder why btrfs-progs refuse
to fix.
>=20
>> # btrfs ins dump-tree -t chunk /dev/sdh2
>=20
> This output is too large for pastebin. The output is
> viewable/downloadable here: https://kwek.duckstad.net/tree.txt

This also proves your chunk tree is CORRECT!
The sum of all devices is 92017957797888, which matches with super block.=

[...]
>=20
>> The simplest way to fix it is to just update the
>=20
> Nice teaser! =F0=9F=98=89 What should I update?

Sorry, I meant to say just update the "superblock", but it turns out,
it's something wrong with your kernel. Probably some old bug we fixed
before.

Would you try to use latest ARCH kernel from an Archiso to try to mount
it RO (just to be safe)?

I checked latest v5.3-rc kernels, haven't found an obvious problem with
the fs_devices->total_rw_bytes update routines.

So it may be an old bug which is already fixed.

Thanks,
Qu

>=20
>> Thanks,
>> Qu
>>> Other info:
>>> [root@cornelis ~]# uname -r
>>> 4.18.16-arch1-1-ARCH
>>>
>>> I was able to mount is using:
>>> [root@cornelis ~]# mount -o usebackuproot,ro /dev/sdh2 /mnt/data
>>>
>>> Now updating my backup, but I REALLY hope to get this fixed on the
>>> production server!
>>>
>=20
>=20


--T7V6QDyrhi3OaUB8GCnbOoolyAXfvESFp--

--O4x4XQTjWleQEoSbp6OZ2RvuTUUBFqoXf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1hOoYACgkQwj2R86El
/qjr7gf/dt/qklJapqIaYlu6nchZi7s6C19Smg+Ryps3X3QfuSGJw3eYkn0r/4Gq
hR8rMJBlBaurul0XzWVpJOIgzZ4GxclyFg3z6ndAn004rPEBxxyZuaIC8Zh2frG2
eVqLDOFX6DDF5fylQVAXPcFsRfWDGcJNNLE+oBm5lipVRCv3qeZgZXtOG6AC4kxe
jkzbdKsjKFWz+SBv9zI0au1aPfVfQGZ6aa0GjTkru/vmelHUQ2ALdGinNTs7PTTG
WEH+RFk+pH/Be4SomCj+ErYT5jeWzTnqZidq4RIXK2GRNnZUL8BgrFDu6vZhM12O
i78e91bbIss7VD4RCLTkPRNCqTsoFQ==
=7kbO
-----END PGP SIGNATURE-----

--O4x4XQTjWleQEoSbp6OZ2RvuTUUBFqoXf--
