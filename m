Return-Path: <linux-btrfs+bounces-17218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20FBA356A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF20F1C011BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB92EE263;
	Fri, 26 Sep 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DyIXvtPG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC722D4F9
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882258; cv=none; b=GolXRsiF54omIk6jMQhKiWL1wQLDib51bBbRqADf5adEBM6m2gg7CcJ6D4HE8XVTN6obC4gW3SW+nUd0GgFERLm95/LAm+SCGLe7K6Hvy6fyi7sYcozfKt66jj7lOlO5L6GuZM897MT51lCKRRtNabEZAOxrxgVqPofWTK8Q2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882258; c=relaxed/simple;
	bh=mcQxfHRN3ErO+reAmjOXbsgn/V0DB2joHitaoQOXbk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UW9d38EGsR9tLR7azKD6SezCd5hFp94esaRrcCqKzCJSUx/1zyQwkuEAowWFlsf84pt3P1g5D6iSXR3L623kzU0nniaclctoD0+mKulJAz8+HkzFrdL+cKv+qPAcQRMX2r49L/GxNjKVjQ/mwO21PZ9lqd52u3+qrtKwoh6XGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DyIXvtPG; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758882253; x=1759487053; i=quwenruo.btrfs@gmx.com;
	bh=ifhQ39BSFc0daj0ZiMZWXZaDPM8iQNEgwppThvo9gUQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DyIXvtPGDbvYYZR13mfnWP/0qosoQ4F3wSBakOHacEIcj3N5Sc1orEXvuQO67pFt
	 IqM5d/Jn+Fr4Qn8ASpPg6RTzkDfhcpw6S7/OWw+ET1w/rJN7tylslEKS6egvWCvsC
	 PdQvULjxUMrh9G/U01m+qfsZo/aA/6Jn5xxhnjmDMXrif9sOusjBbxyUT7nZmloHk
	 Nbb28COynQGDFHz2bE02ztHa+82wqx4PUXYnyTfdy2F3eFiY58l51IEo/uUdIq843
	 tUYmEWEaXslGNP3XxO+Lfe8f2dCKiIGX5JqzwLdrieMeie0yq1dl2gHSOurndyBvL
	 D8d2nqiOhC4n+UKmEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzuB-1uTqnT1teB-00cugI; Fri, 26
 Sep 2025 12:24:12 +0200
Message-ID: <e3e014fa-9987-47b4-9464-5cf78e9abf9a@gmx.com>
Date: Fri, 26 Sep 2025 19:54:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix trivial -Wshadow warnings
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20250926094730.3598980-1-dsterba@suse.com>
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
In-Reply-To: <20250926094730.3598980-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SQBvLmjN3PQ0h+OX9LdqtcCF/PwcptEpBZfhfxmZqNhlG4+cr/K
 VjjTrBV0U3Lzhvs7H5cZ/ZlLaPngVkPpsC1Qie+V48tOSf9FlWwPEMB5WS+M561Zylqk9FH
 9Xuy+f7Aqxau66Mzbbka+GIYN6VAgQAKOIRfAeU8Gk5C7eAVMb1q97JMcKJiszhUvanmNa0
 +IOXu9mRIjVmK9T9hViIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tzHpMCCzB20=;Uf/rZPLi+T1hKaAdNb8WXK6xCch
 +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
 NUU7JkoCAZ6NNQi8DI1y9pHlKMDLp0bi5cQ=



=E5=9C=A8 2025/9/26 19:17, David Sterba =E5=86=99=E9=81=93:
> When compiling with -Wshadow (also in 'make W=3D2' build) there are
> several reports of shadowed variables that seem to be harmless:
>=20
> - btrfs_do_encoded_write() - we can reuse 'ordered', there's no previous
> 			     value that would need to be preserved
>=20
> - scrub_write_endio() - we need a standalone 'i' for bio iteration
>=20
> - scrub_stripe() - duplicate ret2 for errors that must not overwrite 're=
t'
>=20
> - btrfs_subpage_set_writeback() - 'flags' is used for another irqsave lo=
ck
>                                    but is not overwritten when reused fo=
r xarray
> 				  due to scoping, but for clarity let's rename it
>=20
> - process_dir_items_leaf() - duplicate 'ret', used only for immediate ch=
ecks
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although I'm still not 100% sure if using the variable in the function=20
scope is really any safer.

