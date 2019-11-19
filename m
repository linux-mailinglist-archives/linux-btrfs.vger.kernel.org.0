Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB3102193
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 11:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKSKE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 05:04:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59764 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfKSKE5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 05:04:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ9xD56145342;
        Tue, 19 Nov 2019 10:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=X3TS48A8fFR+Nth4jBzbo+X+ecNZIRbOLj2uD5W3kZc=;
 b=m33EDFeVrbN9jwEEGtKjQyLo/Zz50cgqbXEHUxlxY4WMBg2nqlriCcvrvAB/+tM8xw9a
 OabKV8j+AqKythywLv9ZnGq5x7sx3uAf8nyjpoLxJnLzBuXp0axdfwBZvmWpYzA2hX9D
 Xdg4333jBTFz0ncOROiknlDvxo881Bb2tkJoYCUR7YWJfxoJBWNllcRbD0O/q/mlobqZ
 xm4GoLbovllQkJbVS3PxrKSsNrr9jCfjhAL5aZSo7bZ4RMjtgtgoCRsCGaioNjAZ6xfV
 MdswhIwCFlZR/xRtI741THRunvSHc1YpkQiluEawYstbh0WsFlQONS/rOKSXGm12lDrk +A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wa92pnt90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 10:03:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ9xDBu052349;
        Tue, 19 Nov 2019 10:03:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wbxm4164e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 10:03:38 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJA3aOC014139;
        Tue, 19 Nov 2019 10:03:37 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 02:03:36 -0800
Subject: Re: [PATCH 2/3] btrfs: volumes: Add btrfs_fs_devices::missing_list to
 collect missing devices
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <cf9c85fd-4d9f-43be-049c-a5694c0a25e1@oracle.com>
Date:   Tue, 19 Nov 2019 18:03:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191107062710.67964-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190095
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/7/19 2:27 PM, Qu Wenruo wrote:
> This enables btrfs to iterate missing devices separately, without
> iterating all fs_devices.

  IMO.
  We don't need another list to maintain the missing device. We already
  have good enough device lists.
  The way its been implemented is
  Allo_list is the only list from which we shall alloc the chunks.
  Missing is a state of the device.
  A device in the alloc list can be in the Missing state.

  If there is missing_list that means the device in the missing list
  is also possible candidate for the alloc that's messy.
  Also its not typical to have a larger number of missing devices
  to constitute its own list.

Thanks, Anand


> This provides the basis for later degraded chunk enhancement.
> 
> The change includes:
> - Add missing devices to btrfs_fs_devices::missing_list
>    This happens at add_missing_dev() and other locations where
>    missing_devices get increased.
> 
> - Remove missing devices from btrfs_fs_devices::missing_list
>    This needs to cover all locations where missing_devices get decreased.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/volumes.c | 27 +++++++++++++++++++++------
>   fs/btrfs/volumes.h |  6 ++++++
>   2 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index eee5fc1d11f0..a462d8de5d2a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -324,6 +324,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
>   
>   	INIT_LIST_HEAD(&fs_devs->devices);
>   	INIT_LIST_HEAD(&fs_devs->alloc_list);
> +	INIT_LIST_HEAD(&fs_devs->missing_list);
>   	INIT_LIST_HEAD(&fs_devs->fs_list);
>   	if (fsid)
>   		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
> @@ -1089,6 +1090,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
>   			fs_devices->missing_devices--;
>   			clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
> +			list_del_init(&device->dev_alloc_list);
>   		}
>   	}
>   
> @@ -1250,11 +1252,10 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>   	if (device->bdev)
>   		fs_devices->open_devices--;
>   
> +	list_del_init(&device->dev_alloc_list);
>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
> -	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> -		list_del_init(&device->dev_alloc_list);
> +	    device->devid != BTRFS_DEV_REPLACE_DEVID)
>   		fs_devices->rw_devices--;
> -	}
>   
>   	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>   		fs_devices->missing_devices--;
> @@ -2140,6 +2141,12 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   		device->fs_devices->rw_devices--;
>   		mutex_unlock(&fs_info->chunk_mutex);
>   	}
> +	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
> +		mutex_lock(&fs_info->chunk_mutex);
> +		list_del_init(&device->dev_alloc_list);
> +		device->fs_devices->missing_devices--;
> +		mutex_unlock(&fs_info->chunk_mutex);
> +	}
>   
>   	mutex_unlock(&uuid_mutex);
>   	ret = btrfs_shrink_device(device, 0);
> @@ -2184,9 +2191,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	if (cur_devices != fs_devices)
>   		fs_devices->total_devices--;
>   
> -	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
> -		cur_devices->missing_devices--;
> -
>   	btrfs_assign_next_active_device(device, NULL);
>   
>   	if (device->bdev) {
> @@ -2236,6 +2240,13 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   		device->fs_devices->rw_devices++;
>   		mutex_unlock(&fs_info->chunk_mutex);
>   	}
> +	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
> +		mutex_lock(&fs_info->chunk_mutex);
> +		list_add(&device->dev_alloc_list,
> +			 &fs_devices->missing_list);
> +		device->fs_devices->missing_devices++;
> +		mutex_unlock(&fs_info->chunk_mutex);
> +	}
>   	goto out;
>   }
>   
> @@ -2438,6 +2449,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	seed_devices->opened = 1;
>   	INIT_LIST_HEAD(&seed_devices->devices);
>   	INIT_LIST_HEAD(&seed_devices->alloc_list);
> +	INIT_LIST_HEAD(&seed_devices->missing_list);
>   	mutex_init(&seed_devices->device_list_mutex);
>   
>   	mutex_lock(&fs_devices->device_list_mutex);
> @@ -6640,6 +6652,7 @@ static struct btrfs_device *add_missing_dev(struct btrfs_fs_devices *fs_devices,
>   	fs_devices->num_devices++;
>   
>   	set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
> +	list_add(&device->dev_alloc_list, &fs_devices->missing_list);
>   	fs_devices->missing_devices++;
>   
>   	return device;
> @@ -6979,6 +6992,7 @@ static int read_one_dev(struct extent_buffer *leaf,
>   			 */
>   			device->fs_devices->missing_devices++;
>   			set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
> +			list_add(&device->dev_alloc_list, &fs_devices->missing_list);
>   		}
>   
>   		/* Move the device to its own fs_devices */
> @@ -6992,6 +7006,7 @@ static int read_one_dev(struct extent_buffer *leaf,
>   
>   			device->fs_devices->missing_devices--;
>   			fs_devices->missing_devices++;
> +			list_move(&device->dev_alloc_list, &fs_devices->missing_list);
>   
>   			device->fs_devices = fs_devices;
>   		}
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index a7da1f3e3627..9cef4dc4b5be 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -253,6 +253,12 @@ struct btrfs_fs_devices {
>   	 */
>   	struct list_head alloc_list;
>   
> +	/*
> +	 * Devices which can't be found. Projected by chunk_mutex.
> +	 * This acts as a fallback allocation list for certain degraded mount.
> +	 */
> +	struct list_head missing_list;
> +
>   	struct btrfs_fs_devices *seed;
>   	int seeding;
>   
> 

