Return-Path: <linux-btrfs+bounces-19504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E1ACA23FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 04:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E9083003071
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 03:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96E2FCC1E;
	Thu,  4 Dec 2025 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Se+EGvS0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5502D0638
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764818410; cv=none; b=jzcNXw+Olw178dkPmmTYc6aCrQLQUZZUJMpvP2ahpevXI9n8gXkvNAOvP+u+AakKcL5Da1RzyJ1FGP7Xc+QMPjef4hhzyz2cuGHe285QwyTil6dbeN8NYmtvJzmkC82+F9kBJ0lxuiGKvVGS+8NIa1/o4xqs4Cq49wad6O+T2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764818410; c=relaxed/simple;
	bh=ObAPagHi57zIIuf04BfrQYTUDw95uT2PybqZckozOAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uKWMQQSsVSoNqHcjYNLeZrhF1tdtk+EKMaN5ghie2RqERAcJKtuMj4jMyqxdPfNkHT0LQLK+VhLydKWWleQ9d9PLCQStqt+4PXdrTtB5SoN3yHMNPF+YVHzLdFupo18ichnypNUrRujXruXvFqx08fFBNWGes91ebwgd/W86p+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Se+EGvS0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764818397; x=1765423197; i=quwenruo.btrfs@gmx.com;
	bh=wXsA+DLoZVzzlcsa63cgqYPGCrHut/Rv0fyrLKjNyXw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Se+EGvS0UallMPtUBWc+8xe4HLYgiqWUC6tlXpjpT1toe+aFpQoFO+EO2lz7OIX3
	 OrAH7Mm897/p4RToFgk8+WFyLYaHHDWsbvUvmtTWovYJpQZKK12RyqKWpE1kGPMTo
	 Oi/CTF6DefMzTZtWEQuXEewvY6JSpunJ6ek1MpqnXFej7bmXXlAaTYmwc/AxD/Xru
	 sZH+GzB/gspqxDfXlChIgIbpzkP6IHnO8jERN9t/vSse2Zno1GT0l9A+IRN+eYuhW
	 NgZ0EWtCI3f3zi9fP5wzb125Mvkzs7L0U8MT4F0MLc/3/d1ojW+lpy8hz8zWriNBm
	 t+gj7VRThRkzl6mwBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHG8g-1vDkLM2F04-0080e3; Thu, 04
 Dec 2025 04:19:57 +0100
Message-ID: <c7cf2a0b-8ee8-4527-9b50-dee1916fa1d1@gmx.com>
Date: Thu, 4 Dec 2025 13:49:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: relax squota parent qgroup deletion rule
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1764796022.git.boris@bur.io>
 <4b63df0e26492b520b8b145e1d95e356ad89d51a.1764796022.git.boris@bur.io>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <4b63df0e26492b520b8b145e1d95e356ad89d51a.1764796022.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LL0k2WTSZyFXbI6lLs/kXdCdZdMQChZa8m0jcAsi5i8zQ+Gx0Fu
 patnp/OS5dRS+xIQtdtfZIFEnKc7y2PipX7q575qASHoHtuYzFbN8Skc3ROleVogFXesrzO
 GBVD+Z2xU6LQhnkFoT9s2SlqT0SfMKgJ5fOsteZGp+55CaZ5zZMJXFoLzZ9/6HJNj/jncx3
 UqTMliKQtMzXSJg2ZYe6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q7Li8LxinxI=;dggep+L1P6Aq9NLZ7wsFcvtmBfg
 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
 AiaZ0BG4=