The last call site is a good example, it's only safe to use @ret from=20
the function scope as we immediately return after an error.

If we use @ret to record some error but not immediately return, then we=20
can override the previous error code and cause problems.


I'd prefer to always use the local variable, and remove the one in the=20
larger scope, but unfortunately all call sites have directly usage=20
inside the function...

Thanks,
Qu
> ---
>   fs/btrfs/inode.c    | 2 --
>   fs/btrfs/scrub.c    | 4 +---
>   fs/btrfs/subpage.c  | 6 +++---
>   fs/btrfs/tree-log.c | 3 ---
>   4 files changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 02cb081697fea4..ac2fd589697da4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9822,8 +9822,6 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb,=
 struct iov_iter *from,
>   	}
>  =20
>   	for (;;) {
> -		struct btrfs_ordered_extent *ordered;
> -
>   		ret =3D btrfs_wait_ordered_range(inode, start, num_bytes);
>   		if (ret)
>   			goto out_folios;
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 4691d0bdb2e86c..d450ccd3fc7c85 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1284,7 +1284,7 @@ static void scrub_write_endio(struct btrfs_bio *bb=
io)
>   		bitmap_set(&stripe->write_error_bitmap, sector_nr,
>   			   bio_size >> fs_info->sectorsize_bits);
>   		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
> -		for (int i =3D 0; i < (bio_size >> fs_info->sectorsize_bits); i++)
> +		for (i =3D 0; i < (bio_size >> fs_info->sectorsize_bits); i++)
>   			btrfs_dev_stat_inc_and_print(stripe->dev,
>   						     BTRFS_DEV_STAT_WRITE_ERRS);
>   	}
> @@ -2527,8 +2527,6 @@ static noinline_for_stack int scrub_stripe(struct =
scrub_ctx *sctx,
>   	}
>  =20
>   	if (sctx->is_dev_replace && ret >=3D 0) {
> -		int ret2;
> -
>   		ret2 =3D sync_write_pointer_for_zoned(sctx,
>   				chunk_logical + offset,
>   				map->stripes[stripe_index].physical,
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 5ca8d4db67220c..01bf58fa92aa2e 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -460,12 +460,12 @@ void btrfs_subpage_set_writeback(const struct btrf=
s_fs_info *fs_info,
>   	if (!folio_test_dirty(folio)) {
>   		struct address_space *mapping =3D folio_mapping(folio);
>   		XA_STATE(xas, &mapping->i_pages, folio->index);
> -		unsigned long flags;
> +		unsigned long xa_flags;
>  =20
> -		xas_lock_irqsave(&xas, flags);
> +		xas_lock_irqsave(&xas, xa_flags);
>   		xas_load(&xas);
>   		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> -		xas_unlock_irqrestore(&xas, flags);
> +		xas_unlock_irqrestore(&xas, xa_flags);
>   	}
>   	spin_unlock_irqrestore(&bfs->lock, flags);
>   }
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 6aad6b65522b21..08d72506a3d2fb 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4154,7 +4154,6 @@ static int process_dir_items_leaf(struct btrfs_tra=
ns_handle *trans,
>   	for (int i =3D path->slots[0]; i < nritems; i++) {
>   		struct btrfs_dir_item *di;
>   		struct btrfs_key key;
> -		int ret;
>  =20
>   		btrfs_item_key_to_cpu(src, &key, i);
>  =20
> @@ -4224,8 +4223,6 @@ static int process_dir_items_leaf(struct btrfs_tra=
ns_handle *trans,
>   	}
>  =20
>   	if (batch_size > 0) {
> -		int ret;
> -
>   		ret =3D flush_dir_items_batch(trans, inode, src, dst_path,
>   					    batch_start, batch_size);
>   		if (ret < 0)


