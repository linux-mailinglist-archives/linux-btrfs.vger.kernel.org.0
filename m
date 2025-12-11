Return-Path: <linux-btrfs+bounces-19652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 149DECB5998
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 12:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C878830038C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92666306B3D;
	Thu, 11 Dec 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE+Z44p4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144A2FC881
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765451118; cv=none; b=nAt3+7IZ3k4pBkvuk8RVADz53EUYOhc6zb0+z1koQuguiMjSYmn/AJUfIshADyU9lQaPXKBNlixY0zcC5fXzDq6VITHuvoIBZ75KFBM+A9Ljq0LoMKNnm1vWS+VZZopFGaa3C3Zx2iJQbNwUcUy6ixtP0g3wjGzhtgfJkVpc4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765451118; c=relaxed/simple;
	bh=Tzkq+0kzaK/m8fOLUvy+igZrpuaUE6jJYHwD6rxRs/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X17RhBd1j2SxRKvwhpQox/O3TJfJms5LKa0l6QgIhddIznGWlTTDj3dps7MIwugY4jWOaCUZX17aPy484pN749tRYIeaMUL1Rmf9369N17dpe6JkHKkmTv2kZkjA4MO4XHolZOZCMlo7hPY+JetFOgE2Q9kZO72KIktis8pJRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE+Z44p4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1694EC116B1
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765451118;
	bh=Tzkq+0kzaK/m8fOLUvy+igZrpuaUE6jJYHwD6rxRs/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HE+Z44p41iRiDeve3aicvdjoegrvrSh8G7ijPquuTS7val0R6D7Filzv6zruVtVI3
	 upRHUZr3CEvzqpBpzNFSYYh7r73oRTkHSCGLQEuZIzy5KCZrYc09eXcxu5UdF49HRj
	 3y14Ey+UDhcCuuknrBWWisZNcxexIlJSz+/YovqVZidI0QW6PHhldYay1fPZYuE2/y
	 T3QXu+yCv/APv5ImdK7Tq4l/HjUCy1oZIcYt4qpn+GblFd0ePlZQRxlJJLCcH3J/mM
	 ua9E9a/rIMeHApUyQ6jRzw4Qk/TNA4Dgn2IfYMwjP/CM7HUbEk3pY7k6U7YFTfjo4Y
	 BXCYHOzmtYRMA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79f98adea4so120336666b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 03:05:18 -0800 (PST)
X-Gm-Message-State: AOJu0YxbJ2abC+3/Z2VKIGgZ9DHK6YTANtuaWG2tyJ2nubckjqOee3oV
	aPkDLfWeOIg3GXi5YYMgAFaEcwRa1kH4uMyRMA/get6WEF8FEJNqJytBx1t35kg+RiJtVSU/kSe
	RBM/FvVsiq9BV30ubm/+wJGmf/f4nkiY=
X-Google-Smtp-Source: AGHT+IE/6iXT4bTRHCycQ9TA0yBoQ3+XO7gzEwbD+FcwgUunGZmt5rZ30hSwQDXlSa05SLi9/Y828j3mKNIWB4rzfa4=
X-Received: by 2002:a17:907:9483:b0:b73:6474:1ee8 with SMTP id
 a640c23a62f3a-b7ce830132emr641088766b.14.1765451116231; Thu, 11 Dec 2025
 03:05:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211053033.31566-1-robbieko@synology.com>
In-Reply-To: <20251211053033.31566-1-robbieko@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Dec 2025 11:04:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6zuL798_-gcj3zGdWwn_zmqJ3sUA3dxYB77Mp2ZHoSJA@mail.gmail.com>
X-Gm-Features: AQt7F2rzo0MxktGCT-20LNHa5fyYABel9MJdY0kW87cIUk9FNra0ORmm4WCxbcg
Message-ID: <CAL3q7H6zuL798_-gcj3zGdWwn_zmqJ3sUA3dxYB77Mp2ZHoSJA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix deadlock in wait_current_trans() due to
 ignored transaction type
