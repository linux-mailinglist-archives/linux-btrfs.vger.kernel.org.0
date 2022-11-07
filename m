Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C746203E7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 00:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiKGXpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 18:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiKGXpT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 18:45:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE041B9C6
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 15:45:16 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1pBNLN1Rgs-00seY4; Tue, 08
 Nov 2022 00:45:12 +0100
Message-ID: <3b5ebb57-af2a-7cf3-6f2e-75d64f17e853@gmx.com>
Date:   Tue, 8 Nov 2022 07:45:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] btrfs: move device->name rcu alloc and assign to
 btrfs_alloc_device()
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0qsdwor5v5G8wF22BTGylficwC1TuZ38s63jSAisq10OdCp0yQ/
 5+44zPROY+Mp9OA9osyhnJJvCwwvSUlIfLN4UuaGT6MYIQOgnFivbXBGh3yeToGf+fTWh5M
 pBl38jZmoLQhL2R+LrFfQvoO/hMte9NyLqgEY/NsMGI8sbrsPT8zW/PF3eMwEgHsWEFmBDO
 GVkUZlQbKH1NL8KFA3bkA==
UI-OutboundReport: notjunk:1;M01:P0:Ck54YTKlsWE=;ffluYdtCtIFou5BRxK0ctNrsO92
 REbyUYObpOSyWm6aCTbEB8Psxr/rwvqaPWQKIu3zggthxXHauZEbaLST3t0bjiIPra5hVPo/u
 zfJABd3l9y2owOwNLHywTem6Kj/pvymTgK/6qVQt/e4aM6K/riBSry9JER74F1qsMsI9MUCH4
 Syr1yWNTaCoQwGm7oI+uiTxhSFpBmyHDxJs+5SppRU0HzNcqyu4pHc2gxfgpZWS6XzbGAQBSl
 BLAz7gTfcPrEy50ocN2WQ1blFovmaxhV80VilpgcrwikNaZGxZVgliqxZi11uHXuVD17/XR64
 VVLCWLyGebnwUuZBS+0lTbCQDRiR+87Bi9CmS9J665DvlOnoWo96gW14c/Wjsn1vsbH3B6M47
 EDYhpzEUIttj6DiiBeNa2TWovF2eRfXbr9exR+7XzcotGVF0TjoQ3gayeHmGs7jeMS2NIyTgD
 Btmx/TlMWAnZ9AwKeYbC9rEr15ELGAM7SFQgMelspIRv+Zvcf8pLzoiRh6+1loYXpVnRvNM9O
 eVca/WWujkrZwzmZs2yoWnM8F15GSuLSnZc/avyBMk7WGpFdEkG7/jt1jomos5PZnv7lu2bct
 3Ne/9cOP/ikMYnF4cn8voffNNYv/ktT6cyEAoVcsbCLHDctVMrM1Z3J7omPbwCw4NZLU8u6RK
 a1N4cBWS2o6wbMkeZRch3RKZQO3wRbE+Ub2ZhsHRdiYaUJt3OlYq7naXrbgmP3oW0rdM2MQD4
 0Bs9jcz6aB6EnksrxTwHeFAc16kN0MuGZnadwiUdlH78wIuUgmwz+lcd4RtHZNMmsqdarRIYK
 DlQx89xZWrll0Tj7eCMCx8pABIzTzy1EGrE7fGBtWgloJEvzxBASOdERpVbR9puV/GBR3RGIM
 SvsYPIXyRO05LHthbKHGHT8S6wAUAMyHrEg7djvfRMYQ9qxeELfX3/e90w0XywMURTtA6ybnG
 z2ZYF/ZCaAi0RHSUm3I7y2TeM+k=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/7 23:07, Anand Jain wrote:
