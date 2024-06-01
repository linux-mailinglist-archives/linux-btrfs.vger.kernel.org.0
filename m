Return-Path: <linux-btrfs+bounces-5385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED9B8D7290
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 00:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844071F2156B
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jun 2024 22:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ACF2C87A;
	Sat,  1 Jun 2024 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Eq/fVcMc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177F1CD2F
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Jun 2024 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717282080; cv=none; b=MzwWbC30pKislkdk1vvffaIplxWuk2dyi1HiMw68F1r9d0QBstcJVvUBrJtinjMf99s5xgAlihNAvfeboLpqGXO8a4LYGWG5PRiqs/vhGNgbdaVNtK63c1fUlF+kdTfoEurA3OEBmg8wnxEGcC6ROg589+ordaAWaOA63THU6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717282080; c=relaxed/simple;
	bh=Ywo8rrWRoGIddSvnlYhCzHGwW4j9WsT4BBooZeM4TRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6RaH+2G7FjXbHKX4SqD/C3HYGVHcb7HhMHt7D+rDKBPIkYqGbZkWlkPQ0NVwSHfHryguw5qB32Lv6OYqccHdX2TiBkKX0RFMRMyeEyDNtA74R2Mc1iB5DMP+qoYeeTzVaRYR8P0wvlw5idSETIYN4FXkKnhm4B65ihjNjUOuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Eq/fVcMc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a883101so42168321fa.3
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jun 2024 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717282075; x=1717886875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=koA0zeKMDDfKfUArJJ+dgUyHdXz3XPSaQ9vDEwihwFw=;
        b=Eq/fVcMcFQVEi5rsy34N1gBFHTKWzC/Ac9tMECVrNZO2Bpk5GKPWn/rmipkkl2OH2O
         8kADNwBB+GyubiZZoZrTE3kwMapq8a9kzZ4QYG09/i1Cj0ISEOsZaR2KSA/0c2ojrqkQ
         mm4B7pCdFU0wuBD1EOlZ39Ysmxe0iQ3uI4M/v26cPINZYizjKvrC53u9pNwGaCFF7iee
         ZYD95YMy+b7a7Jpga1qrKImb+d7r/P5GaHAZJb/qLJ/nBfCm/EskIEIiDB9t2qvNsylF
         6x/n9d4RXs+WgMhLWwBeSPHxO17xlwcFxJEAoUWo62sHoQ/0zRnd0e68hE1ihfFInl0E
         suYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717282075; x=1717886875;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koA0zeKMDDfKfUArJJ+dgUyHdXz3XPSaQ9vDEwihwFw=;
        b=UWBsVOs+eXAfUZ1+bZdGNVSKvXLrw+uoly64FHSSH8Gf5YKzr7y7RvoTncPI6n75Se
         /CcbfMHbNBYAHPMzOybiuMZeVBdPsn29BEdtnsVZcqYuro6X0PuIqTPkm59PqpLyqRTd
         Vka/EThtB2RO2BCgB+0iVI3jGJlMgUTRC/kD3jhfhhfraWycw4t1OgwqqCo1rPvDRJgt
         Mz4Hgd17ib5TXkBNpB0e2ShKsQO78y4lYrZxVSDFNyd9hCLhs1kbEobyLP5b7vpEtimR
         gRJzBm+XKnj8oQc9E2tv1Xjo/F0S0GX2PCopSQLHiIRKjGdcjnpQRkI5rBLfAOwpoXTT
         GPVw==
X-Forwarded-Encrypted: i=1; AJvYcCVqnjtptfMS7wVhVLNg4zhBD4Zv+moy2SxcrBLMA9COFtQWFpi8D208F3OdDMnb5m31+N+HhkxO/BfRS0BJpFYU75BSgLNP7mx/mq4=
X-Gm-Message-State: AOJu0YwSf0QlYSL0y5Knl3N7ZGJiHrx1P3xVvwCPg1yx4BzSbrfO0V/2
	5ZZvMpAsDwF1AC20J8m5J41zhn7aphC+V1PpbCsXAc8fhxI4zDiT2Ke1oe19zjc=
