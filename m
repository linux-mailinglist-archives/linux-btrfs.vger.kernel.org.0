Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB07127B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjEZNkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjEZNkk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 09:40:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958139B
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 06:40:39 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AFDC21A1C;
        Fri, 26 May 2023 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685108438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5sGnmoVEfkaMZrhHBzBfM+h7wzBMEmTLVI14kU3qyPg=;
        b=pbvNE1AWbFGc5fPS+X5td0zvThZ+IwJQ3G79c4MbyKB+g6mfO0G7nevYhKEl512XcsVew3
        VCSlwzV9OPjYAp6AGixctW+iTJTRyAlx9sj4M3wcYRDw7MGn1OT7qQveRM1X/LQ+TQN1vA
        Q8VZWQMMDDASMsUPSQMYjijOylcMAVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685108438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5sGnmoVEfkaMZrhHBzBfM+h7wzBMEmTLVI14kU3qyPg=;
        b=G1RAeHKcH0K+yzRqzUjbguWiF/sWIWX3ZU3CJBKS6THrxE0dTB2saMvSw6+N2z/hwEcL+x
        5s7Btmum7UIEv3Aw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1320F134AB;
        Fri, 26 May 2023 13:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Sl50A9a2cGQQbAAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Fri, 26 May 2023 13:40:38 +0000
Date:   Fri, 26 May 2023 15:34:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 10/21] btrfs: return bool from lock_extent_buffer_for_io
Message-ID: <20230526133429.GC14830@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230503152441.1141019-1-hch@lst.de>
 <20230503152441.1141019-11-hch@lst.de>
 <20230523184317.GY32559@twin.jikos.cz>
 <20230524054449.GA19255@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524054449.GA19255@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 24, 2023 at 07:44:49AM +0200, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 08:43:17PM +0200, David Sterba wrote:
> > On Wed, May 03, 2023 at 05:24:30PM +0200, Christoph Hellwig wrote:
> > > lock_extent_buffer_for_io never returns a negative error value, so switch
> > > the return value to a simple bool.  Also remove the noinline_for_stack
> > > annotation given that nothing in lock_extent_buffer_for_io or its callers
> > > is particularly stack hungry.
> > 
> > AFAIK the reason for noinline_for_stack is not because of a function is
> > stack hungry but because we want to prevent inlining it so we can see it
> > on stack in case there's an implied waiting. This makes it easier to
> > debug when IO is stuck or there's some deadlock.
> > 
> > This is not consistent in btrfs code though, quick search shows lots of
> > historical noinline_for_stack everywhere without an obvious reason.
> 
> Hmm.  noinline_for_stack is explicitly documented to only exist as an
> annotation that noinline is used for stack usage.  So this is very odd.

Yes that's the documented way, I found one commit fixing the stack
problem, 8ddc319706e5 ("btrfs: reduce stack usage for
btrfsic_process_written_block").

> If you want a normal noinline here I can add one, but to be honest
> I don't really see the point even for stack traces.

What I had in mind was based on 6939f667247e ("Btrfs: fix confusing
worker helper info in stacktrace"), but digging in the mail archives the
patch was sent with noinline
(https://lore.kernel.org/linux-btrfs/20170908213445.1601-1-bo.li.liu@oracle.com/).
I don't remember where I read about the noinline_for_stack use for the
stack trace.

We can audit and remove some of the attributes but this tends to break
only on non-x86 builds so verification would need to go via linux-next
and let build bots report.
