Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C55534F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 16:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351842AbiFUOwR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiFUOwP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 10:52:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB73275CC
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 07:52:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E5301F461;
        Tue, 21 Jun 2022 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655823133;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQrpkrZ8w8cjQc71KR7BduLd04H4vtv7yCs4nnebcnM=;
        b=TJBWE7G9F+zIFaJGGeAhInxsaNCnlFDGnGKa0985Z/uNrRg+Pi2msJMN3JTc4lsrkAfsx4
        We8Mpw9FMIXC0Yc620Iih3Jipl8tZIoiQNIQ6V9+nRPSJBJ2cZf6cPZr2d9UpPKCinouKL
        ydtP1AFFaAZg4uxLZLdYnA3Y1KzR/D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655823133;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQrpkrZ8w8cjQc71KR7BduLd04H4vtv7yCs4nnebcnM=;
        b=IaJwjgPIg9qN90mjzn0KNisibzRKmMDE4ZWyUXjMxd5O1+2/vHw88d/khZ2RYMLj1YwP5U
        4VogkLjpwAWH6BCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F34F713638;
        Tue, 21 Jun 2022 14:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YVhXOhzbsWLdWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Jun 2022 14:52:12 +0000
Date:   Tue, 21 Jun 2022 16:47:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] btrfs: Add the capability of getting commit stats
 in BTRFS
Message-ID: <20220621144735.GB20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-2-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614222231.2582876-2-iangelak@fb.com>
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

On Tue, Jun 14, 2022 at 03:22:32PM -0700, Ioannis Angelakopoulos wrote:
> First we add  "struct btrfs_commit_stats" data structure under "fs_info"
> in fs/btrfs/ctree.h to store the commit stats for BTRFS that will be
> exposed through sysfs.
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
>  fs/btrfs/disk-io.c     |  5 +++++
>  fs/btrfs/transaction.c | 29 +++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f7afdfd0bae7..ff8a3fba0b80 100644
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
> +	struct btrfs_commit_stats commit_stats;

This should be moved before the #ifdef members.

>  };
>  
>  static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..3478732e322f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3133,6 +3133,11 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  	fs_info->sectorsize_bits = ilog2(4096);
>  	fs_info->stripesize = 4096;
>  
> +	fs_info->commit_stats.commit_counter = 0;
> +	fs_info->commit_stats.max_commit_dur = 0;
> +	fs_info->commit_stats.last_commit_dur = 0;
> +	fs_info->commit_stats.total_commit_dur = 0;

You don't need to explicitly set zeros for native types.

> +
>  	spin_lock_init(&fs_info->swapfile_pins_lock);
>  	fs_info->swapfile_pins = RB_ROOT;
>  
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 06c0a958d114..9cb09aa05275 100644
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
> @@ -2084,12 +2085,24 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
>  	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
>  }
>  
> +static void update_commit_stats(struct btrfs_fs_info *fs_info,
> +								ktime_t interval)

Join the lines

> +{
> +	fs_info->commit_stats.commit_counter += 1;

	fs_info->commit_stats.commit_counter++;

> +	fs_info->commit_stats.last_commit_dur = interval;
> +	fs_info->commit_stats.max_commit_dur = max_t(u64,
> +				fs_info->commit_stats.max_commit_dur, interval);
> +	fs_info->commit_stats.total_commit_dur += interval;
> +}
> +
>  int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_transaction *cur_trans = trans->transaction;
>  	struct btrfs_transaction *prev_trans = NULL;
>  	int ret;
> +	ktime_t start_time;
> +	ktime_t interval;
>  
>  	ASSERT(refcount_read(&trans->use_count) == 1);
>  
> @@ -2214,6 +2227,12 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  		}
>  	}
>  
> +	/*
> +	 * Get the time spent on the work done by the commit thread and not
> +	 * the time spent waiting on a previous commit
> +	 */
> +	start_time = ktime_get_ns();
> +
>  	extwriter_counter_dec(cur_trans, trans->type);
>  
>  	ret = btrfs_start_delalloc_flush(fs_info);
> @@ -2455,6 +2474,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  
>  	trace_btrfs_transaction_commit(fs_info);
>  
> +	interval = ktime_get_ns() - start_time;
> +
>  	btrfs_scrub_continue(fs_info);
>  
>  	if (current->journal_info == trans)
> @@ -2462,6 +2483,14 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  
>  	kmem_cache_free(btrfs_trans_handle_cachep, trans);
>  
> +	/*
> +	 * Protect the commit stats updates from concurrent updates through
> +	 * sysfs.
> +	 */

The comment should be next to the definition of commit stats

> +	spin_lock(&fs_info->super_lock);
> +	update_commit_stats(fs_info, interval);
> +	spin_unlock(&fs_info->super_lock);
> +
>  	return ret;
>  
>  unlock_reloc:
> -- 
> 2.30.2
> 
