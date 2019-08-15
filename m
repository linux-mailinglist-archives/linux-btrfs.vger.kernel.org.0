Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE438EF43
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 17:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfHOPY7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 11:24:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37150 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfHOPY7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 11:24:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FFJQCB136194;
        Thu, 15 Aug 2019 15:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=EpIVQiNCwCTUbnAkihnc0Cc81qJr1r6lBl7uzRkVzkI=;
 b=jFOOxX5H730wRc5h5tsHDqS9vn0YY4v7Ub8nXRO3GevICzTUjw7+m/tDuoMm+VcPvNrN
 srZYm/0W/Pjq0CrLzOw1TFSmx795a7q3ZO2EAjYygKBL3EFr3BbBzwEWCgPYnkTfAc7Q
 yVp3QBO2ZDuCLQMdf36l4H97Plt13+S47OlewVzCWgKFyAFUiFcgYNZ6vRI+4dxdTI/X
 0Y4RFK2ClkFuJ0lAmx+hRjNrU1Uc6V8CPlUbGJz7MUw+kEcj9pWDGy9KVY05amf/KlVz
 AuSqJ5n1BFfiVWFtrBOvA5S+IRZpbBFT26po4UnaY9ZHHSBk7ltfamdRYTLp9EOwJppZ /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u9pjqu7f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 15:24:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FFI3P6151513;
        Thu, 15 Aug 2019 15:24:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ucs882eqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 15:24:55 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7FFOsxj021311;
        Thu, 15 Aug 2019 15:24:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 08:24:54 -0700
Date:   Thu, 15 Aug 2019 08:24:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] fstests: make generic/500 xfs+ext4 only
Message-ID: <20190815152425.GA15181@magnolia>
References: <20190815150033.15996-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815150033.15996-1-josef@toxicpanda.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150152
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 11:00:31AM -0400, Josef Bacik wrote:
> I recently fixed some bugs in btrfs's enospc handling that made it start
> failing generic/500.
> 
> The point of this test is to make the thin provisioned device run out of
> space, which results in an EIO being seen on a device from the file
> systems perspective.  This is fine for xfs and ext4 who's metadata is
> being overwritten and already allocated on the thin provisioned device.
> They get an EIO on data writes, fstrim to free up the space, and keep it
> going.
> 
> Btrfs however has dynamic metadata, so the rm -rf could result in
> metadata IO being done on the file system.  Since the thin provisioned
> device is out of space this gives us an EIO, and we flip read only.  We
> didn't remove the file, so the fstrim doesn't recover space anyway, so
> we can't even fstrim and remount.
> 
> Make this test for ext4/xfs only, it just simply won't work right for
> btrfs in it's current form.

How about:

test $FSTYP = "btrfs" && _notrun "btrfs doesn't work that way lol"

since afaik btrfs is the only fs that shouldn't run this test?
Also, I think Ted was trying to kill off tests/shared/...

--D

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/generic/500 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/500 b/tests/generic/500
> index 201d8b9f..1cbd9d65 100755
> --- a/tests/generic/500
> +++ b/tests/generic/500
> @@ -44,7 +44,7 @@ _cleanup()
>  rm -f $seqres.full
>  
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs xfs ext4
>  _supported_os Linux
>  _require_scratch_nocheck
>  _require_dm_target thin-pool
> -- 
> 2.21.0
> 
