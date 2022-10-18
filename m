Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBE602D1A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJRNey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJRNeo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:34:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3EF65C6;
        Tue, 18 Oct 2022 06:34:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 319BB1FE5B;
        Tue, 18 Oct 2022 13:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666100071;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNt5mQC2e5XupOl9BkGF4MbVJZ93LXR8didtu/maIS0=;
        b=kzbaG8JuKjEBIiBs+SDmWsNJYDIM63IO3JiS/XesXxfsZLHVHY4o6t7AUyC+7KG33DyMG/
        iAtYv1hjDg3wlxLeu8g3pf1pHYZH4++LCS+0PJUkd/nEQidw0FEr2yScFNkc8ZiT4tnO0x
        ar5fgI+rs2NvB35R9KKUqCPoQvul/fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666100071;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNt5mQC2e5XupOl9BkGF4MbVJZ93LXR8didtu/maIS0=;
        b=n5fbIhjqkaibarglnrxfV/bOBOZIfYKuAj9X036FhfaBrbEeASs6uk+x4LT6gAZlLSFxN0
        f8EmA1pejpS1+oCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAAA0139D2;
        Tue, 18 Oct 2022 13:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wLvDN2arTmPoHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Oct 2022 13:34:30 +0000
Date:   Tue, 18 Oct 2022 15:34:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     bingjingc <bingjingc@synology.com>
Cc:     fdmanana@kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, bxxxjxxg@gmail.com
Subject: Re: [PATCH] btrfs: send: fix send failure of a subcase of orphan
 inodes
Message-ID: <20221018133421.GW13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221016153346.2794-1-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016153346.2794-1-bingjingc@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 16, 2022 at 11:33:46PM +0800, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> Commit 9ed0a72e5b35 ("btrfs: send: fix failures when processing inodes with
> no links") tries to fix all incremental send cases of orphan inodes the
> send operation will meet. However, there's still a bug causing the corner
> subcase fails with a ENOENT error.
> 
> Here's shortened steps of that subcase:
> 
>   $ btrfs subvolume create vol
>   $ touch vol/foo
> 
>   $ btrfs subvolume snapshot -r vol snap1
>   $ btrfs subvolume snapshot -r vol snap2
> 
>   # Turn the second snapshot to RW mode and delete the file while
>   # holding an open file descriptor on it
>   $ btrfs property set snap2 ro false
>   $ exec 73<snap2/foo
>   $ rm snap2/foo
> 
>   # Set the second snapshot back to RO mode and do an incremental send
>   # with an unusal reverse order
>   $ btrfs property set snap2 ro true
>   $ btrfs send -p snap2 snap1 > /dev/null
>   At subvol snap1
>   ERROR: send ioctl failed with -2: No such file or directory
> 
> It's subcase 3 of BTRFS_COMPARE_TREE_CHANGED in the commit 9ed0a72e5b35
> ("btrfs: send: fix failures when processing inodes with no links"). And
> it's not a common case. We still have not met it in the real world.
> Theoretically, this case can happen in a batch cascading snapshot backup.
> In cascading backups, the receive operation in the middle may cause orphan
> inodes to appear because of the open file descriptors on the snapshot files
> during receiving. And if we don't do the batch snapshot backups in their
> creation order, then we can have an inode, which is an orphan in the parent
> snapshot but refers to a file in the send snapshot. Since an orphan inode
> has no paths, the send operation will fail with a ENOENT error if it
> tries to generate a path for it.
> 
> In that patch, this subcase will be treated as an inode with a new
> generation. However, when the routine tries to delete the old paths in
> the parent snapshot, the function process_all_refs() doesn't check whether
> there are paths recorded or not before it calls the function
> process_recorded_refs(). And the function process_recorded_refs() try
> to get the first path in the parent snapshot in the beginning. Since it has
> no paths in the parent snapshot, the send operation fails.
> 
> To fix this, we can easily put a link count check to avoid entering the
> deletion routine like what we do a link count check to avoid creating a
> new one. Moreover, we can assume that the function process_all_refs()
> can always collect references to process because we know it has a
> positive link count.
> 
> Signed-off-by: BingJing Chang <bingjingc@synology.com>

Added to misc-next, thanks.
