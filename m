Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6123D130
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Aug 2020 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHET5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Aug 2020 15:57:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32828 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgHEQoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Aug 2020 12:44:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075GhSjr142791;
        Wed, 5 Aug 2020 16:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=XsmSkZ5Tl9PmJSK8//epr64/sS7UNs6dSvP6iRKV/u8=;
 b=QBT5tXXfEflHAB8v9s41nOOJ+ITVR3+uBF3AShwYcklCZnQKzF3BEzmy6cPsWg7+HZQ9
 pYTMo/F2S/i7GV+nGAWlCAwEawsDsD222iemlzGN1eHWRrYs0hBnmSatuIq4PWrhM5BM
 Nkc36jDMmAxSAMNBkOyff0VNRuGIXKUSRttRsTj+Mo4bvEI8wXZjC8Ipi4/QldiILcjJ
 smxb4LXJ+ydmPi8j9uhuAJWgn/X83bj+FmEClh26TLZSJee9nYiSnDF8+66MqwMdvzEB
 hyM0eT0OlIdQXRyWVxXA7B6JlCCmcHXJpvtLMvelsfruRGpEwHQAzgZpf6A7wV+ZrIGp xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32qycpgeau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 16:43:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075GhERx155666;
        Wed, 5 Aug 2020 16:43:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32qy8kmb52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 16:43:58 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 075GhvWW028061;
        Wed, 5 Aug 2020 16:43:57 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 09:43:57 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: init device stats for seed devices
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200803192308.17977-1-josef@toxicpanda.com>
Message-ID: <ccab0e74-196c-2bb9-253e-a7a3af74cd11@oracle.com>
Date:   Thu, 6 Aug 2020 00:43:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <20200803192308.17977-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=2 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050133
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/8/20 3:23 am, Josef Bacik wrote:
> We recently started recording device stats across the fleet, and noticed
> a large increase in messages such as this
> 
> BTRFS warning (device dm-0): get dev_stats failed, not yet valid
> 
> on our tiers that use seed devices for their root devices.  This is
> because we do not initialize the device stats for any seed devices if we
> have a sprout device and mount using that sprout device.

  Thanks for spotting and the fix.

>  The basic
> steps for reproducing are
> 
> mkfs seed device
> mount seed device
> fill seed device
> umount seed device
> btrfstune -S 1 seed device
> mount seed device
> btrfs device add -f sprout device /mnt/wherever
> umount /mnt/wherever
> mount sprout device /mnt/wherever
> btrfs device stats /mnt/wherever
> 
> This will fail with the above message in dmesg.
> 
> Fix this by iterating over the fs_devices->seed if they exist in
> btrfs_init_dev_stats.  This fixed the problem and properly reports the
> stats for both devices.
> 

  Also btrfs_run_dev_stats() should be updated to write seed's dev stat
  to ondisk.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d7670e2a9f39..dab295880117 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7225,7 +7225,7 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
>   	path = btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
> -
> +again:
>   	mutex_lock(&fs_devices->device_list_mutex);
>   	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>   		int item_size;
> @@ -7263,6 +7263,12 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
>   	}
>   	mutex_unlock(&fs_devices->device_list_mutex);

  As we loop through the seed fs_devices. %fs_devices which was
  pointing to the sprout fs_devices above, shall point to the seed
  fs_devices and so will be holding the seed::device_list_mutex. But
  our threads which update the seed device such as replace and delete
  are using the sprout::device_list_mutex.

  So it should be sprout::device_list_mutex
  (fs_info->fs_devices->device_list_mutex).

  The loops in btrfs_init_devices_late() and __reada_start_machine()
  which are read only, also holds the seed device_list_mutex, I am
  sending a patch to fix, after which there isn't any thread which
  shall be holding the seed::device_list_mutex when sprout is mounted.

Thanks, Anand


>   
> +	/* If we have seed devices we need to init those stats as well. */
> +	if (fs_devices->seed) {
> +		fs_devices = fs_devices->seed;
> +		goto again;
> +	}
> +
>   	btrfs_free_path(path);
>   	return ret < 0 ? ret : 0;
>   }
> 

