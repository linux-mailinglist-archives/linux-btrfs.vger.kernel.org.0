Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C941132F71
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 14:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfFCMVF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 08:21:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:56724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbfFCMVF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 08:21:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03AD1AE4B;
        Mon,  3 Jun 2019 12:21:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12668DA85E; Mon,  3 Jun 2019 14:21:54 +0200 (CEST)
Date:   Mon, 3 Jun 2019 14:21:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Andrey Abramov <st5pub@yandex.ru>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix -Wunused-but-set-variable warnings
Message-ID: <20190603122152.GM15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Andrey Abramov <st5pub@yandex.ru>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190531195349.31129-1-st5pub@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531195349.31129-1-st5pub@yandex.ru>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 31, 2019 at 10:53:49PM +0300, Andrey Abramov wrote:
> Fix -Wunused-but-set-variable warnings in raid56.c and sysfs.c files

Please ignore the warnings for now. The RAID56 needs more cleanups than
that an the sysfs part needs to be reworked. The stale code comes from
e410e34fad913dd568ec28d2a9949694324c14db that reverted
14e46e04958df740c6c6a94849f176159a333f13.

> Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
> ---
>  fs/btrfs/raid56.c | 32 +++++++++++---------------------
>  fs/btrfs/sysfs.c  |  5 +----
>  2 files changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index f3d0576dd327..4ab29eacfdf3 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1182,22 +1182,17 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>  	int nr_data = rbio->nr_data;
>  	int stripe;
>  	int pagenr;
> -	int p_stripe = -1;
> -	int q_stripe = -1;
> +	int is_q_stripe = 0;
>  	struct bio_list bio_list;
>  	struct bio *bio;
>  	int ret;
>  
>  	bio_list_init(&bio_list);
>  
> -	if (rbio->real_stripes - rbio->nr_data == 1) {
> -		p_stripe = rbio->real_stripes - 1;
> -	} else if (rbio->real_stripes - rbio->nr_data == 2) {
> -		p_stripe = rbio->real_stripes - 2;
> -		q_stripe = rbio->real_stripes - 1;
> -	} else {
> +	if (rbio->real_stripes - rbio->nr_data == 2)
> +		is_q_stripe = 1;
> +	else if (rbio->real_stripes - rbio->nr_data != 1)
>  		BUG();
> -	}

The original code is better structured, enumerates the expected cases
and leaves a catch-all branch.

>  
>  	/* at this point we either have a full stripe,
>  	 * or we've read the full stripe from the drive.
> @@ -1241,7 +1236,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>  		SetPageUptodate(p);
>  		pointers[stripe++] = kmap(p);
>  
> -		if (q_stripe != -1) {
> +		if (is_q_stripe) {
>  
>  			/*
>  			 * raid6, add the qstripe and call the
> @@ -2340,8 +2335,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
>  	int nr_data = rbio->nr_data;
>  	int stripe;
>  	int pagenr;
> -	int p_stripe = -1;

To get rid of the warning, perhaps just this initialization could be
removed, the rest of the code untouched.

> -	int q_stripe = -1;
> +	int is_q_stripe = 0;
>  	struct page *p_page = NULL;
>  	struct page *q_page = NULL;
>  	struct bio_list bio_list;
