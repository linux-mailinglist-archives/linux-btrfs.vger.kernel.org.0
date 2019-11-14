Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E45FC501
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 12:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKNLEW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 06:04:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49772 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfKNLEW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 06:04:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEAx7Qk073191;
        Thu, 14 Nov 2019 11:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=CH/BBMKDNg88JY97N0DNMNOYJ8LbyVnitAmDTwPKlj0=;
 b=rDFJ/dCNY2Z9uxWWQTw+Mlr3CiX6Yj/ISzAT/Lwduu6NRms29gbu4gDjBg78PJ8iXSQo
 /iM8bEMm5PfdS7UWIydZn7poLeE0/eY689eiVrTaFLFQQy7DR97j4PgABfsXGTaOMrXY
 5JtONDMy1VmnKGOlAnMEdwHUDVysRGO8Wytcq1mBfvfjE0X+ZhBbfx3TdKcss4HQKyha
 jy7h5i1FIz2+mgWTOnmO3qUl6NMHScMEPLq6tLEisCBIiundniy0ScNcvbjr6+M6/XLF
 gc6p1+gFz05GkbEDpvfkiXtljZ9f0yRaSQMoQ5YKLHlZA8LlORydH1bvWl4Krkb3+3yt fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w5p3r2bg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 11:03:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEAwF4V068730;
        Thu, 14 Nov 2019 11:00:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2w8v35gssb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 11:00:59 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEB0wJb022918;
        Thu, 14 Nov 2019 11:00:58 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 03:00:58 -0800
Subject: Re: [PATCH v2 3/7] btrfs: handle allocation failure in strdup
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191113102728.8835-1-jthumshirn@suse.de>
 <20191113102728.8835-4-jthumshirn@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3c492c97-0c41-a4b1-5687-6b9ccf40cf67@oracle.com>
Date:   Thu, 14 Nov 2019 19:00:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191113102728.8835-4-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140102
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
> Gracefully handle allocation failures in btrfs_close_one_device()'s
> rcu_string_strdup() instead of crashing the machine.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   fs/btrfs/volumes.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0a2a73907563..e5864ca3bb3b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1064,7 +1064,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
>   static int btrfs_close_one_device(struct btrfs_device *device)
>   {
>   	struct btrfs_fs_devices *fs_devices = device->fs_devices;
> -	struct btrfs_device *new_device;
> +	struct btrfs_device *new_device = NULL;
>   	struct rcu_string *name;
>   
>   	new_device = btrfs_alloc_device(NULL, &device->devid,
> @@ -1072,6 +1072,15 @@ static int btrfs_close_one_device(struct btrfs_device *device)
>   	if (IS_ERR(new_device))
>   		goto err_close_device;
>   
> +	/* Safe because we are under uuid_mutex */
> +	if (device->name) {
> +		name = rcu_string_strdup(device->name->str, GFP_NOFS);
> +		if (!name)
> +			goto err_free_device;
> +
> +		rcu_assign_pointer(new_device->name, name);
> +	}
> +


  Any idea why do we need to strdup() at all to close a device?

Thanks, Anand


>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>   	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
>   		list_del_init(&device->dev_alloc_list);
> @@ -1085,13 +1094,6 @@ static int btrfs_close_one_device(struct btrfs_device *device)
>   	if (device->bdev)
>   		fs_devices->open_devices--;
>   
> -	/* Safe because we are under uuid_mutex */
> -	if (device->name) {
> -		name = rcu_string_strdup(device->name->str, GFP_NOFS);
> -		BUG_ON(!name); /* -ENOMEM */
> -		rcu_assign_pointer(new_device->name, name);
> -	}
> -
>   	list_replace_rcu(&device->dev_list, &new_device->dev_list);
>   	new_device->fs_devices = device->fs_devices;
>   
> @@ -1100,6 +1102,10 @@ static int btrfs_close_one_device(struct btrfs_device *device)
>   
>   	return 0;
>   
> +err_free_device:
> +	if (new_device)
> +		btrfs_free_device(new_device);
> +
>   err_close_device:
>   	btrfs_close_bdev(device);
>   	if (device->bdev) {
> 

