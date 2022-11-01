Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6218614429
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 06:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKAFXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 01:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAFXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 01:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF51165B8
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667280134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VG6ijif+/S920VObUBglHfPEbxM5EjXOWbtoaK7H22U=;
        b=dK3njY0slL3aarsr1b75k2L7LfjzRFfX4eoXIYv7AXeQurzB9809hwfl5MM4CvXfLBnadl
        Sd01M6hxQMkJeqy/WcyAdvbbEKIZLOYpc2R8SqeQYApAK6yugDYveScqmZMfDkqvqDAixK
        z2BOSX5b2UY0DK7Tgu3j2hfRdGt9xBA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-BSTs5UBlMfKIzaiABsraJg-1; Tue, 01 Nov 2022 01:22:13 -0400
X-MC-Unique: BSTs5UBlMfKIzaiABsraJg-1
Received: by mail-pl1-f199.google.com with SMTP id p13-20020a170902e74d00b00187203317d5so3151769plf.17
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 22:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG6ijif+/S920VObUBglHfPEbxM5EjXOWbtoaK7H22U=;
        b=5QBw50FjBtWv4alnOR/9yUvVw4JGRxBTQyyF8ETm+veFPE/5H3yfkKGEOaMiry1xU5
         RMOq9Tz5I541GbUhjZmDnmECY5szvuLCj5METEBqWVaTW/+WeCMUUEIRJrcSuqt2OCJ5
         3/SiLuRAv4Nr88o2Umk4HfxkD+1CN93/Cod0/ZjaAXcAKmvj2nNXc/VkGKl0hVucfu/E
         DxfJZcnxbohL+tQyORjXlrlHVZ6P15XlAnddGovmhwv1zkMn9Mrkvg9I4wLr2HZFiVG7
         zcKAVyuWfv3nNkCD2f+MjBaiDDLRxCg560yYheTGZa5VTuwBrlAgE49rkXuFK90iFJxC
         oVdg==
X-Gm-Message-State: ACrzQf01zZ5fqgK4IKY2CtriUdyEk6La4xwDO5oTcESVszqiHuVCNlcv
        S4Cw+YDBvz25wheGzkCQ0PEcSvEGPg1GYfgB0AbmsvX8RllAuU8Z1hRgauM0qigyO6EXKfkvnCY
        7RFcXbKk8K7uaWWS1JZ7KRE8=
X-Received: by 2002:a17:903:2489:b0:187:3a59:570a with SMTP id p9-20020a170903248900b001873a59570amr694122plw.35.1667280130560;
        Mon, 31 Oct 2022 22:22:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68wJKSryy9/8JQ05+UgJGVRSK/EoZ5IUs+i+3bDqmtYnqFaNYVrBloxtYVQpX7tcT86WGWMA==
X-Received: by 2002:a17:903:2489:b0:187:3a59:570a with SMTP id p9-20020a170903248900b001873a59570amr694101plw.35.1667280130207;
        Mon, 31 Oct 2022 22:22:10 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78f27000000b0056bb36c047asm5537976pfr.105.2022.10.31.22.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:22:09 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:22:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 3/3] btrfs: test fiemap reports extent as not shared
 after COWing it in snapshot
Message-ID: <20221101052205.kq5o6pv66uw3pusg@zlang-mailbox>
References: <cover.1667214081.git.fdmanana@suse.com>
 <e5ae81c52ccbd5245014564b6fbe370ec33c966b.1667214081.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ae81c52ccbd5245014564b6fbe370ec33c966b.1667214081.git.fdmanana@suse.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 11:11:21AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we have a large file, with file extent items spanning several
> leaves in the fs tree, and that is shared due to a snapshot, if we COW one
> of the extents, doing a fiemap will report the respective file range as
> not shared.
> 
> This exercises the processing of delayed references for metadata extents
> in the backref walking code, used by fiemap to determine if an extent is
> shared.
> 
> This used to fail until very recently and was fixed by the following
> kernel commit that landed in 6.1-rc2:
> 
>   943553ef9b51 (""btrfs: fix processing of delayed tree block refs during backref walking")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/280     | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/280.out | 21 +++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100755 tests/btrfs/280
>  create mode 100644 tests/btrfs/280.out
> 
> diff --git a/tests/btrfs/280 b/tests/btrfs/280
> new file mode 100755
> index 00000000..06ef221e
> --- /dev/null
> +++ b/tests/btrfs/280
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 280
> +#
> +# Test that if we have a large file, with file extent items spanning several
> +# leaves in the fs tree, and that is shared due to a snapshot, if we COW one of
> +# the extents, doing a fiemap will report the respective file range as not
> +# shared.
> +#
> +# This exercises the processing of delayed references for metadata extents in
> +# the backref walking code, used by fiemap to determine if an extent is shared.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress snapshot fiemap
> +
> +. ./common/filter
> +. ./common/punch # for _filter_fiemap_flags
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_xfs_io_command "fiemap"
> +
> +_fixed_by_kernel_commit 943553ef9b51 \
> +	"btrfs: fix processing of delayed tree block refs during backref walking"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +# We use compression because it's a very quick way to create a file with a very
> +# large number of extents (compression limits the maximum extent size to 128K)
> +# and while using very little disk space.
> +_scratch_mount -o compress
> +
> +# A 128M file full of compressed extents results in a fs tree with a heigth
> +# of 2 (root at level 1), so we'll end up with tree block references in the
> +# extent tree (if the root was a leaf, we would have only data references).
> +$XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Create a RW snapshot of the default subvolume.
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
> +
> +echo
> +echo "File foo fiemap before COWing extent:"
> +echo
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags
> +
> +echo
> +echo "Overwriting file range [120M, 120M + 128K) in the snapshot"
> +echo
> +$XFS_IO_PROG -c "pwrite -b 128K 120M 128K" $SCRATCH_MNT/snap/foo | _filter_xfs_io
> +# Now fsync the file to force COWing the extent and the path from the root of
> +# the snapshot tree down to the leaf where the extent is at.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/snap/foo
> +
> +echo
> +echo "File foo fiemap after COWing extent in the snapshot:"
> +echo
> +# Now we should have all extents marked as shared except the 128K extent in the
> +# file range [120M, 120M + 128K).
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
> new file mode 100644
> index 00000000..c3f82966
> --- /dev/null
> +++ b/tests/btrfs/280.out
> @@ -0,0 +1,21 @@
> +QA output created by 280
> +wrote 134217728/134217728 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +
> +File foo fiemap before COWing extent:
> +
> +0: [0..261887]: shared
> +1: [261888..262143]: shared|last
> +
> +Overwriting file range [120M, 120M + 128K) in the snapshot
> +
> +wrote 131072/131072 bytes at offset 125829120
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +File foo fiemap after COWing extent in the snapshot:
> +
> +0: [0..245759]: shared
> +1: [245760..246015]: none
> +2: [246016..261887]: shared
> +3: [261888..262143]: shared|last
> -- 
> 2.35.1
> 