X-Google-Smtp-Source: AGHT+IHoojA9lHgYLDWIJEo7wNdUISawxAcdeBJn8ySQXtTQPtCQ+iBf58XKxilwiDUhc5eFj7ze8A==
X-Received: by 2002:a2e:920e:0:b0:2ea:78e2:6a5e with SMTP id 38308e7fff4ca-2ea951ab3c1mr37468401fa.34.1717282074820;
        Sat, 01 Jun 2024 15:47:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632415731sm38631845ad.279.2024.06.01.15.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 15:47:54 -0700 (PDT)
Message-ID: <b1773175-9780-4bdf-a751-4df50a3f19d8@suse.com>
Date: Sun, 2 Jun 2024 08:17:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: use xarray to track dirty extents in
 transaction.
To: Junchao Sun <sunjunchao2870@gmail.com>, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
References: <20240601114213.1647115-1-sunjunchao2870@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240601114213.1647115-1-sunjunchao2870@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/1 21:12, Junchao Sun 写道:
> Using xarray to track dirty extents can reduce the size of the
> struct btrfs_qgroup_extent_record from 64 bytes to 40 bytes.
> And xarray is more cache line friendly, it also reduces the
> complexity of insertion and search code compared to rb tree.
> 
> Another change introduced is about error handling.
> Before this patch, the result of btrfs_qgroup_trace_extent_nolock()
> is always success. In this patch, because of this function calls
> the function xa_store() which has the possibility to fail, so I
> refactored some code to handle error correctly. Even though that
> we preallocated memory in advance, here should not return an error
> theorily. But for the sake of logical completeness, I still
> refactored the error handling code. If you have any questions or
> concerns about this part, feel free to let me know.
> 
> This patch passed the check -g qgroup tests using xfstests and
> checkpatch tests.

Thanks a lot for the work, but still some problem related to coding 
style and error handling.

[...]
> @@ -1036,18 +1043,16 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>   		return -ENOMEM;
>   
>   	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
> -	if (!head_ref) {
> -		kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> -		return -ENOMEM;
> -	}
> +	if (!head_ref)
> +		goto fail1;
>   
>   	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
>   		record = kzalloc(sizeof(*record), GFP_NOFS);
> -		if (!record) {
> -			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> -			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> -			return -ENOMEM;
> -		}
> +		if (!record)
> +			goto fail2;

I'd prefer the old error handling.

> +		ret = xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS);
> +		if (ret)
> +			goto fail3;

Qgroup record inserting error is not critical, instead you can just mark 
qgroup inconsistent and do the remaining cleanup.

>   	}
>   
>   	if (parent)
> @@ -1067,7 +1072,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>   			      false, is_system, generic_ref->owning_root);
>   	head_ref->extent_op = extent_op;
>   
> -	delayed_refs = &trans->transaction->delayed_refs;
>   	spin_lock(&delayed_refs->lock);
>   
>   	/*
> @@ -1076,6 +1080,11 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>   	 */
>   	head_ref = add_delayed_ref_head(trans, head_ref, record,
>   					action, &qrecord_inserted);
> +	if (IS_ERR(head_ref)) {
> +		spin_unlock(&delayed_refs->lock);
> +		ret = PTR_ERR(head_ref);
> +		goto fail3;
> +	}

If you keep the error handling inside qgrou part by just marking qgroup 
inconsistent, add_delayed_ref_head() won't need to return error and no 
extra error handling.
>   
>   	merged = insert_delayed_ref(trans, head_ref, &ref->node);
>   	spin_unlock(&delayed_refs->lock);
> @@ -1096,6 +1105,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>   		btrfs_qgroup_trace_extent_post(trans, record);
>   
>   	return 0;
> +
> +fail3:
> +	kfree(record);
> +fail2:
> +	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> +fail1:
> +	kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> +	return ret;

Please do no use such naming, go with something to indicate the what's 
going to be freed instead.

