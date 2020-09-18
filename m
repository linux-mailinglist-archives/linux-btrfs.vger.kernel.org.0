Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4F27087E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRVrW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIRVrW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 17:47:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA9C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 14:47:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so4219005pgl.10
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Sep 2020 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eQh31Mzl17A5AVKILLeA3/venCugzxkOcHV/jaFRGF8=;
        b=EN6Wlq/wP6QuzepNWe+dq33TNhGr3zoFLTqLezOMa3hSqdC5YykV62qEr3ELrkX3rk
         MbihmSEEhJQgG49+hdnCN5hodJ9AWwTcI17DVcsspgDPFK1FjRTFvaBu4rsk14+wprP9
         LMJZ0XNJwmTVom1auSNrY1i4V3LNC4WcPczx+qhFBhWvhdvkoPAZbLRM6QnC3/JqIaEa
         sm1O/euOKAQiE1T0LCJOTfKV1pOg9pjFq4FREMfgBAt2aYeBFYHw2rWxuHYVd0KDXSvN
         Gf8H4Yf0GNmNYYBnowu3RDu8Ig53Og3pyHC3LDLshdJOMz/lwivqpwME+gO04IDDG9z8
         pTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eQh31Mzl17A5AVKILLeA3/venCugzxkOcHV/jaFRGF8=;
        b=a4xu7NIp1tTEatI9VJHrPbnoHEJU8VwhiNb8MZKynOMclRd1s4OQE+bNshzqb1KHlX
         CO5A16O8TenJSA8nsT3hwLVDhnsbuxSuZOPFP5a2s7WXyeBtfoYsjQMet5NmQHJ+/DLD
         YjZbe8vb9txPitWAgl82YMBstZ/p96/HTjvAJCkydKwwlGm/2+MpyOuVuyKWlFDRMCCA
         Qd/lgYsc0o/KsH1K5AaYtC7QvIq9cWlZsMsLQ6svNvWUDyyZUsvueI1hn1Xh1v1v9kDB
         8ewB0Ezen5If4mUowLW4YmaT7cuxlnCS6ozQlt99kgYnuS/7Xg6jxu7UtupSPVMIJdPj
         p/9w==
X-Gm-Message-State: AOAM533miizGF93MfOEEzeYGYm5upnR7DcR7HR8aMNgw27HhG5mT03nT
        SfULJOumKVKFXxx5DeEaWVIEAm8kxAZj1XNj
X-Google-Smtp-Source: ABdhPJy1+xA3ALxmnILoZLehiMfMJlXNGMJgBjC9mMt+vzSsoOMQfRdTiiNEg+NDQ31I4Rp6IF25mQ==
X-Received: by 2002:a62:a513:0:b029:142:2501:39f6 with SMTP id v19-20020a62a5130000b0290142250139f6mr17421527pfm.69.1600465641604;
        Fri, 18 Sep 2020 14:47:21 -0700 (PDT)
Received: from ?IPv6:2406:3003:2006:2288:6870:5759:3f51:6621? ([2406:3003:2006:2288:6870:5759:3f51:6621])
        by smtp.gmail.com with ESMTPSA id x6sm3689474pjp.25.2020.09.18.14.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 14:47:20 -0700 (PDT)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 1/2] btrfs: init device stats for seed devices
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600461724.git.josef@toxicpanda.com>
 <b0c2be2e6722f091821521301f251628afcd8313.1600461724.git.josef@toxicpanda.com>
Message-ID: <8217721c-0bd9-67af-1900-9594689c127b@oracle.com>
Date:   Sat, 19 Sep 2020 05:47:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <b0c2be2e6722f091821521301f251628afcd8313.1600461724.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Seed read errors should remain persistent.
A similar update to btrfs_run_dev_stats() is required?



