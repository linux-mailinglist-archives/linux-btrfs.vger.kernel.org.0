Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9BFC50A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 12:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKNLGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 06:06:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37308 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNLGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 06:06:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEAx5Dc092517;
        Thu, 14 Nov 2019 11:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=sSxj68u7urGwbuRtzLBOcWWmWbjqtnpHdfT/P1A1Yq8=;
 b=Wwgoc/7lRTGsukXaqZAiCVhJwHPcgjoGAB6bokGC+N7D1E0OX5k3fh/NJyjiwGBhovsD
 Ls6kckGxj+DYcbKI3bofU/aD2zSz6RDcW6rGGoKW25VYUILe/Z0LD2SWNWX28U2wY2eB
 lxXRkiXnawfw/jcyI9F4ROYtar4EaTVB6Rx5HYvdPbZDh/vuWEr6FrN2R4KOs3pSWIAn
 rxf4Pc+XhAaMR/rTOUO9kE+PqJGaN5Qxl/EQbpAaQKVIdDytPwfWgzbpzqyUDG5XdSZ7
 +jKSon0RTXnYKNzG3uqgciTCZUiaEEFEMkFwds49t1b1XZNW9ldnVXYEqnNQBiioNReR Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w5ndqjfbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 11:05:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEB46kf164502;
        Thu, 14 Nov 2019 11:05:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w8g196s2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 11:05:26 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEB5Ppa025789;
        Thu, 14 Nov 2019 11:05:26 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 03:05:25 -0800
Subject: Re: [PATCH v2 7/7] btrfs: change btrfs_fs_devices::rotating to bool
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191113102728.8835-1-jthumshirn@suse.de>
 <20191113102728.8835-8-jthumshirn@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <59723058-f694-d6e2-b2b2-baf02fcbc7c9@oracle.com>
Date:   Thu, 14 Nov 2019 19:05:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191113102728.8835-8-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140103
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/11/19 6:27 PM, Johannes Thumshirn wrote:
> struct btrfs_fs_devices::rotating currently is declared as an integer
> variable but only used as a boolean.
> 
> Change the variable definition to bool and update to code touching it to
> set 'true' and 'false'.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> ---
>   fs/btrfs/volumes.c | 6 +++---
>   fs/btrfs/volumes.h | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ce9c6fa3a32c..6d3bfea2e2d5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -644,7 +644,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   
>   	q = bdev_get_queue(bdev);
>   	if (!blk_queue_nonrot(q))
> -		fs_devices->rotating = 1;
> +		fs_devices->rotating = true;
>   
>   	device->bdev = bdev;
>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
> @@ -2301,7 +2301,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	fs_devices->num_devices = 0;
>   	fs_devices->open_devices = 0;
>   	fs_devices->missing_devices = 0;
> -	fs_devices->rotating = 0;
> +	fs_devices->rotating = false;
>   	fs_devices->seed = seed_devices;
>   
>   	generate_random_uuid(fs_devices->fsid);
> @@ -2496,7 +2496,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
>   
>   	if (!blk_queue_nonrot(q))
> -		fs_devices->rotating = 1;
> +		fs_devices->rotating = true;
>   
>   	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
>   	btrfs_set_super_total_bytes(fs_info->super_copy,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 8e9513b3fe9d..fc1b564b9cfe 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -250,7 +250,7 @@ struct btrfs_fs_devices {
>   	/* set when we find or add a device that doesn't have the
>   	 * nonrot flag set
>   	 */
> -	int rotating;
> +	bool rotating;
>   
>   	struct btrfs_fs_info *fs_info;
>   	/* sysfs kobjects */
> 

