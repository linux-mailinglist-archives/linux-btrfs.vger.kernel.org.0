Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22905AA5F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 04:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiIBCjJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 22:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiIBCjI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 22:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E274CDE
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 19:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662086346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CRLFCHY6wy/rOTY7aKDRzJA0JLqIR4loTOp3UDO00cU=;
        b=cuyrhPX5kvv2LO7yzdnBHtd1LOw0cRnRqNa3fbi/riNisS1jrzIZpKEV6GZj7TM0uYxSrx
        Am0If5HFFe/0GupMO1JFlh/2CwcbsWG13u+OYZ4qq9VQx4eQo//S9VPvPA1A/4/vkHXbam
        iTAiToNr8PuTEr7BahjbqR32CNdKsnc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-VD_AcTo5OtmuG-IElNT3zQ-1; Thu, 01 Sep 2022 22:39:04 -0400
X-MC-Unique: VD_AcTo5OtmuG-IElNT3zQ-1
Received: by mail-qt1-f198.google.com with SMTP id cm10-20020a05622a250a00b003437b745ccdso571525qtb.18
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 19:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CRLFCHY6wy/rOTY7aKDRzJA0JLqIR4loTOp3UDO00cU=;
        b=IFyt+M9GZGZNUX+sHz5RldzNy2FFDkPCBEK4ymphTkoTKJM7rI4HDRnQjARRCXLmvM
         Logv9iWT8Wp/kpuoVS1iFmoQ/ePihtGHEDzzXgnrgvygGNfqdppEmXqjw4Y2sJ5eg7TK
         DRPLxeQsNE2Ycpxkh0dBKtSs5LExcmG9+qlmrWHhIr7lWvTuO6xG8+uo/9QYFRvJRbpg
         PnkooEd5e31791+M/+DgC4VezNxG7fQpbuO2ZfFfN+ek5F6KDFfnkiJWqjm1xivi5bCY
         Q+2JoDdM5oNZ0lRiY9vo6Tc6QTpBF6xUwp66vTmuDyLql5JwIDOQGLCmqlSuxlyQWarR
         M25g==
X-Gm-Message-State: ACgBeo0HxwSnAT7XDHCG3DSR+ExHNM/vDe8wUSeh91aUIx4xlJ4D2zP0
        hzVesSSecnis6F0E2HmMokL7hXgXWJQMyPtBpHtnt552hcNC5BCT0nkGIeygy/CzEjpqhwBfvq0
        I3mWybj2xMJ+YvZp4OmV1sK4=
X-Received: by 2002:ad4:5b8f:0:b0:499:254a:726a with SMTP id 15-20020ad45b8f000000b00499254a726amr7724947qvp.117.1662086344417;
        Thu, 01 Sep 2022 19:39:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR78pghQA2UdlDfKKWq2VW6/I0/zNpYupernE2disdGQ6F6BXkioz3Xqb0948es6td9HHeyjyQ==
X-Received: by 2002:ad4:5b8f:0:b0:499:254a:726a with SMTP id 15-20020ad45b8f000000b00499254a726amr7724928qvp.117.1662086344017;
        Thu, 01 Sep 2022 19:39:04 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k22-20020ac84756000000b0033fc75c3469sm305884qtp.27.2022.09.01.19.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 19:39:03 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:38:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test fsync after punching hole adjacent to
 an existing hole
Message-ID: <20220902023857.mzyqmwx3tcihsqvl@zlang-mailbox>
References: <176a9103bc2a3fe5cc8d9306c3a7c50d5cdc1568.1662048436.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176a9103bc2a3fe5cc8d9306c3a7c50d5cdc1568.1662048436.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 05:10:09PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we punch a hole adjacent to an existing hole, fsync the file
> and then power fail, the new hole exists after mounting again the
> filesystem.
> 
> This currently fails on btrfs with kernels 5.18 and 5.19 when not using
> the "no-holes" feature. The "no-holes" feature is enabled by default at
> mkfs time starting with btrfs-progs 5.15, so to trigger the issue with
> btrfs-progs 5.15+ and kernel 5.18 or kernel 5.19, one must set
> "-O ^no-holes" in the MKFS_OPTIONS environment variable (part of the
> btrfs test matrix).
> 
> The issue is fixed for btrfs with the following kernel patch:
> 
>    "btrfs: update generation of hole file extent item when merging holes"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> v2: Added kernel commit tag (now that's merged in Linus' tree),
>     added auto group, added the new odd _require_congruent_file_oplen
>     requirement.

