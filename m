Return-Path: <linux-btrfs+bounces-19597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EBBCAED70
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 05:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66AB301738D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 04:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B59262FC1;
	Tue,  9 Dec 2025 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6W3Pq8I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C135959
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765253127; cv=none; b=RhOlDL6mgR24yc25bIl4JN0OyhZrNVIM7Uhu3tM83E2EL9ESt/+pbJJMFGZbBjUUGg0WrMzargvWeHHa4v5kOY8iECpN76hgQZIrCK8dlkY8uUnR1LsL+/ySQL1zK5dQGyCRnQ2jC2Z6yWOyG0gk7V+IPmzOgPWs/6XoY39qqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765253127; c=relaxed/simple;
	bh=uwQVGbH8arQxo1na/1xXehTDV39BWbF3g3ec7VS1PWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NqjYn0VkiZp+Wbzr+vGZNulpQXicjAwn15+OvOlhi3hg+tFxjMOF5UTctUeKCAxZGiTmRKBsYS4hamiTEjcj4+bW08wQ4oghjo31vfJH5YKauwxsfxfv1KVvV1l0DP5Oaha0EVSxDsWWs7phCygMnj43slxj+sBO/AorPrfEpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6W3Pq8I; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bdd38966c74so133793a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 20:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765253125; x=1765857925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZ99w3seH0Y24VS+NHvC0bPpIi9b0r5W9d89l9mXXPw=;
        b=m6W3Pq8I7wjeXkvLJOg84mF9xvm6SKak6rINCHmciXhWTZKMrFSiqcLJXx5enA8+74
         ZXcEc9knW9qqc9F4srzztecmvJcgsDPa4Jua4EJ/bIdzrAdxtfc7YZagRRHpMst3KYv+
         5gbBqwh5S07h2QhsqfO/ZjJzjL01Ji9WzkNsh0f9gzrn577wavtdct/a/CHlqbzu6xte
         ryIM8GqJXQ7NgmiFVewmZ/H3Fw4cTQxgpgm3IA3to9uSmsr6wBieUrFpC7In8BbIbzg1
         XM+3eRf3o6eNruZgyE5NTlCI1P/KLAyEUlcT4kkx+o9oFRwKQ930Zo2jAlbfrmgT3XbX
         /M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765253125; x=1765857925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZ99w3seH0Y24VS+NHvC0bPpIi9b0r5W9d89l9mXXPw=;
        b=ui0l/+iB23XWuQQYruoHAGvsiDiKIbmB15mHjvAOrw9nOUnsWGkrwl7N2zV2D3UzFw
         9b813pxoWIRoOm+m1iQux4EswFZIcyfsMnbg4CMZ//WwkRDpcLCy/mJvUwk7ncuYjuRj
         ejjZ78iSuuaBCOyqgsCypdaPOHIFaHWeK4pPPS5Nw5O6C7xglwkZxxa9IgNbnxPitMAR
         8WvfYImTqYWJT8HDEW8M6RLmrjR+s4wCkjkH40iSEfsEzD6Y2Sult8YPSWMfGLVpQro9
         L9Zuk4K9abJSd3G2Gc3bk+VoHPjW+oZezcd9lyG57G22ueFJvruVCkPZa4fjNojSbelj
         P34w==
X-Gm-Message-State: AOJu0YyRlpGF1Ae8HRBz8zcRscr9itG4GRrHn7st5GTyjELW6ZQtj/pw
	Ol7dNVPm4ExE6F3aRLkG6nGPbAHKN9Xch2jN6XxLde/l+cQINZ4TLgoRaupHNXVQGyXa+g==
