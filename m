Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB666742C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 20:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjAST0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 14:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjAST0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 14:26:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36902485B6
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:26:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE3D12189A;
        Thu, 19 Jan 2023 19:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674156363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkDpjZWldZ7NpBH5YRo2VWY9ovW0jQDeD3vEbPpie20=;
        b=Z+Uxvkudx2sw+kTtRP5I7IRbUSnY7fmaTN62Qb1UI+JTdTjQlLz9pZZ3E/Qo/YQDLDjvXY
        98HHLangx4O4KLTQS+XPeUUi0fSVvLRe7b5PtLNoP4qgrSi7utYbhkPYwl7ZWvdYg3dkEg
        8J38M3cPxdRyPcE9mFWM1hbAeIm3QXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674156363;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkDpjZWldZ7NpBH5YRo2VWY9ovW0jQDeD3vEbPpie20=;
        b=dYbu8nnmBIY1oGAEPB4MC6cMGSURsm8oIB/dk19XqrMbQ+o4B/IYshlbgLgzbNPy9EVJTH
        Dqlf7Gd3491t7iAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F121139ED;
        Thu, 19 Jan 2023 19:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NwF/JUuZyWPZPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 19 Jan 2023 19:26:03 +0000
Date:   Thu, 19 Jan 2023 20:20:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: hold block_group refcount during async discard
Message-ID: <20230119192024.GJ11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <07df5461bf34cf138f2f4b281a6fa6a0b389ff68.1673568238.git.boris@bur.io>
 <930c95d4-c55d-cbb3-ce2b-73c4333795d2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <930c95d4-c55d-cbb3-ce2b-73c4333795d2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 19, 2023 at 08:21:42AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/1/13 08:05, Boris Burkov wrote:
> > Async discard does not acquire the block group reference count while it
> > holds a reference on the discard list. This is generally OK, as the
> > paths which destroy block groups tend to try to synchronize on
> > cancelling async discard work. However, relying on cancelling work
> > requires careful analysis to be sure it is safe from races with
> > unpinning scheduling more work.
> > 
> > While I am unable to find a race with unpinning in the current code for
> > either the unused bgs or relocation paths, I believe we have one in an
> > older version of auto relocation in a Meta internal build. This suggests
> > that this is in fact an error prone model, and could be fragile to
> > future changes to these bg deletion paths.
> > 
> > To make this ownership more clear, add a refcount for async discard. If
> > work is queued for a block group, its refcount should be incremented,
> > and when work is completed or canceled, it should be decremented.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> It looks like the patch is causing btrfs/011 to panic with the following 
> ASSERT() failure:

Fixed version replaced and pushed to misc-next. The fix is

--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -540,7 +540,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
        spin_lock(&discard_ctl->lock);
        discard_ctl->prev_discard = trimmed;
        discard_ctl->prev_discard_time = now;
-       if (list_empty(&block_group->discard_list))
+       if (discard_ctl->block_group == NULL)
                __put_discard(block_group);
        discard_ctl->block_group = NULL;
        __btrfs_discard_schedule_work(discard_ctl, now, false);
---
