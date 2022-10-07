Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AED5F73C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 06:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJGE7Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 00:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJGE7W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 00:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ACA112AAB
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 21:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665118759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlqmDztLmgZt8YeXBvrPBMeuvFB6cf0PgJTdrIYKJ2U=;
        b=GUN7SzPDxQmjaE1dS5AN/kbCPxLgd/MLvfEhbtvmN8uOAJK3JIqUI2JG0uB2ahXU5OIj3a
        cGVTl8WG6yzWZR53bVFReUyujwfwVVg+/OB0UTGP49Lb6TuPvxoyH1OQnJb57gWuXfQCJR
        cs2Xt06OvW1c1aLr3cZ3U7y97381AA8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-tFwsdA_3OEupGEhtFcXZQA-1; Fri, 07 Oct 2022 00:59:18 -0400
X-MC-Unique: tFwsdA_3OEupGEhtFcXZQA-1
Received: by mail-qv1-f72.google.com with SMTP id kr13-20020a0562142b8d00b004b1d5953a2cso2356959qvb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Oct 2022 21:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qlqmDztLmgZt8YeXBvrPBMeuvFB6cf0PgJTdrIYKJ2U=;
        b=6gpJo1t/l0gEf2TFQV3D9NqLp5luKIitD1t6KhWtx+nH7Dekw5qHvBeQEk3IEvn6aH
         3rspSj0G9734FQrxlNWie633s/iQxCp4wxzI4TOmiX3sPWd45tQ413rGjIU3aXYlw47r
         dmnGode1mKxiTl1KptGj87n9jKlRe/5/X3mOCpsvI23mZhbMGayIYd+HisL+wWMnNX/G
         /0w53th+rHLMpl4uDbOvmBSrEZhctAiLwZXdzmvXs6eXA5+iv8fYPl4dKP11AxTo9sUZ
         kaABcKuWXYdd9N+NMFqMaWPrZSZ4pWAWv94ufB2lT5nZERN0ozJ0Upb8dtnKjdhWI+6C
         kPpA==
X-Gm-Message-State: ACrzQf3q8clP9p1TvFembpsOp29KQzQ5uwLDO7xsix1NsHJmvEbHLZVJ
        plq8VZbpkGG54ayQHgN92Q/5tWsrkju7GKfjfsKLATBvl8RxR1gC4/BNdFNgKnoxHTZsy4yjXfb
        NdzLO2oA1eEnsHMMzq6x8nP4=
X-Received: by 2002:a05:622a:134a:b0:35b:b5fa:5e12 with SMTP id w10-20020a05622a134a00b0035bb5fa5e12mr3028788qtk.48.1665118758024;
        Thu, 06 Oct 2022 21:59:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Wpt9cKpWbyai2O6SzI9n/J9ZYZklr04JGFw1pSKTB9iJUqPyHkq1iq5ND+PZAEsJZLXfubQ==
X-Received: by 2002:a05:622a:134a:b0:35b:b5fa:5e12 with SMTP id w10-20020a05622a134a00b0035bb5fa5e12mr3028778qtk.48.1665118757679;
        Thu, 06 Oct 2022 21:59:17 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a269800b006b5cc25535fsm1026996qkp.99.2022.10.06.21.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 21:59:17 -0700 (PDT)
Date:   Fri, 7 Oct 2022 12:59:12 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test fiemap on large file with extents shared
 through a snapshot
Message-ID: <20221007045912.5ieeylkcxweiaurx@zlang-mailbox>
References: <d4bf2bc47e3be1437d5693a0b728e199acb549fd.1664808949.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4bf2bc47e3be1437d5693a0b728e199acb549fd.1664808949.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 03, 2022 at 03:58:17PM +0100, fdmanana@kernel.org wrote:
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
>  doc/group-names.txt |   1 +
>  tests/btrfs/276     | 123 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/276.out |  16 ++++++
>  3 files changed, 140 insertions(+)
>  create mode 100755 tests/btrfs/276
>  create mode 100644 tests/btrfs/276.out
> 
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index ef411b5e..6cc9af78 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -47,6 +47,7 @@ eio			IO error reporting
>  encrypt			encrypted file contents
>  enospc			ENOSPC error reporting
>  exportfs		file handles
> +fiemap			fiemap ioctl

Hi,

There're many fiemap related cases, if we'd like to bring in this new group,
I hope we can use a separated patch to do this job completely, include adding
this group name to all related cases. We can talk about it in another patch,
this patch can force on its testing.

Thanks,
Zorro

>  filestreams		XFS filestreams allocator
>  freeze			filesystem freeze tests
>  fsck			general fsck tests
> diff --git a/tests/btrfs/276 b/tests/btrfs/276
> new file mode 100755
> index 00000000..5946dad9
> --- /dev/null
> +++ b/tests/btrfs/276
> @@ -0,0 +1,123 @@
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
> +_begin_fstest auto snapshot compress fiemap
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
> +echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
> +
> +# Creating a snapshot.
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
> +
> +# We have a snapshot, so now all extents should be reported as shared.
> +echo "Number of shared extents in the whole file: $(count_shared_extents)"
> +
> +# Now COW two files ranges, of 1M each, in the snapshot's file.
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

