Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0371625687B
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgH2O7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Aug 2020 10:59:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37014 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2O7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Aug 2020 10:59:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TExm2c070339;
        Sat, 29 Aug 2020 14:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kzsLqBKBoxF7zmbtR8WFd5x3ftbFEZzuHqADyBBea6Q=;
 b=PDyzpQt4kyxz9MEM7B0xbLNuWkNzwPSpbuU6WMGn+/+cnR7U8u9Y9zZU5u/95+YJfTKj
 k/e0JkqGCGnq3r5Q1Jiz9PML2iOMmTDcHyIZ2decqDVM9RyqmqRt07n8/uNyHkd126Z/
 EmwEOSaMPcYy/GsqJ1bffYlleS4F8r78eVp4S5uAcXuS9kpnnSz2TW+bJrnGuFAweQQi
 dUmIs8D/rpWnxqf97pL//isrhLw/f8jkTrk/wUmAgAo6Y5aaoH1pR7ckrA0C2ip8fcdN
 qed85Iv4Hy4XWzDzJGavGPbtiOKXlekQ8DOclm3yIMKn86X27U2OfXLJra9hOV1hIujY cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 337qrh846f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 14:59:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TEpZDk085409;
        Sat, 29 Aug 2020 14:59:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 337c4sfx4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 14:59:47 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07TExkpc010162;
        Sat, 29 Aug 2020 14:59:47 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Aug 2020 07:59:46 -0700
Subject: Re: [PATCH] btrfs: remove fsid argument from
 btrfs_sysfs_update_sprout_fsid
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200812131851.9129-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <77a899a4-7633-f73a-6d81-aa12c01f0630@oracle.com>
Date:   Sat, 29 Aug 2020 22:59:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200812131851.9129-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008290122
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/8/20 9:18 pm, Nikolay Borisov wrote:
> It can be accessed from 'fs_devices' as it's identical to
> fs_info->fs_devices. Also add a comment about why we are calling the
> function. No semantic changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/sysfs.c   | 6 +++---
>   fs/btrfs/sysfs.h   | 3 +--
>   fs/btrfs/volumes.c | 8 ++++++--
>   3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 784a0f8a4cab..2d987b770a20 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1322,8 +1322,8 @@ void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
>   			&disk_to_dev(bdev->bd_disk)->kobj);
>   }
>   
> -void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
> -				    const u8 *fsid)
> +void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices)
> +
>   {
>   	char fsid_buf[BTRFS_UUID_UNPARSED_SIZE];
>   
> @@ -1331,7 +1331,7 @@ void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
>   	 * Sprouting changes fsid of the mounted filesystem, rename the fsid
>   	 * directory
>   	 */
> -	snprintf(fsid_buf, BTRFS_UUID_UNPARSED_SIZE, "%pU", fsid);
> +	snprintf(fsid_buf, BTRFS_UUID_UNPARSED_SIZE, "%pU", fs_devices->fsid);
>   	if (kobject_rename(&fs_devices->fsid_kobj, fsid_buf))
>   		btrfs_warn(fs_devices->fs_info,
>   				"sysfs: failed to create fsid for sprout");
> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> index cf839c46a131..c9efa15f96e0 100644
> --- a/fs/btrfs/sysfs.h
> +++ b/fs/btrfs/sysfs.h
> @@ -20,8 +20,7 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
>                   struct btrfs_device *one_device);
>   int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
>   void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
> -void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
> -				    const u8 *fsid);
> +void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
>   void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
>   		u64 bit, enum btrfs_feature_set set);
>   void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4bae30b9c944..631cb03b3513 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2630,8 +2630,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   			goto error_sysfs;
>   		}
>   
> -		btrfs_sysfs_update_sprout_fsid(fs_devices,
> -				fs_info->fs_devices->fsid);
> +		/*
> +		 * fs_devices now represents the newly sprouted filesystem and
> +		 * its fsid has been changed by btrfs_prepare_sprout
> +		 */
> +		btrfs_sysfs_update_sprout_fsid(fs_devices);
> +
>   	}
>   
>   	ret = btrfs_commit_transaction(trans);
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>

