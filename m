Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37F24C87
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 12:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEUKSC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 06:18:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:37975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUKSC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 06:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558433878;
        bh=YidZxmFEJ/NL9n1qTO6RYVoHh32PsxiCYRy9RD26jh4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Mv52Wfp0Xv5AmVwIVwTCNbhRrHUZOVfSmSJiSRsUZU40niOAl00ea92pghtmm3mgc
         Jjg4HtRPUJtYW6c5zgwenZyegFFSDkVklyzOpxudlGQIM/BbX5LKsV+qeYUsjOLa8b
         +Wh20OMfHFNOQdrg9x5JRNjZjATmN47QNrsqvJ/Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M7pku-1ggPOX2MdM-00vL1H; Tue, 21
 May 2019 12:17:58 +0200
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Erik Jensen <erikjensen@rkjnsn.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
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
Message-ID: <36ae40c5-0c76-d6f5-54ea-8e70aefec8a4@gmx.com>
Date:   Tue, 21 May 2019 18:17:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gBXVQ9Fxc3Kq9g48TrnRZwMfbPKAtQzeF"
X-Provags-ID: V03:K1:GJWYj9lAWFoS4lslOmkd2xOc0Lk9KL8aMSRzdbHt0o9dhnQKxQx
 NurS54kBXiIHgsnOiOvxqAbeJAn9JSpM/7srW+9DBvNSqpk8XTiIei9eSqWNa6lhFf73umr
 BBSzcnuw9f7bTekH1TllJ2rBz0zFNlFaTfLJpp01OY1v25DHhZj0Fd6+sjrDO9YXEmNtAkj
 Oy57NCvFd7Ax4SXFUyxLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mvZmTIHjR1w=:nmkNRMo0WQMqomGl6tDu9k
 6rFjP0ffEmc5OtkfD7Src94h2/YaFM8zmiC3HPxRAQA51DdzePWCNQSrhptKdxTjUCE1Hnyk7
 35oEhojyUVtDtjU3TZbMIdD3hPfT3aOuIwpjqXbG+qSZdDczbm598K8SWaPQvYsod31IDYeOo
 oraaXJT4GsiJj0H/TK6ecYoJKARwrQ/S1sr6d4x/9Thwzldp1xfjR95Rz/NXLNBSTO490fHoI
 WUuP24FcjqUd3nsxbbuVbTPXS68xZhTxW4RT578w16RIE/vDWbRKfyK2wM1awSu/Tw2+FTx6c
 vkZb6/xwT7ccNorz5Qh43Lzd7/ar7Ag9ofQiR/91bGxeDMNsL5ZwITXxA+cG8rXzDWVTvIvb6
 GR+el99D0FPp8unbkyrzw74SA4BGZwl6ZduyRGfH4eMvXnLrMkVuKdwsvrJBBg6UKL0s4zx1f
 ZZMcmZvcvgX8aiNgk+GdhOFxXigGYCoUY9NvDx9UIkSPTvpzjU5k3v4IusXYCROZkdBmadVX4
 bJ1rVaex+TgjrTGUPiS2CWQCXpsa9Y0qZO3UXKc85bp+nS8azk0M9SQXATgpdskMarqiTvUEP
 S6Fj8f88J3RIY4KuCTlxl8z+S32PSYhRb9yaAVCy/ALnZ2UKEiXHycr8fYFSAVKSuNTc9bUio
 bpGKFCYSFWb2j0Qq9TBc72ynjmfeIJOQCbnMVA2dm2spvSwGnVyqwiNIoQTLo/js7gc++2Fwa
 LDK+zIZKliI0u+tIK6+aSBUbBJg/icZcxvRsH5nj6tiT52+izEIt+2e4BSSv1ZhqJyefnqkQJ
 v+WWbLFvUMpVTYi5NY4KT0gVRybwgU/AOqRrZZUDfrdwwd8T3SlGYr8AZDO3xl0NEPeGuVuSt
 v3Fp1lpFboibfnXBjCoqxXmFl/HsX20o1SRvH71jmghsgh5/yq1cDHjuUPov24H03V3t3RK4S
 1fxHWbL+wk9XxFrXB7gj0AkNxogUpeiU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gBXVQ9Fxc3Kq9g48TrnRZwMfbPKAtQzeF
