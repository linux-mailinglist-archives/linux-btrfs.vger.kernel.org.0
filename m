Return-Path: <linux-btrfs+bounces-21855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGGKBQornWmfNAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21855-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 05:37:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE85181AFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 05:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A2183004683
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 04:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2D27A927;
	Tue, 24 Feb 2026 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sE8ZYw65"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717545464D;
	Tue, 24 Feb 2026 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771907842; cv=none; b=RsypzuC9K+RepxpuIRxhZhv5wmYXb/L5QCZNfSaa/W5yc3MMzRt7bf2DniqfSScA79lSulqJHVYEoYE9IQl6j7Bp9XXdqT0JVIYfYA0pN3JsapIWjsHBL+s7f8SC8wJOYJWGbhaTIBERnyTCEx2z/+vsEfJyeUtzVfXtdhqXfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771907842; c=relaxed/simple;
	bh=JpLrFeImJU8tPL6K7qWOC1iXesPu4dm+wJhCNETFhy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nt44FKd6jK/xBRMFMaUR15WXnytNgZc559em8aKQvSSmy+azEt65F51mO9wgDXZcFJPwJvS5FpVjlFQJapkPDhP57wjVCHX/VfX5+5x7BuAC2I8LK09++7ZRyyqYxIrCq05VvNEJjSd8cR1AUGZ8MBsDD5GIhmFulJbWH+X3bvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sE8ZYw65; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771907836; x=1772512636; i=quwenruo.btrfs@gmx.com;
	bh=pbRqie850jaDuaCgPyIG9KW2UJjTEeN29JkMfA3PO3s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sE8ZYw65GXV5wCQO31vwYfioWhNahsoxpV6z3VXAr8fhN6S8JgYFhcuLpZBleewW
	 A7tMlxkHHRliQscqWi4X3BnMhJQhXbcNyd3s+HYku7B7NkXjq3PcO6xKDJ4h4DXvx
	 NjvRpTDZB9MTA6e+3XyryZf850psDfsQcdfZb2ATybBqcEXPrn6VACBKAql9n6FuO
	 eX3wG/s/Pz8hrn4ZbjVzurb5ZYIxh/8ASfcm5RJ6mDZ+8C2bwKOQuhpX9h3si8iTS
	 p8N8lZrFZgphooaxJ4dCAoGhcb37XJC80vGk2+hCnj7ipqJGTSVDW+WciynuGhyYG
	 n2uFSGhT7hpLfxk3vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MoO2E-1vNrBE0U12-00e3jF; Tue, 24
 Feb 2026 05:37:16 +0100
Message-ID: <69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
Date: Tue, 24 Feb 2026 15:07:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
To: =?UTF-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>,
 dsterba@suse.com
Cc: clm@fb.com, naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kees@kernel.org
References: <20260223234451.277369-1-mssola@mssola.com>
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
In-Reply-To: <20260223234451.277369-1-mssola@mssola.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/wWBGrFGsIZbgvjptbhA/IDEhTtpYz+1MtxnW7HSRXix0B1Aigd
 H9CmKkP8vOZ5JirnGqJZulkmVu7E2Piik0cPphEJ7AT1owl7RMc51dej9akFDa2YKmaCkNM
 Z7WHQAgELrcAfNaN+NOcvzHMiqnC5k1yvOs+Ze99bOY7KG8560SGxTBUVzOQY6no3P3aQxb
 nzK/Dkk0Bo3LxGrNwAa/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jjWMC0v+UQo=;Uo2sM3eRTG2PUuLz0We/Bx10YtY
 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
 2P+56Az4=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21855-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mssola.com:email]
X-Rspamd-Queue-Id: 3EE85181AFB
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/24 10:14, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=93=
:
> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
> introduced, among many others, the kzalloc_objs() helper, which has some
> benefits over kcalloc().
>=20
> Cc: Kees Cook <kees@kernel.org>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
> ---
>   fs/btrfs/block-group.c       | 2 +-
>   fs/btrfs/raid56.c            | 8 ++++----
>   fs/btrfs/tests/zoned-tests.c | 2 +-
>   fs/btrfs/volumes.c           | 6 ++----
>   fs/btrfs/zoned.c             | 5 ++---
>   5 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 37bea850b3f0..8d85b4707690 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info=
, u64 chunk_start,
>   	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>   		io_stripe_size =3D btrfs_stripe_nr_to_offset(nr_data_stripes(map));
>  =20
> -	buf =3D kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
> +	buf =3D kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);

