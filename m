Return-Path: <linux-btrfs+bounces-15116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1491AEE49F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A6A3A1BCD
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90B291C16;
	Mon, 30 Jun 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="EhEZGHvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9j0MEMd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D2153BF0
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301068; cv=none; b=mITaJMH2qcz8pvntulWrHohariXSR/rPf5zksvfqkpIBJFR+FgxmVyQUrXjqyGJZR1GY/cD0ig/fm5vtb46+ojJTanD8sS9pVuyUwmYfpKJZP3nMcG/xqxsKhySMP+dudjYFWkFVi9Vt+bnofksdideNfRp3Oi3tHntQ4UViFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301068; c=relaxed/simple;
	bh=Yt4hdq546QtE0h7/TmpYZGfExGS+UpbS0rjli6tkImk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLVkc9Px6UVgn3sF4ZCYft9rR/SJwJnnfB1N4LIroe0ATRoFzDBXMZ02/ss0eMSHHHzuvrrwevR4+ngedg4vAmtrsGPMkEu2VlhUgZbR4aUhZAVEjKuU14Yh4QljEhM+VFImKjGY1vzxaj+jbGuaoQAnmoqNGeHqpnw9Dczfj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=EhEZGHvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9j0MEMd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DFA8140025B;
	Mon, 30 Jun 2025 12:31:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 30 Jun 2025 12:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751301065; x=1751387465; bh=Ps35CaY1iY
	PpYRG95sdHmoi8qAPDnmd37AOKJaVQLAw=; b=EhEZGHvFPsX+LANyPpEfhbk2WV
	1KMHLlCIKTbqUkDiPDe9zSL/F7GRSxcSN+zOpqvNyNzT0ALRZvBN8z8PgGUioroO
	v3D0DlIH+Ami0pErxThkf4OSKyoxggzk3687hA+TOzrpSeUOscehby3sDj4xYcqy
	irjeAa/Z0op3BuYq+egPQu0++BSybQ/9ADmVmjGSDYTReRgQdXdaxHlV4rXYbhPV
	f8T++hmAqZMnlEW3/6Fi7LpQgadZ7wWuoARl/ZhPFk7KqLSTKiJQJNg9KeaaJUss
	Q9u+W8WatKQws9pTfIuiNuDIABnj/UXxqbmA60MXZlqqKp2X9CM3leJIrzYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751301065; x=1751387465; bh=Ps35CaY1iYPpYRG95sdHmoi8qAPDnmd37AO
	KJaVQLAw=; b=J9j0MEMdlyeWXwaKjVPtnpJKh0+jGJSuEYAgCf1yLp7e/R2QMxB
	pZrKtfKUK4Ra0D1G7qpvx8E18N4DufH36UpT8KkIHPgqzdq9qcjrJeP1+orzURgS
	vL6fAbgQBnkbDHIU6fqJYWT1VtWIOrBzMglszZzFOWXyrXRGvykVnQesW0vO+/oH
	/MQz5BsipqdDBgepG0idmv0oh6KGPFNwm1AXxx/27zK9e2VD26XkwYzTIIUrGX0w
	E+e3VCXPTiHEQoNtwCZjzRP/xqlePtloFctHECqjahwsx5oezt5tfGB3J5nxCoU5
	PeGjhKr3Qwu883Y8iUaiA2FudzWT/R8v5ew==
X-ME-Sender: <xms:yLtiaLORrmJfAhNFJ4m-ar93LbGljf8eiQYlMZVFZeeuPsdX_y-uZg>
    <xme:yLtiaF_3NK7E3n4DXNSv-IMem5iZV-LTq_siaHhwF_mxGfbP5yvzvRhDoSxO0hYyd
    cavZ5kgOadqZ608U-w>
X-ME-Received: <xmr:yLtiaKQFwSdda7DNiPKflIxgl74gqydmfMMbyxOlr9uMnGwF8oMhXha8r8zh9nZteoyfB6bcR8O0KoDTQzq7Plpv2RM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehtdfhvefghfdtvefghfelhffgueeugedtveduieehie
    ehteelgeehvdefgeefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yLtiaPsqVAh-7qxugyBQ0exUQ0Ocs4EOFeE_F9FzISUokboIDF10AA>
    <xmx:yLtiaDeTG7CoLBxgproX0GH3jDjYCzAJ1ewKjcFHJGmdc8kYg_Ck-A>
    <xmx:yLtiaL20m6vbSUrrc-90dxjoLRVd111OBFBH7T7vN3Cwg3ticUYn9A>
    <xmx:yLtiaP9Th-wz2o17rY9ESKWb0w1RPFtLX1Y9vM33e89GJVjTO79QkQ>
    <xmx:ybtiaKqo4VjmsRKOCcJqcfHtHhZFMUSfhvsOHJw0rxsDQx_rjI3L26HU>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 12:31:04 -0400 (EDT)
