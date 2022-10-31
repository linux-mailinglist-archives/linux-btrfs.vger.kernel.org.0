Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C6613B8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiJaQmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 12:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJaQml (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 12:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE5E2DE4
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667234497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YGh6jUl6pL2pcWB7w0OY1LDk164YbQNLIed9ZQ1pCDY=;
        b=N20NHLEfgHw/oHR5ItpZ5x2BvXT/pg3SJv4O3/glrwuEDfQx7z67bwmuovlsGmas8PG8/h
        x2KbVVTcOaaI00JrQOvJr9mceo3hZFVSFZWIjS0vABCYeUl9O1r7nnTp7lsjc6FXdLAmxv
        u8fdCczjFnnLmzCS33u7ehO8/KisE6U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596--6pZ_wp3OU25H8EiQJ-CJw-1; Mon, 31 Oct 2022 12:41:35 -0400
X-MC-Unique: -6pZ_wp3OU25H8EiQJ-CJw-1
Received: by mail-qk1-f197.google.com with SMTP id u7-20020a05620a0c4700b006ee526183fcso9775151qki.8
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 09:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGh6jUl6pL2pcWB7w0OY1LDk164YbQNLIed9ZQ1pCDY=;
        b=2vODlrX7VEbWbPTBSMkc98wZEV3jRJVsr6G3S1sAC5tLCwBoFgLA5O7msV/1ijTvKn
         VdcdBA2TFgP8SM9LaVb7QX168T8+MZCMcO0goTNf87xxCji8r0cGxcA4Onx29Swizxt1
         iU3UTmNAloPLz6Mk4Ue9kqTizGk3ybLhA+zmdtp5z4wqfGwP3wcO/GJnxcwQdX8Uw4Ho
         yYcheDKL8kUqpMNdfKgehWonraSJlFvOlbTq+Dxu159YEdZ0jqTBb54V3W5uFJ5rl6W1
         jpprWWvmypTt+pUP+rhL4bCl7XeHawRVpYMMd7IvRABJXuZ0LoCEeIhWiFQpDpma4PQK
         bQPA==
X-Gm-Message-State: ACrzQf2xIritI6wF/m86mp7thV2LA7bmO+F9rCiwuTYnEgh6Zhnk6tsv
        Iba1L3AhuEauhA6+Etna2t6/NN9fxJEBvzgcWr0DiMHcNXg5+EgL02yFxaCtYTbI6bVb5OvrrPd
        q06JXNYgPrZRRViotzpAlvck=
X-Received: by 2002:a05:622a:8f:b0:3a5:d2f:729c with SMTP id o15-20020a05622a008f00b003a50d2f729cmr11317904qtw.211.1667234494586;
        Mon, 31 Oct 2022 09:41:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6UYwFr/CeJ7F4IL5Hn6P0UFcJrk+JhKdIX64EldE9RG/A/XbhjfH4Ztkiwirz38BzIjIAXhw==
X-Received: by 2002:a05:622a:8f:b0:3a5:d2f:729c with SMTP id o15-20020a05622a008f00b003a50d2f729cmr11317883qtw.211.1667234494299;
        Mon, 31 Oct 2022 09:41:34 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a450100b006cbcdc6efedsm5022480qkp.41.2022.10.31.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:41:33 -0700 (PDT)
Date:   Tue, 1 Nov 2022 00:41:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/3] btrfs: test that fiemap reports extent as not shared
 after deleting file
Message-ID: <20221031164128.z4cujrkrcxe6ujqr@zlang-mailbox>
References: <cover.1667214081.git.fdmanana@suse.com>
 <27a0c4ab551b7a7410f4062f5235f20c88e77cfc.1667214081.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a0c4ab551b7a7410f4062f5235f20c88e77cfc.1667214081.git.fdmanana@suse.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 11:11:20AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we have two files with shared extents, after removing one of
