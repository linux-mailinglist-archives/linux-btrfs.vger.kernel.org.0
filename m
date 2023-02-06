Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92268C58B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 19:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBFSRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 13:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBFSRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 13:17:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B092B2AE
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 10:17:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 925E63F732;
        Mon,  6 Feb 2023 18:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675707424;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ECCT8xohA5dQd4yN/fT+e/VhAv10kyr506XhXNqc77Y=;
        b=FLnOh1FzOEz6mJStI5n29R/zjEekP1ayZUfd527O07D8p0l2bf4lvz2V7AAjK0N4EjXZ4y
        0W3ps+JDBJWx7ydnUPk60AMZB+JS/7Ec+d/+45GEmMtxCoopaxgWd2RmtEq67X17LzXh3P
        X6Dm3ySigVhUfRSCALv1p69Ha8kxw4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675707424;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ECCT8xohA5dQd4yN/fT+e/VhAv10kyr506XhXNqc77Y=;
        b=P5cZUhOthWt+mGQwE5TtXfv26U9g/vsMfspi8ZKxByzICh9a3Ig0+m6kqB02M9Z+6F/Css
        idv20l3TQYL/pQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A4B0138E7;
        Mon,  6 Feb 2023 18:17:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gwDgGCBE4WNORAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Feb 2023 18:17:04 +0000
Date:   Mon, 6 Feb 2023 19:11:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: restore assertion failure to the code line where
 it happens
Message-ID: <20230206181116.GB28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230127133202.16220-1-dsterba@suse.com>
 <4fd172e0-bfe5-681d-8e81-bc5955922456@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd172e0-bfe5-681d-8e81-bc5955922456@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 31, 2023 at 07:11:43PM +0800, Anand Jain wrote:
> On 1/27/23 21:32, David Sterba wrote:
> > In commit 083bd7e54e8e ("btrfs: move the printk and assert helpers to
> > messages.c") btrfs_assertfail got un-inlined. This means that assertion
> > failures would all report as messages.c:259 as below, so make it inline
> > again.
> > 
> >    [403.246730] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4259
> >    [403.247935] ------------[ cut here ]------------
> >    [403.248405] kernel BUG at fs/btrfs/messages.c:259!
> 
> 
> Hmm. We have the line number shown from the assert as block-group.c:4259 
> here.
> 
> messages.c:259 is from the BUG() called by btrfs_assertfail().
> 
> Commit 083bd7e54e8e didn't introduce it. Here is some random example of 
> calling the ASSERT() from 2015.

Right, after double checking the code only got moved, not uninlined.

> ------------------------
> commit 67c5e7d464bc466471b05e027abe8a6b29687ebd
> <snap>
>      [181631.208236] BTRFS: assertion failed: 0, file: 
> fs/btrfs/volumes.c, line: 2622
>      [181631.220591] ------------[ cut here ]------------
>      [181631.222959] kernel BUG at fs/btrfs/ctree.h:4062!
> ------------------------
> 
> 
> >   #ifdef CONFIG_BTRFS_ASSERT
> > -void __cold btrfs_assertfail(const char *expr, const char *file, int line);
> 
> > +static inline void __cold __noreturn btrfs_assertfail(const char *expr,
> 
> Further, this won't make all the calls to btrfs_assertfail() as inline 
> unless __always_inline is used.

The always_inline has a bit stronger semantics and it would be safer to
use it here though the function is short enough to be considered for
inlining.

If the inlining or not is useful would need to be measured, inlining
grows the function code vs just a function call. I'll may be do that but
for now the code can stay as is.
