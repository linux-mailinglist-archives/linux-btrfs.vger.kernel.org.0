Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958AD64AFFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 07:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiLMGkb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 01:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLMGka (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 01:40:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6077BE0E;
        Mon, 12 Dec 2022 22:40:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A24761330;
        Tue, 13 Dec 2022 06:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389E7C433D2;
        Tue, 13 Dec 2022 06:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670913628;
        bh=jb4WvD/Lz4Ywp31spUGOBKaoeKuHgB6FtTjgVpaXqY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSxCFSJzyZSW8MFu7sBHzMLw9t3gdWBmmoJtW2jLDan2z8ydq6jFHjBb3D2OpaAjK
         Z+01ztD5zV0Gewn2zWseoKcK5xCtvz8djL0V8AxHDgsIpsRxZ/oPlV305CSNaCkdju
         xXSHaX2caT6+QrHJebzPz1QCKuenF3EEmqPhzCem0uDR1SjZhkMXv6lrB1ePTQwljr
         4cQmm9vhz/AWsTLYCyc9WCa1KjcxqKcHYC9IqZaanrxBvDN4QlxJqUqizw/Hr9e0h5
         f4z+LVyHRAFs5EJSVTZZeGhm+JK2B3Qqcm/pxsgV1tP0s+w0wXSco5jCWPSSqlOBsS
         AWOARcr9dXv/g==
Date:   Mon, 12 Dec 2022 22:40:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, glider@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KMSAN: uninit-value in longest_match
Message-ID: <Y5geWpk1WfgwjzuA@sol.localdomain>
References: <0000000000004f995905ef61a764@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004f995905ef61a764@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 09, 2022 at 01:19:41AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    30d2727189c5 kmsan: fix memcpy tests
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=117d38f5880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a2144983ada8b4f3
> dashboard link: https://syzkaller.appspot.com/bug?extid=14d9e7602ebdf7ec0a60
> compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1e8c2d419c2e/disk-30d27271.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9e8a728a72a9/vmlinux-30d27271.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/89f71c80c707/bzImage-30d27271.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in longest_match+0xc88/0x1220 lib/zlib_deflate/deflate.c:668
>  longest_match+0xc88/0x1220 lib/zlib_deflate/deflate.c:668
>  deflate_fast+0x1838/0x2280 lib/zlib_deflate/deflate.c:954
>  zlib_deflate+0x1783/0x22b0 lib/zlib_deflate/deflate.c:410
>  zlib_compress_pages+0xd34/0x1f90 fs/btrfs/zlib.c:178
>  compression_compress_pages fs/btrfs/compression.c:77 [inline]
>  btrfs_compress_pages+0x325/0x440 fs/btrfs/compression.c:1208
>  compress_file_range+0x11ac/0x3510 fs/btrfs/inode.c:730
>  async_cow_start+0x33/0xd0 fs/btrfs/inode.c:1458
>  btrfs_work_helper+0x55a/0x990 fs/btrfs/async-thread.c:280
>  process_one_work+0xb27/0x13e0 kernel/workqueue.c:2289
>  worker_thread+0x1076/0x1d60 kernel/workqueue.c:2436
>  kthread+0x31b/0x430 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

zlib has long been known to use initialized values in longest_match().  This
issue is mentioned in the zlib FAQ.  I personally consider this to be a bug, as
the code could be written in a way such that it doesn't use uninitialized
memory.  However, zlib considers it to be "safe" and "working as intended".

Note that the copy of zlib in Linux is not really being maintained, and it is
based on a 25-year old version of zlib.  However, upstream zlib does not change
much anyway (it's very hard to get changes accepted into it), and as far as I
can tell even the latest version of upstream zlib has this same issue.

So I suppose the way to resolve this syzbot report is to just add
__no_kmsan_checks to longest_match().  The real issue, though, is that zlib
hasn't kept up with the times (nor has Linux kept up with zlib).

- Eric
