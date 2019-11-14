Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0F2FC503
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 12:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfKNLGN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 06:06:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNLGM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 06:06:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEAx9U9101735;
        Thu, 14 Nov 2019 11:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=K1PboHMvJ8SP0xGiDyrbYWE9AHsm9ovpll7ZgK/ksg0=;
 b=TvRq4hmhY6gz1bqI4h0DTqWUgBz5bV0DYc+dSIDOfW+y/kGo4tPiAUP7JsCjGv/ZAkvm
 wBP2gUdNL0dw7vBSo0OYJds1Nj9Z5ixTG/lTmTpkC2SE/39QJrvXmEHVRpx7tUZ5W2gQ
 4vloQUcK5TaviDtoj6IgO+9uAO+5X73zlGGIyi82w1ZuzmA8NF1ZGbenm5UuwaC42xum
 0ZsLgUkihsOHZmLCsEl1xplEdY7BsdAXdJOSOuQRkWUuS5rshl0WVkl+yQYibFOMCvII
 wRJ3CpSLzsz3kv9MV3NnifexI86ypyaOYB5IddX3M/5+udp+jXnfq6oHbi1U3PoOk4Oh YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w5mvu2g10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 11:04:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEB48e0164722;
        Thu, 14 Nov 2019 11:04:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w8g196qpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 11:04:45 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEB4i7c025223;
        Thu, 14 Nov 2019 11:04:44 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 03:04:44 -0800
Subject: Re: [PATCH v2 6/7] btrfs: change btrfs_fs_devices::seeing to bool
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191113102728.8835-1-jthumshirn@suse.de>
 <20191113102728.8835-7-jthumshirn@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <33e3bc42-9ed1-613b-73ba-9f163116a793@oracle.com>
Date:   Thu, 14 Nov 2019 19:04:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191113102728.8835-7-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140103
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/11/19 6:27 PM, Johannes Thumshirn wrote:
> struct btrfs_fs_devices::seeding currently is declared as an integer
> variable but only used as a boolean.
> 
> Change the variable definition to bool and update to code touching it to
> set 'true' and 'false'.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Nit:
Re: [PATCH v2 6/7] btrfs: change btrfs_fs_devices::seeing to bool
                                                       ^d

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> ---
>   fs/btrfs/volumes.c | 8 ++++----
>   fs/btrfs/volumes.h | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 25e4608e20f1..ce9c6fa3a32c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -634,7 +634,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   		}
>   
>   		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> -		fs_devices->seeding = 1;
> +		fs_devices->seeding = true;
>   	} else {
>   		if (bdev_read_only(bdev))
>   			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> @@ -1139,7 +1139,7 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
>   	WARN_ON(fs_devices->open_devices);
>   	WARN_ON(fs_devices->rw_devices);
>   	fs_devices->opened = 0;
> -	fs_devices->seeding = 0;
> +	fs_devices->seeding = false;
>   
>   	return 0;
>   }
> @@ -2297,7 +2297,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	list_splice_init(&fs_devices->alloc_list, &seed_devices->alloc_list);
>   	mutex_unlock(&fs_info->chunk_mutex);
>   
> -	fs_devices->seeding = 0;
> +	fs_devices->seeding = false;
>   	fs_devices->num_devices = 0;
>   	fs_devices->open_devices = 0;
>   	fs_devices->missing_devices = 0;
> @@ -6681,7 +6681,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>   		if (IS_ERR(fs_devices))
>   			return fs_devices;
>   
> -		fs_devices->seeding = 1;
> +		fs_devices->seeding = true;
>   		fs_devices->opened = 1;
>   		return fs_devices;
>   	}
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 46987a2da786..8e9513b3fe9d 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -243,7 +243,7 @@ struct btrfs_fs_devices {
>   	struct list_head alloc_list;
>   
>   	struct btrfs_fs_devices *seed;
> -	int seeding;
> +	bool seeding;
>   
>   	int opened;
>   
> 

