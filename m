Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D972600D9B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJQLUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJQLT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EA418362;
        Mon, 17 Oct 2022 04:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7409E6104D;
        Mon, 17 Oct 2022 11:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D717CC433C1;
        Mon, 17 Oct 2022 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666005589;
        bh=ikSkEha/FQZ0eNL3TbH7Lqnd/uYHthS3ZEsg1r7q7I0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=niWxA40rhkeFi5rBEf8G8lvr/YtCZsJ1BYOoMTHGEV79VAI8rp1PVfdY14UwQhjzj
         DqwhC/qAs2rZAV5cqs75NzcHQghBWOGSLa6AWKSSwoyBYFIZ0o5PfNQmcqr7qBlZxa
         Z0Hz+ij5OrSjpHQ/oOT43vIe9zM3bcdEXC5BYMhqQMtmgh4R8kM+tdIGy8bKuyeUne
         iBK8dPlqAL+tkl+decUgKbPOoIm4X7cGXIWFcnRofe0DP4Yh83WYscfdeihsmZVmfq
         3uSdmK21bfgToXTKD/9EabCDO1vgzJwiCwsZAI+3MX5Gb68Dnfu0uWm0AMHf3Fe+Mp
         IZx4HYEzQ5zLA==
Received: by mail-oi1-f172.google.com with SMTP id n130so11706334oia.6;
        Mon, 17 Oct 2022 04:19:49 -0700 (PDT)
X-Gm-Message-State: ACrzQf2X1RjAMUrxry2jBnWcFYwFk8lQ5fayy3vq3L1Liz8XzHHzX5mn
        yA9edkEPN2+Zx3AiwatQq/byQrVDToHRqiUU50A=
X-Google-Smtp-Source: AMsMyM5IjV/iy0ALN9nDtU3rTLTq2VlLJIdcciu0XbgQgv94Kgbwv98EEtK+ZZkKRKm9H3HiuSGwzl4iERYlYmfbNKk=
X-Received: by 2002:a05:6808:1691:b0:351:48da:62e0 with SMTP id
 bb17-20020a056808169100b0035148da62e0mr4694056oib.98.1666005588934; Mon, 17
 Oct 2022 04:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221014164600.2626-1-bingjingc@synology.com>
In-Reply-To: <20221014164600.2626-1-bingjingc@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 17 Oct 2022 12:19:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6rOyeDf3pHBeDkq8VKgLQccwzo8KKu4-ybcp-Pb2DpJg@mail.gmail.com>
Message-ID: <CAL3q7H6rOyeDf3pHBeDkq8VKgLQccwzo8KKu4-ybcp-Pb2DpJg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: test incremental send for orphan inodes
To:     bingjingc <bingjingc@synology.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        bxxxjxxg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 14, 2022 at 5:46 PM bingjingc <bingjingc@synology.com> wrote:
>
> From: BingJing Chang <bingjingc@synology.com>
>
> Test that an incremental send operation can handle orphan files or
> directories in or not in the parent snapshot and the send snapshot.
>
> This issue is fixed by a kernel patch with the commit 9ed0a72e5b355d
> ("btrfs: send: fix failures when processing inodes with no links")
>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>
> ---
>  tests/btrfs/278     | 218 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/278.out |   3 +
>  2 files changed, 221 insertions(+)
>  create mode 100755 tests/btrfs/278
>  create mode 100644 tests/btrfs/278.out
>
> diff --git a/tests/btrfs/278 b/tests/btrfs/278
> new file mode 100755
> index 00000000..82da29e0
> --- /dev/null
> +++ b/tests/btrfs/278
> @@ -0,0 +1,218 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 BingJing Chang.
> +#
> +# FS QA Test No. btrfs/278
> +#
> +# Regression test for btrfs incremental send issue when processing inodes
> +# with no links
> +#
> +# This issue is fixed by the following linux kernel btrfs patch:
> +#
> +#   commit 9ed0a72e5b355d ("btrfs: send: fix failures when processing
> +#   inodes with no links")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_fixed_by_kernel_commit 9ed0a72e5b355d \
> +       "btrfs: send: fix failures when processing inodes with no links"
> +_require_test
> +_require_scratch
> +_require_btrfs_command "property"
> +_require_fssum
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
> +
> +# Creating the first snapshot looks like:
> +#
> +# .                                                                  (ino 256)
> +# |--- deleted.file                                                  (ino 257)
> +# |--- deleted.dir/                                                  (ino 258)
> +# |--- changed_subcase1.file                                         (ino 259)
> +# |--- changed_subcase2.file                                         (ino 260)
> +# |--- changed_subcase1.dir/                                         (ino 261)
> +# |    |---- foo                                                     (ino 262)
> +# |--- changed_subcase2.dir/                                         (ino 263)
> +# |    |---- foo                                                     (ino 264)
> +#
> +touch $SCRATCH_MNT/vol/deleted.file
> +mkdir $SCRATCH_MNT/vol/deleted.dir
> +touch $SCRATCH_MNT/vol/changed_subcase1.file
> +touch $SCRATCH_MNT/vol/changed_subcase2.file
> +mkdir $SCRATCH_MNT/vol/changed_subcase1.dir
> +touch $SCRATCH_MNT/vol/changed_subcase1.dir/foo
> +mkdir $SCRATCH_MNT/vol/changed_subcase2.dir
> +touch $SCRATCH_MNT/vol/changed_subcase2.dir/foo
> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
> +
> +# Delete the deleted.*, create a new file and a new directory, and then
> +# take the second snapshot looks like:
> +#
> +# .                                                                  (ino 256)
> +# |--- changed_subcase1.file                                         (ino 259)
> +# |--- changed_subcase2.file                                         (ino 260)
> +# |--- changed_subcase1.dir/                                         (ino 261)
> +# |    |---- foo                                                     (ino 262)
> +# |--- changed_subcase2.dir/                                         (ino 263)
> +# |    |---- foo                                                     (ino 264)
> +# |--- new.file                                                      (ino 265)
> +# |--- new.dir/                                                      (ino 266)
> +#
> +unlink $SCRATCH_MNT/vol/deleted.file
> +rmdir $SCRATCH_MNT/vol/deleted.dir
> +touch $SCRATCH_MNT/vol/new.file
> +mkdir $SCRATCH_MNT/vol/new.dir
> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
> +
> +# Set the subvolume back to read-write mode to make orphans of the first
> +# snapshot to look like:

