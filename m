Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08EF642EAF
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 18:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiLER1d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 12:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiLER12 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 12:27:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90E1D67F
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 09:27:27 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CAAF01FE11;
        Mon,  5 Dec 2022 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670261245;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKSv+E3A7Ocxzaur3XXtaqgtB5YW8F4YeCJxcmd+7x4=;
        b=xESJ/AbI6n8EzPXqK2530acj/9wa3HA0wBMJuxqMYw5+ngFacFr/Zdw3gbuzENwwX3HIOi
        Q/YMWQH5nhWQWjsBsFjdRpTKFpxRqom5Lq3BrDn8fjGcf/Uf8wB2eHJt3deMaSIwunRTwD
        p5JQcdVnVzil1gbP9Fh2OZTUFiUxtxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670261245;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKSv+E3A7Ocxzaur3XXtaqgtB5YW8F4YeCJxcmd+7x4=;
        b=GARWdjiD5ZOG2BX7/GsLiWfzI9/uKyrREbOAdQqBbJQMBCMRs/O3PdExYVbD+ykXdG5ZDY
        BardauhjssHBtBDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AD8D41348F;
        Mon,  5 Dec 2022 17:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ofCQKf0pjmPycQAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Mon, 05 Dec 2022 17:27:25 +0000
Date:   Mon, 5 Dec 2022 18:26:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [syzbot] WARNING: kmalloc bug in btrfs_ioctl_send
Message-ID: <20221205172647.GB5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000075a52e05ee97ad74@google.com>
 <20221129155631.GU5824@twin.jikos.cz>
 <20221202231502.8623.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202231502.8623.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 02, 2022 at 11:15:03PM +0800, Wang Yugui wrote:
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+4376a9a073770c173269@syzkaller.appspotmail.com
> > > 
> > > BTRFS info (device loop0): using free space tree
> > > BTRFS info (device loop0): enabling ssd optimizations
> > > BTRFS info (device loop0): checking UUID tree
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 3072 at mm/util.c:596 kvmalloc_node+0x19c/0x1a4
> > 
> >  594         /* Don't even allow crazy sizes */
> >  595         if (unlikely(size > INT_MAX)) {
> >  596                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> >  597                 return NULL;
> >  598         }
> > 
> > > Modules linked in:
> > > CPU: 1 PID: 3072 Comm: syz-executor189 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > pc : kvmalloc_node+0x19c/0x1a4
> > > lr : kvmalloc_node+0x198/0x1a4 mm/util.c:596
> > > sp : ffff800012f13c40
> > > x29: ffff800012f13c50 x28: ffff0000cbb01000 x27: 0000000000000000
> > > x26: 0000000000000000 x25: ffff0000c97a8a10 x24: ffff0000c6fa6400
> > > x23: 0000000000000000 x22: ffff8000091f72d8 x21: 000caf0ca5eccda0
> > > x20: 00000000ffffffff x19: 0000000000000dc0 x18: 0000000000000010
> > > x17: ffff80000c0f0b68 x16: ffff80000dbe6158 x15: ffff0000c43a1a40
> > > x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c43a1a40
> > > x11: ff808000084361e8 x10: 0000000000000000 x9 : ffff8000084361e8
> > > x8 : ffff0000c43a1a40 x7 : ffff800008578874 x6 : 0000000000000000
> > > x5 : 00000000ffffffff x4 : 0000000000012dc0 x3 : 0010000000000000
> > > x2 : 000caf0ca5eccda0 x1 : 0000000000000000 x0 : 0000000000000000
> > > Call trace:
> > >  kvmalloc_node+0x19c/0x1a4
> > >  kvmalloc include/linux/slab.h:706 [inline]
> > >  kvmalloc_array include/linux/slab.h:724 [inline]
> > >  kvcalloc include/linux/slab.h:729 [inline]
> > >  btrfs_ioctl_send+0x64c/0xed0 fs/btrfs/send.c:7915
> > 
> > 7915         sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
> > 7916                                      arg->clone_sources_count + 1,
> > 7917                                      GFP_KERNEL)
> > 
> > So we get some insane amount of clone_sources_count
> 
>   7844          if (arg->clone_sources_count >
>   7845              ULONG_MAX / sizeof(struct clone_root) - 1) {
>   7846                  ret = -EINVAL;
>   7847                  goto out;
>   7848          }
> 
> here we can change 'ULONG_MAX' to 'INT_MAX' or
> just 'arg->clone_sources_count > SEND_MAX_EXTENT_REFS' ?

SEND_MAX_EXTENT_REFS is for something else, the extent sharing but the
allocation is about potential share sources. So there could be say 2000
subvolumes but each extent could be shared at most by say 500.

The limit for clone_roots should be based on the maximum memory we
consider sane. The size of struct clone_root is 32 bytes on release
build, so with SEND_MAX_EXTENT_REFS which is 1024 this would be 32KiB,
which is not much and an artificial limit.

As the allocation uses virtual memory fallback we can go to
megabytes-range, possibly adding the __GFP_NOWARN. So my suggestion is
to do 4MiB as the overall memory limit and derive the
clone_sources_count limit accordingly, which is 131072.
