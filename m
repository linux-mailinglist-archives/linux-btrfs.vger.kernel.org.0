Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DF24AB300
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 02:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiBGBCL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 20:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGBCK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 20:02:10 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96157C06173B;
        Sun,  6 Feb 2022 17:02:09 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id o11so6059408vkl.11;
        Sun, 06 Feb 2022 17:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8jrX21L6J3v8bF9fJZsr/4TxVcgur1Mg0vbwPmFjsrk=;
        b=qIZEEhYuBBgsKwJMK9eMXnprvlx/n4XdCiLPfsB69YckfKa4Dx2+NjhIU6x1jeBU5G
         NNWHHj98G40YEKNXNsIAZ5o+cFmafaQH9mtajz+E7KT+ds9Pw6PnL5ohf8xqkb2rnvjo
         MhNYVk+VgYA8oCVzCA1UZ4fMbszrROTJ0F0i1FNgKhHwSFaLsbIh4qZtKN/GCVM8tztd
         g2bDz65OYoue0U0KRufhQf0Xgg6O0LHFWijS97ehrCqo7L18ZYYwZtq9lHRed7fyZIPN
         AqNEgwOCAM4533MkxeQTI7tm4TfthZv4p9XW6qxFFeSv2x/PU+E3AT9QcbA0n4KzXFnk
         KQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8jrX21L6J3v8bF9fJZsr/4TxVcgur1Mg0vbwPmFjsrk=;
        b=jYrsGIMXqrFLHYJ9GHYAkjPoy3v10MFQDck9THArZAerwOJv6o4Nx/LvDdsdlcrPPH
         vNtcfAW7+4tpIxfbt7RoamIIcQDLcp3JGx3DQZoNy4ImDF1OrP3C6PlbgloC6lo/rf6V
         qlAguD2/n+xkyqQ0HAZiQx8egBuN4RGeve3LgAjiQNM+bv0/RHRbaH1CA3sHmWP747uG
         RQ/ZZX4d726QTS7SrrSPo6rI8K7v6b1ofqkmLH46DoPMzolUqaDpb1MRTmO5W5U6dtI+
         ox+q5TC+Ud7GQvE1rPY+kcAitcRrI/CJnhkPHFIsJC8ZNb56MVJgm1knXCmUtLgyuXyO
         5wNQ==
X-Gm-Message-State: AOAM530V6tyb2hIyl87k+1VPUZO4a/yw7XFpXpk26iwWrqTTCKj/43Iy
        osZQD4kQ2g4QzfmAQPegx9Ls+H4qnPW4CPwPDTM=
X-Google-Smtp-Source: ABdhPJyXEbojahwDUj939tV0U0vggVrNPhhwW13LEaYPAM1BNNh97XmRAne7kXrK8LL9p0GHLUubSMrPpXMivGEiaY0=
X-Received: by 2002:a05:6122:d06:: with SMTP id az6mr4294882vkb.22.1644195728353;
 Sun, 06 Feb 2022 17:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20220202214455.15753-1-davispuh@gmail.com> <20220202214455.15753-2-davispuh@gmail.com>
 <Yfx39HbTJIM0GRXL@relinquished.localdomain>
In-Reply-To: <Yfx39HbTJIM0GRXL@relinquished.localdomain>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Mon, 7 Feb 2022 03:01:57 +0200
Message-ID: <CAOE4rSyZ4Av_G4RoeG_UVaYk1NEapYJYvheAX0Bxgk0NL9HYGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: prevent copying too big compressed lzo segment
To:     Omar Sandoval <osandov@osandov.com>
Cc:     BTRFS <linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

