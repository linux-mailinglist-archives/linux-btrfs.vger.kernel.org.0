Return-Path: <linux-btrfs+bounces-15756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEDB1659F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0609C4E3D44
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED82E0407;
	Wed, 30 Jul 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="d8Q9NhH4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fx50JZKz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC33248881
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897070; cv=none; b=sqB4rCeA3YLe1dGIxgDW2vZVomlf18L5gAZjuiqJM5FGs3UlkGsNj7MB2LvxuPi7dYhkZwko4+1VoPQDLzF1dEJKLhHl0DTj+x7iN6JlgBdY9y0xrouRE5sL0/67q1aZ81BksXrc2svS3p+oLURNZiXDFNPWv4R0/735pzm6D5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897070; c=relaxed/simple;
	bh=JN5E98p+i/9bPnRz2EqQwceunz48FG3Q7XSHTrByK8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3AHBBw6d7CquvT9QugKopUiko0T1D8O3azmrLZlFiweJvChu6YJ7+BHwYB1YEoQX+H2oFMpm2WoqS/Lt+0kjrz1eVgqbS5vA2RDMarC8V5EYjBbFVi11HQVv2KOHZrktNjHHu48xJSN89l2b+TD22bYB97riXuD+8ds7LX+Lho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=d8Q9NhH4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fx50JZKz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 403637A011A;
	Wed, 30 Jul 2025 13:37:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 30 Jul 2025 13:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753897067; x=1753983467; bh=9qnqcmCj5o
	HrjshiPwYD25WIi1zTYBoIlxLJJKsmEuk=; b=d8Q9NhH49XZu5Ynx6vqN461Szg
	No+8/lvzpgSZOPxNdQKN6RSMxq4+b7616vHO/l108rWXLhq05x6sRGlhq3lHZDdv
	2wnQu6jx7K0O4FmdR8HTRV7shhuoLpPu5D0d+61v8XL/91ogKWteHfd6Im16SQIK
	zcrnRuO4IyYx8BOTBrytvim728pMBGfva9Y3irOOTCs8f+j6EosllmqSfNevWRhM
	GaTXAavrE7akiOYiF70sn4m6bYY/u7cn1WNB9C7nIvtApuI9egMIl4P+54z3wQQd
	DOJKAwTfCIlZslqz+i4g4AbayNf9uwZ7SqVS9TdDtN+zrBNIGXkSXkFSlVRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753897067; x=1753983467; bh=9qnqcmCj5oHrjshiPwYD25WIi1zTYBoIlxL
	JJKsmEuk=; b=Fx50JZKz4nsaaJDDaCzJ14jolOWImNCw4AoVE8UqGMvXzJ8o7l1
	1zxmGycpjhAPqvAKPNStUeT/o5q93u+09n0rE1C4H53AKMrX07wgFNMRyUTNPMLR
	vkFbNZwAYr0KnEFq0btRlE6kr+RYSeHgNgZn27MO81DkMcUUZQYZkJ/FuvlAprKw
	fiWkDAHxP55fgU0c0GOUG1zkrRdKylId1Zm7ps5GblaP5cis1UxjKy8eVAdNfI7p
	83ej6EVxG+3xqghOp6OwGvjy63FiV+Rwo+3Jb4Vk0/WDs4r31tRYEvhjuZIhjBRL
	bWo3ZSnSjz45kfAsHGD2Lhv3veNRvi/9VmQ==
X-ME-Sender: <xms:aliKaPkK_d-ZsYn15cunejSpfW1xQ1GFupU53KFre34xux6IsrpvJQ>
    <xme:aliKaAyr_-muCvV5x2PubhdwWcKLpgyVVYoDoExjLIduB_zVMjsHoJG-y_ajkhGSl
    jA3ajvAWEadh6c-N90>
X-ME-Received: <xmr:aliKaNMZX1Zih3WJkvWrbgVQ2U-cf1Geks5S1iG-NWcMQD3cLB1sdDc4LiFdOUUFdYQS9f-Q1VTG2tnI7TSJ7af7VBc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:aliKaER8zZ1555-nvXb683A-3MVYh9oiD97yWdmZKCq4ijI2gY9KZw>
    <xmx:aliKaLazZzCAYG05rxZqyGbrDmHPIlWYgL4KuzBUXDdZ3UCLlyE1PA>
    <xmx:aliKaB0AN_kz3r15BFQVnynDhEW0sI_keXFiRyppG3NFkpV2EjM0xQ>
    <xmx:aliKaLUiv_vNEGhu6UhYR2o7h-nuZHXzrRtyhzNViraxq7gpST-zlA>
    <xmx:a1iKaC5sfLxIPx-Ppk_jGjHMO-X1ybFbOrsV6ivraL56WvotYahtbVK->
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 13:37:46 -0400 (EDT)
Date: Wed, 30 Jul 2025 10:38:55 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix race between logging inode and checking if it
 was logged before