This version looks good to me, I don't have more review points.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/generic/695     | 91 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/695.out | 15 +++++++
>  2 files changed, 106 insertions(+)
>  create mode 100755 tests/generic/695
>  create mode 100644 tests/generic/695.out
> 
> diff --git a/tests/generic/695 b/tests/generic/695
> new file mode 100755
> index 00000000..b46e35cf
> --- /dev/null
> +++ b/tests/generic/695
> @@ -0,0 +1,91 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 695
> +#
> +# Test that if we punch a hole adjacent to an existing hole, fsync the file and
> +# then power fail, the new hole exists after mounting again the filesystem.
> +#
> +# This is motivated by a regression on btrfs, fixed by the commit mentioned
> +# below, when not using the no-holes feature (which is enabled by default since
> +# btrfs-progs 5.15).
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log punch
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +. ./common/punch
> +
> +_supported_fs generic
> +_fixed_by_kernel_commit e6e3dec6c3c288 \
> +        "btrfs: update generation of hole file extent item when merging holes"
> +_require_scratch
> +_require_dm_target flakey
> +_require_xfs_io_command "fpunch"
> +_require_xfs_io_command "fiemap"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# We punch 2M holes and require extent allocations to align to 2M in fiemap
> +# results.
> +_require_congruent_file_oplen $SCRATCH_MNT $((2 * 1024 * 1024))
> +
> +# Create our test file with the following layout:
> +#
> +# [0, 2M)    - hole
> +# [2M, 10M)  - extent
> +# [10M, 12M) - hole
> +$XFS_IO_PROG -f -c "truncate 12M" \
> +	     -c "pwrite -S 0xab 2M 8M" \
> +	     $SCRATCH_MNT/foobar | _filter_xfs_io
> +
> +# Persist everything, commit the filesystem's transaction.
> +sync
> +
> +# Now punch two holes in the file:
> +#
> +# 1) For the range [2M, 4M), which is adjacent to the existing hole in the range
> +#    [0, 2M);
> +# 2) For the range [8M, 10M), which is adjacent to the existing hole in the
> +#    range [10M, 12M).
> +#
> +# These operations start a new filesystem transaction.
> +# Then finally fsync the file.
> +$XFS_IO_PROG -c "fpunch 2M 2M" \
> +	     -c "fpunch 8M 2M" \
> +	     -c "fsync" $SCRATCH_MNT/foobar
> +
> +# Simulate a power failure and mount the filesystem to check that everything
> +# is in the same state as before the power failure.
> +_flakey_drop_and_remount
> +
> +# We expect the following file layout:
> +#
> +# [0, 4M)    - hole
> +# [4M, 8M)   - extent
> +# [8M, 12M)  - hole
> +echo "File layout after power failure:"
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar | _filter_fiemap
> +
> +# When reading the file we expect to get the range [4M, 8M) filled with bytes
> +# that have a value of 0xab and 0x00 for anything outside that range.
> +echo "File content after power failure:"
> +_hexdump $SCRATCH_MNT/foobar
> +
> +_unmount_flakey
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/695.out b/tests/generic/695.out
> new file mode 100644
> index 00000000..447ef5cf
> --- /dev/null
> +++ b/tests/generic/695.out
> @@ -0,0 +1,15 @@
> +QA output created by 695
> +wrote 8388608/8388608 bytes at offset 2097152
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File layout after power failure:
> +0: [0..8191]: hole
> +1: [8192..16383]: data
> +2: [16384..24575]: hole
> +File content after power failure:
> +000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
> +*
> +400000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
> +*
> +800000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
> +*
> +c00000
> -- 
> 2.35.1
> 

