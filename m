Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D555204977
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 08:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgFWGDF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 02:03:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:34653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgFWGDE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 02:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592892178;
        bh=xSRjehXbGHbPjTDmmQqKC99dMxnaZNCM05uY8NkrrMU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eoOvfMEOhHnljT6JEqwfT2u7ZRb+e1mKXvKgb5ssWcp+GrP1ThQfPd0wnDrxgYAiK
         WqhNELJfoZyV1PPJv0hEPwOu7gTfBwzqTjjJ7iZwFvW8WNOWNtLo9fczIjkQWKnbEi
         OeyHccibNIshPLpUFm8QAo18sVVLs/5h2Dmbb9fc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJE2D-1jYXsZ3LXH-00Kg9i; Tue, 23
 Jun 2020 08:02:57 +0200
Subject: Re: [PATCH 13/15] btrfs-progs: introduce init_alloc_chunk_ctl
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
 <20200610123258.12382-14-johannes.thumshirn@wdc.com>
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
Message-ID: <5db5e549-e400-5ab4-7f10-33e682196e80@gmx.com>
Date:   Tue, 23 Jun 2020 14:02:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610123258.12382-14-johannes.thumshirn@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="flmBV1kInnGvacvONbnuQtmV3JuOz5I2v"
X-Provags-ID: V03:K1:PvLn5kqPl+XyxKUcOKOwcmhSiqsV02COVQIs8bVI3o7WfYko8pq
 CdrQr4Ev6A/egAqyTLdFZBbdB58SFjRBWRaMPZP1GcZTmRCdWjTLO0+exvXPGht/eeCZcaP
 H//5MJ31PMax/0m6dVWTWm4PF/4sbd6bAcYZyxE4hIpvGiR/mWu5B2XNnr5CsHyc0OeEKRl
 PcjYfRnlERvLegeXpkYjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iCBclRTvSno=:gup+7flhK7kjywA00Vp59G
 zUSjkKJTpXcI3KfJUjl+QelH6VmtqyNLBdkzdAtpDpzQuoVpc2ao7YTVOnGvFVjLGTuYBgDyS
 G6uowSjipusV36pst3/kRqx6EyOvfB0jzOYGeRAdNa0OCQBmy9+JyDBmqoxlK0/eVk6o2N2jL
 Z5F/vT4fcCo0hsKtgaDgJtSqqlHvAUdz3P/1nMUGI7jQtDT1YKJKVPUWTbbx4beMFlQJSR0ql
 iKu8EsiAqcLNmH3AkXc8ggdihtj4vaCMVwOAhnfSbiyThxs7bIBaZV/Ra0D7pz3k4val6c5hI
 dulUnOXO+79VIHT7duSYEJ+dfwvdi6uLIfzFm0WvLbXDHLkSNyGsP9XSFQx+bA2W5hEmMdhag
 bf6j8dFVLpGU1gBFYn0zjrx6Gsj5ntuuMiW4E4B60Zgu2oyIirKqI0WRAU6l8AejYq7rVMeCn
 PO9+Hw+nbUe40WRtogh9iz1Na6D0NWeIHiWd9uiyhodKafbDd0VJDMEKumesyOVG17hGzAkqe
 MiQhdoWdtX1qn4LDSNzO6qp/sxLZTtPVF0zfhdbRTeAkuyskhsgRE5JBImCoGmTrDWGzacO93
 YT7vUgq7bmUaaoPBx1Fx5NsGG6uvwKwLSEaMYE8uuYT3Vazv+fDwmS3MjqvnkJPN7qhAX4nA3
 YZO5MdamJXilqx8qeYNVaW4jyWX9GaIay5JWi6quALGpMozNhKbAsKDqb5QpspRtSGt8XL+Bv
 lewlKftbhEo0UAFKRNpKdKzYeYldc72/qu9PPuI5PIvB6uWtX9kOFZvN2coU7Q0pI2v1Iqwvn
 rWfqle9buAfVZIQjcB6WDpxkHrSiyIh2nMFwAYMuvDaIyWqfqsKOd/Jm89DNMmqo3StM7H7Hz
 oEh9O3rd27Pez1YNjDq6a1eir8QyxKO4FAtqs+8JNrHBoYQPLLGYDTub3N5yH9LkQGxc5AsoZ
 iGT+T/MLSs6YsXFXMMqevNhRn7ukan0mIx5foenx+5+tC8lIrbWyyWE4kF+2iyh+ocMNdfKn1
 BoFSScFXgCo0fe9IQynFZI6RuDpvEDTCBdRe7hkPdaAN32M5oTIYPNmaE2wcPqZ1waOvnvxqd
 c8mDz/eX5dt2n/m6Ap3fZwEiv55MYgOiPU+tIYPQQ2yQkPzQKH779l44CaQNfzmx3lwdAOCI4
 NHYmJRY7mZkQr8YazrQQyOykSCP0Csx2poWJbLIw6UA2ylpMA5D/yK9lYFaw8F9yDRCAqDWAy
 evXP/rTT9hQEkJCR/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--flmBV1kInnGvacvONbnuQtmV3JuOz5I2v
