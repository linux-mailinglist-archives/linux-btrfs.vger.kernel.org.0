Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25665788C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 19:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiGRRtg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 13:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiGRRtf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 13:49:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC9B2B611
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 10:49:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEB1B20640;
        Mon, 18 Jul 2022 17:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658166572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nKjtL/8Q7jsTon44l4OoO0xNQot3wb1XXj7Z1FJ1YnM=;
        b=1ecgS4P2qMxBYSzM2H5DBHXC2BfUzOD4OV2GIsHXthQyzUqMrZTJCtz16DQ3vjVtAXwPlk
        ROujbnQiKkZM8S6Qzsln1x6h6CewgbVBWRhUpJAdepASTp51jDWjzTHtBLEWbV+497+Gwj
        8XYFS/Qagb9Oge+ff/bWvts2b1U4dRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658166572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nKjtL/8Q7jsTon44l4OoO0xNQot3wb1XXj7Z1FJ1YnM=;
        b=Ea3O5IqmY//eS7lcp9fJMbfJTznJggoUUx8XKZOuY0bZ08lRfBg/Dnfr1PjGckzDBVVqJx
        eiaz/oR+Aa4V0mCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0DA013754;
        Mon, 18 Jul 2022 17:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cfQAJiyd1WJlGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 17:49:32 +0000
Date:   Mon, 18 Jul 2022 19:44:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: join running log transaction when logging new name
Message-ID: <20220718174439.GM13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <502f1d2cc23000b8585ad87122b7f6c0a8c2c6ab.1658091704.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502f1d2cc23000b8585ad87122b7f6c0a8c2c6ab.1658091704.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 17, 2022 at 10:05:05PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When logging a new name, in case of a rename, we pin the log before
> changing it. We then either delete a directory entry from the log or
> insert a key range item to mark the old name for deletion on log replay.
> 
> However when doing one of those log changes we may have another task that
> started writing out the log (at btrfs_sync_log()) and it started before
> we pinned the log root. So we may end up changing a log tree while its
> writeback is being started by another task syncing the log. This can lead
> to inconsistencies in a log tree and other unexpected results during log
> replay, because we can get some committed node pointing to a node/leaf
> that ends up not getting written to disk before the next log commit.
> 
> The problem, conceptually, started to happen in commit 88d2beec7e53fc
> ("btrfs: avoid logging all directory changes during renames"), because
> there we started to update the log without joining its current transaction
> first.
> 
> However the problem only became visible with commit 259c4b96d78dda
> ("btrfs: stop doing unnecessary log updates during a rename"), and that is
> because we used to pin the log at btrfs_rename() and then before entering
> btrfs_log_new_name(), when unlinking the old dentry, we ended up at
> btrfs_del_inode_ref_in_log() and btrfs_del_dir_entries_in_log(). Both
> of them join the current log transaction, effectively waiting for any log
> transaction writeout (due to acquiring the root's log_mutex). This made it
> safe even after leaving the current log transaction, because we remained
> with the log pinned when we called btrfs_log_new_name().
> 
> Then in commit 259c4b96d78dda ("btrfs: stop doing unnecessary log updates
> during a rename"), we removed the log pinning from btrfs_rename() and
> stopped calling btrfs_del_inode_ref_in_log() and
> btrfs_del_dir_entries_in_log() during the rename, and started to do all
> the needed work at btrfs_log_new_name(), but without joining the current
> log transaction, only pinning the log, which is racy because another task
> may have started writeout of the log tree right before we pinned the log.
> 
> Both commits landed in kernel 5.18, so it doesn't make any practical
> difference which should be blamed, but I'm blaming the second commit only
> because with the first one, by chance, the problem did not happen due to
> the fact we joined the log transaction after pinning the log and unpinned
> it only after calling btrfs_log_new_name().
> 
> So make btrfs_log_new_name() join the current log transaction instead of
> pinning it, so that we never do log updates if it's writeout is starting.
> 
> Fixes: 259c4b96d78dda ("btrfs: stop doing unnecessary log updates during a rename")
> CC: stable@vger.kernel.org # 5.18+
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Tested-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
