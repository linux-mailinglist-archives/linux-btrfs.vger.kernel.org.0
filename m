Return-Path: <linux-btrfs+bounces-2955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39B86D7DF
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 00:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB301F21913
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 23:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1F275814;
	Thu, 29 Feb 2024 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KS/+/uy9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOAp1roy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5A55E76;
	Thu, 29 Feb 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249493; cv=none; b=c5j8QGjvg3uP0WRmFifYTKg2rTcsPssT7t2DRS62bnRxD0c0RNcryShV5bCsiy3UjahFnaEfCHDyVoow8tWYo1/QpY/3NOMz6S0rD9i/bvTSPouTlFbzEHVyhvwfk2vZZwejUfstdRWk67PwUCWSpUs8SjxFC0ytCHi7FWsKiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249493; c=relaxed/simple;
	bh=HTzbY+8vxLKQQqFf7V17Hpy9/TsUTY4T2yxeLQj7sH0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwZtiBNS/WC3FDRqe6EXR/8g9ty39RrnFk9w2HKii9hg0X1RwYFLHCDBGkGzVXZdrHIdycmpfeseNQ19j3FtoC01afWrhuj4zVysUgb3bS0PqslxuRPk1bOaI2WiCrauxOIBWYJ4ebQKtEbJx3CFHexhblsLME2xv8bUsnD9y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KS/+/uy9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOAp1roy; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 643673200A91;
	Thu, 29 Feb 2024 18:31:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 29 Feb 2024 18:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709249488; x=1709335888; bh=yeqqb4gtfY
	X/6l8Ur5nv7zJk04vGMoYp8+PwYU6YTvg=; b=KS/+/uy9+TLubk2fVoAepM9abu
	uIgsXWYAd320sew0Z5lyeor+dqfVVVQq+05MTwDhKvI2Zr+IfyfMy7XkIlwK8B9r
	Iz/XSfFTZV8RvfyYZ+ek720bwFI7l0mFs/GIlRNnAwCfB7SJzEj9kDkU+OXV6ROj
	VBXHRIvchJ8UAzVfWK/K0U65UPRl9/XrSFL5esYSRVTRP+wLKauV72tE+iqlL6tn
	bvNJew5aYujnjimjuJwkVz5nNupwmsUccW3IwghBgKmCxu1G2ff566QmEDW09VUS
	vPcwU9B/lWHYL90nRp9i7WLUOzvoAupCaBZPmVl3cOkpgJIXPzsXrs+xa/4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709249488; x=1709335888; bh=yeqqb4gtfYX/6l8Ur5nv7zJk04vG
	MoYp8+PwYU6YTvg=; b=HOAp1royy9E5SVX4dvB+TZO2W/WIXwlyQCgYojQl2aBl
	s4oYnHcsu9Ys8JUtG1XfJjwlIhUjwFnTKYBmR/EMC60ZjUu57TgAMreD+iGUwmX/
	LuhBVGGVCWywjFozDTAThXUjGB3RQFxBe6YLGlwA5fxocxjIEZ5GBcGrLyNvluQd
	CXKrFiFR9iXBEJTn5QjjJqADIGHpD7jclAvHOVA0xNTHfwhQepuSdvVPvWFOnv4p
	3TiN17sZp/XBsYP1lJyQFdX+wS0Idm26NelO5CHeWnz9NWKz6Lm1hT9hypW4/oEJ
	K6uKJMMG/T6/xoJOINd7m7JqgCYn318soQnfy9ZFTA==
X-ME-Sender: <xms:0BPhZRoXzqvOCi8ZbwfArazim6714k3mEPnhKY6Azeg2Dx7uI45kXw>
    <xme:0BPhZTpOb2-kFeAvsFkvZe4XG4clIuuiyUr5I1oHo4x5QdJP9zhp8HXjPxYFLrHpc
    1tlZmDv683B7otELgU>
X-ME-Received: <xmr:0BPhZePChNN8l6iXWsvtuHb0nyLQ_-G4us07eOIiZRl73BWIXqd1PJ6uJdUUlmW6xevKXgdmyg4Nut1VWaVD5FqCOs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedtgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepheduveelkeeiteelveeiuefhudehtdeigfehkeeffe
    egledvueevgefgudeuveefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:0BPhZc5Yxh5yS-7Br8x5QSd1sc6gyey07njxqX0CCPp_gUjVSQuuXQ>
    <xmx:0BPhZQ6oaAwuB_zTokxxX6-hWJn4B_FW7ovWtOFanBonYoDxEzpy3w>
    <xmx:0BPhZUi-WuHnCYSQbzNuFEUypckXm4orozWasgo3b4JcCJzMWYvpdg>
    <xmx:0BPhZeRv1guj-RBMo8JAEVCPEIzDl49r_N21hUTdTf1RpC0k2Bjclw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 18:31:28 -0500 (EST)
Date: Thu, 29 Feb 2024 15:32:40 -0800
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test for shifting devt
Message-ID: <20240229233240.GA1799927@zen.localdomain>
References: <27bad2e06121a6cd5cb34146e37b8e2dc46dec0c.1709231457.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27bad2e06121a6cd5cb34146e37b8e2dc46dec0c.1709231457.git.boris@bur.io>

This is a pretty poor submission, I forgot to write a commit message and
there are some random obvious problems with the style of the test
itself. Please disregard until I resend.

Sorry for the spam!
Boris

