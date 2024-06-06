Return-Path: <linux-btrfs+bounces-5499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0058FE2DB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137B11F2456E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B21817CA18;
	Thu,  6 Jun 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FauNs4Aa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80017B517
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666241; cv=none; b=jyyf065RZF3SPZr8H9dhEwcXMv4pFik6GWPvSvxSs/oJqCEYiFJ20koczedrnqzm4Trjr/u+BUFOdGvJCIAXB+M4S5E3+V89phQRJzxQY2lMpZQJGMBAu62zZGSKIFeAUF6Mj18PpHpksJ+ky5i5/2CdRDBimE7QuS0uorlBv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666241; c=relaxed/simple;
	bh=1aQBvRiTnzBqkrw4Q4tW7yH/STdVnYbQN6PBOPRi06I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Acrz04AJ7KTqMTH45H3/0fU+MAE0Vq3hA4OE64btc693RwCYJII+pqB+tGK3V+g+H/LBpDp0urLnt6WVRfauZguMaA3lt3xj3QS/RMQgSngm/VHvgjdEWrV8J0Nh4RX549btt6Q12RyRugPAxqGntnKlobuT1dMo0zs2y7OVwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FauNs4Aa; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717666231; x=1718271031; i=quwenruo.btrfs@gmx.com;
	bh=2GZJvUZPkmE7K8D8g/CjC/KI+M2bTz/X6qPtJbrxA1A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FauNs4Aaw70MEhzL2iY30rS0pY9qEIrtvZi9GiB/tymur0D+Q8cL6jC0li5HniHR
	 Dmg0EjuCOpOgyDkFpNuFi9DQD7oNYcoHaGrEwsJ49zOJDKJW/p50CKZYzO05fSjYm
	 0dzn+eKhzfvlqJpLAbKW75sHDISn5RT1YDvl9rKEKFk7ULdk0KE+/6VfE81zW0OQ6
	 QUzuQXaSB9NWnSU8K2vorqiWn1m1voOzXIq4Hz/WyHfCjuWzxRZ8uuJ3JY5anrS1x
	 Z/Pd0mO8UG8vFfmZ23CXZQuHH3xIdR+lmW3bUIw/95M3zoiyUVg6AjDgOjKjK1tum
	 W92fVaHzdmjtg+UvTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKUp-1s1D6P2HwF-00VJOR; Thu, 06
 Jun 2024 11:30:31 +0200
Message-ID: <0610a1b0-78a6-4c1f-9188-69b587c8146f@gmx.com>
Date: Thu, 6 Jun 2024 19:00:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: qgroup: use xarray to track dirty extents in
 transaction.
