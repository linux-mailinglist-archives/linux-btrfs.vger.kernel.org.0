Return-Path: <linux-btrfs+bounces-12492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F27EA6BFC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9877E189241E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E92226D1B;
	Fri, 21 Mar 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed9n3XtZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE54207A;
	Fri, 21 Mar 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573922; cv=none; b=Ktk7dSJZn7+kfz1mA/+AZiPuvjwflZVMU//dd0z7CHB1eSzI/rZru8pIejXzY4Rd4ee1/dY0vYZQ0jIDHlQOmg+xgWPKhlb6tQIr4mwZn9389n3oEIacWtbwIurcTZKHp8tN0A5ZDNnRjPDC2sMUaTjMm8LDEGVJtLLcmET40Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573922; c=relaxed/simple;
	bh=2DG5Ut4XCmcz1sW92eSTl6+27VN/JzPJpmes4DvEGik=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=gOe3XmakcjMHspy0x5Cw87P0cR4jXoKKwSedKY8tM0Ai0NLmriGskOtSGPJHqUoo6t2xGTCCw1ChfatWmhKFAfTk92ndyhzJyUDh/2WsxGMGmB5e/hcFBWMxujkldxTjUtK8DIA5WIqw9i1eMerI9e9FbYYP0GXHaA+w4iKovC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed9n3XtZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso54629205ad.1;
        Fri, 21 Mar 2025 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742573920; x=1743178720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aa/oeSqu9j7ZG2jk5B9U7UubDFHfuN9VI7rabr0YyHM=;
        b=Ed9n3XtZtHYACk5MFJdIwwuwfATK5gUX2J69NC3mXTrr6sLwKAj0eJpE8oeJMlTfvB
         4YmFRULD+DWcVE//v1Jf02YQLxhcRb1YoJSSqco4SbqIdH3ZQQ6dCKjFwOZi3jskTFFp
         BUG7cR+4PBxS4oXuvQN9n3ixVXId0tKS2WF+YQGvcOePTj2yfwJvdhC1Mt7/UqxV9OxB
         kB3TcIXPYXOIxb+GlZHE4paqoA91TeJCLPIWtTD7eRrp5BccA+YMHyJyuhAi2TVrSWMd
         ClXZohPc9ltq8L06Nbzrto8YyqlJOQOSMNa4Y0l56pcaGLMmAjl3eYJyuiFb+hoFq5Bo
         ngiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573920; x=1743178720;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aa/oeSqu9j7ZG2jk5B9U7UubDFHfuN9VI7rabr0YyHM=;
        b=IAXh518chOSCW4taU8JkDoLDNTJXiCUsYZ/e3ycg9OPuqHCTB+RcxyOPhH98hclY7a
         EAIlYhwP4vtgwF7SWweJPAseHxNXC2Kl5lo92PQzFsQSAy6Wex6UC+kNgK79dgWGtFgm
         a+SoaXS+tcywk16yDNYlUEju2JSMsjJOysyTADdxCkfOSy4p6W7jj0BShWrm7u/Lk+9u
         mUSIYOgqxBORQTX8GqkRBV0l4xC129aRdST9wU98QaWt68YgEIGWoyAjBaWDeZQYyrkE
         91q30xf+0bEDCQ4bGwBV8Ob51/vyQmoZF+sNa+3Pfw9FYUiTCWLySf0vqoLVJuYs4sMi
         VNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjY+5EDMlZCfcSYriXDgXzAEGx0Wtqn/+Iu4Te9kYnBn4UjbEHVQppckShj7V8jt5AKbpLZwOtLAiKxvyV@vger.kernel.org, AJvYcCVyRt4ebjq7djZB4cYUE2457PKeS2ShceaehCTluqp+Z/kaIcEz60ZL2WKRAuDVZBrCINKe/sbF+Bl6pw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5gZBRxBh5TUUW3SBytAc7iQP3+GRj7LrsCvxiSECdIFNeGFS0
	vw5TWo2CKcOh4OaCe/3pdydXJGHAYTq9n7sjESlVK77/kCXjERAv
