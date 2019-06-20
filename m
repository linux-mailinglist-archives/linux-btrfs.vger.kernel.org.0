Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6844D202
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFTPVr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 11:21:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbfFTPVr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 11:21:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B917CAD5D;
        Thu, 20 Jun 2019 15:21:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 643371E434F; Thu, 20 Jun 2019 17:21:45 +0200 (CEST)
Date:   Thu, 20 Jun 2019 17:21:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/9] blkcg, writeback: Add wbc->no_wbc_acct
Message-ID: <20190620152145.GL30243@quack2.suse.cz>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190615182453.843275-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615182453.843275-3-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 15-06-19 11:24:46, Tejun Heo wrote:
> When writeback IOs are bounced through async layers, the IOs should
> only be accounted against the wbc from the original bdi writeback to
> avoid confusing cgroup inode ownership arbitration.  Add
> wbc->no_wbc_acct to allow disabling wbc accounting.  This will be used
> make btfs compression work well with cgroup IO control.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

I'm completely ignorant of how btrfs compressed writeback works so don't
quite understand implications of this. So does this mean that writeback to
btrfs compressed files won't be able to transition inodes from one memcg to
another? Or are you trying to say the 'wbc' used from async worker thread
is actually a dummy one and we would double-account the writeback?

Anyway, AFAICS no_wbc_acct means: "IO done as a result of this wbc will not
have influence on inode memcg ownership", doesn't it?

								Honza
> ---
>  fs/fs-writeback.c         | 2 +-
>  include/linux/writeback.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index c29cff345b1f..667ba07fffcd 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -724,7 +724,7 @@ void wbc_account_io(struct writeback_control *wbc, struct page *page,
>  	 * behind a slow cgroup.  Ultimately, we want pageout() to kick off
>  	 * regular writeback instead of writing things out itself.
>  	 */
> -	if (!wbc->wb)
> +	if (!wbc->wb || wbc->no_wbc_acct)
>  		return;
>  
>  	id = mem_cgroup_css_from_page(page)->id;
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 738a0c24874f..b8f5f000cde4 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -68,6 +68,7 @@ struct writeback_control {
>  	unsigned for_reclaim:1;		/* Invoked from the page allocator */
>  	unsigned range_cyclic:1;	/* range_start is cyclic */
>  	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
> +	unsigned no_wbc_acct:1;		/* skip wbc IO accounting */
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	struct bdi_writeback *wb;	/* wb this writeback is issued under */
>  	struct inode *inode;		/* inode being written out */
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
