Return-Path: <linux-btrfs+bounces-8290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA58988241
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F5E284A24
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4B1BC067;
	Fri, 27 Sep 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oJ1s8Cnt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B21BBBED
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431836; cv=none; b=BjNMOZIKBBIb3vgmRz6nf8Pd3et2/7kwNgZHORZCaYJpEEyyi6zJdk/28VHV1z5L3iUTJiLWnL2+y2cQ25klWuHNdBppIpmDWtnNRUhH6emGtG5VpVMmWIgbOvbY7v0nytBSz74bLU1Ro6uGopSmvvo9cIgnqyuoDyf9iXnK4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431836; c=relaxed/simple;
	bh=NVr9TrllY9+/HH0HgPaY8OGBIGHbLlDNP2qYVl4Hii8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7uvZB6cl4D3Cy8EE33MoC7HwWRO9TLUTyCrf6Wo9H8Vugr2pLARTw1feA0ivgfdNP1bAx0wB+I1/mH2DV1P5NR9lErD4rWidEf9xMvG5AKbAUkD2Sc3oe7zFydAMPImLlxRYRtwE7hGm9WW5LGKEA1dS4Xyq7M5fqefcaf/iKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oJ1s8Cnt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727431822; x=1728036622; i=quwenruo.btrfs@gmx.com;
	bh=QUENOFO7uPYUp8WsUwIV1kgG1STBAMdk7u0kUZaAqe0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oJ1s8Cnt8NgoIG2IE6e/cNgjGVL30az5d0fJjirJ8s4XZNWNImLNyR6Itwtg5hes
	 xCh7x+4VhfwPDYCG7pDUfcvaXIblR0s9aqJx+4QGkU/YWx50tpZWznBCKx6HedOcv
	 yIsBJFN4HyAYXaW/BzsQEBNaYysnUc8ndjrXqGWEBJTLF3EpKKNl5/jZ649JhVL8y
	 pKGd71gkfX/oGbA3sKUbD1H5IyZibB8UIE9xLHubEMWnuBzhMkXbAeenVoklLamCD
	 xs3Rb7au76LexrXZLHjRrqVREtmaLnVZdL4CeV3DhZ348KyI4nUZnSaAeZ7lDpFm8
	 2NOvB1hIrxOAQBGDzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgNct-1sHF0U2DAF-00bci8; Fri, 27
 Sep 2024 12:10:22 +0200
Message-ID: <7cf92eb7-98ad-4968-bbe8-2fa0c35f1e9c@gmx.com>
Date: Fri, 27 Sep 2024 19:40:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: introduce RAID1 round-robin read balancing
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
References: <cover.1727368214.git.anand.jain@oracle.com>
 <63676f15fe9b1ca6c10eb9021829b4666db6d021.1727368214.git.anand.jain@oracle.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <63676f15fe9b1ca6c10eb9021829b4666db6d021.1727368214.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kx7+Nq3Kd1ktkQh3FQDMM1s1wikG9bkQEecycslJisbfcOJJIWT
 kVLZvZpKH5jEGv2Z5OWSSRoAzpDHuCT0YPo/LmtWcZwkop8xWVq6MCLGurnB7I12OWHdHJZ
 /PZ31chngNiE2xtKPYOVH58dpiLgRdc07rb1JiP4nNvSJwLpFpit/8m18W4LQrhW3C7+eub
 +FI+jlYPfDXV0oN5ss4mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EDGnZyHkceI=;NlugIa2nD+XGwS69Hi8+b3aywC6
 Few4vqzOWE3fsOn52/VbxBH4ZPScZEVA0d6m2XVTdZ8PfIXo5yXFPW41DD/X+L8Mr+jYw3FSU
 uMouM3mDjIkTsxmAFzVbPbAvRknr6UuDYoI6U4p7TwJaV2cTGVgyyRYg+EMFZLoJ40yOvFF5m
 YoeDJiFlFwRWJTxe/HVRkvnzwd9NyMx34rEsl4NsQfs05Bmm63kTZyUN9FVUnSlLu+8k3L4YE
 3fKf0Xt7zBfVNv07tLlQc5Jqwl2q95pvJrlR1L9tUt4r3fyyYq46HM6Mzta2B006aSeTWLvh5
 9yahqWkA0EeStfbn7vYas2OtSEHlj7oujDZXzqJtVhp3R9Pseia1rhRsok1vH/rov8h+cvjMR
 JLOgsXrx+P+oTm4pTNZUkskMpubfcUKptXqTQhszVRUbvj1Ceaqxn7FVoUEPojOVN8nAHCbPo
 9xFEOoFK+2u2QbZCHIDQBELzKj0wZAr2X2/28VhV13YIYXv6U9KzQxt2NJdpwBgvhvGOJsDko
 zh0uOhYlvHiPv6ReHiUB07hi7mYUMBKjtPj+AaP31wOEXaTfxLF8NLWrRzfmDiASPj2h5klsX
 17Vsv+fUprNSt0aUO7kty66ZHE2I/CqEuM7/Amvv8iFmWTSVLfe287CAseiD+ZQLM0E33luS7
 G4KiO1ymE9U2W2d/CFgRYzLf/+wvqsyPxzwy/AmpzIYELb6D3L9Ii/FI7fqXFXGqmVspwOSts
 lQHBGSOlcomzLI0DXxGg4yYwrXW3PvFzwcy89ES+D7wprIHnTwwywurtuws5b8BFxg40on2gV
 KFbMXPSiLacx5TXnLAv5LBNQ==



