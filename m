Return-Path: <linux-btrfs+bounces-5900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC89130D3
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2024 01:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A281C21B21
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 23:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8EA16F27D;
	Fri, 21 Jun 2024 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="f2qxcywf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF515532C
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011728; cv=none; b=Tll+036yV6fEr2+SlcPffKV+/m93rzMNIv5SZkbHl4ZR1mp76f89jtJgrsrTrp1Nl/QFQFst3++eQH/SstZJ/+78+fEK2/MTTyfAce7hAGKphEOdz/BAQZbVfRmLDIkzWKqnZUnVQ2hPRyE4ATnqSK1SP8auDT2vNo4gl3kpscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011728; c=relaxed/simple;
	bh=LYdGuhPSCLLvhRNjYOJDUqLozdc9z04BcA5sqzznE9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kQkq8eyj/+dh/OkIb6jkdmIyOU1TmEsBla+2wHHM4AyVb8XPXYPgk3LsQwhP/Jvfiqme2noko4IpPrB12k8/EKPysber/tFPZhZlysNJ2mfvBmGNcHFlZdE3gnrEwXjMOXexElIPQ9fMQZdg3EjWIVuFaEp58RqG6DcRNzZ9jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=f2qxcywf; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719011716; x=1719616516; i=quwenruo.btrfs@gmx.com;
	bh=zvtp0UhLdd1I4rPsnQCFmq8DwcJ8GBtMKaAUpajSRVI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f2qxcywfC4pIR9NW1Tlld/xdjPbOt6Zt2kgWG22eH852aRON77uW1XtItzPUyhtx
	 Pzz1M6Ym4S7CiPGDN8b3itc0oJJZmnypxL71iQxVvrnOVOJc6VHiNIl9Y/HDcDQgv
	 g8h6l/X0Rr97ZytOpHqYBLZc26VQQExeyIOBJAxa0A/Q/aLKycdlG7Kd2aU/Gydk0
	 4gKE1hbB6dKZPOYEI4c5je8apQaK7SLFINv/UTvNgBiq5KLAHk1d0ebweicOyazK6
	 dj+T3S0ywBQtOg0TMgP2gAFALVcmYaRoSs4XObdrcdsk+n7qUAd1P7MOVWdDcnlw3
	 qu+hk9H15xx9HCIf7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt79P-1sf4DV0XPt-00uxo7; Sat, 22
 Jun 2024 01:15:16 +0200
Message-ID: <fa169d4b-9fbb-4a61-a4a8-4d2e46a7de1c@gmx.com>
Date: Sat, 22 Jun 2024 08:45:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: preallocate ulist memory for qgroup rsv
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
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
In-Reply-To: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E7DkglrdbwTb0M5r4yQ8558/IXcmBQO2qgBr5ZMDGFNCwzbuFz6
 3C2eLPbEJvs00VF1NKmTBhI88ISg67sYDOFL7vW2kYpWzoFiap4yWJm/o2KlxstSZu6/1gb
 9xYKNZjcL+pgflG8UfQgZCPRudpz5JLhLTbJzOUghkqeXI59g+CTANyPrQrN1W77pK3xOSP
 LuwsPbek668PDjJx68D8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D4WkmgtPuWs=;4509kR/B5h3YHdcOie6WyJJ5Klg
 OZ1m7HwQlmpas5nMwhRLBf16/tT2Y0IpZqpsiHSPS3TFZhzqR3tGvcODAhayuRmYOIFdAbCs+
 pws3PrGcnzxn8NrRpP0mI+ImPwAILMHXYMh17QVZUL7s/wRzz/VB8wJlUks1esf8QNoZLZAI6
 M+H8JE7X84Dwf0ZAHistpV/NWXtH+RJqDOTf895LGwTVRKc/Q/RWxcwuWYcpBQgcpe1kPMBO1
 cxYxlX3Qp1yPFLrqg1kTjP1p5wgmiFB9p3QaXHaoeF1/qhnKfWX6ds1/+YVIXAIgVjO/H+6RX
 GdFjqVL9TWcMKTr8CmnxY0AP2SoBVTPF76BT9nYUIxVHH7a0uRnp8qihlcrMx0UetJhzupWEA
 W9gdx5oi0/zxYz53Pl1lK40BVFUP9RVKQpfuMqgBnda8tqOJjGqq2zzs3Y04jwV3aiS6Rn1b8
 S59FjSfh2B2u9I3lLCfxmy7pucZKMQHuVNlAoWTCaPoE1OMLqW3JFvY7D8m6CCkjtJHoTrIuj
 CZOI/C4emMGl0IMuCQZYhj0JtMM+/lCYrRJ+kQavmGasR8/4o2PwahEEefl6qt6J3Rk6Rwvio
 mAALd6hcePNLEO/j0h3aLOmrfbt12W62xQwmQZIgBP3uVnugIx6C1rXIdrlaFnDV9gLqivrj/
 GvXtWFtfVVsZsP/lu8PZRNX6b2OmeYs3F/LmPERLGqMGq6a/u3X5PKh9x7+0kTyK6yZbZNGm0
 c4GHuhytLOtaDYCeOAv/Ch7YSi1M1JBRwpzbOQLayoCxd9e+4IUpdtS9dJtp08Ab78qPEoesq
 a+l/oDEdJuMro0ugzx6KKJ1xC0DXwIH1QSzHEq7t7g8LI=



