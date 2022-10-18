Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5557602BF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 14:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJRMmo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 08:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJRMmn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 08:42:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44A4C34DD
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 05:42:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50D62207BD;
        Tue, 18 Oct 2022 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666096959;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VgdljcyI4IVMb3JIH7kENbbE0ONcb7P3Q+j/uiwVNlI=;
        b=iyyk6OZA7S2Ou7FtwSGdebExOaWUQHueSeucqArnysw7No5z1QZL/KLRmUZqJXNSQYAr4T
        rrcXF3C+Sly8Q51PxHlKElKsPxm72NCm2cts4U7+29UgiXHdXmaXt7rw3aLMgcduBE+OHT
        jF02vq7BS5TL5iihKKrdvKigQKTS3QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666096959;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VgdljcyI4IVMb3JIH7kENbbE0ONcb7P3Q+j/uiwVNlI=;
        b=BLGMi79xQw65nNAQIpBUWNhDLfRykfFjdO4CQxJxJ3lzJN6SookXxlDn0xpYZQ3cpvMD1P
        uyFaVQfzZUiO8LDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26849139D2;
        Tue, 18 Oct 2022 12:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ngdtCD+fTmMtewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Oct 2022 12:42:39 +0000
Date:   Tue, 18 Oct 2022 14:42:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/3] btrfs: avoid GFP_ATOMIC allocation failures during
 endio
Message-ID: <20221018124229.GT13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665755095.git.josef@toxicpanda.com>
 <20221017142516.GQ13389@twin.jikos.cz>
 <Y02aAoQDtAoit8xL@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02aAoQDtAoit8xL@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 02:08:02PM -0400, Josef Bacik wrote:
> On Mon, Oct 17, 2022 at 04:25:16PM +0200, David Sterba wrote:
> > > 
> > > This is perfectly safe, we'll drop the tree lock and loop around any time we
> > > have to re-search the tree after modifying part of our range, we don't need to
> > > hold the lock for our entire operation.
> > > 
> > > The only drawback here is that we could infinite loop if we can't make our
> > > allocation.  This is why a mempool would be the proper solution, as we can't
> > > fail these allocations without brining the box down, which is what we currently
> > > do anyway.
> > 
> > Aren't the mempools shifting the possibly infinite loop one layer down
> > only? With some added bonus of creating indirect dependencies of the
> > allocating and freeing threads.
> 
> bio's use mempools for the same reason, the emergency reserve exists so that we
> always are able to make our allocations.  Clearly we could still end up in a bad
> situation if we exhaust the emergency reserve, but the extent states in this
> particular case don't get allocated a bunch.  Thanks,

I think that bios are the only thing that works with mempools reliably
because it satisfies the guaranteed forward progress. Otherwise the
indirect dependenices lead to lockups in the allocation, which is
equivalent to the potentially infinite looping. The emergency reserve is
another finite resource so it can get exhausted eventually, and it's
not scaled to the number of potential requests that could hit the same
code path and competing for the memory. It's true we'd be dealing with a
system in a bad state and depending on another subsystems make it less
predictable. The simplest options are wait or exit with error.

Anyway, the mempools might work in this case but I'm skeptical so I'd be
very interested in some kind of proof that we understand the edge cases.
