Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8752E289F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Dec 2020 19:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgLXSrQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Dec 2020 13:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgLXSrP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Dec 2020 13:47:15 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADBFC061575
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Dec 2020 10:46:30 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id 75so2588579ilv.13
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Dec 2020 10:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsNUBloWAUhQfAKDNr2zmKo9lnafAmXiCyM9Nf0pRww=;
        b=a8A93bvb/S42nAxAXLnD61jX94h4I86jOUNYbqKygMlKpbLqZf+ZINKUEF2SOEhl//
         0eljsyfPk4tJikmwT9PEODyw3boxEMBYA+p5a7oVUJVAHEDl0bcPRw9EEoiauZ+n4KiG
         TPv2vqwmGRCHbKTfaM4NVYK0ASePVgnZgUyw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsNUBloWAUhQfAKDNr2zmKo9lnafAmXiCyM9Nf0pRww=;
        b=oXDacK5VePmOB5uE2vkd3g85oiWRhIgmRj+iQ5b6UUEU1lGRQjdrAtHkbm2fHv5+aK
         4x2Xb3GWU8lENPjKlbLSIkrVAjEOWEn8i1UaDroZclAwy8evZjdx7Kl6gMbxsJSPB6a7
         tdlNIHrVzOopk0hC6Qv2xcru+h/0V6pQ4tJx7Rfdfsvhq6Kf5ZJZDfZ+ne+InE5Jza8g
         PmyTj328v2kq3K1C31s56WBeqzYBE1THmQccifg7EJc+aEe84WZiaxfeNW2TR6yaPyQ3
         cQ1I/2GT2+PtCT8bGfWlyvPuqFD0DpNygnc0Ay2SLPTEO9vblLI9sFay4UrYLttjnFsF
         KA2Q==
X-Gm-Message-State: AOAM533KpqSnlN3Fx+Ys25d2Zw/4LCRl+KlIU7fD/Gycl507FgdMutOB
        Z5GeLxwAX60IHdYjtr+4+dXRR8fX8SYo35SuVCscfQ==
X-Google-Smtp-Source: ABdhPJzsmImv7k+5UrjMHFKA93tf3e/AzHOKBFsr40lui6mxYWeQ8BhATn0N88TYfOYKFQPj9VJF1PoQnqjwa/kciQI=
X-Received: by 2002:a05:6e02:5c2:: with SMTP id l2mr30093792ils.231.1608835589405;
 Thu, 24 Dec 2020 10:46:29 -0800 (PST)
MIME-Version: 1.0
References: <16ffadab-42ba-f9c7-8203-87fda3dc9b44@maciej.szmigiero.name>
 <74c7129b-a437-ebc4-1466-7fb9f034e006@maciej.szmigiero.name> <20201223205642.GA19817@gondor.apana.org.au>
In-Reply-To: <20201223205642.GA19817@gondor.apana.org.au>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Thu, 24 Dec 2020 18:46:18 +0000
Message-ID: <CALrw=nFRLxpG+Qzy=wki1m6HnQUqPK9CQFGEEnB1tjSF0ex4UQ@mail.gmail.com>
Subject: Re: dm-crypt with no_read_workqueue and no_write_workqueue + btrfs
 scrub = BUG()
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        dm-crypt@saout.de, linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Nobuto Murata <nobuto.murata@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-crypto <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 23, 2020 at 8:57 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, Dec 23, 2020 at 04:37:34PM +0100, Maciej S. Szmigiero wrote:
> >
> > It looks like to me that the skcipher API might not be safe to
> > call from a softirq context, after all.
>
> skcipher is safe to use in a softirq.  The problem is only in
> dm-crypt where it tries to allocate memory with GFP_NOIO.

Hm.. After eliminating the GFP_NOIO (as well as some other sleeping
paths) from dm-crypt softirq code I still hit an occasional crash in
my extreme setup (QEMU with 1 CPU and cryptd_max_cpu_qlen set to 1)
(decoded with stacktrace_decode.sh):

