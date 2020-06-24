Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6399E2071B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbgFXLDS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 07:03:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:43077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbgFXLDR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 07:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592996592;
        bh=UyOqHjyeQjg96bm5qj2ACcsgA9xnW36P/CA/KXz3SdU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CFdmZ+om25g971RnqVERH+HeiDf5krWYp+gGyTKAWMJIFDVMayybRanjMFqKHIgeN
         COK3QmqjHxeK3Ju/iRYVHbhZPUBf5jw34VRW+Fv8+GP8y61F4ql0cRgd1YlpfP8BaJ
         JKIk2zndubFZusrPHFqKIQnsijCIugx+CKJwjnV8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89L1-1jio7o18vj-005Itv; Wed, 24
 Jun 2020 13:03:12 +0200
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
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
Message-ID: <8add89b8-c581-26c3-31df-e5e056449dc2@gmx.com>
Date:   Wed, 24 Jun 2020 19:03:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qIN3Kggxqhc2GAimSzc2Wx3PyH1VMiOmL"
X-Provags-ID: V03:K1:MdJpF0quNcYSzSaehwVUUFvKH2z8suahkg68vvJu1Uj0lHGSDgq
 we0yASSG8akJRsQvFtRR5yBCBI77iCM/wR9fVK3LgdpdbmGuamRqLHmmnrlIFqOKoU+rnxJ
 RVYesXiKDlH8FquXBsIBQxCa+2YpUATr2DYWjYFTDYKBcx2qbff4Kpru9rHoDbsfUKJq9jO
 zLothp5Y1pU50sve+9RyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wqcKh08sC+0=:tpjNqe40PJ6c4Pp+8HlseK
 I4LxE3dZtvHNQOPecXpi1KHs2v6V5VVRRMhh/hpCiYjk6uy689IkDrSP1INoJvL1uhWkp8khd
 XqMzbDNBlUvOJ5KiRE4swXMdBLvzq1nFSAnk5WUUHVtKwn2XFiSiqddXO76zR4oVY4dPsgA4K
 F5G4WBDQ6uugUK5aFIsy0WnBekJNFGA2eU/nfjC9M1fZ+ZbqsRdLvbLqwowclbIHQcKYi/0n7
 /V577rLj6QyK056Q+TCj7ClDba7v3CThh2rRbwKvMAdHmQDuxECELFoKJ4NYIBVGn4Z7497Dh
 PRSCqlgfjCyh/EfPdp6fBxB9GLoMJSOBilLCsLlR+j7cYUElQxfNcV3A/OuN8wc9es++NdKKi
 0TcKiQQ7+jdPT5q5M90jqGqHs+i8a1zWt+BQAHUcPVmibUCI+VY9e9qfn60c79lbd7Nk9KrH4
 i6M6jaC9wjkuxwl4yVXsa7QLzpFXBiN78pgNHxoxUMv2BiM28Rdhj6wCmgHkPDjoZl1tY3Lva
 5l7lzpBGuByRSRcM/h0Sqc8STREsyK3qzd9/uT4CTZhuROUYSy9Bsc7eB1SC/E7kT1Dywt3qz
 UVfNe9XPiIWaL7ZBXQo73xWwveneiFJ5XVpc2YWamlhjU26R8BdikeDueBQSDCNA2R1qnapUP
 /3KVzPjPb1NXtIUI9to0T5PVFlIlWtulGSEk5wyCV4SPeX+H56a5Io3eeqkSmoU0K2C8GQagj
 5WLCj0sVsXIjrpxDO1DEFSfgzl6DXQNGpdp5grOg9DB5dYQCI89oE0f1cwiIKFYXpQ/eDRLFm
 o1QNX3gtdOPx8R9V3ehry1/Rh0VaLYpgQys1hPQV84v7Vii7aeqcUljhhLatTbL9QF+xpIVDc
 Y+XwFkQ8n4oSrzUA9aB9G5BLH6YvFIWSymlA5o+++zSHhrpMYFqO8EORE4Y+jppWHkFAQeiqJ
 Y1a8+Frgr9kADy40j4ihmZtQ/3icCVG2F+zIXU1D/aEKu2SXhnUQ6NyyakYpTWSqp81UqeqGn
 FZEcDomM90IgqitbeZUElBtHYBbwiDqPKwE4ac2p3WG2uvlzGPPTxzHAzJGiFzcUed0AkWS37
 AKhACCMk83Aa3spKJ1B0ZpZssZ2eRNtqyNBYWB9WC1vNa2Xxv6ZeU9VSHX0tOFZbh75ID0twt
 zmS0IccjzRN2h7dfggnWJj7D5dskMR4nM0L9bE6i/oFMYhshI3zIs3ecHOGcZum86rz6VErMM
 C+/Otak9Nsi78MSoQAwQktUEmgawgD0VS4iNxnQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qIN3Kggxqhc2GAimSzc2Wx3PyH1VMiOmL
