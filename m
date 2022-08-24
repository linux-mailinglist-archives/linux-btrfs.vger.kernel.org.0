Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23759FDDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbiHXPGm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 11:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbiHXPGk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 11:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A319927A;
        Wed, 24 Aug 2022 08:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C396618C9;
        Wed, 24 Aug 2022 15:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84677C433D6;
        Wed, 24 Aug 2022 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661353594;
        bh=LPdXGG7mzlg0oqGXwJkLQDNxQEfvcnNAFQcLauv1jSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULtLN6bH08i1o2+VkNUXtlg7V+lOB2ZfA57mHS57QGxtKPECsojRgsg75OagQtn9V
         bfVDZEZV5EI0z0+2A07y0mmmbM4BPAZnAYkoFHWOyu5/1YPv6G5gBrnJDnYWWkK7fr
         IMuMyIgSqeF6CQ/0sureUtrIsUXSsdHb1J8bkmvTQtyHNk661D30KuYdDAw/0rcUOx
         0Gm0HIV6wKNok/a2XIhoU90BgC4q6VQ8PY1NSSrDhdnwh0UeIfzlBuANUvM3qbCV7d
         VrxCcgIwtF1Ahetb68HVhl7gLsco3FM4d5SWxjMohIGACNiUQUSXc6fHrm70jTQDQT
         76h3Yt+UPuBIQ==
Date:   Wed, 24 Aug 2022 08:06:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs/271: use the common fail_request setup helpers
Message-ID: <YwY+en1DCZ8FNWUf@magnolia>
References: <20220823193230.505544-1-hch@lst.de>
 <20220823193230.505544-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823193230.505544-2-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 23, 2022 at 09:32:30PM +0200, Christoph Hellwig wrote:
> Use the helpers from common/fail_make_request instead of open coding
> them.  This switches to using a higher error count than the existing
> code, which was the intention from the very beginning (and doesn't
> actuallt matter for the short sequences in this test).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

A pretty straightforward conversion!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/btrfs/271     | 35 ++++++++---------------------------
>  tests/btrfs/271.out |  2 ++
>  2 files changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/tests/btrfs/271 b/tests/btrfs/271
> index 681fa965..c7c95b3e 100755
> --- a/tests/btrfs/271
> +++ b/tests/btrfs/271
> @@ -18,20 +18,6 @@ _require_fail_make_request
>  _require_scratch_dev_pool 2
>  _scratch_dev_pool_get 2
>  
> -enable_io_failure()
> -{
> -	local sysfs_bdev=`_sysfs_dev $1`
> -
> -	echo 1 > $sysfs_bdev/make-it-fail
> -}
> -
> -disable_io_failure()
> -{
> -	local sysfs_bdev=`_sysfs_dev $1`
> -
> -	echo 0 > $sysfs_bdev/make-it-fail
> -}
> -
>  _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>  _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
>  
> @@ -43,15 +29,12 @@ pagesize=$(get_page_size)
>  blocksize=$(_get_block_size $SCRATCH_MNT)
>  sectors_per_page=$(($pagesize / $blocksize))
>  
> -# enable block I/O error injection
> -echo 100 > $DEBUGFS_MNT/fail_make_request/probability
> -echo 1000 > $DEBUGFS_MNT/fail_make_request/times
> -echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
> +_allow_fail_make_request
>  
>  echo "Step 1: writing with one failing mirror:"
> -enable_io_failure $SCRATCH_DEV
> +_bdev_fail_make_request $SCRATCH_DEV 1
>  $XFS_IO_PROG -f -c "pwrite -W -S 0xaa 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io
> -disable_io_failure $SCRATCH_DEV
> +_bdev_fail_make_request $SCRATCH_DEV 0
>  
>  errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | \
>  	$AWK_PROG '/write_io_errs/ { print $2 }')
> @@ -63,15 +46,13 @@ echo "Step 2: verify that the data reads back fine:"
>  $XFS_IO_PROG -c "pread -v 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io_offset
>  
>  echo "Step 3: writing with two failing mirrors (should fail):"
> -enable_io_failure $SCRATCH_DEV
> -enable_io_failure $dev2
> +_bdev_fail_make_request $SCRATCH_DEV 1
> +_bdev_fail_make_request $dev2 1
>  $XFS_IO_PROG -f -c "pwrite -W -S 0xbb 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io
> -disable_io_failure $dev2
> -disable_io_failure $SCRATCH_DEV
> +_bdev_fail_make_request $dev2 0
> +_bdev_fail_make_request $SCRATCH_DEV 0
>  
> -# disable block I/O error injection
> -echo 0 > $DEBUGFS_MNT/fail_make_request/probability
> -echo 0 > $DEBUGFS_MNT/fail_make_request/times
> +_disallow_fail_make_request
>  
>  _scratch_dev_pool_put
>  # success, all done
> diff --git a/tests/btrfs/271.out b/tests/btrfs/271.out
> index 27451c37..d58c92f2 100644
> --- a/tests/btrfs/271.out
> +++ b/tests/btrfs/271.out
> @@ -1,4 +1,5 @@
>  QA output created by 271
> +Allow global fail_make_request feature
>  Step 1: writing with one failing mirror:
>  wrote 8192/8192 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -519,3 +520,4 @@ read 8192/8192 bytes
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Step 3: writing with two failing mirrors (should fail):
>  fsync: Input/output error
> +Disallow global fail_make_request feature
> -- 
> 2.30.2
> 
