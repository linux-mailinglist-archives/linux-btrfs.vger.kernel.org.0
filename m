Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1986B5B0FB4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIGWOT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 18:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIGWOR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 18:14:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5A9C228C
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 15:14:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7F5E22383;
        Wed,  7 Sep 2022 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662588853;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hK7ZdijOsdQZOEY85ygr0eSNZQOrouG/e3B/s4yucgI=;
        b=0+0Yu7NC0NaxBabJiNFpSSJSjpdZSYlEtcHGsfvts5iJ5VquI0CIIavzV073Bw1u9uZuyj
        FLlEaOn/sSlSBUjhNR4S2WB7jzIrQ3gOyuap7r6HN8/A1zg9tggh2LVorHRRTdhElXXfvI
        t4f5eFmjDfiFezNiB4tPNyJ99ReFGtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662588853;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hK7ZdijOsdQZOEY85ygr0eSNZQOrouG/e3B/s4yucgI=;
        b=EuAtJBSNEVoeNXWm7ylgQqrEgL4nl8gVL+aVH7uFsd8xliSrupmQqsMoRF3XCi5SW6bL9d
        LdU0oNpNbEP52lDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8917813A66;
        Wed,  7 Sep 2022 22:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x7B5ILUXGWPJXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 07 Sep 2022 22:14:13 +0000
Date:   Thu, 8 Sep 2022 00:08:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't update the block group item if used bytes
 are the same
Message-ID: <20220907220850.GP32411@suse.cz>
Reply-To: dsterba@suse.cz
References: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
 <YxirXjl1Ur3VV3B6@localhost.localdomain>
 <YxjVDY7jIH3Vv/il@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxjVDY7jIH3Vv/il@localhost.localdomain>
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

On Wed, Sep 07, 2022 at 01:29:49PM -0400, Josef Bacik wrote:
> On Wed, Sep 07, 2022 at 10:31:58AM -0400, Josef Bacik wrote:
> > On Mon, Jul 11, 2022 at 02:37:52PM +0800, Qu Wenruo wrote:
> > > When committing a transaction, we will update block group items for all
> > > dirty block groups.
> > > 
> > > But in fact, dirty block groups don't always need to update their block
> > > group items.
> > > It's pretty common to have a metadata block group which experienced
> > > several CoW operations, but still have the same amount of used bytes.
> > > 
> > > In that case, we may unnecessarily CoW a tree block doing nothing.
> > > 
> > > This patch will introduce btrfs_block_group::commit_used member to
> > > remember the last used bytes, and use that new member to skip
> > > unnecessary block group item update.
> > > 
> > > This would be more common for large fs, which metadata block group can
> > > be as large as 1GiB, containing at most 64K metadata items.
> > > 
> > > In that case, if CoW added and the deleted one metadata item near the end
> > > of the block group, then it's completely possible we don't need to touch
> > > the block group item at all.
> > > 
> > > I don't have any benchmark to prove this, but this should not cause any
> > > hurt either.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > I've been seeing random btrfs check failures on our overnight testing since this
> > patch was merged.  I can't blame it directly yet, I've mostly seen it on
> > TEST_DEV, and once while running generic/648.  I'm running it in a loop now to
> > reproduce and then fix it.
> > 
> > We can start updating block groups before we're in the critical section, so we
> > can update block_group->bytes_used while we're updating the block group item in
> > a different thread.  So if we set the block_group item to some value of
> > bytes_used, then update it in another thread, and then set ->commit_used to the
> > new value we'll fail to update the block group item with the correct value
> > later.
> > 
> > We need to wrap this bit in the block_group->lock to avoid this particular
> > problem.  Once I reproduce and validate the fix I'll send that, but I wanted to
> > reply in case that takes longer than I expect.  Thanks,
> 
> Ok this is in fact the problem, this fixup made the problem go away.  Thanks,

Thanks for tracking it down, I've removed the patch from for-next, it's
an optimization and we haven't seen any numbers yet how useful it is.
