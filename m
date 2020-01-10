Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704031373DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgAJQmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 11:42:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:34086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgAJQmY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 11:42:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 52F5DACD5;
        Fri, 10 Jan 2020 16:42:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 363D7DA78B; Fri, 10 Jan 2020 17:42:12 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:42:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: open code log helpers in device_list_add()
Message-ID: <20200110164212.GQ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200110090555.7049-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110090555.7049-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 10, 2020 at 05:05:54PM +0800, Anand Jain wrote:
> fs_info is born during mount, and operations before the mount such as
> scanning and assembling of the device volume should happen without any
> reference to fs_info.
> 
> However the patch commit a9261d4125c9 (btrfs: harden agaist duplicate
> fsid on scanned devices) used fs_info to call btrfs_warn_in_rcu() and
> btrfs_info_in_rcu(), so if fs_info is NULL, the stacked functions leads
> to btrfs_printk() which shall print "unknown" instead of sb->s_id. Or
> even might UAF as reported in [1].
> 
> So do the right thing, don't use btrfs_warn_in_rcu() and
> btrfs_info_in_rcu() in device_list_add() instead just open code it.
> 
> Link:
> [1] https://www.spinics.net/lists/linux-btrfs/msg96524.html
> Fixes: a9261d4125c9 (btrfs: harden agaist duplicate fsid on scanned devices)
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6fd90270e2c7..1a419841fc99 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -889,17 +889,21 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  			if (device->bdev != path_bdev) {
>  				bdput(path_bdev);
>  				mutex_unlock(&fs_devices->device_list_mutex);
> -				btrfs_warn_in_rcu(device->fs_info,
> -			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
> +				rcu_read_lock();
> +				printk_ratelimited(

Avoiding fs_info here is correct but we don't want to use raw printk or
printk_ratelimited anywhere.
