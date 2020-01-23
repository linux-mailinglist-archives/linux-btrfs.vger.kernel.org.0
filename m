Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B50146E16
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 17:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAWQOx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 11:14:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59056 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWQOx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 11:14:53 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NFwbd4165425;
        Thu, 23 Jan 2020 16:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Ia08TZqCyE5xBeGh+PtNz5g13L3hyjGujrDuhaKynpk=;
 b=bnvYXDYtJMeu8oG9EeJVIPTWPn/2y6Da6hkMkf3WVp3YypWzo9uOKvdUUcKloNF2tNrm
 vPcUHoVR0Nzqpz2+yOnvzx1Q2nXVeLCE3WwYAgj9YmFcqVTNlud3jxI/Ie8w2nzTL0yR
 eAPFXd5koFjqmBF8hLoc6abYdS6FkOUKg2gZmr+q7VLJdi5jMvocPEa5dWaFO3XT3fXu
 v0Z8zi591drv/Xn+HLA0uyvWdqcRxnixO7Gw/gN0n0A4Zvkg7wNXI59yA0HTdf6rOYk9
 COe7i8tqn1yonu+mPSqfhtZXw7PuGBbEScFuXXtkzuXFAotP6bWAHpBUpzQlit2iVhgk vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xksyqkauw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 16:14:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NFxGj4072138;
        Thu, 23 Jan 2020 16:14:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xpq7n36t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 16:14:45 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00NGEidL017087;
        Thu, 23 Jan 2020 16:14:44 GMT
Received: from [10.191.53.142] (/10.191.53.142)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 08:14:44 -0800
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 4/5] btrfs: do not account global reserve in
 can_overcommit
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20190822191904.13939-1-josef@toxicpanda.com>
 <20190822191904.13939-5-josef@toxicpanda.com>
Message-ID: <8b7d11d3-3f54-d090-a1c6-cb1e67b2b4f1@oracle.com>
Date:   Fri, 24 Jan 2020 00:14:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822191904.13939-5-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230130
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



This patch is causing regression in the test case generic/027
and generic/275 with MKFS_OPTIONS="-n64K" on x86_64.

Both of these tests, test FS behavior at ENOSPC.

In generic/027, it fails to delete a file with ENOSPC

      +rm: cannot remove '/mnt/scratch/testdir/6/file_1598': No space 
left on device

In generic/275, it failed to create at least 128k size file after
deleting 256k sized file. Failure may be fair taking into the cow part,
but any idea why it could be successful before this patch?

     +du: cannot access '/mnt/scratch/tmp1': No such file or directory
     +stat: cannot stat '/mnt/scratch/tmp1': No such file or directory

These fail on misc-next as well.

Thanks, Anand


On 8/23/19 3:19 AM, Josef Bacik wrote:
> We ran into a problem in production where a box with plenty of space was
> getting wedged doing ENOSPC flushing.  These boxes only had 20% of the
> disk allocated, but their metadata space + global reserve was right at
> the size of their metadata chunk.
> 
> In this case can_overcommit should be allowing allocations without
> problem, but there's logic in can_overcommit that doesn't allow us to
> overcommit if there's not enough real space to satisfy the global
> reserve.
> 
> This is for historical reasons.  Before there were only certain places
> we could allocate chunks.  We could go to commit the transaction and not
> have enough space for our pending delayed refs and such and be unable to
> allocate a new chunk.  This would result in a abort because of ENOSPC.
> This code was added to solve this problem.
> 
> However since then we've gained the ability to always be able to
> allocate a chunk.  So we can easily overcommit in these cases without
> risking a transaction abort because of ENOSPC.
> 
> Also prior to now the global reserve really would be used because that's
> the space we relied on for delayed refs.  With delayed refs being
> tracked separately we no longer have to worry about running out of
> delayed refs space while committing.  We are much less likely to
> exhaust our global reserve space during transaction commit.
> 
> Fix the can_overcommit code to simply see if our current usage + what we
> want is less than our current free space plus whatever slack space we
> have in the disk is.  This solves the problem we were seeing in
> production and keeps us from flushing as aggressively as we approach our
> actual metadata size usage.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/space-info.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index a43f6287074b..3053b3e91b34 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -165,9 +165,7 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
>   			  enum btrfs_reserve_flush_enum flush,
>   			  bool system_chunk)
>   {
> -	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
>   	u64 profile;
> -	u64 space_size;
>   	u64 avail;
>   	u64 used;
>   	int factor;
> @@ -181,22 +179,7 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
>   	else
>   		profile = btrfs_metadata_alloc_profile(fs_info);
>   
> -	used = btrfs_space_info_used(space_info, false);
> -
> -	/*
> -	 * We only want to allow over committing if we have lots of actual space
> -	 * free, but if we don't have enough space to handle the global reserve
> -	 * space then we could end up having a real enospc problem when trying
> -	 * to allocate a chunk or some other such important allocation.
> -	 */
> -	spin_lock(&global_rsv->lock);
> -	space_size = calc_global_rsv_need_space(global_rsv);
> -	spin_unlock(&global_rsv->lock);
> -	if (used + space_size >= space_info->total_bytes)
> -		return 0;
> -
> -	used += space_info->bytes_may_use;
> -
> +	used = btrfs_space_info_used(space_info, true);
>   	avail = atomic64_read(&fs_info->free_chunk_space);
>   
>   	/*
> 

