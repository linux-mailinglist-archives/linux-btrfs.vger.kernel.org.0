Return-Path: <linux-btrfs+bounces-15117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB41AEE4AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B26F7A412E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815C290BCC;
	Mon, 30 Jun 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="STOjJ74u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lnYz/Mvt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646224A05D
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301162; cv=none; b=tvnqeukTCWDqEuH0t3HCJLncI8Y1X7GwK/7C102eZLN1O3rfOUXTS61jbgyrDybZfjDzzadS7ATkNFDUsKzjXEotU1ZWVC+wxMhTLRoDW2L4xbutwiLH6ApIxOZ1d7RL9u08X6Tss4zesNqfMw4QvzXwVjldIld5zRAUBL96l38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301162; c=relaxed/simple;
	bh=tFfStmie5ehogJyjyBbpI1KWgkE40Z3NrNNPLfyns1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f74q+2GczgQ6GLmccVLBgFHV9YwEtz9kpMNViPQhItqR54PnWqT6efhOw77nMXPC2/tJz3dLssK3IluRNBxz3xewvsGPDCVybj94uxDyBf/sq93V7We/SBEfhJMmdOnfE0/Lg827AJKooewCWGbCc9HyUR1zeaLGu4v9kqhubHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=STOjJ74u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lnYz/Mvt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C41814001EA;
	Mon, 30 Jun 2025 12:32:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 30 Jun 2025 12:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751301158; x=1751387558; bh=HknrKVRq62
	g4138Q1lVe9TMYZVN/S+9/gY9r3kp1Vpw=; b=STOjJ74umxDkOk7B1u+nKJW01Y
	bu6JoA7/nU1EwE4cqyQZHQdQQgpF97tIyxm7JBySVbv1w3WbmlueNJotXCpIyp6z
	PRvxfqfSrDwvbmbbNjwaI0p441V3v1ufqrhSn7B9k6G7QGFwZLexKx3rPK/v7g+B
	XtCsP7FtuIL3+XLORZB5yaGu8OJ6N2VDO8vkBmgt7P7YzcWmr04kkYJU+lrSjLNj
	YaKWZMdmVEsQauM4IMh2TLHDGAUGtmen4aSoCq/uaaXqn1SCLyf0v4IlWjCxiQXk
	1kfB5TpZH+rD7AsKtp1Z+XwnVYDrKrxRgZpcu4hWhJ5spbK/O1VXA0jLjP1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751301158; x=1751387558; bh=HknrKVRq62g4138Q1lVe9TMYZVN/S+9/gY9
	r3kp1Vpw=; b=lnYz/Mvt1NE0YgVzwI/JwBdT06IcT405TVVUWQ3TNLb1jowxaN0
	UKK7N/j2PXIjwXNo7d5pVHXyiKSw9S5CSqn+ia2VFj5bi8f2a8Ncp1Pn2MNUh9W/
	W0Lovs1RQDFlAgZ/CZfupGvpOzCND0RWEFO344Er/uR+CDm4bJs9+um3KT0TSnsC
	b0ByHAqw4f+9i08wtBVSAfr7zHreM6misYl0MTx6iYuxf6ZH/5I4TjU8y8DukNGY
	YUD1jil5oWVvpgBlFfLUg6WyLM3qFsm5sU2czcOy2uODsEmGAlUte46dKlEJiHy8
	/gO09oBK0rh5HHhmYM1B5rIvvU7eNa21L9g==
X-ME-Sender: <xms:JrxiaAnlMOTjAtTZrmWDmYvvy-j8t4FXU-TEctId-X3TC8CgEgkciA>
    <xme:JrxiaP222VAj9Gx9RqCw-k-yUSVCTlHlrgHbZHO2VyVWRO1I1fGW0UqVOKOVhPIp9
    UiccjeowDCnKmiRF0c>
X-ME-Received: <xmr:JrxiaOqPthX52nw0ZfkOfF57Iyx5vCtlWLc0C3YCbrLVnhB0KbvZ-NRvOMp8EmTGD1-MMAtclqB69kXWjhQtKa35owc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:JrxiaMnuoiC5p9QMJDHj1Z4oVac0GQ6GWc4AOxUFEjivtEgCr7FtDA>
    <xmx:JrxiaO0FePNjLeXUV89S_1Gu-IHEc-Xo0K-2r-KRNfppRJDQf-Ehow>
    <xmx:JrxiaDsQ0PxXUifIXjQkLIMwJ3egJeeDJsST9JgHs0ihHXfd-hb9lA>
    <xmx:JrxiaKV8LSbQOTodb0E9pc0CyPadupZ91yUVBJiEF552Vr48Cun63w>
    <xmx:JrxiaFAcd_6YA6gReEKWHzjIfQahucZHOnFy3aF5n47MOpEhTm9WMcwK>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 12:32:37 -0400 (EDT)
