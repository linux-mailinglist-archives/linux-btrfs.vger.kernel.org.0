Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63127477A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVRaM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 13:30:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVRaM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 13:30:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B48EB040;
        Tue, 22 Sep 2020 17:30:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EFB82DA6E9; Tue, 22 Sep 2020 19:28:55 +0200 (CEST)
Date:   Tue, 22 Sep 2020 19:28:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: return error if we're unable to read device
 stats
Message-ID: <20200922172855.GH6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1600461724.git.josef@toxicpanda.com>
 <6f50f5be859468da38bd504c0f78a97dbcd0306d.1600461724.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f50f5be859468da38bd504c0f78a97dbcd0306d.1600461724.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 18, 2020 at 04:44:33PM -0400, Josef Bacik wrote:
> @@ -7270,22 +7271,30 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
>  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
>  	struct btrfs_device *device;
>  	struct btrfs_path *path = NULL;
> +	int ret = 0;
>  
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
>  
>  	mutex_lock(&fs_devices->device_list_mutex);
> -	list_for_each_entry(device, &fs_devices->devices, dev_list)
> -		__btrfs_init_dev_stats(fs_info, device, path);
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		ret = __btrfs_init_dev_stats(fs_info, device, path);
> +		if (ret)
> +			goto out;
> +	}
>  	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
> -		list_for_each_entry(device, &seed_devs->devices, dev_list)
> -			__btrfs_init_dev_stats(fs_info, device, path);
> +		list_for_each_entry(device, &seed_devs->devices, dev_list) {
> +			ret = __btrfs_init_dev_stats(fs_info, device, path);
> +			if (ret)
> +				break;

This jumps out of the inner list_for_each and continues traversing the
seed_list, is that intentional? Or goto out should be here as well.

> +		}
>  	}
> +out:
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
>  	btrfs_free_path(path);
> -	return 0;
> +	return ret;
>  }