To: Junchao Sun <sunjunchao2870@gmail.com>, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com
References: <20240603113650.279782-1-sunjunchao2870@gmail.com>
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
In-Reply-To: <20240603113650.279782-1-sunjunchao2870@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VsQbiAQEIE2ZRMVpB99DjDYPyJPE1g0NnY9vRrWcVEnLuAeueTW
 IvwIjEcdld4nnEbf5bZOCwmRlIbCA5k2uZnmOPlv0qGnVlMzCkrNzNFoGQy8Op8mFfzryAK
 /4p5IRF/1RMA4waBN2ywqO5UnfEt9sbM3H0KBDTw01PkfAPt9pHeAdGwwMKKCxQ98MHQDQ4
 iWwbznh3lj83gXe0o/bmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gTCaCtYLO30=;bhkHSRzG5CIpfZpn247btPbYO34
 uvfRrizMrKqr0vx6J2iKfO6XRhzWk6WenDsQDnFW88DOKwwomCRH4QNe/CqhEvVVZP5T4rI54
 DGWU2axlwDphAzIDEE5Z/OZJGCLbUjaORv4MmKn3X5/SOQdRv230ivg6p9Z+WFS2AdAPH27oM
 qVbAWjFacmgl9nvdONp8AXB+Mrj0hz7wQOkWAcm6EwvGped0/V1XZ9pX3zGRCGxs/iW9w6nd/
 KIuB0rZ4OoM3N2cJbkAhGjUbGPwWpp5OgZSgyXfTKgnvDCJYIpj2c0n/xNQ9s69+p/An2mMck
 iQXIegpTpglhkaFbJvCvkdWEf/0ovWWqs/H/DTiTkeOURf+jrLnLr9wIZhGR7zX2O+wYhYddy
 LDQ1sAdiVbqW90JJcXcHxh6uWX7UATm+wap1GV5n0vjGXLcPD3UUUkTFQ9HKA1z5niK+kuV9b
 ChzN4jjRKEKN6MezASAmqcGSRFKQQOGLqfwZOf/26VBNHuKnJiaSzwNr+hdVvWwKYGiiI8edW
 wfcXl+pKhxagK/Vk1jYIWHfGPMP+o9Za55TVIKQzX3yLSXHqe/B8H0hTP+JjReZ6oCCkb4WQN
 oX9Pj/jxKfHmo4VRYNbcYf16kIt9vZpH8vcfvZXeB5ASt/D5V4n50AnUvDzyI2lgeZ/iFiALR
 almq4tUptqFV551D3ZKZ6gZnUws9GWb8cjLKMMWy1Df2Bbm/3/nJHcNK1j85nbB8m3MA2MQ1X
 /TCtVQw8NpSRB1XMuEIbzLAdDRX7FNvpDZ0KwOpJqhELHXaEXyRYRlefa4vMTBQ7e9oWQQA22
 W9sqF9MCyFYyzr1UKfgm3N3CAa/IZd/AnWhL950VW1pmQ=



=E5=9C=A8 2024/6/3 21:06, Junchao Sun =E5=86=99=E9=81=93:
> Changes since v1:
>   - Use xa_load() to update existing entry instead of double
>     xa_store().
>   - Rename goto lables.
>   - Remove unnecessary calls to xa_init().
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

Sorry for the late reply, this version looks much better now, just
something small nitpicks.

> ---
>   fs/btrfs/delayed-ref.c | 57 ++++++++++++++++++++--------------
>   fs/btrfs/delayed-ref.h |  2 +-
>   fs/btrfs/qgroup.c      | 69 +++++++++++++++++++++---------------------
>   fs/btrfs/qgroup.h      |  1 -
>   fs/btrfs/transaction.c |  6 ++--
>   5 files changed, 73 insertions(+), 62 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 891ea2fa263c..e5cbc91e9864 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -915,8 +915,11 @@ add_delayed_ref_head(struct btrfs_trans_handle *tra=
ns,
>   	/* Record qgroup extent info if provided */
>   	if (qrecord) {
>   		if (btrfs_qgroup_trace_extent_nolock(trans->fs_info,
> -					delayed_refs, qrecord))
> +					delayed_refs, qrecord)) {

Since btrfs_qgroup_trace_extent_nolock() can return <0 for errors, I'd
prefer the more common handling like:

	ret =3D btrfs_qgroup_trace_extent_nolock();
	/* Either error or no need to use the qrecord */
	if (ret) {
		/* Do the cleanup */
	}
> +			/* If insertion failed, free preallocated memory */
> +			xa_release(&delayed_refs->dirty_extents, qrecord->bytenr);
>   			kfree(qrecord);
> +		}
>   		else
>   			qrecord_inserted =3D true;
>   	}
> @@ -1029,6 +1032,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_=
handle *trans,
>   	u8 ref_type;
>
>   	is_system =3D (generic_ref->tree_ref.ref_root =3D=3D BTRFS_CHUNK_TREE=
_OBJECTID);
> +	delayed_refs =3D &trans->transaction->delayed_refs;
>
>   	ASSERT(generic_ref->type =3D=3D BTRFS_REF_METADATA && generic_ref->ac=
tion);
>   	ref =3D kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS);
> @@ -1036,18 +1040,15 @@ int btrfs_add_delayed_tree_ref(struct btrfs_tran=
s_handle *trans,
>   		return -ENOMEM;
>
>   	head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS=
);
> -	if (!head_ref) {
> -		kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> -		return -ENOMEM;
> -	}
> +	if (!head_ref)
> +		goto free_ref;
>
>   	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgrou=
p) {
>   		record =3D kzalloc(sizeof(*record), GFP_NOFS);
> -		if (!record) {
> -			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> -			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> -			return -ENOMEM;
> -		}
> +		if (!record)
> +			goto free_head_ref;
> +		if (xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS))
> +			goto free_record;

