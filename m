Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9982364091D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Dec 2022 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiLBPPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Dec 2022 10:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiLBPPI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Dec 2022 10:15:08 -0500
Received: from out29-223.mail.aliyun.com (out29-223.mail.aliyun.com [115.124.29.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53159CD9BD
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Dec 2022 07:15:05 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06500351|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0994864-0.00859541-0.891918;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.QMICyeH_1669994102;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QMICyeH_1669994102)
          by smtp.aliyun-inc.com;
          Fri, 02 Dec 2022 23:15:02 +0800
Date:   Fri, 02 Dec 2022 23:15:03 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [syzbot] WARNING: kmalloc bug in btrfs_ioctl_send
In-Reply-To: <20221129155631.GU5824@twin.jikos.cz>
References: <00000000000075a52e05ee97ad74@google.com> <20221129155631.GU5824@twin.jikos.cz>
Message-Id: <20221202231502.8623.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, linux-btrfs only

> On Tue, Nov 29, 2022 at 12:21:41AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=176a733d880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=54b747d981acc7b7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4376a9a073770c173269
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134c3d03880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13237ca1880000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/d75f5f77b3a3/disk-6d464646.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/9382f86e4d95/vmlinux-6d464646.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/cf2b5f0d51dd/Image-6d464646.gz.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/aa0da055eccb/mount_0.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4376a9a073770c173269@syzkaller.appspotmail.com
> > 
> > BTRFS info (device loop0): using free space tree
> > BTRFS info (device loop0): enabling ssd optimizations
> > BTRFS info (device loop0): checking UUID tree
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 3072 at mm/util.c:596 kvmalloc_node+0x19c/0x1a4
> 
>  594         /* Don't even allow crazy sizes */
>  595         if (unlikely(size > INT_MAX)) {
>  596                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>  597                 return NULL;
>  598         }
> 
> > Modules linked in:
> > CPU: 1 PID: 3072 Comm: syz-executor189 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : kvmalloc_node+0x19c/0x1a4
> > lr : kvmalloc_node+0x198/0x1a4 mm/util.c:596
> > sp : ffff800012f13c40
> > x29: ffff800012f13c50 x28: ffff0000cbb01000 x27: 0000000000000000
> > x26: 0000000000000000 x25: ffff0000c97a8a10 x24: ffff0000c6fa6400
> > x23: 0000000000000000 x22: ffff8000091f72d8 x21: 000caf0ca5eccda0
> > x20: 00000000ffffffff x19: 0000000000000dc0 x18: 0000000000000010
> > x17: ffff80000c0f0b68 x16: ffff80000dbe6158 x15: ffff0000c43a1a40
> > x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c43a1a40
> > x11: ff808000084361e8 x10: 0000000000000000 x9 : ffff8000084361e8
> > x8 : ffff0000c43a1a40 x7 : ffff800008578874 x6 : 0000000000000000
> > x5 : 00000000ffffffff x4 : 0000000000012dc0 x3 : 0010000000000000
> > x2 : 000caf0ca5eccda0 x1 : 0000000000000000 x0 : 0000000000000000
> > Call trace:
> >  kvmalloc_node+0x19c/0x1a4
> >  kvmalloc include/linux/slab.h:706 [inline]
> >  kvmalloc_array include/linux/slab.h:724 [inline]
> >  kvcalloc include/linux/slab.h:729 [inline]
> >  btrfs_ioctl_send+0x64c/0xed0 fs/btrfs/send.c:7915
> 
> 7915         sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
> 7916                                      arg->clone_sources_count + 1,
> 7917                                      GFP_KERNEL)
> 
> So we get some insane amount of clone_sources_count

  7844          if (arg->clone_sources_count >
  7845              ULONG_MAX / sizeof(struct clone_root) - 1) {
  7846                  ret = -EINVAL;
  7847                  goto out;
  7848          }

here we can change 'ULONG_MAX' to 'INT_MAX' or
just 'arg->clone_sources_count > SEND_MAX_EXTENT_REFS' ?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/12/02

