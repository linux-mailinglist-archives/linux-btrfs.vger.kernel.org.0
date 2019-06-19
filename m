Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFFD4B7A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfFSMIq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 08:08:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfFSMIq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 08:08:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6C65AC54
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 12:08:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 71184DA88C; Wed, 19 Jun 2019 14:09:31 +0200 (CEST)
Date:   Wed, 19 Jun 2019 14:09:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/6] btrfs: use raid_attr for minimum stripe count in
 btrfs_calc_avail_data_space
Message-ID: <20190619120931.GD8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1560880630.git.dsterba@suse.com>
 <ffdc7e77015c2f5ad45de7acc2336fe2901bb605.1560880630.git.dsterba@suse.com>
 <7adb54d3-38c9-738b-caf0-c6926ab19dbb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7adb54d3-38c9-738b-caf0-c6926ab19dbb@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 10:51:14AM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.06.19 г. 21:00 ч., David Sterba wrote:
> > Minimum stripe count matches the minimum devices required for a given
> > profile. The open coded assignments match the raid_attr table.
> > 
> > What's changed here is the meaning for RAID5/6. Previously their
> > min_stripes would be 1, while newly it's devs_min. This however shold be
> > the same as before because it's not possible to create filesystem on
> > fewer devices than the raid_attr table allows.
> > 
> > There's no adjustment regarding the parity stripes (like
> > calc_data_stripes does), because we're interested in overall space that
> > would fit on the devices.
> > 
> > Missing devices make no difference for the whole calculation, we have
> > the size stored in the structures.
> 
> I think the clean up in this function should include more here's list of
> things which I think will make it more readable.

I did not intend to clean up the whole function in this patch, only whre
the raid table could be used.

> Something like the
> attached diff on top of your patch:
> 
> 

> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 6e196b8a0820..230aef8314da 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1898,11 +1898,10 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
>  	struct btrfs_device_info *devices_info;
>  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>  	struct btrfs_device *device;
> -	u64 skip_space;
>  	u64 type;
>  	u64 avail_space;
>  	u64 min_stripe_size;
> -	int min_stripes = 1, num_stripes = 1;
> +	int num_stripes = 1;
>  	int i = 0, nr_devices;
>  
>  	/*
> @@ -1957,28 +1956,21 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
>  		avail_space = device->total_bytes - device->bytes_used;
>  
>  		/* align with stripe_len */
> -		avail_space = div_u64(avail_space, BTRFS_STRIPE_LEN);
> -		avail_space *= BTRFS_STRIPE_LEN;
> +		avail_space = rounddown(avail_space, BTRFS_STRIPE_LEN);

As long as the stripe length is a constant, this is fine. rounddown uses
% (modulo) so this can be come division that will not work for u64
types.

>  
>  		/*
>  		 * In order to avoid overwriting the superblock on the drive,
>  		 * btrfs starts at an offset of at least 1MB when doing chunk
>  		 * allocation.
> +		 *
> +		 * This ensures we have at least min_stripe_size free space
> +		 * after excluding 1mb.
>  		 */
> -		skip_space = SZ_1M;
> -
> -		/*
> -		 * we can use the free space in [0, skip_space - 1], subtract
> -		 * it from the total.
> -		 */
> -		if (avail_space && avail_space >= skip_space)
> -			avail_space -= skip_space;
> -		else
> -			avail_space = 0;
> -
> -		if (avail_space < min_stripe_size)
> +		if (avail_space <= SZ_1M + min_stripe_size)
>  			continue;
>  
> +		avail_space -= SZ_1M;
> +
>  		devices_info[i].dev = device;
>  		devices_info[i].max_avail = avail_space;
>  
> @@ -1992,9 +1984,8 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
>  
>  	i = nr_devices - 1;
>  	avail_space = 0;
> -	while (nr_devices >= min_stripes) {
> -		if (num_stripes > nr_devices)
> -			num_stripes = nr_devices;
> +	while (nr_devices >= rattr->devs_min) {
> +		num_stripes = min(num_stripes, nr_devices);
>  
>  		if (devices_info[i].max_avail >= min_stripe_size) {
>  			int j;

All of the above look good to me, feel free to send them as proper
patches.
