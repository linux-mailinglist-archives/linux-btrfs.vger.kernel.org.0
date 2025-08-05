Return-Path: <linux-btrfs+bounces-15861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFF4B1BA7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 20:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D3B170514
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433329A32D;
	Tue,  5 Aug 2025 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="HZWauUQ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hR58F/5M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE0199939
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420053; cv=none; b=uMqo1mABDApP28VBS/cxddRSMai9qx9OIQnpoiVcXymUSPIFGc3hw6oIawFonexnVV3IRUnwLLpt46V60CIc4wFrrq67gHuztaIRyzP2YkEXtE6F0WrmKUBV/E2bcjbxZjH1X+qmcA86rVayONyHK1ckg9KaGAjUaJd5H8RvsX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420053; c=relaxed/simple;
	bh=z09TXL5YUVhf1k4WtwlzXUi+2TI4F98f4V8F/e2gluM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwbWYOnzbzITQIWmpjj/DqtvK8Xp1v53N90+BSX9xCWSbEfa8eWD0jT+Wx8GJvxJpJRO8qg3AR75e2q9pTviyvtIKzTRvV5622p6JhWulvdb6Qf/CUd1ZDSAHgDeleTK+mbK3zfn2Ef2UYEEd33UNSYWjiC2/ZQ6yPALO6UxbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=HZWauUQ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hR58F/5M; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DD1B1400059;
	Tue,  5 Aug 2025 14:54:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 14:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754420051; x=1754506451; bh=Mb4ychyOrY
	dF5X4PWHexFzDEShAQOqeUSbXlPTV0+SE=; b=HZWauUQ5fo/kCkHEiHMxmEUTOg
	uTRmfloWurMmoFrhp9v0DrXCWv4ebXrt5FLQGyIIXPzsSsAonYliNL7+UWL4ZC9U
	nCek4qsSIh+sVjPKPrortLz1Ut9pENNjAQNsmvREC9Ki5tkSGmgL4d72oxwXdOG3
	t2Hr84NazhH2SVYcypgBlQZGIqGcS7ZtRnNk3icXvfHzgMAlcY/GZaO3DkClaIzQ
	RywRVCkoO7TO4UQsy6jcbyyM5O0ulDMV2egK0KotQELZnCBWTqQW9I2HKF4e3oJt
	cldoJVByzCB2qBoqv1uWr1SWb2zyY3ByD8vFLw/Z+owIzd1rvijxE3EQKLZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754420051; x=1754506451; bh=Mb4ychyOrYdF5X4PWHexFzDEShAQOqeUSbX
	lPTV0+SE=; b=hR58F/5MP8fzfHEs9Ijq3ON2gIJIzOMVfQa42RBAqvFjixoWv54
	p+DiVf0HoeVrHRQZC7oA5QY9O5ev2jbLl42BBTPiM8cHmPGCadekyVCuEAterBv7
	49fVU++F98YYI2RhB+PsgGNLvcwDAj3OuRmykD5243K9LZnFq8yc/X7xvHnpMba8
	jAdBjtTTneJUVYA2V2TDF77YL+nZJWuJbbYhS2EDraJvHiCX4s0epQmntq6YAqL8
	kQsFCk0GZr1XTmfvkkk8DttDoZQYSq3P2Y+8J0Uv0LPbUQsVHVPHQ6ID1vDnZSoM
	W7BDh12pXmTTWmqCb2IlyoRZrB9YF9zz1Qw==
X-ME-Sender: <xms:U1OSaOzkNWh7dJgLumca6NRaTGwHbsCNeQUyWB8-gV_YSRiw0v_21A>
    <xme:U1OSaKd2d7B8lSTq3quHRCJ9GKbLj4QkVpGB8JrzU4A7rZK-RsM-dl4hGiHiVF42l
    UsDcP_4fn3wjeusGGk>
