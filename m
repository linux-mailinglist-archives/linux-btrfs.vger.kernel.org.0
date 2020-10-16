Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0469290715
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408794AbgJPOWR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 10:22:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394682AbgJPOWR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 10:22:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB938B1F7;
        Fri, 16 Oct 2020 14:22:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C5986DA7C3; Fri, 16 Oct 2020 16:20:47 +0200 (CEST)
Date:   Fri, 16 Oct 2020 16:20:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: Be smarter when sleeping in
 transaction_kthread
Message-ID: <20201016142047.GS6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201008122430.93433-1-nborisov@suse.com>
 <20201008122430.93433-5-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122430.93433-5-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 08, 2020 at 03:24:30PM +0300, Nikolay Borisov wrote:
> If transaction_kthread is woken up before
> btrfs_fs_info::commit_interval seconds have elapsed it will sleep for a
> fixed period of 5 seconds. This is not a problem per-se but is not
> accuaret, instead the code should sleep for an interval which guarantees
> on next wakeup commit_interval would have passed. Since time tracking is
> not accurate add 1 second to ensure next wake up would be after
> commit_interval.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/disk-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c5d3e7f75066..a1fe99cf0831 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1735,7 +1735,7 @@ static int transaction_kthread(void *arg)
>  		if (cur->state < TRANS_STATE_COMMIT_START &&
>  		    delta < fs_info->commit_interval) {
>  			spin_unlock(&fs_info->trans_lock);
> -			delay = msecs_to_jiffies(5000);
> +			delay = msecs_to_jiffies((1+delta) * 1000);

This does not seem right. Delta is number of seconds since the
transaction started, so we need to sleep for the remaining time. Which
is commit_interval - delta.
