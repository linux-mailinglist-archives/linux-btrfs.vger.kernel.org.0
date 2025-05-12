Return-Path: <linux-btrfs+bounces-13885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FABAB3654
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 13:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8653816E4A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 11:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6228292904;
	Mon, 12 May 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cieMWKEc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D12673A9;
	Mon, 12 May 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050844; cv=none; b=bnH/Lxm5EweyLyiCuSJetqvD46Mp4lnWghEzHQihnOLlld8wtn+ZngieZYO/6rClcNsEmTCSsdx5wFeOAzj36axLkdTELYhsRcPfwUg+LcBhiNeOtqvkjzxBBZKzZWo700pVsvlIsrCMPReF2tTpZwPpY9nlso/yID9EZJY9hR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050844; c=relaxed/simple;
	bh=eb8ZsJ6Yx2yDxjJYXJfcI7YxWu14s9HET5BlZwhZGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDji/9YKhpS0fPupC74GnqyiEDeVbtPBRVe0hdaaFAnFlbVnyJYyw9yIlD8zc7g5zyjm5BwD3HrMyu1tsmdkolagaF/busdzR+bw12OWUF5BnqgL0uGJy2YMPKM034dEuf7EeFI42w/S0I6Q7F9vi4yxOwU3CQaCy+IT5tNTqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cieMWKEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7EAC4CEE7;
	Mon, 12 May 2025 11:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747050843;
	bh=eb8ZsJ6Yx2yDxjJYXJfcI7YxWu14s9HET5BlZwhZGq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cieMWKEcGLYW1VpYVrH2+e+HK8IxhJDwv4H/37aidvb8AwUvqV1zBqrA6yrGJi7XH
	 Q+yNOIkjLRqXsbgS3U4fv13sKW8ZQh4XoPALgPp3krZMK12n5ycESW3CyJPsBOer1Y
	 8Su/GSwO06gc6XZrwHWEmnq+V3MGflV6NTIBl8iAKIWV4sm0GBYeD4/87DWdJr3bmV
	 V6EB9Peb8WIvBCDSRJutcyaMGrTxd56N239rYB9B22hf4EkchdVYJwnqStMZTfqsju
	 t52c13R92nulq1hN2Ca5H+sE+CLphiK6O6LO2KLr/yUW/w5BbSBg655T+KzAqw3FPB
	 zyfRHBjTlFatA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fbf534f8dbso6691546a12.3;
        Mon, 12 May 2025 04:54:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKu0BQUJaVPkjx2x684osQiuFAgVUOolfKWOz8dr6Tormb66M7Y1MRqNZmX7+Z9wUrwChA8eyBoHUBcLSi@vger.kernel.org, AJvYcCXT7qbLsBXhbuaqYL0rJbvaBMkIb0LQDpiLw8qI2DoqBT/eT6uupFOzgnoijsocCGNRykc08mAIqRdI8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33MAWtoOnIhygMsagOj+V/Rfs/P/aJ9wjUWvLujjAGRwX7y8H
	sY3YVVfrCJMekWvYxhE1DtXpgXv3hyKf4gJOrf08VVYyI4NGnrm0DnCX15uaFcLq4lIakTq6hpY
	vnFbf1ssGwXvBjj4/E3tvCJQBLfM=
X-Google-Smtp-Source: AGHT+IHITliuM5o9K8MKsEdEWVwNfSftxfl7r9fZQdUSymVQs1FehguKW9uNhVvxJtBQ2ZkajSKvZ1otZvxtGf/XAVI=
X-Received: by 2002:a17:907:968c:b0:ad2:49cc:b460 with SMTP id
 a640c23a62f3a-ad249ccb8admr495776666b.3.1747050842117; Mon, 12 May 2025
 04:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUCLMz0hY-GaPj1Z=fhkgRHjxVXHZ8kz0PvkFN0b=8L2Q@mail.gmail.com>
