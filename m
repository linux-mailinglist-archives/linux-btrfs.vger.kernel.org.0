Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE39507111
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353421AbiDSOzX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 10:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353516AbiDSOzU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 10:55:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1D03A73B;
        Tue, 19 Apr 2022 07:52:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A73C61450;
        Tue, 19 Apr 2022 14:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9075CC385A5;
        Tue, 19 Apr 2022 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650379956;
        bh=WJRTD9Q3V2rhTK7SmZ3hW9wVHe80yPaHk24EhUQsHqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tR5C/L8hdSAIPRuGJh4PRhcxDARDAFm6MkhfYRn1/VGHmbINMoggQdvwKfNS3bk8b
         K4m9reGsdfQczw+J96eY7djHDoHR00Cn+IRZcc/n3KAAxO2nWGF/FwPUXW/XDyQCJO
         mo06TuqGmTgSZosXraeMTyhcIsG2Cue1jp18wvlFga0i6+d7NoetNCDmXsmgFzhIQX
         944DZXD9Xp9xHGmYFNHqWpZJeYm/a2j/pBE5gBaJdFBzXqg5UNmO3aFVpL1u82wxeH
         f1uTxK6L/udZj5WSbsFfudE0yrShnYFPsi7NQKLJSqjzHKUe2LqV8mxrVsMbB0npL2
         Nw0YLhbEjjU9A==
Date:   Tue, 19 Apr 2022 15:52:33 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        nborisov@suse.com, dsterba@suse.com, shepjeng@gmail.com,
        kernel@cccheng.net
Subject: Re: [PATCH] fstests: btrfs: test setting compression via xattr on
 nodatacow files
Message-ID: <Yl7MsVxpaYWfIEZH@debian9.Home>
References: <20220418075430.484158-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418075430.484158-1-cccheng@synology.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 18, 2022 at 03:54:30PM +0800, Chung-Chiang Cheng wrote:
> Compression and nodatacow are mutually exclusive. Besides ioctl, there
> is another way to setting compression via xattrs, and shouldn't produce
> invalid combinations.

Hi Chung-Chiang,

Thanks for taking the time to write and submit the test.
Some inlined comments below.

> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  tests/btrfs/264     | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/264.out | 15 +++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100755 tests/btrfs/264
>  create mode 100644 tests/btrfs/264.out
> 
> diff --git a/tests/btrfs/264 b/tests/btrfs/264
> new file mode 100755
> index 000000000000..42bfcd4f93a0
> --- /dev/null
> +++ b/tests/btrfs/264
> @@ -0,0 +1,76 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 Synology Inc. All Rights Reserved.
> +#
> +# FS QA Test No. 264
> +#
> +# Compression and nodatacow are mutually exclusive. Besides ioctl, there
> +# is another way to setting compression via xattrs, and shouldn't produce
> +# invalid combinations.
> +#
> +# To prevent mix any compression-related options with nodatacow, FS_NOCOMP_FL
> +# is also rejected by ioctl as well as FS_COMPR_FL on nodatacow files. To
> +# align with it, no and none are also unacceptable in this test.
> +#
> +# The regression is fixed by a patch with the following subject:
> +#   btrfs: do not allow compression on nodatacow files
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress attr
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_chattr C
> +_require_chattr c

This require, for chattr c, is not needed, since the test never calls
chattr with +c or -c.

It also misses a call to:

_require_attrs

Due to the calls to setfattr and lsattr.

> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +#
> +# DATACOW
> +#
> +test_file="$SCRATCH_MNT/foo"
> +touch "$test_file"
> +$CHATTR_PROG -C "$test_file"
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +$SETFATTR_PROG -n "btrfs.compression" -v zlib "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v no   "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v lzo  "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v none "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v zstd "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +
> +#
> +# NODATACOW
> +#
> +test_file="$SCRATCH_MNT/bar"
> +touch "$test_file"
> +$CHATTR_PROG +C "$test_file"
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +# all valid compression type are not allowed on nodatacow files
> +$SETFATTR_PROG -n "btrfs.compression" -v zlib "$test_file" |& _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v lzo  "$test_file" |& _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v zstd "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +# no/none are also not allowed on nodatacow files
> +$SETFATTR_PROG -n "btrfs.compression" -v no   "$test_file" |& _filter_scratch
> +$SETFATTR_PROG -n "btrfs.compression" -v none "$test_file" |& _filter_scratch
> +$LSATTR_PROG -l "$test_file" | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/264.out b/tests/btrfs/264.out
> new file mode 100644
> index 000000000000..82c551411411
> --- /dev/null
> +++ b/tests/btrfs/264.out
> @@ -0,0 +1,15 @@
> +QA output created by 264
> +SCRATCH_MNT/foo ---
> +SCRATCH_MNT/foo Compression_Requested
> +SCRATCH_MNT/foo ---
> +SCRATCH_MNT/foo Compression_Requested
> +SCRATCH_MNT/foo ---
> +SCRATCH_MNT/foo Compression_Requested
> +SCRATCH_MNT/bar No_COW
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +SCRATCH_MNT/bar No_COW
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +setfattr: SCRATCH_MNT/bar: Invalid argument
> +SCRATCH_MNT/bar No_COW

This is all fine, and I appreciate that you had special care to make sure
the test works even if one runs the test with "-o compress" or "-o nodatacow"
set in MOUNT_OPTIONS.

However the test is based on some pre-5.14 kernel, presumably one of the
Synology forks, and because of that it fails even after applying the btrfs
fix on a recent kernel:

root 15:43:45 /home/fdmanana/git/hub/xfstests (master)> ./check btrfs/264
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian9 5.18.0-rc2-btrfs-next-115 #1 SMP PREEMPT_DYNAMIC Wed Apr 13 09:17:09 WEST 2022
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/264	- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/264.out.bad)
    --- tests/btrfs/264.out	2022-04-19 14:49:03.845696283 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/264.out.bad	2022-04-19 15:43:50.413816742 +0100
    @@ -1,9 +1,9 @@
     QA output created by 264
     SCRATCH_MNT/foo ---
     SCRATCH_MNT/foo Compression_Requested
    -SCRATCH_MNT/foo ---
    +SCRATCH_MNT/foo Dont_Compress
     SCRATCH_MNT/foo Compression_Requested
    -SCRATCH_MNT/foo ---
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/264.out /home/fdmanana/git/hub/xfstests/results//btrfs/264.out.bad'  to see the entire diff)
Ran: btrfs/264
Failures: btrfs/264
Failed 1 of 1 tests

root 15:43:50 /home/fdmanana/git/hub/xfstests (master)> diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/264.out /home/fdmanana/git/hub/xfstests/results//btrfs/264.out.bad
--- /home/fdmanana/git/hub/xfstests/tests/btrfs/264.out	2022-04-19 14:49:03.845696283 +0100
+++ /home/fdmanana/git/hub/xfstests/results//btrfs/264.out.bad	2022-04-19 15:43:50.413816742 +0100
@@ -1,9 +1,9 @@
 QA output created by 264
 SCRATCH_MNT/foo ---
 SCRATCH_MNT/foo Compression_Requested
-SCRATCH_MNT/foo ---
+SCRATCH_MNT/foo Dont_Compress
 SCRATCH_MNT/foo Compression_Requested
-SCRATCH_MNT/foo ---
+SCRATCH_MNT/foo Dont_Compress
 SCRATCH_MNT/foo Compression_Requested
 SCRATCH_MNT/bar No_COW
 setfattr: SCRATCH_MNT/bar: Invalid argument
root 15:43:52 /home/fdmanana/git/hub/xfstests (master)> 

The reason is that the test is expecting that setting "no" for the compression
property removes the compression flag only, but does not set the NOCOMPRESS flag.

After 5.14, setting 'no' or 'none' clears the COMPRESS bit and sets the NOCOMPRESS bit.
The change happened in this commit:

	commit 5548c8c6f55bf0097075b3720e14857e3272429f
	Author: David Sterba <dsterba@suse.com>
	Date:   Mon Jun 14 18:10:04 2021 +0200

	    btrfs: props: change how empty value is interpreted

So the test needs to be updated and tested on a recent kernel.
Other than that, it looks fine to me.

Thanks.




> -- 
> 2.34.1
> 