Content-Type: multipart/mixed; boundary="v2o8sjBTHivlC8bnmTlSaDondClmMXVMD"

--v2o8sjBTHivlC8bnmTlSaDondClmMXVMD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/10 =E4=B8=8B=E5=8D=888:32, Johannes Thumshirn wrote:
> Factor out setting of alloc_chuk_ctl fileds in a separate function
> init_alloc_chunk_ctl.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  volumes.c | 70 +++++++++++++++++++++++++++++++------------------------=

>  1 file changed, 40 insertions(+), 30 deletions(-)
>=20
> diff --git a/volumes.c b/volumes.c
> index 57d0db5463ef..aacff6e0656b 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -1067,6 +1067,44 @@ static const struct btrfs_raid_profile {
>  	},
>  };
> =20
> +static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
> +				 struct alloc_chunk_ctl *ctl)
> +{
> +	int type =3D ctl->type;
> +
> +	ctl->num_stripes =3D btrfs_raid_profile_table[type].num_stripes;
> +	ctl->min_stripes =3D btrfs_raid_profile_table[type].min_stripes;
> +	ctl->sub_stripes =3D btrfs_raid_profile_table[type].sub_stripes;
> +	ctl->stripe_len =3D BTRFS_STRIPE_LEN;
> +
> +	switch (type) {
> +	case BTRFS_RAID_RAID1:
> +	case BTRFS_RAID_RAID1C3:
> +	case BTRFS_RAID_RAID1C4:
> +		ctl->num_stripes =3D min(ctl->min_stripes, ctl->total_devs);

The kernel code looks more elegant to me, no switch at all and takes
full advantage of btrfs_raid_attr.

Although your work is already pretty awesome, mind to make it even better=
?

Thanks,
Qu

> +		break;
> +	case BTRFS_RAID_RAID0:
> +		ctl->num_stripes =3D min(ctl->max_stripes, ctl->total_devs);
> +		break;
> +	case BTRFS_RAID_RAID10:
> +		ctl->num_stripes =3D min(ctl->max_stripes, ctl->total_devs);
> +		ctl->num_stripes &=3D ~(u32)1;
> +		break;
> +	case BTRFS_RAID_RAID5:
> +		ctl->num_stripes =3D min(ctl->max_stripes, ctl->total_devs);
> +		ctl->stripe_len =3D find_raid56_stripe_len(ctl->num_stripes - 1,
> +				    btrfs_super_stripesize(info->super_copy));
> +		break;
> +	case BTRFS_RAID_RAID6:
> +		ctl->num_stripes =3D min(ctl->max_stripes, ctl->total_devs);
> +		ctl->stripe_len =3D find_raid56_stripe_len(ctl->num_stripes - 2,
> +				    btrfs_super_stripesize(info->super_copy));
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>  		      struct btrfs_fs_info *info, u64 *start,
>  		      u64 *num_bytes, u64 type)
> @@ -1100,11 +1138,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle =
*trans,
>  	}
> =20
>  	ctl.type =3D btrfs_bg_flags_to_raid_index(type);
> -	ctl.num_stripes =3D btrfs_raid_profile_table[ctl.type].num_stripes;
>  	ctl.max_stripes =3D 0;
> -	ctl.min_stripes =3D btrfs_raid_profile_table[ctl.type].min_stripes;
> -	ctl.sub_stripes =3D btrfs_raid_profile_table[ctl.type].sub_stripes;
> -	ctl.stripe_len =3D BTRFS_STRIPE_LEN;
>  	ctl.total_devs =3D btrfs_super_num_devices(info->super_copy);
> =20
>  	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> @@ -1129,32 +1163,8 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle =
*trans,
>  			ctl.max_stripes =3D BTRFS_MAX_DEVS(info);
>  		}
>  	}
> -	switch (ctl.type) {
> -	case BTRFS_RAID_RAID1:
> -	case BTRFS_RAID_RAID1C3:
> -	case BTRFS_RAID_RAID1C4:
> -		ctl.num_stripes =3D min(ctl.min_stripes, ctl.total_devs);
> -		break;
> -	case BTRFS_RAID_RAID0:
> -		ctl.num_stripes =3D min(ctl.max_stripes, ctl.total_devs);
> -		break;
> -	case BTRFS_RAID_RAID10:
> -		ctl.num_stripes =3D min(ctl.max_stripes, ctl.total_devs);
> -		ctl.num_stripes &=3D ~(u32)1;
> -		break;
> -	case BTRFS_RAID_RAID5:
> -		ctl.num_stripes =3D min(ctl.max_stripes, ctl.total_devs);
> -		ctl.stripe_len =3D find_raid56_stripe_len(ctl.num_stripes - 1,
> -				    btrfs_super_stripesize(info->super_copy));
> -		break;
> -	case BTRFS_RAID_RAID6:
> -		ctl.num_stripes =3D min(ctl.max_stripes, ctl.total_devs);
> -		ctl.stripe_len =3D find_raid56_stripe_len(ctl.num_stripes - 2,
> -				    btrfs_super_stripesize(info->super_copy));
> -		break;
> -	default:
> -		break;
> -	}
> +
> +	init_alloc_chunk_ctl(info, &ctl);
>  	if (ctl.num_stripes < ctl.min_stripes)
>  		return -ENOSPC;
> =20
>=20


--v2o8sjBTHivlC8bnmTlSaDondClmMXVMD--

--flmBV1kInnGvacvONbnuQtmV3JuOz5I2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7xmwsACgkQwj2R86El
/qhU6Af/arjca1l+yb50ZstoFFu3tY+zwYN3eAww1jVgtXNXVIwL8ymiWBqZnXET
LDK9odSCBF8DyXdzyS4vbzn6ixVUrQwm51DoAaocGkiT78585zgoIalrObHP2RJa
lsiK9qNEB9sPbaXJ2VynC7D7U2h+iRkskwS9hHnuUx2wgJxzUCUdQcCvPIuJUidL
o4dB7ybtbfxcn8Gv8YN4IFKNS3h0bPZwFr1vcOplnNFwMfPr4UueLdOJaEQfe9xA
9YZY9PwuX7WafkzgFKFom0ndUDLN5C+SCd8kR6KaOPHGlO0vAB8QezEYvitpuL9P
0AazHb+iMD2ukvB615UmlMJ/3Cxldw==
=rrV+
-----END PGP SIGNATURE-----

--flmBV1kInnGvacvONbnuQtmV3JuOz5I2v--
