Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A875FB49B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJKObQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 10:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJKObN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 10:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515A595E57
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665498671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MWhFOv/8CIQ7lq6b1mVgRJ2UTIUJEf6/OUvokj16uts=;
        b=M2e7gmmjYmv2HqWCKkbzEH2WvgzsAzWfRwHsKdXS68XjVqnYT9SWBMIcUeBlZ9H02VpJas
        I4qbNmTJu3NesOJxisuTN6ls73sJ5/nCBweMFGsZFmOBoed58kXXAqYIXQOXPmHrdfe519
        /u4HUAitHT/uYNr4ZiqRX9ce2FFATCA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-tRPjWEgQMc6TF51rTYKuZg-1; Tue, 11 Oct 2022 10:31:10 -0400
X-MC-Unique: tRPjWEgQMc6TF51rTYKuZg-1
Received: by mail-qk1-f199.google.com with SMTP id w13-20020a05620a424d00b006e833c4fb0dso9359659qko.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 07:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWhFOv/8CIQ7lq6b1mVgRJ2UTIUJEf6/OUvokj16uts=;
        b=En7SEO+oDYw96hqvscxTnwCGq9jUiFsN5mgoIeLR3a4jRiLas+DE9X/5jOl+hDbPkb
         yc3PWNyYXAtaLwWHFP8tIowxhcmaSKvTnm8Wa/riFiNsf1MXnVmUHj+KQsI4r5Dfk7+C
         xEP1tNDKFXMqSf3CU+/c5TcquZUOitBC5jXe9Jz/XXbrDlCvIrskiYQoU6qQfMd3N2dj
         m8mwi79eVIVV94L/5msqig3YAjFkkNF3O8+/xEAoCVrn1IeFwUOQQjgLQDoi3GBF14u4
         TX2gSOCrVej1vARmHzP896ARqezpsnaaLPwfbWonghcGKB+Dc3ary+Kemf9+R2ZUQQ4h
         sk4g==
X-Gm-Message-State: ACrzQf0h3CVEpO5GobAcBn8io4gm8ApcditVrj+jlrVtvkMDDq5ToSks
        QcdDnY04bqwab+om+zm9gttQB8rNk0X57jZKI14fKVWv2p5ZrMU19m+rvrM427VYriCeRhzsQyq
        4Mj0c5py5sK8Rk1IjEwhpIY0=
X-Received: by 2002:ad4:5941:0:b0:4b4:46b5:e36b with SMTP id eo1-20020ad45941000000b004b446b5e36bmr3275251qvb.33.1665498669089;
        Tue, 11 Oct 2022 07:31:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM67d0s9tp7DYu1Rsy4//wOqVxHJ4xzaA+hqeLIF56Wf01eqKTB9xiomI+8qwhe1dXmt6ptViQ==
X-Received: by 2002:ad4:5941:0:b0:4b4:46b5:e36b with SMTP id eo1-20020ad45941000000b004b446b5e36bmr3275199qvb.33.1665498668675;
        Tue, 11 Oct 2022 07:31:08 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n14-20020ac85a0e000000b00397912cb249sm8700665qta.28.2022.10.11.07.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:31:08 -0700 (PDT)
Date:   Tue, 11 Oct 2022 22:31:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test fiemap reports extent as shared after
 cloning it
Message-ID: <20221011143103.avkf3stsdqztaiav@zlang-mailbox>
References: <c5ede97bf4c2537ef9ee3adf35a9b35cb2150b8a.1665490911.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ede97bf4c2537ef9ee3adf35a9b35cb2150b8a.1665490911.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 01:22:03PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we have two consecutive extents and only one of them is
> cloned, then fiemap correctly reports which one is shared and reports
> the other as not shared.
> 
> This currently fails on btrfs for all kernel releases, but is fixed by
> a kernel patch that landed in Linus' tree last week:
> 
>   ac3c0d36a2a2f7 ("btrfs: make fiemap more efficient and accurate reporting extent sharedness")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

This patch looks good to me. Although I haven't pushed your patch which adds
fiemap group -- "[PATCH 3/3] fstests: add fiemap group", but I've merged it
locally, will push it with this patch together (as this patch depends on it).

Reviewed-by: Zorro Lang <zlang@redhat.com>


