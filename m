Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8465AF36
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jun 2019 09:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfF3HUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jun 2019 03:20:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:60325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfF3HUf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jun 2019 03:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561879228;
        bh=E/0QQVhISD9dVGAkXfdEq5E3Z9yugdluXM90ukoJJP0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Osiz2qEJQ/emhnRq0u/sH/LnEFfpMzIUC9jM+DYxDmMMegoqMaeo0muMW5G25F4tD
         4S8euliQFnZ5/96NRV3orq9eL9AdjcHcc3EG9Otc0SaAC3ZKZwfA9qzEgVBfeHatEk
         ejnxJ2DUqkz7n8ExHVNwtp0nxoUnITGjWsaGWqyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIMfW-1hmyIp2qlI-00EIjr; Sun, 30
 Jun 2019 09:20:28 +0200
Subject: Re: What are the maintenance recommendation ?
To:     Pierre Couderc <pierre@couderc.eu>, linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
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
Message-ID: <2798e32e-92cb-529e-e0bc-8e79a3a5ff69@gmx.com>
Date:   Sun, 30 Jun 2019 15:20:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8Lx8h9zMzFDcWwVcJqNWYbUWCuc7A5Jej"
X-Provags-ID: V03:K1:IF2tFTLT7WKsslu33cmdq9kTkUIKfuh+NnqztPjcEFBJHuc+XJj
 NfxY9KO/jSfmGU9tImTu9tnAdckTb826kUX4rvf/or6tAvIYZisFQkXfy+WY1Ab8plQi1fi
 Kt4Y3ViMACfUMf27CTR0j6hTWzX4x7kBNcYKRR5hF0iXw1HPhR6zBUd1muWP+M02V2qXiXS
 DwwrYavBH22pcNbkjakOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d2tXGMwY+LE=:NokzloB2sfFIqUNTqYaiGO
 vRLwQyxVSGt9s0tZBkQnCenQRQpi18XhZhcs1BwhewcwGklVZeZYek7COzj4THuHAm1MXbqRH
 4CiVYIymjvSTAoQ3sHadXaB28jJ8QyZZ5/WjYyUffODYF3r79TYQzpPglxEGYMfKpWQnpc7pI
 QpYthT4O+GcbvoWCD8vVFE0tmWJxNqG4SItciE3oBnxyaG0vHN9d1ldbWOWRwbjF2uI+6Cv0T
 yXpojXmG8mdRD1Iq+ky2IFFycvC+LszPHE3svVdEby61bjoObIdfaBWSHIZCdG/1mQH3KxLqj
 OG/6vcUapInHN1SPHrTVlba/FWzlBfbk1x8Zw1dhen91X3OlSGOU5FrGi3IVuA4rasSYBP8Pe
 MveMKAH+KptjyPGh8Eju/ETDai0+JZ7zRYaXayXgICMB1q3SvyfQ2ricuzb8DG239E2JE0ncU
 OMeTzQazPIQisweth3ZPeQNLx2oIPE9jJvXZsIKFbEW0habBlmhHMKqD3GomOLp+TKXMeb9KP
 ffc65xZX6qS4UynXd7rH2xoktt1k8Adx5BaI5WLAm4yap3wG1cX1ptDLiZLptj3ls69RUd9Dy
 tPDFYBo+skrv85a4qfYdQyp0gW7u2HrBlToQXpoH8smr6Uul549v7Untw5rN7+TKBQNrVcowV
 BWK3Wk7MFwUPgiHAspqKaD37trp03s/S+D3MYbBQPxg9Vez6jNLaPeggC9ZDGDGxogLHHjuCa
 90iIVcTAr9Dcbmmqfn9I2zidJg0ZIg37ffiUwPQ5d4M6kXoFRPXqeObMCD1kpMRZ2ttnOmofe
 ENCxsnZByUjejRMb+2PjfgGeZY5eEOlIYl2X1mEl3TjTEhLmZTC8RbqkV0KDqVIBgCFoI0hWN
 vq9JBEXxFb4lJ3HZSkWU0dvRdqdPDEtgG4cHBg9q2dZgxR4t76+olQhej8i/sogYvvu8Si/VQ
 LSh7Kl//AEtRUNWhWNvWaI3xzGx3pmM0G0s2KNmpxW+PMAn6hCkVHIZoYINiQT4FnbNpTSmEj
 Kwq9+95+jKOLqnDJft6XCSLo7Lb3zbW5u4NdniDFOJRB+06K0aw8hB9LobetmkqXM6Lx9lFDG
 nfucYqM+epoIdc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Lx8h9zMzFDcWwVcJqNWYbUWCuc7A5Jej
