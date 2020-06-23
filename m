Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187F4204A01
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 08:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgFWGdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 02:33:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:43967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgFWGdi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 02:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592894012;
        bh=+2kZQ1/tFVWx3vnNxoJcXm0T2n5hdJt+QQASnUrQMYo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IVyWt8nlPIbNBFnZ7XpCYIXK4F7KsrDycrNApHiCmDv5vgdNG9x7W/TTYcumILD/P
         VAEV15O9HTI7ZN3GYyF47au2rV0ZGIHkheqVYSVlUcxvQGtbQa2kswZ1zLBDLj3+Sg
         lq8YbIKVXuvNaKzCYVkMIxZdaEMoKqduzXvGrFOk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJZO-1jBYS53YPO-00fQPv; Tue, 23
 Jun 2020 08:33:32 +0200
Subject: Re: [PATCH 00/15] btrfs-progs: simplify chunk allocation a bit
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <bd2ed4a5-69f6-9b32-b86d-1b637bae2630@gmx.com>
Date:   Tue, 23 Jun 2020 14:33:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CinPTdvdLzHtWzTdeVh5Eqpr4YghFzfKd"
X-Provags-ID: V03:K1:DWS9Y9OgKx1TAg9i3DGmXCHB7W2GRJFjEOxhlCe1P3VQjj/2ECw
 QE1tkxlpeO8B6z8SMAMOWR/vzQC/zeoeiarOQ++3oVOHzb1zfEDbTcOR+4Ju4B/opmFmjd3
 oAXOxiK22+BwxTa/5T5ObFy649QBLzvYaV35+8PgJvLgszNYLF1a9clJxc4azGxkFTfz0z4
 xIciHhR0IjuCPmHxR/ACg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YRdCQ9c9/v4=:kQu7R6/KhrFPVbzG9jWCHB
 YvBh0UgCU5Rl0rAqLUPohB4VJlfxOUQerSV5K7AqJfPGM8Bo4DtpR9LqpWmX7KiN1DpN2wwLx
 0ybkDf23ae8zzDzOxv8zYWohK0u1R4RUxn4xpAPwnjdIYscAAN51MyPZnwguVt+hqJTjScASB
 J5C72LBFMRd9sF/UO+Ry0u1K+kPUDCTX9XgHZB6K0BzT+WCuZGlVBUHot6N4r8lgEXSII+4yk
 HZDXEYyapxiKrsYs9fLlxww+fmkImiVO9q+XctXd7Ij+/+jGgsw5R67G3nIcGdyo/ilXWpSfj
 NroFGUx1iGlRNbUC+x01D6Z+fLN+piUCNGhjvA/+2dVkGe0mlIQxP/XvcD6d4LwygnXYFw2Pc
 ip8STWPXg5epUC8OILEXpXLvKV89C5H/bfWTyo8MHtpSbLEmyTS5w9UqzZAvGrTnxVsOnn0n/
 pS8i8+SRTBvKVEmGTKAykUx/B1ORaEFOLZinLvOiEdhiC1UWAoN0PKgGkUeJFqcZYsFgJFZWv
 RNbQyDa0xPeWZU2D1jNE+OxIuHrHXs+540iIZ9q+fgCgplkYG3Ki/coiif5yzXng/cviAjsW1
 PnWNUa0I/hOTx6p6bXWA9dMv0om9Xyoy7mWHeDtPR7V3NwFxDewJJt2KbnaJ0oOmBKYpbMsY0
 n+zexIrodjrqoZwd9izRCC7BrZ2Dw0DsZhZYIf/Ghpi9TqGFHwxlKcMxjJGPSlg0g3n9bloh0
 NW7uqbNrs7rcl98FCy0xMC7+Dlr6t0mFrLrUW0aityj6rW96UajYCfSVwgHxewt2TCE90ZEWK
 OfOVq7sdqYVZtLy3vgJxCC5up7le7IDmJ8yPq6++duFJj7NtKQ0Rcb8py24HKFBbftrHzscPh
 A6her0+vYHsOl4y8Fg3E60WmziB5K796aez68qceUXjaaYJ2jfgeeQ9UQd5HAurGBVNbDCd8V
 mOTjGsVpEezvnzabEAHaHrwcx+HZsgjTcN1Ba6zrwoZ5PaAQoIiN1tGgCg+Eoz+TO2e2JWhdl
 AxC91X0ziV8nmnPa26tUN/NSd7QRNhRHteB08ZNfoDReUR8sZ+KArXp8nHr2ueOViPd9qoRUw
 firW8F6bhFT4K/o5F3Mn2gwzBuikMtxgU5OfMSLBw+DzlEfsFcFYnp5NHZR2WL9rKiApgFmBC
 wWG3wEH619AM+6rYzrOogSAxWQMbn1HHsMUupEfD+9oHYc9EV7gieCFP1ROVVAvTRwxUAQTZa
 O/wX6mbZ41BfDcoMi
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CinPTdvdLzHtWzTdeVh5Eqpr4YghFzfKd
Content-Type: multipart/mixed; boundary="HcmD8xu4CjgmQzwKyvHCPeRHzARzuKT3i"

