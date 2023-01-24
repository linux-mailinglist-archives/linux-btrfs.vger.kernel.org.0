Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2683E67A088
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 18:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjAXRwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 12:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjAXRwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 12:52:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DD5251;
        Tue, 24 Jan 2023 09:52:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7755521976;
        Tue, 24 Jan 2023 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674582764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Skva1shEE/HsMOpqBg9bz8kfTRteiEo++f+fehu7oXw=;
        b=aGX0E8XrDCHcRCVG3VAY9Z/gQpmErfQtaWPiBaHPevpj2iOZqOftEvAlT7qZciHFusvaWL
        ROLYxMyj9sOIfsRfJUxhyXQFuUYzWZyqK5hBDYCXvH4QuS5OYrpxFkOoVcpNhEGuwqaeft
        OrLH7ELI1Rk4NiVRljzdCVFT3D2DE4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674582764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Skva1shEE/HsMOpqBg9bz8kfTRteiEo++f+fehu7oXw=;
        b=pK5suF+uVP5Hv8VS5Us1ycz54+2ik14Xx8i3plKx4K3jEuqlAGJnfGJ+5Y/hEZgqtfkQg9
        YKbOJSEar9gphZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C00F13487;
        Tue, 24 Jan 2023 17:52:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ARm8Cewa0GNCdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 Jan 2023 17:52:44 +0000
Date:   Tue, 24 Jan 2023 18:47:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+4376a9a073770c173269@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        dsterba@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, w@1wt.eu
Subject: Re: [syzbot] [btrfs?] WARNING: kmalloc bug in btrfs_ioctl_send
Message-ID: <20230124174702.GU11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000075a52e05ee97ad74@google.com>
 <0000000000006e58cb05f2d86236@google.com>
 <CAHk-=whJ0Rya9++f5B=6euHxRGRKOYNZARxN7bZb61RmOHGnFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whJ0Rya9++f5B=6euHxRGRKOYNZARxN7bZb61RmOHGnFA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 22, 2023 at 11:53:08AM -0800, Linus Torvalds wrote:
> On Sun, Jan 22, 2023 at 3:14 AM syzbot
> <syzbot+4376a9a073770c173269@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit 7661809d493b426e979f39ab512e3adf41fbcc69
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Wed Jul 14 16:45:49 2021 +0000
> >
> >     mm: don't allow oversized kvmalloc() calls
> 
> Heh. I assume this is the
> 
>         sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
>                                      arg->clone_sources_count + 1,
>                                      GFP_KERNEL);
> 
> in btrfs_ioctl_send(), where the 'clone_sources_count' thing is
> basically just an argument to the btrfs ioctl, and user space can set
> it to anything it damn well likes.
> 
> So that warning is very much correct, and the problem is that the code
> doesn't do any  realsanity checking at all on the ioctl arguments, and
> basically allows the code to exhaust all memory.
> 
> Ok, there's a sanity check in the form of an overflow check:
> 
>         /*
>          * Check that we don't overflow at later allocations, we request
>          * clone_sources_count + 1 items, and compare to unsigned long inside
>          * access_ok.
>          */
>         if (arg->clone_sources_count >
>             ULONG_MAX / sizeof(struct clone_root) - 1) {
>                 ret = -EINVAL;
>                 goto out;
>         }
> 
> but ULONG_MAX is a *lot* of memory that the btrfs code is happy to try
> to allocate.
> 
> This ioctl does seem to be protected by a
> 
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
> 
> so at least it wasn't some kind of "random user can use up all memory".
> 
> I suspect the simplest way to make syzbot happy is to change the
> 
>         if (arg->clone_sources_count >
>             ULONG_MAX / sizeof(struct clone_root) - 1) {
> 
> test to use INT_MAX instead of ULONG_MAX, which will then match the
> vmalloc sanity check and avoid the warning.
> 
> But maybe an even smaller value might be more domain-appropriate here?

Real world number for clone_sources_count would be low, in tens or
hundreds at most.  Size of struct clone_root is 40 bytes, and 1M array
can hold about 26K items, which is enough for some realistic stress
testing. I'll set the limit for allocated memory to 8M which should be
generous (about 200K array items) and future proof in case new members
need to be added to clone_root.
