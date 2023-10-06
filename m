Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30D57BBCC9
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 18:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjJFQdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 12:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjJFQdg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 12:33:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC58AD;
        Fri,  6 Oct 2023 09:33:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 610241F895;
        Fri,  6 Oct 2023 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696610013;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tzXrEC2Z1vQNVzZFlXqM0dEZQpYH4VaM+7BqEBYBWlA=;
        b=X98zqZkKd5M3PmOJNltssRLo7T1SmeMabgEhF/rfE9V/G5CwLM58dWSMduBr3kbudteTcB
        KcGsXdbMzNYPo8ltxfY+VbvDrADuHpsnQ79UilnJPzcAvbdFqYSY2AgDVz96xmBMezySg6
        33Ud1VRsuyD0vd3X9tqFrU+49GzMgaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696610013;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tzXrEC2Z1vQNVzZFlXqM0dEZQpYH4VaM+7BqEBYBWlA=;
        b=VmL3xqDyv1LtXDyWaiZM1b8BdHeQvyhhvheRX1hXZTJYHGvuMfkqNGEqyC4GzwScnIzHfy
        ZyYVyGHMeg6WQSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3276013586;
        Fri,  6 Oct 2023 16:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7BeiC902IGUdHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 16:33:33 +0000
Date:   Fri, 6 Oct 2023 18:26:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: KCSAN: data-race in btrfs_sync_log [btrfs] /
 btrfs_update_inode [btrfs]
Message-ID: <20231006162649.GL28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <01c15818-5765-408b-aff0-6c68b8c2a874@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01c15818-5765-408b-aff0-6c68b8c2a874@alu.unizg.hr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 10:15:49PM +0200, Mirsad Todorovac wrote:
> Hi,
> 
> On the vanilla 6.6-rc2 torvalds kernel KCSAN reported this data-race:
> 
> [ 2690.990793] ==================================================================
> [ 2690.991470] BUG: KCSAN: data-race in btrfs_sync_log [btrfs] / btrfs_update_inode [btrfs]
> 
> [ 2690.992804] write to 0xffff88811b57faf8 of 4 bytes by task 40555 on cpu 20:
> [ 2690.992815] btrfs_sync_log (/home/marvin/linux/kernel/torvalds2/fs/btrfs/tree-log.c:2964) btrfs
> [ 2690.993484] btrfs_sync_file (/home/marvin/linux/kernel/torvalds2/fs/btrfs/file.c:1954) btrfs
> [ 2690.994149] vfs_fsync_range (/home/marvin/linux/kernel/torvalds2/fs/sync.c:188)
> [ 2690.994161] __x64_sys_fsync (/home/marvin/linux/kernel/torvalds2/./include/linux/file.h:45 /home/marvin/linux/kernel/torvalds2/fs/sync.c:213 /home/marvin/linux/kernel/torvalds2/fs/sync.c:220 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218)
> [ 2690.994172] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
> [ 2690.994186] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)
> 
> [ 2690.994203] read to 0xffff88811b57faf8 of 4 bytes by task 5338 on cpu 21:
> [ 2690.994214] btrfs_update_inode (/home/marvin/linux/kernel/torvalds2/fs/btrfs/transaction.h:175 /home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:4016) btrfs
> [ 2690.994877] btrfs_finish_one_ordered (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:4028 /home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3139) btrfs
> [ 2690.995541] btrfs_finish_ordered_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/inode.c:3230) btrfs
> [ 2690.996205] finish_ordered_fn (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ordered-data.c:304) btrfs
> [ 2690.996871] btrfs_work_helper (/home/marvin/linux/kernel/torvalds2/fs/btrfs/async-thread.c:314) btrfs
> [ 2690.997539] process_one_work (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2630)
> [ 2690.997551] worker_thread (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2697 /home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2784)
> [ 2690.997562] kthread (/home/marvin/linux/kernel/torvalds2/kernel/kthread.c:388)
> [ 2690.997571] ret_from_fork (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/process.c:147)
> [ 2690.997583] ret_from_fork_asm (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:312)
> 
> [ 2690.997598] value changed: 0x00000004 -> 0x00000005
> 
> [ 2690.997613] Reported by Kernel Concurrency Sanitizer on:
> [ 2690.997621] CPU: 21 PID: 5338 Comm: kworker/u65:7 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
> [ 2690.997633] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [ 2690.997640] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [ 2690.998311] ==================================================================
> 
> fs/btrfs/tree-log.c
> -------------------------------------
> 2948         /*
> 2949          * We _must_ update under the root->log_mutex in order to make sure we
> 2950          * have a consistent view of the log root we are trying to commit at
> 2951          * this moment.
> 2952          *
> 2953          * We _must_ copy this into a local copy, because we are not holding the
> 2954          * log_root_tree->log_mutex yet.  This is important because when we
> 2955          * commit the log_root_tree we must have a consistent view of the
> 2956          * log_root_tree when we update the super block to point at the
> 2957          * log_root_tree bytenr.  If we update the log_root_tree here we'll race
> 2958          * with the commit and possibly point at the new block which we may not
> 2959          * have written out.
> 2960          */
> 2961         btrfs_set_root_node(&log->root_item, log->node);
> 2962         memcpy(&new_root_item, &log->root_item, sizeof(new_root_item));
> 2963
> 2964 →       root->log_transid++;
> 2965         log->log_transid = root->log_transid;
> 2966         root->log_start_pid = 0;
> 2967         /*
> 2968          * IO has been started, blocks of the log tree have WRITTEN flag set
> 2969          * in their headers. new modifications of the log will be written to
> 2970          * new positions. so it's safe to allow log writers to go in.
> 2971          */
> 2972         mutex_unlock(&root->log_mutex);
> 
> fs/btrfs/transaction.h
> ----------------------------------
> 170 static inline void btrfs_set_inode_last_trans(struct btrfs_trans_handle *trans,
> 171                                               struct btrfs_inode *inode)
> 172 {
> 173         spin_lock(&inode->lock);
> 174         inode->last_trans = trans->transaction->transid;
> 175         inode->last_sub_trans = inode->root->log_transid;
> 176         inode->last_log_commit = inode->last_sub_trans - 1;
> 177         spin_unlock(&inode->lock);
> 178 }
> 
> I am not certain whether the reader and writer side contend for the same lock, but it
> seems that on the safe side would be putting the reader into READ_ONCE() to get a consistent
> value?:

Filipe send a series adding the READ_ONCE/WRITE_ONCE annotations for the
log_transid (and more):
https://lore.kernel.org/linux-btrfs/cover.1696415673.git.fdmanana@suse.com/

This will appear in linux-next soon.