piektd., 2022. g. 4. febr., plkst. 02:48 =E2=80=94 lietot=C4=81js Omar Sand=
oval
(<osandov@osandov.com>) rakst=C4=ABja:
>
> On Wed, Feb 02, 2022 at 11:44:55PM +0200, D=C4=81vis Mos=C4=81ns wrote:
> > Compressed length can be corrupted to be a lot larger than memory
> > we have allocated for buffer.
> > This will cause memcpy in copy_compressed_segment to write outside
> > of allocated memory.
> >
> > This mostly results in stuck read syscall but sometimes when using
> > btrfs send can get #GP
> >
> > kernel: general protection fault, probably for non-canonical address 0x=
841551d5c1000: 0000 [#1] PREEMPT SMP NOPTI
> > kernel: CPU: 17 PID: 264 Comm: kworker/u256:7 Tainted: P           OE  =
   5.17.0-rc2-1 #12
> > kernel: Workqueue: btrfs-endio btrfs_work_helper [btrfs]
> > kernel: RIP: 0010:lzo_decompress_bio (./include/linux/fortify-string.h:=
225 fs/btrfs/lzo.c:322 fs/btrfs/lzo.c:394) btrfs
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:*  48 8b 06                mov    (%rsi),%rax              <-- tra=
pping instruction
> >    3:   48 8d 79 08             lea    0x8(%rcx),%rdi
> >    7:   48 83 e7 f8             and    $0xfffffffffffffff8,%rdi
> >    b:   48 89 01                mov    %rax,(%rcx)
> >    e:   44 89 f0                mov    %r14d,%eax
> >   11:   48 8b 54 06 f8          mov    -0x8(%rsi,%rax,1),%rdx
> > kernel: RSP: 0018:ffffb110812efd50 EFLAGS: 00010212
> > kernel: RAX: 0000000000001000 RBX: 000000009ca264c8 RCX: ffff98996e6d8f=
f8
> > kernel: RDX: 0000000000000064 RSI: 000841551d5c1000 RDI: ffffffff950043=
5d
> > kernel: RBP: ffff989a3be856c0 R08: 0000000000000000 R09: 00000000000000=
00
> > kernel: R10: 0000000000000000 R11: 0000000000001000 R12: ffff98996e6d80=
00
> > kernel: R13: 0000000000000008 R14: 0000000000001000 R15: 000841551d5c10=
00
> > kernel: FS:  0000000000000000(0000) GS:ffff98a09d640000(0000) knlGS:000=
0000000000000
> > kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > kernel: CR2: 00001e9f984d9ea8 CR3: 000000014971a000 CR4: 00000000003506=
e0
> > kernel: Call Trace:
> > kernel:  <TASK>
> > kernel: end_compressed_bio_read (fs/btrfs/compression.c:104 fs/btrfs/co=
mpression.c:1363 fs/btrfs/compression.c:323) btrfs
> > kernel: end_workqueue_fn (fs/btrfs/disk-io.c:1923) btrfs
> > kernel: btrfs_work_helper (fs/btrfs/async-thread.c:326) btrfs
> > kernel: process_one_work (./arch/x86/include/asm/jump_label.h:27 ./incl=
ude/linux/jump_label.h:212 ./include/trace/events/workqueue.h:108 kernel/wo=
rkqueue.c:2312)
> > kernel: worker_thread (./include/linux/list.h:292 kernel/workqueue.c:24=
55)
> > kernel: ? process_one_work (kernel/workqueue.c:2397)
> > kernel: kthread (kernel/kthread.c:377)
> > kernel: ? kthread_complete_and_exit (kernel/kthread.c:332)
> > kernel: ret_from_fork (arch/x86/entry/entry_64.S:301)
> > kernel:  </TASK>
> >
> > Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> > ---
> >  fs/btrfs/lzo.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> > index 31319dfcc9fb..ebaa5083f2ae 100644
> > --- a/fs/btrfs/lzo.c
> > +++ b/fs/btrfs/lzo.c
> > @@ -383,6 +383,13 @@ int lzo_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
> >               kunmap(cur_page);
> >               cur_in +=3D LZO_LEN;
> >
> > +             if (seg_len > WORKSPACE_CBUF_LENGTH) {
> > +                     // seg_len shouldn't be larger than we have alloc=
ated for workspace->cbuf
> > +                     btrfs_err(fs_info, "unexpectedly large lzo segmen=
t len %u", seg_len);
> > +                     ret =3D -EUCLEAN;
> > +                     goto out;
> > +             }
> > +
>
> Oof, the fact that we weren't checking this is pretty bad... Shouldn't
> we also be checking that seg_len is within the size of the remaining
> input?
>

I don't think that's useful. The only case where it matters is if
final segment size is wrong and is larger than total size. In that
case decompressing most likely will still succeed as it won't need all
data to complete and it's safe to copy more than is used.
It's more likely that middle segments are corrupted for which this
check would make no difference.
But there still is another potential issue, if total size is correct,
but if a lot segment sizes are corrupted to be smaller than supposed
and if they still successfully decompress then we will read outside of
cb->compressed_pages because we check only cur_in < len_in but not
nr_pages
