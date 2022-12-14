Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99464CBF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 15:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbiLNORD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 09:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbiLNORA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 09:17:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A54222BC5;
        Wed, 14 Dec 2022 06:16:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 589FC200AC;
        Wed, 14 Dec 2022 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671027416;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8zM93onZ+wyMUx2u678a0EiovzGYDh0EbHR+OS2gn0=;
        b=FfZ/yjlgGnXm/bhZDI11fbcxfTDq/MOJC/fhiM0WESLXwiqqzw2eZjoK6MlGHkisNV5IV2
        mBt59slsftdZzE8lkN1vtnJsDAbEOLC55s8bTqYNEyPcrTTQ5iJFKW0EUY2Tlh7i8280Tn
        sH2K9BNO7VtSxyfyHykj7RVJyC6/ec4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671027416;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8zM93onZ+wyMUx2u678a0EiovzGYDh0EbHR+OS2gn0=;
        b=JHU4ur/czOhI4MsVTsQxzwtlFJrWvATEEDYHWRhdGrVDIEgBROaBP7F58ADZlIztiob2mr
        jDGiN/my7PyzxDAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14FF5138F6;
        Wed, 14 Dec 2022 14:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vt5QBNjamWPJIQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Dec 2022 14:16:56 +0000
Date:   Wed, 14 Dec 2022 15:16:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Alexander Potapenko <glider@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KMSAN: uninit-value in longest_match
Message-ID: <20221214141613.GB10499@suse.cz>
Reply-To: dsterba@suse.cz
References: <0000000000004f995905ef61a764@google.com>
 <Y5geWpk1WfgwjzuA@sol.localdomain>
 <CAG_fn=XDN23qMwwMCPi=8drv9kE6Z-goFQ8nNN8Qux3bdrnvLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XDN23qMwwMCPi=8drv9kE6Z-goFQ8nNN8Qux3bdrnvLw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 14, 2022 at 02:56:56PM +0100, Alexander Potapenko wrote:
> On Tue, Dec 13, 2022 at 7:40 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > On Fri, Dec 09, 2022 at 01:19:41AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    30d2727189c5 kmsan: fix memcpy tests
> > > git tree:       https://github.com/google/kmsan.git master
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=117d38f5880000
> > > kernel config:
> > https://syzkaller.appspot.com/x/.config?x=a2144983ada8b4f3
> > > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=14d9e7602ebdf7ec0a60
> > > compiler:       clang version 15.0.0 (
> > https://github.com/llvm/llvm-project.git
> > 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian)
> > 2.35.2
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image:
> > https://storage.googleapis.com/syzbot-assets/1e8c2d419c2e/disk-30d27271.raw.xz
> > > vmlinux:
> > https://storage.googleapis.com/syzbot-assets/9e8a728a72a9/vmlinux-30d27271.xz
> > > kernel image:
> > https://storage.googleapis.com/syzbot-assets/89f71c80c707/bzImage-30d27271.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the
> > commit:
> > > Reported-by: syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com
> > >
> > > =====================================================
> > > BUG: KMSAN: uninit-value in longest_match+0xc88/0x1220
> > lib/zlib_deflate/deflate.c:668
> > >  longest_match+0xc88/0x1220 lib/zlib_deflate/deflate.c:668
> > >  deflate_fast+0x1838/0x2280 lib/zlib_deflate/deflate.c:954
> > >  zlib_deflate+0x1783/0x22b0 lib/zlib_deflate/deflate.c:410
> > >  zlib_compress_pages+0xd34/0x1f90 fs/btrfs/zlib.c:178
> > >  compression_compress_pages fs/btrfs/compression.c:77 [inline]
> > >  btrfs_compress_pages+0x325/0x440 fs/btrfs/compression.c:1208
> > >  compress_file_range+0x11ac/0x3510 fs/btrfs/inode.c:730
> > >  async_cow_start+0x33/0xd0 fs/btrfs/inode.c:1458
> > >  btrfs_work_helper+0x55a/0x990 fs/btrfs/async-thread.c:280
> > >  process_one_work+0xb27/0x13e0 kernel/workqueue.c:2289
> > >  worker_thread+0x1076/0x1d60 kernel/workqueue.c:2436
> > >  kthread+0x31b/0x430 kernel/kthread.c:376
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> >
> > zlib has long been known to use initialized values in longest_match().
> > This
> > issue is mentioned in the zlib FAQ.  I personally consider this to be a
> > bug, as
> > the code could be written in a way such that it doesn't use uninitialized
> > memory.  However, zlib considers it to be "safe" and "working as intended".
> >
> > Note that the copy of zlib in Linux is not really being maintained, and it
> > is
> > based on a 25-year old version of zlib.  However, upstream zlib does not
> > change
> > much anyway (it's very hard to get changes accepted into it), and as far
> > as I
> > can tell even the latest version of upstream zlib has this same issue.
> >
> > So I suppose the way to resolve this syzbot report is to just add
> > __no_kmsan_checks to longest_match().  The real issue, though, is that zlib
> > hasn't kept up with the times (nor has Linux kept up with zlib).
> >
> >
> Can't we just pass __GFP_ZERO when allocating the workspace here:
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index b4f44662cda7c..23dc5628f8209 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -63,7 +63,8 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
> 
>         workspacesize = max(zlib_deflate_workspacesize(MAX_WBITS,
> MAX_MEM_LEVEL),
>                         zlib_inflate_workspacesize());
> -       workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
> +       workspace->strm.workspace = kvmalloc(workspacesize,
> +                                            GFP_KERNEL | __GFP_ZERO);

Currently none of the compression workspaces does allocation with
zeroing. I'm not sure if we should actually zero the work memory right
before use, in the *get_workspace helpers so that each compression
starts from the same state. But this will be a performance hit and not
actually necessary if it's not required by the compression methods.

Which would leave only the allocation as the place to zero the memory.
If it's really just zlib that needs that then Ok, I'd suggest to use the
kvzalloc instead of __GFP_ZERO.