Not sure if we should use *buf for the type.

I still remember we had some bugs related to incorrect type usage.

Another thing is, we may not want to use the kzalloc version.
We don't want to waste CPU time just to zero out the content meanwhile=20
we're ensured to re-assign the contents.

Thus kmalloc_objs() maybe better.

Thanks,
Qu


>   	if (!buf) {
>   		ret =3D -ENOMEM;
>   		goto out;
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 02105d68accb..1ebfed8f0a0a 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2110,8 +2110,8 @@ static int recover_sectors(struct btrfs_raid_bio *=
rbio)
>   	 * @unmap_array stores copy of pointers that does not get reordered
>   	 * during reconstruction so that kunmap_local works.
>   	 */
> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOF=
S);
>   	if (!pointers || !unmap_array) {
>   		ret =3D -ENOMEM;
>   		goto out;
> @@ -2844,8 +2844,8 @@ static int recover_scrub_rbio(struct btrfs_raid_bi=
o *rbio)
>   	 * @unmap_array stores copy of pointers that does not get reordered
>   	 * during reconstruction so that kunmap_local works.
>   	 */
> -	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> -	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> +	pointers =3D kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
> +	unmap_array =3D kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOF=
S);
>   	if (!pointers || !unmap_array) {
>   		ret =3D -ENOMEM;
>   		goto out;
> diff --git a/fs/btrfs/tests/zoned-tests.c b/fs/btrfs/tests/zoned-tests.c
> index da21c7aea31a..2bc3b14baa41 100644
> --- a/fs/btrfs/tests/zoned-tests.c
> +++ b/fs/btrfs/tests/zoned-tests.c
> @@ -58,7 +58,7 @@ static int test_load_zone_info(struct btrfs_fs_info *f=
s_info,
>   		return -ENOMEM;
>   	}
>  =20
> -	zone_info =3D kcalloc(test->num_stripes, sizeof(*zone_info), GFP_KERNE=
L);
> +	zone_info =3D kzalloc_objs(*zone_info, test->num_stripes, GFP_KERNEL);
>   	if (!zone_info) {
>   		test_err("cannot allocate zone info");
>   		return -ENOMEM;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e15e138c515b..c0cf8f7c5a8e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5499,8 +5499,7 @@ static int calc_one_profile_avail(struct btrfs_fs_=
info *fs_info,
>   		goto out;
>   	}
>  =20
> -	devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_info)=
,
> -			       GFP_NOFS);
> +	devices_info =3D kzalloc_objs(*devices_info, fs_devices->rw_devices, G=
FP_NOFS);
>   	if (!devices_info) {
>   		ret =3D -ENOMEM;
>   		goto out;
> @@ -6067,8 +6066,7 @@ struct btrfs_block_group *btrfs_create_chunk(struc=
t btrfs_trans_handle *trans,
>   	ctl.space_info =3D space_info;
>   	init_alloc_chunk_ctl(fs_devices, &ctl);
>  =20
> -	devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_info)=
,
> -			       GFP_NOFS);
> +	devices_info =3D kzalloc_objs(*devices_info, fs_devices->rw_devices, G=
FP_NOFS);
>   	if (!devices_info)
>   		return ERR_PTR(-ENOMEM);
>  =20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index ab330ec957bc..851b0de7bed7 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1697,8 +1697,7 @@ static int btrfs_load_block_group_raid10(struct bt=
rfs_block_group *bg,
>   		return -EINVAL;
>   	}
>  =20
> -	raid0_allocs =3D kcalloc(map->num_stripes / map->sub_stripes, sizeof(*=
raid0_allocs),
> -			       GFP_NOFS);
> +	raid0_allocs =3D kzalloc_objs(*raid0_allocs, map->num_stripes / map->s=
ub_stripes, GFP_NOFS);
>   	if (!raid0_allocs)
>   		return -ENOMEM;
>  =20
> @@ -1916,7 +1915,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_=
block_group *cache, bool new)
>  =20
>   	cache->physical_map =3D map;
>  =20
> -	zone_info =3D kcalloc(map->num_stripes, sizeof(*zone_info), GFP_NOFS);
> +	zone_info =3D kzalloc_objs(*zone_info, map->num_stripes, GFP_NOFS);
>   	if (!zone_info) {
>   		ret =3D -ENOMEM;
>   		goto out;


