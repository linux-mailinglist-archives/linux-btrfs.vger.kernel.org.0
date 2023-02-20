Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B9469D41D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 20:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjBTTeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 14:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjBTTeW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 14:34:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B32213DF4
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 11:34:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D9697209B2;
        Mon, 20 Feb 2023 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676921659;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qrZA6MPf64EQVob+5d5DmAR09VBHRqj8UeJVxUVgmbo=;
        b=ZEoFCAuD37qO9WAB7VHt1ko30Zfy+qQtNq5vbtjsOK7ALdwKjbJk4H8RYtOvcuXmuLZDze
        jiGC9IVuD/14t+03Dmj32FKuXk3sOXlhN8nh0OW7UnegaK8WyzP/rryJ3CS1bWXNWad3mP
        uaPXIOt0jzuQ0St19eSJiPLdlm9iy78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676921659;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qrZA6MPf64EQVob+5d5DmAR09VBHRqj8UeJVxUVgmbo=;
        b=2NMxVBhM45nLfm38L7D20/xhAgwW4kagk/UdPysd3RVDJWagr5YvO0zNjNoEeFBq+oW4de
        xiHk1RsDCuGzT8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0A71134BA;
        Mon, 20 Feb 2023 19:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZnQuKjvL82M7SAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 19:34:19 +0000
Date:   Mon, 20 Feb 2023 20:28:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/7] Error handling fixes
Message-ID: <20230220192824.GA10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1675787102.git.josef@toxicpanda.com>
 <20230215192639.GU28288@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215192639.GU28288@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 08:26:39PM +0100, David Sterba wrote:
> On Tue, Feb 07, 2023 at 11:57:18AM -0500, Josef Bacik wrote:
> > Hello,
> > 
> > For a short period of time our btrfs backport had 947a629988f1 ("btrfs: move
> > tree block parentness check into validate_extent_buffer()") without the
> > associated fix, which resulted in a lot of hilarity.
> > 
> > One of the things that popped was a WARN_ON(ret == 1) in __btrfs_free_extent
> > where we didn't find the bytenr we were looking for.  This was troubling, as it
> > appeared that we were losing the EIO and returning 1 from btrfs_search_slot.
> > 
> > I rigged up my error injection stress test with
> > btrfs_check_leaf/btrfs_check_node with balance (as this was the path that we saw
> > the error).  This of course uncovered a few other unrelated things, but
> > eventually I reproduced what we saw in production.  Thankfully it was not that
> > we were eating the -EIO and returning 1 instead, however the actual problem is
> > worse.  We do not handle the errors properly in snapshot delete (which also gets
> > used by reloation), and then we do not abort the transaction when we hit errors
> > in this path, which leads to the file system being corrupted and eventually
> > triggers the above WARN_ON().
> > 
> > With these fixes in place my stress testing was running overnight without
> > tripping over any other leaks, corruptions, or panics.  Previously I wasn't able
> > to run for longer than a couple of minutes without falling over.  Thanks,
> > 
> > Josef
> > 
> > Josef Bacik (7):
> >   btrfs: use btrfs_handle_fs_error in btrfs_fill_super
> >   btrfs: replace BUG_ON(level == 0) with ASSERT(level)
> >   btrfs: handle errors from btrfs_read_node_slot in split
> >   btrfs: iput on orphan cleanup failure
> >   btrfs: drop root refs properly when orphan cleanup fails
> >   btrfs: handle errors in walk_down_tree properly
> >   btrfs: abort the transaction if we get an error during snapshot drop
> 
> Added to for-next as topic branch, will be moved to misc-next once the
> 6.3 pull request is out. Thanks.

Moved to misc-next.
