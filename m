Return-Path: <linux-btrfs+bounces-14667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDC4ADB5C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152593B23F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5430B27FB2E;
	Mon, 16 Jun 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="U1b/xLN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdkfZysx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497D273D78
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088727; cv=none; b=HRWpJ4nq0b9EJ/sJ11S9MEsADn5+kb3E3x9DP5DUrkEQuufmYHDFCo8OSfn2npSnjZBnLrbdF2BGAClVUFWyG66iFcnOFtqgcbz+8rWzUzaKgqzBDOxxKAvsDnNL6a0oCIfCqIod229kF+idDK2wVXDJRawlJvYlZz3RNoRZkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088727; c=relaxed/simple;
	bh=hjpiglZeiWDZ0tWNoJrJlTtmuI84eCZzLWJYC6sbvR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhDlqgqfWvDKW3SPUCTh9qgIvuLYqo+TFFlwUwAWjofH2gslWchziWES1IX0LfTcybqRYPi/LAZBXnPU/WXAYHa81zQ3r50DhluvaqDQGLES4SFg2nu4YjKdSs6AXAgGVS6lHzYOmRAqtHColD60g9jwR9pv6g9rqahXPpM/Zyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=U1b/xLN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdkfZysx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EFBC713803DF;
	Mon, 16 Jun 2025 11:45:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 16 Jun 2025 11:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1750088723; x=1750175123; bh=Xf/8QGWqvA
	uZ8iB3fprWkfQaXOj5quSrziKI5o8uxJ0=; b=U1b/xLN8EfVwcyDBGLxYSMrD8t
	A5GOY+/chv4T7M3LLVWjzYPz/XJQybp3/CL3W7dbICBEoWINrMER93WLoaqNd0nC
	dFZ4YbobOia10LDZGKDzyBtz3iXmEH68zNHspOTM5o8oz0plgQudaSRzIr2YwMYB
	xla7iJqXEKvTa7WZshlabNx/vHki0W0jRSKH42dtItSrrYh2Jet3IOLOCr+F3kVx
	U7yHdN4HI4/ktqiVv3Jo8USmcMcwl2DriwLgldP82xsV1eWRZ/EdZKK34nKX6mlf
	BIJJSUHrlUTvgcG4ArV+V/+1xRLu2a4AwdSkA5gDKE1/b3dnyRJUuEEUg+NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750088723; x=1750175123; bh=Xf/8QGWqvAuZ8iB3fprWkfQaXOj5quSrziK
	I5o8uxJ0=; b=IdkfZysxdKBWAccyA2kaP1mpmM3uEzJ0YWvEFgXvoeTxMttixOH
	ogF+QcYNlH0Op2hgT/oRCNB/xSt1b5vBqOj84T0aS1XI8uhdfK6+iYg+P4hEAWz3
	aak+ejLskHpZ6y7Jf7XyYFT1ULrS1KjA9DGMWkiF+weicqcc8b6sOVIil+xwLhbW
	yMWjow+EliUiYKcOPds+KPipB9n4IX2f5mQzis9xhCZ2BSz8MKhQMjXtd2JZY18R
	/YD4qDdzyJCEghgr9i0sfS0i6ZwKJrXBQo7fenuU8yNc9g6OsvwlaY9tWycUhBXu
	Az5zBo+hCvPpS6PQXWLICdkNXnsNMAjr1Jg==
X-ME-Sender: <xms:EzxQaNiaToOH_z2VT9kZdgGYJiDviSmd3AG1Am2T8JraRhfrVTixyg>
    <xme:EzxQaCAarN7EEbOOTBh8azQrQ6YSgx1OXOFeNGMw3IFBFFbYV1u5kaIuIJ0uKnmia
    opvNgf1MOGisrPOWvI>
X-ME-Received: <xmr:EzxQaNE3oDsSIvKyeczSlol0aLzyNjwomJihVXhsIcRe4AinanBEWzFvXG9Zz459poZr_inQJ4V1KhrL7e8NOoz6DWk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhf
    evhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgr
    nhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EzxQaCT27EwvV_MVFcEx7dnhOCNbHExmS32-vyCNZjVshAz09QxVnA>
    <xmx:EzxQaKzpfAN5aRrXEHyG5n0DlUVdP6Efx6RswWNuYBBHZVIJvAeHDA>
    <xmx:EzxQaI6ilsltylDDE92ZUX9xR-YKkY-P1ZDAx9iX1wD3mihcuXidMQ>
    <xmx:EzxQaPxbtJzGULSoKIVkfr2_MhIuQ9g8iTIGHekDM1oiqIM7gixUpw>
    <xmx:EzxQaCdza6tFzO1QexstkpbK0tJI4jeH6n-C1SNFygubDQOemNiyzdm9>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 11:45:23 -0400 (EDT)
