Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46106213CF0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgGCPp1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 11:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:53374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCPp0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 11:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7FCDAC24;
        Fri,  3 Jul 2020 15:45:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 090E3DA87C; Fri,  3 Jul 2020 17:45:06 +0200 (CEST)
Date:   Fri, 3 Jul 2020 17:45:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/10] btrfs: raid56: Use in_range where applicable
Message-ID: <20200703154506.GD27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-6-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702134650.16550-6-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 04:46:45PM +0300, Nikolay Borisov wrote:
> While at it use the opportunity to simplify find_logical_bio_stripe by
> reducing the scope of 'stripe_start' variable and squash the
> sector-to-bytes conversion on one line.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/raid56.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index d9415a22617b..d89dd3030bba 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1349,7 +1349,6 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
>  			   struct bio *bio)
>  {
>  	u64 physical = bio->bi_iter.bi_sector;
> -	u64 stripe_start;
>  	int i;
>  	struct btrfs_bio_stripe *stripe;
>  
> @@ -1357,9 +1356,7 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
>  
>  	for (i = 0; i < rbio->bbio->num_stripes; i++) {
>  		stripe = &rbio->bbio->stripes[i];
> -		stripe_start = stripe->physical;
> -		if (physical >= stripe_start &&
> -		    physical < stripe_start + rbio->stripe_len &&
> +		if (in_range(physical, stripe->physical, rbio->stripe_len) &&
>  		    stripe->dev->bdev &&
>  		    bio->bi_disk == stripe->dev->bdev->bd_disk &&
>  		    bio->bi_partno == stripe->dev->bdev->bd_partno) {
> @@ -1377,18 +1374,13 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
>  static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
>  				   struct bio *bio)
>  {
> -	u64 logical = bio->bi_iter.bi_sector;
> -	u64 stripe_start;
> +	u64 logical = bio->bi_iter.bi_sector << 9;

FYI, if bi_iter::bi_sector is shifted left or right, it needs the u64
cast because the type sector_t is not always 64bit for some reasons.
We've had bugs with the conversion on 32bit arches, for consistency it
needs to be there.

>  	int i;
>  
> -	logical <<= 9;
> -
>  	for (i = 0; i < rbio->nr_data; i++) {
> -		stripe_start = rbio->bbio->raid_map[i];
> -		if (logical >= stripe_start &&
> -		    logical < stripe_start + rbio->stripe_len) {
> +		u64 stripe_start = rbio->bbio->raid_map[i];
> +		if (in_range(logical, stripe_start, rbio->stripe_len))
>  			return i;
> -		}
>  	}
>  	return -1;
>  }
> -- 
> 2.17.1
