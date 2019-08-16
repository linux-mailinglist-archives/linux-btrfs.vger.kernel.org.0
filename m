Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E058F8C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 04:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfHPCQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 22:16:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57778 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHPCQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 22:16:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G2E03T072309;
        Fri, 16 Aug 2019 02:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=5zGxCaY2q+Jg4s901FEPuVa15/+cH22cogU/E1G7Ufo=;
 b=fsikMhdIMsm6hUZ8jnZm55xQt5KbKP5FiNi5KUzR6VIb3ePQvM/Mj8PivOhG37cSqF1n
 5S5Y5k9sgG1RteLglUIJ+GnA/Z/xN4SmszuiIE7/ShnwYxc/7s76WT18BVk4yXEcaB1h
 FM5zMYKVmPNzK/lxVmwmKaTNyZzDNgi9rMJ/KSMToa6el8fR48lSQTzi3cKvoMEHaIxW
 V3Q6y2hM2xTvF8K3qFGkdGebTeddQQF9lOS836VYTY4D8OWfB3XBViCxnalPYYReEQrx
 thExm8ycRD8RC3toVrrAllxFhqQf742YxoWJZsM0pw4DGmFM4RyaNEdqRyQIhZia9ZBk qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u9pjqwu2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 02:16:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G2Dl2c116951;
        Fri, 16 Aug 2019 02:16:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2udgqfkqwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 02:16:36 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7G2GYTP019517;
        Fri, 16 Aug 2019 02:16:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 19:16:34 -0700
Date:   Thu, 15 Aug 2019 19:16:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fstests: generic/500 doesn't work for btrfs
Message-ID: <20190816021633.GB15181@magnolia>
References: <20190815182659.27875-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815182659.27875-1-josef@toxicpanda.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160022
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:26:59PM -0400, Josef Bacik wrote:
> Btrfs does COW, so when we unlink the file we need to update metadata
> and write it to a new location, which we can't do because the thinp is
> full.  This results in an EIO during a metadata write, which makes us
> flip read only, thus making it impossible to fstrim the fs.  Just make
> it so we skip this test for btrfs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/generic/500 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/generic/500 b/tests/generic/500
> index 201d8b9f..5cd7126f 100755
> --- a/tests/generic/500
> +++ b/tests/generic/500
> @@ -49,6 +49,12 @@ _supported_os Linux
>  _require_scratch_nocheck
>  _require_dm_target thin-pool
>  
> +# The unlink below will result in new metadata blocks for btrfs because of CoW,
> +# and since we've filled the thinp device it'll return EIO, which will make
> +# btrfs flip read only, making it fail this test when it just won't work right
> +# for us in the first place.
> +test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"

I did it for the lulz,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> +
>  # Require underlying device support discard
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> -- 
> 2.21.0
> 