=E5=9C=A8 2025/12/4 07:41, Boris Burkov =E5=86=99=E9=81=93:
> Currently, with squotas, we do not allow removing a parent qgroup with
> no members if it still has usage accounted to it. This makes it really
> difficult to recover from accounting bugs, as we have no good way of
> getting back to 0 usage.
>=20
> Instead, allow deletion (it's safe at 0 members..) while still warning
> about the inconsistency by adding a squota parent check.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/qgroup.c | 51 +++++++++++++++++++++++++++++++++--------------
>   1 file changed, 36 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9e7e0c2e98ac..731ab71ff8ef 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1458,6 +1458,7 @@ static void qgroup_iterator_clean(struct list_head=
 *head)
>   	}
>   }
>  =20
> +

A stray new line.

Otherwise looks good to me. I'll reply on the cover letter.

Thanks,
Qu

>   /*
>    * The easy accounting, we're updating qgroup relationship whose child=
 qgroup
>    * only has exclusive extents.
> @@ -1730,6 +1731,36 @@ int btrfs_create_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
>   	return ret;
>   }
>  =20
> +static bool can_delete_parent_qgroup(struct btrfs_qgroup *qgroup)
> +
> +{
> +	ASSERT(btrfs_qgroup_level(qgroup->qgroupid));
> +	return list_empty(&qgroup->members);
> +}
> +
> +/*
> + * Return true if we can delete the squota qgroup and false otherwise.
> + *
> + * Rules for whether we can delete:
> + *
> + * A subvolume qgroup can be removed iff the subvolume is fully deleted=
, which
> + * is iff there is 0 usage in the qgroup.
> + *
> + * A higher level qgroup can be removed iff it has no members.
> + * Note: We audit its usage to warn on inconsitencies without blocking =
deletion.
> + */
> +static bool can_delete_squota_qgroup(struct btrfs_fs_info *fs_info, str=
uct btrfs_qgroup *qgroup)
> +{
> +	ASSERT(btrfs_qgroup_mode(fs_info) =3D=3D BTRFS_QGROUP_MODE_SIMPLE);
> +
> +	if (btrfs_qgroup_level(qgroup->qgroupid) > 0) {
> +		squota_check_parent_usage(fs_info, qgroup);
> +		return can_delete_parent_qgroup(qgroup);
> +	}
> +
> +	return !(qgroup->rfer || qgroup->excl || qgroup->rfer_cmpr || qgroup->=
excl_cmpr);
> +}
> +
>   /*
>    * Return 0 if we can not delete the qgroup (not empty or has children=
 etc).
>    * Return >0 if we can delete the qgroup.
> @@ -1740,23 +1771,13 @@ static int can_delete_qgroup(struct btrfs_fs_inf=
o *fs_info, struct btrfs_qgroup
>   	struct btrfs_key key;
>   	BTRFS_PATH_AUTO_FREE(path);
>  =20
> -	/*
> -	 * Squota would never be inconsistent, but there can still be case
> -	 * where a dropped subvolume still has qgroup numbers, and squota
> -	 * relies on such qgroup for future accounting.
> -	 *
> -	 * So for squota, do not allow dropping any non-zero qgroup.
> -	 */
> -	if (btrfs_qgroup_mode(fs_info) =3D=3D BTRFS_QGROUP_MODE_SIMPLE &&
> -	    (qgroup->rfer || qgroup->excl || qgroup->excl_cmpr || qgroup->rfer=
_cmpr))
> -		return 0;
> +	/* Since squotas cannot be inconsistent, they have special rules for d=
eletion. */
> +	if (btrfs_qgroup_mode(fs_info) =3D=3D BTRFS_QGROUP_MODE_SIMPLE)
> +		return can_delete_squota_qgroup(fs_info, qgroup);
>  =20
>   	/* For higher level qgroup, we can only delete it if it has no child.=
 */
> -	if (btrfs_qgroup_level(qgroup->qgroupid)) {
> -		if (!list_empty(&qgroup->members))
> -			return 0;
> -		return 1;
> -	}
> +	if (btrfs_qgroup_level(qgroup->qgroupid))
> +		return can_delete_parent_qgroup(qgroup);
>  =20
>   	/*
>   	 * For level-0 qgroups, we can only delete it if it has no subvolume


