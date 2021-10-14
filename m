Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC342DE26
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhJNPcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhJNPcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:32:42 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83A7C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:30:37 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o13so3950397qvm.4
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r3DHWSP+ip2Qj3k3jazTSn468tt+YTihVkqVP+3dPiY=;
        b=DeGvPIzAFP06u0ToilZOdJ+rhqWKYNc/4cP3B3yCAY+i3oTi47g9zDTWWTTU+ISW1L
         fgKQc6ZAQQYTLqMMbY5zfwMXu5i5jFCpIbpTJ2kDoME1aklU9PUcqzRQfhEidB7BVB8f
         Os/g3cPUMKmMVhPGKmvkVN5GamqzvNeWz/kV0ITsBSjxf6kSMDcDHexj0yGllawuex6J
         AF4PWo0kZyMgVAt289SV3XmhRC5fRAOp4xAcMiExlCpoIVPmIRFI3VTbj+srvtJGfbip
         qXOov1DDI/jiu55/oe1PUI9AS4LgpSsL7kbIP01u4C91BaUd7Gigi4uP187qq5SpfSos
         McsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r3DHWSP+ip2Qj3k3jazTSn468tt+YTihVkqVP+3dPiY=;
        b=fPr8Sqm8Gt8NtXJWSuDXiR7YpT9yAcspLNjLEaqK+0sPou6l8KkS49CB69ukoDaXsr
         RfOQI0lnooPpSFNgCfxnmkq7mBfGdwEFZGw8WKnBEb+0u/3ctZa+kg3qSVgbeMZcuwh5
         EMKw+aR2ZC88XYhXpXnpPEhQr3iuVMTPI7aukstnWpnODJxmfCSUcNxR4WGVe1R8XGHH
         vB5YtAeb1N2mEav8wHQ13GT3bRJh5ynzKWQYoBYO1Qmq9cNJC3BSjapJ6j8TJWBfVh0m
         eZYfYt99ibzBjo75eZgQAPI9zO/b2vFzWL3KPk0OVPME1oj1izuCu5115dT+npUtq+Ik
         tRmA==
X-Gm-Message-State: AOAM5338ilPftihAxc1yEPDhAY+Ji3MEbiBl2IK9HKDhUjJJEMp4mqp1
        ZtgwFXb3KBQPLtKEVwLT2Nc8Og==
X-Google-Smtp-Source: ABdhPJwL7biW+jpfVaRoRPtffVxs2i9aJJoPJOjUO7R56FQjTVOHtpZ5ga0zQOgxQlcMtoUnvaAswg==
X-Received: by 2002:ad4:4b63:: with SMTP id m3mr5936315qvx.35.1634225436710;
        Thu, 14 Oct 2021 08:30:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u10sm1583441qkp.58.2021.10.14.08.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:30:36 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:30:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v8] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
Message-ID: <YWhNG9SowUp5nTxz@localhost.localdomain>
References: <20211013080137.Bbt1omPCnM-ICZCnqrgjTq-2Rj4YbsM6OCm1MMBtG4o@z>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013080137.Bbt1omPCnM-ICZCnqrgjTq-2Rj4YbsM6OCm1MMBtG4o@z>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 04:01:37PM +0800, Anand Jain wrote:
> btrfs_prepare_sprout() splices seed devices into its own struct fs_devices,
> so that its parent function btrfs_init_new_device() can add the new sprout
> device to fs_info->fs_devices.
> 
> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
> device_list_mutex. But they are holding it sequentially, thus creates a
> small window to an opportunity to race. Close this opportunity and hold
> device_list_mutex common to both btrfs_init_new_device() and
> btrfs_prepare_sprout().
> 
> This patch splits btrfs_prepare_sprout() into btrfs_init_sprout() and
> btrfs_setup_sprout(). This split is essential because device_list_mutex
> shouldn't be held for allocs in btrfs_init_sprout() but must be held for
> btrfs_setup_sprout(). So now a common device_list_mutex can be used
> between btrfs_init_new_device() and btrfs_setup_sprout().
> 
> This patch also moves the lockdep_assert_held(&uuid_mutex) from the
> starting of the function to just above the line where we need this lock.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v8:
>  Change log update:
>  s/btrfs_alloc_sprout/btrfs_init_sprout/g
>  s/btrfs_splice_sprout/btrfs_setup_sprout/g
>  No code change.
> 
> v7:
>  . Not part of the patchset "btrfs: cleanup prepare_sprout" anymore as
>  1/3 is merged and 2/3 is dropped.
>  . Rename btrfs_alloc_sprout() to btrfs_init_sprout() as it does more
>  than just alloc and change return to btrfs_device *.
>  . Rename btrfs_splice_sprout() to btrfs_setup_sprout() as it does more
>  than just the splice.
>  . Add lockdep_assert_held(&uuid_mutex) and
>  lockdep_assert_held(&fs_devices->device_list_mutex) in btrfs_setup_sprout().
> 
> v6:
>  Remove RFC.
>  Split btrfs_prepare_sprout so that the allocation part can be outside
>  of the device_list_mutex in the parent function btrfs_init_new_device().
> 
>  fs/btrfs/volumes.c | 73 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 53 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8e2b76b5fd14..10227b13a1a6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2378,21 +2378,14 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>  	return btrfs_find_device_by_path(fs_info, device_path);
>  }
>  
> -/*
> - * does all the dirty work required for changing file system's UUID.
> - */
> -static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
> +static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
>  {
>  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>  	struct btrfs_fs_devices *old_devices;
>  	struct btrfs_fs_devices *seed_devices;
> -	struct btrfs_super_block *disk_super = fs_info->super_copy;
> -	struct btrfs_device *device;
> -	u64 super_flags;
>  
> -	lockdep_assert_held(&uuid_mutex);
>  	if (!fs_devices->seeding)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
>  	/*
>  	 * Private copy of the seed devices, anchored at
> @@ -2400,7 +2393,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>  	 */
>  	seed_devices = alloc_fs_devices(NULL, NULL);
>  	if (IS_ERR(seed_devices))
> -		return PTR_ERR(seed_devices);
> +		return seed_devices;
>  
>  	/*
>  	 * It's necessary to retain a copy of the original seed fs_devices in
> @@ -2411,9 +2404,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>  	old_devices = clone_fs_devices(fs_devices);
>  	if (IS_ERR(old_devices)) {
>  		kfree(seed_devices);
> -		return PTR_ERR(old_devices);
> +		return old_devices;
>  	}
>  
> +	lockdep_assert_held(&uuid_mutex);

There's no reason to move this down here, you can leave it at the top of this
function.  Fix that up and you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
