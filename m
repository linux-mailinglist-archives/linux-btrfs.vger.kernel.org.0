Return-Path: <linux-btrfs+bounces-5751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F0490A2C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 05:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A241C214A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 03:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA417BB38;
	Mon, 17 Jun 2024 03:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="soe1PrBw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314D176AB2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593916; cv=none; b=mIBiuya5kYbKjSh9OA2uM7C6XmeI0pdouS8syqSt+nv0JW9KSzYQHTnGXKYhp2grOw5zCvtECadGd5HWcGvhHSt14rDR2l5yRhf0n37RpGGBe6hhSJJGgJZaKOyDldROQ2iUxmpfNxefpG6shHxo5MyIWuGbaWXpliC/vX6JNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593916; c=relaxed/simple;
	bh=vkrz68kj6brN6q09zgkgrnDtDwIG1Tcr5fV2Mh68BkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx/VONSFpOMbpagbhP38pRsTUOQ39jT1U2lxnZKcitpOWGytUfBL8WJKr6dbEU24KipUnGqDqEO1cE6GT4M153LiPPAivtvEp9pNDA9mlelxozRoxxkbWXXiuSnDrND/qKkbRxZYKOG2GdmPQy5pyQLrr3RecDbC014QOCYzSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=soe1PrBw; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718593906; x=1719198706; i=quwenruo.btrfs@gmx.com;
	bh=IOD2NWuELU/tTvDrKO18UsucHc5E99e7LoHzzPoN9Yw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=soe1PrBwCXW3rOWHHbywrAk0FxWJuo9r9XuO348rWa6JMoaGfrlVzTmRUxLpvS9o
	 hfqJI4SmsgBRVayyEOAOF6b74ryuiQBhDe7RBbjcV7nLusC4Zflvbd7ZhRyTNhksM
	 QVKAjEEM+T+yVUCLVHGriX3RO3i4h4ppRsYz3qd4+a4rOW95EQxCGH1yHUkxLNkji
	 matLjKOXhA2YBgjNK0UixvLRDoQtYv5eQOdMDWKKgzIhaXz7LGRHN9z3geKa0bcRO
	 Bs8zsORVxZ7+yzh8mU+dndsrpNdpNWXVp821kxxNo4d843mz9QtrH1nnaoDmKLeWU
	 OxUrFxkMjnoIr4r8Lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof57-1slCeW0k8H-00bAOj; Mon, 17
 Jun 2024 05:11:46 +0200
Message-ID: <b02d6f61-65d6-42f5-a89d-c43f7eccbbe6@gmx.com>
Date: Mon, 17 Jun 2024 12:41:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] btrfs: qgroup: use xarray to track dirty extents
 in transaction.
To: Junchao Sun <sunjunchao2870@gmail.com>, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com
References: <20240607143021.122220-1-sunjunchao2870@gmail.com>
 <20240607143021.122220-2-sunjunchao2870@gmail.com>
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
In-Reply-To: <20240607143021.122220-2-sunjunchao2870@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xb/dbz7BY2kewRzvpZEaZV8bEQew+lfw9M3KhVjABmjVc+itrtB
 47a358LSSsf/grmeH0RO+a5Xfza2cOOl+oDmQa+2H2PpoWe/lmRIlFwJ0KlZcfZpHWiGmed
 kkxE1JZeTe1MU1dtf85rvDzhX5HMG9mOJUPS2Zu2l1IodQBw+At5qdxdWZ/onowM98nhtI+
 VBJBllpBhtI6Ay8TD/KiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aB5j8iBkFj0=;v5v9KAkrpkkrCVWiMn9ykjW6tQ7
 +8vXcNqK6p8HVpRTTjRTuRA0/bYkKddhrOVl5prIABttT+v74MioCEhHhwNSqWzyop/nyz9z4
 bTptk66aPl2NzA8k7aW4866APbeq/GqBKgvQHpIXnJFzI7lV8TshqP9SgUzWcGaHt5a8yIuWn
 SgpqjLE14bC23qvC0e/jiYIsppNt2Pgak2hsZTtOoKZyt0g65aDFLpN2RQx2iEceLYQq3fhRx
 nAMkbFNjJ4u9HRgOciaZ0B8AlEJNiC4lQKoy37sApm9bDTBxwFg6PEIHyLCoRIKUuS51W0SF1
 uO5PXNuyATPyCwODvUicPFT4kB2YdkjUi8/WWQXR5ouAFgF440zinGIHyvRmUOWD1TpRf+XQR
 iT3ROfluHITcceHQMldd/kwrLY9gtOtd0nKuJMHKAutfHppep128UdYKXIjNygcANxDoMXXte
 wsqjvu53Hd3UzYDCrZ3n5m8bx3DOXdmrgZY8TdCgURuuYHfV+gczWNudjuBWQsH1/5gDg4BcX
 bVfK0FbKPpthRcPzT5Jlt3KU3YNYkgXFJaY7XCzwBVNYb80/OL7ga3XsXnra0jcZwZPw8eiwg
 Dn+8DtZKDUz9qdAyHknqOcj/5SAr4nok4Ro4AJZg3x4DWKrTnJbhWigIVYa9m1aQ+FCMKMPHP
 v8NIb85GPBBT/UZ3Bt0nsfRFryqJyrewMzlRn1SL5xLRceiyVN7q9DxpjZs5fBNBKlLuGZsf0
 yF7bO27/LlfSKDoQlaJXdC9H7/5g4AXhz2KkKMMqkc4FFM9eu7e9eDeJzkXe8IxOgNgo+/wjL
 mdiNOJT2U4il3E3RTU2IfKhyKADcJPUiFoL1am/kbUUd0=