Message-ID: <20250730173855.GB2742973@zen.localdomain>
References: <7585d15c0e9c163d5cdf32307014a4e792e62541.1753807163.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7585d15c0e9c163d5cdf32307014a4e792e62541.1753807163.git.fdmanana@suse.com>

On Tue, Jul 29, 2025 at 06:02:05PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's a race between checking if an inode was logged before and logging
> an inode that can cause us to mark an inode as not logged just after it
> was logged by a concurrent task:
> 
> 1) We have inode X which was not logged before neither in the current
>    transaction not in past transaction since the inode was loaded into
>    memory, so it's ->logged_trans value is 0;
> 
> 2) We are at transaction N;
> 
> 3) Task A calls inode_logged() against inode X, sees that ->logged_trans
>    is 0 and there is a log tree and so it proceeds to search in the log
>    tree for an inode item for inode X. It doesn't see any, but before
>    it sets ->logged_trans to N - 1...
> 
> 3) Task B calls btrfs_log_inode() against inode X, logs the inode and
>    sets ->logged_trans to N;
> 
> 4) Task A now sets ->logged_trans to N - 1;
> 
> 5) At this point anyone calling inode_logged() gets 0 (inode not logged)
>    since ->logged_trans is greater than 0 and less than N, but our inode
>    was really logged. As a consequence operations like rename, unlink and
>    link that happen afterwards in the current transaction end up not
>    updating the log when they should.
> 
> The same type of race happens in case our inode is a directory when we
> update the inode's ->last_dir_index_offset field at inode_logged() to
> (u64)-1, and in that case such a race could make directory logging skip
> logging new entries at process_dir_items_leaf(), since any new dir entry
> has an index less than (u64).
> 
> Fix this by ensuring inode_logged() is always called while holding the
> inode's log_mutex.

Reviewed-by: Boris Burkov <boris@bur.io>

The fix and explanation of the inode_logged() vs btrfs_log_inode() logic
as it pertains to setting logged_trans make sense to me.

I do have one question, though, if you don't mind:

How come higher level inode locking doesn't protect us? What paths down
into inode_logged() and btrfs_log_inode() can run concurrently on the
same inode? Intuitively, I would expect that anything which calls
btrfs_log_inode() would need to write lock the inode and anything that
calls inode_logged() would at least read lock it? Poking around the code
myself as well, but figured I would ask..

Thanks,
Boris

> 
> Fixes: 0f8ce49821de ("btrfs: avoid inode logging during rename and link when possible")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tree-log.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 43a96fb27bce..8c6d1eb84d0e 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3485,14 +3485,27 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
>   * Returns 1 if the inode was logged before in the transaction, 0 if it was not,
>   * and < 0 on error.
>   */
> -static int inode_logged(const struct btrfs_trans_handle *trans,
> -			struct btrfs_inode *inode,
> -			struct btrfs_path *path_in)
> +static int inode_logged_locked(const struct btrfs_trans_handle *trans,
> +			       struct btrfs_inode *inode,
> +			       struct btrfs_path *path_in)
>  {
>  	struct btrfs_path *path = path_in;
>  	struct btrfs_key key;
>  	int ret;
>  
> +	/*
> +	 * The log_mutex must be taken to prevent races with concurrent logging
> +	 * as we may see the inode not logged when we are called but it gets
> +	 * logged right after we did not find it in the log tree and we end up
> +	 * setting inode->logged_trans to a value less than trans->transid after
> +	 * the concurrent logging task has set it to trans->transid. As a
> +	 * consequence, subsequent rename, unlink and link operations may end up
> +	 * not logging new names and removing old names from the log.
> +	 * The same type of race also happens if out inode is a directory when
> +	 * we update inode->last_dir_index_offset below.
> +	 */
> +	lockdep_assert_held(&inode->log_mutex);
> +
>  	if (inode->logged_trans == trans->transid)
>  		return 1;
>  
> @@ -3594,6 +3607,19 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
>  	return 1;
>  }
>  
> +static inline int inode_logged(const struct btrfs_trans_handle *trans,
> +			       struct btrfs_inode *inode,
> +			       struct btrfs_path *path)
> +{
> +	int ret;
> +
> +	mutex_lock(&inode->log_mutex);
> +	ret = inode_logged_locked(trans, inode, path);
> +	mutex_unlock(&inode->log_mutex);
> +
> +	return ret;
> +}
> +
>  /*
>   * Delete a directory entry from the log if it exists.
>   *
> @@ -6678,7 +6704,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
>  	 * inode_logged(), because after that we have the need to figure out if
>  	 * the inode was previously logged in this transaction.
>  	 */
> -	ret = inode_logged(trans, inode, path);
> +	ret = inode_logged_locked(trans, inode, path);
>  	if (ret < 0)
>  		goto out_unlock;
>  	ctx->logged_before = (ret == 1);
> -- 
> 2.47.2
> 