X-Gm-Gg: ASbGnctFWuZKzRgxdwk6fQBSA767FXf9DbuJNMOK1uNwv9kpMFCAyKc81LYUlG7NwpK
	Kds7zoCLp66+RwBHfib2nmYH6ma/29tVQORiiG5DB438IeazjXM3Cz3mxPAi+5Noz7tXGufctms
	mkxtS0bAqH/SPZliW++UHz/YFnDTp+esAaGdvJt0C8fDo4fxzNPHlNwjDfTRQEF2ZgwK3veF+qG
	AKWeGYaogJOyON1B7fMTJs3kecEcWZCdyUQcrD1+giaaj7jIgrT/1Kee7gD+lzChdg8Aw71xVMc
	JqT4USbOSVTHbpj41DhnQlkiGKa1QNK+K7OhZw==
X-Google-Smtp-Source: AGHT+IHXK9ihuIUg5cGB2ifPWnnFjgVEW5WEuE0I3f27Sirj3sdGKbFJ6aKgD/fM7L49KZ3goFwL7w==
X-Received: by 2002:a05:6a00:3c95:b0:736:eb7e:df39 with SMTP id d2e1a72fcca58-73905a54b96mr7338183b3a.24.1742573919427;
        Fri, 21 Mar 2025 09:18:39 -0700 (PDT)