=E5=9C=A8 2024/6/8 00:00, Junchao Sun =E5=86=99=E9=81=93:
> Changes since v2:
>    - Separate the cleanup code into a single patch.
>    - Call qgroup_mark_inconsistent() when record insertion failed.
>    - Return negative value when record insertion failed.
>
> Changes since v1:
>    - Use xa_load() to update existing entry instead of double
>      xa_store().
>    - Rename goto lables.
>    - Remove unnecessary calls to xa_init().

Forgot to mention, you should not put changelog into the commit message.

You do not need to resent, I'll remove them when pushing into for-next
branch.
(Along with extra testing etc).


>
> Using xarray to track dirty extents can reduce the size of the
> struct btrfs_qgroup_extent_record from 64 bytes to 40 bytes.
> And xarray is more cache line friendly, it also reduces the
> complexity of insertion and search code compared to rb tree.
>
> Another change introduced is about error handling.
> Before this patch, the result of btrfs_qgroup_trace_extent_nolock()
> is always a success. In this patch, because of this function calls
> the function xa_store() which has the possibility to fail, so mark
> qgroup as inconsistent if error happened and then free preallocated
> memory. Also we preallocate memory before spin_lock(), if memory
> preallcation failed, error handling is the same the existing code.
>
> This patch passed the check -g qgroup tests using xfstests and
> checkpatch tests.
>
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/delayed-ref.c | 14 +++++++--
>   fs/btrfs/delayed-ref.h |  2 +-
>   fs/btrfs/qgroup.c      | 66 ++++++++++++++++++++----------------------
>   fs/btrfs/transaction.c |  5 ++--
>   4 files changed, 46 insertions(+), 41 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 1a41ab991738..ec78d4c7581c 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -891,10 +891,13 @@ add_delayed_ref_head(struct btrfs_trans_handle *tr=
ans,
>
>   	/* Record qgroup extent info if provided */
>   	if (qrecord) {
> -		if (btrfs_qgroup_trace_extent_nolock(trans->fs_info,
> -					delayed_refs, qrecord))
> +		int ret =3D btrfs_qgroup_trace_extent_nolock(trans->fs_info,
> +					delayed_refs, qrecord);
> +		if (ret) {
> +			/* Clean up if insertion fails or item exists. */
> +			xa_release(&delayed_refs->dirty_extents, qrecord->bytenr);
>   			kfree(qrecord);
> -		else
> +		} else
>   			qrecord_inserted =3D true;
>   	}
>
> @@ -1048,6 +1051,9 @@ static int add_delayed_ref(struct btrfs_trans_hand=
le *trans,
>   		record =3D kzalloc(sizeof(*record), GFP_NOFS);
>   		if (!record)
>   			goto free_head_ref;
> +		if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents,
> +			       generic_ref->bytenr, GFP_NOFS))
> +			goto free_record;
>   	}
>
>   	init_delayed_ref_common(fs_info, node, generic_ref);
> @@ -1084,6 +1090,8 @@ static int add_delayed_ref(struct btrfs_trans_hand=
le *trans,
>   		return btrfs_qgroup_trace_extent_post(trans, record);
>   	return 0;
>
> +free_record:
> +	kfree(record);
>   free_head_ref:
>   	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
>   free_node:
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 04b180ebe1fe..a81d6f2aa799 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -201,7 +201,7 @@ struct btrfs_delayed_ref_root {
>   	struct rb_root_cached href_root;
>
>   	/* dirty extent records */
> -	struct rb_root dirty_extent_root;
> +	struct xarray dirty_extents;
>
>   	/* this spin lock protects the rbtree and the entries inside */
>   	spinlock_t lock;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index fc2a7ea26354..f75ed67a8edf 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1902,16 +1902,14 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid,
>    *
>    * Return 0 for success insert
>    * Return >0 for existing record, caller can free @record safely.
> - * Error is not possible
> + * Return <0 for insertion failed, caller can free @record safely.
>    */
>   int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
>   				struct btrfs_delayed_ref_root *delayed_refs,
>   				struct btrfs_qgroup_extent_record *record)
>   {
> -	struct rb_node **p =3D &delayed_refs->dirty_extent_root.rb_node;
> -	struct rb_node *parent_node =3D NULL;
> -	struct btrfs_qgroup_extent_record *entry;
> -	u64 bytenr =3D record->bytenr;
> +	struct btrfs_qgroup_extent_record *existing, *ret;
> +	unsigned long bytenr =3D record->bytenr;
>
>   	if (!btrfs_qgroup_full_accounting(fs_info))
>   		return 1;
> @@ -1919,26 +1917,24 @@ int btrfs_qgroup_trace_extent_nolock(struct btrf=
s_fs_info *fs_info,
>   	lockdep_assert_held(&delayed_refs->lock);
>   	trace_btrfs_qgroup_trace_extent(fs_info, record);
>
> -	while (*p) {
> -		parent_node =3D *p;
> -		entry =3D rb_entry(parent_node, struct btrfs_qgroup_extent_record,
> -				 node);
> -		if (bytenr < entry->bytenr) {
> -			p =3D &(*p)->rb_left;
> -		} else if (bytenr > entry->bytenr) {
> -			p =3D &(*p)->rb_right;
> -		} else {
> -			if (record->data_rsv && !entry->data_rsv) {
> -				entry->data_rsv =3D record->data_rsv;
> -				entry->data_rsv_refroot =3D
> -					record->data_rsv_refroot;
> -			}
> -			return 1;
> +	xa_lock(&delayed_refs->dirty_extents);
> +	existing =3D xa_load(&delayed_refs->dirty_extents, bytenr);
> +	if (existing) {
> +		if (record->data_rsv && !existing->data_rsv) {
> +			existing->data_rsv =3D record->data_rsv;
> +			existing->data_rsv_refroot =3D record->data_rsv_refroot;
>   		}
> +		xa_unlock(&delayed_refs->dirty_extents);
> +		return 1;
> +	}
> +
> +	ret =3D __xa_store(&delayed_refs->dirty_extents, record->bytenr, recor=
d, GFP_ATOMIC);
> +	xa_unlock(&delayed_refs->dirty_extents);
> +	if (xa_is_err(ret)) {
> +		qgroup_mark_inconsistent(fs_info);
> +		return xa_err(ret);
>   	}
>
> -	rb_link_node(&record->node, parent_node, p);
> -	rb_insert_color(&record->node, &delayed_refs->dirty_extent_root);
>   	return 0;
>   }
>
> @@ -2045,6 +2041,11 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_=
handle *trans, u64 bytenr,
>   	if (!record)
>   		return -ENOMEM;
>
> +	if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents, bytenr=
, GFP_NOFS)) {
> +		kfree(record);
> +		return -ENOMEM;
> +	}
> +
>   	delayed_refs =3D &trans->transaction->delayed_refs;
>   	record->bytenr =3D bytenr;
>   	record->num_bytes =3D num_bytes;
> @@ -2053,7 +2054,9 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_h=
andle *trans, u64 bytenr,
>   	spin_lock(&delayed_refs->lock);
>   	ret =3D btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, recor=
d);
>   	spin_unlock(&delayed_refs->lock);
> -	if (ret > 0) {
> +	if (ret) {
> +		/* Clean up if insertion fails or item exists. */
> +		xa_release(&delayed_refs->dirty_extents, record->bytenr);
>   		kfree(record);
>   		return 0;
>   	}
> @@ -2922,7 +2925,7 @@ int btrfs_qgroup_account_extents(struct btrfs_tran=
s_handle *trans)
>   	struct btrfs_qgroup_extent_record *record;
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	struct ulist *new_roots =3D NULL;
> -	struct rb_node *node;
> +	unsigned long index;
>   	u64 num_dirty_extents =3D 0;
>   	u64 qgroup_to_skip;
>   	int ret =3D 0;
> @@ -2932,10 +2935,7 @@ int btrfs_qgroup_account_extents(struct btrfs_tra=
ns_handle *trans)
>
>   	delayed_refs =3D &trans->transaction->delayed_refs;
>   	qgroup_to_skip =3D delayed_refs->qgroup_to_skip;
> -	while ((node =3D rb_first(&delayed_refs->dirty_extent_root))) {
> -		record =3D rb_entry(node, struct btrfs_qgroup_extent_record,
> -				  node);
> -
> +	xa_for_each(&delayed_refs->dirty_extents, index, record) {
>   		num_dirty_extents++;
>   		trace_btrfs_qgroup_account_extents(fs_info, record);
>
> @@ -3001,7 +3001,7 @@ int btrfs_qgroup_account_extents(struct btrfs_tran=
s_handle *trans)
>   		ulist_free(record->old_roots);
>   		ulist_free(new_roots);
>   		new_roots =3D NULL;
> -		rb_erase(node, &delayed_refs->dirty_extent_root);
> +		xa_erase(&delayed_refs->dirty_extents, index);
>   		kfree(record);
>
>   	}
> @@ -4788,15 +4788,13 @@ int btrfs_qgroup_trace_subtree_after_cow(struct =
btrfs_trans_handle *trans,
>   void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *tra=
ns)
>   {
>   	struct btrfs_qgroup_extent_record *entry;
> -	struct btrfs_qgroup_extent_record *next;
> -	struct rb_root *root;
> +	unsigned long index;
>
> -	root =3D &trans->delayed_refs.dirty_extent_root;
> -	rbtree_postorder_for_each_entry_safe(entry, next, root, node) {
> +	xa_for_each(&trans->delayed_refs.dirty_extents, index, entry) {
>   		ulist_free(entry->old_roots);
>   		kfree(entry);
>   	}
> -	*root =3D RB_ROOT;
> +	xa_destroy(&trans->delayed_refs.dirty_extents);
>   }
>
>   void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u6=
4 rsv_bytes)
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 3388c836b9a5..c473c049d37f 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -143,8 +143,7 @@ void btrfs_put_transaction(struct btrfs_transaction =
*transaction)
>   		BUG_ON(!list_empty(&transaction->list));
>   		WARN_ON(!RB_EMPTY_ROOT(
>   				&transaction->delayed_refs.href_root.rb_root));
> -		WARN_ON(!RB_EMPTY_ROOT(
> -				&transaction->delayed_refs.dirty_extent_root));
> +		WARN_ON(!xa_empty(&transaction->delayed_refs.dirty_extents));
>   		if (transaction->delayed_refs.pending_csums)
>   			btrfs_err(transaction->fs_info,
>   				  "pending csums is %llu",
> @@ -351,7 +350,7 @@ static noinline int join_transaction(struct btrfs_fs=
_info *fs_info,
>   	memset(&cur_trans->delayed_refs, 0, sizeof(cur_trans->delayed_refs));
>
>   	cur_trans->delayed_refs.href_root =3D RB_ROOT_CACHED;
> -	cur_trans->delayed_refs.dirty_extent_root =3D RB_ROOT;
> +	xa_init(&cur_trans->delayed_refs.dirty_extents);
>   	atomic_set(&cur_trans->delayed_refs.num_entries, 0);
>
>   	/*

