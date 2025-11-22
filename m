Return-Path: <linux-btrfs+bounces-19268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ADAC7C8E2
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 07:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEA064E31C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329FF258EFF;
	Sat, 22 Nov 2025 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY8rX7CF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41ED231A41
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763794274; cv=none; b=atcbYKsDRjqr11JMnl5JGVqYoCYZhQmf8TX1lPAhF15RYNG2IMBkIwV7nQtMp2wO3lo/R6lsfzjlVkRrTtvwDxanGTTs5zgcFnUOyG6QgyW4ibr1EAIOYk2epuf36j3c0s9DJyUgLpUkAVrzulK1JQ80sgHiF3VT3xcZDGI4sUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763794274; c=relaxed/simple;
	bh=Uv6IgGHUXTwuL5FUHdqYGPVlcCJz6Rx1NMSpzWBu5+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bSN8e/SbMOeJtCj8qAMvwSRo9TyC0DwabStVtCxhu+Dhf8/zTrvmG9ExQvyv6ABlTQsu3unONLzCr2hogJtpJzJSCjZ7Zc259+GbtIi9xUsnZas1fAF4/mslcDJdDUE2n2spHvWTnkqy0nLz1TK8PHxZm6P4xdiijLCQn9yv2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY8rX7CF; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3436b2dbff6so373914a91.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 22:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763794272; x=1764399072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iTQc/17LRN/Ba8PpLqHEvzgc8rFPgjHw88QjpXYyBI=;
        b=OY8rX7CFLCZtpLfIqV0+dbUXVNnIiajHdwc4PLxWNTVRdCgfIm/m+gHQ3Ng59pKYsy
         XklWn3dhwY8UliWjc1etg6RjvTYfP2WgVXRwPdnYiuxf+3Vnaie00qV7Mq1j3fqL2wO/
         4jBD6ZzBgzr9dymNO1vYS8MsUNyw88qjzT6OaSKkCwG4BE46KDMrJ1hqKGbsrsu/uhns
         fBiyrSsYeJNPro0GCzfnf/Ah8v4AWCikz4JGLjPzVrx6A9hsqcXs61ARqZdxjN+WD3BX
         kqIJMltWC+2us1cee4WZxm02IE9OyIGme1chf1634RYmVRHlXqlWQn1dep1awuUvYPOX
         0g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763794272; x=1764399072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iTQc/17LRN/Ba8PpLqHEvzgc8rFPgjHw88QjpXYyBI=;
        b=jw7UJqpOYuV6pK/oFVboZbzp0K6Ssq7r3XRAUDL1oGEJo0i57nMxCnEARnf2oaCrrK
         4HO4/Udv009L12DkWB8X8zOmoFuRYRoKL7sL0siC9g/5TgB70zoik0Ny422dep/xgy/z
         2YWvfw6ff/ZNgViKY75z5u/5cY/cahN3RMenjpBYhUGPZn0Ugp/9246Wj9a4ELQIu7w/
         z5CGJcp6hvjwjP7eRedUUZFiMqvGGg9z8bccK3LFhq0xyvBL4ERWXuDSvdufXk6lMyfc
         kcDzzb5Qav0yARrvUQp6wOxk0ti0aVn3zQNqVUZ7q42gFxUh1JtPV9MUEGcqZbO/ojNR
         vJ8A==
X-Gm-Message-State: AOJu0YxJLG3PVxPmadJ6qdfFpZCW8eVskVbcvVK4eOy0cNLNICC4I+r3
	d1vNjf7Bbz2UOREgPZbpwpz5OSC2GShExU1qVMGTfle56+kGE37N3Gn0Z5SXoDruxNXnBA==
X-Gm-Gg: ASbGnct0vKUt9UMi4Fvix0hPHn71cag6xHyP0hGDgDTbY7UELMExtSksy+lWV7WzW7A
	lkMFyr8htHdZftVXkqskfbvKEnyg0zW1jVht9Uqdl+Fy/tT/0N8QIo1PimMmPPjfVw+cS8TLeO7
	cmugYb5NIHmisNXhg9xoeNHD5OqTSd2GzMpks4QAlvS/+DiyJHlQkX7+X+yShN19HGQM96bFWr4
	BLGMjdqFncYkPRhnGcHt+rVUdyESMibdjyzF17atasZFdlXIv7FzmoJhassjZ0DJqrPpHIxKdmU
	MTjCNyoD9MLbtj/hz7BiRyMo78doKkd01g0loGaweNGoev7AugY8h/H7q0rEz6ZXd0u/T2IZYMY
	Q091Y8ZGgEghxuZC3iv4ZDrXCaHPr+S2Tvy+e6fXTkGbB/QkeKAXxiJWRr2QFQCAYohluvSVwBl
	JoC/pkKipHboQ0YtieYKzSGMbIzgBU04R4CFQ=
X-Google-Smtp-Source: AGHT+IG5Z/8NfUfqriVgmAH2VOkeFF2950Jz2t35Hyq3lOLvKb5W/0cejFXJxk9DbeXpZNmEDW2zHQ==
X-Received: by 2002:a17:90b:17ca:b0:340:b8f2:24f6 with SMTP id 98e67ed59e1d1-34733e4abadmr3292965a91.2.1763794272164;
        Fri, 21 Nov 2025 22:51:12 -0800 (PST)
Received: from [192.168.1.13] ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3472692e5c8sm7477906a91.11.2025.11.21.22.51.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 22:51:11 -0800 (PST)
Message-ID: <7c74f2ae-3d8e-4743-b528-78861859cf09@gmail.com>
Date: Sat, 22 Nov 2025 14:51:08 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: simplify boolean argument for
 btrfs_{inc,dec}_ref