=E5=9C=A8 2024/9/27 19:25, Anand Jain =E5=86=99=E9=81=93:
> This feature balances I/O across the striped devices when reading from
> RAID1 blocks.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/sysfs.c   |  4 ++++
>   fs/btrfs/volumes.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  7 ++++++
>   3 files changed, 64 insertions(+)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 03926ad467c9..18fb35a887c6 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1305,7 +1305,11 @@ static ssize_t btrfs_temp_fsid_show(struct kobjec=
t *kobj,
>   }
>   BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>
> +#ifdef CONFIG_BTRFS_DEBUG
> +static const char * const btrfs_read_policy_name[] =3D { "pid", "rotati=
on" };
> +#else
>   static const char * const btrfs_read_policy_name[] =3D { "pid" };
> +#endif
>
>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>   				      struct kobj_attribute *a, char *buf)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 995b0647f538..c130a27386a7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5859,6 +5859,54 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *=
fs_info, u64 logical, u64 len)
>   	return ret;
>   }
>
> +#ifdef CONFIG_BTRFS_DEBUG

It would be much better to utilize CONFIG_BTRFS_EXPERIMENTAL.
CONFIG_BTRFS_DEBUG is now for pure debug purposes.

Thanks,
Qu

> +struct stripe_mirror {
> +	u64 devid;
> +	int map;
> +};
> +
> +static int btrfs_cmp_devid(const void *a, const void *b)
> +{
> +	struct stripe_mirror *s1 =3D (struct stripe_mirror *)a;
> +	struct stripe_mirror *s2 =3D (struct stripe_mirror *)b;
> +
> +	if (s1->devid < s2->devid)
> +		return -1;
> +	if (s1->devid > s2->devid)
> +		return 1;
> +	return 0;
> +}
> +
> +static int btrfs_read_rotation(struct btrfs_chunk_map *map, int first,
> +			       int num_stripe)
> +{
> +	struct stripe_mirror stripes[4] =3D {0}; //4: for testing, works for n=
ow.
> +	struct btrfs_fs_devices *fs_devices;
> +	u64 devid;
> +	int index, j, cnt;
> +	int next_stripe;
> +
> +	index =3D 0;
> +	for (j =3D first; j < first + num_stripe; j++) {
> +		devid =3D map->stripes[j].dev->devid;
> +
> +		stripes[index].devid =3D devid;
> +		stripes[index].map =3D j;
> +
> +		index++;
> +	}
> +
> +	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
> +	     btrfs_cmp_devid, NULL);
> +
> +	fs_devices =3D map->stripes[first].dev->fs_devices;
> +	cnt =3D atomic_inc_return(&fs_devices->total_reads);
> +	next_stripe =3D stripes[cnt % num_stripe].map;
> +
> +	return next_stripe;
> +}
> +#endif
> +
>   static int find_live_mirror(struct btrfs_fs_info *fs_info,
>   			    struct btrfs_chunk_map *map, int first,
>   			    int dev_replace_is_ongoing)
> @@ -5888,6 +5936,11 @@ static int find_live_mirror(struct btrfs_fs_info =
*fs_info,
>   	case BTRFS_READ_POLICY_PID:
>   		preferred_mirror =3D first + (current->pid % num_stripes);
>   		break;
> +#ifdef CONFIG_BTRFS_DEBUG
> +	case BTRFS_READ_POLICY_ROTATION:
> +		preferred_mirror =3D btrfs_read_rotation(map, first, num_stripes);
> +		break;
> +#endif
>   	}
>
>   	if (dev_replace_is_ongoing &&
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 4481575dd70f..81701217dbb9 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -303,6 +303,10 @@ enum btrfs_chunk_allocation_policy {
>   enum btrfs_read_policy {
>   	/* Use process PID to choose the stripe */
>   	BTRFS_READ_POLICY_PID,
> +#ifdef CONFIG_BTRFS_DEBUG
> +	/* Balancing raid1 reads across all striped devices */
> +	BTRFS_READ_POLICY_ROTATION,
> +#endif
>   	BTRFS_NR_READ_POLICY,
>   };
>
> @@ -431,6 +435,9 @@ struct btrfs_fs_devices {
>   	enum btrfs_read_policy read_policy;
>
>   #ifdef CONFIG_BTRFS_DEBUG
> +	/* read counter for the filesystem */
> +	atomic_t total_reads;
> +
>   	/* Checksum mode - offload it or do it synchronously. */
>   	enum btrfs_offload_csum_mode offload_csum_mode;
>   #endif


