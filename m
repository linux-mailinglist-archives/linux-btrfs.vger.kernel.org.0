Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3213B014
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgANQyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 11:54:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:54556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgANQyZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 11:54:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EF6E1AEBA;
        Tue, 14 Jan 2020 16:54:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4AD29DA795; Tue, 14 Jan 2020 17:54:11 +0100 (CET)
Date:   Tue, 14 Jan 2020 17:54:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/6] btrfs: Read stripe len directly in btrfs_rmap_block
Message-ID: <20200114165411.GG3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191119120555.6465-1-nborisov@suse.com>
 <20191119120555.6465-6-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119120555.6465-6-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 02:05:54PM +0200, Nikolay Borisov wrote:
> extent_map::orig_block_len contains the size of a physical stripe when
> it's used to describe block groups. So get the size directly in
> btrfs_rmap_block rather than open-coding the calculations. No
> functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/block-group.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c3b1f304bc70..2ab4d9cb598a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1546,17 +1546,12 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>  		return -EIO;
>  
>  	map = em->map_lookup;
> -	data_stripe_length = em->len;
> +	data_stripe_length = em->orig_block_len;
>  	io_stripe_size = map->stripe_len;
>  
> -	if (map->type & BTRFS_BLOCK_GROUP_RAID10)
> -		data_stripe_length = div_u64(data_stripe_length, map->num_stripes / map->sub_stripes);
> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID0)
> -		data_stripe_length = div_u64(data_stripe_length, map->num_stripes);
> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> -		data_stripe_length = div_u64(data_stripe_length, nr_data_stripes(map));
> +	/* For raid5/6 adjust to a full IO stripe length */
> +	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>  		io_stripe_size = map->stripe_len * nr_data_stripes(map);

I'm not convinced this is 'no functional change' so will merge only
patches 1-4 for now as I have reviewed them and want to add them to
misc-next before the 5.6 freeze.
