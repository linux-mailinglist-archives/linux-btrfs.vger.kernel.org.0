Return-Path: <linux-btrfs+bounces-6443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF92930AB8
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 18:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51514B20EB7
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E413AA39;
	Sun, 14 Jul 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOwEhZZZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE761E52A
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720973637; cv=none; b=m5i8fF4yvm1kABDDKmzDDGqf00v9m9/RbW40Gma0IWEghC40uNLXsU/sUwlsdmeDY4H3VSqzzLjyRsmfn2XU88qWBev7cJkFpu0VAlJmgZSNdjh1GX+g2eSp+69JQYLl0GTKhOW/TCOxZ4+89Rt74R7DPdYqw9FpQmySJ4UaJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720973637; c=relaxed/simple;
	bh=CB96b1Q0wdE9EamX1g2WRiEjLBGXvhKoY1yRgcndmRI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M6+gCnJSHL0tu+DH9+a0FxM9d7oX5AOhSJm8+7+bSONg3OSGb6BFBTyYmFuyFQv2XoUrpyuiEo2b4leo+XIgQGAhok0weT20uMY2cePre+CUn7ipK6PyBwGTlJu/9YHcpkCL/exIeubtpPDIN9Tuj9PQZEdn+ixodVmWjjNGRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOwEhZZZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79f178351d4so225241885a.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720973634; x=1721578434; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sCPi5otBrpJgxVunbaiat2Z/ICL0QNMkDGcQVrsIlYU=;
        b=LOwEhZZZ/fNgYciBvcWYjFLhwFi/2jSz7DHxJyLoxDB/A5vw62R7kG8nydpqmZJNwg
         F/2NWojP/8Clzi6jxL/Ilvo1p/HBbXqJsG7rHpESPrW1oHMXwMsOkNuA9dq4iEYPtauf
         0OMKi4UalHyurw7V8NUfwcFYAuCxmOwrKNyCl7pHAvv458GMdrZz83PxgUFKdbsPCL+e
         emrv//OHewK64x28ZRemcwnCJTGPRdxIrAm7vzOT43JJ+L5NZDVXXnHG4Ou/Jx+iEZbi
         Yc1imVxzOZ4zuP8LNsmHyNweiCbywDBVaHbI5Zup6OwktQIe7anO00mlpfY6TP6vDg9G
         IJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720973634; x=1721578434;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCPi5otBrpJgxVunbaiat2Z/ICL0QNMkDGcQVrsIlYU=;
        b=aXxFFA7Pm72t4CwHUTLCoFmsBS/0HhmS2+177jiznlIe75gaXVCs3+J7vIbJ897qH/
         XB4xJ6jQG2WTbJgSYX2S5wuI1igt09oflKc1ID8VKeHrhmHIHQKtJRVhXG6uUvwKyfZj
         X/Ycl8J2roP0j3WOBin0gfx/nKqRlAbeZhBY/pcOgDUylDNpsO97ZSWdDp2JgC8octF5
         KBV9mQxT5gBWvZjHioPGKSazF4ftk7m8U0quAtu87nzpb39pdAdF9tpWb16toJ1nTMPN
         XDdNg14GU82IUXU42o6A14oTsSbnwm7XG9gIUdSC4tQsRH4khw5PgGk+Mm6SVVedUuqH
         mIbg==
X-Gm-Message-State: AOJu0YxxhPNlFMNuOizIRTov3XiCfwD8pHSFrOihOAZY3d/h6MP5d3SM
	fEP6ypKTMcidYshwh30POQc7EnHt0C9JxCmQS/Voy6JDgs6oNU2mhqdB0rfQ6VQoVPpAKkM7Cjh
	zqxl0kLIbXH548SHjGs3OK31GwqoG3tC4ROM=
X-Google-Smtp-Source: AGHT+IGh8sfJjHEzG6pYUgHCCilFHm6PsN39GWTHBmtPEg+nxdj2+C4/yuH5V3XKirMm8hRiyqi81pt1guW2xBboaMc=
X-Received: by 2002:a05:620a:24cb:b0:79d:53e9:7f06 with SMTP id
 af79cd13be357-79f19a4676fmr2182431585a.8.1720973634142; Sun, 14 Jul 2024
 09:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Krakow <hurikhan77@gmail.com>
Date: Sun, 14 Jul 2024 18:13:28 +0200
Message-ID: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
Subject: btrfs crashes during routine btrfs-balance-least-used
To: linux-btrfs <linux-btrfs@vger.kernel.org>, Oliver Wien <ow@netactive.de>
Content-Type: text/plain; charset="UTF-8"

Hello btrfs list!

(also reported in irc)

Our btrfs pool crashed during a routine btrfs-balance-least-used.
Maybe of interest: bees is also running on this filesystem, snapper
takes hourly snapshots with retention policy.

