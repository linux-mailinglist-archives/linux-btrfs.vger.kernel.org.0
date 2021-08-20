Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3338C3F280E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 10:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhHTIAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 04:00:49 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:34734 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhHTIAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 04:00:49 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 012A01E00699;
        Fri, 20 Aug 2021 11:00:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1629446410; bh=1GFEBKrTlpAHNcmVSrGaIJSpsUIPQNSOYSyL2ifCvdQ=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=SsDY56RN5DAnmNMzU6WPFj9a+Txzu5lm+6seQmT+ZULDfb7dZaiDvGhwV9AiJXp7l
         gSAJ0gy+C8tUYQEzvdVIIMTQUGYMfAfrhdl2KNXk7B4HZuz2H/7kY12U7Lh0LEaS2y
         yuyTT50RQITuYMpKE3Nkzhwmkg4Dlj+EX6RGT5+U=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id ED5AE1E00671;
        Fri, 20 Aug 2021 11:00:09 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id zJrYy-8tT-Hs; Fri, 20 Aug 2021 11:00:09 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id A92AE1E0066A;
        Fri, 20 Aug 2021 11:00:09 +0300 (EEST)
Received: from nas (unknown [49.65.73.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id C75AF1BE013A;
        Fri, 20 Aug 2021 11:00:07 +0300 (EEST)
References: <cover.1629396187.git.anand.jain@oracle.com>
 <8b8e72c87d0ee97da1b2e243a24b68d84d0ac3b9.1629396187.git.anand.jain@oracle.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH RFC 2/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
Date:   Fri, 20 Aug 2021 15:51:03 +0800
Message-ID: <y28weeg4.fsf@damenly.su>
In-reply-to: <8b8e72c87d0ee97da1b2e243a24b68d84d0ac3b9.1629396187.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1ml5Y9aTPX9ELYI3baDBgxqjROX/Ph8/vJrhAZwzvmU1qJf04NURK/nm1yS2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 20 Aug 2021 at 02:18, Anand Jain <anand.jain@oracle.com> 
wrote:

> btrfs_prepare_sprout() moves seed devices into its own struct 
> fs_devices,
> so that its parent function btrfs_init_new_device() can add the 
> new sprout
> device to fs_info->fs_devices.
>
> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
> device_list_mutex. But they are holding it sequentially, thus 
> creates a
> small window to an opportunity to race. Close this opportunity 
> and hold
> device_list_mutex common to both btrfs_init_new_device() and
> btrfs_prepare_sprout().
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> RFC because I haven't identified the other thread which could 
> race with
> this, but still does this cleanup makes sense?
>
>  fs/btrfs/volumes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 91b8422b3f67..f490d1897c56 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2366,6 +2366,8 @@ static int btrfs_prepare_sprout(struct 
> btrfs_fs_info *fs_info)
>  	u64 super_flags;
>
>  	lockdep_assert_held(&uuid_mutex);
> +	lockdep_assert_held(&fs_devices->device_list_mutex);
> +
>
Just a reminder: clone_fs_devices() still takes the mutex in 
misc-next.

>  	if (!fs_devices->seeding)
>  		return -EINVAL;
>
> @@ -2397,7 +2399,6 @@ static int btrfs_prepare_sprout(struct 
> btrfs_fs_info *fs_info)
>  	INIT_LIST_HEAD(&seed_devices->alloc_list);
>  	mutex_init(&seed_devices->device_list_mutex);
>
> -	mutex_lock(&fs_devices->device_list_mutex);
>  	list_splice_init_rcu(&fs_devices->devices, 
>  &seed_devices->devices,
>  			      synchronize_rcu);
>  	list_for_each_entry(device, &seed_devices->devices, dev_list)
> @@ -2413,7 +2414,6 @@ static int btrfs_prepare_sprout(struct 
> btrfs_fs_info *fs_info)
>  	generate_random_uuid(fs_devices->fsid);
>  	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, 
>  BTRFS_FSID_SIZE);
>  	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
> -	mutex_unlock(&fs_devices->device_list_mutex);
>
>  	super_flags = btrfs_super_flags(disk_super) &
>  		      ~BTRFS_SUPER_FLAG_SEEDING;
> @@ -2588,6 +2588,7 @@ int btrfs_init_new_device(struct 
> btrfs_fs_info *fs_info, const char *device_path
>  	device->dev_stats_valid = 1;
>  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>
> +	mutex_lock(&fs_devices->device_list_mutex);
>  	if (seeding_dev) {
>  		btrfs_clear_sb_rdonly(sb);
>  		ret = btrfs_prepare_sprout(fs_info);
>
the erorr case:
if (ret) {
    mutex_unlock(&fs_devices->device_list_mutex);
    ...
}

Thanks.

--
Su

> @@ -2599,7 +2600,6 @@ int btrfs_init_new_device(struct 
> btrfs_fs_info *fs_info, const char *device_path
>
>  	device->fs_devices = fs_devices;
>
> -	mutex_lock(&fs_devices->device_list_mutex);
>  	mutex_lock(&fs_info->chunk_mutex);
>  	list_add_rcu(&device->dev_list, &fs_devices->devices);
>  	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
