Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9827474D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIVRN5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 13:13:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVRN5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 13:13:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C88BAD49;
        Tue, 22 Sep 2020 17:14:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 13787DA6E9; Tue, 22 Sep 2020 19:12:40 +0200 (CEST)
Date:   Tue, 22 Sep 2020 19:12:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: init device stats for seed devices
Message-ID: <20200922171239.GG6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1600461724.git.josef@toxicpanda.com>
 <b0c2be2e6722f091821521301f251628afcd8313.1600461724.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c2be2e6722f091821521301f251628afcd8313.1600461724.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 18, 2020 at 04:44:32PM -0400, Josef Bacik wrote:
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
>  fs/btrfs/volumes.c | 88 +++++++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6c7c8819cb31..c0cea9f5fdbc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7223,61 +7223,69 @@ static void btrfs_set_dev_stats_value(struct extent_buffer *eb,
>  			    sizeof(val));
>  }
>  
> -int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
> +static void __btrfs_init_dev_stats(struct btrfs_fs_info *fs_info,
> +				   struct btrfs_device *device,
> +				   struct btrfs_path *path)

__ is not necessary and can be avoided by naming the function properly,
as it initializes the stats on a device

>  {
> -	struct btrfs_key key;
>  	struct btrfs_root *dev_root = fs_info->dev_root;

The fs_info parameter is used only once, just to read the dev_root, that
is also used just once. Both can be obtained from the @device.

The path is passed for convenience as it's reused and allocated out of
mutex, so that's fine for a helper.
