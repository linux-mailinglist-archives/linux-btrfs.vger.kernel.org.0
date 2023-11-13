Return-Path: <linux-btrfs+bounces-90-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD937E9D23
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 14:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BE51C208F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4F82031F;
	Mon, 13 Nov 2023 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axU86Pmo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC48200C5
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 13:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EA9C433C9
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699882143;
	bh=KWG5LCV6U1GggP4D/OFzv1+obtGa/pN4tePQULVCroU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=axU86PmoLKvH0p9HxggZktBrCv4bnRdJVCigbQPpa1SLnS8+U+2Izlei8gKngzXgh
	 WGIkgE7wNIhwna89a5sbIKF1Il1vXfbhM4CKKE2fowNm8wwWEPWdGTpqwFl3wcnAos
	 MiXvcyrcp7EJ+6/THwy+z+oaULxj/H2SLE/dk6JI5yTTT4zrOeI7vt+2Xt3O7l3MuX
	 pK4Cro/KtQNY7BnN4j3mmRIW2Ji4EPxrsmBMPCCPZWa/6npHe3eqOFKsOalq7L4f9N
	 B6PAo8Q8L4/Rm8G8ATzHDHqaUSR/feroEDF7pIFz9xn8E3qld7fN19k1wncvV6Pxuf
	 O9GcoradXSSXw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-507a55302e0so6142871e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 05:29:03 -0800 (PST)
X-Gm-Message-State: AOJu0Yw1ag5uOqxHorc3nF5fu3jhhqn3H9+FQjHo1V1xY/bU/3yMilQP
	/L1t4dPhMMliAEgbUKa/skIHOCuhSWnD/WfdnQI=
X-Google-Smtp-Source: AGHT+IEwmCLuogfW2kanKP/2syY+950ccmz9Q/jkW/Iqr620gBKo4VhBjh9JgvsWGDxZWFT4LDwNmkiuzjL+bHQHKqk=
X-Received: by 2002:ac2:43bc:0:b0:509:478f:fb07 with SMTP id
 t28-20020ac243bc000000b00509478ffb07mr4251006lfl.30.1699882141674; Mon, 13
 Nov 2023 05:29:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b305a5b0228b40fc62923b0133957c72468600de.1699649085.git.wqu@suse.com>
In-Reply-To: <b305a5b0228b40fc62923b0133957c72468600de.1699649085.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 Nov 2023 13:28:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H49E1B33d_MHoq61sN0oXHXiPPbWX4DDivqp63kS8r7Pg@mail.gmail.com>
Message-ID: <CAL3q7H49E1B33d_MHoq61sN0oXHXiPPbWX4DDivqp63kS8r7Pg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not abort transaction if there is already an
 existing qgroup
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, 
	syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 8:45=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Syzbot reported a regression that after commit 6ed05643ddb1 ("btrfs:
> create qgroup earlier in snapshot creation") we can trigger transaction
> abort during subvolume creation:

subvolume -> snapshot

>
>   ------------[ cut here ]------------
>   BTRFS: Transaction aborted (error -17)
>   WARNING: CPU: 0 PID: 5057 at fs/btrfs/transaction.c:1778 create_pending=
_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
>   Modules linked in:
>   CPU: 0 PID: 5057 Comm: syz-executor225 Not tainted 6.6.0-syzkaller-1536=
5-g305230142ae0 #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/09/2023
>   RIP: 0010:create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:=
1778
>   Call Trace:
>    <TASK>
>    create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1967
>    btrfs_commit_transaction+0xf1c/0x3730 fs/btrfs/transaction.c:2440
>    create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
>    btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
>    btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
>    __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
>    btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
>    btrfs_ioctl+0xbbf/0xd40
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:871 [inline]
>    __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
>    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>    do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>    entry_SYSCALL_64_after_hwframe+0x63/0x6b
>   RIP: 0033:0x7f2f791127b9
>    </TASK>
>
> [CAUSE]
> The error number is -EEXIST, which can happen for qgroup if there is
> already an existing qgroup and then we're trying to create a subvolume

subvolume -> snapshot

> for it.
>
> [FIX]
> In that case, we can continue creating the subvolume, although it may

subvolume -> snapshot

> lead to qgroup inconsistency, it's not so critical to abort the current
> transaction.
>
> So in this case, we can just ignore the non-critical errors, mostly -EEXI=
ST
> (there is already a qgroup).
>
> Reported-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
> Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

With those minor fixes to the changelog:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 9694a3ca1739..7af9665bebae 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1774,7 +1774,7 @@ static noinline int create_pending_snapshot(struct =
btrfs_trans_handle *trans,
>         btrfs_release_path(path);
>
>         ret =3D btrfs_create_qgroup(trans, objectid);
> -       if (ret) {
> +       if (ret && ret !=3D -EEXIST) {
>                 btrfs_abort_transaction(trans, ret);
>                 goto fail;
>         }
> --
> 2.42.1
>
>

