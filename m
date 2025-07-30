Return-Path: <linux-btrfs+bounces-15764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5542EB1677C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 22:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89650189C699
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089241DC9B3;
	Wed, 30 Jul 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="HFfCe6jE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RtwCuXI7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005579C0
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906608; cv=none; b=LuYLv4hUn7qcXQ7MK4/p9hgyqx3cceoANG90DjHAguo/MrbZG2/WOjK7gyq+1hg98iondVgf9Gd47vHSPz+Jsx8IwskVNOj/bqMJ6orv2b2A7KJf8sCEzEsgb6jsQ114SG3FrNMx8rvTaig2rBkIimVuxy8qxGULBoMfMUn82G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906608; c=relaxed/simple;
	bh=fS+Kv5ih24THff+dsrOosr+hGxLvmGsuoK1CFApe3D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCbwsFZvwlQYRGfMI1E/7aULQ6+xdQY9Ki+Hagw5FLBcWcQM2rm3PLMmpwf7TguRBRcSUMRPiI9dC0M0Y+Q9jmhc7ZqXs5mdPEHkPx9ZiYXeEOmGWXWARJUPv71PvXwnXapgSuu/iYOp/gUZPSg2R9v4XYnIqqT+rsShQ3DyblA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=HFfCe6jE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RtwCuXI7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2316214008B2;
	Wed, 30 Jul 2025 16:16:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 30 Jul 2025 16:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753906604; x=1753993004; bh=BYr84Q/bZm
	xQR50uy/6DrAcTPj+boww8/Qj1WCWWy6o=; b=HFfCe6jEmqzpb3YHCVPwKs6sBs
	uTUBxWuF1yCp9/Hpex21W6iRZxxDuDKEKNWGBsd6NJuHMnAy53j4YR6z3EVAyf+B
	069t5a8BxDzyDg2YVYDAaxzs/P8i6krtZUdOSxEP/DjoYBknzjflHg8HjgMoekve
	GgP5nFw4axEpxYIqYing6pAdL3KtsIjImtWGtm/AZrhl5V0O0tghQIQ3og+TMjeA
	zn06vhK8gamMY1lpgl7pXErbIRd62enjNHKj3Y4/z+28lzlCXHGk9U3WWur0jGOc
	qPXcejzMaqQx6L0BYH9zams9EmNKn9LJYofDDxrMzVX0zoJZNGBAMo3OtT+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753906604; x=1753993004; bh=BYr84Q/bZmxQR50uy/6DrAcTPj+boww8/Qj
	1WCWWy6o=; b=RtwCuXI76h6Xk5XRPVEU/Y1dUzc8OFBKK0M7KqsRWvvO047d0fR
	FcuRl2SspjViUKEV9TOs1fPYEeC0Iu02P+SnRAkMT1x3M3CTv7PvNAWtTOZiex6Q
	N+oEmoIkjrRQrBwE9mcjEUi3mMW4F3hLDWqVbjg5BwMcoMkJXlQh8oCi3Zp4AxfO
	TjbM53I4LZXeRJO11RoaOYmZgxgfcsWrp1VvLn7Kbr9oSziBPzx0AlyLW7/w4dQC
	YLfW+OY/yMaZcvRn6xDAm1GZh7r9aqYe0DD/UAcmDz/SaFcjWds1X/OiTp/mRk93
	TOCd9L1iU9sFzDv2UCn2xXDLnzdbMcQp20w==
X-ME-Sender: <xms:q32KaOu2LyJ8AeXMO7Fvee4_PyazG4AtYua417JDb_TXIiRwzfJeeA>
    <xme:q32KaDr6lAutec9-2oCO_EJZqM0aldA7TZOedGvizUPVbofy7-xr7k8_T9zIrPkPQ
    zPuYiyuo_umk8yfLss>
X-ME-Received: <xmr:q32KaLnvkOhUt9hA7YK6pnNG5kymiTo-2mCDm-Ep_zxJIox0wvPYuzBQeQyqpRvej6fha1Kb-l5A1SZUs-OJunn5usw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehudeiffdthedvfeetudeufeejjeevudeileelgfeutd
    euueetfeehhefhfeetudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhprhhothho
    nhhmrghilhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q32KaHzFaJP3Vq8C5GAjA62RRi4ybOdD9fptC1aMOuYJJgvsETL6vA>
    <xmx:q32KaDlp8RgEZsFBHydouZl_7VKa7hzLAw-01ijLqVqK16-NVy8VPw>
    <xmx:q32KaAe2c81RS_abZ7XvCEZ9wnro6bBSQ-g2MBIxWgxdO9DB_9Um_g>
    <xmx:q32KaJrCFAK4JgfdgC-Fc8G9LQGdEHVXy3cOOPxxBt_7KEmxMHpSZg>
    <xmx:rH2KaJyFd_z1BDSgtgaXEGjn9fYqwH5c4jv9wPZtM1W85eXbxbUikyfc>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 16:16:43 -0400 (EDT)
Date: Wed, 30 Jul 2025 13:17:52 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix log tree replay failure due to file with 0
 links and extents
Message-ID: <20250730201752.GA909565@zen.localdomain>
References: <5c89804b07e3681c3a9bc50bf1d63d9ce77d7020.1753902432.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c89804b07e3681c3a9bc50bf1d63d9ce77d7020.1753902432.git.fdmanana@suse.com>