Received: from dw-tp ([171.76.82.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54d5sm2132885b3a.39.2025.03.21.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:18:38 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, linux-btrfs@vger.kernel.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [linux-next-20250320][btrfs] Kernel OOPs while running btrfs/108
In-Reply-To: <e4b1ccf8-c626-4683-82db-219354a27e61@linux.ibm.com>
Date: Fri, 21 Mar 2025 21:26:43 +0530
Message-ID: <87h63ms7gk.fsf@gmail.com>
References: <e4b1ccf8-c626-4683-82db-219354a27e61@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


+linux-btrfs

Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:

> Greetings!!!
>
>
> I am observing Kernel oops while running brtfs/108 TC on IBM Power System.
>
> Repo: Linux-Next (next-20250320)

Looks like this next tag had many btrfs related changes -
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/fs/btrfs?h=next-20250320

>
> Traces:
>
> [  418.392604] run fstests btrfs/108 at 2025-03-21 05:11:21
> [  418.560137] Kernel attempted to read user page (0) - exploit attempt? 
> (uid: 0)
> [  418.560156] BUG: Kernel NULL pointer dereference on read at 0x00000000

NULL pointer dereference... 

> [  418.560161] Faulting instruction address: 0xc0000000010ef8b0
> [  418.560166] Oops: Kernel access of bad area, sig: 11 [#1]
> [  418.560169] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [  418.560174] Modules linked in: btrfs blake2b_generic xor raid6_pq 
> zstd_compress loop nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib 
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 bonding nf_defrag_ipv4 
> tls rfkill ip_set nf_tables nfnetlink sunrpc pseries_rng vmx_crypto fuse 
> ext4 mbcache jbd2 sd_mod sg ibmvscsi scsi_transport_srp ibmveth
> [  418.560212] CPU: 1 UID: 0 PID: 37583 Comm: rm Kdump: loaded Not 
> tainted 6.14.0-rc7-next-20250320 #1 VOLUNTARY
> [  418.560218] Hardware name: IBM,9080-HEX Power11
> [  418.560223] NIP:  c0000000010ef8b0 LR: c00800000bb190ac CTR: 
> c0000000010ef888
> [  418.560227] REGS: c0000000a252f5a0 TRAP: 0300   Not tainted 
> (6.14.0-rc7-next-20250320)
> [  418.560232] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 44008444  XER: 20040000
> [  418.560240] CFAR: c00800000bc1df84 DAR: 0000000000000000 DSISR: 
> 40000000 IRQMASK: 1
> [  418.560240] GPR00: c00800000bb190ac c0000000a252f840 c0000000016a8100 
> 0000000000000000
> [  418.560240] GPR04: 0000000000000000 0000000000010000 0000000000000000 
> fffffffffffe0000
> [  418.560240] GPR08: c00000010724aad8 0000000000000003 0000000000001000 
> c00800000bc1df70
> [  418.560240] GPR12: c0000000010ef888 c000000affffdb00 0000000000000000 
> 0000000000000000
> [  418.560240] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [  418.560240] GPR20: c0000000777a8000 c00000006a9c9000 c00000010724a950 
> c0000000777a8000
> [  418.560240] GPR24: fffffffffffffffe c00000010724aad8 0000000000010000 
> 00000000000000a0
> [  418.560240] GPR28: 0000000000010000 c00c00000048c3c0 0000000000000000 
> 0000000000000000
> [  418.560287] NIP [c0000000010ef8b0] _raw_spin_lock_irq+0x28/0x98
> [  418.560294] LR [c00800000bb190ac] wait_subpage_spinlock+0x64/0xd0 [btrfs]


btrfs is working on subpage size support for a while now.
Adding +linux-btrfs, in case if they are already aware of this problem.

I am not that familiar with btrfs code. But does this look like that the
subpage (folio->private became NULL here) somehow?

-ritesh

> [  418.560339] Call Trace:
> [  418.560342] [c0000000a252f870] [c00800000bb205dc] 
> btrfs_invalidate_folio+0xa8/0x4f0 [btrfs]
> [  418.560384] [c0000000a252f930] [c0000000004cbcdc] 
> truncate_cleanup_folio+0x110/0x14c
> [  418.560391] [c0000000a252f960] [c0000000004ccc7c] 
> truncate_inode_pages_range+0x100/0x4dc
> [  418.560397] [c0000000a252fbd0] [c00800000bb20ba8] 
> btrfs_evict_inode+0x74/0x510 [btrfs]
> [  418.560437] [c0000000a252fc90] [c00000000065c71c] evict+0x164/0x334
> [  418.560443] [c0000000a252fd30] [c000000000647c9c] do_unlinkat+0x2f4/0x3a4
> [  418.560449] [c0000000a252fde0] [c000000000647da0] sys_unlinkat+0x54/0xac
> [  418.560454] [c0000000a252fe10] [c000000000033498] 
> system_call_exception+0x138/0x330
> [  418.560461] [c0000000a252fe50] [c00000000000d05c] 
> system_call_vectored_common+0x15c/0x2ec
> [  418.560468] --- interrupt: 3000 at 0x7fffb1b366bc
> [  418.560471] NIP:  00007fffb1b366bc LR: 00007fffb1b366bc CTR: 
> 0000000000000000
> [  418.560475] REGS: c0000000a252fe80 TRAP: 3000   Not tainted 
> (6.14.0-rc7-next-20250320)
> [  418.560479] MSR:  800000000280f033 
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44008804  XER: 00000000
> [  418.560490] IRQMASK: 0
> [  418.560490] GPR00: 0000000000000124 00007ffffcb4e2b0 00007fffb1c37d00 
> ffffffffffffff9c
> [  418.560490] GPR04: 000000013d660380 0000000000000000 0000000000000000 
> 0000000000000003
> [  418.560490] GPR08: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [  418.560490] GPR12: 0000000000000000 00007fffb1dba5c0 00007ffffcb4e538 
> 000000011972d0e8
> [  418.560490] GPR16: 000000011972d098 000000011972d060 000000011972d020 
> 000000011972cff0
> [  418.560490] GPR20: 000000011972d298 000000011972cc10 0000000000000000 
> 000000013d6615a0
> [  418.560490] GPR24: 0000000000000002 000000011972d0b8 000000011972cf98 
> 000000011972d1d0
> [  418.560490] GPR28: 00007ffffcb4e538 000000013d6602f0 0000000000000000 
> 0000000000100000
> [  418.560532] NIP [00007fffb1b366bc] 0x7fffb1b366bc
> [  418.560536] LR [00007fffb1b366bc] 0x7fffb1b366bc
> [  418.560538] --- interrupt: 3000
> [  418.560541] Code: 7c0803a6 4e800020 3c4c005c 38428878 7c0802a6 
> 60000000 39200001 992d0932 a12d0008 3ce0fffe 5529083c 61290001 
> <7d001829> 7d063879 40c20018 7d063838
> [  418.560555] ---[ end trace 0000000000000000 ]---
>
>
> If you happed to fix this, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.