Considering we are doing a big functional change, I'd really prefer to
move the error handling cleanup, for better bisection.

>   	}
>
>   	if (parent)
> @@ -1067,7 +1068,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_=
handle *trans,
>   			      false, is_system, generic_ref->owning_root);
>   	head_ref->extent_op =3D extent_op;
>
> -	delayed_refs =3D &trans->transaction->delayed_refs;

Again, not really needed to touch it in a function changing patch.

>   	spin_lock(&delayed_refs->lock);
>
>   	/*
> @@ -1096,6 +1096,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
>   		btrfs_qgroup_trace_extent_post(trans, record);
>
>   	return 0;
> +
> +free_record:
> +	kfree(record);
> +free_head_ref:
> +	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> +free_ref:
> +	kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> +	return -ENOMEM;
>   }
>
>   /*
> @@ -1137,28 +1145,23 @@ int btrfs_add_delayed_data_ref(struct btrfs_tran=
s_handle *trans,
>   	ref->objectid =3D owner;
>   	ref->offset =3D offset;
>
> -
> +	delayed_refs =3D &trans->transaction->delayed_refs;
>   	head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS=
);
> -	if (!head_ref) {
> -		kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> -		return -ENOMEM;
> -	}
> +	if (!head_ref)
> +		goto free_ref;
>
>   	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgrou=
p) {
>   		record =3D kzalloc(sizeof(*record), GFP_NOFS);
> -		if (!record) {
> -			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> -			kmem_cache_free(btrfs_delayed_ref_head_cachep,
> -					head_ref);
> -			return -ENOMEM;
> -		}
> +		if (!record)
> +			goto free_head_ref;
> +		if (xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS))
> +			goto free_record;

Same here.

[...]
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 5470e1cdf10c..717e16da9679 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1890,16 +1890,13 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid,
>    *
>    * Return 0 for success insert
>    * Return >0 for existing record, caller can free @record safely.
> - * Error is not possible

Then why not add a minus return value case?

The most common pattern would be, >0 for one common case (qrecord
exists), 0 for another common case (qrecord inserted), <0 for error.

Just like btrfs_search_slot().
And that's my first impression on the function, but it's not the case.

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
> @@ -1907,26 +1904,27 @@ int btrfs_qgroup_trace_extent_nolock(struct btrf=
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
> +		spin_lock(&fs_info->qgroup_lock);
> +		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;

We have qgroup_mark_inconsistent(), which would skip future accounting.

> +		spin_unlock(&fs_info->qgroup_lock);
> +
> +		return 1;

It's much better just to return the xa_err() instead.

>   	}
>
> -	rb_link_node(&record->node, parent_node, p);
> -	rb_insert_color(&record->node, &delayed_refs->dirty_extent_root);
>   	return 0;
>   }
>
> @@ -2027,13 +2025,18 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans=
_handle *trans, u64 bytenr,
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	int ret;
>
> +	delayed_refs =3D &trans->transaction->delayed_refs;
>   	if (!btrfs_qgroup_full_accounting(fs_info) || bytenr =3D=3D 0 || num_=
bytes =3D=3D 0)
>   		return 0;
>   	record =3D kzalloc(sizeof(*record), GFP_NOFS);
>   	if (!record)
>   		return -ENOMEM;
>
> -	delayed_refs =3D &trans->transaction->delayed_refs;

Again, you may want to not touch unrelated code in a function changing
patch.

Otherwise looks good to me.

Thanks,
Qu