Date: Mon, 30 Jun 2025 09:32:42 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs: qgroup: fix race between quota disable and
 quota rescan ioctl
Message-ID: <20250630163242.GA61133@zen.localdomain>
References: <cover.1751288689.git.fdmanana@suse.com>
 <19f775a9f256c4a5146cc97b7f521464429c81bc.1751288689.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19f775a9f256c4a5146cc97b7f521464429c81bc.1751288689.git.fdmanana@suse.com>

On Mon, Jun 30, 2025 at 02:07:47PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's a race between a task disabling quotas and another running the
> rescan ioctl that can result in a use-after-free of qgroup records from
> the fs_info->qgroup_tree rbtree.
> 
> This happens as follows:
> 
> 1) Task A enters btrfs_ioctl_quota_rescan() -> btrfs_qgroup_rescan();
> 
> 2) Task B enters btrfs_quota_disable() and calls
>    btrfs_qgroup_wait_for_completion(), which does nothing because at that
>    point fs_info->qgroup_rescan_running is false (it wasn't set yet by
>    task A);
> 
> 3) Task B calls btrfs_free_qgroup_config() which starts freeing qgroups
>    from fs_info->qgroup_tree without taking the lock fs_info->qgroup_lock;
> 
> 4) Task A enters qgroup_rescan_zero_tracking() which starts iterating
>    the fs_info->qgroup_tree tree while holding fs_info->qgroup_lock,
>    but task B is freeing qgroup records from that tree without holding
>    the lock, resulting in a use-after-free.
> 
> Fix this by taking fs_info->qgroup_lock at btrfs_free_qgroup_config().
> Also at btrfs_qgroup_rescan() don't start the rescan worker if quotas
> were already disabled.
> 
> Reported-by: cen zhang <zzzccc427@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/qgroup.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index b83d9534adae..8fa874ef80b3 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -636,22 +636,30 @@ bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info)
>  
>  /*
>   * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
> - * first two are in single-threaded paths.And for the third one, we have set
> - * quota_root to be null with qgroup_lock held before, so it is safe to clean
> - * up the in-memory structures without qgroup_lock held.
> + * first two are in single-threaded paths.
>   */
>  void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
>  {
>  	struct rb_node *n;
>  	struct btrfs_qgroup *qgroup;
>  
> +	/*
> +	 * btrfs_quota_disable() can be called concurrently with
> +	 * btrfs_qgroup_rescan() -> qgroup_rescan_zero_tracking(), so take the
> +	 * lock.
> +	 */
> +	spin_lock(&fs_info->qgroup_lock);
>  	while ((n = rb_first(&fs_info->qgroup_tree))) {
>  		qgroup = rb_entry(n, struct btrfs_qgroup, node);
>  		rb_erase(n, &fs_info->qgroup_tree);
>  		__del_qgroup_rb(qgroup);
> +		spin_unlock(&fs_info->qgroup_lock);
>  		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
>  		kfree(qgroup);
> +		spin_lock(&fs_info->qgroup_lock);
>  	}
> +	spin_unlock(&fs_info->qgroup_lock);
> +
>  	/*
>  	 * We call btrfs_free_qgroup_config() when unmounting
>  	 * filesystem and disabling quota, so we set qgroup_ulist
> @@ -4036,12 +4044,16 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
>  	qgroup_rescan_zero_tracking(fs_info);
>  
>  	mutex_lock(&fs_info->qgroup_rescan_lock);
> -	fs_info->qgroup_rescan_running = true;
> -	btrfs_queue_work(fs_info->qgroup_rescan_workers,
> -			 &fs_info->qgroup_rescan_work);
> +	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {

could this be one of the helpers like !btrfs_qgroup_enabled() or maybe
even better !btrfs_qgroup_full_accounting()?

> +		fs_info->qgroup_rescan_running = true;
> +		btrfs_queue_work(fs_info->qgroup_rescan_workers,
> +				 &fs_info->qgroup_rescan_work);
> +	} else {
> +		ret = -ENOTCONN;
> +	}
>  	mutex_unlock(&fs_info->qgroup_rescan_lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
> -- 
> 2.47.2
> 

