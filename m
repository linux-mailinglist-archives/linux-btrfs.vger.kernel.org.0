Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB9271654
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Sep 2020 19:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgITR1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Sep 2020 13:27:51 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:44333 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgITR1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Sep 2020 13:27:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07495303|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.589075-0.000620109-0.410305;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.IZoBNHJ_1600622866;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IZoBNHJ_1600622866)
          by smtp.aliyun-inc.com(10.147.40.44);
          Mon, 21 Sep 2020 01:27:47 +0800
Date:   Mon, 21 Sep 2020 01:27:40 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs/022: Add qgroup assign test
Message-ID: <20200920172740.GQ3853@desktop>
References: <20200920085753.277590-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920085753.277590-1-realwakka@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 20, 2020 at 08:57:53AM +0000, Sidong Yang wrote:
> The btrfs/022 test is basic test about qgroup. but it doesn't have
> test with qgroup assign function. This patch adds parent assign
> test. parent assign test make two subvolumes and a qgroup for assign.
> Assign two subvolumes with a qgroup and check that quota of group
> has same value with sum of two subvolumes.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

We usually don't add new test case to existing tests, as that may make a
PASSed test starting to FAIL, which looks like a regression.

> ---
>  tests/btrfs/022 | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tests/btrfs/022 b/tests/btrfs/022
> index aaa27aaa..cafaa8b2 100755
> --- a/tests/btrfs/022
> +++ b/tests/btrfs/022
> @@ -110,6 +110,40 @@ _limit_test_noexceed()
>  	[ $? -eq 0 ] || _fail "should have been allowed to write"
>  }
>  
> +#basic assign testing
> +_parent_assign_test()

Local function names don't need to be prefixed with "_".

> +{
> +	echo "=== parent assign test ===" >> $seqres.full
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a

The helpers based on run_check are not recommended, please just
open-coded btrfs subvolume command and filter the output when necessary.
j
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	subvolid_a=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	subvolid_b=$(_btrfs_get_subvolid $SCRATCH_MNT b)
> +
> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
> +
> +	_run_btrfs_util_prog qgroup assign 0/$subvolid_a 1/100 $SCRATCH_MNT
> +	_run_btrfs_util_prog qgroup assign 0/$subvolid_b 1/100 $SCRATCH_MNT
> +
> +	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
> +	_ddt of=$SCRATCH_MNT/b/file bs=4M count=1 >> $seqres.full 2>&1
> +	sync

Just fsync the individule files if possible.


> +
> +	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid_a")
> +	a_shared=$(echo $a_shared | awk '{ print $2 }' | tr -dc '0-9')

$AWK_PROG

> +
> +	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid_b")
> +	b_shared=$(echo $b_shared | awk '{ print $2 }' | tr -dc '0-9')
> +	sum=$(expr $b_shared  + $a_shared)
> +
> +	q_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "1/100")
> +	q_shared=$(echo $q_shared | awk '{ print $2 }' | tr -dc '0-9')
> +
> +	[ $sum -eq $q_shared ] || _fail "shared values don't match"

Print the actual number and expected number as well?

Thanks,
Eryu

> +}
> +
>  units=`_btrfs_qgroup_units`
>  
>  _scratch_mkfs > /dev/null 2>&1
> @@ -133,6 +167,12 @@ _check_scratch_fs
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  _limit_test_noexceed
> +_scratch_unmount
> +_check_scratch_fs
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +_parent_assign_test
>  
>  # success, all done
>  echo "Silence is golden"
> -- 
> 2.25.1
