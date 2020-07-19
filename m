Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C722530B
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgGSRS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 13:18:59 -0400
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:55518 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 13:18:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09955654|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0151279-0.000842376-0.98403;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03307;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.I4N4Bu3_1595179134;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.I4N4Bu3_1595179134)
          by smtp.aliyun-inc.com(10.147.40.233);
          Mon, 20 Jul 2020 01:18:54 +0800
Date:   Mon, 20 Jul 2020 01:18:53 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Boris Burkov <boris@bur.io>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] generic: add a test for umount racing mount
Message-ID: <20200719171853.GE2557159@desktop>
References: <20200712113741.GW1938@dhcp-12-102.nay.redhat.com>
 <20200713204639.1271794-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713204639.1271794-1-boris@bur.io>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 01:46:39PM -0700, Boris Burkov wrote:
> Test if dirtying many inodes (which can delay umount) then
> unmounting and quickly mounting again causes the mount to fail.
> 
> A race, which breaks the test in btrfs, is fixed by the patch:
> "btrfs: fix mount failure caused by race with umount"
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/generic/603     | 53 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/603.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 56 insertions(+)
>  create mode 100755 tests/generic/603
>  create mode 100644 tests/generic/603.out
> 
> diff --git a/tests/generic/603 b/tests/generic/603
> new file mode 100755
> index 00000000..8e9a80e6
> --- /dev/null
> +++ b/tests/generic/603
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook  All Rights Reserved.
> +#
> +# FS QA Test 603
> +#
> +# Evicting dirty inodes can take a long time during umount.
> +# Check that a new mount racing with such a delayed umount succeeds.
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
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch

Ah, it's fixed in v3, so ignore my first comment in the reply to v2 :)

Thanks,
Eryu

> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +for i in $(seq 0 500)
> +do
> +	dd if=/dev/zero of="$SCRATCH_MNT/$i" bs=1M count=1 > /dev/null 2>&1
> +done
> +_scratch_unmount &
> +_scratch_mount
> +wait
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/603.out b/tests/generic/603.out
> new file mode 100644
> index 00000000..6810da89
> --- /dev/null
> +++ b/tests/generic/603.out
> @@ -0,0 +1,2 @@
> +QA output created by 603
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index d9ab9a31..c0ace35b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -605,3 +605,4 @@
>  600 auto quick quota
>  601 auto quick quota
>  602 auto quick encrypt
> +603 auto quick
> -- 
> 2.24.1
