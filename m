Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C3111CDC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 14:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfLLNFi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 08:05:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:42196 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729297AbfLLNFi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 08:05:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E48B7AD2C;
        Thu, 12 Dec 2019 13:05:34 +0000 (UTC)
Subject: Re: [PATCH 2/6] btrfs: metadata_uuid: move split-brain handling from
 fs_id() to new function
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <20191212110132.11063-3-Damenly_Su@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c510f446-67a6-edb7-72a4-0617288a3c52@suse.com>
Date:   Thu, 12 Dec 2019 15:05:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191212110132.11063-3-Damenly_Su@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.12.19 г. 13:01 ч., damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
> 
> The parameter @metadata_fsid of fs_id() is not NULL while scanned device
> has metadata_uuid but not changing. Obviously, the cases handling part
> in fs_id() is for this situation. Move the logic into new function
> find_fsid_changing_metadata_uuid().

I think the following changelog might sound better.

metadata_fsid parameter of find_fsid is non-null in once specific case
in device_list_add. Factor the code out of find_fsid to a dedicated
function to improve readability.


> 
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> ---
>  fs/btrfs/volumes.c | 78 ++++++++++++++++++++++++----------------------
>  1 file changed, 41 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9efa4123c335..b08b06a89a77 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -438,40 +438,6 @@ static noinline struct btrfs_fs_devices *find_fsid(
>  
>  	ASSERT(fsid);
>  
> -	if (metadata_fsid) {
> -		/*
> -		 * Handle scanned device having completed its fsid change but
> -		 * belonging to a fs_devices that was created by first scanning
> -		 * a device which didn't have its fsid/metadata_uuid changed
> -		 * at all and the CHANGING_FSID_V2 flag set.
> -		 */
> -		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> -			if (fs_devices->fsid_change &&
> -			    memcmp(metadata_fsid, fs_devices->fsid,
> -				   BTRFS_FSID_SIZE) == 0 &&
> -			    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
> -				   BTRFS_FSID_SIZE) == 0) {
> -				return fs_devices;
> -			}
> -		}
> -		/*
> -		 * Handle scanned device having completed its fsid change but
> -		 * belonging to a fs_devices that was created by a device that
> -		 * has an outdated pair of fsid/metadata_uuid and
> -		 * CHANGING_FSID_V2 flag set.
> -		 */
> -		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> -			if (fs_devices->fsid_change &&
> -			    memcmp(fs_devices->metadata_uuid,
> -				   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
> -			    memcmp(metadata_fsid, fs_devices->metadata_uuid,
> -				   BTRFS_FSID_SIZE) == 0) {
> -				return fs_devices;
> -			}
> -		}
> -	}
> -
> -	/* Handle non-split brain cases */
>  	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>  		if (metadata_fsid) {
>  			if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) == 0
> @@ -712,6 +678,46 @@ static struct btrfs_fs_devices *find_fsid_changed(
>  
>  	return NULL;
>  }
> +
> +static struct btrfs_fs_devices *find_fsid_changing_metada_uuid(

That function name is long (and contains a typo). More like something like:

find_fsid_with_metadata_uuid.

> +					struct btrfs_super_block *disk_super)
> +{
> +	struct btrfs_fs_devices *fs_devices;
> +
> +	/*
> +	 * Handle scanned device having completed its fsid change but
> +	 * belonging to a fs_devices that was created by first scanning
> +	 * a device which didn't have its fsid/metadata_uuid changed
> +	 * at all and the CHANGING_FSID_V2 flag set.
> +	 */
> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +		if (fs_devices->fsid_change &&
> +		    memcmp(disk_super->metadata_uuid, fs_devices->fsid,
> +			   BTRFS_FSID_SIZE) == 0 &&
> +		    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
> +			   BTRFS_FSID_SIZE) == 0) {
> +			return fs_devices;
> +		}
> +	}
> +	/*
> +	 * Handle scanned device having completed its fsid change but
> +	 * belonging to a fs_devices that was created by a device that
> +	 * has an outdated pair of fsid/metadata_uuid and
> +	 * CHANGING_FSID_V2 flag set.
> +	 */
> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +		if (fs_devices->fsid_change &&
> +		    memcmp(fs_devices->metadata_uuid,
> +			   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
> +		    memcmp(disk_super->metadata_uuid, fs_devices->metadata_uuid,
> +			   BTRFS_FSID_SIZE) == 0) {
> +			return fs_devices;
> +		}
> +	}
> +
> +	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
> +}
> +
>  /*
>   * Add new device to list of registered devices
>   *
> @@ -751,13 +757,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  			fs_devices = find_fsid_changed(disk_super);
>  		}
>  	} else if (has_metadata_uuid) {
> -		fs_devices = find_fsid(disk_super->fsid,
> -				       disk_super->metadata_uuid);
> +		fs_devices = find_fsid_changing_metada_uuid(disk_super);
>  	} else {
>  		fs_devices = find_fsid(disk_super->fsid, NULL);
>  	}
>  
> -
>  	if (!fs_devices) {
>  		if (has_metadata_uuid)
>  			fs_devices = alloc_fs_devices(disk_super->fsid,
> 
