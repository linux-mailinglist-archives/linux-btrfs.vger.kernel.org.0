Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C62298C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 14:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgGVM6O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 08:58:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVM6N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 08:58:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FF58AC24;
        Wed, 22 Jul 2020 12:58:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 37947DA70B; Wed, 22 Jul 2020 14:57:46 +0200 (CEST)
Date:   Wed, 22 Jul 2020 14:57:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/3] btrfs: fix lockdep splat in open_fs_devices
Message-ID: <20200722125745.GS3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200717191229.2283043-1-josef@toxicpanda.com>
 <20200717191229.2283043-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717191229.2283043-2-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 17, 2020 at 03:12:27PM -0400, Josef Bacik wrote:
> Fix this by not holding the ->device_list_mutex at this point.  The
> device_list_mutex exists to protect us from modifying the device list
> while the file system is running.
> 
> However it can also be modified by doing a scan on a device.  But this
> action is specifically protected by the uuid_mutex, which we are holding
> here.  We cannot race with opening at this point because we have the
> ->s_mount lock held during the mount.  Not having the
> ->device_list_mutex here is perfectly safe as we're not going to change
> the devices at this point.

Agreed, the uuid_mutex is sufficient here, since 81ffd56b574 ("btrfs:
fix mount and ioctl device scan ioctl race") that excludes the critical
parts of mount and scan.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/volumes.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ce01e44f8134..20295441251a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -258,6 +258,9 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   * may be used to exclude some operations from running concurrently without any
>   * modifications to the list (see write_all_supers)
>   *
> + * Is not required at mount and close times, because our device list is
> + * protected by the uuid_mutex at that point.

This is correct, however there's one comment a few lines above about
unid_mutex

  "does not protect: manipulation of the fs_devices::devices list!"

so I'll update it means 'not in general but there are exceptions like
mount context'.

> + *
>   * balance_mutex
>   * -------------
>   * protects balance structures (status, state) and context accessed from
> @@ -602,6 +605,11 @@ static int btrfs_free_stale_devices(const char *path,
>  	return ret;
>  }
>  
> +/*
> + * This is only used on mount, and we are protected from competing things
> + * messing with our fs_devices by the uuid_mutex, thus we do not need the
> + * fs_devices->device_list_mutex here.
> + */
>  static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  			struct btrfs_device *device, fmode_t flags,
>  			void *holder)
> @@ -1230,7 +1238,6 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  
>  	lockdep_assert_held(&uuid_mutex);
>  
> -	mutex_lock(&fs_devices->device_list_mutex);

I'll leave a comment here as the device list is clearly modified
(list_sort).

>  	if (fs_devices->opened) {
>  		fs_devices->opened++;
>  		ret = 0;
> @@ -1238,7 +1245,6 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  		list_sort(NULL, &fs_devices->devices, devid_cmp);
>  		ret = open_fs_devices(fs_devices, flags, holder);
>  	}
> -	mutex_unlock(&fs_devices->device_list_mutex);
>  
>  	return ret;
>  }
> -- 
> 2.24.1
