Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE27369EB78
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 00:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBUXw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 18:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBUXwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 18:52:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8355F2E80F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 15:52:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F65A5C3C7;
        Tue, 21 Feb 2023 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677023528;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGEFGcDMDKoND+2AOmXxGV9iGCQJKynyRtmKRNVePEc=;
        b=t9XQGx5rBncuwF4eLgjw+Lv4p9ABNSq8WxbvsPcfOpqL07xHk+a0ztBC+t3dSBmEbC+S2T
        2ThkxSkGXIovG3n4SIdfgHlTvIqcP5aPyFIW/H+9xx960EtyWkau8xCtmeUBbuYaZQRBeG
        tWKrr8Atvo9BXCXcmmzw6Ndy55wqtOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677023528;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGEFGcDMDKoND+2AOmXxGV9iGCQJKynyRtmKRNVePEc=;
        b=ARc2TfSKJdSWOUzfQfFnjVhq1ds/warXkeSIaGkEWDZJD2YafM7nCKOqxR/Mqm2zqOPqGa
        sfAbWMhvGBg8FnDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEA3F13223;
        Tue, 21 Feb 2023 23:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aJNtOSdZ9WN3ZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Feb 2023 23:52:07 +0000
Date:   Wed, 22 Feb 2023 00:46:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: restore assertion failure to the code line where
 it happens
Message-ID: <20230221234612.GS10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4fd172e0-bfe5-681d-8e81-bc5955922456@oracle.com>
 <20230206181116.GB28288@twin.jikos.cz>
 <20230221182810.B3E4.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221182810.B3E4.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 06:28:11PM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Tue, Jan 31, 2023 at 07:11:43PM +0800, Anand Jain wrote:
> > > On 1/27/23 21:32, David Sterba wrote:
> > > > In commit 083bd7e54e8e ("btrfs: move the printk and assert helpers to
> > > > messages.c") btrfs_assertfail got un-inlined. This means that assertion
> > > > failures would all report as messages.c:259 as below, so make it inline
> > > > again.
> > > > 
> > > >    [403.246730] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4259
> > > >    [403.247935] ------------[ cut here ]------------
> > > >    [403.248405] kernel BUG at fs/btrfs/messages.c:259!
> > > 
> > > 
> > > Hmm. We have the line number shown from the assert as block-group.c:4259 
> > > here.
> > > 
> > > messages.c:259 is from the BUG() called by btrfs_assertfail().
> > > 
> > > Commit 083bd7e54e8e didn't introduce it. Here is some random example of 
> > > calling the ASSERT() from 2015.
> > 
> > Right, after double checking the code only got moved, not uninlined.
> > 
> > > ------------------------
> > > commit 67c5e7d464bc466471b05e027abe8a6b29687ebd
> > > <snap>
> > >      [181631.208236] BTRFS: assertion failed: 0, file: 
> > > fs/btrfs/volumes.c, line: 2622
> > >      [181631.220591] ------------[ cut here ]------------
> > >      [181631.222959] kernel BUG at fs/btrfs/ctree.h:4062!
> > > ------------------------
> > > 
> > > 
> > > >   #ifdef CONFIG_BTRFS_ASSERT
> > > > -void __cold btrfs_assertfail(const char *expr, const char *file, int line);
> > > 
> > > > +static inline void __cold __noreturn btrfs_assertfail(const char *expr,
> > > 
> > > Further, this won't make all the calls to btrfs_assertfail() as inline 
> > > unless __always_inline is used.
> > 
> > The always_inline has a bit stronger semantics and it would be safer to
> > use it here though the function is short enough to be considered for
> > inlining.
> > 
> > If the inlining or not is useful would need to be measured, inlining
> > grows the function code vs just a function call. I'll may be do that but
> > for now the code can stay as is.
> 
> This patch is yet not in misc-next?

It was not woarking as I though as it does not change how the assertion
line is printed. Inlining would also inline the place of BUG() so that
could make a difference but otherwise needs to be measure how the
inlining bloats the object files.

> By the way , '__cold' is meanless for inline?

Right.
