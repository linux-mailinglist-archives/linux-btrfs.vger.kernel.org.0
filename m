Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9646826366E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgIITEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 15:04:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44022 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIITEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 15:04:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089Ixgvc156790;
        Wed, 9 Sep 2020 19:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=eUQLJKkJwngh5GhFzMwdnVOIBBr3ctU8HUS8W/0hJL8=;
 b=N4mhetbEKBq5uJImIJZHevfD2/RCytT0ZRlD33fBYys2PNyFzs/eyGU3apnhsS34bvLB
 vfmkYT2e01q+H4mFy6I/gVk6EqKyoaVeaDIzRYsqCGl7VRggriAb93P/J+/OTQK4K4p5
 7I90TanotUkjzcpsRceNeRLEyeMc1xGm+Baj4AP9nzzG0pYEl8ej5LL0sLweymCQzPWt
 qii8svgvCfLU/NCrpk4eZBOU2VB8U+NILEsGEiQa6SCNfbxuxRJ28LQmxKIMp8iRXf8B
 z0PTurN79m9lPxT0OWDSbxSf4cvpNIwNOf5bNIziDNPZYkBMgXCEQQV2Ji/YzMF1/Zuv oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 33c23r3ts4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 19:04:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089J1V82154635;
        Wed, 9 Sep 2020 19:02:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33cmetdasd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 19:02:17 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 089J2FZH031863;
        Wed, 9 Sep 2020 19:02:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Sep 2020 12:02:14 -0700
Date:   Wed, 9 Sep 2020 12:02:13 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: add test for zero range over a file range with
 many small extents
Message-ID: <20200909190213.GA7943@magnolia>
References: <e038bd2419f60f0b4c5ac13da78bfba345f4dba7.1599560067.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e038bd2419f60f0b4c5ac13da78bfba345f4dba7.1599560067.git.fdmanana@suse.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=3 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090168
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 08, 2020 at 11:32:02AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test a fallocate() zero range operation against a large file range for which
> there are many small extents allocated. Verify the operation does not fail
> and the respective range return zeroes on subsequent reads.

LOL, we didn't already have a stress test for fzero? :/

> This test is motivated by a bug found on btrfs. The patch that fixes the
> bug on btrfs has the following subject:
> 
>  "btrfs: fix metadata reservation for fallocate that leads to transaction aborts"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good to me!

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/609     | 61 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/609.out |  5 ++++
>  tests/generic/group   |  1 +
>  3 files changed, 67 insertions(+)
>  create mode 100755 tests/generic/609
>  create mode 100644 tests/generic/609.out
> 
> diff --git a/tests/generic/609 b/tests/generic/609
> new file mode 100755
> index 00000000..cda2b3dc
> --- /dev/null
> +++ b/tests/generic/609
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 609
> +#
> +# Test a fallocate() zero range operation against a large file range for which
> +# there are many small extents allocated. Verify the operation does not fail
> +# and the respective range return zeroes on subsequent reads.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
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
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_xfs_io_command "fzero"
> +_require_xfs_io_command "fpunch"
> +_require_test_program "punch-alternating"
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Create a file with many small extents. To speed up file creation, do
> +# buffered writes and then punch a hole on every other block.
> +$XFS_IO_PROG -f -c "pwrite -S 0xab -b 10M 0 100M" \
> +	$SCRATCH_MNT/foobar >>$seqres.full
> +$here/src/punch-alternating $SCRATCH_MNT/foobar >>$seqres.full
> +
> +# For btrfs, trigger a transaction commit to force metadata COW for the
> +# following fallocate zero range operation.
> +sync
> +
> +$XFS_IO_PROG -c "fzero 0 100M" $SCRATCH_MNT/foobar
> +
> +# Check the file content after umounting and mounting again the fs, to verify
> +# everything was persisted.
> +_scratch_cycle_mount
> +
> +echo "File content after zero range operation:"
> +od -A d -t x1 $SCRATCH_MNT/foobar
> +
> +status=0
> +exit
> diff --git a/tests/generic/609.out b/tests/generic/609.out
> new file mode 100644
> index 00000000..feb8c211
> --- /dev/null
> +++ b/tests/generic/609.out
> @@ -0,0 +1,5 @@
> +QA output created by 609
> +File content after zero range operation:
> +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +*
> +104857600
> diff --git a/tests/generic/group b/tests/generic/group
> index aa969bcb..f8eabc0a 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -611,3 +611,4 @@
>  606 auto attr quick dax
>  607 auto attr quick dax
>  608 auto attr quick dax
> +609 auto quick prealloc zero
> -- 
> 2.26.2
> 
