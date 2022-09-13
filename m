Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C115B6D79
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiIMMn7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 08:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiIMMn6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 08:43:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B833052825
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 05:43:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65A7A33698;
        Tue, 13 Sep 2022 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663073035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Q8ZynhAtb93oYkQOLgIJ8Bhxr7xCzo4R5PYH8VQ69c=;
        b=M47JuHxMCZA0Z1MxGNks/1V6+DDJgmywTRi6vUNvOmsA6+NK/3PKwK99bciLFnzajU7NhE
        qqZ5hstbD2AufjFr0jUC6eNaQheEv4a0bFzQpIvRRgmSwald5Ce6OKU08wTnfBDL+a8RBg
        CBXhPmtuwuanSD2gK/2uwtAccHft91w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663073035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Q8ZynhAtb93oYkQOLgIJ8Bhxr7xCzo4R5PYH8VQ69c=;
        b=vJCyhrlagIX9DpRo59gbC89WmV4dND8mkS+tE0mbWJQieaqCYk7CQiIL+z6VaebBTyXq9u
        pCN+otEZ026S4tBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F3E213AB5;
        Tue, 13 Sep 2022 12:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y7uFDgt7IGNrCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 13 Sep 2022 12:43:55 +0000
Date:   Tue, 13 Sep 2022 14:38:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3] btrfs: don't update the block group item if used
 bytes are the same
Message-ID: <20220913123828.GK32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2a76b8005eb7208eda97e62a944ae456cbe8386f.1662705863.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a76b8005eb7208eda97e62a944ae456cbe8386f.1662705863.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 09, 2022 at 02:45:22PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> 
> When committing a transaction, we will update block group items for all
> dirty block groups.
> 
> But in fact, dirty block groups don't always need to update their block
> group items.
> It's pretty common to have a metadata block group which experienced
> several CoW operations, but still have the same amount of used bytes.
> 
> In that case, we may unnecessarily CoW a tree block doing nothing.
> 
> [ENHANCEMENT]
> 
> This patch will introduce btrfs_block_group::commit_used member to
> remember the last used bytes, and use that new member to skip
> unnecessary block group item update.
> 
> This would be more common for large fs, which metadata block group can
> be as large as 1GiB, containing at most 64K metadata items.
> 
> In that case, if CoW added and the deleted one metadata item near the end
> of the block group, then it's completely possible we don't need to touch
> the block group item at all.
> 
> [BENCHMARK]
> 
> The patchset itself can have quite a high chance (20~80%) to skip block
> group item updates in a lot of workload.
> 
> As a result, it would result shorter time spent on
> btrfs_write_dirty_block_groups(), and overall reduce the execution time
> of the critical section of btrfs_commit_transaction().
> 
> Here comes a fio command, which will do random writes in 4K block size,
> causing a very heavy metadata updates.
> 
> fio --filename=$mnt/file --size=512M --rw=randwrite --direct=1 --bs=4k \
>     --ioengine=libaio --iodepth=64 --runtime=300 --numjobs=4 \
>     --name=random_write --fallocate=none --time_based --fsync_on_close=1
> 
> The file size (512M) and number of threads (4) means 2GiB file size in
> total, but during the full 300s run time, my dedicated SATA SSD is able
> to write around 20~25GiB, which is over 10 times the file size.
> 
> Thus after we fill the initial 2G, we should not cause much block group items
> updates.
> 
> Please note, the fio numbers by itself doesn't have much change, but if
> we look deeper, there is some reduced execution time, especially
> for the critical section of btrfs_commit_transaction().
> 
> I added extra trace_printk() to measure the following per-transaction
> execution time
> 
> - Critical section of btrfs_commit_transaction()
>   By re-using the existing update_commit_stats() function, which
>   has already calculated the interval correctly.
> 
> - The while() loop for btrfs_write_dirty_block_groups()
>   Although this includes the execution time of btrfs_run_delayed_refs(),
>   it should still be representative overall.
> 
> Both result involves transid 7~30, the same amount of transaction
> committed.
> 
> The result looks like this:
> 
>                       |      Before       |     After      |  Diff
> ----------------------+-------------------+----------------+--------
> Transaction interval  | 229247198.5       | 215016933.6    | -6.2%
> Block group interval  | 23133.33333       | 18970.83333    | -18.0%
> 
> The change in block group item updates is more obvious, as skipped bg
> item updates also means less delayed refs, thus the change is more
> obvious.
> 
> And the overall execution time for that bg update loop is pretty small,
> thus we can assume the extent tree is already mostly cached.
> If we can skip a uncached tree block, it would cause more obvious
> change.
> 
> Unfortunately the overall reduce in commit transaction critical section
> is much smaller, as the block group item updates loop is not really the
> major part, at least for the above fio script.
> 
> But still we have a observable reduction in the critical section.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [Josef pinned down the race and provided a fix]
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks for the numbers, it seems worth and now that we have the fixed
version I'll add it to 6.1 queue as we have the other perf improvements
there.
