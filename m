Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA88D25B21F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgIBQwz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 12:52:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40814 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgIBQwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 12:52:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082Gnl4o153969;
        Wed, 2 Sep 2020 16:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jxr21YykYZKdullgKkPHFfg+o0ZD8pj+EE1nxrBvYr8=;
 b=YGtPF4fP8Hn+/VT3GSH7KJB+wzo6IZcu9uFbTR/KNIdguSiFdQ6P+Mrqqwyc4eXKmmqK
 9ufDRsdhUy/JIbuIY4Y8gbIkZO3l2NUvZd9LmeapKDLwByNIT41qEjo2veKFQF+cTL/x
 wGWCsjoCoyW5J+d1KhfAZhtd2SHHN7hgH0wRzXpf2mAE6lh5rovPttId61+bes0bNgdR
 N9v/gnTiaL9j9Lw5mC8bRncJa4u24DRxVnKSDTPM+UQkIICRMbcRKvW2qBzCOxr/x1Tg
 y8/LVbp2HCQhxzFcuKUQt16Vg7qSG0d0jlmcZnd0awDellpIcMcji4fdRod/HNfPsBoL zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 339dmn2ag8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 16:52:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082GnjAS137913;
        Wed, 2 Sep 2020 16:50:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3380y021ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 16:50:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082Gojd7016554;
        Wed, 2 Sep 2020 16:50:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 09:50:45 -0700
Date:   Wed, 2 Sep 2020 09:50:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH][v3 fstests: add generic/609 to test O_DIRECT|O_DSYNC
Message-ID: <20200902165044.GE191798@magnolia>
References: <f5ba8625d6277035b69e466f6ea87f19620f7fcb.1599058822.git.josef@toxicpanda.com>
 <20200902160044.266690-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902160044.266690-1-josef@toxicpanda.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020161
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 02, 2020 at 12:00:44PM -0400, Josef Bacik wrote:
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
> ---
> v2->v3:
> - This time with 609.out added, verified it passed with xfs.
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
> index 00000000..3d1c97b2
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
> +_require_xfs_io_command "pwrite" "-DV"
> +
> +$XFS_IO_PROG -f -d -c "pwrite -D -V 1 0 4k"  $TEST_DIR/file | _filter_xfs_io

I wonder, does this also work if you did:

$XFS_IO_PROG -f -d -s -c 'pwrite 0 4k' $TEST_DIR/file

In other words, can you reproduce the problem with good old pwrite() and
a file descriptor opened O_SYNC?  Or do you specifically have to have
pwritev2 with RWF_DSYNC?

(I might also write 64k to future proof this testcase for the day when
someone builds an fs that can only do 64k direct writes, but maybe
that's crazy...)

> +
> +status=0
> +exit
> diff --git a/tests/generic/609.out b/tests/generic/609.out
> new file mode 100644
> index 00000000..db3242cb
> --- /dev/null
> +++ b/tests/generic/609.out
> @@ -0,0 +1,3 @@
> +QA output created by 609
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/generic/group b/tests/generic/group
> index aa969bcb..ae2567a0 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -611,3 +611,4 @@
>  606 auto attr quick dax
>  607 auto attr quick dax
>  608 auto attr quick dax
> +609 auto quick

This probably ought to be 'auto quick rw' since it's a write test.

The rest of the logic looks sound to me though.

--D

> -- 
> 2.28.0
> 