> There is a repeating code section in the parent function after calling
> btrfs_alloc_device(), as below.
> 
>                name = rcu_string_strdup(path, GFP_...);
>                 if (!name) {
>                         btrfs_free_device(device);
>                         return ERR_PTR(-ENOMEM);
>                 }
>                 rcu_assign_pointer(device->name, name);
> 
> Except in add_missing_dev() for obvious reasons.
> 
> This patch consolidates that repeating code into the btrfs_alloc_device()
> itself so that the parent function doesn't have to duplicate code.
> This consolidation also helps to review issues regarding rcu lock
> violation with device->name.
> 
> Parent function device_list_add() and add_missing_dev() uses GFP_NOFS for
> the alloc, whereas the rest of the parent function uses GFP_KERNEL, so
> bring the NOFS alloc context using memalloc_nofs_save() in the function
> device_list_add() and add_missing_dev() is already doing it.

I'm wondering do we really need to use RCU for device list?

My understanding of this situation is, btrfs has very limited way to 
modifiy device list (device add/remove/replace), while most of our 
operations are read-only for device list.

Can we just go regular semaphore and get rid of the RCU scheme completely?

Thanks,
Qu
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/dev-replace.c | 10 +------
>   fs/btrfs/volumes.c     | 64 ++++++++++++++++++------------------------
>   fs/btrfs/volumes.h     |  4 +--
>   3 files changed, 30 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 84af2010fae2..9c4a8649a0f4 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -249,7 +249,6 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>   	struct btrfs_device *device;
>   	struct block_device *bdev;
> -	struct rcu_string *name;
>   	u64 devid = BTRFS_DEV_REPLACE_DEVID;
>   	int ret = 0;
>   
> @@ -293,19 +292,12 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>   	}
>   
>   
> -	device = btrfs_alloc_device(NULL, &devid, NULL);
> +	device = btrfs_alloc_device(NULL, &devid, NULL, device_path);
>   	if (IS_ERR(device)) {
>   		ret = PTR_ERR(device);
>   		goto error;
>   	}
>   
> -	name = rcu_string_strdup(device_path, GFP_KERNEL);
> -	if (!name) {
> -		btrfs_free_device(device);
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> -	rcu_assign_pointer(device->name, name);
>   	ret = lookup_bdev(device_path, &device->devt);
>   	if (ret)
>   		goto error;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 27fa43f5c4f4..7a9e6c40c053 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -845,26 +845,23 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   	}
>   
>   	if (!device) {
> +		unsigned int nofs_flag;
> +
>   		if (fs_devices->opened) {
>   			mutex_unlock(&fs_devices->device_list_mutex);
>   			return ERR_PTR(-EBUSY);
>   		}
>   
> +		nofs_flag = memalloc_nofs_save();
>   		device = btrfs_alloc_device(NULL, &devid,
> -					    disk_super->dev_item.uuid);
> +					    disk_super->dev_item.uuid, path);
> +		memalloc_nofs_restore(nofs_flag);
>   		if (IS_ERR(device)) {
>   			mutex_unlock(&fs_devices->device_list_mutex);
>   			/* we can safely leave the fs_devices entry around */
>   			return device;
>   		}
>   
> -		name = rcu_string_strdup(path, GFP_NOFS);
> -		if (!name) {
> -			btrfs_free_device(device);
> -			mutex_unlock(&fs_devices->device_list_mutex);
> -			return ERR_PTR(-ENOMEM);
> -		}
> -		rcu_assign_pointer(device->name, name);
>   		device->devt = path_devt;
>   
>   		list_add_rcu(&device->dev_list, &fs_devices->devices);
> @@ -997,30 +994,18 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>   	fs_devices->total_devices = orig->total_devices;
>   
>   	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
> -		struct rcu_string *name;
> +		const char *dev_path = NULL;
> +
> +		if (orig_dev->name)
> +			dev_path = orig_dev->name->str;
>   
>   		device = btrfs_alloc_device(NULL, &orig_dev->devid,
> -					    orig_dev->uuid);
> +					    orig_dev->uuid, dev_path);
>   		if (IS_ERR(device)) {
>   			ret = PTR_ERR(device);
>   			goto error;
>   		}
>   
> -		/*
> -		 * This is ok to do without rcu read locked because we hold the
> -		 * uuid mutex so nothing we touch in here is going to disappear.
> -		 */
> -		if (orig_dev->name) {
> -			name = rcu_string_strdup(orig_dev->name->str,
> -					GFP_KERNEL);
> -			if (!name) {
> -				btrfs_free_device(device);
> -				ret = -ENOMEM;
> -				goto error;
> -			}
> -			rcu_assign_pointer(device->name, name);
> -		}
> -
>   		list_add(&device->dev_list, &fs_devices->devices);
>   		device->fs_devices = fs_devices;
>   		fs_devices->num_devices++;
> @@ -2592,7 +2577,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	struct btrfs_device *device;
>   	struct block_device *bdev;
>   	struct super_block *sb = fs_info->sb;
> -	struct rcu_string *name;
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>   	struct btrfs_fs_devices *seed_devices;
>   	u64 orig_super_total_bytes;
> @@ -2633,20 +2617,13 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	}
>   	rcu_read_unlock();
>   
> -	device = btrfs_alloc_device(fs_info, NULL, NULL);
> +	device = btrfs_alloc_device(fs_info, NULL, NULL, device_path);
>   	if (IS_ERR(device)) {
>   		/* we can safely leave the fs_devices entry around */
>   		ret = PTR_ERR(device);
>   		goto error;
>   	}
>   
> -	name = rcu_string_strdup(device_path, GFP_KERNEL);
> -	if (!name) {
> -		ret = -ENOMEM;
> -		goto error_free_device;
> -	}
> -	rcu_assign_pointer(device->name, name);
> -
>   	device->fs_info = fs_info;
>   	device->bdev = bdev;
>   	ret = lookup_bdev(device_path, &device->devt);
> @@ -6986,8 +6963,9 @@ static struct btrfs_device *add_missing_dev(struct btrfs_fs_devices *fs_devices,
>   	 * always do NOFS because we use it in a lot of other GFP_KERNEL safe
>   	 * places.
>   	 */
> +
>   	nofs_flag = memalloc_nofs_save();
> -	device = btrfs_alloc_device(NULL, &devid, dev_uuid);
> +	device = btrfs_alloc_device(NULL, &devid, dev_uuid, NULL);
>   	memalloc_nofs_restore(nofs_flag);
>   	if (IS_ERR(device))
>   		return device;
> @@ -7011,14 +6989,15 @@ static struct btrfs_device *add_missing_dev(struct btrfs_fs_devices *fs_devices,
>    *		is generated.
>    * @uuid:	a pointer to UUID for this device.  If NULL a new UUID
>    *		is generated.
> + * @path:	a pointer to device path if available, NULL otherwise.
>    *
>    * Return: a pointer to a new &struct btrfs_device on success; ERR_PTR()
>    * on error.  Returned struct is not linked onto any lists and must be
>    * destroyed with btrfs_free_device.
>    */
>   struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
> -					const u64 *devid,
> -					const u8 *uuid)
> +					const u64 *devid, const u8 *uuid,
> +					const char *path)
>   {
>   	struct btrfs_device *dev;
>   	u64 tmp;
> @@ -7057,6 +7036,17 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>   	else
>   		generate_random_uuid(dev->uuid);
>   
> +	if (path) {
> +		struct rcu_string *name;
> +
> +		name = rcu_string_strdup(path, GFP_KERNEL);
> +		if (!name) {
> +			btrfs_free_device(dev);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +		rcu_assign_pointer(dev->name, name);
> +	}
> +
>   	return dev;
>   }
>   
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 6c7b5cf2de79..07eb5aecbe81 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -649,8 +649,8 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
>   				 struct btrfs_dev_lookup_args *args,
>   				 const char *path);
>   struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
> -					const u64 *devid,
> -					const u8 *uuid);
> +					const u64 *devid, const u8 *uuid,
> +					const char *path);
>   void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
>   void btrfs_free_device(struct btrfs_device *device);
>   int btrfs_rm_device(struct btrfs_fs_info *fs_info,