>   }
>   
>   /*
> @@ -1120,6 +1137,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>   	u64 owner = generic_ref->data_ref.ino;
>   	u64 offset = generic_ref->data_ref.offset;
>   	u8 ref_type;
> +	int ret = -ENOMEM;
>   
>   	ASSERT(generic_ref->type == BTRFS_REF_DATA && action);
>   	ref = kmem_cache_alloc(btrfs_delayed_data_ref_cachep, GFP_NOFS);
> @@ -1137,28 +1155,24 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>   	ref->objectid = owner;
>   	ref->offset = offset;
>   
> -
> +	delayed_refs = &trans->transaction->delayed_refs;
>   	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
> -	if (!head_ref) {
> -		kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> -		return -ENOMEM;
> -	}
> +	if (!head_ref)
> +		goto fail1;
>   
>   	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
>   		record = kzalloc(sizeof(*record), GFP_NOFS);
> -		if (!record) {
> -			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> -			kmem_cache_free(btrfs_delayed_ref_head_cachep,
> -					head_ref);
> -			return -ENOMEM;
> -		}
> +		if (!record)
> +			goto fail2;
> +		ret = xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS);
> +		if (ret)
> +			goto fail3;

The same.

>   	}
>   
>   	init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_root,
>   			      reserved, action, true, false, generic_ref->owning_root);
>   	head_ref->extent_op = NULL;
>   
> -	delayed_refs = &trans->transaction->delayed_refs;
>   	spin_lock(&delayed_refs->lock);
>   
>   	/*
> @@ -1167,6 +1181,11 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>   	 */
>   	head_ref = add_delayed_ref_head(trans, head_ref, record,
>   					action, &qrecord_inserted);
> +	if (IS_ERR(head_ref)) {
> +		ret = PTR_ERR(head_ref);
> +		spin_unlock(&delayed_refs->lock);
> +		goto fail3;
> +	}
>   
>   	merged = insert_delayed_ref(trans, head_ref, &ref->node);
>   	spin_unlock(&delayed_refs->lock);
> @@ -1187,6 +1206,14 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>   	if (qrecord_inserted)
>   		return btrfs_qgroup_trace_extent_post(trans, record);
>   	return 0;
> +
> +fail3:
> +	kfree(record);
> +fail2:
> +	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> +fail1:
> +	kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> +	return ret;

The same.

