Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158EB6172E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 00:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiKBXk3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 19:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBXkG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 19:40:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162462BCB
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 16:35:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CAAB91F38D;
        Wed,  2 Nov 2022 23:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667432104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5MAaQVYIPQ3DSHc+Idnpz5BM5bUqRsMg4JJo8KJiT24=;
        b=oSVEoEh/gqlVP8i4n8Q2JhWt3eaxW1a2brljYKkiTG+gVLcyV9pSmZeRuqdTzdi7NpfE7y
        wDtpgegruKCnN9ZjklW/cdrQKgjP9Vr45LnqC9KSBfqLY53QLVZPswOATSDL9KU7JisDg+
        yhi5hnPNGtWRAmACSjwzzrnrHfSeh0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667432104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5MAaQVYIPQ3DSHc+Idnpz5BM5bUqRsMg4JJo8KJiT24=;
        b=dtvqnDcSG4AAOoL6GeDwKib2BFquVqrzQJ7jmMHvV/bTpNFxTz3pzZnaRYlsJLGYxRn+r1
        t9P9z53ObPvBJjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A403E13AE0;
        Wed,  2 Nov 2022 23:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DmoIJ6j+YmPvXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 02 Nov 2022 23:35:04 +0000
Date:   Thu, 3 Nov 2022 00:34:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/12] btrfs: raid56: use submit-and-wait method to
 handle raid56 worload
Message-ID: <20221102233445.GL5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667300355.git.wqu@suse.com>
 <20221102145915.GG5824@twin.jikos.cz>
 <c95a26a3-09da-4511-9bd8-21d4cf1be1fc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95a26a3-09da-4511-9bd8-21d4cf1be1fc@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 03, 2022 at 06:32:46AM +0800, Qu Wenruo wrote:
> On 2022/11/2 22:59, David Sterba wrote:
> > On Tue, Nov 01, 2022 at 07:16:00PM +0800, Qu Wenruo wrote:
> >>    btrfs: raid56: extract rwm write bios assembly into a helper
> >>    btrfs: raid56: introduce the a main entrance for rmw path
> >>    btrfs: raid56: switch write path to rmw_rbio()
> >>    btrfs: raid56: extract scrub read bio list assembly code into a helper
> >>    btrfs: raid56: switch scrub path to use a single function
> >>    btrfs: remove the unused btrfs_fs_info::endio_raid56_workers and
> >>      btrfs_raid_bio::end_io_work
> > 
> > Thanks for untangling it. You may want to add some recognizable prefix
> > like raid56_ to functions that could block for io,
> 
> One thing I am never going to stably handle is the naming...
> 
> To me, since it's inside raid56.c, a prefix like "raid56_" looks a 
> little redundant, unless it's exported.

Yes, this is one of the reasons, source code clarity. I suggested adding
some prefix because there is or was an occasional error that ended up
in finish_rmw. Before your patches it was declared as noinline and doing
all xor/parity calculations and then bio submission. The only hint that
it's in our code is because of the 'rmw', the full btrfs_ prefix or at
least some extent_, extent_io_ etc could help to recognize where the
error happened. The generic functions tend to use very generic naming
scheme so anything that seems btrfs specific helps, in this case it
would be sufficient to add raid56_ .

The renames can be added as needed, no big deal if it's not in the first
version but in this case I had a prior knowledge where I'd really like
to see it. As the code got reworked significantly I'm fine with doing it
in the followup RMW fix series.

> But sure, with much less functions it's much easier to add/remove 
> prefixes in one go.
> 
> > simple helpers do not
> > need it and they'll be probably inlined anyway.
> > 
> > Added to misc-next. Please proceed with the RMW fix series.
> 
> That's awesome.
> 
> Although I'm afraid I would just come up with extra refactors...
> 
> The latest thing that has some impact on RMW fix is the faila/b used in 
> the current code.
> 
> a) if just one sector failed to be read by somehow, we mark the whole 
> stripe failed.
> 
> b) since RMW now will handle data csum verification, we have extra 
> source of failed sectors.
> 
> I'll check if I can migrate the faila/b to an error bitmap, and then 
> re-base my RMW fixes.

I think it's fine, reducing the jumps between the functions is a good
intermediate step, in this case it helps to reduce the complexity and
it's easier to find further cleanups or optimizations.