On Thu, Feb 29, 2024 at 10:36:41AM -0800, Boris Burkov wrote:
> ---
>  common/config       |   1 +
>  common/rc           |   4 ++
>  tests/btrfs/303     | 127 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/303.out |   2 +
>  4 files changed, 134 insertions(+)
>  create mode 100755 tests/btrfs/303
>  create mode 100644 tests/btrfs/303.out
> 
> diff --git a/common/config b/common/config
> index a3b15b96f..43b517fda 100644
> --- a/common/config
> +++ b/common/config
> @@ -235,6 +235,7 @@ export BLKZONE_PROG="$(type -P blkzone)"
>  export GZIP_PROG="$(type -P gzip)"
>  export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
>  export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
> +export PARTED_PROG="$(type -P parted)"
>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/common/rc b/common/rc
> index 30c44dddd..8e009aca9 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5375,6 +5375,10 @@ _require_unshare() {
>  		_notrun "unshare $*: command not found, should be in util-linux"
>  }
>  
> +_require_parted() {
> +	$PARTED_PROG --list &>/dev/null || _notrun "parted: command not found"
> +}
> +
>  # Return a random file in a directory. A directory is *not* followed
>  # recursively.
>  _random_file() {
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> new file mode 100755
> index 000000000..dece3eacc
> --- /dev/null
> +++ b/tests/btrfs/303
> @@ -0,0 +1,127 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
> +#
> +# FS QA Test 303
> +#
> +# Test an edge case of multi device volume management in btrfs.
> +# If a device changes devt between mounts of a multi device fs, we can trick
> +# btrfs into mounting the same device twice fully (not as a bind mount). From
> +# there, it is trivial to induce corruption.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_test
> +_require_parted
> +
> +#BARE_MOUNT_PROG=$here/src/bare-mount
> +
> +_cleanup() {
> +	cd /
> +	umount $MNT
> +	umount $BIND
> +	losetup -d $DEV0
> +	losetup -d $DEV1
> +	losetup -d $DEV2
> +	rm $IMG0
> +	rm $IMG1
> +	rm $IMG2
> +}
> +
> +do_mkpart() {
> +	local dev=$1
> +	$PARTED_PROG $dev 'mkpart mypart 1M 100%' --script
> +}
> +
> +do_rmpart() {
> +	local dev=$1
> +	$PARTED_PROG $dev 'rm 1' --script
> +}
> +
> +# Prepare 3 loop devices on the test device
> +IMG0=$TEST_DIR/$$.img0
> +IMG1=$TEST_DIR/$$.img1
> +IMG2=$TEST_DIR/$$.img2
> +truncate -s 1G $IMG0
> +truncate -s 1G $IMG1
> +truncate -s 1G $IMG2
> +DEV0=$(losetup -f $IMG0 --show)
> +DEV1=$(losetup -f $IMG1 --show)
> +DEV2=$(losetup -f $IMG2 --show)
> +D0P1=$DEV0"p1"
> +D1P1=$DEV1"p1"
> +MNT=$TEST_DIR/mnt
> +BIND=$TEST_DIR/bind
> +
> +# Setup partition table with one partition on each device
> +$PARTED_PROG $DEV0 'mktable gpt' --script
> +$PARTED_PROG $DEV1 'mktable gpt' --script
> +do_mkpart $DEV0
> +do_mkpart $DEV1
> +
> +# mkfs with two devices to avoid clearing devices on close
> +# single raid to allow removing DEV2
> +$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 &>/dev/null
> +
> +# Cycle mount the two device fs to populate both devices into the
> +# stale device cache
> +mkdir -p $MNT
> +mount $D0P1 $MNT
> +umount $MNT
> +
> +# Swap the partition dev_ts. This leaves the dev_t in the cache out of date.
> +do_rmpart $DEV0
> +do_rmpart $DEV1
> +do_mkpart $DEV1
> +do_mkpart $DEV0
> +
> +# Mount with mismatched dev_t!
> +mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do dangerous stuff on raw mount point"
> +
> +# Remove extra device to bring temp-fsid back in the fray
> +$BTRFS_UTIL_PROG device remove $DEV2 $MNT
> +
> +# Create the should be bind mount
> +mkdir -p $BIND
> +mount $D0P1 $BIND
> +mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)
> +bind_show=$($BTRFS_UTIL_PROG filesystem show $BIND)
> +# If they're different, we are in trouble.
> +[ "$mount_show" = "$bind_show" ] || echo "$mount_show != $bind_show"
> +
> +# now prove it by corrupting it
> +for i in $(seq 20); do
> +	# TODO diff prog
> +	dd if=/dev/urandom of=$MNT/foo.$i bs=50M count=1 &>/dev/null
> +done
> +for i in $(seq 20); do
> +	# TODO diff prog
> +	dd if=/dev/urandom of=$BIND/foo.$i bs=50M count=1 &>/dev/null
> +done
> +sync
> +find $BIND -type f -delete
> +sync
> +$FSTRIM_PROG $BIND
> +sleep 5
> +echo 3 > /proc/sys/vm/drop_caches
> +$BTRFS_UTIL_PROG scrub start -B $MNT >>$seqres.full 2>&1
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> new file mode 100644
> index 000000000..d48808e60
> --- /dev/null
> +++ b/tests/btrfs/303.out
> @@ -0,0 +1,2 @@
> +QA output created by 303
> +Silence is golden
> -- 
> 2.43.0
> 

