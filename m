Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45235F82CB
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Oct 2022 05:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJHD1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 23:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJHD1M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 23:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC721258
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 20:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665199630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqANhglfz2KN6UJ+jqEVr0yc6agxGBu3MLkK6ZrABYE=;
        b=R6kH+Qn/ahE0MvMMoOtB6w5fauZA132FtV0X2kyoWENo7mQu+mqONGP+wWbrXIwaFlKnzo
        C89+wFObB8qgu1QKmosjC9LMeAgoIGLCmxxomuGNYXtCzRKVMqljcS4KrKtX7DsLtqwUXR
        DKMnT5S0qc+rxB/aRRgxInXKyIy9IJc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-qHMslX18Pse4g8rXwZS_1A-1; Fri, 07 Oct 2022 23:27:07 -0400
X-MC-Unique: qHMslX18Pse4g8rXwZS_1A-1
Received: by mail-pg1-f200.google.com with SMTP id s68-20020a632c47000000b00434e0e75076so3779004pgs.7
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Oct 2022 20:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqANhglfz2KN6UJ+jqEVr0yc6agxGBu3MLkK6ZrABYE=;
        b=TA7WeszKjF3qskgW63vs0CGIONG4BgfoQV42UkbUkHf3wOiH379WNU99DOpOY7rtAm
         gqY9Mkple0bhaFEbjKZWn2wtj4dfSmATQy32ekrpblsoFaxoHOOeovFtRCO/+vxB7Rkl
         WdIdWGss9ZeHBrrKgIR49i+z1AHMBaze8hM/SNZZLkgvoqSul9TvKW1vykhOO9GKlo92
         4aVYAn258s4f914IMAjrPrjZbaUj33Tf+CM2HQaJ9juG6CQFfSV7oNpJi/eovLxz930w
         vf7g+msaCNFjkasPS5E7MSfDlZIDM2TqEJbra94zOCdYBucWb99hfm0uLtFF5zdP66bL
         Oy8w==
X-Gm-Message-State: ACrzQf2Y5YByJlmuQd9X411GERWedzw4mAMnXM1PsSWnEKAULmLzoqcW
        0gzmDdc3ZqkhHH0VOzeddS4ryUTuXRKjTCMrOUp6ZatA33ibWk3qjkgBCuHm/ncHOpKs6KPYYJ6
        QEcvwKPxzkS2KyC10g9iCpSw=
X-Received: by 2002:a17:902:d50f:b0:178:6505:fae3 with SMTP id b15-20020a170902d50f00b001786505fae3mr8308616plg.54.1665199626381;
        Fri, 07 Oct 2022 20:27:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ouHy9z2CxOFaMcP2pPWPxIUJpE33ptyQHGKMs81lbY3OfS+yqCUcTaBJzaVgZsyzPfMaj6g==
X-Received: by 2002:a17:902:d50f:b0:178:6505:fae3 with SMTP id b15-20020a170902d50f00b001786505fae3mr8308588plg.54.1665199626037;
        Fri, 07 Oct 2022 20:27:06 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0017e93c158d7sm2243931plh.214.2022.10.07.20.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 20:27:05 -0700 (PDT)
Date:   Sat, 8 Oct 2022 11:27:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/3] btrfs: test fiemap on large file with extents shared
 through a snapshot
Message-ID: <20221008032701.mzkgmvw5fdx5lguo@zlang-mailbox>
References: <cover.1665150613.git.fdmanana@suse.com>
 <e8be02ae6e5495a029e1345df8b66139042a3c72.1665150613.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8be02ae6e5495a029e1345df8b66139042a3c72.1665150613.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 07, 2022 at 02:53:34PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Verify that fiemap correctly reports the sharedness of extents for a file
