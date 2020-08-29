Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3725688D
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgH2PPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Aug 2020 11:15:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgH2PO7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Aug 2020 11:14:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TFEkuc012707;
        Sat, 29 Aug 2020 15:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8yS3zWkotqeym/+wDZdQt5/wVnORbPnVZtDoLZTxYGI=;
 b=vYOwbrXfxQUQvLLMHUXkY1v+iuHZQ/aWRO+A6AG9Dh6nG8PI0cC1rmXf08LiDitquoST
 Zhz3tkMFre5byZcLgQCJeJyMhTYjQUBmW+17y9Rcqc4VZzgAW7c9cBAbj06MCsNZwhuj
 jQTQzbUKURWfujN0NfH7rhgif6y7p4ruAqOgOajyrB1QJVBr2NgGlElnRtyQGfT0S0Jo
 BENGEf3JVAjhn0soqNg+k3USFGht/c3Gf9toiugT69OwnFM8v38iIP2+eKoCdb7EieaG
 oLE5MSwU4k3zXOkCeVzCgS/ebImN/U3uTyT5KNvf5x/gn3L6dFqj5NoN7BuJ1yrX396N fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eeqh39q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 15:14:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TF5VRc111836;
        Sat, 29 Aug 2020 15:14:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 337c4sg7m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 15:14:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07TFEss3012836;
        Sat, 29 Aug 2020 15:14:54 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Aug 2020 08:14:53 -0700
Subject: Re: [PATCH 3/5] btrfs: Make close_fs_devices return void
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-4-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a09845f6-b790-14c0-01f6-7cde8f4c29f6@oracle.com>
Date:   Sat, 29 Aug 2020 23:14:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200715104850.19071-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=2 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290124
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/7/20 6:48 pm, Nikolay Borisov wrote:
> The return value of this function conveys absolutely no information.
> All callers already check the state of  fs_devices->opened to decide
> how to proceed. So conver the function to returning void. While at it
> make btrfs_close_devices also return void.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/volumes.c | 12 ++++--------
>   fs/btrfs/volumes.h |  2 +-
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index db29fc4fbe89..6de021c78277 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1146,12 +1146,12 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>   	ASSERT(atomic_read(&device->reada_in_flight) == 0);
>   }
>   
> -static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
> +static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
>   {
>   	struct btrfs_device *device, *tmp;
>   
>   	if (--fs_devices->opened > 0)
> -		return 0;
> +		return;
>   
>   	mutex_lock(&fs_devices->device_list_mutex);
>   	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
> @@ -1163,17 +1163,14 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
>   	WARN_ON(fs_devices->rw_devices);
>   	fs_devices->opened = 0;
>   	fs_devices->seeding = false;
> -
> -	return 0;
>   }
>   
> -int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
> +void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
>   {
>   	struct btrfs_fs_devices *seed_devices = NULL;
> -	int ret;
>   
>   	mutex_lock(&uuid_mutex);
> -	ret = close_fs_devices(fs_devices);
> +	close_fs_devices(fs_devices);
>   	if (!fs_devices->opened) {
>   		seed_devices = fs_devices->seed;
>   		fs_devices->seed = NULL;
> @@ -1186,7 +1183,6 @@ int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
>   		close_fs_devices(fs_devices);
>   		free_fs_devices(fs_devices);
>   	}
> -	return ret;
>   }
>   
>   static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5eea93916fbf..76e5470e19a8 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -435,7 +435,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   struct btrfs_device *btrfs_scan_one_device(const char *path,
>   					   fmode_t flags, void *holder);
>   int btrfs_forget_devices(const char *path);
> -int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
> +void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>   void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step);
>   void btrfs_assign_next_active_device(struct btrfs_device *device,
>   				     struct btrfs_device *this_dev);
> 


Reviewed-by: Anand Jain <anand.jain@oracle.com>
