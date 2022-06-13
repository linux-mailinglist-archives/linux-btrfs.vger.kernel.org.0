Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA92549EF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 22:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiFMUXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351443AbiFMUXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 16:23:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE94F33
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 12:04:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9B89821C34;
        Mon, 13 Jun 2022 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655147048;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iazwCmIZ4QhJVZx/Z/zRnt2s5+79HyTqUfnp95fUsv4=;
        b=vgxamHcbrfvIA0j5LmIaaZ6bT1Gm2zA29q91EHoPdSCcH6gfcxjDuHYb2U8PbiDdvMfUqY
        wfAf7CpUazYmk8lNhpU7guCUUdB31DMyYPiarBIntEoZf+PHLE9PzyGAFwe2cq+um7qmjz
        eqpIr6LoS7n1pcGfyj8DZ0mm9zlgdok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655147048;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iazwCmIZ4QhJVZx/Z/zRnt2s5+79HyTqUfnp95fUsv4=;
        b=KQGSykSOaeccpRozVPiQrj/GjuLI6b9K6HqdOuQCaiqLhUgSo5dnunzkBTEXziM/HDtCk/
        RIwtPnmm2zdn4NAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6217313443;
        Mon, 13 Jun 2022 19:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AqoJFyiKp2JTKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 13 Jun 2022 19:04:08 +0000
Date:   Mon, 13 Jun 2022 20:59:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: Add the capability of getting commit stats in
 BTRFS
Message-ID: <20220613185935.GG20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220610205406.301397-1-iangelak@fb.com>
 <20220610205406.301397-2-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610205406.301397-2-iangelak@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 10, 2022 at 01:54:07PM -0700, Ioannis Angelakopoulos wrote:
> First we add  "struct btrfs_commit_stats" data structure under "fs_info"
> to store the commit stats for BTRFS that will be exposed through sysfs
> 
> The stats exposed are: 1) The number of commits so far, 2) The duration of
> the last commit in ms, 3) The maximum commit duration seen so far in ms
> and 4) The total duration for all commits so far in ms.
> 
> The update of the commit stats occurs after the commit thread has gone
> through all the logic that checks if there is another thread committing
> at the same time. This means that we only account for actual commit work
> in the commit stats we report and not the time the thread spends waiting
> until it is ready to do the commit work.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>  fs/btrfs/ctree.h       | 14 ++++++++++++++
>  fs/btrfs/disk-io.c     |  6 ++++++
>  fs/btrfs/transaction.c | 38 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f7afdfd0bae7..d4cc38451c7b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -660,6 +660,18 @@ enum btrfs_exclusive_operation {
>  	BTRFS_EXCLOP_SWAP_ACTIVATE,
>  };
>  
> +/* Storing data about btrfs commits. The data are accessible over sysfs */
> +struct btrfs_commit_stats {
> +	/* Total number of commits */
> +	u64 commit_counter;
> +	/* The maximum commit duration so far*/
> +	u64 max_commit_dur;
> +	/* The last commit duration */
> +	u64 last_commit_dur;
> +	/* The total commit duration */
> +	u64 total_commit_dur;
> +};
> +
>  struct btrfs_fs_info {
>  	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
>  	unsigned long flags;
> @@ -1082,6 +1094,8 @@ struct btrfs_fs_info {
>  	spinlock_t eb_leak_lock;
>  	struct list_head allocated_ebs;
>  #endif
> +
> +	struct btrfs_commit_stats *commit_stats;

As long as this is in fs_info and reasonable size I don't see a reason
to make the stats allocated dynamically, compared to being embedded
either as a struct or array of u64.

> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -10,6 +10,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/blkdev.h>
>  #include <linux/uuid.h>
> +#include <linux/timekeeping.h>
>  #include "misc.h"
>  #include "ctree.h"
>  #include "disk-io.h"
> @@ -674,7 +675,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>  	 * and then we deadlock with somebody doing a freeze.
>  	 *
>  	 * If we are ATTACH, it means we just want to catch the current
> -	 * transaction and commit it, so we needn't do sb_start_intwrite(). 
> +	 * transaction and commit it, so we needn't do sb_start_intwrite().

Unrelated change.

>  	 */
>  	if (type & __TRANS_FREEZABLE)
>  		sb_start_intwrite(fs_info->sb);
> @@ -2084,12 +2085,30 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
>  	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
>  }
>  
> +static void update_commit_stats(struct btrfs_fs_info *fs_info,
> +								ktime_t interval)
> +{
> +	/* Increase the successful commits counter */

Such comments are really useless, it repeats in words what the code does
not why and does not bring any new information for understanding. I'd
not put any comment into this function at all, it's clear from the name
and it's short.

> +	fs_info->commit_stats->commit_counter += 1;
> +	/* Update the last commit duration */
> +	fs_info->commit_stats->last_commit_dur = interval / 1000000;
> +	/* Update the maximum commit duration */
> +	fs_info->commit_stats->max_commit_dur =
> +				fs_info->commit_stats->max_commit_dur >	interval / 1000000 ?
> +				fs_info->commit_stats->max_commit_dur :	interval / 1000000;
> +	/* Update the total commit duration */
> +	fs_info->commit_stats->total_commit_dur += interval / 1000000;

4 times repeated 'interfal / 1000000' that converts the parameter from
ns to ms, so that should be done already in the caller.

> +}
> +
>  int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_transaction *cur_trans = trans->transaction;
>  	struct btrfs_transaction *prev_trans = NULL;
>  	int ret;
> +	ktime_t start_time;
> +	ktime_t end_time;
> +	ktime_t interval;
>  
>  	ASSERT(refcount_read(&trans->use_count) == 1);
>  
> @@ -2214,6 +2233,12 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  		}
>  	}
>  
> +	/*
> +	 * Get the time spent on the work done by the commit thread and not
> +	 * the time spent on a previous commit
> +	 */
> +	start_time = ktime_get_ns();
> +
>  	extwriter_counter_dec(cur_trans, trans->type);
>  
>  	ret = btrfs_start_delalloc_flush(fs_info);
> @@ -2462,6 +2487,17 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  
>  	kmem_cache_free(btrfs_trans_handle_cachep, trans);
>  
> +	end_time = ktime_get_ns();

I'm not sure the end time should be read here, there's a tracepoint a
few lines above marking end of the transaction.

> +	interval = end_time - start_time;

end_time is used only once, not needed

> +
> +	/*
> +	 * Protect the commit stats updates from concurrent updates through
> +	 * sysfs.
> +	 */
> +	spin_lock(&fs_info->trans_lock);
> +	update_commit_stats(fs_info, interval);

So here pass interval/1000000

> +	spin_unlock(&fs_info->trans_lock);
> +
>  	return ret;
>  
>  unlock_reloc:
> -- 
> 2.30.2
> 
