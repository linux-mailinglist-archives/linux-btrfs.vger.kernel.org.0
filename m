Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FDC4A8847
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352115AbiBCQEN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 11:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiBCQEM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 11:04:12 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96631C061714;
        Thu,  3 Feb 2022 08:04:12 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id w17so1991505vko.9;
        Thu, 03 Feb 2022 08:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YBZ2wparna3Zx34qvS7RUa2hwfBOoSUSLIksmifzJxw=;
        b=lGDmMLDDj0X+xf6sPnCXPrAiJV1cVWiavadEErcOSlsli+/EFqCGnY5rpEoHnP4+C1
         T5lnVlDYeevBYc553v0ixQNSNveLdv52TkRLn+WG5+3WR0TheVrJemHlTz3nNh8MKZsM
         Qkza9fcaI7ViDTP6U44iQQkPinwFzKzyWyxE80E6ANYv92ZT7ep3Bs8Q/B29Xjhvk+jS
         z9ZAuu3oLJ8DkRHDdp8VxF55Gv0KtjjUPZwD42TtZ1iSP/U0R211+oKsTbPUdSnWNi/J
         slWZOImAiTzm24jkgvR6wW9OeQMNAYa0XHWN7laNlaTo849EW1R0csL5+K4OP3LEiW/s
         aJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YBZ2wparna3Zx34qvS7RUa2hwfBOoSUSLIksmifzJxw=;
        b=sJ+OyIl6HgWVV6+Yf2oZ+75lALiEyX7KtSysqCwYo7QLbTCCs1iSSk/Y/tr6uB8JuD
         v5N60kLSHbbH+SjsIXzGe5GEfZGYja0oHTyzH+UQpDYgim8pPWI+Yvo46tZKAz5CPq8I
         iCDrJ6AUWEzJ4KfUAgdVBH4Bwjn8RNcjg7NP0xB5GAOQ8lUTyh0YUkrFEiiA9XqjH/T4
         hyAvLFlr1Rm3ZEwmK6RXUuCRyk+uYJ962G/hctUm9n1wnrBtukHbzpFH0ipK1DZWWnqP
         wYEJRGOuj0xxfveOVFD2Fv7pct2RLABQUm+4dv3p+4XiYSAK2/xb71C2HQK+yE7qAtR5
         qI1g==
X-Gm-Message-State: AOAM533CYMHtY5bFwKfkhPyWJIaFXc/Iliqfy+XoUsGaVyvb4ISM63d6
        vyo86sOnhUEWyaFkacmEj/jmBq3HIrYn3e20d2H3tczGcUxTLs8n
X-Google-Smtp-Source: ABdhPJxNApdLiqDTOyLTpw9gxwighCzodqhc55izY3tKhISrqNjjwO9KjSGQ3y4hw7IzBAueNkU/Uzhgvkl80cbOYTo=
X-Received: by 2002:a05:6122:91b:: with SMTP id j27mr15048192vka.32.1643904251677;
 Thu, 03 Feb 2022 08:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20220202214455.15753-1-davispuh@gmail.com> <20220202214455.15753-2-davispuh@gmail.com>
 <iltw2hyu.fsf@damenly.su>
In-Reply-To: <iltw2hyu.fsf@damenly.su>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Thu, 3 Feb 2022 18:04:00 +0200
Message-ID: <CAOE4rSxt6bcFNnWCw7nyPUZ5T5fAXDy0rmGUvavnQQW3kqXAwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: prevent copying too big compressed lzo segment
To:     Su Yue <l@damenly.su>
Cc:     BTRFS <linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ceturtd., 2022. g. 3. febr., plkst. 15:33 =E2=80=94 lietot=C4=81js Su Yue
(<l@damenly.su>) rakst=C4=ABja:
>
>
> On Wed 02 Feb 2022 at 23:44, D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> wrote:
>
> > Compressed length can be corrupted to be a lot larger than
> > memory
> > we have allocated for buffer.
> > This will cause memcpy in copy_compressed_segment to write
> > outside
> > of allocated memory.
> >
> > This mostly results in stuck read syscall but sometimes when
> > using
> > btrfs send can get #GP
> >
> > kernel: general protection fault, probably for non-canonical
> > address 0x841551d5c1000: 0000 [#1] PREEMPT SMP NOPTI
> > kernel: CPU: 17 PID: 264 Comm: kworker/u256:7 Tainted: P
> > OE     5.17.0-rc2-1 #12
> > kernel: Workqueue: btrfs-endio btrfs_work_helper [btrfs]
> > kernel: RIP: 0010:lzo_decompress_bio
> > (./include/linux/fortify-string.h:225 fs/btrfs/lzo.c:322
> > fs/btrfs/lzo.c:394) btrfs
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:*  48 8b 06                mov    (%rsi),%rax
> >    <-- trapping instruction
> >    3:   48 8d 79 08             lea    0x8(%rcx),%rdi
> >    7:   48 83 e7 f8             and    $0xfffffffffffffff8,%rdi
> >    b:   48 89 01                mov    %rax,(%rcx)
> >    e:   44 89 f0                mov    %r14d,%eax
> >   11:   48 8b 54 06 f8          mov    -0x8(%rsi,%rax,1),%rdx
> > kernel: RSP: 0018:ffffb110812efd50 EFLAGS: 00010212
> > kernel: RAX: 0000000000001000 RBX: 000000009ca264c8 RCX:
> > ffff98996e6d8ff8
> > kernel: RDX: 0000000000000064 RSI: 000841551d5c1000 RDI:
> > ffffffff9500435d
> > kernel: RBP: ffff989a3be856c0 R08: 0000000000000000 R09:
> > 0000000000000000
> > kernel: R10: 0000000000000000 R11: 0000000000001000 R12:
> > ffff98996e6d8000
> > kernel: R13: 0000000000000008 R14: 0000000000001000 R15:
> > 000841551d5c1000
> > kernel: FS:  0000000000000000(0000) GS:ffff98a09d640000(0000)
> > knlGS:0000000000000000
> > kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > kernel: CR2: 00001e9f984d9ea8 CR3: 000000014971a000 CR4:
> > 00000000003506e0
> > kernel: Call Trace:
> > kernel:  <TASK>
> > kernel: end_compressed_bio_read (fs/btrfs/compression.c:104
> > fs/btrfs/compression.c:1363 fs/btrfs/compression.c:323) btrfs
> > kernel: end_workqueue_fn (fs/btrfs/disk-io.c:1923) btrfs
> > kernel: btrfs_work_helper (fs/btrfs/async-thread.c:326) btrfs
> > kernel: process_one_work (./arch/x86/include/asm/jump_label.h:27
> > ./include/linux/jump_label.h:212
> > ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2312)
> > kernel: worker_thread (./include/linux/list.h:292
> > kernel/workqueue.c:2455)
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
> > @@ -383,6 +383,13 @@ int lzo_decompress_bio(struct list_head
> > *ws, struct compressed_bio *cb)
> >               kunmap(cur_page);
> >               cur_in +=3D LZO_LEN;
> >
> > +             if (seg_len > WORKSPACE_CBUF_LENGTH) {
> > +                     // seg_len shouldn't be larger than we
> > have allocated for workspace->cbuf
> >
> Makes sense.
> Is the corrupted lzo compressed extent produced by a normal fs or
> crafted manually? If it is from a normal fs, something insane
> happened
> in extent compressed path.
>

Happened normally, but in 2016 year. It's RAID1 where HBA dropped out
some disks and some sectors didn't got written, so most likely that
section contains previous unrelated data.