>  tests/generic/702     | 92 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/702.out | 23 +++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100755 tests/generic/702
>  create mode 100644 tests/generic/702.out
> 
> diff --git a/tests/generic/702 b/tests/generic/702
> new file mode 100755
> index 00000000..f93bc946
> --- /dev/null
> +++ b/tests/generic/702
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 702
> +#
> +# Test that if we have two consecutive extents and only one of them is cloned,
> +# then fiemap correctly reports which one is shared and reports the other as not
> +# shared.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone fiemap
> +
> +. ./common/filter
> +. ./common/reflink
> +
> +_fixed_by_kernel_commit ac3c0d36a2a2f7 \
> +	"btrfs: make fiemap more efficient and accurate reporting extent sharedness"
> +
> +_supported_fs generic
> +_require_scratch_reflink
> +_require_xfs_io_command "fiemap"
> +
> +fiemap_test_file()
> +{
> +	local filepath=$1
> +
> +	# Skip the first two lines of xfs_io's fiemap output (file path and
> +	# header describing the output columns).
> +	#
> +	# Print the first column (extent number), second column (file range),
> +	# fourth column (extent size) and fifth column (flags) of the fiemap
> +	# output.
> +	#
> +	# We filter the flags column to only tell us if an extent is shared or
> +	# not (flag 0x2000, which matches FIEMAP_EXTENT_SHARED) because on some
> +	# filesystem configs we may have other flags printed - for example
> +	# running btrfs with "-o compress" we get the flag 0x8 as well (which
> +	# is FIEMAP_EXTENT_ENCODED).
> +	#
> +	# The third column is the physical location of the extents, so it's
> +	# omitted because the location varies between different filesystems.
> +	#
> +	$XFS_IO_PROG -c "fiemap -v" $filepath | tail -n +3 | \
> +		$AWK_PROG '{ print $1, $2, $4, \
> +			  and(strtonum($5), 0x2000) ? "shared" : "not_shared" }'
> +}
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +# We create 128K extents in the test files below.
> +_require_congruent_file_oplen $SCRATCH_MNT $((128 * 1024))
> +
> +# Create file foo with 2 consecutive extents, each one with a size of 128K.
> +echo "Creating file foo"
> +$XFS_IO_PROG -f -c "pwrite -b 128K 0 128K" -c "fsync" \
> +	     -c "pwrite -b 128K 128K 128K" -c "fsync" \
> +	     $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Clone only the first extent into another file.
> +echo "Cloning first extent of file foo to file bar"
> +$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/foo 0 0 128K" $SCRATCH_MNT/bar | \
> +	_filter_xfs_io
> +
> +# Now fiemap file foo, it should report the first 128K extent as shared and the
> +# second 128K extent as not shared.
> +echo "fiemap of file foo:"
> +fiemap_test_file $SCRATCH_MNT/foo
> +
> +# Now do a similar test as above, except that this time only the second 128K
> +# extent is cloned, the first extent is not cloned.
> +
> +# Create file foo2 with 2 consecutive extents, each one with a size of 128K.
> +echo "Creating file foo2"
> +$XFS_IO_PROG -f -c "pwrite -b 128K 0 128K" -c "fsync" \
> +	     -c "pwrite -b 128K 128K 128K" -c "fsync" \
> +	     $SCRATCH_MNT/foo2 | _filter_xfs_io
> +
> +# Clone only the second extent of foo2 into another file.
> +echo "Cloning second extent of file foo2 to file bar2"
> +$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/foo2 128K 0 128K" $SCRATCH_MNT/bar2 | \
> +	_filter_xfs_io
> +
> +# Now fiemap file foo2, it should report the first 128K extent as not shared and
> +# the second 128K extent as shared
> +echo "fiemap of file foo2:"
> +fiemap_test_file $SCRATCH_MNT/foo2
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/702.out b/tests/generic/702.out
> new file mode 100644
> index 00000000..576bb5e8
> --- /dev/null
> +++ b/tests/generic/702.out
> @@ -0,0 +1,23 @@
> +QA output created by 702
> +Creating file foo
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 131072/131072 bytes at offset 131072
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Cloning first extent of file foo to file bar
> +linked 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +fiemap of file foo:
> +0: [0..255]: 256 shared
> +1: [256..511]: 256 not_shared
> +Creating file foo2
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 131072/131072 bytes at offset 131072
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Cloning second extent of file foo2 to file bar2
> +linked 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +fiemap of file foo2:
> +0: [0..255]: 256 not_shared
> +1: [256..511]: 256 shared
> -- 
> 2.35.1
> 

