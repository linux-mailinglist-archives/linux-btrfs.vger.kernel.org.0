Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221FA4A8546
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 14:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiBCNdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 08:33:09 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:51666 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiBCNdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 08:33:09 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id CAA086C0071B;
        Thu,  3 Feb 2022 15:33:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1643895187; bh=5CWjScT1XW8d+nIOT0i4Q+4qvhjMs70lGC/mjHRVjIY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date:to:cc;
        b=QbDZ+AbNbJpIH19pupUPjNn8t9Kn8yIi/BIE0k5tVF8HGZog91F2LStaomVMKuWm7
         0pcT6zXr6qFciYcsKcx7eGR8qP3LP5E+APCdpy+FCYFYJDAPgAxL51SCArYl1ks/Lf
         1qrtTb1Hnw5wyUtiHcAxeFQ72z+LGoui/XnKVLc0=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id BB8676C00715;
        Thu,  3 Feb 2022 15:33:07 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id hPg7AAATWSB6; Thu,  3 Feb 2022 15:33:07 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 5F7006C006BE;
        Thu,  3 Feb 2022 15:33:07 +0200 (EET)
References: <20220202214455.15753-1-davispuh@gmail.com>
 <20220202214455.15753-2-davispuh@gmail.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: prevent copying too big compressed lzo segment
Date:   Thu, 03 Feb 2022 21:26:20 +0800
In-reply-to: <20220202214455.15753-2-davispuh@gmail.com>
Message-ID: <iltw2hyu.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetewt38GpVJY3o+ue5zhxdnmX7NS+afEgJTHLEkGpqPg+1xF8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 02 Feb 2022 at 23:44, D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>=20
wrote:

> Compressed length can be corrupted to be a lot larger than=20
> memory
> we have allocated for buffer.
> This will cause memcpy in copy_compressed_segment to write=20
> outside
> of allocated memory.
>
> This mostly results in stuck read syscall but sometimes when=20
> using
> btrfs send can get #GP
>
> kernel: general protection fault, probably for non-canonical=20
> address 0x841551d5c1000: 0000 [#1] PREEMPT SMP NOPTI
> kernel: CPU: 17 PID: 264 Comm: kworker/u256:7 Tainted: P=20
> OE     5.17.0-rc2-1 #12
> kernel: Workqueue: btrfs-endio btrfs_work_helper [btrfs]
> kernel: RIP: 0010:lzo_decompress_bio=20
> (./include/linux/fortify-string.h:225 fs/btrfs/lzo.c:322=20
> fs/btrfs/lzo.c:394) btrfs
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:*  48 8b 06                mov    (%rsi),%rax=20
>    <-- trapping instruction
>    3:   48 8d 79 08             lea    0x8(%rcx),%rdi
>    7:   48 83 e7 f8             and    $0xfffffffffffffff8,%rdi
>    b:   48 89 01                mov    %rax,(%rcx)
>    e:   44 89 f0                mov    %r14d,%eax
>   11:   48 8b 54 06 f8          mov    -0x8(%rsi,%rax,1),%rdx
> kernel: RSP: 0018:ffffb110812efd50 EFLAGS: 00010212
> kernel: RAX: 0000000000001000 RBX: 000000009ca264c8 RCX:=20
> ffff98996e6d8ff8
> kernel: RDX: 0000000000000064 RSI: 000841551d5c1000 RDI:=20
> ffffffff9500435d
> kernel: RBP: ffff989a3be856c0 R08: 0000000000000000 R09:=20
> 0000000000000000
> kernel: R10: 0000000000000000 R11: 0000000000001000 R12:=20
> ffff98996e6d8000
> kernel: R13: 0000000000000008 R14: 0000000000001000 R15:=20
> 000841551d5c1000
> kernel: FS:  0000000000000000(0000) GS:ffff98a09d640000(0000)=20
> knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00001e9f984d9ea8 CR3: 000000014971a000 CR4:=20
> 00000000003506e0
> kernel: Call Trace:
> kernel:  <TASK>
> kernel: end_compressed_bio_read (fs/btrfs/compression.c:104=20
> fs/btrfs/compression.c:1363 fs/btrfs/compression.c:323) btrfs
> kernel: end_workqueue_fn (fs/btrfs/disk-io.c:1923) btrfs
> kernel: btrfs_work_helper (fs/btrfs/async-thread.c:326) btrfs
> kernel: process_one_work (./arch/x86/include/asm/jump_label.h:27=20
> ./include/linux/jump_label.h:212=20
> ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2312)
> kernel: worker_thread (./include/linux/list.h:292=20
> kernel/workqueue.c:2455)
> kernel: ? process_one_work (kernel/workqueue.c:2397)
> kernel: kthread (kernel/kthread.c:377)
> kernel: ? kthread_complete_and_exit (kernel/kthread.c:332)
> kernel: ret_from_fork (arch/x86/entry/entry_64.S:301)
> kernel:  </TASK>
>
> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> ---
>  fs/btrfs/lzo.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index 31319dfcc9fb..ebaa5083f2ae 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -383,6 +383,13 @@ int lzo_decompress_bio(struct list_head=20
> *ws, struct compressed_bio *cb)
>  		kunmap(cur_page);
>  		cur_in +=3D LZO_LEN;
>
> +		if (seg_len > WORKSPACE_CBUF_LENGTH) {
> +			// seg_len shouldn't be larger than we=20
> have allocated for workspace->cbuf
>
Makes sense.
Is the corrupted lzo compressed extent produced by a normal fs or
crafted manually? If it is from a normal fs, something insane=20
happened
in extent compressed path.

--
Su

> +			btrfs_err(fs_info, "unexpectedly large lzo=20
> segment len %u", seg_len);
> +			ret =3D -EUCLEAN;
> +			goto out;
> +		}
> +
>  		/* Copy the compressed segment payload into=20
>  workspace */
>  		copy_compressed_segment(cb, workspace->cbuf,=20
>  seg_len, &cur_in);