To: linux-btrfs@vger.kernel.org
References: <20251122063516.4516-2-sunk67188@gmail.com>
 <20251122063516.4516-4-sunk67188@gmail.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <20251122063516.4516-4-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2025/11/22 14:00, Sun YangKai 写道:
> Replace open-coded if/else blocks with the boolean directly and introduce
> local const bool variables, making the code shorter and easier to read.
> 
> No functional change.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/ctree.c       | 38 ++++++++++++--------------------------
>  fs/btrfs/extent-tree.c | 17 +++++------------
>  2 files changed, 17 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1b15cef86cbc..300fd8c16ad7 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -249,6 +249,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
>  	int ret = 0;
>  	int level;
>  	struct btrfs_disk_key disk_key;
> +	const bool is_reloc_root = (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID);
>  	u64 reloc_src_root = 0;
>  
>  	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
> @@ -262,7 +263,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
>  	else
>  		btrfs_node_key(buf, &disk_key, 0);
>  
> -	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
> +	if (is_reloc_root)
>  		reloc_src_root = btrfs_header_owner(buf);
>  	cow = btrfs_alloc_tree_block(trans, root, 0, new_root_objectid,
>  				     &disk_key, level, buf->start, 0,
> @@ -276,7 +277,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
>  	btrfs_set_header_backref_rev(cow, BTRFS_MIXED_BACKREF_REV);
>  	btrfs_clear_header_flag(cow, BTRFS_HEADER_FLAG_WRITTEN |
>  				     BTRFS_HEADER_FLAG_RELOC);
> -	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
> +	if (is_reloc_root)
>  		btrfs_set_header_flag(cow, BTRFS_HEADER_FLAG_RELOC);
>  	else
>  		btrfs_set_header_owner(cow, new_root_objectid);
> @@ -291,16 +292,9 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
>  		return ret;
>  	}
>  
> -	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
> -		ret = btrfs_inc_ref(trans, root, cow, true);
> -		if (unlikely(ret))
> -			btrfs_abort_transaction(trans, ret);
> -	} else {
> -		ret = btrfs_inc_ref(trans, root, cow, false);
> -		if (unlikely(ret))
> -			btrfs_abort_transaction(trans, ret);
> -	}
> -	if (ret) {
> +	ret = btrfs_inc_ref(trans, root, cow, is_reloc_root);

Now we have something like this:

ret = btrfs_inc_ref(trans, root, cow, is_reloc_root);

As suggested by Daniel, it would be helpful to add a comment explaining why we
pass true to @full_backref when dealing with a relocation tree (is_reloc_root).
However, I currently lack the knowledge to provide a clear explanation.

> +	if (unlikely(ret)) {
> +		btrfs_abort_transaction(trans, ret);
>  		btrfs_tree_unlock(cow);
>  		free_extent_buffer(cow);
>  		return ret;
> @@ -362,6 +356,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
>  	u64 owner;
>  	u64 flags;
>  	int ret;
> +	const bool is_reloc_root = (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID);
>  
>  	/*
>  	 * Backrefs update rules:
> @@ -397,8 +392,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
>  		}
>  	} else {
>  		refs = 1;
> -		if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID ||
> -		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
> +		if (is_reloc_root || btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
>  			flags = BTRFS_BLOCK_FLAG_FULL_BACKREF;
>  		else
>  			flags = 0;
> @@ -417,14 +411,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
>  	}
>  
>  	if (refs > 1) {
> -		if ((owner == btrfs_root_id(root) ||
> -		     btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) &&
> +		if ((owner == btrfs_root_id(root) || is_reloc_root) &&
>  		    !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)) {
>  			ret = btrfs_inc_ref(trans, root, buf, true);
>  			if (ret)
>  				return ret;
>  
> -			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
> +			if (is_reloc_root) {
>  				ret = btrfs_dec_ref(trans, root, buf, false);
>  				if (ret)
>  					return ret;
> @@ -437,20 +430,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
>  			if (ret)
>  				return ret;
>  		} else {
> -
> -			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
> -				ret = btrfs_inc_ref(trans, root, cow, true);
> -			else
> -				ret = btrfs_inc_ref(trans, root, cow, false);
> +			ret = btrfs_inc_ref(trans, root, cow, is_reloc_root);
>  			if (ret)
>  				return ret;
>  		}
>  	} else {
>  		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
> -			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
> -				ret = btrfs_inc_ref(trans, root, cow, true);
> -			else
> -				ret = btrfs_inc_ref(trans, root, cow, false);
> +			ret = btrfs_inc_ref(trans, root, cow, is_reloc_root);
>  			if (ret)
>  				return ret;
>  			ret = btrfs_dec_ref(trans, root, buf, true);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 527310f3aeb3..f3d33d7a2376 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5875,18 +5875,11 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
>  
>  	if (wc->refs[level] == 1) {
>  		if (level == 0) {
> -			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
> -				ret = btrfs_dec_ref(trans, root, eb, true);
> -				if (ret) {
> -					btrfs_abort_transaction(trans, ret);
> -					return ret;
> -				}
> -			} else {
> -				ret = btrfs_dec_ref(trans, root, eb, false);
> -				if (unlikely(ret)) {
> -					btrfs_abort_transaction(trans, ret);
> -					return ret;
> -				}
> +			const bool full_backref = (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF);
> +			ret = btrfs_dec_ref(trans, root, eb, full_backref);
> +			if (unlikely(ret)) {
> +				btrfs_abort_transaction(trans, ret);
> +				return ret;
>  			}
>  			if (btrfs_is_fstree(btrfs_root_id(root))) {
>  				ret = btrfs_qgroup_trace_leaf_items(trans, eb);


