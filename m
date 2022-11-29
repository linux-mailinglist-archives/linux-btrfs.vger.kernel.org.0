Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B35663C449
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Nov 2022 16:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiK2P5O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Nov 2022 10:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiK2P5J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Nov 2022 10:57:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B5429A4;
        Tue, 29 Nov 2022 07:57:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF2061F8A3;
        Tue, 29 Nov 2022 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669737425;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4rrof04B4BUneN0YAsgvWJibMt8zt/DghF1AH6ZuDQA=;
        b=0luU5yo5h3ZP04gBIzb0u9hlMiZ/rdkMgJ+fSlEB5r4wwsyC4JBsQbDqWTE3fafyUUHylr
        31ZN/rOpEvANpvVjDmBvAUfG59TZCgkoMC8knlwrWTVcv2D0OJZtPB3hWw2Qo3AuZmsQeo
        JcvoaDRoq0JDj4LlNnTrpFuC58GF2G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669737425;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4rrof04B4BUneN0YAsgvWJibMt8zt/DghF1AH6ZuDQA=;
        b=++eLHpZyULBiT85ijUx3ofc3K8rdSmQmAs+NR3BJ/JBuy1MtdaKFGi8vD7dJQaAb4FzMjP
        y6Wj+7vUAYGEoqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6FCA13AF6;
        Tue, 29 Nov 2022 15:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DvzXK9ErhmMtBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 29 Nov 2022 15:57:05 +0000
Date:   Tue, 29 Nov 2022 16:56:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+4376a9a073770c173269@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: kmalloc bug in btrfs_ioctl_send
Message-ID: <20221129155631.GU5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000075a52e05ee97ad74@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000075a52e05ee97ad74@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 29, 2022 at 12:21:41AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=176a733d880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=54b747d981acc7b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=4376a9a073770c173269
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134c3d03880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13237ca1880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d75f5f77b3a3/disk-6d464646.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9382f86e4d95/vmlinux-6d464646.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cf2b5f0d51dd/Image-6d464646.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/aa0da055eccb/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4376a9a073770c173269@syzkaller.appspotmail.com
> 
> BTRFS info (device loop0): using free space tree
> BTRFS info (device loop0): enabling ssd optimizations
> BTRFS info (device loop0): checking UUID tree
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3072 at mm/util.c:596 kvmalloc_node+0x19c/0x1a4

 594         /* Don't even allow crazy sizes */
 595         if (unlikely(size > INT_MAX)) {
 596                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
 597                 return NULL;
 598         }

> Modules linked in:
> CPU: 1 PID: 3072 Comm: syz-executor189 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : kvmalloc_node+0x19c/0x1a4
> lr : kvmalloc_node+0x198/0x1a4 mm/util.c:596
> sp : ffff800012f13c40
> x29: ffff800012f13c50 x28: ffff0000cbb01000 x27: 0000000000000000
> x26: 0000000000000000 x25: ffff0000c97a8a10 x24: ffff0000c6fa6400
> x23: 0000000000000000 x22: ffff8000091f72d8 x21: 000caf0ca5eccda0
> x20: 00000000ffffffff x19: 0000000000000dc0 x18: 0000000000000010
> x17: ffff80000c0f0b68 x16: ffff80000dbe6158 x15: ffff0000c43a1a40
> x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c43a1a40
> x11: ff808000084361e8 x10: 0000000000000000 x9 : ffff8000084361e8
> x8 : ffff0000c43a1a40 x7 : ffff800008578874 x6 : 0000000000000000
> x5 : 00000000ffffffff x4 : 0000000000012dc0 x3 : 0010000000000000
> x2 : 000caf0ca5eccda0 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  kvmalloc_node+0x19c/0x1a4
>  kvmalloc include/linux/slab.h:706 [inline]
>  kvmalloc_array include/linux/slab.h:724 [inline]
>  kvcalloc include/linux/slab.h:729 [inline]
>  btrfs_ioctl_send+0x64c/0xed0 fs/btrfs/send.c:7915

7915         sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
7916                                      arg->clone_sources_count + 1,
7917                                      GFP_KERNEL)

So we get some insane amount of clone_sources_count

>  _btrfs_ioctl_send+0x188/0x218 fs/btrfs/ioctl.c:5233
>  btrfs_ioctl+0x5c0/0xa64
>  vfs_ioctl fs/ioctl.c:51 [inline]
