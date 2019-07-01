Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70F15B46B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 07:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfGAF40 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 01:56:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:41699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbfGAF4Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 01:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561960573;
        bh=1j2D5Ssgv+lVBhaIDVWur6lapeYr5Uja9T1YiveZK+k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ES0rmL5MUIJnUJI1mWnaO3U/nn5MMnovZhGeQ9DtzZAM4OR0GaHrji1P5DwmIo+b9
         xgvGA2ulZruBYyq+7qsdL1EA/qTXyaySS8oMwi74raIw7tTfxhM6fINs4S6nm2VHlJ
         5pxodakHyVAlB6ZPKL7jrT6cj8sL5Ib/Q5ZoYa4E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1hdzo63GvS-0050wh; Mon, 01
 Jul 2019 07:56:13 +0200
Subject: Re: Spurious "ghost" "parent transid verify failed" messages on
 5.0.21 - with call traces
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20190312040024.GI9995@hungrycats.org>
 <20190403144716.GA15312@hungrycats.org>
 <20190701033925.GH11831@hungrycats.org>
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
Message-ID: <eb60e397-6e33-b73c-e845-a4498952601d@gmx.com>
Date:   Mon, 1 Jul 2019 13:56:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701033925.GH11831@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="buQf68zDVjyC3lUNs3q9efY0IL3IxR2cj"
X-Provags-ID: V03:K1:1T0FiEBpT+eFkDHwRTXNABe4SKgRbAOo8qa5w0L8Jv+V9c3zyuT
 SYqnnbuR5UqZ1KuUPaPIUJ90YnwhJpRlLkMMA+QWx3zVxh48KYfXSsbjyVjQYGtjBrIVCon
 5zVZXIdGQU6BcGv4xVJbMCPtWQxV8V7H/bGL0XaC8nE9EIYwZepwpW5OlWiyfewAlP93dlI
 K6XaJGojYRxbc5FM4eGjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oVTRPCc/n4k=:wRI2XxGXAkMf3St6wK7lYj
 yVT7bTJwGJdjgtMUyV9bEWkAlkJrN9DA+24kNU+YyrBvrQXub6/2S+IbkNzUE9O3NjMzwLZAC
 IGRiRLv3vyKBRorbI40nseVRMMP4/R7mSzf5glOyHfe/ThQP5u4DMjiHkzR5+ZMb1QefeUuvl
 GqsRT7aHArzQLwi+8KlCgYFHGNEyrwwbzvA71mYGg1Nu9HQxKtWqig1EB1q+g0qlleMSoucXW
 JhlhKelX/UbVLJCB8/eWP3sUjaFEPxnqztxkv0jKwCALI7c5/6K7KR7bY/eGF6lGAM5ICUOpP
 XyT7xLJ22w+2yWI360GKZuk59tPH39U4vFvb37cfTTThiHe1q760vyt/hl2NRBdgudzOHEAm2
 oor9zFApTIgapQNzNjyjA4a+2UoHH0MvhLqTdLz6liNYx0E8LYXU0PFhj2FtlMjY3jcLirchX
 PzknDPWI8R3LLY1wLeaMuVCl/csVD5/L+qmmOTLwHeYSZIcUxo/QHtyJXQsPoBQJbSzenwicf
 TPE1Uzki6jhOvEMoNVuQul1z6yCq0MN7rjC+YP/z3ocpv3g3bkbOwXCrhsGMJsd81PU4yPZmB
 1I61HuPop4pMIDmcp7JWAPBwwkDnJpQtYKYaX1AUUVCxaIvWXQ13q58+hGdjz6T5yamqwZFC7
 mYoBJ25iL6SYi3DPt/dGLxdMSYQd89xJqPbkuJWiZu1sv4y0pAJWKtnPxjlvIAYqEMxEbz0VJ
 tzG6FeHC3xnVuzqFY5fLg5TRy4uwFnDM2tmIuUTE+ryw+j0bK3s1VFMkmWrb8ff4XYT6BNb3n
 Ia7wTAzPphrFTdGrgu5MFrXpn+LaV6xUo+k/AieGZXEKPUOPzhRNMHV0o9yEcn5g1JZzcHRSF
 IM6Iqx6hQkcCp9EVsZZyVeHD2XAaE+qliT7WCLsEJY3JwIaEo8Bu5eAgDoFM17PML39L568BQ
 dMjVHsrjNg1U3r9kOUAuQCBMncyRQ+ZyJdm4Ti4A1CmA3SxDyy2lD9gbrS+SOWTMTZ5Dl/q+j
 ZbfQd47uTPEdI4lKJmmjO1qW83lFU1c7M0hwBmcAFkuefw6/YzHpVDvQaDjQChC59V9zkN2vc
 SpDngC6pGPeDsY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--buQf68zDVjyC3lUNs3q9efY0IL3IxR2cj
