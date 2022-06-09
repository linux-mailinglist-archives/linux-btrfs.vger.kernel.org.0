Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFCF5458B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 01:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiFIXkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 19:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFIXkJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 19:40:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA3E96DF
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 16:40:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CFA61FF09;
        Thu,  9 Jun 2022 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654818007;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfUxceFBqrjO+eZCW9JoVBerZothJGerAWhOqsWUV00=;
        b=DFs5FKHCay60feJ0pDPzv6Ap+Loo4usf6wl0BSOwrshb0kThZ6EZuJPMnlUanCOxmacPIh
        j1E1xHmsIRZg01j5CouwU4Yl/P23dcr6rWHXif4roZFSKEHQodpfnUio8CX50WuUTR5E4n
        +5vpQmIXSjl7jzZxaq3M7Ktjq2RFfR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654818007;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfUxceFBqrjO+eZCW9JoVBerZothJGerAWhOqsWUV00=;
        b=Q4JV25EleE8V8Eepj9btIbSSu4cCJ5kCHUo6lMLxMDwhsCBn5M7gWT4YHVKPubSRMFBzkS
        jOfP5fFi4s5fRTBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02DB913A8C;
        Thu,  9 Jun 2022 23:40:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zYpQO9aEomKwLwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Jun 2022 23:40:06 +0000
Date:   Fri, 10 Jun 2022 01:35:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, willy@infradead.org, nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Message-ID: <20220609233536.GZ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        willy@infradead.org, nborisov@suse.com
References: <20220609164629.30316-1-dsterba@suse.com>
 <17d8d373-f836-5d23-2939-d9dfcb65ae7e@gmx.com>
 <20220609225906.GX20633@twin.jikos.cz>
 <fa8e446c-1a17-4239-efcd-f4f2004f0e34@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa8e446c-1a17-4239-efcd-f4f2004f0e34@gmx.com>
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

On Fri, Jun 10, 2022 at 07:15:17AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/6/10 06:59, David Sterba wrote:
> > On Fri, Jun 10, 2022 at 06:58:00AM +0800, Qu Wenruo wrote:
> >>> v2:
> >>>
> >>> - allocate 3 pages per device to keep parallelism, otherwise the
> >>>     submission would be serialized on the page lock
> >>
> >> Wouldn't this cause extra memory overhead for non-4K page size systems?
> >>
> >> Would simpler kmalloc() fulfill the requirement for both 4K and non-4K
> >> page size systems?
> >
> > Yeah on pages larger than 4K it's a bit wasteful. kmalloc should be
> > possible, for bios we need the page pointer but we should be able to get
> > it from the kmalloc address. I'd rather do that in a separate change
> > though.
> 
> That would work for me.
> 
> Just want to bring a little more love to those larger page sized systems.

Yeah that's a good point, memory usage should be always considered in
kernel. My other concern about the preallocated pages is that pinning
3 for the filesystem mount duration, that could be long, could create
fragmentation issues as the pages could prevent some internal
optimizations like coalescing pages into larger chunks. But, I think
that should not be that bad, with eg. up to 20 devices it's something
like 60 pages, so before implementing anything more efficient I'd need
an expert opinion.