Date: Mon, 30 Jun 2025 09:34:16 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs: qgroup: remove no longer used
 fs_info->qgroup_ulist
Message-ID: <20250630163416.GB61133@zen.localdomain>
References: <cover.1751288689.git.fdmanana@suse.com>
 <6051db0c1a943d7f896fbb5b9cd548908e161ed0.1751288689.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6051db0c1a943d7f896fbb5b9cd548908e161ed0.1751288689.git.fdmanana@suse.com>

On Mon, Jun 30, 2025 at 02:07:48PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's not used anymore after commit 091344508249 ("btrfs: qgroup: use
> qgroup_iterator in qgroup_convert_meta()"), so remove it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/disk-io.c |  1 -
>  fs/btrfs/fs.h      |  6 ------
>  fs/btrfs/qgroup.c  | 31 +------------------------------
>  3 files changed, 1 insertion(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f6fa951c6be9..ee4911452cfd 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1947,7 +1947,6 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
>  	fs_info->qgroup_tree = RB_ROOT;
>  	INIT_LIST_HEAD(&fs_info->dirty_qgroups);
>  	fs_info->qgroup_seq = 1;
> -	fs_info->qgroup_ulist = NULL;
>  	fs_info->qgroup_rescan_running = false;
>  	fs_info->qgroup_drop_subtree_thres = BTRFS_QGROUP_DROP_SUBTREE_THRES_DEFAULT;
>  	mutex_init(&fs_info->qgroup_rescan_lock);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index b239e4b8421c..a731c883687d 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -740,12 +740,6 @@ struct btrfs_fs_info {
>  	struct rb_root qgroup_tree;
>  	spinlock_t qgroup_lock;
>  
> -	/*
> -	 * Used to avoid frequently calling ulist_alloc()/ulist_free()
> -	 * when doing qgroup accounting, it must be protected by qgroup_lock.
> -	 */
> -	struct ulist *qgroup_ulist;
> -
>  	/*
>  	 * Protect user change for quota operations. If a transaction is needed,
>  	 * it must be started before locking this lock.
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 8fa874ef80b3..98a53e6edb2c 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -397,12 +397,6 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>  	if (!fs_info->quota_root)
>  		return 0;
>  
> -	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
> -	if (!fs_info->qgroup_ulist) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
>  	path = btrfs_alloc_path();
>  	if (!path) {
>  		ret = -ENOMEM;
> @@ -587,8 +581,6 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>  		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN)
>  			ret = qgroup_rescan_init(fs_info, rescan_progress, 0);
>  	} else {
> -		ulist_free(fs_info->qgroup_ulist);
> -		fs_info->qgroup_ulist = NULL;
>  		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
>  		btrfs_sysfs_del_qgroups(fs_info);
>  	}
> @@ -660,13 +652,6 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
>  	}
>  	spin_unlock(&fs_info->qgroup_lock);
>  
> -	/*
> -	 * We call btrfs_free_qgroup_config() when unmounting
> -	 * filesystem and disabling quota, so we set qgroup_ulist
> -	 * to be null here to avoid double free.
> -	 */
> -	ulist_free(fs_info->qgroup_ulist);
> -	fs_info->qgroup_ulist = NULL;
>  	btrfs_sysfs_del_qgroups(fs_info);
>  }
>  
> @@ -1012,7 +997,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>  	struct btrfs_qgroup *qgroup = NULL;
>  	struct btrfs_qgroup *prealloc = NULL;
>  	struct btrfs_trans_handle *trans = NULL;
> -	struct ulist *ulist = NULL;
>  	const bool simple = (quota_ctl_args->cmd == BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA);
>  	int ret = 0;
>  	int slot;
> @@ -1035,12 +1019,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>  	if (fs_info->quota_root)
>  		goto out;
>  
> -	ulist = ulist_alloc(GFP_KERNEL);
> -	if (!ulist) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
>  	ret = btrfs_sysfs_add_qgroups(fs_info);
>  	if (ret < 0)
>  		goto out;
> @@ -1080,9 +1058,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>  	if (fs_info->quota_root)
>  		goto out;
>  
> -	fs_info->qgroup_ulist = ulist;
> -	ulist = NULL;
> -
>  	/*
>  	 * initially create the quota tree
>  	 */
> @@ -1281,17 +1256,13 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>  	if (ret)
>  		btrfs_put_root(quota_root);
>  out:
> -	if (ret) {
> -		ulist_free(fs_info->qgroup_ulist);
> -		fs_info->qgroup_ulist = NULL;
> +	if (ret)
>  		btrfs_sysfs_del_qgroups(fs_info);
> -	}
>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>  	if (ret && trans)
>  		btrfs_end_transaction(trans);
>  	else if (trans)
>  		ret = btrfs_end_transaction(trans);
> -	ulist_free(ulist);
>  	kfree(prealloc);
>  	return ret;
>  }
> -- 
> 2.47.2
> 

