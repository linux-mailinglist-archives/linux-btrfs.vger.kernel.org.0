Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C32C2DF5AE
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Dec 2020 15:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgLTOde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Dec 2020 09:33:34 -0500
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:58695 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbgLTOdd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Dec 2020 09:33:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436582|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0562625-0.00115523-0.942582;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.J9NOF22_1608474762;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.J9NOF22_1608474762)
          by smtp.aliyun-inc.com(10.147.42.22);
          Sun, 20 Dec 2020 22:32:42 +0800
Date:   Sun, 20 Dec 2020 22:32:41 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [RESEND PATCH] btrfs: Add test 154
Message-ID: <20201220143241.GY3853@desktop>
References: <20201207153237.1073887-1-nborisov@suse.com>
 <20201207161900.1079190-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207161900.1079190-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 07, 2020 at 06:19:00PM +0200, Nikolay Borisov wrote:
> This test verifies btrfs' free objectid management. I.e it ensures that
> the first objectid is always 256 in an fs tree.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Some minor issues below, but I'd like btrfs folks to help review to see
if the free objectid management test is reasonable.

> ---
> 
> Resend it as I fudged btrfs' mailing list address so the patch didn't get to it.
>  tests/btrfs/154     | 80 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/154.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 83 insertions(+)
>  create mode 100755 tests/btrfs/154
>  create mode 100644 tests/btrfs/154.out
> 
> diff --git a/tests/btrfs/154 b/tests/btrfs/154
> new file mode 100755
> index 000000000000..6aee204e05cb
> --- /dev/null
> +++ b/tests/btrfs/154
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 154
> +#
> +# Test correct operation of free objectid related functionality
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
> +_require_scratch
> +
> +
> +_scratch_mkfs > /dev/null
> +_scratch_mount
> +
> +# create a new subvolume to validate its objectid is initialized accordingly
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/newvol >> $seqres.full 2>&1 \
> +	|| _fail "couldn't create subvol"
> +
> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t1 $SCRATCH_DEV \
> +	| grep -q "256 ROOT_ITEM"  ||	_fail "First subvol with id 256 doesn't exist"

This also requires

_require_btrfs_command inspect-internal dump-tree

And it's better to explain why '256' is the expected value, where does
it come from.

> +
> +# create new file in the new subvolume to validate its objectid is set as
> +# expected
> +touch $SCRATCH_MNT/newvol/file1
> +
> +# ensure we have consistent view on-disk
> +sync
> +
> +# get output related to the new root's dir entry
> +output=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t5 $SCRATCH_DEV | grep -A2 "256 DIR_ITEM 1903355334")
> +
> +# get the objectid of the new root
> +new_root_id=$(echo "$output" | awk '/location key/{printf $3}' | tr -d  '(')

I'd dump the output to a tmp file (and the following outputs in the
test), as saving the output in a variable may cause unexpected results,
something like ignoring "\n", and make it harder to debug.

> +[ $new_root_id -eq 256 ] || _fail "New root id not equal to 256"
> +
> +# the given root should always be item number 2, since it's the only item
> +item_seq=$(echo "$output" | awk '/item/ {printf $2}')

$AWK_PROG

Thanks,
Eryu

> +[ $item_seq -eq 2 ] || _fail "New root not at item idx 2"
> +
> +# now parse the structure of the new subvol's tree
> +output=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t256 $SCRATCH_DEV)
> +
> +# this is the subvol's own ino
> +first_ino=$(echo "$output" | awk '/item 0/{printf $4}' | tr -d '(')
> +[ $first_ino -eq 256 ] || _fail "First ino objectid in subvol not 256"
> +
> +# this is ino of first file in subvol
> +second_ino=$(echo "$output" | awk '/item 4/{printf $4}' | tr -d '(')
> +[ $second_ino -eq 257 ] || _fail "Second ino objectid in subvol not 257"
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/154.out b/tests/btrfs/154.out
> new file mode 100644
> index 000000000000..a18c304305c4
> --- /dev/null
> +++ b/tests/btrfs/154.out
> @@ -0,0 +1,2 @@
> +QA output created by 154
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index d18450c7552e..44d33222def0 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -156,6 +156,7 @@
>  151 auto quick volume
>  152 auto quick metadata qgroup send
>  153 auto quick qgroup limit
> +154 auto quick
>  155 auto quick send
>  156 auto quick trim balance
>  157 auto quick raid
> --
> 2.17.1
