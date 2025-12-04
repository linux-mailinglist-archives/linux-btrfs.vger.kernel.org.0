Return-Path: <linux-btrfs+bounces-19501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C98CA20A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 01:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DA2C3012752
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 00:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2419F48D;
	Thu,  4 Dec 2025 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dVE0MQlN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6HBQrMI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238219D89E
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764808136; cv=none; b=LiIDSTy5aXO+XqpVdc6Ij4LY7k9If7Ii1CV94dG0BE/jU66eLiC770EebYQGLNK5kFB8c860dHUc0zKzexRfPa4W/t0UMDu6g1ufunCAjUQds4KNfgTE8INpGU1CDCyuTQ8+OwsR7w9mdRMo9nfbljO4BbqCnrFos26CR6Ff6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764808136; c=relaxed/simple;
	bh=TzM1W9BN9YKAPxeurpcblGYDYItmyOoYBTd8sbZ7tZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5XgIm1yZkl/oyhlVx8x/EPybKvmNg5UZuEg1yTnxAqbA4heiZ8Q2HwWshw22A5v4TSt/dI5VlRLyS2yz6cpQ7yJu5poKd/mp5uMIIOkSEqcSNFY1SzQvP/jcAl3sd6rdD4R9is/7AnWNj9pgPEKV7rJ2q7RKqHSSEsuFu0DkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dVE0MQlN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6HBQrMI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 755321D000D1;
	Wed,  3 Dec 2025 19:28:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 03 Dec 2025 19:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764808133; x=1764894533; bh=BnUMqd5iqN
	6V0W+6OqlDgpJj5H1zSIO1L454kjlzViw=; b=dVE0MQlNPC+Wo5qG5E8d2NmRCu
	nWYzQtozuunuJoZSDOc4R2n4480Uzq0K8kswJ22VCnZUPgiC+kENOaeYZTtL338b
	HSWJQYJA4vTDvgdVOwwUFEesxKMfQRcWVJm/E8zPkNwa3dw1Xj/ENXxS913bLE4s
	Yfb9jX8uL1z3FWFjCtC/4E6+dgHCswFURHai/2Rlkg00O0FAuxSwf2koPGha2crf
	XFzbIuehZfPly4Hx0sFWn8bUw7iAgYtGSGVzlPuiEcUlCeY7+rujKYG41k1pwKQw
	h4JX/6TpOXyqcvnFfR0Sc85IhDVh7nLC5eA9Rmx2lcNaHgMzML+CsX93xrWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764808133; x=1764894533; bh=BnUMqd5iqN6V0W+6OqlDgpJj5H1zSIO1L45
	4kjlzViw=; b=n6HBQrMIwvrE0yZn1I6XZ1Sgzf+RNOX8E5RNVe2OwpFagkpJAnM
	mQ4NKTUFEhB4NwX9FS1CpsNrvm5xXTPuOUMML/uQGKv0HnjS4MJNOVk2RqlJHMxL
	Y2TF2Os51lBMkv7ZWeE75096SQIqAq+Xn6Ilg8Yk/F7LK25JEwdMY1IU7x0SzH/r
	uGL51dWzKvtAKvIumK+5oic2Hg84lJjby9MvCb+Ktr2WjsJiM1NXqakiLEdMqj7U
	WoI7Nmi3sWcEQhZ56YyzF6RRRPFqQ2zW0Ed4LN4NIXjAKEJrOFwPi+Vl8grBcG/u
	wetrOSN0l0/nspumopLaSId6J/wNROlNt9A==
X-ME-Sender: <xms:xdUwaRJUxgDbHFcp9vZdMBp9K2Z0FqWJPAGaplsfbtqj9yEEJuvrBA>
    <xme:xdUwaTKXJXlf8GVjkaoPQvgtKLHGAGsZsFY5lkjabcFe91kcU3p0YFA23viDuxGJ-
    FF5sYTK7rbtzPJR-N7PVTkIbbQB3O2x-khIlK3-2pnILGSXQOCluQ>