X-Gm-Gg: ASbGncu/vmOPi9ii8P/5o1eRGhePM+N5qT9W4luxrCvrujfjQz4ipsoTpYRBazBC0Rn
	bZdtXBKDG8oon4p4W+EkL61G9p6Kv98HEf+lKFhkb7ROk77UShVsrLmA2VwAtefkW5bgwG7XLHJ
	ylafLXWH5abF+cy3RMD04tviBnI+UCv/EoOKUdgplBvEeyrIuMBedj9+dB9S2b3Vxn9HGwytQoC
	W34HEqkkuPJwL0u2f5yURaT1bGjqd6q87zNimcmE2Pxjti8sUGCAmtlOLr2S6kNA+hFOvgF3Sqc
	rp9/gGYHU2TAoet/5V0l2Cu6AqWo0YTt9OLjNAY3zqh10OtPBZzUXBKr2yTRnczYsuPBuXFs/5N
	7xGAC+dmsKDwd0lpwi/V7Aaq7LRyhfaWTrrFbGuQjn3HG4HTNefKqvyyPxVKQCh3KsLFrVWoX/4
	tNDPkJhReLqxcr+5U/zbiLUB0l
X-Google-Smtp-Source: AGHT+IGvSgPEEp8iXVUfS2F9a5Hsbc9t5fRIEx8Tldk7MXufrDzhdPNyicnZN0BR8keQdA1Ya5wskg==
X-Received: by 2002:a05:6a00:a16:b0:7ab:9850:25fb with SMTP id d2e1a72fcca58-7e8c04ef208mr6533853b3a.2.1765253125197;
        Mon, 08 Dec 2025 20:05:25 -0800 (PST)
Received: from [192.168.1.13] ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e7ecb848c8sm9905843b3a.9.2025.12.08.20.05.23
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 20:05:24 -0800 (PST)
Message-ID: <71c01e60-122c-49e4-8391-ed51c4426f60@gmail.com>
Date: Tue, 9 Dec 2025 12:05:21 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
To: linux-btrfs@vger.kernel.org
References: <20251209033747.31010-1-sunk67188@gmail.com>
 <20251209033747.31010-5-sunk67188@gmail.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <20251209033747.31010-5-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/12/9 11:27, Sun YangKai 写道:
> There's a common parttern in callers of btrfs_prev_leaf:
> p->slots[0]-- if p->slots[0] points to a slot with invalid item(nritem).
> 
> So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
> valid slot and cleanup its over complex logic.
> 
> Reading and comparing keys in btrfs_prev_leaf() is unnecessary because
> when got a ret>0 from btrfs_search_slot(), slots[0] points to where we
> should insert the key. So just slots[0]-- is enough to get the previous
> item.
> 
> And then remove the related logic and cleanup the callers.
> 
> ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]))
> is enough to make sure that nritems != 0 and slots[0] points to a valid
> btrfs_item.
> 
> And getting a `nritems==0` when btrfs_prev_leaf() returns 0 is a logic
> error because btrfs_pref_leaf() should always
> 
> 1. either find a non-empty leaf
> 2. or return 1
> 
> So we can use ASSERT here.
> 
> No functional changes.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/ctree.c | 100 +++++++++--------------------------------------
>  1 file changed, 19 insertions(+), 81 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index bb886f9508e2..07e6433cde61 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2365,12 +2365,9 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
>  static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
>  {
>  	struct btrfs_key key;
> -	struct btrfs_key orig_key;
> -	struct btrfs_disk_key found_key;
>  	int ret;
>  
>  	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
> -	orig_key = key;
>  
>  	if (key.offset > 0) {
>  		key.offset--;
> @@ -2390,48 +2387,12 @@ static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
>  	if (ret <= 0)
>  		return ret;
>  
> -	/*
> -	 * Previous key not found. Even if we were at slot 0 of the leaf we had
> -	 * before releasing the path and calling btrfs_search_slot(), we now may
> -	 * be in a slot pointing to the same original key - this can happen if
> -	 * after we released the path, one of more items were moved from a
> -	 * sibling leaf into the front of the leaf we had due to an insertion
> -	 * (see push_leaf_right()).
> -	 * If we hit this case and our slot is > 0 and just decrement the slot
> -	 * so that the caller does not process the same key again, which may or
> -	 * may not break the caller, depending on its logic.
> -	 */
> -	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
> -		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
> -		ret = btrfs_comp_keys(&found_key, &orig_key);
> -		if (ret == 0) {
> -			if (path->slots[0] > 0) {
> -				path->slots[0]--;
> -				return 0;
> -			}
> -			/*
> -			 * At slot 0, same key as before, it means orig_key is
> -			 * the lowest, leftmost, key in the tree. We're done.
> -			 */
> -			return 1;
> -		}
> -	}
> +	/* There's no smaller keys in the whole tree. */
> +	if (path->slots[0] == 0)
> +		return 1;
>  
> -	btrfs_item_key(path->nodes[0], &found_key, 0);
> -	ret = btrfs_comp_keys(&found_key, &key);
> -	/*
> -	 * We might have had an item with the previous key in the tree right
> -	 * before we released our path. And after we released our path, that
> -	 * item might have been pushed to the first slot (0) of the leaf we
> -	 * were holding due to a tree balance. Alternatively, an item with the
> -	 * previous key can exist as the only element of a leaf (big fat item).
> -	 * Therefore account for these 2 cases, so that our callers (like
> -	 * btrfs_previous_item) don't miss an existing item with a key matching
> -	 * the previous key we computed above.
> -	 */
> -	if (ret <= 0)
> -		return 0;
> -	return 1;
> +	path->slots[0]--;
> +	return 0;
>  }
>  
>  /*
> @@ -2461,19 +2422,10 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
>  		if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
>  			return btrfs_next_leaf(root, p);
>  	} else {
> -		if (p->slots[0] == 0) {
> -			ret = btrfs_prev_leaf(root, p);
> -			if (ret < 0)
> -				return ret;
> -			if (!ret) {
> -				if (p->slots[0] == btrfs_header_nritems(p->nodes[0]))
> -					p->slots[0]--;
> -				return 0;
> -			}
> -			return 1;
> -		} else {
> -			p->slots[0]--;
> -		}
> +		if (p->slots[0] == 0)
> +			return btrfs_prev_leaf(root, p);

I just found we don't need to call btrfs_prev_leaf() here because we've got
ret==1 and p->slots[0] == 0 from btrfs_search_slot(), which means there's no
lower key in the whole tree so just return 1 is enough.

> +
> +		p->slots[0]--;
>  	}
>  	return 0;
>  }
> @@ -4957,26 +4909,19 @@ int btrfs_previous_item(struct btrfs_root *root,
>  			int type)
>  {
>  	struct btrfs_key found_key;
> -	struct extent_buffer *leaf;
> -	u32 nritems;
>  	int ret;
>  
>  	while (1) {
>  		if (path->slots[0] == 0) {
>  			ret = btrfs_prev_leaf(root, path);
> -			if (ret != 0)
> +			if (ret)
>  				return ret;
> -		} else {
> -			path->slots[0]--;
> -		}
> -		leaf = path->nodes[0];
> -		nritems = btrfs_header_nritems(leaf);
> -		if (nritems == 0)
> -			return 1;
> -		if (path->slots[0] == nritems)
> +		} else
>  			path->slots[0]--;
>  
> -		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +		ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
>  		if (found_key.objectid < min_objectid)
>  			break;
>  		if (found_key.type == type)
> @@ -4998,26 +4943,19 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
>  			struct btrfs_path *path, u64 min_objectid)
>  {
>  	struct btrfs_key found_key;
> -	struct extent_buffer *leaf;
> -	u32 nritems;
>  	int ret;
>  
>  	while (1) {
>  		if (path->slots[0] == 0) {
>  			ret = btrfs_prev_leaf(root, path);
> -			if (ret != 0)
> +			if (ret)
>  				return ret;
> -		} else {
> -			path->slots[0]--;
> -		}
> -		leaf = path->nodes[0];
> -		nritems = btrfs_header_nritems(leaf);
> -		if (nritems == 0)
> -			return 1;
> -		if (path->slots[0] == nritems)
> +		} else
>  			path->slots[0]--;
>  
> -		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +		ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
>  		if (found_key.objectid < min_objectid)
>  			break;
>  		if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||