I'm currently still collecting diagnostics, "btrfs check" log is
already 3 GB and growing.

The btrfs runs on three devices vd{c,e,f}1 with data=single meta=raid1.

Here's an excerpt from dmesg (full log https://gist.tnonline.net/TE):

[1143841.581968] BTRFS info (device vdc1): balance: start
-dvrange=402046058496..402046058497
[1143841.583434] BTRFS info (device vdc1): relocating block group
402046058496 flags data
[1143852.414459] BTRFS info (device vdc1): found 45428 extents, stage:
move data extents
[1143913.107511] ------------[ cut here ]------------
[1143913.107516] WARNING: CPU: 10 PID: 937 at
fs/btrfs/extent-tree.c:3092 __btrfs_free_extent+0x68e/0x1130
[1143913.107583] CPU: 10 PID: 937 Comm: btrfs-transacti Not tainted
6.6.30-gentoo #1
[1143913.107585] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[1143913.107587] RIP: 0010:__btrfs_free_extent+0x68e/0x1130
[1143913.107590] Code: 58 61 00 00 49 8b 7d 50 49 89 d8 48 89 e9 45 8b
4e 40 48 c7 c6 20 48 06 af 8b 94 24 98 00 00 00 e8 37 f3 0a 00 e9 95
fc ff ff <0f> 0b f0 48 0f ba a8 f8 09 00 00 02 41 b8 00 00 00 00 0f 83
33 03
[1143913.107592] RSP: 0018:ffffbdd081063c78 EFLAGS: 00010246
[1143913.107595] RAX: ffffa0e64547a000 RBX: 0000005dc970d000 RCX:
0000000000004000
[1143913.107597] RDX: 0000000000000011 RSI: ffffa0e682bee2da RDI:
ffffbdd081063c17
[1143913.107598] RBP: 0000000000000001 R08: 0000005dc970e000 R09:
00000000001000a8
[1143913.107599] R10: a80000005dc970e0 R11: 0000000000001000 R12:
0000000004da9000
[1143913.107600] R13: ffffa0e82ed28270 R14: ffffa0e8059e4700 R15:
ffffa0e8742c40e0
[1143913.107601] FS:  0000000000000000(0000) GS:ffffa0f833c80000(0000)
knlGS:0000000000000000
[1143913.107605] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1143913.107607] CR2: 000000005665c138 CR3: 00000001060fb000 CR4:
00000000001506e0
[1143913.107608] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[1143913.107608] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[1143913.107609] Call Trace:
[1143913.107612]  <TASK>
[1143913.107613]  ? __warn+0x62/0xc0
[1143913.107638]  ? __btrfs_free_extent+0x68e/0x1130
[1143913.107640]  ? report_bug+0x15e/0x1a0
[1143913.107661]  ? handle_bug+0x36/0x70
[1143913.107674]  ? exc_invalid_op+0x13/0x60
[1143913.107676]  ? asm_exc_invalid_op+0x16/0x20
[1143913.107687]  ? __btrfs_free_extent+0x68e/0x1130
[1143913.107689]  __btrfs_run_delayed_refs+0x274/0xfc0
[1143913.107691]  btrfs_run_delayed_refs+0x50/0x1f0
[1143913.107692]  btrfs_commit_transaction+0x65/0xd40
[1143913.107696]  ? start_transaction+0xcb/0x570
[1143913.107698]  transaction_kthread+0x150/0x1b0
[1143913.107701]  ? close_ctree+0x420/0x420
[1143913.107703]  kthread+0xc4/0xf0
[1143913.107715]  ? kthread_complete_and_exit+0x20/0x20
[1143913.107718]  ret_from_fork+0x28/0x40
[1143913.107729]  ? kthread_complete_and_exit+0x20/0x20
[1143913.107732]  ret_from_fork_asm+0x11/0x20
[1143913.107734]  </TASK>
[1143913.107735] ---[ end trace 0000000000000000 ]---
[1143913.107737] ------------[ cut here ]------------
[1143913.107737] BTRFS: Transaction aborted (error -117)
[1143913.107749] WARNING: CPU: 10 PID: 937 at
fs/btrfs/extent-tree.c:3093 __btrfs_free_extent+0xed9/0x1130
[1143913.107752] CPU: 10 PID: 937 Comm: btrfs-transacti Tainted: G
   W          6.6.30-gentoo #1
