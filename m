Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668BB58D266
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 05:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiHIDgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 23:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIDgC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 23:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01AB81D33C
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 20:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660016160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRpTzSCutRhSU7KrxI5EUYYsl3ijEUMNVGzdJ2ADq2k=;
        b=VHkx4nODCdL8Gy9pUHyPeFBqFCnhCIUmZkVW1VvBCCPcvMAF7smkyUTG9pMVOzTF/1UrN7
        ynblRNzCnL9cNlm8o+GHV2URCCgCWHjuY/r3HCQnQOFWo+kW90fYoS9Ky7NMFGuake8U6l
        OoZbYzDa7RLwovLEZWTDnn3DRRyw6OA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-w4eIppBtP6CJNEPVKDvuBA-1; Mon, 08 Aug 2022 23:35:58 -0400
X-MC-Unique: w4eIppBtP6CJNEPVKDvuBA-1
Received: by mail-qt1-f198.google.com with SMTP id bb40-20020a05622a1b2800b00342eb08cc48so5420165qtb.17
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 20:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tRpTzSCutRhSU7KrxI5EUYYsl3ijEUMNVGzdJ2ADq2k=;
        b=bmzvR1zOOemPDism/C7VXQkQVKLjeOWyIV4TDDYW/AZLNoqbw+ASlFppt9Js45MM/z
         0rpiD7MBOvqFT+Bbm91lzI0WLOkOAzMDOAzJHbafwFVhjLK0cu5lALicVJGLOWlLmLUc
         p68ySXWeiK8xUcH1AUo0x/+z3o4heCP2xZSP9QGQpFZHx/2HnHVuYkGt7zdsU7l+r9xB
         SHJrCJ5Wi5Frw0KO0QNVQrsbQn8c7PW1UfYxprbLOmnIgbP3xi0RK/8N5YlTM7f+dRhW
         nWWxsKUpOvy8M3bBSFSnFgz/ogAIJebs/EzhmTD5Ae0/ZxXgiRaOGyXfLluMgjRekWKV
         tShg==
X-Gm-Message-State: ACgBeo3gizCIWo00rLhvTYEBNm81UZamEYcKx8l1Dy02LNPvVmy+ll/Q
        Riasv2Qdwi2E0FC7wxrmq8+fUeRCBJqFEGZydV8eDR1hzlTmZDvRVudx8U710PYn6Z+ksUvCll4
        l9QdzjTqj3C4en2Dy6R4Dsas=
X-Received: by 2002:a05:622a:30a:b0:31e:fa39:2dd with SMTP id q10-20020a05622a030a00b0031efa3902ddmr18323746qtw.679.1660016158335;
        Mon, 08 Aug 2022 20:35:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6lMAJ7tS6WQTGe6/LKnZhG5yNZBSYxUa0l9SRjNn1H5Uc2p9iCqA3Yobgn/CUA5zgwtnPsEg==
X-Received: by 2002:a05:622a:30a:b0:31e:fa39:2dd with SMTP id q10-20020a05622a030a00b0031efa3902ddmr18323730qtw.679.1660016158010;
        Mon, 08 Aug 2022 20:35:58 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s11-20020a05622a1a8b00b0031d283f4c4dsm9843839qtc.60.2022.08.08.20.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 20:35:57 -0700 (PDT)
Date:   Tue, 9 Aug 2022 11:35:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        djwong@kernel.org
Subject: Re: [PATCH] generic: test fsync after punching hole adjacent to an
 existing hole
Message-ID: <20220809033551.ip3lq5kkhvabdppn@zlang-mailbox>
References: <83a74ba89e9e4ee1060b7dfa1f190d4b51691909.1659957268.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a74ba89e9e4ee1060b7dfa1f190d4b51691909.1659957268.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 08, 2022 at 12:18:58PM +0100, fdmanana@kernel.org wrote:
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
>   "btrfs: update generation of hole file extent item when merging holes"

CC btrfs list

> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/694     | 85 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/694.out | 15 ++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100755 tests/generic/694
>  create mode 100644 tests/generic/694.out
> 
> diff --git a/tests/generic/694 b/tests/generic/694
> new file mode 100755
> index 00000000..c034f914
> --- /dev/null
> +++ b/tests/generic/694
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 694
> +#
> +# Test that if we punch a hole adjacent to an existing hole, fsync the file and
> +# then power fail, the new hole exists after mounting again the filesystem.

Better to explain this's a known regression test at here.

And add _fixed_by_kernel_commit later, after that kernel patch is merged and
has a fixed commit id.

> +#
> +. ./common/preamble
> +_begin_fstest quick log punch

"auto" group?

> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/dmflakey
> +. ./common/punch
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
   ^^^^
This's just a reminder, please remove it.

> +_supported_fs generic
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

Darrick added a new helper _require_congruent_file_oplen(), might worth
using it. Any thoughts?

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
> +od -A d -t x1 $SCRATCH_MNT/foobar

Can _hexdump in common/rc help ?

> +
> +_unmount_flakey
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/694.out b/tests/generic/694.out
> new file mode 100644
> index 00000000..f55212f3
> --- /dev/null
> +++ b/tests/generic/694.out
> @@ -0,0 +1,15 @@
> +QA output created by 694
> +wrote 8388608/8388608 bytes at offset 2097152
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File layout after power failure:
> +0: [0..8191]: hole
> +1: [8192..16383]: data
> +2: [16384..24575]: hole
> +File content after power failure:
> +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +*
> +4194304 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +8388608 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +*
> +12582912
> -- 
> 2.35.1
> 

