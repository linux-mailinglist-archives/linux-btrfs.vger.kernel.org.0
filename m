Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E032C7857
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Nov 2020 08:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgK2HTz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Nov 2020 02:19:55 -0500
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:47253 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgK2HTz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Nov 2020 02:19:55 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07535394|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.399659-0.00197455-0.598366;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.J0Yt7M8_1606634344;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.J0Yt7M8_1606634344)
          by smtp.aliyun-inc.com(10.147.41.138);
          Sun, 29 Nov 2020 15:19:04 +0800
Date:   Sun, 29 Nov 2020 15:19:04 +0800
From:   Eryu Guan <guan@eryu.me>
To:     ethanwu <ethanwu@synology.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com
Subject: Re: [PATCH] btrfs: test if rename handles dir item collision
 correctly
Message-ID: <20201129071904.GO3853@desktop>
References: <20201126105013.246270-1-ethanwu@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126105013.246270-1-ethanwu@synology.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 26, 2020 at 06:50:13PM +0800, ethanwu wrote:
> This is a regression test for the issue fixed by the kernel commit titled
> "Btrfs: correctly calculate item size used when item key collision happends"
> 
> In this case, we'll simply rename many forged filename that cause collision
> under a directory to see if rename failed and filesystem is forced readonly.
> 
> Signed-off-by: ethanwu <ethanwu@synology.com>
> ---
>  tests/btrfs/227     | 311 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/227.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 314 insertions(+)
>  create mode 100755 tests/btrfs/227
>  create mode 100644 tests/btrfs/227.out
> 
> diff --git a/tests/btrfs/227 b/tests/btrfs/227
> new file mode 100755
> index 00000000..ba1cd359
> --- /dev/null
> +++ b/tests/btrfs/227
> @@ -0,0 +1,311 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Synology.  All Rights Reserved.
> +#
> +# FS QA Test 227
> +#
> +# Test if btrfs rename handle dir item collision correctly
> +# Without patch fix, rename will fail with EOVERFLOW, and filesystem
> +# is forced readonly.
> +#
> +# This bug is going to be fxied by a patch for kernel titled
> +# "Btrfs: correctly calculate item size used when item key collision happends"
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
> +    cd /
> +    rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch
> +
> +rm -f $seqres.full
> +
> +# Currently in btrfs the node/leaf size can not be smaller than the page
> +# size (but it can be greater than the page size). So use the largest
> +# supported node/leaf size (64Kb) so that the test can run on any platform
> +# that Linux supports.
> +_scratch_mkfs "--nodesize 65536" >>$seqres.full 2>&1
> +_scratch_mount
> +
> +file_name_list=(d6d0dIka505ebc681949a25a3f1a4e7464f18bfcdb04a103b8ece40cddf61ccc9e690232878008edceecda8633591197bce8c0105891d2717425cb4bd04223bb08426de820da732c0e16b8a9fa236bb5b5260e526639780dacd378ca79428f640a0300a11a98f4f92719c62d6f7d756fa80f0aa654ae06

The file names are too long for the test, I'm wondering how are the
names that could cause collisions generated in the first place? Is it
possible to re-generate them at runtime? Instead of hard-coding them in
the array.

Thanks,
Eryu
