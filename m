Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B596A232B20
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 07:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgG3FDw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 01:03:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44326 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgG3FDw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 01:03:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U52unV122630;
        Thu, 30 Jul 2020 05:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gGbkGF8RUw4BWHwfj49dvlXrhViERkgyTCXlOgKL1qk=;
 b=To4ufyS6/kqchba+TJ+Zif9WIaXD7q2cOOyyP5MoLzRjMqorfcZxP+UEs5sq3yRBGvFU
 mcXbNhmihau1b7WMl27TIKifeAUultSS3ApZxj3vy32bfFjEAALqUp2VX+WW4qoSnnpN
 wC9c/uU0z3Y0dqbYYv5C/NbgaY3+j48/TsVeWAJ8N2SRlbJKXwwU58A/6g9LMeopZ2jb
 570dXs9ajiGW6TzkW9mXzmXDC5mhpX8sb6fYEISCKQpaHKY5BeVUKt7SIlfwNd0AWjfo
 Sjw5bodAK3Yqp3voFBgF7ssLgZumGuQm6+4l4b1KO0nAfcQ77enao6kRK6RMzx2SEpRL Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32hu1jhgth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 05:03:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U4qXvt133361;
        Thu, 30 Jul 2020 05:01:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32hu5yx1fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 05:01:46 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06U51jZ8010611;
        Thu, 30 Jul 2020 05:01:45 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 22:01:45 -0700
Subject: Re: [PATCH 3/4] btrfs: Remove redundant code from
 btrfs_free_stale_devices
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200722080925.6802-1-nborisov@suse.com>
 <20200722080925.6802-4-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <59efd39e-6d19-2d7e-00f9-d9b86a9b57cf@oracle.com>
Date:   Thu, 30 Jul 2020 13:01:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200722080925.6802-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=2 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300037
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/7/20 4:09 pm, Nikolay Borisov wrote:
> Following the refactor of btrfs_free_stale_devices in
> 7bcb8164ad94 ("btrfs: use device_list_mutex when removing stale devices")
> fs_devices are freed after they have been iterated by the inner
> list_for_each so the UAF fixed by introducing the break in
> fd649f10c3d2 ("btrfs: Fix use-after-free when cleaning up fs_devs with
> a single stale device") is no longer necessary. Just remove it
> altogether. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/volumes.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 384614fe0e2a..17047c118969 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -588,8 +588,6 @@ static int btrfs_free_stale_devices(const char *path,
>   			btrfs_free_device(device);
>   
>   			ret = 0;
> -			if (fs_devices->num_devices == 0)
> -				break;
>   		}
>   		mutex_unlock(&fs_devices->device_list_mutex);
>   
> 


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
