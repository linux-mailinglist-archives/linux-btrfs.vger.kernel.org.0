Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF5449744
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 15:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhKHPAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 10:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbhKHPAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 10:00:08 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCEC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 06:57:24 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id r8so15689853qkp.4
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 06:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wqVLX8dZDHeyRANbcCrFQXX2AwaVObKHrVIUZALrz5Q=;
        b=jGDLZ9lxEVHgwdsGzdLEo59SkvlHTWawRNY4EzRxaTc6r5vqrYh1ah2/18T+dsyfQm
         ggHCpNrgag7GGDZeDUIiVQEARNWhFj1IAu7YfeKuF2NyGux69u7se7o6kD0RVtxlLfvQ
         eLS7Kj2Rl/zn0ZThsbe79ctQMFnzVlMD4y/SPJ9R/0HX+HM1ZNqmEu9RXEC+tLBf6WLJ
         kvbicRcV6vkfUQ1ARRGdR7aJkQ4AobIWlQUInsqtV5oZ0v/G/uVQS/9GW4p94bg8MJsv
         fL8PMOkbaayMV5MRntsfPquyWf4RrpaUZV1UwDmri3j5xVVNIsiqCh2JoMuciFJaqp36
         /qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wqVLX8dZDHeyRANbcCrFQXX2AwaVObKHrVIUZALrz5Q=;
        b=nfXmPM8bFEQX06n+ykFsu5HXq0BXAlaRn/BIob7ZZs4leNDMtR+Nkb1OQwtTsSwovc
         XpmvPJ4HuT4B8db6SOxlisM7BRSr3XJ1AWbPDol1aSomqKEbmUXiyIQ6HO5vqqRZfY5f
         KewbOqI2EHnzxrwLOaX/+7aKrhef+5sVGGCYtjZvGLFGejE2lRRSKG1gS3yUjMf3FuWq
         ypbNf/TqSnMjX6/WNohDBvqzSveWxOO2JB5uFcwS9f4XIMWPN2VuI96+pIP1i+TTAX83
         pPPscZp06eGFX5SolDpqJgm+s7tOD3qxjB6AyXcux2ymvYJDJaVtdnZkrXgj4OjR+SIs
         TqHA==
X-Gm-Message-State: AOAM533eMdaS3hX1LDJqK8Q0m3/vZbl7oyw3cGu5YD9T1+cVjOTlHNgs
        zs3rELfaAHCSldwklNHljK0Kow==
X-Google-Smtp-Source: ABdhPJx8GIdXzZU6sFFo+NPh1G4oLNaPZYpvoWo1jVpum73toQi1FPFcyq6qyGittvnLMM8o/0SY5A==
X-Received: by 2002:a37:94c4:: with SMTP id w187mr170042qkd.136.1636383443232;
        Mon, 08 Nov 2021 06:57:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b20sm11359377qtx.89.2021.11.08.06.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:57:22 -0800 (PST)
Date:   Mon, 8 Nov 2021 09:57:21 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED
 exclusive state
Message-ID: <YYk60W+6No80x7Ps@localhost.localdomain>
References: <20211108142820.1003187-1-nborisov@suse.com>
 <20211108142820.1003187-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108142820.1003187-2-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 08, 2021 at 04:28:18PM +0200, Nikolay Borisov wrote:
> Current set of exclusive operation states is not sufficient to handle all
> practical use cases. In particular there is a need to be able to add a
> device to a filesystem that have paused balance. Currently there is no
> way to distinguish between a running and a paused balance. Fix this by
> introducing BTRFS_EXCLOP_BALANCE_PAUSED which is going to be set in 2
> occasions:
> 
> 1. When a filesystem is mounted with skip_balance and there is an
>    unfinished balance it will now be into BALANCE_PAUSED instead of
>    simply BALANCE state.
> 
> 2. When a running balance is paused.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.h   |  3 +++
>  fs/btrfs/ioctl.c   | 13 +++++++++++++
>  fs/btrfs/volumes.c | 11 +++++++++--
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 7553e9dc5f93..8376271bfed1 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -613,6 +613,7 @@ enum {
>   */
>  enum btrfs_exclusive_operation {
>  	BTRFS_EXCLOP_NONE,
> +	BTRFS_EXCLOP_BALANCE_PAUSED,
>  	BTRFS_EXCLOP_BALANCE,
>  	BTRFS_EXCLOP_DEV_ADD,
>  	BTRFS_EXCLOP_DEV_REMOVE,
> @@ -3305,6 +3306,8 @@ bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
>  				 enum btrfs_exclusive_operation type);
>  void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
>  void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
> +void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info);
> +
>  
>  /* file.c */
>  int __init btrfs_auto_defrag_init(void);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 92424a22d8d6..f4c05a9aab84 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -414,6 +414,15 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
>  	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
>  }
>  
> +void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info)
> +{
> +	spin_lock(&fs_info->super_lock);
> +	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
> +	       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
> +	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
> +	spin_unlock(&fs_info->super_lock);
> +}
> +
>  static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
>  {
>  	struct inode *inode = file_inode(file);
> @@ -4020,6 +4029,10 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
>  			if (fs_info->balance_ctl &&
>  			    !test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
>  				/* this is (3) */
> +				spin_lock(&fs_info->super_lock);
> +				ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
> +				fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
> +				spin_unlock(&fs_info->super_lock);
>  				need_unlock = false;
>  				goto locked;
>  			}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cc80f2a97a0b..e87f9ac440c2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4355,8 +4355,10 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>  	ret = __btrfs_balance(fs_info);
>  
>  	mutex_lock(&fs_info->balance_mutex);
> -	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req))
> +	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
>  		btrfs_info(fs_info, "balance: paused");
> +		btrfs_exclop_pause_balance(fs_info);
> +	}
>  	/*
>  	 * Balance can be canceled by:
>  	 *
> @@ -4406,6 +4408,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>  static int balance_kthread(void *data)
>  {
>  	struct btrfs_fs_info *fs_info = data;
> +	bool paused = false;

Unused variable.  Thanks,

Josef