Content-Type: multipart/mixed; boundary="gBf5hnjBXjOgOwNEgwTi4vfZIXWXypUZw";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, linux-btrfs@vger.kernel.org
Message-ID: <eb60e397-6e33-b73c-e845-a4498952601d@gmx.com>
Subject: Re: Spurious "ghost" "parent transid verify failed" messages on
 5.0.21 - with call traces
References: <20190312040024.GI9995@hungrycats.org>
 <20190403144716.GA15312@hungrycats.org>
 <20190701033925.GH11831@hungrycats.org>
In-Reply-To: <20190701033925.GH11831@hungrycats.org>

--gBf5hnjBXjOgOwNEgwTi4vfZIXWXypUZw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/1 =E4=B8=8A=E5=8D=8811:39, Zygo Blaxell wrote:
> On Wed, Apr 03, 2019 at 10:47:16AM -0400, Zygo Blaxell wrote:
>> On Tue, Mar 12, 2019 at 12:00:25AM -0400, Zygo Blaxell wrote:
>>> On 4.14.x and 4.20.14 kernels (probably all the ones in between too,
>>> but I haven't tested those), I get what I call "ghost parent transid
>>> verify failed" errors.  Here's an unedited recent example from dmesg:=

>>>
>>> 	[16180.649285] BTRFS error (device dm-3): parent transid verify fail=
ed on 1218181971968 wanted 9698 found 9744
>>
>> These happen much less often on 5.0.x, but they still happen from time=

>> to time.
>=20
> I put this patch in 5.0.21:
>=20
> 	commit 5abbed1af5570f1317f31736e3862e8b7df1ca8b
> 	Author: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> 	Date:   Sat May 18 17:48:59 2019 -0400
>=20
> 	    btrfs: get a call trace when we hit ghost parent transid verify fa=
ilures
>=20
> 	diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> 	index 6fe9197f6ee4..ed961d2915a1 100644
> 	--- a/fs/btrfs/disk-io.c
> 	+++ b/fs/btrfs/disk-io.c
> 	@@ -356,6 +356,7 @@ static int verify_parent_transid(struct extent_io_=
tree *io_tree,
> 			"parent transid verify failed on %llu wanted %llu found %llu",
> 				eb->start,
> 				parent_transid, btrfs_header_generation(eb));
> 	+               WARN_ON(1);
> 		ret =3D 1;
> 	=20
> 		/*
>=20
> and eventually (six weeks later!) got another reproduction of this bug
> on 5.0.21:
>=20
[snip]
>=20
> which confirms the event comes from the LOGICAL_INO ioctl, at least.
> I had suspected that before based on timing and event log correlations,=

> but now I have stack traces.
>=20
> It looks like insufficient locking, i.e. the eb got modified while
> LOGICAL_INO was looking at it.

For this case, a quick dirty fix would be try to joining a transaction
(if the fs is not RO) and hold the trans handler to block current
transaction from being committed.

This is definitely going to impact performance but at least should avoid
such transid mismatch call.

In theory it should also affect any backref lookup not protected, like
subvolume aware defrag.

Thanks,
Qu

>=20
> As usual for the "ghost" parent transid verify failure, there's no
> persistent failure, no error reported to applications, and error counts=

> in 'btrfs dev stats' are not incremented.
>=20


--gBf5hnjBXjOgOwNEgwTi4vfZIXWXypUZw--

--buQf68zDVjyC3lUNs3q9efY0IL3IxR2cj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0ZoHgACgkQwj2R86El
/qg8mQf9HCxaAXFIeJB/Vx77Bl+9kUWHs/1P0JtBkb7FozdCE1UUY6kNp8cwOnm9
XrU1gN866yJtU+2L6LMyehvhQNZpVyJUk6cZwMtxxfFuH3I21EAnui+QQsaFRiKl
Vh4zhvdsfUglOQpNwrOO7Ij+Uk79e25yV8/tblN/QsQ1acXvuscWXyOO2j2irTEI
yTdZ3aQpJn000O7MqrLMtV28pG6HaZvb3B4OdeuYu3Csn6ouanEcNFuf0LOHQZMH
Da0ozOxtorki4DRAgsdyMlOvx8QqfqC+YDhHiE/zCFy3umRZLGAwM+FSNqCWV//i
uL6dEA/XqZ3YU23u237pa4fOB6Ig6g==
=2NbF
-----END PGP SIGNATURE-----

--buQf68zDVjyC3lUNs3q9efY0IL3IxR2cj--
