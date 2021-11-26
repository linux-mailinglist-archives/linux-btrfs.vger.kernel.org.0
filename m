Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E77C45F278
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Nov 2021 17:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbhKZQx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Nov 2021 11:53:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353431AbhKZQv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Nov 2021 11:51:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3C6CC2191E;
        Fri, 26 Nov 2021 16:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637945294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTcMpDPSRmQyACR930Xaph00x8q1CdePBk4ZN6RyVv8=;
        b=Sv9PnovJpW6QRIgpszRxPa103KxV6zX5p7Yn5w2rOaI2NsD28QoLuf4XLufPa8u/mQMj/b
        QPJ3ebIQOHp+Xns/45aSyLPLCS5BpRcqkyKT85qmz28cnSXnVOqWSeuMCYoeaxyCzOrJjR
        7wTKyMMprDG/dnrORzEMzw/JJBLQIBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637945294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTcMpDPSRmQyACR930Xaph00x8q1CdePBk4ZN6RyVv8=;
        b=LlC7BXE3OmmUvdSwE2k6Zupg7hEFoUgpiKyjLyx9E/pPjX3jyK8gaNywoI3k7k06u6Jysq
        81VzjmatU37ip5CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 031B9A3B9A;
        Fri, 26 Nov 2021 16:48:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3C76ADA735; Fri, 26 Nov 2021 17:48:05 +0100 (CET)
Date:   Fri, 26 Nov 2021 17:48:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 10/21] btrfs: move struct scrub_ctx to scrub.h
Message-ID: <20211126164804.GC28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
 <c120d508b232845c70d4c5378c12b0152d7d700e.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c120d508b232845c70d4c5378c12b0152d7d700e.1637745470.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 01:30:36AM -0800, Johannes Thumshirn wrote:
> Move 'struct scrub_ctx' to the newly created scrub.h file.
> 
> This is a preparation step for moving zoned only code from scrub.c to
> zoned.c.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/scrub.c | 44 +----------------------------------------
>  fs/btrfs/scrub.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 43 deletions(-)
>  create mode 100644 fs/btrfs/scrub.h
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 70cf1f487748c..a2c42ff544701 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -21,6 +21,7 @@
>  #include "raid56.h"
>  #include "block-group.h"
>  #include "zoned.h"
> +#include "scrub.h"
>  
>  /*
>   * This is only the first step towards a full-features scrub. It reads all
> @@ -46,7 +47,6 @@ struct scrub_ctx;
>   */
>  #define SCRUB_PAGES_PER_RD_BIO	32	/* 128k per bio */
>  #define SCRUB_PAGES_PER_WR_BIO	32	/* 128k per bio */
> -#define SCRUB_BIOS_PER_SCTX	64	/* 8MB per device in flight */
>  
>  /*
>   * the following value times PAGE_SIZE needs to be large enough to match the
> @@ -151,48 +151,6 @@ struct scrub_parity {
>  	unsigned long		bitmap[];
>  };
>  
> -struct scrub_ctx {
> -	struct scrub_bio	*bios[SCRUB_BIOS_PER_SCTX];
> -	struct btrfs_fs_info	*fs_info;
> -	int			first_free;
> -	int			curr;
> -	atomic_t		bios_in_flight;
> -	atomic_t		workers_pending;
> -	spinlock_t		list_lock;
> -	wait_queue_head_t	list_wait;
> -	struct list_head	csum_list;
> -	atomic_t		cancel_req;
> -	int			readonly;
> -	int			pages_per_rd_bio;
> -
> -	/* State of IO submission throttling affecting the associated device */
> -	ktime_t			throttle_deadline;
> -	u64			throttle_sent;
> -
> -	int			is_dev_replace;
> -	u64			write_pointer;
> -
> -	struct scrub_bio        *wr_curr_bio;
> -	struct mutex            wr_lock;
> -	int                     pages_per_wr_bio; /* <= SCRUB_PAGES_PER_WR_BIO */
> -	struct btrfs_device     *wr_tgtdev;
> -	bool                    flush_all_writes;
> -
> -	/*
> -	 * statistics
> -	 */
> -	struct btrfs_scrub_progress stat;
> -	spinlock_t		stat_lock;
> -
> -	/*
> -	 * Use a ref counter to avoid use-after-free issues. Scrub workers
> -	 * decrement bios_in_flight and workers_pending and then do a wakeup
> -	 * on the list_wait wait queue. We must ensure the main scrub task
> -	 * doesn't free the scrub context before or while the workers are
> -	 * doing the wakeup() call.
> -	 */
> -	refcount_t              refs;
> -};
>  
>  struct scrub_warning {
>  	struct btrfs_path	*path;
> diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
> new file mode 100644
> index 0000000000000..3eb8c8905c902
> --- /dev/null
> +++ b/fs/btrfs/scrub.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_SCRUB_H
> +#define BTRFS_SCRUB_H
> +
> +#define SCRUB_BIOS_PER_SCTX	64	/* 8MB per device in flight */

> +struct scrub_ctx {
> +	struct scrub_bio	*bios[SCRUB_BIOS_PER_SCTX];
> +	struct btrfs_fs_info	*fs_info;
> +	int			first_free;
> +	int			curr;
> +	atomic_t		bios_in_flight;
> +	atomic_t		workers_pending;
> +	spinlock_t		list_lock;
> +	wait_queue_head_t	list_wait;
> +	struct list_head	csum_list;
> +	atomic_t		cancel_req;
> +	int			readonly;
> +	int			pages_per_rd_bio;
> +
> +	/* State of IO submission throttling affecting the associated device */
> +	ktime_t			throttle_deadline;
> +	u64			throttle_sent;
> +
> +	int			is_dev_replace;
> +	u64			write_pointer;
> +
> +	struct scrub_bio        *wr_curr_bio;
> +	struct mutex            wr_lock;
> +	int                     pages_per_wr_bio; /* <= SCRUB_PAGES_PER_WR_BIO */
> +	struct btrfs_device     *wr_tgtdev;
> +	bool                    flush_all_writes;
> +
> +	/*
> +	 * statistics
> +	 */
> +	struct btrfs_scrub_progress stat;
> +	spinlock_t		stat_lock;
> +
> +	/*
> +	 * Use a ref counter to avoid use-after-free issues. Scrub workers
> +	 * decrement bios_in_flight and workers_pending and then do a wakeup
> +	 * on the list_wait wait queue. We must ensure the main scrub task
> +	 * doesn't free the scrub context before or while the workers are
> +	 * doing the wakeup() call.
> +	 */
> +	refcount_t              refs;
> +};

Headers should be self contained and pull all includes or do forward
definitions, the structure contains many types that need defining.
