Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E37B7FD3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjJDMxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJDMxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 08:53:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA64C4
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 05:53:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8EF612183A;
        Wed,  4 Oct 2023 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696423981;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFVjgrKi+R9BvMO/MUr+qFBcdQs8mdfMiDOtiF6rvlk=;
        b=iI2eFxtDVvaIiuoZd2mBjaLKSFzM8GkzC4547FT8arcTc9YkzfSzNjAXf9gZ2NzB3GLisi
        0AaO9E1JzpBT7DOoD2zANsKDIO+11+Zw5rAEKt9YZ28HdLrFgZx8PPrO70Zp49gpDhyJXB
        Y2L5RL27FGV+UhsHyGNZH6DKFkjgyt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696423981;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFVjgrKi+R9BvMO/MUr+qFBcdQs8mdfMiDOtiF6rvlk=;
        b=wvZ1p8QnDf+uKW83tc48UypQrqHBp3PiL405YVQCI16YEuHHH0qg5V58rs2xdjaLtcsW6K
        L4s9S9wtCBpRnmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62CD213A2E;
        Wed,  4 Oct 2023 12:53:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Iu1UFy1gHWXRQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 04 Oct 2023 12:53:01 +0000
Date:   Wed, 4 Oct 2023 14:46:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/8] btrfs: relocation: use on-stack iterator in
 build_backref_tree
Message-ID: <20231004124618.GA28758@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695380646.git.dsterba@suse.com>
 <7588cec46a2d548400de33930811fa12026f1dd1.1695380646.git.dsterba@suse.com>
 <CAL3q7H6wryrNsjk8HZqqiSyMHTcxcPC-kd2U-uCEVxWYHAPV2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6wryrNsjk8HZqqiSyMHTcxcPC-kd2U-uCEVxWYHAPV2Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 04, 2023 at 01:35:26PM +0100, Filipe Manana wrote:
> On Fri, Sep 22, 2023 at 2:26 PM David Sterba <dsterba@suse.com> wrote:
> >
> > build_backref_tree() is called in a loop by relocate_tree_blocks()
> > for each relocated block. The iterator is allocated and freed repeatedly
> > while we could simply use an on-stack variable to avoid the allocation
> > and remove one more failure case. The stack grows by 48 bytes.
> >
> > This was the only use of btrfs_backref_iter_alloc() so it's changed to
> > be an initializer and btrfs_backref_iter_free() can be removed
> > completely.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/backref.c    | 26 ++++++++++----------------
> >  fs/btrfs/backref.h    | 11 ++---------
> >  fs/btrfs/relocation.c | 12 ++++++------
> >  3 files changed, 18 insertions(+), 31 deletions(-)
> >
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index 0dc91bf654b5..691b20b47065 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -2828,26 +2828,20 @@ void free_ipath(struct inode_fs_paths *ipath)
> >         kfree(ipath);
> >  }
> >
> > -struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info)
> > +int btrfs_backref_iter_init(struct btrfs_fs_info *fs_info,
> > +                           struct btrfs_backref_iter *iter)
> >  {
> > -       struct btrfs_backref_iter *ret;
> > -
> > -       ret = kzalloc(sizeof(*ret), GFP_NOFS);
> > -       if (!ret)
> > -               return NULL;
> > -
> > -       ret->path = btrfs_alloc_path();
> > -       if (!ret->path) {
> > -               kfree(ret);
> > -               return NULL;
> > -       }
> > +       memset(iter, 0, sizeof(struct btrfs_backref_iter));
> > +       iter->path = btrfs_alloc_path();
> 
> So this is breaking misc-next, as paths are leaking here, easily
> visible after "rmmod btrfs":
> 
> [ 2265.115295] =============================================================================
> [ 2265.115938] BUG btrfs_path (Not tainted): Objects remaining in
> btrfs_path on __kmem_cache_shutdown()
> [ 2265.116615] -----------------------------------------------------------------------------
> 
> [ 2265.117614] Slab 0x00000000dbb6fd30 objects=36 used=3
> fp=0x000000001768ab21
> flags=0x17fffc000000800(slab|node=0|zone=2|lastcpupid=0x1ffff)
> [ 2265.118423] CPU: 1 PID: 402761 Comm: rmmod Not tainted
> 6.6.0-rc3-btrfs-next-139+ #1
> [ 2265.118440] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [ 2265.118457] Call Trace:
> [ 2265.118483]  <TASK>
> [ 2265.118491]  dump_stack_lvl+0x44/0x60
> [ 2265.118521]  slab_err+0xb6/0xf0
> [ 2265.118547]  __kmem_cache_shutdown+0x15f/0x2f0
> [ 2265.118565]  kmem_cache_destroy+0x4c/0x170
> [ 2265.118588]  exit_btrfs_fs+0x24/0x40 [btrfs]
> [ 2265.119121]  __x64_sys_delete_module+0x193/0x290
> [ 2265.119137]  ? exit_to_user_mode_prepare+0x3d/0x170
> [ 2265.119154]  do_syscall_64+0x38/0x90
> [ 2265.119169]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 2265.119185] RIP: 0033:0x7f55ec127997
> [ 2265.119199] Code: 73 01 c3 48 8b 0d 81 94 0c 00 f7 d8 64 89 01 48
> 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 94 0c 00 f7 d8 64 89
> 01 48
> [ 2265.119210] RSP: 002b:00007ffe06412d98 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [ 2265.119225] RAX: ffffffffffffffda RBX: 00005589627f26f0 RCX: 00007f55ec127997
> [ 2265.119234] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005589627f2758
> [ 2265.119241] RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
> [ 2265.119249] R10: 00007f55ec19aac0 R11: 0000000000000206 R12: 00007ffe06412fe0
> [ 2265.119257] R13: 00007ffe064133da R14: 00005589627f22a0 R15: 00007ffe06412fe8
> [ 2265.119276]  </TASK>
> [ 2265.119281] Disabling lock debugging due to kernel taint
> [ 2265.119289] Object 0x0000000062d6ea78 @offset=784
> [ 2265.120073] Object 0x0000000042bd66e6 @offset=1904
> [ 2265.120712] Object 0x00000000603962f0 @offset=2240
> [ 2265.121397] =============================================================================
> [ 2265.122021] BUG btrfs_path (Tainted: G    B             ): Objects
> remaining in btrfs_path on __kmem_cache_shutdown()
> (...)
> 
> I get thousands and thousands of these messages after running fstests
> and doing "rmmod btrfs".

Thanks, for catching it, I don't seem to have the rmmod test in my
setups.

> The problem here is the code is reusing the iterator, and every time
> allocating a new path without freeing the previous one.
> It could simply avoid path allocation and reuse it.

I'll remove the patch for now and revisit using this suggestion, thanks.
