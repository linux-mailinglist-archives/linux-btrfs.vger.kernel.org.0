Return-Path: <linux-btrfs+bounces-16259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D54B308E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 00:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A959B162B42
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73352EA73C;
	Thu, 21 Aug 2025 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dWTbjwbH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572A18DB35
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813964; cv=none; b=mW3kXpWld4WS/zlyN4auTvHk52G6/JaZlYuFSAFX584reefcok6YsHKfMxNsE40u0oFYFfzLDcp8NKfkgFHrzqP9MNqUCebrcB6SictyYwKBVgQXRuMuH7MZ78bmTj26elDdKSwiv7wEMxoX7cBhUQC+1kcAjihC6u5DOAbZf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813964; c=relaxed/simple;
	bh=d0BFbq1hNVWI/4Sqgmtuz2v678vvdIfh4BIxu0TlzlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S6uUi3hKn2w2vS67Zrsl81TwN2FzWDDRgCuC5B3mVXFTlMc78POivaweqdXTITKY4zvNVSDkVTMydRW5HN2UIf/hA+ekkFv/ha3+udTGoaO+SAwm8N1QWsIG77PcJMotoyBNoQgF6NVc1G+hYvN+SrOy7lg6R6pO16YiFTCVbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dWTbjwbH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755813959; x=1756418759; i=quwenruo.btrfs@gmx.com;
	bh=ilQv/Tr2V5KON/eCAjo1PQ9inyxJYl/FOiP0K2T8kbM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dWTbjwbHDNpG9yLYmflQ4zZpFz95BowAv74bX/aPVH5EuN5Ht26u7uS8H+gy//No
	 C0J7/+uF3+Oi53vpt57+e+REKAjfeFJYxRMFiTlAgYdBJPYkwAt09mGb3iVmCpnQ1
	 X+2C5SCNzFnI5mnIFbehciTEniai1jU5FLW8Eixf8ogTvHbPWLOiJ68KhIIWe4kuP
	 q+RYka7mpwehLDguRC/AZcqBmcIDR00z3TpkBnMBBv7di62USaJ9XzhLCBn6pzSHW
	 3qUmXk83wuSftu4Le/ISfvzAv5OG/nXmRLi03x86NA5R31bKX2jswwykiPifXErtN
	 fQNBCBPIeN3I8aSc7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9Mtg-1uS4PK27zY-00rZ6L; Fri, 22
 Aug 2025 00:05:59 +0200
Message-ID: <0a4de604-453f-4984-aa19-b6f9f958b6e1@gmx.com>
Date: Fri, 22 Aug 2025 07:35:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix squota _cmpr stats leak
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <052d87d0f70d66e7f50c45e3ec095056ae0cb4f4.1755813444.git.boris@bur.io>
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
In-Reply-To: <052d87d0f70d66e7f50c45e3ec095056ae0cb4f4.1755813444.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9aRl7HFq2sKKVGoBNOcH/pfSpC2Z1A4sKwMPwTbcA0AnHe1I0Ka
 OQAjOdxKUfLY556iodH99mkko0ozx1NOZlfVuVtC9N3Mpqdcen6WdkfLvGdnFef12rD7K8q
 0SXDjzYrfQKaCNZWmdVrm+9fVixJxpT90wqBOgqTet9Jd3B+F6SlAXj+CdKts1+PMKv7DWn
 h/yqMl0qHFRq/Zq8kL9CA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QBudsMcqos8=;7I7d9aYr/mHRiVLOt38kYX3fD9m
 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
 NyYjx/X6JIoZ1IZcPqK0Dbr63K3U



=E5=9C=A8 2025/8/22 07:28, Boris Burkov =E5=86=99=E9=81=93:
> The following workload on a squota enabled fs:
>   btrfs subvol create mnt/sv
>   btrfs qgroup create 1/1 mnt
>   btrfs qgroup assign mnt/sv 1/1 mnt
>   btrfs qgroup delete mnt/sv
>   # make the cleaner thread run
>   btrfs filesystem sync mnt; sleep 1; btrfs filesystem sync mnt
>   btrfs qgroup destroy 1/1 mnt
>=20
> will fail with EBUSY. The reason is that 1/1 does the quick accounting
> when we assign sv to it, gaining its exclusive usage as excl and
> excl_cmpr. But then when we delete sv, the decrement happens via
> record_squota_delta() which does not update excl_cmpr, as squotas does
> not make any distinction between compressed and normal extents. Thus,
> we increment excl_cmpr but never decrement it, and are unable to delete
> 1/1. The two possible fixes are to make squota always mirror excl and
> excl_cmpr or to make the fast accounting separately track the plain and
> cmpr numbers. The latter felt cleaner to me so that is what I opted for.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/qgroup.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 6352cd29ff89..2d8667cc609a 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1455,6 +1455,7 @@ static int __qgroup_excl_accounting(struct btrfs_f=
s_info *fs_info, u64 ref_root,
>   	struct btrfs_qgroup *qgroup;
>   	LIST_HEAD(qgroup_list);
>   	u64 num_bytes =3D src->excl;
> +	u64 num_bytes_cmpr =3D src->excl_cmpr;
>   	int ret =3D 0;
>  =20
>   	qgroup =3D find_qgroup_rb(fs_info, ref_root);
> @@ -1466,11 +1467,12 @@ static int __qgroup_excl_accounting(struct btrfs=
_fs_info *fs_info, u64 ref_root,
>   		struct btrfs_qgroup_list *glist;
>  =20
>   		qgroup->rfer +=3D sign * num_bytes;
> -		qgroup->rfer_cmpr +=3D sign * num_bytes;
> +		qgroup->rfer_cmpr +=3D sign * num_bytes_cmpr;
>  =20
>   		WARN_ON(sign < 0 && qgroup->excl < num_bytes);
> +		WARN_ON(sign < 0 && qgroup->excl_cmpr < num_bytes_cmpr);
>   		qgroup->excl +=3D sign * num_bytes;
> -		qgroup->excl_cmpr +=3D sign * num_bytes;
> +		qgroup->excl_cmpr +=3D sign * num_bytes_cmpr;
>  =20
>   		if (sign > 0)
>   			qgroup_rsv_add_by_qgroup(fs_info, qgroup, src);


