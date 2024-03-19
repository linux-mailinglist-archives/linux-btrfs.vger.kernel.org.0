Return-Path: <linux-btrfs+bounces-3443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC98804A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 19:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACF82839ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF43985A;
	Tue, 19 Mar 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kezibaO+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B438384
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872416; cv=none; b=tn7DqV9+GnsjWGX7IiDq9fnBBAoljd/2yACWARnEkv6VMv/31LSqVWS6ak/KN2GfG1atTWUDcSBGtRs9HmP1pzdG3QwNBqkglwJY2pzH/RoAotX2WsdGxZzc4PaYfmHKXcO7VWyZX2CI2c2DFDwEpLWSgSyyv5YBGAbmNQ49gpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872416; c=relaxed/simple;
	bh=kNt8X2CDNvpmVH+Z3Syn9hSKFdnUh//QJi5674o1owc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXZvAw72bSiWHFSq5n0e8YI51G7K6fXj3pGvwkazdXV+bo3EfEnXAE10rLqgilyJRle4A9WoYPm2nyohZJxfHjD1//N3wKQcy35yKnBqJfI9r/hK21Fv1nP5tSdp7Q9y1cVV7wypglhgdI3t6eiTa9w6icFTWb+COSAgN9JJkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kezibaO+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78a16114b69so15503585a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710872413; x=1711477213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNhQcqNbxqFwsL2AIBGyZ00e0ZolzLkpOfs8NReh3gI=;
        b=kezibaO+cY8cQGxL354k06pNy/7UiEXCwq5khBY+cKL7aMY1iff5BVj6jt/qfTO4KO
         gjksG5/6K8rfhIsejCscx0zTAJ+jjfPhZZn4Kl/90aV5/qxSOSBzEZUdjqD409/zXXzO
         MEJef6Dvei278y3ejFQB5CX7tFkfY7J2GRExFZKGgAeXVApx80lIlNdHU3YdwqfItXuJ
         qfUW5+ICEus/U0aL2or99mQtcxbcoI/4s83Hd7X3vw5cpIQrTURSLssvHGoGfwJ3Ebav
         9MldbizVA/lINIPykjYoHYcHvxKC+hyg76vMsxV/bnpUrZCyvklejdx13DjrSR6AZ8pf
         tXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872413; x=1711477213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNhQcqNbxqFwsL2AIBGyZ00e0ZolzLkpOfs8NReh3gI=;
        b=G6JgaTlJirG7z4yrW1XdYF5+/5q1rad+vzUGKoAhRGIJTLPGep7+ikLMloXxnze1UT
         Z0WrXDFD4+ap5ZYeXBQ5uuo2rn++YZB3xRnbAPmJkcod289jxfhyBnm6nVV+zMTi25cg
         0/DZmKXWvKW1/C7FXvzrDtOPxH6YSFvBtRNJkzVIH45w82MqkkvUfhH4vcQDg/1K+xj3
         +46E9BrlhWvJLEEmaC72KN1rawSpB+upz6omwRvPuG1nIom/pC5G22qEYVvJ9fVZU/Kz
         TbntgzBY7DMBCaSv0nf1ge3MbRga9itVaCcy51o3jkSA5cntIaaEeVr3gM7SpvJVN1lI
         AOmA==
X-Gm-Message-State: AOJu0Ywt/KlgNqtO1tlKXMzJDibVS+GOaMOHiQuYjOFlgbgiqDNYyFwK
	c9zUYxjMTTpzyVgTIZUmrwimiaxnnbpR8jT60+/n3JgnQ/UeCTrpH9iUOnZPgA4=
X-Google-Smtp-Source: AGHT+IFOzUED2XaS75LJgew8uyzi1qt9Et1lwdSxPF6TMjCIzAqkoatOx1w2Qh/GVTnP8q6jtrxYug==
X-Received: by 2002:a05:620a:31a3:b0:789:e3ee:c6a2 with SMTP id bi35-20020a05620a31a300b00789e3eec6a2mr417863qkb.37.1710872413654;
        Tue, 19 Mar 2024 11:20:13 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a136700b0078863e0f829sm4805168qkl.12.2024.03.19.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:20:13 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:20:12 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 24/29] btrfs: btrfs_drop_snapshot rename ret to ret2 and
 err to ret