Content-Type: multipart/mixed; boundary="ex1MIe3MSjMWs6ulPxbQoG8Upvuu7JUfI"

--ex1MIe3MSjMWs6ulPxbQoG8Upvuu7JUfI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/24 =E4=B8=8B=E5=8D=886:21, Johannes Thumshirn wrote:
> With the recent addition of filesystem checksum types other than CRC32c=
,
> it is not anymore hard-coded which checksum type a btrfs filesystem use=
s.
>=20
> Up to now there is no good way to read the filesystem checksum, apart f=
rom
> reading the filesystem UUID and then query sysfs for the checksum type.=

>=20
> Add a new csum_type field to the BTRFS_IOC_FS_INFO ioctl command which
> usually is used to query filesystem features. Also add a flags member
> indicating that the kernel responded with a set csum_type field.
>=20
> Fixes: 3951e7f050ac ("btrfs: add xxhash64 to checksumming algorithms")
> Fixes: 3831bf0094ab ("btrfs: add sha256 to checksumming algorithm")

I don't think the fixes tags are needed.
You're just adding a new interface for IOC_FS_INFO to grab the algorithm.=


Overall looks good.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ioctl.c           |  3 +++
>  include/uapi/linux/btrfs.h | 13 ++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index b3e4c632d80c..16062720f5f3 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3217,6 +3217,9 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_i=
nfo *fs_info,
>  	fi_args->nodesize =3D fs_info->nodesize;
>  	fi_args->sectorsize =3D fs_info->sectorsize;
>  	fi_args->clone_alignment =3D fs_info->sectorsize;
> +	fi_args->csum_type =3D
> +			le16_to_cpu(btrfs_super_csum_type(fs_info->super_copy));
> +	fi_args->flags |=3D BTRFS_FS_INFO_FLAG_CSUM_TYPE;
> =20
>  	if (copy_to_user(arg, fi_args, sizeof(*fi_args)))
>  		ret =3D -EFAULT;
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index e6b6cb0f8bc6..161d9100c2a6 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -250,10 +250,21 @@ struct btrfs_ioctl_fs_info_args {
>  	__u32 nodesize;				/* out */
>  	__u32 sectorsize;			/* out */
>  	__u32 clone_alignment;			/* out */
> +	__u32 flags;				/* out */

The flags looks a little too generic.
What about extra_members or things like that?

This flag really indicates what extra info the ioctl args can provide,
so a better name would be easier to understand.

Thanks,
Qu

> +	__u16 csum_type;
> +	__u16 reserved16;
>  	__u32 reserved32;
> -	__u64 reserved[122];			/* pad to 1k */
> +	__u64 reserved[121];			/* pad to 1k */
>  };
> =20
> +/*
> + * fs_info ioctl flags
> + *
> + * Used by:
> + * struct btrfs_ioctl_fs_info_args
> + */
> +#define BTRFS_FS_INFO_FLAG_CSUM_TYPE			(1 << 0)
> +
>  /*
>   * feature flags
>   *
>=20


--ex1MIe3MSjMWs6ulPxbQoG8Upvuu7JUfI--

--qIN3Kggxqhc2GAimSzc2Wx3PyH1VMiOmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7zMuwACgkQwj2R86El
/qgGwwf/YimHYSu2bcoul/F901kBvYESJlsW20Gvt/7XjWzCgNwWTs2fCCgxxDap
lgL+/NCHo5x8y0qvEL33GVbKmpvoDSg+sFvsXKD4HII9OVZo07h19aFWcvfnuSYr
8DBze97Mg3EBNL2AvP2XN33fom4w9FU1HnoG+xbf5NebpRiA8u6CDiQdJzZmZ/XD
7ct/B4byf9R3P/8nNej7fNiQwPr8+5G19eJokdGoUs6x6xH6Ww5i0tnMCw99atXa
BIuvsSegpVGYsJLZPjuspehbMrfDIzN5gPfTbdseDCBT/OuDu7Fa/ER1Nn2ENzUf
WSAcqqAhyvpNiZG7dVFOR/ZtRRgBnw==
=CpLg
-----END PGP SIGNATURE-----

--qIN3Kggxqhc2GAimSzc2Wx3PyH1VMiOmL--
