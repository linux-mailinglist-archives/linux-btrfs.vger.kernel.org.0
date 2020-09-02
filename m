Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9025B3A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgIBSWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 14:22:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBSWD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 14:22:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082I9eVZ094919;
        Wed, 2 Sep 2020 18:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cmKMfdGiIE4tNXnhVXVNmnTi1MSq2Jql+jhofTKa+9c=;
 b=un5sTMJ7/WBFSj+eJRyAXzbAdG8d0XqKMB9Vor8aztCyLJrGrm61jT/Y6xqP7EAemAl5
 6DyTVhfnxJfE1pyju5KJrgncclkvqeg19W8QoORHVCU5oSbNZDHTiy39OjRKtBfaHc1i
 XIckAlmfRhw98pgWkIcj241sZYLQJNE0Bqc3/iPqRmTInlsz+CCERRwpHml8W1YOiqLI
 BQ+aXDXpbM7oSNJPXDcGPh1sDHpra5pnkO/gxmi2LrfxUmIypG6U1lFgPdBlpCi16DCg
 iAtQ7QWQhNfuOtE9EzITNJ9uQ8aej4WTeagSChiVp73Q6LArSrAtTBYzMfBTnE2mHy29 zA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 339dmn2vgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 18:22:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082I9kfq040335;
        Wed, 2 Sep 2020 18:22:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3380y06bw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 18:22:01 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082IM0VT029620;
        Wed, 2 Sep 2020 18:22:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 11:22:00 -0700
Date:   Wed, 2 Sep 2020 11:21:59 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH][v4] fstests: add generic/609 to test O_DIRECT|O_DSYNC
Message-ID: <20200902182159.GB6084@magnolia>
References: <8e841e0e05934baaf6119363414440b271426a03.1599065695.git.josef@toxicpanda.com>
 <20200902171036.273416-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902171036.273416-1-josef@toxicpanda.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020171
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 02, 2020 at 01:10:36PM -0400, Josef Bacik wrote:
> We had a problem recently where btrfs would deadlock with
> O_DIRECT|O_DSYNC because of an unexpected dependency on ->fsync in
> iomap.  This was only caught by chance with aiostress, because weirdly
> we don't actually test this particular configuration anywhere in
> xfstests.  Fix this by adding a basic test that just does
> O_DIRECT|O_DSYNC writes.  With this test the box deadlocks right away
> with Btrfs, which would have been helpful in finding this issue before
> the patches were merged.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks fine to me, thanks!  Sorry about Yet Another Iomap Dustup. :(

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> v3->v4:
> - Trying to see how many times I can fuck this thing up.
> - Simplified the xfs_io command per Darrick's suggestion.
> - Added it to the rw group.
> 
>  tests/generic/609     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/609.out |  3 +++
>  tests/generic/group   |  1 +
>  3 files changed, 47 insertions(+)
>  create mode 100755 tests/generic/609
>  create mode 100644 tests/generic/609.out
> 
> diff --git a/tests/generic/609 b/tests/generic/609
> new file mode 100755
> index 00000000..6c74ae63
> --- /dev/null
> +++ b/tests/generic/609
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Josef Bacik.  All Rights Reserved.
> +#
> +# FS QA Test 609
> +#
> +# iomap can call generic_write_sync() if we're O_DSYNC, so write a basic test to
> +# exercise O_DSYNC so any unsuspecting file systems will get lockdep warnings if
> +# their locking isn't compatible.
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
> +	rm -rf $TEST_DIR/file
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_xfs_io_command "pwrite"
> +
> +$XFS_IO_PROG -f -d -s -c "pwrite 0 64k" $TEST_DIR/file | _filter_xfs_io
> +
> +status=0
> +exit
> diff --git a/tests/generic/609.out b/tests/generic/609.out
> new file mode 100644
> index 00000000..111c7fe9
> --- /dev/null
> +++ b/tests/generic/609.out
> @@ -0,0 +1,3 @@
> +QA output created by 609
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/generic/group b/tests/generic/group
> index aa969bcb..ae2567a0 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -611,3 +611,4 @@
>  606 auto attr quick dax
>  607 auto attr quick dax
>  608 auto attr quick dax
> +609 auto quick rw
> -- 
> 2.28.0
> 