Date: Mon, 16 Jun 2025 08:44:58 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: check BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE at
 __add_block_group_free_space()
Message-ID: <20250616154458.GA812359@zen.localdomain>
References: <cover.1749421865.git.fdmanana@suse.com>
 <40dd299a0b7551fb8163da00a6ed716a8f8c3d46.1749421865.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40dd299a0b7551fb8163da00a6ed716a8f8c3d46.1749421865.git.fdmanana@suse.com>

On Sun, Jun 08, 2025 at 11:43:34PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Every caller of __add_block_group_free_space() is checking if the flag
> BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE is set before calling it. This is
> duplicate code and it's prone to some mistake in case we add more callers
> in the future. So move the check for that flag into the start of
> __add_block_group_free_space().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/free-space-tree.c | 58 ++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index af005fb4b676..f03f3610b713 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -816,11 +816,9 @@ int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>  	u32 flags;
>  	int ret;
>  
> -	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
> -		ret = __add_block_group_free_space(trans, block_group, path);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = __add_block_group_free_space(trans, block_group, path);
> +	if (ret)
> +		return ret;
>  
>  	info = search_free_space_info(NULL, block_group, path, 0);
>  	if (IS_ERR(info))
> @@ -1011,11 +1009,9 @@ int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
>  	u32 flags;
>  	int ret;
>  
> -	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
> -		ret = __add_block_group_free_space(trans, block_group, path);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = __add_block_group_free_space(trans, block_group, path);
> +	if (ret)
> +		return ret;
>  
>  	info = search_free_space_info(NULL, block_group, path, 0);
>  	if (IS_ERR(info))
> @@ -1403,9 +1399,12 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
>  					struct btrfs_block_group *block_group,
>  					struct btrfs_path *path)
>  {
> +	bool own_path = false;
>  	int ret;
>  
> -	clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags);
> +	if (!test_and_clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> +				&block_group->runtime_flags))
> +		return 0;
>  
>  	/*
>  	 * While rebuilding the free space tree we may allocate new metadata
> @@ -1430,10 +1429,19 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
>  	 */
>  	set_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &block_group->runtime_flags);
>  
> +	if (!path) {
> +		path = btrfs_alloc_path();
> +		if (!path) {
> +			btrfs_abort_transaction(trans, -ENOMEM);
> +			return -ENOMEM;
> +		}
> +		own_path = true;
> +	}
> +

Is the "own_path" change intended to be bundled with this one? If so,
can you mention it in the commit message as well?

>  	ret = add_new_free_space_info(trans, block_group, path);
>  	if (ret) {
>  		btrfs_abort_transaction(trans, ret);
> -		return ret;
> +		goto out;
>  	}
>  
>  	ret = __add_to_free_space_tree(trans, block_group, path,
> @@ -1441,33 +1449,23 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
>  	if (ret)
>  		btrfs_abort_transaction(trans, ret);
>  
> -	return 0;
> +out:
> +	if (own_path)
> +		btrfs_free_path(path);
> +
> +	return ret;
>  }
>  
>  int add_block_group_free_space(struct btrfs_trans_handle *trans,
>  			       struct btrfs_block_group *block_group)
>  {
> -	struct btrfs_fs_info *fs_info = trans->fs_info;
> -	struct btrfs_path *path = NULL;
> -	int ret = 0;
> +	int ret;
>  
> -	if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
> +	if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
>  		return 0;
>  
>  	mutex_lock(&block_group->free_space_lock);
> -	if (!test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags))
> -		goto out;
> -
> -	path = btrfs_alloc_path();
> -	if (!path) {
> -		ret = -ENOMEM;
> -		btrfs_abort_transaction(trans, ret);
> -		goto out;
> -	}
> -
> -	ret = __add_block_group_free_space(trans, block_group, path);
> -out:
> -	btrfs_free_path(path);
> +	ret = __add_block_group_free_space(trans, block_group, NULL);
>  	mutex_unlock(&block_group->free_space_lock);
>  	return ret;
>  }
> -- 
> 2.47.2
> 

