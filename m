Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC61021AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 11:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfKSKIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 05:08:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57338 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfKSKIf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 05:08:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ9wxWb156836;
        Tue, 19 Nov 2019 10:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=0E5/MkzsTCKQEnVyaV8wWx3jnkBAomGp6YS/8zNxv6M=;
 b=i8z3NkxDZqxa76trmhr5hc6SDSV7WxuzDL47HfrwsyEYDti2L/LVGL82HHBujLe0/Odw
 JjB0D7o08fBNCUGub/cgVbe/TZA2qLtZCL3i1KJ2t0bm1Ftx/lg7qJaO9aXdh4pvqj+c
 pZvD+NFbq6lroYguQEUQ1+X63ID1xyw1aJuMcbGstj/xSa+XazLF2wrlL2FXs6TwQ28L
 SdBZcoPrLsrXSRaN7SL1/cvjh8yaxLryOUeeeltrhqDx6IDOHJDlhDxc/N3Y704cdjUe
 F0c0REvRGyo+G4+wNZQ8/G17EzK8O01WrlCLjtagpvbwgUxawK29IzFow+MACB5Ny0dw Qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htnwah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 10:07:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ9wdTU154766;
        Tue, 19 Nov 2019 10:05:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wc09x4pmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 10:05:15 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJA5D8O011482;
        Tue, 19 Nov 2019 10:05:14 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 02:05:13 -0800
Subject: Re: [PATCH 3/3] btrfs: volumes: Allocate degraded chunks if rw
 devices can't fullfil a chunk
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-4-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6cc25dbd-55e4-43bb-7b95-86c62bee27c7@oracle.com>
Date:   Tue, 19 Nov 2019 18:05:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191107062710.67964-4-wqu@suse.com>
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
> [PROBLEM]
> Btrfs degraded mount will fallback to SINGLE profile if there are not
> enough devices:

  Its better to keep it like this for now until there is a fix for the
  write hole. Otherwise hitting the write hole bug in case of degraded
  raid1 will be more prevalent.

  I proposed a RFC a long time before [1] (also in there, there
  is a commit id which turned the degraded raid1 profile into single
  profile (without much write-up on it)).

    [1] [PATCH 0/2] [RFC] btrfs: create degraded-RAID1 chunks

  Similarly the patch related to the reappearing missing device [2]
  falls under the same category. Will push for the integration after
  the write hole fix.

    [2] [PATCH] btrfs: handle dynamically reappearing missing device
    (test case 154).

  If you look close enough the original author has quite nicely made
  sure write hole bug will be very difficultly to hit. These fixes
  shall make it easy to hit. So its better to work on the write hole
  first.

  I am trying to fix write hole. First attempt has limited success
  (works fine in two disk raid1 only). Now trying other ways to fix.

>   # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
>   # wipefs -fa /dev/test/scratch2
>   # mount -o degraded /dev/test/scratch1 /mnt/btrfs
>   # fallocate -l 1G /mnt/btrfs/foobar
>   # btrfs ins dump-tree -t chunk /dev/test/scratch1
>          item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 1674575872) itemoff 15511 itemsize 80
>                  length 536870912 owner 2 stripe_len 65536 type DATA
>   New data chunk will fallback to SINGLE.
> 
> If user doesn't balance those SINGLE chunks, even with missing devices
> replaced, the fs is no longer full RAID1, and a missing device can break
> the tolerance.

  As its been discussed quite a lot of time before, the current
  re-silver/recovery approach for degraded-raid1 (with offload to Single)
  requires balance. Its kind of known.

Thanks, Anand


> [CAUSE]
> The cause is pretty simple, when mounted degraded, missing devices can't
> be used for chunk allocation.
> Thus btrfs has to fall back to SINGLE profile.
> 
> [ENHANCEMENT]
> To avoid such problem, this patch will:
> - Make all profiler reducer/updater to consider missing devices as part
>    of num_devices
> - Make chunk allocator to fallback to missing_list as last resort
> 
> If we have enough rw_devices, then go regular chunk allocation code.

> This can avoid allocating degraded chunks.
> E.g. for 3 devices RAID1 degraded mount, we will use the 2 existing
> devices to allocate chunk, avoid degraded chunk.

> But if we don't have enough rw_devices, then we check missing devices to
> allocate degraded chunks.
> E.g. for 2 devices RAID1 degraded mount, we have to allocate degraded
> chunks to keep the RAID1 profile.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/block-group.c | 10 +++++++---
>   fs/btrfs/volumes.c     | 18 +++++++++++++++---
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index bf7e3f23bba7..1686fd31679b 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -52,11 +52,13 @@ static u64 get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
>    */
>   static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
>   {
> -	u64 num_devices = fs_info->fs_devices->rw_devices;
> +	u64 num_devices;
>   	u64 target;
>   	u64 raid_type;
>   	u64 allowed = 0;
>   
> +	num_devices = fs_info->fs_devices->rw_devices +
> +		      fs_info->fs_devices->missing_devices;
>   	/*
>   	 * See if restripe for this chunk_type is in progress, if so try to
>   	 * reduce to the target profile
> @@ -1986,7 +1988,8 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
>   	if (stripped)
>   		return extended_to_chunk(stripped);
>   
> -	num_devices = fs_info->fs_devices->rw_devices;
> +	num_devices = fs_info->fs_devices->rw_devices +
> +		      fs_info->fs_devices->missing_devices;
>   
>   	stripped = BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK |
>   		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
> @@ -2981,7 +2984,8 @@ static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
>   
>   	num_dev = btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)].devs_max;
>   	if (!num_dev)
> -		num_dev = fs_info->fs_devices->rw_devices;
> +		num_dev = fs_info->fs_devices->rw_devices +
> +			  fs_info->fs_devices->missing_devices;
>   
>   	return num_dev;
>   }
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a462d8de5d2a..4dee1974ceb7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5052,8 +5052,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
>   			     max_chunk_size);
>   
> -	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
> -			       GFP_NOFS);
> +	devices_info = kcalloc(fs_devices->rw_devices +
> +			       fs_devices->missing_devices,
> +			       sizeof(*devices_info), GFP_NOFS);
>   	if (!devices_info)
>   		return -ENOMEM;
>   
> @@ -5067,7 +5068,18 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   			max_stripe_size, dev_stripes);
>   	if (ret < 0)
>   		goto error;
> -
> +	/*
> +	 * If rw devices can't fullfil the request, fallback to missing devices
> +	 * as last resort.
> +	 */
> +	if (ndevs < devs_min) {
> +		ret = gather_dev_holes(info, devices_info + ndevs, &ndevs,
> +				&fs_devices->missing_list,
> +				fs_devices->missing_devices,
> +				max_stripe_size, dev_stripes);
> +		if (ret < 0)
> +			goto error;
> +	}
>   	/*
>   	 * now sort the devices by hole size / available space
>   	 */
> 

