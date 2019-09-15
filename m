Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02228B2E2B
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 06:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfIOEgX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Sep 2019 00:36:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39860 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfIOEgX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Sep 2019 00:36:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id i1so11585317pfa.6;
        Sat, 14 Sep 2019 21:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nNq7LHU3QqqsQk9p0onC2EDsswEjjpq97N/L9TB2bI=;
        b=ovI00x4MzJi+D1YJCZO2CEMQRBHjCsZFSk7yNjQBgNnc8RWfXXCbQeF1uYPaPhN4ly
         u9H/yTZkMvIJdXifVYQHni54XXK6bxexkW/uLyjBuRPYjNM51X1ZhS7EqHZ9jn8h1Tsb
         RS8BUwroRnPAwH4KBwLB7G5VNl3l17Bsgs7A90h5R1bU4nrUIjHX8Mp5W9znJgKyZBcJ
         HzAC7wOvQYtstD0jEaPSYbadPwUmz2FWTguOl0tFKaFh8c/vMgbKxbh5hYZYNY1p4gr2
         UT3hrnvStTFtqFwyuYLqGNvaTCuqgdaeqJOLxyBHK12oiJE6Uyp1IN7hbcxbMzApk6eA
         8N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nNq7LHU3QqqsQk9p0onC2EDsswEjjpq97N/L9TB2bI=;
        b=edjXY/dvNU0P4sef/LeQW3MNeIEMw8gZB+DDtwvXCdGtIkLqXYGu1qFjiKDLjhOafg
         EiCMFdIyGs9LB7gQQAekGZn8i2Gzk2BR1YY/jz6+PgKtUx0SFArDHK8bzBz7fH7sHGBc
         W0GIIxIrbJyFBmhi/tnRau2cRkzMp35Km/DhMOn88LHpe5B/3/n6wpwK108rGNXMuNvd
         n/3mMeqPJlSkC5q0FqxQIvj9w+4kbPsIQMTUcqINyaobHpsXWkChnRb8E3v+tnkRXr6Q
         7f+79vZEqmwx12ClEM1u+ASZtqMhKaw+gvixlbojsfxC/KFT2xiCvs+JN4PjtbKP4A7S
         qivQ==
X-Gm-Message-State: APjAAAVHrmZy4xZLJI/yQv6vCEcPNLYZabpIW+BXZ2uABzCWYLR6OyKN
        jjrs6bxx2ZLaNZEy+XT2oug=
X-Google-Smtp-Source: APXvYqwTa5ZBfHWSgFVH4PJjk+ShRwPE259VCe9D3lKe5QNR4uCVbbuTkSJilAEzXerv2sFygr2rTg==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr29978962pgv.168.1568522181696;
        Sat, 14 Sep 2019 21:36:21 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id f23sm33903344pfn.22.2019.09.14.21.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 21:36:20 -0700 (PDT)
Date:   Sun, 15 Sep 2019 12:36:14 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs: Verify falloc on multiple holes won't
 cause qgroup reserved data space leak
Message-ID: <20190915043614.GK2622@desktop>
References: <20190913015151.15076-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913015151.15076-1-wqu@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 13, 2019 at 09:51:51AM +0800, Qu Wenruo wrote:
> Add a test case where falloc is called on multiple holes with qgroup
> enabled.
> 
> This can cause qgroup reserved data space leak and false EDQUOT error
> even we're not reaching the limit.
> 
> The fix is titled:
> "btrfs: qgroup: Fix the wrong target io_tree when freeing
>  reserved data space"
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/192     | 72 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/192.out | 18 ++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 91 insertions(+)
>  create mode 100755 tests/btrfs/192
>  create mode 100644 tests/btrfs/192.out
> 
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> new file mode 100755
> index 00000000..361b6d92
> --- /dev/null
> +++ b/tests/btrfs/192
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 192
> +#
> +# Test if btrfs is going to leak qgroup reserved data space when
> +# falloc on multiple holes fails.
> +# The fix is titled:
> +# "btrfs: qgroup: Fix the wrong target io_tree when freeing reserved data space"
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_xfs_io_command falloc
> +
> +_scratch_mkfs > /dev/null
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
> +$BTRFS_UTIL_PROG qgroup limit -e 256M "$SCRATCH_MNT"
> +
> +for i in $(seq 3); do

Why do we need to loop 3 times? Some comments would be good, or we could
just remove the loop?

Other than that the test looks fine to me.

Thanks,
Eryu

> +	# Create a file with the following layout:
> +	# 0         128M      256M      384M
> +	# |  Hole   |4K| Hole |4K| Hole |
> +	# The total hole size will be 384M - 8k
> +	truncate -s 384m "$SCRATCH_MNT/file"
> +	$XFS_IO_PROG -c "pwrite 128m 4k" -c "pwrite 256m 4k" \
> +		"$SCRATCH_MNT/file" | _filter_xfs_io
> +
> +	# Falloc 0~384M range, it's going to fail due to the qgroup limit
> +	$XFS_IO_PROG -c "falloc 0 384m" "$SCRATCH_MNT/file" |\
> +		_filter_xfs_io_error
> +	rm "$SCRATCH_MNT/file"
> +
> +	# Ensure above delete reaches disk and free some space
> +	sync
> +done
> +
> +# We should be able to write at least 3/4 of the limit
> +$XFS_IO_PROG -f -c "pwrite 0 192m" "$SCRATCH_MNT/file" | _filter_xfs_io
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/192.out b/tests/btrfs/192.out
> new file mode 100644
> index 00000000..13bc6036
> --- /dev/null
> +++ b/tests/btrfs/192.out
> @@ -0,0 +1,18 @@
> +QA output created by 192
> +wrote 4096/4096 bytes at offset 134217728
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 4096/4096 bytes at offset 268435456
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +fallocate: Disk quota exceeded
> +wrote 4096/4096 bytes at offset 134217728
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 4096/4096 bytes at offset 268435456
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +fallocate: Disk quota exceeded
> +wrote 4096/4096 bytes at offset 134217728
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 4096/4096 bytes at offset 268435456
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +fallocate: Disk quota exceeded
> +wrote 201326592/201326592 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 2474d43e..160fe927 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -194,3 +194,4 @@
>  189 auto quick send clone
>  190 auto quick replay balance qgroup
>  191 auto quick send dedupe
> +192 auto qgroup fast enospc limit
> -- 
> 2.22.0
> 