X-ME-Received: <xmr:U1OSaCLYRdPUwKaYp9iGRTzFxXAw64vA8fKefvLao5iZdO-sVicjGupFqCeS94nI4pbaPT2iBkb8ychF9oWcctfZFiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:U1OSaDEQClrFxxr5Bvws96JTZaHBS2jV2ZlU41oUldXR_nZ4-toSEA>
    <xmx:U1OSaErWmGmH0-r2YfpXE8io-K2QRJD4bSZgW7LqJ8u919n0_yq1zA>
    <xmx:U1OSaERsZtrDHq9ewJO7yuhP0c3ITviYUyiCxSwJXvtY4ZWoxFlcMQ>
    <xmx:U1OSaJMoY3vGjk9Ja9-4-lGCXl1sst-PXxX9zHMuvb4e0uUQRiAc3g>
    <xmx:U1OSaBVcdR71jC5uUH9FFEHnMt0pvV6nSQRxB1lkA8Q5oxCAbgEoJ42J>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 14:54:10 -0400 (EDT)
Date: Tue, 5 Aug 2025 11:55:09 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not set mtime/ctime to current time when
 unlinking for log replay
Message-ID: <20250805185509.GA4106638@zen.localdomain>
References: <eb58e42ddc016bff18f179b4ef4507d6fe37e73d.1754304373.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb58e42ddc016bff18f179b4ef4507d6fe37e73d.1754304373.git.fdmanana@suse.com>

On Mon, Aug 04, 2025 at 11:49:41AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we are doing an unlink for log replay, we are updating the directory's
> mtime and ctime to the current time, and this is incorrect since it should
> stay with the mtime and ctime that were set when the directory was logged.
> 
> This is the same as when adding a link to an inode during log replay (with
> btrfs_add_link()), where we want the mtime and ctime to be the values that
> were in place when the inode was logged.
> 
> This was found with generic/547 using LOAD_FACTOR=20 and TIME_FACTOR=20,
> where due to large log trees we have longer log replay times and fssum
> could detect a mismatch of the mtime and ctime of a directory.
> 
> Fix this by skipping the mtime and ctime update at __btrfs_unlink_inode()
> if we are in log replay context (just like btrfs_add_link()).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/inode.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fcbe3e791026..83e242bf42f3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4192,6 +4192,23 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static void update_time_after_link_or_unlink(struct btrfs_inode *dir)
> +{
> +	struct timespec64 now;
> +
> +	/*
> +	 * If we are replaying a log tree, we do not want to update the mtime
> +	 * and ctime of the parent directory with the current time, since the
> +	 * log replay procedure is responsible for setting them to their correct
> +	 * values (the ones it had when the fsync was done).
> +	 */
> +	if (test_bit(BTRFS_FS_LOG_RECOVERING, &dir->root->fs_info->flags))
> +		return;
> +
> +	now = inode_set_ctime_current(&dir->vfs_inode);
> +	inode_set_mtime_to_ts(&dir->vfs_inode, now);
> +}
> +
>  /*
>   * unlink helper that gets used here in inode.c and in the tree logging
>   * recovery code.  It remove a link in a directory with a given name, and
> @@ -4292,7 +4309,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>  	inode_inc_iversion(&inode->vfs_inode);
>  	inode_set_ctime_current(&inode->vfs_inode);
>  	inode_inc_iversion(&dir->vfs_inode);
> - 	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
> +	update_time_after_link_or_unlink(dir);
>  
>  	return btrfs_update_inode(trans, dir);
>  }
> @@ -6686,15 +6703,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
>  	btrfs_i_size_write(parent_inode, parent_inode->vfs_inode.i_size +
>  			   name->len * 2);
>  	inode_inc_iversion(&parent_inode->vfs_inode);
> -	/*
> -	 * If we are replaying a log tree, we do not want to update the mtime
> -	 * and ctime of the parent directory with the current time, since the
> -	 * log replay procedure is responsible for setting them to their correct
> -	 * values (the ones it had when the fsync was done).
> -	 */
> -	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &root->fs_info->flags))
> -		inode_set_mtime_to_ts(&parent_inode->vfs_inode,
> -				      inode_set_ctime_current(&parent_inode->vfs_inode));
> +	update_time_after_link_or_unlink(parent_inode);
>  
>  	ret = btrfs_update_inode(trans, parent_inode);
>  	if (ret)
> -- 
> 2.47.2
> 

