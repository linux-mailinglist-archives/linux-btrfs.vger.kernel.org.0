Return-Path: <linux-btrfs+bounces-12056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FDAA54FF6
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 17:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E2F16FCB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3099C199FAF;
	Thu,  6 Mar 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj9ZPafJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775ADEC2
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276860; cv=none; b=FDRLPoMh/LxH+f8EqoAeA+gpDPWKM/1Jp9eaXxN4wqPqaKCuYvxB3YJP/bPMwv/XigacUMvtQycyT45/22ezb9dnWW3YKToBPHkEscdatf7Vcm03jSsTGqnRW38QFdfsC/7ZHdqQ5rL6OX3ySPusxYNJBrAC+0O0XhCh9Cqyapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276860; c=relaxed/simple;
	bh=zpbXlFx24DBGuoPcvd49Ltfl0Na6TtHIR1RIlcG1sZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7f9HPiVQbVVAZoCBOAKzq8slEnxKBrKCO0uWbr8O19Q1Euh5CtlSw8mUhLrejCfdH3ca8BBAeM/u5ua+lL4Ej7jAN7xtG67fkAxBeRs6jqk5Ub/dXxVV8rQRwJyP5UHQk69n63wrlfPthgcsTzN6LI1VeqQYQ6q5Wtr2G1MGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj9ZPafJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001ABC4CEE0
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741276860;
	bh=zpbXlFx24DBGuoPcvd49Ltfl0Na6TtHIR1RIlcG1sZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tj9ZPafJDUwx/nyqpNEaCAtThpBVPZH/7iCPfMQgIDQGhM5tsk+Q3UPwVWHL4LI59
	 DHKdGGD+duf8GldsHBebXT+Z2yCXt1YJR6S9Hx6iyZWOoL2RhvoTCggm+h9mYDlH5o
	 WsPsYSzalmaP6SY0HaTguRbGJRnoDlNjV/n6SGpHUN+QfSwWiIL6kk+o7Hir8AMMmg
	 R6EbAGb+Q6ToQabl3+MFTDceQTsWwHx1Q1t2bSIbQtdDkqARJAARRnIci/181Qmt2+
	 nxt1YYKSr7aehpqStshdjWKcqqrUTS+QGBcbkHnvXZd6ajrjP0jUIU1hwPqi/RuF/j
	 DC0REgoRJ6zqQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e549af4927so1439897a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Mar 2025 08:00:59 -0800 (PST)
X-Gm-Message-State: AOJu0YylgmDG7807MEJk7Kf3FzXtwVlbqvrUqv+UJM0LlC9UdVgoy6nJ
	3fJJxIg/slI6KSOwpEd1cy6TKFK1GW+4G4OfqSxKlliDT0E61+loZsI0Z8wfrxLznbHdy56ih3W
	MnEVQyn/BD6M1eUwidnIxtdf0bkI=
X-Google-Smtp-Source: AGHT+IGs2Z++HVs2Af3S3NxBEbcGJl42szeEU5rQLr1RrR9nb3YyTKJOmy+sTdK28VllnKWEYUh7xC8dXejTUyp2aRg=
X-Received: by 2002:a17:907:3d86:b0:ac2:8a4:b9db with SMTP id
 a640c23a62f3a-ac20d8bcab2mr680767166b.16.1741276858470; Thu, 06 Mar 2025
 08:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741196484.git.fdmanana@suse.com> <cover.1741198394.git.fdmanana@suse.com>
 <35989618-457a-47a6-acf6-7175d86eec08@gmx.com>
In-Reply-To: <35989618-457a-47a6-acf6-7175d86eec08@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 6 Mar 2025 16:00:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H48z3E6KmyG6T1GZCi+_57FVNNP4iO-MshxQWN8ez-Ycg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr0D5CRlT47iE276jdPzUyuePFHynKbBdrTonPrG9nDgNckX41nPVfPDQY
Message-ID: <CAL3q7H48z3E6KmyG6T1GZCi+_57FVNNP4iO-MshxQWN8ez-Ycg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] btrfs: fix unexpected delayed iputs at umount time
 and cleanups
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 10:09=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/3/6 04:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Fix a couple races that can result in adding delayed iputs during umoun=
t after
> > we no longer expect to find any, triggering an assertion failure. Plus =
a couple
> > cleanups. Details in the change logs.
> >
> > V2: Removed the NULL checks for the workqueues in patches 1 and 2, as t=
hey
> >      can never be NULL while at close_ctree() (they can only be NULL in=
 error
> >      paths from open_ctree()).
>
> BTW, even with this series applied, I can still trigger the delayed iput
> ASSERT():
>
> [ 5364.406135] BTRFS warning (device dm-10 state EA): direct IO failed
> ino 259 op 0x0 offset 0x14800 len 18432 err no 10
> [ 5364.406327] BTRFS warning (device dm-10 state EA): direct IO failed
> ino 301 op 0x0 offset 0x112000 len 12288 err no 10
> [ 5364.406443] BTRFS warning (device dm-10 state EA): direct IO failed
> ino 284 op 0x0 offset 0x129000 len 40960 err no 10
> [ 5364.408115] BTRFS warning (device dm-10 state EA): direct IO failed
> ino 333 op 0x0 offset 0x43000 len 2048 err no 10
> [ 5364.408350] BTRFS warning (device dm-10 state EA): direct IO failed
> ino 7914 op 0x0 offset 0x34a000 len 43008 err no 10
> [ 5364.636270] BTRFS info (device dm-10 state EA): last unmount of
> filesystem 9c4c225e-d4c6-43d0-b8c9-4b3afb5cb3cc
> [ 5364.639881] assertion failed: list_empty(&fs_info->delayed_iputs), in
> fs/btrfs/disk-io.c:4419
> [ 5364.641814] ------------[ cut here ]------------
> [ 5364.642733] kernel BUG at fs/btrfs/disk-io.c:4419!
> [ 5364.643712] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 5364.644880] CPU: 5 UID: 0 PID: 2672520 Comm: umount Tainted: G
> W          6.14.0-rc5-custom+ #224
> [ 5364.646787] Tainted: [W]=3DWARN
>
> I have hit this at least twice, on x86_64 with the new experimental 2K
> block size.
>
> And this is the latest for-next, which does not have the uncached IO
> patch at all.
>
> Since I do not have compression enable for the mount options, I believe
> there is some extra causes.

There is, in case of IO errors we can add delayed iputs from another queue,
which makes sense since generic/648 exercises IO error simulation with dmer=
ror,
and your dmesg also shows IO errors. Patch here:

https://lore.kernel.org/linux-btrfs/b07f13dbfadfdb5884b21b97bbf1316c45d06a3=
2.1741272910.git.fdmanana@suse.com/

Thanks.

>
> Thanks,
> Qu
>
> >
> > Filipe Manana (4):
> >    btrfs: fix non-empty delayed iputs list on unmount due to endio work=
ers
> >    btrfs: fix non-empty delayed iputs list on unmount due to compressed=
 write workers
> >    btrfs: move __btrfs_bio_end_io() code into its single caller
> >    btrfs: move btrfs_cleanup_bio() code into its single caller
> >
> >   fs/btrfs/bio.c     | 36 ++++++++++++++----------------------
> >   fs/btrfs/disk-io.c | 21 +++++++++++++++++++++
> >   2 files changed, 35 insertions(+), 22 deletions(-)
> >
>

