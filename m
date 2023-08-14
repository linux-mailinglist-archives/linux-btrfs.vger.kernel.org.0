Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1777C0A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 21:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjHNTT4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 15:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjHNTTr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 15:19:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE110D0;
        Mon, 14 Aug 2023 12:19:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB2F91F383;
        Mon, 14 Aug 2023 19:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692040783;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWt0n5Bz0xrgGTrlj+tin8YxwC6XtAxbAwDMLF6l0Sk=;
        b=UyIwWXyUGs3CYMnhuj7D292BIRvdFVGADTFTTH1zGs0SH8HEcvraGX7hpKcPq0AE1F/OzK
        OE0IUcX3CG7E6WxpmtsO9N+NzCp7kGADQN8Gt7lGSpRAGPzEXGmGyKnu468lLUIhKMCwS/
        WO4hi/jqVALJaIn754z25HosgujczAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692040783;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWt0n5Bz0xrgGTrlj+tin8YxwC6XtAxbAwDMLF6l0Sk=;
        b=QlMupPRral3SJlFUoI2qObeMewUcogwhC6OxgrOaJG0DBX8XIGe2/EB2JWT2y2vSQPM1+5
        JyfuJsVymeI06cAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B2EB138EE;
        Mon, 14 Aug 2023 19:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l9dKIE9+2mTOegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 14 Aug 2023 19:19:43 +0000
Date:   Mon, 14 Aug 2023 21:13:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Yikebaer Aizezi <yikebaer61@gmail.com>, clm@fb.com,
        dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in set_state_bits
Message-ID: <20230814191316.GE2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CALcu4rZGym6uSKJqgMJpSmGgiGX=8sHRrukqR85VCiEPDFddkA@mail.gmail.com>
 <2ffff901-81fc-476e-9bcd-8d351b25e07c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffff901-81fc-476e-9bcd-8d351b25e07c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 14, 2023 at 05:31:41PM +0800, Qu Wenruo wrote:
> On 2023/8/14 14:23, Yikebaer Aizezi wrote:
> > Hello,
> >
> > When using Healer to fuzz the Linux-6.5-rc5,  the following crash
> > was triggered.
> >
> > HEAD commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f (tag: v6.5-rc5)
> > git tree: upstream
> >
> > console output:
> > https://drive.google.com/file/d/1KuE7x7TW_pt_aNWWr2GAdehfYixsgeOO/view?usp=drive_link
> > kernel config:https://drive.google.com/file/d/1b_em6R2Zl98np83b818BzE1FrxbiaGuh/view?usp=drive_link
> > C reproducer:https://drive.google.com/file/d/1HlzFbWr3wqzlLi8I2_ZCQumS71WDLXj1/view?usp=drive_link
> > Syzlang reproducer:
> > https://drive.google.com/file/d/1Bu70LrWxOzsbkilELLuxo8VnjcAFiH1Y/view?usp=drive_link
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
> >
> >
> > memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=8428 'syz-executor'
> > loop1: detected capacity change from 0 to 32768
> > BTRFS: device fsid 84eb0a0b-d357-4bc1-8741-9d3223c15974 devid 1
> > transid 7 /dev/loop1 scanned by syz-executor (8428)
> > BTRFS info (device loop1): using xxhash64 (xxhash64-generic) checksum algorithm
> > BTRFS info (device loop1): disk space caching is enabled
> > BTRFS info (device loop1): enabling ssd optimizations
> > BTRFS info (device loop1): auto enabling async discard
> > FAULT_INJECTION: forcing a failure.
> > name failslab, interval 1, probability 0, space 0, times 1
> > CPU: 0 PID: 8428 Comm: syz-executor Not tainted 6.5.0-rc5 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0x132/0x150 lib/dump_stack.c:106
> >   fail_dump lib/fault-inject.c:52 [inline]
> >   should_fail_ex+0x49f/0x5b0 lib/fault-inject.c:153
> >   should_failslab+0x5/0x10 mm/slab_common.c:1471
> >   slab_pre_alloc_hook mm/slab.h:711 [inline]
> >   slab_alloc_node mm/slub.c:3452 [inline]
> >   __kmem_cache_alloc_node+0x61/0x350 mm/slub.c:3509
> >   kmalloc_trace+0x22/0xd0 mm/slab_common.c:1076
> >   kmalloc include/linux/slab.h:582 [inline]
> >   ulist_add_merge fs/btrfs/ulist.c:210 [inline]
> >   ulist_add_merge+0x16f/0x660 fs/btrfs/ulist.c:198
> >   add_extent_changeset fs/btrfs/extent-io-tree.c:191 [inline]
> 
> If you checked the call site, it is doing GFP_ATOMIC allocation inside a
> critical section.
> 
> Doing such error injection without any clue is not really helping here.
> You can even inject error to NOFAIL call sites, and everyone would not
> really treat it serious.
> 
> IIRC even syzbot is no longer reporting errors with blind error
> injection anymore.

Error injection makes sense for realistic errors that are hard to hit,
the memory allocation failure injected in this case is possible but not
realistic. Fixing it is desirable but otherwise has low priority.