--HcmD8xu4CjgmQzwKyvHCPeRHzARzuKT3i
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/10 =E4=B8=8B=E5=8D=888:32, Johannes Thumshirn wrote:
> While playing a bit with the RAID code, I've come up with some cleanups=
 for
> the chunk allocatin in progs. It's not aligned to what we're doing in t=
he
> kernel, but the code has diverged so much it is a daunting task to conv=
erge it
> again.

The refactor looks pretty good, and passes all existing self tests.

But comparing with kernel code, there are still too many if branches for
different profiles, unlike kernel fully utilizing btrfs_raid_attr.

With that fixed, it would be perfect to be merged.

Thanks,
Qu
>=20
> Johannes Thumshirn (15):
>   btrfs-progs: simplify minimal stripe number checking
>   btrfs-progs: simplify assignment of number of RAID stripes
>   btrfs-progs: introduce alloc_chunk_ctl structure
>   btrfs-progs: cache number of devices for chunk allocation
>   btrfs-progs: pass alloc_chunk_ctl to chunk_bytes_by_type
>   btrfs-progs: introduce raid profile table for chunk allocation
>   btrfs-progs: consolidate assignment of minimal stripe number
>   btrfs-progs: consolidate assignment of sub_stripes
>   btrfs-progs: consolidate setting of RAID1 stripes
>   btrfs-progs: do table lookup for simple RAID profiles' num_stripes
>   btrfs-progs: consolidate num_stripes sanity check
>   btrfs-progs: compactify num_stripe setting in btrfs_alloc_chunk
>   btrfs-progs: introduce init_alloc_chunk_ctl
>   btrfs-progs: don't pretend RAID56 has a different stripe length
>   btrfs-progs: consolidate num_stripes setting for striping RAID levels=

>=20
>  volumes.c | 261 +++++++++++++++++++++++++++++++-----------------------=

>  1 file changed, 148 insertions(+), 113 deletions(-)
>=20


--HcmD8xu4CjgmQzwKyvHCPeRHzARzuKT3i--

--CinPTdvdLzHtWzTdeVh5Eqpr4YghFzfKd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7xojgACgkQwj2R86El
/qhwVQf+IoQANKCjv8L9s80na2cYRP81FelzSAqESviMvD6tRHXB9ICaLBZzkiQ3
qzu9vu39zb6o2+sJZ9RaOVdF4Lckwg6ss3BXSqvFBBUNGU8FtoQYv11mnGPe2CRt
HmEz3e5UcG7hrIqEPHCN3x2y2JH2ZaEcXKUcy4O+T/A3LbMNe4uAvnZpO6pcCwEj
2fBcDUZNkaae50Tqdm2ic7ERto3Snwz6wuYbNmu7rswjbJ9IsdnPkyagIipVE5HV
B8q/neagum9ZwpPoxME9oxFGfAWpfo6icgBm9oxlG6a1Z4nwhVSL1wc1zWS/KFgN
qA4k9uTcSksx1gFrrPDEGknQqr/OCg==
=jm8d
-----END PGP SIGNATURE-----

--CinPTdvdLzHtWzTdeVh5Eqpr4YghFzfKd--