>   }
>   
>   int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 62d679d40f4f..f9b20c0671c7 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -166,7 +166,7 @@ struct btrfs_delayed_ref_root {
>   	struct rb_root_cached href_root;
>   
>   	/* dirty extent records */
> -	struct rb_root dirty_extent_root;
> +	struct xarray dirty_extents;
>   
>   	/* this spin lock protects the rbtree and the entries inside */
>   	spinlock_t lock;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 5470e1cdf10c..3241d21a7121 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1890,16 +1890,14 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>    *
>    * Return 0 for success insert
>    * Return >0 for existing record, caller can free @record safely.
> - * Error is not possible
>    */
>   int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
>   				struct btrfs_delayed_ref_root *delayed_refs,
>   				struct btrfs_qgroup_extent_record *record)
>   {
> -	struct rb_node **p = &delayed_refs->dirty_extent_root.rb_node;
> -	struct rb_node *parent_node = NULL;
> -	struct btrfs_qgroup_extent_record *entry;
> -	u64 bytenr = record->bytenr;
> +	struct btrfs_qgroup_extent_record *existing;
> +	const u64 bytenr = record->bytenr;
> +	int ret;
>   
>   	if (!btrfs_qgroup_full_accounting(fs_info))
>   		return 1;
> @@ -1907,27 +1905,26 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
>   	lockdep_assert_held(&delayed_refs->lock);
>   	trace_btrfs_qgroup_trace_extent(fs_info, record);
>   
> -	while (*p) {
> -		parent_node = *p;
> -		entry = rb_entry(parent_node, struct btrfs_qgroup_extent_record,
> -				 node);
> -		if (bytenr < entry->bytenr) {
> -			p = &(*p)->rb_left;
> -		} else if (bytenr > entry->bytenr) {
> -			p = &(*p)->rb_right;
> -		} else {
> -			if (record->data_rsv && !entry->data_rsv) {
> -				entry->data_rsv = record->data_rsv;
> -				entry->data_rsv_refroot =
> -					record->data_rsv_refroot;
> -			}
> -			return 1;
> +	existing = xa_store(&delayed_refs->dirty_extents, bytenr, record, GFP_ATOMIC);
> +	if (xa_is_err(existing))
> +		goto out;
> +	else if (existing) {
> +		if (record->data_rsv && !existing->data_rsv) {
> +			existing->data_rsv = record->data_rsv;
> +			existing->data_rsv_refroot = record->data_rsv_refroot;
>   		}
> +		existing = xa_store(&delayed_refs->dirty_extents, bytenr, existing, GFP_ATOMIC);

Instead of such complex double xa_store to modify the values, why not 
take xa_lock() and xa_find() so that you can easily find the existing 
entry and modify the members?

In fact the double xa_store() is just going to make it way harder to 
grasp on which pointer is really stored inside the xarrary.

> @@ -4664,15 +4668,14 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
>   void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
>   {
>   	struct btrfs_qgroup_extent_record *entry;
> -	struct btrfs_qgroup_extent_record *next;
> -	struct rb_root *root;
> +	unsigned long index;
>   
> -	root = &trans->delayed_refs.dirty_extent_root;
> -	rbtree_postorder_for_each_entry_safe(entry, next, root, node) {
> +	xa_for_each(&trans->delayed_refs.dirty_extents, index, entry) {
>   		ulist_free(entry->old_roots);
>   		kfree(entry);
>   	}
> -	*root = RB_ROOT;
> +	xa_destroy(&trans->delayed_refs.dirty_extents);
> +	xa_init(&trans->delayed_refs.dirty_extents);

Do you really need to call xa_init() after xa_destory()?

>   }
>   
>   void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u64 rsv_bytes)
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index be18c862e64e..f8165a27b885 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -116,7 +116,6 @@
>    * TODO: Use kmem cache to alloc it.
>    */
>   struct btrfs_qgroup_extent_record {
> -	struct rb_node node;
>   	u64 bytenr;
>   	u64 num_bytes;
>   
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index bf8e64c766b6..006080814ee5 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -145,8 +145,8 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
>   		BUG_ON(!list_empty(&transaction->list));
>   		WARN_ON(!RB_EMPTY_ROOT(
>   				&transaction->delayed_refs.href_root.rb_root));
> -		WARN_ON(!RB_EMPTY_ROOT(
> -				&transaction->delayed_refs.dirty_extent_root));
> +		WARN_ON(!xa_empty(
> +				&transaction->delayed_refs.dirty_extents));
>   		if (transaction->delayed_refs.pending_csums)
>   			btrfs_err(transaction->fs_info,
>   				  "pending csums is %llu",
> @@ -353,7 +353,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>   	memset(&cur_trans->delayed_refs, 0, sizeof(cur_trans->delayed_refs));
>   
>   	cur_trans->delayed_refs.href_root = RB_ROOT_CACHED;
> -	cur_trans->delayed_refs.dirty_extent_root = RB_ROOT;
> +	xa_init(&cur_trans->delayed_refs.dirty_extents);
>   	atomic_set(&cur_trans->delayed_refs.num_entries, 0);
>   
>   	/*
> @@ -690,7 +690,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>   	 * and then we deadlock with somebody doing a freeze.
>   	 *
>   	 * If we are ATTACH, it means we just want to catch the current
> -	 * transaction and commit it, so we needn't do sb_start_intwrite().
> +	 * transaction and commit it, so we needn't do sb_start_intwrite().

Is this something fixed by LSP server automatically?

This looks exactly like a lot of my patches where whitespace errors are 
auto-corrected...

Thanks,
Qu
>   	 */
>   	if (type & __TRANS_FREEZABLE)
>   		sb_start_intwrite(fs_info->sb);