Message-ID: <20240319182012.GK2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <d7c6a92fa4199b7b0e95eb02ac5d10689d7222d7.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c6a92fa4199b7b0e95eb02ac5d10689d7222d7.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:32PM +0530, Anand Jain wrote:
> To fix code style for the return variable, first rename ret to ret2
> comopile and then rename err to ret.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/extent-tree.c | 82 +++++++++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 4b0a55e66a55..acea2a7be4e5 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5858,8 +5858,8 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	struct btrfs_root_item *root_item = &root->root_item;
>  	struct walk_control *wc;
>  	struct btrfs_key key;
> -	int err = 0;
> -	int ret;
> +	int ret = 0;
> +	int ret2;
>  	int level;
>  	bool root_dropped = false;
>  	bool unfinished_drop = false;
> @@ -5868,14 +5868,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> -		err = -ENOMEM;
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
>  	wc = kzalloc(sizeof(*wc), GFP_NOFS);
>  	if (!wc) {
>  		btrfs_free_path(path);
> -		err = -ENOMEM;
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> @@ -5888,12 +5888,12 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	else
>  		trans = btrfs_start_transaction(tree_root, 0);
>  	if (IS_ERR(trans)) {
> -		err = PTR_ERR(trans);
> +		ret = PTR_ERR(trans);
>  		goto out_free;
>  	}
>  
> -	err = btrfs_run_delayed_items(trans);
> -	if (err)
> +	ret = btrfs_run_delayed_items(trans);
> +	if (ret)
>  		goto out_end_trans;
>  
>  	/*
> @@ -5922,13 +5922,13 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  		level = btrfs_root_drop_level(root_item);
>  		BUG_ON(level == 0);
>  		path->lowest_level = level;
> -		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +		ret2 = btrfs_search_slot(NULL, root, &key, path, 0, 0);
>  		path->lowest_level = 0;
> -		if (ret < 0) {
> -			err = ret;
> +		if (ret2 < 0) {
> +			ret = ret2;
>  			goto out_end_trans;
>  		}
> -		WARN_ON(ret > 0);
> +		WARN_ON(ret2 > 0);
>  
>  		/*
>  		 * unlock our path, this is safe because only this
> @@ -5941,12 +5941,12 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  			btrfs_tree_lock(path->nodes[level]);
>  			path->locks[level] = BTRFS_WRITE_LOCK;
>  
> -			ret = btrfs_lookup_extent_info(trans, fs_info,
> +			ret2 = btrfs_lookup_extent_info(trans, fs_info,
>  						path->nodes[level]->start,
>  						level, 1, &wc->refs[level],
>  						&wc->flags[level], NULL);
> -			if (ret < 0) {
> -				err = ret;
> +			if (ret2 < 0) {
> +				ret = ret2;
>  				goto out_end_trans;
>  			}
>  			BUG_ON(wc->refs[level] == 0);
> @@ -5971,21 +5971,21 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  
>  	while (1) {
>  
> -		ret = walk_down_tree(trans, root, path, wc);
> -		if (ret < 0) {
> -			btrfs_abort_transaction(trans, ret);
> -			err = ret;
> +		ret2 = walk_down_tree(trans, root, path, wc);
> +		if (ret2 < 0) {
> +			btrfs_abort_transaction(trans, ret2);
> +			ret = ret2;
>  			break;
>  		}
>  
> -		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
> -		if (ret < 0) {
> -			btrfs_abort_transaction(trans, ret);
> -			err = ret;
> +		ret2 = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
> +		if (ret2 < 0) {
> +			btrfs_abort_transaction(trans, ret2);
> +			ret = ret2;
>  			break;
>  		}
>  
> -		if (ret > 0) {
> +		if (ret2 > 0) {
>  			BUG_ON(wc->stage != DROP_REFERENCE);

This can be changed to

if (ret > 0) {
	BUG_ON(wc->stage != DROP_REFERENCE);
	ret = 0;
	break;
}

>  			break;
>  		}
> @@ -6003,12 +6003,12 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  		BUG_ON(wc->level == 0);
>  		if (btrfs_should_end_transaction(trans) ||
>  		    (!for_reloc && btrfs_need_cleaner_sleep(fs_info))) {
> -			ret = btrfs_update_root(trans, tree_root,
> +			ret2 = btrfs_update_root(trans, tree_root,
>  						&root->root_key,
>  						root_item);
> -			if (ret) {
> -				btrfs_abort_transaction(trans, ret);
> -				err = ret;
> +			if (ret2) {
> +				btrfs_abort_transaction(trans, ret2);
> +				ret = ret2;
>  				goto out_end_trans;
>  			}
>  
> @@ -6019,7 +6019,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
>  				btrfs_debug(fs_info,
>  					    "drop snapshot early exit");
> -				err = -EAGAIN;
> +				ret = -EAGAIN;
>  				goto out_free;
>  			}
>  
> @@ -6033,30 +6033,30 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  			else
>  				trans = btrfs_start_transaction(tree_root, 0);
>  			if (IS_ERR(trans)) {
> -				err = PTR_ERR(trans);
> +				ret = PTR_ERR(trans);
>  				goto out_free;
>  			}
>  		}
>  	}
>  	btrfs_release_path(path);
> -	if (err)
> +	if (ret)
>  		goto out_end_trans;
>  
> -	ret = btrfs_del_root(trans, &root->root_key);
> -	if (ret) {
> -		btrfs_abort_transaction(trans, ret);
> -		err = ret;
> +	ret2 = btrfs_del_root(trans, &root->root_key);
> +	if (ret2) {
> +		btrfs_abort_transaction(trans, ret2);
> +		ret = ret2;
>  		goto out_end_trans;
>  	}
>  
>  	if (!is_reloc_root) {
> -		ret = btrfs_find_root(tree_root, &root->root_key, path,
> +		ret2 = btrfs_find_root(tree_root, &root->root_key, path,
>  				      NULL, NULL);
> -		if (ret < 0) {
> -			btrfs_abort_transaction(trans, ret);
> -			err = ret;
> +		if (ret2 < 0) {
> +			btrfs_abort_transaction(trans, ret2);
> +			ret = ret2;
>  			goto out_end_trans;
> -		} else if (ret > 0) {
> +		} else if (ret2 > 0) {

And then here we just set ret = 0 again, and then we have no need for ret2.
Thanks,

Josef

