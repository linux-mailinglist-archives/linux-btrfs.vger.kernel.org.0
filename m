Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9563064DDD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Dec 2022 16:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiLOPcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 10:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLOPcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 10:32:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E827B22;
        Thu, 15 Dec 2022 07:32:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 259F75BEB1;
        Thu, 15 Dec 2022 15:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671118360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D4W44t3UjZK0uOHiinw56j5KBmLIjjc+Nk0//prNb8k=;
        b=xvXKAYDcmJNvq6qfHHkEY1KubH7YCHcTMrvvfY0Fwi0wXB4v+4YRFA6uYY6pPmeMIOU5/Q
        4SOaKSwkoaF0qwX5WzFPhYQZpICc5SQH/n1mDVeglYOLfNv6J8i89acFHIZ69Y8TvM3hFz
        BjfJnhO0Vv5auDNv+rgZQaUEXBWcGjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671118360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D4W44t3UjZK0uOHiinw56j5KBmLIjjc+Nk0//prNb8k=;
        b=r3gcd4wB5jQ8x0ady+Hyjw2RCBGEAnqHeXZeWbSZU3lFB7+I5o3NgYw9QhMQDaWUkZQE+f
        lrN4j1VO3VHc8HDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F140E13434;
        Thu, 15 Dec 2022 15:32:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nDtoORc+m2PwBAAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 15 Dec 2022 15:32:39 +0000
Date:   Thu, 15 Dec 2022 16:33:30 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: new test for logical inode resolution panic
Message-ID: <20221215163330.7ad6ae27@echidna.fritz.box>
In-Reply-To: <98d2055515cd765b0835a7f751a21cbb72c03621.1671059406.git.boris@bur.io>
References: <98d2055515cd765b0835a7f751a21cbb72c03621.1671059406.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Boris,

Thanks for providing this reproducer...

On Wed, 14 Dec 2022 15:12:01 -0800, Boris Burkov wrote:

> If we create a file that has an inline extent followed by a prealloc
> extent, then attempt to use the logical to inode ioctl on the prealloc
> extent, but in the overwritten range, backref resolution will process
> the inline extent. Depending on the leaf eb layout, this can panic.
> Add a new test for this condition. In the long run, we can add spew when
> we read out-of-bounds fields of inline extent items and simplify this
> test to look for dmesg warnings rather than trying to force a fairly
> fragile panic (dependent on non-standardized details of leaf layout).
> 
> The test causes a kernel panic unless:
> btrfs: fix logical_ino ioctl panic
> is applied to the kernel.

This could be included as a test hint via _fixed_by_kernel_commit(), but
given that failure is a panic, it probably doesn't matter...

> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/btrfs/279     | 95 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/279.out |  2 +

Looks like a rebase is needed - btrfs/279 is already taken.

>  2 files changed, 97 insertions(+)
>  create mode 100755 tests/btrfs/279
>  create mode 100644 tests/btrfs/279.out
> 
> diff --git a/tests/btrfs/279 b/tests/btrfs/279
> new file mode 100755
> index 00000000..ef77f84b
> --- /dev/null
> +++ b/tests/btrfs/279
> @@ -0,0 +1,95 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 279
> +#
> +# Given a file with extents:
> +# [0 : 4096) (inline)
> +# [4096 : N] (prealloc)
> +# if a user uses the ioctl BTRFS_IOC_LOGICAL_INO[_V2] asking for the file of the
> +# non-inline extent, it results in reading the offset field of the inline
> +# extent, which is meaningless (it is full of user data..). If we are
> +# particularly lucky, it can be past the end of the extent buffer, resulting in
> +# a crash.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/dmlogwrites
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "fsync"
> +_require_xfs_io_command "pwrite"
> +
> +dump_tree() {
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV
> +}
> +
> +get_extent_data() {
> +	local ino=$1
> +	dump_tree $SCRATCH_DEV | grep -A4 "($ino EXTENT_DATA "
> +}
> +
> +get_prealloc_offset() {
> +	local ino=$1
> +	get_extent_data $ino | grep "disk byte" | awk '{print $5}'
> +}
> +
> +# This test needs to create conditions s.t. the special inode's inline extent
> +# is the first item in a leaf. Therefore, fix a leaf size and add 
> +# items that are otherwise not necessary to reproduce the inline-prealloc
> +# condition to get to such a state.
> +#
> +# Roughly, the idea for getting the right item fill is to:
> +# 1. create an extra file with a variable sized inline extent item
> +# 2. create our evil file that will cause the panic
> +# 3. create a whole bunch of files to create a bunch of dir/index items
> +# 4. size the variable extent item s.t. the evil extent item is item 0 in the
> +#    next leaf
> +#
> +# We do it in this somewhat convoluted way because the dir and index items all
> +# come before any inode, inode_ref, or extent_data items. So we can predictably
> +# create a bunch of them, then sneak in a funny sized extent to round out the
> +# difference.
> +
> +_scratch_mkfs "--nodesize 16k" >/dev/null
> +_scratch_mount
> +
> +f=$SCRATCH_MNT/f
> +
> +# the variable extra "leaf padding" file
> +$XFS_IO_PROG -fc "pwrite -q 0 700" $f.pad
> +
> +# the evil file with an inline extent followed by a prealloc extent
> +# created by falloc with keep-size, then two non-truncating writes to the front
> +touch $f.evil
> +$XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +ino=$(stat -c '%i' $f.evil)
> +logical=$(get_prealloc_offset $ino)
> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +sync
> +
> +# a bunch of inodes to stuff dir items in front of the extent items
> +for i in $(seq 122); do

nit: a c-style bash loop would avoid the extra seq process

> +	$XFS_IO_PROG -fc "pwrite -q 0 8192" $f.$i
> +done
> +sync
> +
> +btrfs inspect-internal logical-resolve $logical $SCRATCH_MNT | _filter_scratch
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/279.out b/tests/btrfs/279.out
> new file mode 100644
> index 00000000..c5906093
> --- /dev/null
> +++ b/tests/btrfs/279.out
> @@ -0,0 +1,2 @@
> +QA output created by 279
> +Silence is golden

With the rebase to avoid tests/btrfs/279 collision, this looks good:

Reviewed-by: David Disseldorp <ddiss@suse.de>
