Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235FD5B9F06
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiIOPi0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiIOPiU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 11:38:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBFA7F0B0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 08:38:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DDFA733732;
        Thu, 15 Sep 2022 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663256295;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=69wcJjPahh3mgCCgtTViYIwOEl1foe3v7/Z9Q4/IUTk=;
        b=hxm14E5badtWtKXN6FJq2Z8X93SLgSOKKYffy0NXWQJVQ+lfSkQdr5EUFtfikj2rb2DlQs
        u+jxhBc8zw1GN0MftN779vAp+LI1mPhq0pcigji89IZXi/2I3l8+aNsZqs4wmQsX3F9kX1
        TgOmDFcrYZ8A0rGtL7vdPESik3FnY3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663256295;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=69wcJjPahh3mgCCgtTViYIwOEl1foe3v7/Z9Q4/IUTk=;
        b=s2wyryKPeN8gDZ4oBTsWpV7Pla6tG8DwvBciY0obegCB7Wlk+eD7A17bPAziqmbkU8nLHo
        OOOumWYcDi9Lj0Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B397013A49;
        Thu, 15 Sep 2022 15:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e8r8KudGI2MwGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 15 Sep 2022 15:38:15 +0000
Date:   Thu, 15 Sep 2022 17:32:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4] btrfs: skip update of block group item if used bytes
 are the same
Message-ID: <20220915153247.GQ32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f68664759229da440226ebc28114108470b761b6.1663241717.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68664759229da440226ebc28114108470b761b6.1663241717.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 07:38:52PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> 
> When committing a transaction, we will update block group items for all
> dirty block groups.
> 
> But in fact, dirty block groups don't always need to update their block
> group items.
> It's pretty common to have a metadata block group which experienced
> several COW operations, but still have the same amount of used bytes.
> 
> In that case, we may unnecessarily COW a tree block doing nothing.
> 
> [ENHANCEMENT]
> 
> This patch will introduce btrfs_block_group::commit_used member to
> remember the last used bytes, and use that new member to skip
> unnecessary block group item update.
> 
> This would be more common for large filesystems, where metadata block
> group can be as large as 1GiB, containing at most 64K metadata items.
> 
> In that case, if COW added and then deleted one metadata item near the
> end of the block group, then it's completely possible we don't need to
> touch the block group item at all.
> 
> [BENCHMARK]
> 
> The change itself can have quite a high chance (20~80%) to skip block
> group item updates in lot of workloads.
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
> Thus after we fill the initial 2G, we should not cause much block group
> item updates.
> 
> Please note, the fio numbers by themselves don't have much change, but
> if we look deeper, there is some reduced execution time, especially for
> the critical section of btrfs_commit_transaction().
> 
> I added extra trace_printk() to measure the following per-transaction
> execution time:
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
> The change in block group item updates is more obvious, as skipped block
> group item updates also mean less delayed refs.
> 
> And the overall execution time for that block group update loop is
> pretty small, thus we can assume the extent tree is already mostly
> cached.  If we can skip an uncached tree block, it would cause more
> obvious change.
> 
> Unfortunately the overall reduction in commit transaction critical
> section is much smaller, as the block group item updates loop is not
> really the major part, at least not for the above fio script.
> 
> But still we have a observable reduction in the critical section.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> Changelog:
> v4:
> - Race fix again
>   Even with v3 fix, there seems to be a race window, but I'm not 100% sure.
> 
>   `cache->commit_used` is not updated with spinlock protection, thus
>   no proper multi-core barrier to sync the new value to other cores.
> 
>   Thus it's possible that, on core A we have cache->commit_used updated,
>   but on another core, cache->commit_used may still be the old value.
>   And incorrectly skip the update for the block group.
> 
>   Anyway we should handle btrfs_block_group members with spinlock,
>   especially there are two members involved now.
> 
>   This time I hope to get more testing, thus please don't include this
>   patch for late -rc. Better only targeting v6.2.

Yeah 6.2 is the safe option for now, I'll add it to for-next after rc1
so we don't hit other errors potentially caused by this patch.
