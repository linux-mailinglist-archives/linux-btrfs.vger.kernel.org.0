Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD869449C93
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbhKHTkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:40:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42104 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhKHTkP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:40:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 48776218CE;
        Mon,  8 Nov 2021 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636400249;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HopIdWQRu69P5sUXyDeEG5MMe96rEr+/Ip9aTTOzPcM=;
        b=xrfiQ+lHD/hir6zHuhBNeDn6IhazZkUrx8+iddQTStXQ/eQp4SxMFSjJwkQnji1Q/xGNd+
        DZhX2ztbBUeiIlaPgQRUPoa87Y1umqR0xAh8zk0gFlUyix7VJhEZoC9qpO+rh5B2x04zWk
        fjUJ+DqTVVqFMq/xjQhDnTCM59pLWpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636400249;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HopIdWQRu69P5sUXyDeEG5MMe96rEr+/Ip9aTTOzPcM=;
        b=z3EfTmeAxU1PiwWDVJQ162OjFh6wsBcYnuwEJQxRlq2CcW/peg23HOIAmTbnx/4hnSQ5sf
        tC8+ZKDGtgDgOpBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 407D2A3B84;
        Mon,  8 Nov 2021 19:37:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B712DA799; Mon,  8 Nov 2021 20:36:50 +0100 (CET)
Date:   Mon, 8 Nov 2021 20:36:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v9] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
Message-ID: <20211108193650.GL28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <8afc1ed3ef688557bbb0dfae1e23d47e53cb645f.1634813005.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afc1ed3ef688557bbb0dfae1e23d47e53cb645f.1634813005.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 06:49:57PM +0800, Anand Jain wrote:
> @@ -2662,18 +2688,25 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  
>  	if (seeding_dev) {
>  		btrfs_clear_sb_rdonly(sb);
> -		ret = btrfs_prepare_sprout(fs_info);
> -		if (ret) {
> -			btrfs_abort_transaction(trans, ret);
> +
> +		/* GFP_KERNEL alloc should not be under device_list_mutex */
> +		seed_devices = btrfs_init_sprout(fs_info);
> +		if (IS_ERR(seed_devices)) {
> +			btrfs_abort_transaction(trans, (int)PTR_ERR(seed_devices));

Shouldn't this do

			ret = PTR_ERR(seed_devices)
			btrfs_abort_transaction(trans, ret);
			goto error_trans;

The ret value would otherwise remain unchanged, from some previous use
which at this point would be 0.

>  			goto error_trans;
>  		}
> +	}
> +
> +	mutex_lock(&fs_devices->device_list_mutex);
> +	if (seeding_dev) {
> +		btrfs_setup_sprout(fs_info, seed_devices);
> +
>  		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
>  						device);
>  	}
>  
>  	device->fs_devices = fs_devices;
>  
> -	mutex_lock(&fs_devices->device_list_mutex);
>  	mutex_lock(&fs_info->chunk_mutex);
>  	list_add_rcu(&device->dev_list, &fs_devices->devices);
>  	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
