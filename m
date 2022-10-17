Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE2601113
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 16:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJQOZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 10:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJQOZ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 10:25:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767F2FFE8
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 07:25:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3394B1F6E6;
        Mon, 17 Oct 2022 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666016725;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/9cKhwFkXu+F06U68n7qf81WOsO9O+gbKe6mpuM0yI=;
        b=VFPP9uEIyMMm1WCtMnzEXBQ37GMhvpc0IGQ8j2mVacfVHNHJ6BrJTjLpmJDypSJdFfN2MZ
        L8/5rizsBjRURkHj86V9GcZvbRpKsAFazZBlrULXPwHmUkRtxwzN388SRX2Tx+GyYlJk2c
        rtxVMRwylyIngcdI3w/ulqdNCpHlftw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666016725;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/9cKhwFkXu+F06U68n7qf81WOsO9O+gbKe6mpuM0yI=;
        b=J1sYPC7y+25pdaIOO79NFq8g4YeCn4f/bQT5rvLUYBq9yCiFi3YDqg4FCGErht+AsB48dq
        LeQwyre2NOJlkAAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12F6413398;
        Mon, 17 Oct 2022 14:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bFGfA9VlTWM2ewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Oct 2022 14:25:25 +0000
Date:   Mon, 17 Oct 2022 16:25:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] btrfs: avoid GFP_ATOMIC allocation failures during
 endio
Message-ID: <20221017142516.GQ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665755095.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665755095.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 14, 2022 at 10:00:38AM -0400, Josef Bacik wrote:
> Hello,
> 
> As you can imagine we have workloads that don't behave super well sometimes, and
> they'll OOM the box in a really spectacular fashion.  Sometimes these trip the
> BUG_ON(!prealloc) things inside of the extent io tree code.
> 
> We've talked about switching these allocations to mempools for a while, but
> that's going to require some extra work.  We can drastically reduce the
> likelihood of failing these allocations by simply dropping the tree lock and
> attempting to make the allocation with the original gfp_mask.
> 
> The main problem with that approach is we've been using GFP_ATOMIC in the endio
> path for....reasons?  I *think* the read endio work used to happen in IRQ
> context, but it hasn't for at least a decade, and in fact if we get read
> failures we do our failrec allocations with GFP_NOFS, so clearly GFP_ATOMIC
> isn't really required in this path.

Up to my possibly dated knowledge endio is done in irq context so we
need to verify that. I did a quick check in block/ but the bare bio->end_io()
is not called unser obvious irq protection (spin lock or local_irq
save/restore), but I could be mistaken due to the maze of block layer.

> So kill the GFP_ATOMIC allocations in the endio path, which is where we see
> these panics, and then change the extent io code to simply do the loop again if
> it can't allocate the prealloc extent with GFP_ATOMIC so we can make the
> allocation with the callers gfp_mask.
> 
> This is perfectly safe, we'll drop the tree lock and loop around any time we
> have to re-search the tree after modifying part of our range, we don't need to
> hold the lock for our entire operation.
> 
> The only drawback here is that we could infinite loop if we can't make our
> allocation.  This is why a mempool would be the proper solution, as we can't
> fail these allocations without brining the box down, which is what we currently
> do anyway.

Aren't the mempools shifting the possibly infinite loop one layer down
only? With some added bonus of creating indirect dependencies of the
allocating and freeing threads.
