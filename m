Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B76E13696F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 10:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgAJJOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 04:14:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48040 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgAJJOX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 04:14:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A9DGPR004818;
        Fri, 10 Jan 2020 09:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=BI76oBg7CTKePu5KfZhXAvNSxNcFF8BfPHLFY2Kwy/w=;
 b=ZAzDjXx0RkaUfnYhaiBsY340re+SflUk+hwi5wGuPxwATamYqg8PIoIZFKP7SNQc4xTl
 0enWiSUUTZjpILVfnNNmk7sepsa2H6UUNCAI10WlrVJRKQoJwSHEKtHldYgoSEaAz4PP
 Yfz4ahKw1DyFgsB2/+Yq8NzReZFu+Lsyxb8HEudqCY0JMPRmO1X2J9E6k2fySZKHUPNH
 ZnWcNxkxcVEPZhZGkSHUHU5narnBVfB00g5Il58tKybtp7rANKjTdR2+wp0CoXLgZHEb
 hlutdAkUFohrkCJ1aqSWAYN2eOkmLax3Sf4tUqQYQloSZ3ObrNJrsvL+Mh5qoCJnyF4v /w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xajnqgq7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 09:14:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A9E53v031338;
        Fri, 10 Jan 2020 09:14:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xenn8y3wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 09:14:13 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00A9De7d003418;
        Fri, 10 Jan 2020 09:13:40 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jan 2020 01:13:40 -0800
Subject: Re: [PATCH] btrfs: Fix error code in btrfs_sysfs_add_mounted()
To:     Dan Carpenter <dan.carpenter@oracle.com>, Chris Mason <clm@fb.com>,
        Dennis Zhou <dennis@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200110055126.4rhhfsotll6puma7@kili.mountain>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b5d47473-8dc1-6780-a774-95fa9a5bf8ee@oracle.com>
Date:   Fri, 10 Jan 2020 17:13:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200110055126.4rhhfsotll6puma7@kili.mountain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100078
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/1/20 1:51 PM, Dan Carpenter wrote:
> The error code wasn't set on this error path.
 >
> Fixes: e12ebce8a4a8 ("btrfs: sysfs: make UUID/debug have its own kobject")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   fs/btrfs/sysfs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 58486229be95..55e4ed1af29c 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1288,8 +1288,10 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
>   
>   #ifdef CONFIG_BTRFS_DEBUG
>   	fs_info->debug_kobj = kobject_create_and_add("debug", fsid_kobj);
> -	if (!fs_info->debug_kobj)
> +	if (!fs_info->debug_kobj) {
> +		error = -ENOMEM;


  uh-oh right.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

>   		goto failure;
> +	}
>   
>   	error = sysfs_create_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
>   	if (error)
> 
