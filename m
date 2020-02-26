Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8CD16F686
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 05:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgBZEfv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 23:35:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53356 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgBZEfu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 23:35:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01Q4YFcB073783;
        Wed, 26 Feb 2020 04:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Epowt9oTJcjfobPgsn5jWBGakvQXsZQ60yHqI54EYj0=;
 b=PA6FBuRZQpYiONdepDzR9OWBP+54erMysrlnfQcxnWa+syD4ryQ/FnBJsNg2Fpe+BKxz
 YhVZoPNWlARKS5Ck/sqAdmnBDYKupkkIZaEDBY7CxsWUFU8SPFxqKw/2949kVig92Hdw
 p2Zr0yopqPt/N3WmZ6lVe3nghNeI5ddTdIsey+l/IxgRIMxY5P7wQwS9+8Al6InrolUa
 v64lYpY0MZPsu3KE78RXd8AB2kpE3dzpfLbrahM0I7CLAW+wxhVgDemPMHSFg0QVCdDY
 bUfeQAJv9eXbFV4zD1t7L4Ih+ZlhC7yk6wbLvnvv9F8F1dEB4/4Vx+IcKXxFrYMwKGOg eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ydcsrgxgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 04:35:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01Q4Wjvd192515;
        Wed, 26 Feb 2020 04:35:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ydcs12c67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 04:35:45 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01Q4Ziw7025767;
        Wed, 26 Feb 2020 04:35:44 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Feb 2020 20:35:44 -0800
Subject: Re: [PATCH] btrfs: don't force read-only after error in drop snapshot
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200225140553.24849-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7660846a-43ed-c218-68c6-fd330e3ff2d1@oracle.com>
Date:   Wed, 26 Feb 2020 12:35:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200225140553.24849-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260032
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/2/20 10:05 PM, David Sterba wrote:
> Deleting a subvolume on a full filesystem leads to ENOSPC followed by a
> forced read-only. This is not a transaction abort and the filesystem is
> otherwise ok, so the error should be just propagated.

yep.

> This is caused by unnecessary call to btrfs_handle_fs_error for almost
> all errors, except EAGAIN. This does not make sense as the standard
> transaction abort mechanism is in btrfs_drop_snapshot so all relevant
> failures are handled.
> 
> Originally in commit cb1b69f4508a ("Btrfs: forced readonly when
> btrfs_drop_snapshot() fails") there was no return value at all, so the
> btrfs_std_error made some sense but once the error handling and
> propagation has been we don't need it.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> The use of btrfs_handle_fs_error in other places looks fishy, it makes
> sense only in case there's a real error and transaction abort is not
> possible, ~40 calls sound too much.
> 
>   fs/btrfs/extent-tree.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 161274118853..b18db1b3a412 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5426,8 +5426,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
>   	 */
>   	if (!for_reloc && !root_dropped)
>   		btrfs_add_dead_root(root);
> -	if (err && err != -EAGAIN)
> -		btrfs_handle_fs_error(fs_info, err, NULL);
>   	return err;
>   }

However can we confirm that the error returned here are logged by its 
parents (relocation thread and the cleaner thread) ?

Thanks, Anand