> the files, if we do a fiemap against the other file, it does not report
> extents as shared anymore.
> 
> This exercises the processing of delayed references for data extents in
> the backref walking code, used by fiemap to determine if an extent is
> shared.
> 
> This used to fail until very recently and was fixed by the following
> kernel commit that landed in 6.1-rc2:
> 
>   4fc7b5722824 (""btrfs: fix processing of delayed data refs during backref walking")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Looks good to me. As this's not a genericcase, I'm not sure if you need
_require_congruent_file_oplen helper.

Thanks,
Zorro

>  tests/btrfs/279     | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/279.out | 39 +++++++++++++++++++++
>  2 files changed, 121 insertions(+)
>  create mode 100755 tests/btrfs/279
>  create mode 100644 tests/btrfs/279.out
> 
> diff --git a/tests/btrfs/279 b/tests/btrfs/279
> new file mode 100755
> index 00000000..5b5824fd
> --- /dev/null
> +++ b/tests/btrfs/279
> @@ -0,0 +1,82 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 279
> +#
> +# Test that if we have two files with shared extents, after removing one of the
> +# files, if we do a fiemap against the other file, it does not report extents as
> +# shared anymore.
> +#
> +# This exercises the processing of delayed references for data extents in the
> +# backref walking code, used by fiemap to determine if an extent is shared.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol fiemap clone
> +
> +. ./common/filter
> +. ./common/reflink
> +. ./common/punch # for _filter_fiemap_flags
> +
> +_supported_fs btrfs
> +_require_scratch_reflink
> +_require_cp_reflink
> +_require_xfs_io_command "fiemap"
> +
> +_fixed_by_kernel_commit 4fc7b5722824 \
> +	"btrfs: fix processing of delayed data refs during backref walking"
> +
> +run_test()
> +{
> +	local file_path_1=$1
> +	local file_path_2=$2
> +	local do_sync=$3
> +
> +	$XFS_IO_PROG -f -c "pwrite 0 64K" $file_path_1 | _filter_xfs_io
> +	_cp_reflink $file_path_1 $file_path_2
> +
> +	if [ $do_sync -eq 1 ]; then
> +		sync
> +	fi
> +
> +	echo "Fiemap of $file_path_1 before deleting $file_path_2:" | \
> +		_filter_scratch
> +	$XFS_IO_PROG -c "fiemap -v" $file_path_1 | _filter_fiemap_flags
> +
> +	rm -f $file_path_2
> +
> +	echo "Fiemap of $file_path_1 after deleting $file_path_2:" | \
> +		_filter_scratch
> +	$XFS_IO_PROG -c "fiemap -v" $file_path_1 | _filter_fiemap_flags
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Create two test subvolumes, we'll reflink files between them.
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv2 | _filter_scratch
> +
> +echo
> +echo "Testing with same subvolume and without transaction commit"
> +echo
> +run_test "$SCRATCH_MNT/subv1/f1" "$SCRATCH_MNT/subv1/f2" 0
> +
> +echo
> +echo "Testing with same subvolume and with transaction commit"
> +echo
> +run_test "$SCRATCH_MNT/subv1/f3" "$SCRATCH_MNT/subv1/f4" 1
> +
> +echo
> +echo "Testing with different subvolumes and without transaction commit"
> +echo
> +run_test "$SCRATCH_MNT/subv1/f5" "$SCRATCH_MNT/subv2/f6" 0
> +
> +echo
> +echo "Testing with different subvolumes and with transaction commit"
> +echo
> +run_test "$SCRATCH_MNT/subv1/f7" "$SCRATCH_MNT/subv2/f8" 1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/279.out b/tests/btrfs/279.out
> new file mode 100644
> index 00000000..a959a86d
> --- /dev/null
> +++ b/tests/btrfs/279.out
> @@ -0,0 +1,39 @@
> +QA output created by 279
> +Create subvolume 'SCRATCH_MNT/subv1'
> +Create subvolume 'SCRATCH_MNT/subv2'
> +
> +Testing with same subvolume and without transaction commit
> +
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Fiemap of SCRATCH_MNT/subv1/f1 before deleting SCRATCH_MNT/subv1/f2:
> +0: [0..127]: shared|last
> +Fiemap of SCRATCH_MNT/subv1/f1 after deleting SCRATCH_MNT/subv1/f2:
> +0: [0..127]: last
> +
> +Testing with same subvolume and with transaction commit
> +
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Fiemap of SCRATCH_MNT/subv1/f3 before deleting SCRATCH_MNT/subv1/f4:
> +0: [0..127]: shared|last
> +Fiemap of SCRATCH_MNT/subv1/f3 after deleting SCRATCH_MNT/subv1/f4:
> +0: [0..127]: last
> +
> +Testing with different subvolumes and without transaction commit
> +
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Fiemap of SCRATCH_MNT/subv1/f5 before deleting SCRATCH_MNT/subv2/f6:
> +0: [0..127]: shared|last
> +Fiemap of SCRATCH_MNT/subv1/f5 after deleting SCRATCH_MNT/subv2/f6:
> +0: [0..127]: last
> +
> +Testing with different subvolumes and with transaction commit
> +
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Fiemap of SCRATCH_MNT/subv1/f7 before deleting SCRATCH_MNT/subv2/f8:
> +0: [0..127]: shared|last
> +Fiemap of SCRATCH_MNT/subv1/f7 after deleting SCRATCH_MNT/subv2/f8:
> +0: [0..127]: last
> -- 
> 2.35.1
> 