This confused me. You mention setting the subvolume to RW, but what
happens is we are
setting the snapshot "snap1" to RW. So, something like:

"Set the snapshot "snap1" to read-write mode and turn several inodes
to orphans, so
that the snapshot will look like this:"

> +#
> +# .                                                                  (ino 256)
> +# |--- (orphan) deleted.file                                         (ino 257)
> +# |--- (orphan) deleted.dir/                                         (ino 258)
> +# |--- (orphan) changed_subcase1.file                                (ino 259)
> +# |--- changed_subcase2.file                                         (ino 260)
> +# |--- (orphan) changed_subcase1.dir/                                (ino 261)
> +# |--- changed_subcase2.dir/                                         (ino 263)
> +# |    |---- foo                                                     (ino 264)
> +#
> +# Note: To make an easy illustration, I just put a tag "(orphan)" in front of
> +# their original names to indicate that they're deleted, but their inodes can
> +# not be removed because of open file descriptors on them. Mention that orphan
> +# inodes don't have names(paths).
> +#
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap1 ro false
> +exec 71<$SCRATCH_MNT/snap1/deleted.file
> +exec 72<$SCRATCH_MNT/snap1/deleted.dir
> +exec 73<$SCRATCH_MNT/snap1/changed_subcase1.file
> +exec 74<$SCRATCH_MNT/snap1/changed_subcase1.dir
> +unlink $SCRATCH_MNT/snap1/deleted.file
> +rmdir $SCRATCH_MNT/snap1/deleted.dir
> +unlink $SCRATCH_MNT/snap1/changed_subcase1.file
> +unlink $SCRATCH_MNT/snap1/changed_subcase1.dir/foo
> +rmdir $SCRATCH_MNT/snap1/changed_subcase1.dir
> +
> +# Turn the subvolume back to read-only mode as snapshots

Same here, and the sentence also seems unfinished. So:

"Turn the snapshot "snap1" back to read-only mode."

> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap1 ro true
> +
> +# Set the subvolume back to read-write mode to make orphans of the second
> +# snapshot to look like:

Same here, it's the snapshot "snap2" and not the subvolume.

"Set the snapshot "snap2" to read-write mode and turn several inodes
to orphans, so
that the snapshot will look like this:"