On 19/9/20 4:44 am, Josef Bacik wrote:
> We recently started recording device stats across the fleet, and noticed
> a large increase in messages such as this
> 
> BTRFS warning (device dm-0): get dev_stats failed, not yet valid
> 
> on our tiers that use seed devices for their root devices.  This is
> because we do not initialize the device stats for any seed devices if we
> have a sprout device and mount using that sprout device.  The basic
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
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 88 +++++++++++++++++++++++++---------------------
>   1 file changed, 48 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6c7c8819cb31..c0cea9f5fdbc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7223,61 +7223,69 @@ static void btrfs_set_dev_stats_value(struct extent_buffer *eb,
>   			    sizeof(val));
>   }
>   
> -int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
> +static void __btrfs_init_dev_stats(struct btrfs_fs_info *fs_info,
> +				   struct btrfs_device *device,
> +				   struct btrfs_path *path)
>   {
> -	struct btrfs_key key;
>   	struct btrfs_root *dev_root = fs_info->dev_root;
> -	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_dev_stats_item *ptr;
>   	struct extent_buffer *eb;
> -	int slot;
> -	int ret = 0;
> +	struct btrfs_key key;
> +	int item_size;
> +	int i, ret, slot;
> +
> +	key.objectid = BTRFS_DEV_STATS_OBJECTID;
> +	key.type = BTRFS_PERSISTENT_ITEM_KEY;
> +	key.offset = device->devid;
> +	ret = btrfs_search_slot(NULL, dev_root, &key, path, 0, 0);
> +	if (ret) {
> +		for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
> +			btrfs_dev_stat_set(device, i, 0);
> +		device->dev_stats_valid = 1;
> +		btrfs_release_path(path);
> +		return;
> +	}
> +	slot = path->slots[0];
> +	eb = path->nodes[0];
> +	item_size = btrfs_item_size_nr(eb, slot);
> +
> +	ptr = btrfs_item_ptr(eb, slot,
> +			     struct btrfs_dev_stats_item);
> +
> +	for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++) {
> +		if (item_size >= (1 + i) * sizeof(__le64))
> +			btrfs_dev_stat_set(device, i,
> +					   btrfs_dev_stats_value(eb, ptr, i));
> +		else
> +			btrfs_dev_stat_set(device, i, 0);
> +	}
> +
> +	device->dev_stats_valid = 1;
> +	btrfs_dev_stat_print_on_load(device);
> +	btrfs_release_path(path);
> +}
> +
> +int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
>   	struct btrfs_device *device;
>   	struct btrfs_path *path = NULL;
> -	int i;
>   
>   	path = btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
>   
>   	mutex_lock(&fs_devices->device_list_mutex);
> -	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> -		int item_size;
> -		struct btrfs_dev_stats_item *ptr;
> -
> -		key.objectid = BTRFS_DEV_STATS_OBJECTID;
> -		key.type = BTRFS_PERSISTENT_ITEM_KEY;
> -		key.offset = device->devid;
> -		ret = btrfs_search_slot(NULL, dev_root, &key, path, 0, 0);
> -		if (ret) {
> -			for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
> -				btrfs_dev_stat_set(device, i, 0);
> -			device->dev_stats_valid = 1;
> -			btrfs_release_path(path);
> -			continue;
> -		}
> -		slot = path->slots[0];
> -		eb = path->nodes[0];
> -		item_size = btrfs_item_size_nr(eb, slot);
> -
> -		ptr = btrfs_item_ptr(eb, slot,
> -				     struct btrfs_dev_stats_item);
> -
> -		for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++) {
> -			if (item_size >= (1 + i) * sizeof(__le64))
> -				btrfs_dev_stat_set(device, i,
> -					btrfs_dev_stats_value(eb, ptr, i));
> -			else
> -				btrfs_dev_stat_set(device, i, 0);
> -		}
> -
> -		device->dev_stats_valid = 1;
> -		btrfs_dev_stat_print_on_load(device);
> -		btrfs_release_path(path);
> +	list_for_each_entry(device, &fs_devices->devices, dev_list)
> +		__btrfs_init_dev_stats(fs_info, device, path);
> +	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
> +		list_for_each_entry(device, &seed_devs->devices, dev_list)
> +			__btrfs_init_dev_stats(fs_info, device, path);
>   	}
>   	mutex_unlock(&fs_devices->device_list_mutex);
>   
>   	btrfs_free_path(path);
> -	return ret < 0 ? ret : 0;
> +	return 0;
>   }
>   
>   static int update_dev_stat_item(struct btrfs_trans_handle *trans,
> 