> with a very large number of extents, spanning many b+tree leaves in the fs
> tree, and when the file's subvolume was snapshoted.
> 
> Currently this passes on all kernel releases and its purpose is to prevent
> and detect regressions in the future, as this actually happened during
> recent development on the btrfs' fiemap related code. With this test we
> now have better coverage for fiemap when a file is shared through a
> snapshot.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/276     | 124 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/276.out |  16 ++++++
>  2 files changed, 140 insertions(+)
>  create mode 100755 tests/btrfs/276
>  create mode 100644 tests/btrfs/276.out
> 
> diff --git a/tests/btrfs/276 b/tests/btrfs/276
> new file mode 100755
> index 00000000..c27e8383
> --- /dev/null
> +++ b/tests/btrfs/276
> @@ -0,0 +1,124 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 276
> +#
> +# Verify that fiemap correctly reports the sharedness of extents for a file with
> +# a very large number of extents, spanning many b+tree leaves in the fs tree,
> +# and when the file's subvolume was snapshoted.
> +#
> +. ./common/preamble
> +_begin_fstest auto snapshot compress
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_xfs_io_command "fiemap" "ranged"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +# We use compression because it's a very quick way to create a file with a very
> +# large number of extents (compression limits the maximum extent size to 128K)
> +# and while using very little disk space.
> +_scratch_mount -o compress
> +
> +fiemap_test_file()
> +{
> +	local offset=$1
> +	local len=$2
> +
> +	# Skip the first two lines of xfs_io's fiemap output (file path and
> +	# header describing the output columns).
> +	$XFS_IO_PROG -c "fiemap -v $offset $len" $SCRATCH_MNT/foo | tail -n +3
> +}
> +
> +# Count the number of shared extents for the whole test file or just for a given
> +# range.
> +count_shared_extents()
> +{
> +	local offset=$1
> +	local len=$2
> +
> +	# Column 5 (from xfs_io's "fiemap -v" command) is the flags (hex field).
> +	# 0x2000 is the value for the FIEMAP_EXTENT_SHARED flag.
> +	fiemap_test_file $offset $len | \
> +		$AWK_PROG --source 'BEGIN { cnt = 0 }' \
> +			  --source '{ if (and(strtonum($5), 0x2000)) cnt++ }' \
> +			  --source 'END { print cnt }'
> +}
> +
> +# Count the number of non shared extents for the whole test file or just for a
> +# given range.
> +count_not_shared_extents()
> +{
> +	local offset=$1
> +	local len=$2
> +
> +	# Column 5 (from xfs_io's "fiemap -v" command) is the flags (hex field).
> +	# 0x2000 is the value for the FIEMAP_EXTENT_SHARED flag.
> +	fiemap_test_file $offset $len | \
> +		$AWK_PROG --source 'BEGIN { cnt = 0 }' \
> +			  --source '{ if (!and(strtonum($5), 0x2000)) cnt++ }' \
> +			  --source 'END { print cnt }'
> +}
> +
> +# Create a 16G file as that results in 131072 extents, all with a size of 128K
> +# (due to compression), and a fs tree with a height of 3 (root node at level 2).
> +# We want to verify later that fiemap correctly reports the sharedness of each
> +# extent, even when it needs to switch from one leaf to the next one and from a
> +# node at level 1 to the next node at level 1.
> +#
> +$XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Sync to flush delalloc and commit the current transaction, so fiemap will see
> +# all extents in the fs tree and extent trees and not look at delalloc.
> +sync
> +
> +# All extents should be reported as non shared (131072 extents).
> +echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
> +
> +# Creating a snapshot.
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
> +
> +# We have a snapshot, so now all extents should be reported as shared.
> +echo "Number of shared extents in the whole file: $(count_shared_extents)"
> +
> +# Now COW two file ranges, of 1M each, in the snapshot's file.
> +# So 16 extents should become non-shared after this.
> +#
> +$XFS_IO_PROG -c "pwrite -b 1M 8M 1M" \
> +	     -c "pwrite -b 1M 12G 1M" \
> +	     $SCRATCH_MNT/snap/foo | _filter_xfs_io
> +
> +# Sync to flush delalloc and commit the current transaction, so fiemap will see
> +# all extents in the fs tree and extent trees and not look at delalloc.
> +sync
> +
> +# Now we should have 16 non-shared extents and 131056 (131072 - 16) shared
> +# extents.
> +echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
> +echo "Number of shared extents in the whole file: $(count_shared_extents)"
> +
> +# Check that the non-shared extents are indeed in the expected file ranges (each
> +# with 8 extents).
> +echo "Number of non-shared extents in range [8M, 9M): $(count_not_shared_extents 8M 1M)"
> +echo "Number of non-shared extents in range [12G, 12G + 1M): $(count_not_shared_extents 12G 1M)"
> +
> +# Now delete the snapshot.
> +$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap | _filter_scratch
> +
> +# We deleted the snapshot and committed the transaction used to delete it (-c),
> +# but all its extents (both metadata and data) are actually only deleted in the
> +# background, by the cleaner kthread. So remount, which wakes up the cleaner
> +# kthread, with a commit interval of 1 second and sleep for 1.1 seconds - after
> +# this we are guaranteed all extents of the snapshot were deleted.
> +_scratch_remount commit=1
> +sleep 1.1
> +
> +# Now all extents should be reported as not shared (131072 extents).
> +echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
> new file mode 100644
> index 00000000..3bf5a5e6
> --- /dev/null
> +++ b/tests/btrfs/276.out
> @@ -0,0 +1,16 @@
> +QA output created by 276
> +wrote 17179869184/17179869184 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Number of non-shared extents in the whole file: 131072
> +Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +Number of shared extents in the whole file: 131072
> +wrote 1048576/1048576 bytes at offset 8388608
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 12884901888
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Number of non-shared extents in the whole file: 16
> +Number of shared extents in the whole file: 131056
> +Number of non-shared extents in range [8M, 9M): 8
> +Number of non-shared extents in range [12G, 12G + 1M): 8
> +Delete subvolume (commit): 'SCRATCH_MNT/snap'
> +Number of non-shared extents in the whole file: 131072
> -- 
> 2.35.1
> 

