Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34456518FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfFXQte (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 12:49:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732220AbfFXQte (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 12:49:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2029AE74;
        Mon, 24 Jun 2019 16:49:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 839111E2F23; Mon, 24 Jun 2019 18:49:32 +0200 (CEST)
Date:   Mon, 24 Jun 2019 18:49:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/9] blkcg, writeback: Add wbc->no_wbc_acct
Message-ID: <20190624164932.GN32376@quack2.suse.cz>
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
       ^^ btrfs

> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
...
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

Can you add comment here that this is for writeback which has been already
accounted for?

Otherwise the patch looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