X-ME-Received: <xmr:xdUwaXVCOU2BjQ74yyEFiJlauf_sVHUCizUgtjoR3HA-9pEfXTYezt0MJ5R5RSOEsVRZp7AKQoR6VioNfeVJdqlPwRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeiheeihe
    etleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    fhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsth
    hrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xdUwadiyzDTN_3aw9oLTMh9IHkhgCMZ0aR8C6pVCnAFtiUWG1e7nlA>
    <xmx:xdUwaa-zvHwH9U7NWb_dQEnjHfH5nRgMmYyhWiuoEEBtG34nFI3ung>
    <xmx:xdUwafCms6q6qxSYmmlqE7T3DpSoS0CZklIzI_so4rkD0kg8o7vQlA>
    <xmx:xdUwafJmTvev2FhTRghlyQqBn_3UeunthgjwN7hJWlXlT5TcoWF1eA>
    <xmx:xdUwaQ81lCLjBecE-Tb2R16YIytbHRNxXRnBNlpzdgIj99W5ftAnQrA6>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 19:28:52 -0500 (EST)
Date: Wed, 3 Dec 2025 16:29:12 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: do not skip logging new dentries when logging
 a new name
Message-ID: <20251204002912.GA3671224@zen.localdomain>
References: <a1b70971f8b73d44695ab6af56b69e0ae1010179.1764783284.git.fdmanana@suse.com>
 <818f6f16e33bfa2da9bd0101e49a47aad44a791a.1764799815.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <818f6f16e33bfa2da9bd0101e49a47aad44a791a.1764799815.git.fdmanana@suse.com>

On Wed, Dec 03, 2025 at 10:13:18PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we are logging a directory and the log context indicates that we
> are logging a new name for some other file (that is or was inside that
> directory), we skip logging the inodes for new dentries in the directory.
> 
> This is ok most of the time, but if after the rename or link operation
> that triggered the logging of that directory, we have an explicit fsync
> of that directory without the directory inode being evicted and reloaded,
> we end up never logging the inodes for the new dentries that we found
> during the new name logging, as the next directory fsync will only process
> dentries that were added after the last time we logged the directory (we
> are doing an incremental directory logging).
> 
> So make sure we always log new dentries for a directory even if we are
> in a context of logging a new name.
> 
> We started skipping logging inodes for new dentries as of commit
> c48792c6ee7a ("btrfs: do not log new dentries when logging that a new name
> exists") and it was fine back then, because when logging a directory we
> always iterated over all the directory entries (for leaves changed in the
> current transaction) so a subsequent fsync would always log anything that
> was previously skipped while logging a directory when logging a new name
> (with btrfs_log_new_name()). But later support for incrementally logging
> a directory was added in commit dc2872247ec0 ("btrfs: keep track of the
> last logged keys when logging a directory"), to avoid checking all dir
> items every time we log a directory, so the check to skip dentry logging
> added in the first commit should have been removed when the incremental
> support for logging a directory was added.
> 
> A test case for fstests will follow soon.
> 
> Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/84c4e713-85d6-42b9-8dcf-0722ed26cb05@gmail.com/
> Fixes: dc2872247ec0 ("btrfs: keep track of the last logged keys when logging a directory")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
> 
> V2: Update changelog to be more detailed about when skipping the logging
>     of new dentries during new name logging became incorrect, and update
>     the Fixes commit.
> 
>  fs/btrfs/tree-log.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 64c1155160a2..31edc93a383e 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -5865,14 +5865,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
>  	struct btrfs_inode *curr_inode = start_inode;
>  	int ret = 0;
>  
> -	/*
> -	 * If we are logging a new name, as part of a link or rename operation,
> -	 * don't bother logging new dentries, as we just want to log the names
> -	 * of an inode and that any new parents exist.
> -	 */
> -	if (ctx->logging_new_name)
> -		return 0;
> -
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> -- 
> 2.47.2
> 

