Return-Path: <linux-btrfs+bounces-18290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D428C068BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 15:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D061F1A021B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCDB31DDBA;
	Fri, 24 Oct 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="h3gDAJCg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQWc6uZn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60E315D4E;
	Fri, 24 Oct 2025 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313307; cv=none; b=Wr9C4hetD2Py0RUsbht9TVEGcd06MEmIZYqGcKLnenGmvz5drjCagj7p/DYLZqhzXwCgt7jkGnlJ60C7eXj+zTR9Wnq86bIRqXWq6Fbzf+cGrhvuFt4adW5Pm6xX9jsBJ9SVyOQev7wjRfxYuK9WOU2jwW7d/8xY9LnrQQLPPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313307; c=relaxed/simple;
	bh=GjvlTSV4sSVedh4E/AqW1SJeZi+7VaSvsp24sZ49AeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBI91tQgLVuhg2me8UeA8OvCURyuzur4ynETddMYYxKcfWuT2nR7Sh1sdSs3UaORKEE8TZbETPWpp7qM7TK8Ewt+rhMwnZOxxv5GBvcpdGv9gNq6z4UY8Az528yUk5+PYuq/ZUJrZmrFobmU+iytPH6feFKLIgHWCWwV1sFD1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=h3gDAJCg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQWc6uZn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E7FF14001D0;
	Fri, 24 Oct 2025 09:41:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 24 Oct 2025 09:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761313304; x=1761399704; bh=GOBrcL9T6R
	g6ZlGsRLtG8PddbfaOKTeucMsDnUDVF1A=; b=h3gDAJCgj9MRaRPw1XrBbBZFc3
	Fz4agsP89TI5MA71c/QOxRAvBzZmpjFx5UXbRSluBUuhX4J1mdzVEQ3f5Qko9mEc
	gZDZXdCjufOOGLgFB61Zt3qg3leHjCdX7PE78liY56EOvw1LbPC3zq3SuAzcyWYs
	JYvqyAoy9QZdyKVAynFXYoAOeOQOKK9kDQMTIYfP0XroJW4R5ShSVbyjJvbPUtKm
	VMRLoNex2VXYBsD1134P5rw5CSSFawjamyI787QJEDGwPa+JyumrOnKYCE+Z62Tj
	bekdzygZHDcYyXFQ4N6qS5zgbMgrxLRo2fN24a09EoR28mg1IuIFiCqwO/fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761313304; x=1761399704; bh=GOBrcL9T6Rg6ZlGsRLtG8PddbfaOKTeucMs
	DnUDVF1A=; b=DQWc6uZn1Im0K1jltHJ/4SAH+ODV9nctOyoRhLf70Vgdo59ckKu
	SqTW2fGPkHmfnNySx8yGd+POBBocaEnmZG3qTKZnF0wyaWFjTpeuoC5kr0NjDF3V
	A7Ok0YaOmdZ0dXJmsfVJ9gZ9DuZ7wbmAeFx+qWqlxsm37XUxIx1EpL9hkleBfhrX
	CPiUhbLqvzbuP6XsHYac6DpsIBTXZAO3aq6/Odx7aZnZ8CxWkfwxv10bgswSXj1P
	/Zw7sKgtAzuxGw7oZBgCXJaPQ2rwEcVJ2bZbsn6qxJv23cfkKdBXSCtcovy5I+3F
	5V5wX5+0kn8lsVYuvM6sl5zgYRBNU52ZH8g==
X-ME-Sender: <xms:GIL7aICTpBTpNcHPHeBWMqp_uFe0KJ64spAwt_TOfmCMrBg7Za9hEg>
    <xme:GIL7aIXbt3mnHEk_XqxzgcP1Gq82xAePIBJTgyyH_7AKRHIkZvT-3YbCYSl2EoBqh
    5Z8JMic5qiDKzZ8X-lI-QsZTbgzLBCeumT4CE3oOh_fAaM7RbCF2CE>
X-ME-Received: <xmr:GIL7aGArX2T_bWfk5WqiTpQw261FEPPhBHShUCj_EiTRrdWCGkqiXmXY-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfshhtvghsth
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfughmrghnrghnrgessh
    hushgvrdgtohhm
X-ME-Proxy: <xmx:GIL7aL8FlMhoYuKQjFZ7KJIkkXasxCMXNc5DNBNvzKCsnYu24yBU8A>
    <xmx:GIL7aNEfL9oZNwIgCS1SVaU5HG6qu-2JbissKuzhToNtexAsAv8J6Q>
    <xmx:GIL7aJM4f-rm8btJVYBt7xCaHU93Gfb1BZBh9vk_e_j9AOR_RkV7jg>
    <xmx:GIL7aHe7lWnu-KDfgfB7dObA1TdQIPxHVppgvA4jw3Hh9fxhPSbVHw>
    <xmx:GIL7aPAinb7vy7XAMsgh8ph-yZlrkKXwygwHLZ199-QI9Cd3w-R3FPp0>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 09:41:43 -0400 (EDT)
Date: Fri, 24 Oct 2025 06:41:41 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test fsync of directory after renaming new
 symlink
Message-ID: <aPuCFeWGuxG4am51@devvm12410.ftw0.facebook.com>
References: <54585ed26988fb88be1eab8211aa383a5e7cbd19.1761306683.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54585ed26988fb88be1eab8211aa383a5e7cbd19.1761306683.git.fdmanana@suse.com>

On Fri, Oct 24, 2025 at 12:53:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we fsync a directory that has a new symlink, then rename the
> symlink and fsync again the directory, after a power failure the symlink
> exists with the new name and not the old one.
> 
> This is to exercise a bug in btrfs where we ended up not persisting the
> new name of the symlink. That is fixed by a kernel patch that has the
> following subject:
> 
>  "btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  tests/generic/779     | 60 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/779.out |  2 ++
>  2 files changed, 62 insertions(+)
>  create mode 100755 tests/generic/779
>  create mode 100644 tests/generic/779.out
> 
> diff --git a/tests/generic/779 b/tests/generic/779
> new file mode 100755
> index 00000000..40d1a86c
> --- /dev/null
> +++ b/tests/generic/779
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 779
> +#
> +# Test that if we fsync a directory that has a new symlink, then rename the
> +# symlink and fsync again the directory, after a power failure the symlink
> +# exists with the new name and not the old one.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_symlinks
> +_require_dm_target flakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our test dir and add a symlink inside it.
> +mkdir $SCRATCH_MNT/dir
> +ln -s foobar $SCRATCH_MNT/dir/old-slink
> +
> +# Fsync the test dir, should persist the symlink.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> +
> +# Rename the symlink and fsync the directory. It should persist the new symlink
> +# name.
> +mv $SCRATCH_MNT/dir/old-slink $SCRATCH_MNT/dir/new-slink
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# Check that the symlink exists with the new name and has the correct content.
> +[ -L $SCRATCH_MNT/dir/new-slink ] || echo "symlink dir/new-slink not found"
> +echo "symlink content: $(readlink $SCRATCH_MNT/dir/new-slink)"
> +
> +_unmount_flakey
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/779.out b/tests/generic/779.out
> new file mode 100644
> index 00000000..c595cd01
> --- /dev/null
> +++ b/tests/generic/779.out
> @@ -0,0 +1,2 @@
> +QA output created by 779
> +symlink content: foobar
> -- 
> 2.47.2
> 