[1143913.107754] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[1143913.107754] RIP: 0010:__btrfs_free_extent+0xed9/0x1130
[1143913.107756] Code: ff be 8b ff ff ff 48 c7 c7 80 3f 06 af e8 8f 5b
c2 ff 0f 0b e9 04 fb ff ff be 8b ff ff ff 48 c7 c7 80 3f 06 af e8 77
5b c2 ff <0f> 0b e9 20 fb ff ff 8b 5c 24 28 89 df e8 95 2f ff ff 84 c0
0f 85
[1143913.107757] RSP: 0018:ffffbdd081063c78 EFLAGS: 00010296
[1143913.107759] RAX: 0000000000000027 RBX: 0000005dc970d000 RCX:
0000000000000027
[1143913.107760] RDX: ffffa0f833c9b448 RSI: 0000000000000001 RDI:
ffffa0f833c9b440
[1143913.107761] RBP: 0000000000000001 R08: 0000000000000001 R09:
00000000ffffdfff
[1143913.107762] R10: 0000000000000000 R11: 0000000000000003 R12:
0000000004da9000
[1143913.107762] R13: ffffa0e82ed28270 R14: ffffa0e8059e4700 R15:
ffffa0e8742c40e0
[1143913.107763] FS:  0000000000000000(0000) GS:ffffa0f833c80000(0000)
knlGS:0000000000000000
[1143913.107766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1143913.107767] CR2: 000000005665c138 CR3: 00000001060fb000 CR4:
00000000001506e0
[1143913.107768] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[1143913.107769] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[1143913.107770] Call Trace:
[1143913.107771]  <TASK>
[1143913.107771]  ? __warn+0x62/0xc0
[1143913.107774]  ? __btrfs_free_extent+0xed9/0x1130
[1143913.107775]  ? report_bug+0x15e/0x1a0
[1143913.107778]  ? handle_bug+0x36/0x70
[1143913.107780]  ? exc_invalid_op+0x13/0x60
[1143913.107783]  ? asm_exc_invalid_op+0x16/0x20
[1143913.107785]  ? __btrfs_free_extent+0xed9/0x1130
[1143913.107786]  ? __btrfs_free_extent+0xed9/0x1130
[1143913.107788]  __btrfs_run_delayed_refs+0x274/0xfc0
[1143913.107789]  btrfs_run_delayed_refs+0x50/0x1f0
[1143913.107791]  btrfs_commit_transaction+0x65/0xd40
[1143913.107794]  ? start_transaction+0xcb/0x570
[1143913.107797]  transaction_kthread+0x150/0x1b0
[1143913.107804]  ? close_ctree+0x420/0x420
[1143913.107806]  kthread+0xc4/0xf0
[1143913.107809]  ? kthread_complete_and_exit+0x20/0x20
[1143913.107812]  ret_from_fork+0x28/0x40
[1143913.107814]  ? kthread_complete_and_exit+0x20/0x20
[1143913.107817]  ret_from_fork_asm+0x11/0x20
[1143913.107818]  </TASK>
[1143913.107819] ---[ end trace 0000000000000000 ]---
[1143913.107820] BTRFS: error (device vdc1: state A) in
__btrfs_free_extent:3093: errno=-117 Filesystem corrupted
[1143913.107823] BTRFS info (device vdc1: state EA): forced readonly
[1143913.107829] BTRFS info (device vdc1: state EA): leaf
1581679099904 gen 3933860 total ptrs 260 free space 5156 owner 2
[1143913.107831] item 0 key (402811465728 178 5935621899263475458)
itemoff 16255 itemsize 28
[1143913.107834] extent data backref root 340 objectid 338204534
offset 0 count 1
[1143913.107835] item 1 key (402811465728 178 5935621899272047437)
itemoff 16227 itemsize 28

"btrfs check" can only run in lowmem mode, it will crash with "out of
memory" (the system has 74G of RAM). Here's the beginning of the log:

[1/7] checking root items
[2/7] checking extents
ERROR: shared extent 15929577472 referencer lost (parent: 1147747794944)
ERROR: shared extent 15929577472 referencer lost (parent: 1148095201280)
ERROR: shared extent 15929577472 referencer lost (parent: 1175758274560)
(repeating thousands of similar lines)

Last gist: https://gist.tnonline.net/Z4 (meanwhile, this log is over
3GB, I can upload it somewhere later).

We have backups (daily backups stored inside borg on a remote host).

Is there anything we can do? Restoring from backup will probably take
more than 24h (3 TB). The system runs web and mail hosts for more than
100 customers.

We did not try to run "btrfs check --repair" yet, nor
"--init-extent-tree". I'd rather try a quick repair before restoring.
But OTOH, I don't want to make it worse and waste time by trying.

Unfortunately, the btrfs has been mounted rw again after unmounting
following the incident. This restarted the balance, and it seems it
changed the first error "btrfs check" found. I'll try
"ro,skip-balance" after btrfs-check finished. I think the file-system
is still fully readable and we can take one last backup.

Also, I happily provide the logs collected if a dev wanted to look into it.


Thanks in advance
Kai