Content-Type: multipart/mixed; boundary="81rijhJviwlmZe7wiE7ocMDRiJMzuLHnv";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Erik Jensen <erikjensen@rkjnsn.net>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <36ae40c5-0c76-d6f5-54ea-8e70aefec8a4@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
In-Reply-To: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>

--81rijhJviwlmZe7wiE7ocMDRiJMzuLHnv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/21 =E4=B8=8B=E5=8D=884:34, Erik Jensen wrote:
> I have a 5-drive btrfs filesystem. (raid-5 data, dup metadata). I can
> mount it fine on my x86_64 system, and running `btrfs check` there
> reveals no errors. However, I am not able to mount the filesystem on
> my 32-bit ARM board, which I am hoping to use for lower-power file
> serving. dmesg shows the following:

Have you ever tried btrfs check on the arm board?

I have an odroid C2 board at hand, but never tried armhf build on it,
only tried aarch64.
It may be an interesting adventure.

Thanks,
Qu

>=20
> [   83.066301] BTRFS info (device dm-3): disk space caching is enabled
> [   83.072817] BTRFS info (device dm-3): has skinny extents
> [   83.553973] BTRFS error (device dm-3): bad tree block start, want
> 17628726968320 have 396461950000496896
> [   83.554089] BTRFS error (device dm-3): bad tree block start, want
> 17628727001088 have 5606876608493751477
> [   83.601176] BTRFS error (device dm-3): bad tree block start, want
> 17628727001088 have 5606876608493751477
> [   83.610811] BTRFS error (device dm-3): failed to verify dev extents
> against chunks: -5
> [   83.639058] BTRFS error (device dm-3): open_ctree failed
>=20
> Is this expected to work? I did notice that there are gotchas on the
> wiki related to filesystems over 8TiB on 32-bit systems, but it
> sounded like they were mostly related to running the tools, as opposed
> to the filesystem driver itself. (Each of the five drives is
> 8TB/7.28TiB)
>=20
> If this isn't expected, what should I do to help track down the issue?
>=20
> Also potentially relevant: The x86_64 system is currently running
> 4.19.27, while the ARM system is running 5.1.3.
>=20
> Finally, just in case it's relevant, I just finished reencrypting the
> array, which involved doing a `btrfs replace` on each device in the
> array.
>=20
> Any pointers would be appreciated.
>=20
> Thanks.
>=20


--81rijhJviwlmZe7wiE7ocMDRiJMzuLHnv--

--gBXVQ9Fxc3Kq9g48TrnRZwMfbPKAtQzeF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzj0FIACgkQwj2R86El
/qhttQf/S7LOTTFmfJnUFj/axBe8dH0H2M5g+iFOOyVieN3hlmwHyHXPviYGjhWT
PxrTcI4Gc6C1OPJkE0MNANZ/DMqBdIA1enwPMy7BK5JPOlYuhKoPtq99ib4SrfCJ
K6j+QixMdNF2gjhch8GKVvStW1wf1q7sQNpJQSLhlAcA9h6RGYhzyZdtYTeBlc65
GiF3Xigq/pRCxxFTacnjGVSLobmfGJuLrHq/WmfAY6Q8PbWDSyKKd2gTfBvKOEd8
6EUMBSB4qJmPAEw/1Jm8wpRDBcCkdtmhuJGNpLESM4XDS14NWwqiEsmZV4VBkL2W
675EDytkum6vmCeZ3or37JUckQBRUQ==
=5ii2
-----END PGP SIGNATURE-----

--gBXVQ9Fxc3Kq9g48TrnRZwMfbPKAtQzeF--