[   89.324723] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   89.325713] #PF: supervisor write access in kernel mode
[   89.326460] #PF: error_code(0x0002) - not-present page
[   89.327211] PGD 0 P4D 0
[   89.327589] Oops: 0002 [#1] PREEMPT SMP PTI
[   89.328200] CPU: 0 PID: 21 Comm: kworker/0:1 Not tainted 5.10.0+ #79
[   89.329109] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 0.0.0 02/06/2015
[   89.330284] Workqueue: cryptd cryptd_queue_worker
[   89.330999] RIP: 0010:crypto_dequeue_request
(/cfsetup_build/./include/linux/list.h:112
/cfsetup_build/./include/linux/list.h:135
/cfsetup_build/./include/linux/list.h:146
/cfsetup_build/crypto/algapi.c:957)
[ 89.331757] Code: e9 c9 d0 a8 48 c7 c7 f9 c9 d0 a8 e8 c2 88 fe ff 4c
8b 23 48 c7 c6 e9 c9 d0 a8 48 c7 c7 f9 c9 d0 a8 49 8b 14 24 49 8b 44
24 08 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 49 89 04 24
48
All code
========
   0: e9 c9 d0 a8 48        jmpq   0x48a8d0ce
   5: c7 c7 f9 c9 d0 a8    mov    $0xa8d0c9f9,%edi
   b: e8 c2 88 fe ff        callq  0xfffffffffffe88d2
  10: 4c 8b 23              mov    (%rbx),%r12
  13: 48 c7 c6 e9 c9 d0 a8 mov    $0xffffffffa8d0c9e9,%rsi
  1a: 48 c7 c7 f9 c9 d0 a8 mov    $0xffffffffa8d0c9f9,%rdi
  21: 49 8b 14 24          mov    (%r12),%rdx
  25: 49 8b 44 24 08        mov    0x8(%r12),%rax
  2a:* 48 89 42 08          mov    %rax,0x8(%rdx) <-- trapping instruction
  2e: 48 89 10              mov    %rdx,(%rax)
  31: 48 b8 00 01 00 00 00 movabs $0xdead000000000100,%rax
  38: 00 ad de
  3b: 49 89 04 24          mov    %rax,(%r12)
  3f: 48                    rex.W

Code starting with the faulting instruction
===========================================
   0: 48 89 42 08          mov    %rax,0x8(%rdx)
   4: 48 89 10              mov    %rdx,(%rax)
   7: 48 b8 00 01 00 00 00 movabs $0xdead000000000100,%rax
   e: 00 ad de
  11: 49 89 04 24          mov    %rax,(%r12)
  15: 48                    rex.W
[   89.334414] RSP: 0018:ffffba64c00bbe68 EFLAGS: 00010246
[   89.335165] RAX: 0000000000000000 RBX: ffff9b9d6fc28d88 RCX: 0000000000000000
[   89.336182] RDX: 0000000000000000 RSI: ffffffffa8d0c9e9 RDI: ffffffffa8d0c9f9
[   89.337204] RBP: 0000000000000000 R08: ffffffffa906e708 R09: 0000000000000058
[   89.338208] R10: ffffffffa9068720 R11: 00000000fffffc00 R12: ffff9b9a43797478
[   89.339216] R13: 0000000000000020 R14: ffff9b9d6fc28e00 R15: 0000000000000000
[   89.340231] FS:  0000000000000000(0000) GS:ffff9b9d6fc00000(0000)
knlGS:0000000000000000
[   89.341376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.342207] CR2: 0000000000000008 CR3: 000000014cd76002 CR4: 0000000000170ef0
[   89.343238] Call Trace:
[   89.343609] cryptd_queue_worker (/cfsetup_build/crypto/cryptd.c:172)
[   89.344218] process_one_work
(/cfsetup_build/./arch/x86/include/asm/preempt.h:26
/cfsetup_build/kernel/workqueue.c:2284)
[   89.344821] ? rescuer_thread (/cfsetup_build/kernel/workqueue.c:2364)
[   89.345399] worker_thread
(/cfsetup_build/./include/linux/list.h:282
/cfsetup_build/kernel/workqueue.c:2422)
[   89.345923] ? rescuer_thread (/cfsetup_build/kernel/workqueue.c:2364)
[   89.346504] kthread (/cfsetup_build/kernel/kthread.c:292)
[   89.346986] ? kthread_create_worker_on_cpu
(/cfsetup_build/kernel/kthread.c:245)
[   89.347713] ret_from_fork (/cfsetup_build/arch/x86/entry/entry_64.S:302)
[   89.348255] Modules linked in:
[   89.348708] CR2: 0000000000000008
[   89.349197] ---[ end trace b7e9618b4122ed3b ]---
[   89.349863] RIP: 0010:crypto_dequeue_request
(/cfsetup_build/./include/linux/list.h:112
/cfsetup_build/./include/linux/list.h:135
/cfsetup_build/./include/linux/list.h:146
/cfsetup_build/crypto/algapi.c:957)
[ 89.350606] Code: e9 c9 d0 a8 48 c7 c7 f9 c9 d0 a8 e8 c2 88 fe ff 4c
8b 23 48 c7 c6 e9 c9 d0 a8 48 c7 c7 f9 c9 d0 a8 49 8b 14 24 49 8b 44
24 08 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 49 89 04 24
48
All code
========
   0: e9 c9 d0 a8 48        jmpq   0x48a8d0ce
   5: c7 c7 f9 c9 d0 a8    mov    $0xa8d0c9f9,%edi
   b: e8 c2 88 fe ff        callq  0xfffffffffffe88d2
  10: 4c 8b 23              mov    (%rbx),%r12
  13: 48 c7 c6 e9 c9 d0 a8 mov    $0xffffffffa8d0c9e9,%rsi
  1a: 48 c7 c7 f9 c9 d0 a8 mov    $0xffffffffa8d0c9f9,%rdi
  21: 49 8b 14 24          mov    (%r12),%rdx
  25: 49 8b 44 24 08        mov    0x8(%r12),%rax
  2a:* 48 89 42 08          mov    %rax,0x8(%rdx) <-- trapping instruction
  2e: 48 89 10              mov    %rdx,(%rax)
  31: 48 b8 00 01 00 00 00 movabs $0xdead000000000100,%rax
  38: 00 ad de
  3b: 49 89 04 24          mov    %rax,(%r12)
  3f: 48                    rex.W

Code starting with the faulting instruction
===========================================
   0: 48 89 42 08          mov    %rax,0x8(%rdx)
   4: 48 89 10              mov    %rdx,(%rax)
   7: 48 b8 00 01 00 00 00 movabs $0xdead000000000100,%rax
   e: 00 ad de
  11: 49 89 04 24          mov    %rax,(%r12)
  15: 48                    rex.W
[   89.353266] RSP: 0018:ffffba64c00bbe68 EFLAGS: 00010246
[   89.354003] RAX: 0000000000000000 RBX: ffff9b9d6fc28d88 RCX: 0000000000000000
[   89.355048] RDX: 0000000000000000 RSI: ffffffffa8d0c9e9 RDI: ffffffffa8d0c9f9
[   89.356063] RBP: 0000000000000000 R08: ffffffffa906e708 R09: 0000000000000058
[   89.357082] R10: ffffffffa9068720 R11: 00000000fffffc00 R12: ffff9b9a43797478
[   89.358088] R13: 0000000000000020 R14: ffff9b9d6fc28e00 R15: 0000000000000000
[   89.359127] FS:  0000000000000000(0000) GS:ffff9b9d6fc00000(0000)
knlGS:0000000000000000
[   89.360296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.361129] CR2: 0000000000000008 CR3: 000000014cd76002 CR4: 0000000000170ef0
[   89.362160] Kernel panic - not syncing: Fatal exception in interrupt
[   89.363145] Kernel Offset: 0x26000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   89.364730] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

This happens when running dm-crypt with no_read_workqueues on top of
an emulated NVME in QEMU (NVME driver "completes" IO in IRQ context).
Somehow sending decryption requests to cryptd in some fashion in
softirq context corrupts the crypto queue it seems.

Regards,
Ignat


> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
