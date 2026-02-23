Return-Path: <linux-btrfs+bounces-21845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD0UHnBznGmcGAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21845-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:34:08 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC1D178C5A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4ED07302CC20
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030AC2EA16A;
	Mon, 23 Feb 2026 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FePXPJf6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A427FB18
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860811; cv=none; b=FZjNf9tJe5R0DyNIw12iwAA1LxMJ1u/Kd2SkHjgS8h2KqKuiws+iLEwDd/zyF/miTaTHnWwyqDlOk8fpayMAo8cieqjmPB3Cv7E0Fljfn4rD59DnXnpo8349wjaKncph2Gf9OpZHnkT4WqVzj4jLQFrpKdCbLHaObmvgteq2Wfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860811; c=relaxed/simple;
	bh=OkaDnGqdM+s+r4/tujcP4B3QdSsLjnJ47TW5IJUBruk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJO113Q/z6PI8APA0LZCmtkkcQMpTxufg2RvgnMiQaTkHC7R7kXWo1yCvpAFWj5hlE4/8puvRs05Y089py/BgxE/TXsrycrXWkGkFWheUmz2uRWt1ZX3nh8jnBipWTEmTznyn22QODz3UsEtYZCveogHMaw45Hg7oJbz1f4+lmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FePXPJf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8020C116D0
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860810;
	bh=OkaDnGqdM+s+r4/tujcP4B3QdSsLjnJ47TW5IJUBruk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FePXPJf62truL5Rkbqrrbfk+eX9xOM+jeqn6LBYHHFMHdJJ3rMzV+9VgBHUBEz0ML
	 hQiALNxyDoMZHtqlzTC5lQLfF8eqDxDNm/Jc5Nq4BoRIWJLZL0ZOjPmx/N/yfGOEJP
	 hhrudvyVIRbxC4jZArgd+BdHHVev4bDhozsjxP592AENyz64Mce7M83jZTtg1lJuJW
	 2hIQTFKLwooSEd+3sOR+SmX3nIWpg87Dv86xbyxlWUp44i9Jb6JQC9cVUQWfZQUJaC
	 oZDPPPtztc7IWzxw6tuS5cVTcvt0pdU6O70Jk52GRnGRIN682R7gniUt3WPyNRH19J
	 7TuTyEBaxS63A==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so742329666b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 07:33:30 -0800 (PST)
X-Gm-Message-State: AOJu0YwMiMfzS1RGEkpwVqqsnPTa58X/jBmSSa67PNjioT52u5JA9Rwp
	QXz/6nfqsJ47I1xLdvopI0Qpz1sUTUCkju4X59KU7lpC3Us4LPKCmhvvYA6xaie0OG4ANtJXhcr
	sxzvDtivswVdPd98qWxYGuRwcaEMvfg4=
X-Received: by 2002:a17:906:7304:b0:b88:71ec:e7a6 with SMTP id
 a640c23a62f3a-b9081a1d37cmr592558966b.17.1771860809431; Mon, 23 Feb 2026
 07:33:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223143820.89931-1-johannes.thumshirn@wdc.com>
 <CAL3q7H5fg12yM+RUsDsKbEsr7-Fdk_Fs2gr6=qG-E1uR0YU-Kw@mail.gmail.com> <8727ee44-8eab-4fcd-8b6d-2bc85271772a@wdc.com>
In-Reply-To: <8727ee44-8eab-4fcd-8b6d-2bc85271772a@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 23 Feb 2026 15:32:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5VNs0FuBCoALq+BHWH3rWne-7o0on3vJfbNVgr1QkMZg@mail.gmail.com>
X-Gm-Features: AaiRm50xpDYE_DStz3vOGe8szwUCSp8KqprBwGovGQ_lJed-dzwKOUXVI9l989s
Message-ID: <CAL3q7H5VNs0FuBCoALq+BHWH3rWne-7o0on3vJfbNVgr1QkMZg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: catch aborted trans in btrfs_zoned_reserve_data_reloc_bg
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21845-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,termbin.com:url,wdc.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FC1D178C5A
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 3:28=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 2/23/26 4:14 PM, Filipe Manana wrote:
> > On Mon, Feb 23, 2026 at 2:39=E2=80=AFPM Johannes Thumshirn
> > <johannes.thumshirn@wdc.com> wrote:
> >> btrfs_zoned_reserve_data_reloc_bg() is called on each mount of a file
> >> system and allocates a new block-group, to assign it to be the dedicat=
ed
> >> relocation target, if no pre-existing usable block-group for this task=
 is