=E5=9C=A8 2024/6/22 08:01, Boris Burkov =E5=86=99=E9=81=93:
> When qgroups are enabled, during data reservation, we allocate the
> ulist_nodes that track the exact reserved extents with GFP_ATOMIC
> unconditionally. This is unnecessary, and we can follow the model
> already employed by the struct extent_state we preallocate in the non
> qgroups case, which should reduce the risk of allocation failures with
> GFP_ATOMIC.
>
> Add a prealloc node to struct ulist which ulist_add will grab when it is
> present, and try to allocate it before taking the tree lock while we can
> still take advantage of a less strict gfp mask. The lifetime of that
> node belongs to the new prealloc field, until it is used, at which point
> it belongs to the ulist linked list.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-io-tree.c |  4 ++++
>   fs/btrfs/extent_io.h      |  5 +++++
>   fs/btrfs/ulist.c          | 21 ++++++++++++++++++---
>   fs/btrfs/ulist.h          |  2 ++
>   4 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index ed2cfc3d5d8a..c54c5d7a5cd5 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -4,6 +4,7 @@
>   #include <trace/events/btrfs.h>
>   #include "messages.h"
>   #include "ctree.h"
> +#include "extent_io.h"
>   #include "extent-io-tree.h"
>   #include "btrfs_inode.h"
>
> @@ -1084,6 +1085,9 @@ static int __set_extent_bit(struct extent_io_tree =
*tree, u64 start, u64 end,
>   		 */
>   		prealloc =3D alloc_extent_state(mask);
>   	}
> +	/* Optimistically preallocate the extent changeset ulist node. */
> +	if (changeset)
> +		extent_changeset_prealloc(changeset, mask);
>
>   	spin_lock(&tree->lock);
>   	if (cached_state && *cached_state) {
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 96c6bbdcd5d6..8b33cfea6b75 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -215,6 +215,11 @@ static inline struct extent_changeset *extent_chang=
eset_alloc(void)
>   	return ret;
>   }
>
> +static inline void extent_changeset_prealloc(struct extent_changeset *c=
hangeset, gfp_t gfp_mask)
> +{
> +	ulist_prealloc(&changeset->range_changed, gfp_mask);
> +}
> +
>   static inline void extent_changeset_release(struct extent_changeset *c=
hangeset)
>   {
>   	if (!changeset)
> diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> index 183863f4bfa4..f35d3e93996b 100644
> --- a/fs/btrfs/ulist.c
> +++ b/fs/btrfs/ulist.c
> @@ -50,6 +50,7 @@ void ulist_init(struct ulist *ulist)
>   	INIT_LIST_HEAD(&ulist->nodes);
>   	ulist->root =3D RB_ROOT;
>   	ulist->nnodes =3D 0;
> +	ulist->prealloc =3D NULL;
>   }
>
>   /*
> @@ -68,6 +69,8 @@ void ulist_release(struct ulist *ulist)
>   	list_for_each_entry_safe(node, next, &ulist->nodes, list) {
>   		kfree(node);
>   	}
> +	kfree(ulist->prealloc);
> +	ulist->prealloc =3D NULL;
>   	ulist->root =3D RB_ROOT;
>   	INIT_LIST_HEAD(&ulist->nodes);
>   }
> @@ -105,6 +108,12 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
>   	return ulist;
>   }
>
> +void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
> +{
> +	if (ulist && !ulist->prealloc)
> +		ulist->prealloc =3D kzalloc(sizeof(*ulist->prealloc), gfp_mask);
> +}
> +
>   /*
>    * Free dynamically allocated ulist.
>    *
> @@ -206,9 +215,15 @@ int ulist_add_merge(struct ulist *ulist, u64 val, u=
64 aux,
>   			*old_aux =3D node->aux;
>   		return 0;
>   	}
> -	node =3D kmalloc(sizeof(*node), gfp_mask);
> -	if (!node)
> -		return -ENOMEM;
> +
> +	if (ulist->prealloc) {
> +		node =3D ulist->prealloc;
> +		ulist->prealloc =3D NULL;
> +	} else {
> +		node =3D kmalloc(sizeof(*node), gfp_mask);
> +		if (!node)
> +			return -ENOMEM;
> +	}
>
>   	node->val =3D val;
>   	node->aux =3D aux;
> diff --git a/fs/btrfs/ulist.h b/fs/btrfs/ulist.h
> index 8e200fe1a2dd..c62a372f1462 100644
> --- a/fs/btrfs/ulist.h
> +++ b/fs/btrfs/ulist.h
> @@ -41,12 +41,14 @@ struct ulist {
>
>   	struct list_head nodes;
>   	struct rb_root root;
> +	struct ulist_node *prealloc;
>   };
>
>   void ulist_init(struct ulist *ulist);
>   void ulist_release(struct ulist *ulist);
>   void ulist_reinit(struct ulist *ulist);
>   struct ulist *ulist_alloc(gfp_t gfp_mask);
> +void ulist_prealloc(struct ulist *ulist, gfp_t mask);
>   void ulist_free(struct ulist *ulist);
>   int ulist_add(struct ulist *ulist, u64 val, u64 aux, gfp_t gfp_mask);
>   int ulist_add_merge(struct ulist *ulist, u64 val, u64 aux,