In-Reply-To: <CAFRLqsUCLMz0hY-GaPj1Z=fhkgRHjxVXHZ8kz0PvkFN0b=8L2Q@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 12 May 2025 12:53:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5NtJ+0eB6HzLw-JAewBSA8V8jZbPMapdwUA+P5axg+7g@mail.gmail.com>
X-Gm-Features: AX0GCFuIY-Igdi5x80pqhZ87dmhuLhMQMTqAy8tWwut9ziBsG-2p072Zetq-2_c
Message-ID: <CAL3q7H5NtJ+0eB6HzLw-JAewBSA8V8jZbPMapdwUA+P5axg+7g@mail.gmail.com>
Subject: Re: [BUG] Data race on delayed_refs->num_heads_ready between
 btrfs_delete_ref_head and btrfs_run_delayed_refs
To: cen zhang <zzzccc427@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 8:48=E2=80=AFAM cen zhang <zzzccc427@gmail.com> wro=
te:
>
> Hello maintainers,
>
> I would like to report a data race bug detected in
> the Btrfs filesystem on Linux kernel 6.14-rc4.
> The issue was discovered by our tools,
> which identified unsynchronized concurrent accesses to
> `delayed_refs->num_heads_ready`.
>
> The relevant stack trace detail is as follows:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3DDATARACE=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> Function: btrfs_delete_ref_head+0x164/0x180 fs/btrfs/delayed-ref.c:550
> Function: check_ref_cleanup+0x178/0x290 fs/btrfs/extent-tree.c:3381
> Function: btrfs_free_tree_block+0x334/0x7f0 fs/btrfs/extent-tree.c:3444
> Function: btrfs_quota_disable+0x4d2/0x750 fs/btrfs/qgroup.c:1414
> Function: btrfs_ioctl_quota_ctl+0x18f/0x1f0 fs/btrfs/ioctl.c:3707
> Function: btrfs_ioctl+0x943/0xe40 fs/btrfs/ioctl.c:5325
> Function: vfs_ioctl fs/ioctl.c:51 [inline]
> Function: __do_sys_ioctl fs/ioctl.c:906 [inline]
> Function: __se_sys_ioctl+0x91/0xf0 fs/ioctl.c:892
> Function: do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> Function: do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
> Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Function: 0x0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  __btrfs_run_delayed_refs+0xe0/0x1a50 fs/btrfs/extent-tree.c:2015
>  btrfs_run_delayed_refs+0xd1/0x2b0 fs/btrfs/extent-tree.c:2158
>  btrfs_commit_transaction+0x27a/0x1c40 fs/btrfs/transaction.c:2196
>  del_balance_item fs/btrfs/volumes.c:3810 [inline]
>  reset_balance_state+0x193/0x240 fs/btrfs/volumes.c:3874
>  btrfs_balance+0x1698/0x1770 fs/btrfs/volumes.c:4706
>  btrfs_ioctl_balance+0x290/0x470 fs/btrfs/ioctl.c:3587
>  btrfs_ioctl+0xcaf/0xe40 fs/btrfs/ioctl.c:5305
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:906 [inline]
>  __se_sys_ioctl+0x91/0xf0 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1a0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The code locations involved in the data race are:
>
> Write (fs/btrfs/delayed-ref.c):
>
> if (!head->processing)
>     delayed_refs->num_heads_ready--;
>
> Reader (fs/btrfs/extent-tree.c):
>
> delayed_refs =3D &trans->transaction->delayed_refs;
> if (min_bytes =3D=3D 0) {
>     max_count =3D delayed_refs->num_heads_ready;
>     ...
> }
>
> I=E2=80=99ve verified that this issue still exists in the latest source t=
ree as follows
>
> Write (fs/btrfs/delayed-ref.c):
>
> 548        if (!head->processing)
> 549                delayed_refs->num_heads_ready--;
>
> Reader (fs/btrfs/extent-tree.c):
>
> 2007        delayed_refs =3D &trans->transaction->delayed_refs;
> 2008        if (min_bytes =3D=3D 0) {
> 2009                max_count =3D delayed_refs->num_heads_ready;
> 2010                min_bytes =3D U64_MAX;
> 2011        }

It's a harmless race. We can silence KCSAN and such tools with a
data_race() annotation there.

Patch sent:    https://lore.kernel.org/linux-btrfs/13e40ba1be5f87e2b79275f5=
8f4defe11e6bd62d.1747050634.git.fdmanana@suse.com/

Thanks.

>
> Thank you for your attention to this matter.
>
> Best regards,
> Cen Zhang
>