To: robbieko <robbieko@synology.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 5:39=E2=80=AFAM robbieko <robbieko@synology.com> wr=
ote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When wait_current_trans() is called during start_transaction(), it
> currently waits for a blocked transaction without considering whether
> the given transaction type actually needs to wait for that particular
> transaction state. The btrfs_blocked_trans_types[] array already defines
> which transaction types should wait for which transaction states, but
> this check was missing in wait_current_trans().
>
> This can lead to a deadlock scenario involving two transactions and
> pending ordered extents:
>   1. Transaction A is in TRANS_STATE_COMMIT_DOING state
>   2. A worker processing an ordered extent calls start_transaction()
>      with TRANS_JOIN
>   3. join_transaction() returns -EBUSY because Transaction A is in
>      TRANS_STATE_COMMIT_DOING
>   4. Transaction A moves to TRANS_STATE_UNBLOCKED and completes
>   5. A new Transaction B is created (TRANS_STATE_RUNNING)
>   6. The ordered extent from step 2 is added to Transaction B's
>      pending ordered extents
>   7. Transaction B immediately starts commit by another task and
>      enters TRANS_STATE_COMMIT_START
>   8. The worker finally reaches wait_current_trans(), sees Transaction B
>      in TRANS_STATE_COMMIT_START (a blocked state), and waits
>      unconditionally
>   9. However, TRANS_JOIN should NOT wait for TRANS_STATE_COMMIT_START
>      according to btrfs_blocked_trans_types[]
>   10. Transaction B is waiting for pending ordered extents to complete
>   11. Deadlock: Transaction B waits for ordered extent, ordered extent
>       waits for Transaction B
>
> This can be illustrated by the following call stacks:
>   CPU0                              CPU1
>                                     btrfs_finish_ordered_io()
>                                       start_transaction(TRANS_JOIN)
>                                         join_transaction()
>                                           # -EBUSY (Transaction A is
>                                           # TRANS_STATE_COMMIT_DOING)
>   # Transaction A completes
>   # Transaction B created
>   # ordered extent added to
>   # Transaction B's pending list
>   btrfs_commit_transaction()
>     # Transaction B enters
>     # TRANS_STATE_COMMIT_START
>     # waiting for pending ordered
>     # extents
>                                         wait_current_trans()
>                                           # waits for Transaction B
>                                           # (should not wait!)
>
> Task bstore_kv_sync in btrfs_commit_transaction waiting for ordered
> extents:
>   __schedule+0x2e7/0x8a0
>   schedule+0x64/0xe0
>   btrfs_commit_transaction+0xbf7/0xda0 [btrfs]
>   btrfs_sync_file+0x342/0x4d0 [btrfs]
>   __x64_sys_fdatasync+0x4b/0x80
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Task kworker in wait_current_trans waiting for transaction commit:
>   Workqueue: btrfs-syno_nocow btrfs_work_helper [btrfs]
>   __schedule+0x2e7/0x8a0
>   schedule+0x64/0xe0
>   wait_current_trans+0xb0/0x110 [btrfs]
>   start_transaction+0x346/0x5b0 [btrfs]
>   btrfs_finish_ordered_io.isra.0+0x49b/0x9c0 [btrfs]
>   btrfs_work_helper+0xe8/0x350 [btrfs]
>   process_one_work+0x1d3/0x3c0
>   worker_thread+0x4d/0x3e0
>   kthread+0x12d/0x150
>   ret_from_fork+0x1f/0x30
>
> Fix this by passing the transaction type to wait_current_trans() and
> checking btrfs_blocked_trans_types[cur_trans->state] against the given
> type before deciding to wait. This ensures that transaction types which
> are allowed to join during certain blocked states will not unnecessarily
> wait.

I would add at the end "... will not unncessarily wait or cause such deadlo=
cks".

Anyway, it looks good to me, great finding!

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I'll add the patch to the for-next branch later today.

Thanks.

>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/transaction.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 05ee4391c83a..a8988e5af730 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -520,13 +520,14 @@ static inline int is_transaction_blocked(struct btr=
fs_transaction *trans)
>   * when this is done, it is safe to start a new transaction, but the cur=
rent
>   * transaction might not be fully on disk.
>   */
> -static void wait_current_trans(struct btrfs_fs_info *fs_info)
> +static void wait_current_trans(struct btrfs_fs_info *fs_info, unsigned i=
nt type)
>  {
>         struct btrfs_transaction *cur_trans;
>
>         spin_lock(&fs_info->trans_lock);
>         cur_trans =3D fs_info->running_transaction;
> -       if (cur_trans && is_transaction_blocked(cur_trans)) {
> +       if (cur_trans && is_transaction_blocked(cur_trans) &&
> +               (btrfs_blocked_trans_types[cur_trans->state] & type)) {
>                 refcount_inc(&cur_trans->use_count);
>                 spin_unlock(&fs_info->trans_lock);
>
> @@ -701,12 +702,12 @@ start_transaction(struct btrfs_root *root, unsigned=
 int num_items,
>                 sb_start_intwrite(fs_info->sb);
>
>         if (may_wait_transaction(fs_info, type))
> -               wait_current_trans(fs_info);
> +               wait_current_trans(fs_info, type);
>
>         do {
>                 ret =3D join_transaction(fs_info, type);
>                 if (ret =3D=3D -EBUSY) {
> -                       wait_current_trans(fs_info);
> +                       wait_current_trans(fs_info, type);
>                         if (unlikely(type =3D=3D TRANS_ATTACH ||
>                                      type =3D=3D TRANS_JOIN_NOSTART))
>                                 ret =3D -ENOENT;
> @@ -1003,7 +1004,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_=
info, u64 transid)
>
>  void btrfs_throttle(struct btrfs_fs_info *fs_info)
>  {
> -       wait_current_trans(fs_info);
> +       wait_current_trans(fs_info, TRANS_START);
>  }
>
>  bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
> --
> 2.17.1
>
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.
>