Content-Type: multipart/mixed; boundary="4dXqLc3abiz6GoD2qf8nyjpTVYSLOQPmG";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Pierre Couderc <pierre@couderc.eu>, linux-btrfs@vger.kernel.org,
 Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Message-ID: <2798e32e-92cb-529e-e0bc-8e79a3a5ff69@gmx.com>
Subject: Re: What are the maintenance recommendation ?
References: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>
In-Reply-To: <f9ceb3c8-b557-16d6-3f21-f2de34dfae9c@couderc.eu>

--4dXqLc3abiz6GoD2qf8nyjpTVYSLOQPmG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/30 =E4=B8=8A=E5=8D=882:50, Pierre Couderc wrote:
> 1- Is there a summary of btrfs recommendations for maintenance ?
>=20
> I have read somewhere that=C2=A0 a monthly=C2=A0 btrfs scrub is recomme=
nded. Is
> there somewhere a reference,=C2=A0 an "official" (or not...) guide of a=
ll=C2=A0
> that=C2=A0 is recommended ?

I'd say scrub can tell you how bad your disks are.
But at least, I'd recommend to do an offline check (btrfs check) and a
scrub after every unclean shutdown.

For the maintenance recommends, Zygo Blaxell should has a pretty good
ideas on this topic.

>=20
> I am lost in the wiki...
>=20
> 2- Is there a repair guide ? I see all these commands restore, scrub,
> rescue. Is there a guide of what to do when a disk has some errors ? Th=
e
> man does not say when use some command...

If you're doing scrub routinely, it should give your a more reliable
early warning than SMART.

Normally for bad disk(s), you could replace them in advance. E.g when
the disk begins to have unrecoverable errors suddenly, it is a good time
to replace it.

If it's too late that the fs can't be mounted any more, my recommends are=
:
1. btrfs check --readonly and save the output
   Sent the output to the mail list for help. The mail list will provide
   much detailed solution to recover.

2. try to mount the fs RO and save the output
   Just like step 1.

3. Btrfs-restore if you have enough space
   The only generic and easy to use way to salvage data.

The following methods are only for guys with some btrfs internal knowledg=
e:
- mount with usebackroot option
- btrfs-find-root paired with btrfs check --chunk-root/--tree-root
  Both methods are mostly the same, trying to use old roots.
  Not reliable.
- experimental kernel patches to skip extent tree at mount time
  Kernel equivalent for btrfs-restore. Needs to recompile at least btrfs
  kernel module. Only works for extent tree related corruption.

Thanks,
Qu

>=20
> Erros occurs fairly often on big disks...
>=20
> Thanks
>=20
> PC
>=20


--4dXqLc3abiz6GoD2qf8nyjpTVYSLOQPmG--

--8Lx8h9zMzFDcWwVcJqNWYbUWCuc7A5Jej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0YYrYACgkQwj2R86El
/qgBRgf/XYjtgnjMdO+rh8ZUaSW+2VAR0DZrlky2IugFmMi5d3Nu2yWv2w7F0GSi
rU2IAYBqYBOwkKKF8e9ej1cmpIb85oSFmP6OiUrsMGA0eOWVI9h+ghRnTJsqvKvT
+JsS5c1aVxUT9AvDO+2X8zUF8rd7sJaOHT5RQX2rTxbsYrqxlbrtsoaRDj6NLj0g
eZpFbQFfLhRr0ax4aGc8D7CkN855gzEV2myz16c+v5evHvIYojkGRkpc7MFV5a6g
/9ddZL2INOSc1ipGSxYyJp0tn7X2OYHUmRTaLFjvmLYs68weu3QwarsyIuD5btus
MpiMRJgzWPi9HWi8DRrxhekuDpZNkg==
=HoSv
-----END PGP SIGNATURE-----

--8Lx8h9zMzFDcWwVcJqNWYbUWCuc7A5Jej--