> >> found.
> >>
> >> If for some reason the transaction was aborted during the call to
> >> btrfs_chunk_alloc() and btrfs_end_transaction() is executed, a
> >> NULL-pointer dereference happens in btrfs_end_transaction().
> > How does that happen?
> > Do you have the stack trace?
> >
> > We are supposed to be able to call btrfs_end_transaction() even if the
> > transaction was aborted.
> > In fact we have to, otherwise we leak memory. We do this everywhere in
> > the code base in fact.
> >
> Yep I do, here's the most important part:
>
> [  944.448765] BUG: kernel NULL pointer dereference, address: 00000000000=
0073c
> [  944.449060] #PF: supervisor write access in kernel mode
> [  944.449270] #PF: error_code(0x0002) - not-present page
> [  944.449476] PGD 0 P4D 0
> [  944.449590] Oops: Oops: 0002 [#1] SMP NOPTI
> [  944.449762] CPU: 3 UID: 0 PID: 19233 Comm: mount Tainted: G        W  =
         6.19.0-rc8+ #330 PREEMPT(none)
> [  944.450174] Tainted: [W]=3DWARN
> [  944.450301] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  944.450536] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x50
> [  944.450755] Code: 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 5=
5 53 48 89 fb 9c 5d fa bf 01 00 00 00 e8 65 07 5d ff 31 c0 ba 01 00 00 00 <=
f0> 0f b1 13 75 0a 48 89 e8 5b 5d c3 cc cc cc cc 89 c6 48 89 df e8
> [  944.451505] RSP: 0018:ffffc9000c617c98 EFLAGS: 00010046
> [  944.451726] RAX: 0000000000000000 RBX: 000000000000073c RCX: 000000000=
0000002
> [  944.452020] RDX: 0000000000000001 RSI: 0000000000000003 RDI: 000000000=
0000001
> [  944.452313] RBP: 0000000000000207 R08: ffffffff8223c71d R09: 000000000=
0000635
> [  944.452612] R10: ffff888108588000 R11: 0000000000000003 R12: 000000000=
0000003
> [  944.452910] R13: 000000000000073c R14: 0000000000000000 R15: ffff88811=
4dd6000
> [  944.453208] FS:  00007f2993745840(0000) GS:ffff8882b508d000(0000) knlG=
S:0000000000000000
> [  944.453534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  944.453777] CR2: 000000000000073c CR3: 0000000121a82006 CR4: 000000000=
0770eb0
> [  944.454072] PKRU: 55555554
> [  944.454187] Call Trace:
> [  944.454293]  <TASK>
> [  944.454387]  try_to_wake_up+0x5b/0x640
> [  944.454556]  __btrfs_end_transaction+0x137/0x230
> [  944.454754]  btrfs_zoned_reserve_data_reloc_bg+0x300/0x3d0
> [  944.454989]  open_ctree+0xedf/0x1688
> [  944.455146]  btrfs_get_tree.cold+0xbf/0x200
> [  944.455327]  vfs_get_tree+0x21/0xa0
> [  944.455480]  __do_sys_fsconfig+0x4c8/0x690
> [  944.455660]  do_syscall_64+0x59/0x2b0
> [  944.455822]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> And decoded:
>
> [  944.451505] RSP: 0018:ffffc9000c617c98 EFLAGS: 00010046
> [  944.451726] RAX: 0000000000000000 RBX: 000000000000073c RCX: 000000000=
0000002
> [  944.452020] RDX: 0000000000000001 RSI: 0000000000000003 RDI: 000000000=
0000001
> [  944.452313] RBP: 0000000000000207 R08: ffffffff8223c71d R09: 000000000=
0000635
> [  944.452612] R10: ffff888108588000 R11: 0000000000000003 R12: 000000000=
0000003
> [  944.452910] R13: 000000000000073c R14: 0000000000000000 R15: ffff88811=
4dd6000
> [  944.453208] FS:  00007f2993745840(0000) GS:ffff8882b508d000(0000) knlG=
S:0000000000000000
> [  944.453534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  944.453777] CR2: 000000000000073c CR3: 0000000121a82006 CR4: 000000000=
0770eb0
> [  944.454072] PKRU: 55555554
> [  944.454187] Call Trace:
> [  944.454293]  <TASK>
> [  944.454387]  try_to_wake_up (./include/linux/spinlock.h:557 kernel/sch=
ed/core.c:4106)
> [  944.454556]  __btrfs_end_transaction (fs/btrfs/transaction.c:1115 (dis=
criminator 2))
> [  944.454754]  btrfs_zoned_reserve_data_reloc_bg (fs/btrfs/zoned.c:2840)
> [  944.454989]  open_ctree (fs/btrfs/disk-io.c:3588)
> [  944.455146]  btrfs_get_tree.cold (fs/btrfs/super.c:982 fs/btrfs/super.=
c:1944 fs/btrfs/super.c:2087 fs/btrfs/super.c:2121)
> [  944.455327]  vfs_get_tree (fs/super.c:1752)
> [  944.455480]  __do_sys_fsconfig (fs/fsopen.c:231 fs/fsopen.c:295 fs/fso=
pen.c:473)
> [  944.455660]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discrimina=
tor 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> [  944.455822]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S=
:131)
> [  944.456041] RIP: 0033:0x7f299392740e

This should go into the change log.

The problem is  btrfs_zoned_reserve_data_reloc_bg() is called in
open_ctree() before we initialized the transaction kthread and
btrfs_end_transaction() will try to wake the kthread.

The fix here is to change the order in open_ctree() to call
btrfs_zoned_reserve_data_reloc_bg() only after setting up the
transaction kthread (which is just a few lines below anyway).

Thanks.

>
>
>
> full log of my debug session so far, including dumps of fs_info,
> space_info and trans: https://termbin.com/m3mz
>

