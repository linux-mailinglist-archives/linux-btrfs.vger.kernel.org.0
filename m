Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A68370C636
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 21:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjEVTQT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 15:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjEVTQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 15:16:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B32E43;
        Mon, 22 May 2023 12:15:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A12C200F6;
        Mon, 22 May 2023 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684782943;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fpgikaj4b/fIR4oq3PCGfq5sJzdvVfaJIjtWnHRA6R0=;
        b=D70ZT6b1fjWsuL+W1yj9TGbzMb0C5NWUnfgJRwHMF/T18jNEQuWzzMrZ5WgrNX6Fuqiofu
        9gIyExPl+ESAj1eopVNEcMi2aMU7mlhOCEyhVFSAfijvBLJFvs6ueVYTZvgHmAz5mHlNo9
        XyvAIcTLpeqhNHo/L04sjJrUjTYguTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684782943;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fpgikaj4b/fIR4oq3PCGfq5sJzdvVfaJIjtWnHRA6R0=;
        b=XtD6nqwgq+tgbSkSxyJ62p07UNPB1IyTTPrapmj+inkYSMN3ePjmWutdZo9t4Up0qUKIxp
        gtrOQSCuPuRaBjCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3303E13336;
        Mon, 22 May 2023 19:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nl8AC1+/a2QPNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 19:15:43 +0000
Date:   Mon, 22 May 2023 21:09:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        linux-mm@kvack.org
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
Message-ID: <20230522190936.GP32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
 <ZGuRqtPkmeP07M6x@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGuRqtPkmeP07M6x@pc636>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 22, 2023 at 06:00:42PM +0200, Uladzislau Rezki wrote:
> > Hi,
> > 
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> > 
> > > after updating from 6.2.x to 6.3.x, vmalloc error messages started to appear in the dmesg
> > > 
> > > 
> > > 
> > > # free 
> > >                total        used        free      shared  buff/cache   available
> > > Mem:        16183724     1473068      205664       33472    14504992    14335700
> > > Swap:       16777212      703596    16073616
> > > 
> > > 
> > > (zswap enabled)
> > 
> > See bugzilla for the full thread and attached dmesg.
> > 
> > On the report, the reporter can't perform the required bisection,
> > unfortunately.
> > 
> > Anyway, I'm adding it to regzbot:
> > 
> > #regzbot introduced: v6.2..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217466
> > #regzbot title: btrfs_work_helper dealloc error in v6.3.x
> > 
> > Thanks.
> > 
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217466
> > 
> According to dmesg output from the bugzilla, the vmalloc tries to
> allocate high order pages: 1 << 9. Since it fails to get a order-9 page
> you get the warning:

That we want a order 9 is intentional, it's for a compression workspace
(bugzilla comment 5). It's allocated as kvzalloc i.e. with the fallback
to vmalloc in case the first one fails.

> <snip>
> 	if (area->nr_pages != nr_small_pages) {
> 		/* vm_area_alloc_pages() can also fail due to a fatal signal */
> 		if (!fatal_signal_pending(current))
> 			warn_alloc(gfp_mask, NULL,
> 				"vmalloc error: size %lu, page order %u, failed to allocate pages",
> 				area->nr_pages * PAGE_SIZE, page_order);
> 		goto fail;
> 	}
> <snip>
> 
> and it fails.
> 
> If the __GFP_NOFAIL is passed, the vm_area_alloc_pages() function switches
> to allocate 0-order pages instead. I think the fix is to call the
> kvmalloc_node() with __GFP_NOFAIL flag.

__GFP_NOFAIL does not make sense here and we've tried hard not to used
it anywhere because of the deadlocky effects. Did you mean __GFP_NOWARN?
That's a patch I sent today but there's another comment in the bugzilla
that we got more allocation warnings for huge (2M) allocations, this
time it was for a deduplication ioctl.

This seems to be a noticeable change in 6.3, before we disable the
warning in our code I think the MM guys could have a look. So far it
seems we're about to paper of a problem.