> +#
> +# .                                                                  (ino 256)
> +# |--- (orphan) changed_subcase1.file                                (ino 259)
> +# |--- (orphan) changed_subcase2.file                                (ino 260)
> +# |--- (orphan) changed_subcase1.dir/                                (ino 261)
> +# |--- (orphan) changed_subcase2.dir/                                (ino 263)
> +# |--- (orphan) new.file                                             (ino 265)
> +# |--- (orphan) new.dir/                                             (ino 266)
> +#
> +# Note: Same notice as above. Mention that orphan inodes don't have
> +# names(paths).
> +#
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap2 ro false
> +exec 81<$SCRATCH_MNT/snap2/changed_subcase1.file
> +exec 82<$SCRATCH_MNT/snap2/changed_subcase1.dir
> +exec 83<$SCRATCH_MNT/snap2/changed_subcase2.file
> +exec 84<$SCRATCH_MNT/snap2/changed_subcase2.dir
> +exec 85<$SCRATCH_MNT/snap2/new.file
> +exec 86<$SCRATCH_MNT/snap2/new.dir
> +unlink $SCRATCH_MNT/snap2/changed_subcase1.file
> +unlink $SCRATCH_MNT/snap2/changed_subcase1.dir/foo
> +rmdir $SCRATCH_MNT/snap2/changed_subcase1.dir
> +unlink $SCRATCH_MNT/snap2/changed_subcase2.file
> +unlink $SCRATCH_MNT/snap2/changed_subcase2.dir/foo
> +rmdir $SCRATCH_MNT/snap2/changed_subcase2.dir
> +unlink $SCRATCH_MNT/snap2/new.file
> +rmdir $SCRATCH_MNT/snap2/new.dir
> +
> +# Turn the subvolume back to read-only mode as snapshots

Same here, it's snapshot "snap2" and not the subvolume.
The sentence also seems unfinished.

"Turn the snapshot "snap2" back to read-only mode."

> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap2 ro true
> +
> +# Test that a full send operation can handle orphans with no paths
> +_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
> +
> +# Test that an incremental send operation can handle orphans.
> +#
> +# Here're descriptions for the details:
> +#
> +# Case 1: new.file and new.dir (BTRFS_COMPARE_TREE_NEW)
> +#        |  send snapshot  | action
> +#  --------------------------------
> +#  nlink |        0        | ignore
> +#
> +# They're new inodes in the send snapshots, while they don't have paths.

snapshots -> snapshot

"They are new inodes in the send snapshot ("snap2"), but they don't
have paths because they have no links".

> +# Test that the send operation can ignore them in order not to generate
> +# the creation commands for them. Or it will fail in retrieving their
> +# current paths.

Mentioning the error would be useful:

 "... Or it will fail, with -ENOENT, when trying to generate paths for them."

Other than those minor things, it looks good to me.
Test passes on a patched kernel and fails on an unpatched kernel.

Thanks so much for doing this!

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +#
> +#
> +# Case 2: deleted.file and deleted.dir (BTRFS_COMPARE_TREE_DELETED)
> +#       | parent snapshot | action
> +# ----------------------------------
> +# nlink |        0        | as usual
> +#
> +# They're deleted in the parent snapshots but become orphans with no
> +# paths. Test that no deletion commands will be generated as usual.
> +# This case didn't fail before.
> +#
> +#
> +# Case 3: changed_*.file and changed_*.dir (BTRFS_COMPARE_TREE_CHANGED)
> +#           |       | parent snapshot | send snapshot | action
> +# -----------------------------------------------------------------------
> +# subcase 1 | nlink |        0        |       0       | ignore
> +# subcase 2 | nlink |       >0        |       0       | new_gen(deletion)
> +#
> +# In subcase 1, test that the send operation can ignore them without trying
> +# to generate any commands.
> +#
> +# In subcase 2, test that the send operation can generate an unlink command
> +# for that file and test that it can generate a rename command for the
> +# non-empty directory first and a rmdir command to remove it finally. Or
> +# the receive operation will fail with a wrong unlink on a non-empty
> +# directory.
> +#
> +_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
> +                    $SCRATCH_MNT/snap2
> +
> +$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
> +       -x $SCRATCH_MNT/snap2/snap1 $SCRATCH_MNT/snap2
> +
> +# Recreate the filesystem by receiving both send streams and verify we get
> +# the same content that the original filesystem had.
> +exec 71>&-
> +exec 72>&-
> +exec 73>&-
> +exec 74>&-
> +exec 81>&-
> +exec 82>&-
> +exec 83>&-
> +exec 84>&-
> +exec 85>&-
> +exec 86>&-
> +_scratch_unmount
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Add the first snapshot to the new filesystem by applying the first send
> +# stream.
> +_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
> +
> +# Test the incremental send stream
> +_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
> +
> +$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/snap2
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
> new file mode 100644
> index 00000000..82b93b4e
> --- /dev/null
> +++ b/tests/btrfs/278.out
> @@ -0,0 +1,3 @@
> +QA output created by 278
> +OK
> +OK
> --
> 2.37.1
>
