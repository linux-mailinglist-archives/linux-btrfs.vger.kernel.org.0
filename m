Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B011AB5E68
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfIRHy7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 03:54:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54794 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfIRHy7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 03:54:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8I7sA4K108521;
        Wed, 18 Sep 2019 07:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Y0IidVLuhLFe3mZhQNw3oryiKnlBP93UeCDfVDdDFfs=;
 b=i53/HqRS0xvdaw93/GWgQPZ5OInOAf5TRid43kg85GncadrAn9Zd2muJYqd+PVOrarCq
 8CaUczUiN8RbF/DtdRpptT85mQpKZB6Qw3y208PYCR0piqrDWtb4g5AygXaSr+F3cId6
 nVvR/7T+TY/9DSpPN9UvDyOpSCtfN091ml79d+Gm/G0P6lOfdoV2LcQlBgc68H8XZY08
 PHiKATvOIlGGR1bBzJGoiWsl2wXC5kfqdPW23Y8aWZROsbyIxYvYxeflCEYe7trOOAyc
 5CXQw8KTz+87/q7TzYnNdSuRqcT6RuWfDcek5j3IT3f2Js2+Rxlxs6TkRzMfcikilyaG Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v385e1yjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 07:54:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8I7sAG0147937;
        Wed, 18 Sep 2019 07:54:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2v37m9s5v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 07:54:54 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8I7srYa014555;
        Wed, 18 Sep 2019 07:54:53 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 00:54:53 -0700
Subject: Re: [PATCH 2/2] fstests: btrfs/011: Handle finished scrub/replace
 operation gracefully
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190918065626.34902-1-wqu@suse.com>
 <20190918065626.34902-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2b6c6153-d4e0-f776-2c7c-4aa4c6331b39@oracle.com>
Date:   Wed, 18 Sep 2019 15:54:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190918065626.34902-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180084
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/9/19 2:56 PM, Qu Wenruo wrote:
> [BUG]
> When btrfs/011 is executed on a fast enough system (fully memory backed
> VM, with test device has unsafe cache mode), the test can fail like
> this:
> 
>    btrfs/011 43s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests-dev/results//btrfs/011.out.bad)
>      --- tests/btrfs/011.out     2019-07-22 14:13:44.643333326 +0800
>      +++ /home/adam/xfstests-dev/results//btrfs/011.out.bad      2019-09-18 14:49:28.308798022 +0800
>      @@ -1,3 +1,4 @@
>       QA output created by 011
>       *** test btrfs replace
>      -*** done
>      +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>      +(see /home/adam/xfstests-dev/results//btrfs/011.full for details)
>      ...
> 
> [CAUSE]
> Looking into the full output, it shows:
>    ...
>    Replace from /dev/mapper/test-scratch1 to /dev/mapper/test-scratch2
> 
>    # /usr/bin/btrfs replace start -f /dev/mapper/test-scratch1 /dev/mapper/test-scratch2 /mnt/scratch
>    # /usr/bin/btrfs replace cancel /mnt/scratch
>    INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not started
>    failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
> 
> So this means the replace is already finished before we cancel it.
> For fast system, it's very common.
> 
> [FIX]
> Instead of using _run_btrfs_util_prog which requires 0 as return value,
> we just call "$BTRFS_UTIL_PROG replace cancel" and ignore all its
> stderr/stdout, and completely rely on "$BTRFS_UTIL_PROG replace status"
> output to verify the work.
> 
> Furthermore if we finished replac before cancelling it, we should
> replace again to switch the device back, or after the test case, btrfs
> check will fail as there is no valid btrfs on that replaced device.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/011 | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 89bb4d11..858b00e8 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -148,13 +148,25 @@ btrfs_replace_test()
>   		# background the replace operation (no '-B' option given)
>   		_run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
>   		sleep 1
> -		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
> +		# 1s is enough for fast system to finish replace, so here we
> +		# ignore all the output, completely rely on later status
> +		# output to determine
> +		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT &> /dev/null
>   
>   		# 'replace status' waits for the replace operation to finish
>   		# before the status is printed
>   		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
>   		cat $tmp.tmp >> $seqres.full
> -		grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled) failed"
> +		grep -q -e canceled -e finished $tmp.tmp ||\
> +			_fail "btrfs replace status (canceled) failed"
> +
> +		# If replace finished before cancel, replace them back or
> +		# the final fsck after test case will fail as there is no btrfs
> +		# on the $source_dev anymore
> +		if grep -q -e finished $tmp.tmp ; then
> +			$BTRFS_UTIL_PROG replace start -Bf $replace_options \
> +				$target_dev $source_dev $SCRATCH_MNT
> +		fi
>   	else
>   		if [ "${quick}Q" = "thoroughQ" ]; then
>   			# On current hardware, the thorough test runs
> 

Faced the same problem before. But I don't have a good solution
to fix. Because the idea of the test case appears to test the replace
cancel. This change makes it not to error if replace is not running
in the first place.

Thanks, Anand

