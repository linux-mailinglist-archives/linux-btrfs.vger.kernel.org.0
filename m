Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270D564E84A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLPIru (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 03:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiLPIrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 03:47:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE37101
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 00:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671180405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPPDZPIaNuKnRMsNmGfNSikM7u5rNWllbaXS/BA8xWc=;
        b=GFm/9k0CEJkCGezejRjY1PuFoY034SMCh19KBv1xEaS+hkqu67Tki+g9Hyyq9/w1gtfftn
        tQY2kbucqRhmjolUN39ygQG1p8ONsVVXruxueqM42VpD+j4bJsFtzRB1ndpF9i2/QOCT82
        bFOtlXlkraZLuUl7l09G82mwpqQV0JM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-bQsXs2bGMTyfHVmwjhYLUg-1; Fri, 16 Dec 2022 03:46:33 -0500
X-MC-Unique: bQsXs2bGMTyfHVmwjhYLUg-1
Received: by mail-pf1-f200.google.com with SMTP id k21-20020aa78215000000b00575ab46ca2cso1215347pfi.20
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 00:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPPDZPIaNuKnRMsNmGfNSikM7u5rNWllbaXS/BA8xWc=;
        b=LYsZTWwbGCy9NKHy+cby3mnJhFDrHNX7MowQCf5RhIXwQSKryN9LFO9b82E93+sORV
         gA13u8iHb1X6KN/v9otF0kMDBASqR3TJXvcAE2sORN4CpJdUR6TEw5dJ/ROBmvacITF8
         3VgVYp+5XtWAtVwfawpE8L+Xh9Bo78+dij7Mf0y6lHVDbajsdVboHIXqCYh0z/pNbLqL
         ZOOV90JilTqMJaPi0iDetq2BEPKVYhP8xPUT/KbyDTGONWl4FxGSp6UOotMJNLVhbeoY
         cEmEn9pjZ7y0VqWJEZpAVzDZozoTk3W+hRB268npfm1oHWWZnxNu5BisIkxykb62sV4C
         2ojw==
X-Gm-Message-State: ANoB5pnvw1eDUeQ6iJOyPk1/zNFbb6A6Q8/4vGBE9kmJcWOq9HY89FlH
        GTbBWeyPkKYM9pf6pxGWlMHinWMaiBVPxBJrmPzKQR9eLmGY/fG46jWET3JPOilcMl97kZ1HqPb
        XLkR3PHPS1cjIXh3+HltlOyc=
X-Received: by 2002:a17:902:f60f:b0:186:e378:91cf with SMTP id n15-20020a170902f60f00b00186e37891cfmr36917188plg.37.1671180392386;
        Fri, 16 Dec 2022 00:46:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5CotI8zkD8Wl/2bfnyakU3pj3sctEGpyyzGPPKmRFej9u29DYN5UaYcS3D/xO/bigL8jeCpQ==
X-Received: by 2002:a17:902:f60f:b0:186:e378:91cf with SMTP id n15-20020a170902f60f00b00186e37891cfmr36917174plg.37.1671180391994;
        Fri, 16 Dec 2022 00:46:31 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001837b19ebb8sm1010109pls.244.2022.12.16.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 00:46:31 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:46:27 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: new test for logical inode resolution panic
Message-ID: <20221216084627.ipg772ugfedo6mig@zlang-mailbox>
References: <98d2055515cd765b0835a7f751a21cbb72c03621.1671059406.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d2055515cd765b0835a7f751a21cbb72c03621.1671059406.git.boris@bur.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 14, 2022 at 03:12:01PM -0800, Boris Burkov wrote:
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

Hi,

Thanks for this new case.

Is this patch merged, does it has a commit id? BTW, please mark this
known issue by _fixed_by_kernel_commit in case source code.

> is applied to the kernel.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/btrfs/279     | 95 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/279.out |  2 +
>  2 files changed, 97 insertions(+)
>  create mode 100755 tests/btrfs/279
>  create mode 100644 tests/btrfs/279.out
> 
> diff --git a/tests/btrfs/279 b/tests/btrfs/279
> new file mode 100755
> index 00000000..ef77f84b
> --- /dev/null
> +++ b/tests/btrfs/279

btrfs/279 was just token last weekend, please help to rebase to the latest
fstests for-next branch, or change the 279 to a big enough number which won't
cause conflict (I'll give it a proper number when merge it).

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

Does this case really use helpers in above two included files?

> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +_require_xfs_io_command "falloc"

Add this case to prealloc or preallocrw group

> +_require_xfs_io_command "fsync"
> +_require_xfs_io_command "pwrite"
> +
> +dump_tree() {
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV

_require_btrfs_command inspect-internal dump-tree

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

We recommend calling _fail at here if _scratch_mkfs fails with a *specified*
option.

_scratch_mkfs "--nodesize 16k" >>$seqres.full || _fail "mkfs failed"

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

Not sure if you reall use this touch command as you've used "-f" option for
xfs_io.

> +$XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +ino=$(stat -c '%i' $f.evil)
> +logical=$(get_prealloc_offset $ino)
> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil

xfs_io commands can be combined in one line, to make the code looks clear (except
you hope the fd closed after each command done) E.g:

$XFS_IO_PROG -fc "falloc -k 0 1m" -c fsync $f.evil
ino=$(stat -c '%i' $f.evil)
logical=$(get_prealloc_offset $ino)
$XFS_IO_PROG -c "pwrite -q 0 23" -c fsync \
	     -c "pwrite -q 0 23" -c fsync \
	     $f.evil

> +sync
> +
> +# a bunch of inodes to stuff dir items in front of the extent items
> +for i in $(seq 122); do
> +	$XFS_IO_PROG -fc "pwrite -q 0 8192" $f.$i
> +done
> +sync
> +
> +btrfs inspect-internal logical-resolve $logical $SCRATCH_MNT | _filter_scratch
   ^^
   $BTRFS_UTIL_PROG

_require_btrfs_command inspect-internal logical-resolve

The .out file only has "Silence is golden", what's this _filter_scratch used for?

> +_scratch_unmount

Is the ending _scratch_unmount useful?

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
> -- 
> 2.38.1
> 