On Wed, Jul 30, 2025 at 08:20:40PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we log a new inode (not persisted in a past transaction) that has 0
> links and extents, then log another inode with an higher inode number, we
> end up with failing to replay the log tree with -EINVAL. The steps for
> this are:
> 
> 1) create new file A
> 2) write some data to file A
> 3) open an fd on file A
> 4) unlink file A
> 5) fsync file A using the previously open fd
> 6) create file B (has higher inode number than file A)
> 7) fsync file B
> 8) power fail before current transaction commits
> 
> Now when attempting to mount the fs, the log replay will fail with
> -ENOENT at replay_one_extent() when attempting to replay the first
> extent of file A. The failure comes when trying to open the inode for
> file A in the subvolume tree, since it doesn't exist.
> 
> Before commit 5f61b961599a ("btrfs: fix inode lookup error handling
> during log replay"), the returned error was -EIO instead of -ENOENT,
> since we converted any errors when attempting to read an inode during
> log replay to -EIO.
> 
> The reason for this is that the log replay procedure fails to ignore
> the current inode when we are at the stage LOG_WALK_REPLAY_ALL, our
> current inode has 0 links and last inode we processed in the previous
> stage has a non 0 link count. In other words, the issue is that at
> replay_one_extent() we only update wc->ignore_cur_inode if the current
> replay stage is LOG_WALK_REPLAY_INODES.
> 
> Fix this by updating wc->ignore_cur_inode whenever we find an inode item
> regardless of the current replay stage. This is a simple solution and easy
> to backport, but later we can do other alternatives like avoid logging
> extents or inode items other than the inode item for inodes with a link
> count of 0.
> 
> The problem with the wc->ignore_cur_inode logic has been around since
> commit f2d72f42d5fa ("Btrfs: fix warning when replaying log after fsync
> of a tmpfile") but it only became frequent to hit since the more recent
> commit 5e85262e542d ("btrfs: fix fsync of files with no hard links not
> persisting deletion"), because we stopped skipping inodes with a link
> count of 0 when logging, while before the problem would only be triggered
> if trying to replay a log tree created with an older kernel which has a
> logged inode with 0 links.
> 
> A test case for fstests will be submitted soon.

Great catch and explanation.

While studying the ignore_cur_inode and stage logic a bit more carefully
I noticed that ignore_cur_inodes has a comment where it is defined in
struct walk_control that says it needs to be set only in the
LOG_WALK_REPLAY_INODES stage, which is no longer true.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Reported-by: Peter Jung <ptr1337@cachyos.org>
> Link: https://lore.kernel.org/linux-btrfs/fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org/
> Reported-by: burneddi <burneddi@protonmail.com>
> Link: https://lore.kernel.org/linux-btrfs/lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com/#t
> Reported-by: Russell Haley <yumpusamongus@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com/
> Fixes: f2d72f42d5fa ("Btrfs: fix warning when replaying log after fsync of a tmpfile")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tree-log.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 8c6d1eb84d0e..09ddb2ee4df4 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2602,23 +2602,30 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
>  
>  	nritems = btrfs_header_nritems(eb);
>  	for (i = 0; i < nritems; i++) {
> -		btrfs_item_key_to_cpu(eb, &key, i);
> +		struct btrfs_inode_item *inode_item;
>  
> -		/* inode keys are done during the first stage */
> -		if (key.type == BTRFS_INODE_ITEM_KEY &&
> -		    wc->stage == LOG_WALK_REPLAY_INODES) {
> -			struct btrfs_inode_item *inode_item;
> -			u32 mode;
> +		btrfs_item_key_to_cpu(eb, &key, i);
>  
> -			inode_item = btrfs_item_ptr(eb, i,
> -					    struct btrfs_inode_item);
> +		if (key.type == BTRFS_INODE_ITEM_KEY) {
> +			inode_item = btrfs_item_ptr(eb, i, struct btrfs_inode_item);
>  			/*
> -			 * If we have a tmpfile (O_TMPFILE) that got fsync'ed
> -			 * and never got linked before the fsync, skip it, as
> -			 * replaying it is pointless since it would be deleted
> -			 * later. We skip logging tmpfiles, but it's always
> -			 * possible we are replaying a log created with a kernel
> -			 * that used to log tmpfiles.
> +			 * An inode with no links is either:
> +			 *
> +			 * 1) A tmpfile (O_TMPFILE) that got fsync'ed and never
> +			 *    got linked before the fsync, skip it, as replaying
> +			 *    it is pointless since it would be deleted later.
> +			 *    We skip logging tmpfiles, but it's always possible
> +			 *    we are replaying a log created with a kernel that
> +			 *    used to log tmpfiles;
> +			 *
> +			 * 2) A non-tmpfile which got its last link deleted
> +			 *    while holding an open fd on it and later got
> +			 *    fsynced through that fd. We always log the
> +			 *    parent inodes when inode->last_unlink_trans is
> +			 *    set to the current transaction, so ignore all the
> +			 *    inode items for this inode. We will delete the
> +			 *    inode when processing the parent directory with
> +			 *    replay_dir_deletes().
>  			 */
>  			if (btrfs_inode_nlink(eb, inode_item) == 0) {
>  				wc->ignore_cur_inode = true;
> @@ -2626,6 +2633,13 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
>  			} else {
>  				wc->ignore_cur_inode = false;
>  			}
> +		}
> +
> +		/* Inode keys are done during the first stage. */
> +		if (key.type == BTRFS_INODE_ITEM_KEY &&
> +		    wc->stage == LOG_WALK_REPLAY_INODES) {
> +			u32 mode;
> +
>  			ret = replay_xattr_deletes(trans, root, log, path, key.objectid);
>  			if (ret)
>  				break;
> -- 
> 2.47.2
> 

