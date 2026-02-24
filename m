Return-Path: <linux-btrfs+bounces-21877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FH8F4q2nWnURAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21877-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:32:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E869D188656
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 075883181DD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEB539E6D9;
	Tue, 24 Feb 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPxGdCmh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EB3806A5
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943173; cv=none; b=Ssb3nGNwHN5cFRHQovnIspeg7glp7eQZkq47GRPpTLC5667NGfXXRr/htTnwBbyEp0j1lsvyogZydbOHmGmV6hxByix01FrxAFlysN/yJ9uo1zn9jC/UK/5gCqmV6k6JhyMdkevnvPKjALrJWrR6MquN9f+aifZODgF5ZUIn3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943173; c=relaxed/simple;
	bh=61BOYmMpMx8+yC5CSFlqzFrdV0FCZH/NdkTHK9YtIy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOVtsszs9QCzvQePj70BdtY7ai95lUzBXrfGLSgUsCCFm85Ro85lDxdRO2j5TaDB7c2KnPrkKmgICquQay1TFVxkO5s/cnzzPvPaU5GLFR7g5/pUMfRFDkC54haiRkfqhRM/6euorHQbKMmEBUfl4XGToK2rJqv4N04dwLZBKEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPxGdCmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCE3C2BCB0
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771943172;
	bh=61BOYmMpMx8+yC5CSFlqzFrdV0FCZH/NdkTHK9YtIy4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cPxGdCmhtykPwVJudyLhs2cn2Lux2NOEdEUBsz6dZbI9O64NGOlvxYFqHC+swB35d
	 INVtkoCUGsXUw/UT3TrUlB3f+4ROb82HdboVwhquDPx3yvVWxEGOsP0i2A5QuPtQyV
	 550KHkA39tzZmRfWbLO6y2ymMoZByFNhQZ0/WaTny6FJ2dax7qq98WrRrQpawmpTq4
	 USDQGbZ7tBca44XaKc9Tn/Bm1/wHJycEX6jxmNya5MDL2/QBrSNsH2SkI90TOefIEV
	 31SzC3fqr+BWF1cN1B4BLQ7gf8rZ10eQSyVj5SzTCtkCfWEjIq/ELDH8lj2350yB9O
	 xqBZuyfFOhADw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65c5a778923so8581610a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 06:26:12 -0800 (PST)
X-Gm-Message-State: AOJu0YzfWs2lstMFtKBTdUlXn2bDO97iqpUZ+/fXinTuVRPDjJrBg56k
	PkITXTu2QUwTs7JCApgHo9gRmnQ0vPOS5uweKnIxC8KkcpnPYgNz0KlSXdExOL52B99xeqQPFpu
	ha9+Mkk50SM0Ivv/QXP+ASUkiYEERWjU=
X-Received: by 2002:a17:907:84b:b0:b90:bc06:2acc with SMTP id
 a640c23a62f3a-b90bc063e40mr301503166b.5.1771943171271; Tue, 24 Feb 2026
 06:26:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224125113.14831-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260224125113.14831-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 24 Feb 2026 14:25:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5+v__wrqe3gj-E0PE_09-S7ZHERnFLO5LEPcjKwS1DJQ@mail.gmail.com>
X-Gm-Features: AaiRm520l7355gJIWP5LEtJIgXw0dwHO_lT2IoQMAUk3eRX1_WI2eSMyBPjjS4c
Message-ID: <CAL3q7H5+v__wrqe3gj-E0PE_09-S7ZHERnFLO5LEPcjKwS1DJQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: move btrfs_zoned_reserve_data_reloc_bg
 after kthread start
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21877-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: E869D188656
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:54=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> btrfs_zoned_reserve_data_reloc_bg() is called on each mount of a file
> system and allocates a new block-group, to assign it to be the dedicated
> relocation target, if no pre-existing usable block-group for this task is
> found.
>
> If for some reason the transaction is aborted, btrfs_end_transaction()
> will wake up the transaction kthread. But the transaction kthread is not
> yet initialized at the time btrfs_zoned_reserve_data_reloc_bg() is
> called, leading to the follwing NULL-pointer dereference:
>
>  RSP: 0018:ffffc9000c617c98 EFLAGS: 00010046
>  RAX: 0000000000000000 RBX: 000000000000073c RCX: 0000000000000002
>  RDX: 0000000000000001 RSI: 0000000000000003 RDI: 0000000000000001
>  RBP: 0000000000000207 R08: ffffffff8223c71d R09: 0000000000000635
>  R10: ffff888108588000 R11: 0000000000000003 R12: 0000000000000003
>  R13: 000000000000073c R14: 0000000000000000 R15: ffff888114dd6000
>  FS:  00007f2993745840(0000) GS:ffff8882b508d000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000000073c CR3: 0000000121a82006 CR4: 0000000000770eb0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   try_to_wake_up (./include/linux/spinlock.h:557 kernel/sched/core.c:4106=
)
>   __btrfs_end_transaction (fs/btrfs/transaction.c:1115 (discriminator 2))
>   btrfs_zoned_reserve_data_reloc_bg (fs/btrfs/zoned.c:2840)
>   open_ctree (fs/btrfs/disk-io.c:3588)
>   btrfs_get_tree.cold (fs/btrfs/super.c:982 fs/btrfs/super.c:1944 fs/btrf=
s/super.c:2087 fs/btrfs/super.c:2121)
>   vfs_get_tree (fs/super.c:1752)
>   __do_sys_fsconfig (fs/fsopen.c:231 fs/fsopen.c:295 fs/fsopen.c:473)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x8=
6/entry/syscall_64.c:94 (discriminator 1))
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
>  RIP: 0033:0x7f299392740e
>
> Move the call to btrfs_zoned_reserve_data_reloc_bg() after the
> transaction_kthread has been initialized to fix this problem.
>
> Fixes: 694ce5e143d6 ("btrfs: zoned: reserve data_reloc block group on mou=
nt")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> This supersedes https://lore.kernel.org/r/20260223143820.89931-1-johannes=
.thumshirn@wdc.com
>
>  fs/btrfs/disk-io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 73ddde973532..428b135a890d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3583,7 +3583,6 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>                 }
>         }
>
> -       btrfs_zoned_reserve_data_reloc_bg(fs_info);
>         btrfs_free_zone_cache(fs_info);
>
>         btrfs_check_active_zone_reservation(fs_info);
> @@ -3611,6 +3610,8 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>                 goto fail_cleaner;
>         }
>
> +       btrfs_zoned_reserve_data_reloc_bg(fs_info);

Adding a comment above like:  "Starts a transaction, must be called
after the transaction kthread is initialized."
Would help prevent reintroducing the bug if we get a refactoring in
the future that moves it around.

Also, adding an ASSERT(fs_info->transaction_thread !=3D NULL)  in
__btrfs_end_transaction(), even if there was no abort, would be good
to have to prevent this sort of bug and catch any cases in the future
where we start a transaction before the kthread is initialized. That
can be done separately.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
>         ret =3D btrfs_read_qgroup_config(fs_info);
>         if (ret)
>                 goto fail_trans_kthread;
> --
> 2.53.0
>
>

