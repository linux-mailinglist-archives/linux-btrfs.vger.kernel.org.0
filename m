Return-Path: <linux-btrfs+bounces-9293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D09B8D43
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D739B1F22F20
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33634157484;
	Fri,  1 Nov 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwkLVXvY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8C156C76;
	Fri,  1 Nov 2024 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730450691; cv=none; b=ujZM3KI+o5PBlRpiNoKIEsx/fvtVKmHjtyTc3L7SfrOxW9g9NM2G/GgPXcrGi7HXb4FR7Q3YGMzMBp2J+4Jdpp3Q/7WYAyC80U8XrUXFLhquClE0qaVVd/mMwkTETOXhfNqyTGsq2f5g4GiBM0g6cY9drCfsPxZ1re4/RF07cgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730450691; c=relaxed/simple;
	bh=hFP28qqDVRgB/iKvSSyW9TfPZ4Jslyo2VBj6dqTndBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k45HdHPvEpfcxK98KX9CW6LvPSEdlwQclV3yRpv1DxnVRSWkh1maeRTkke4+sQnBJ/Kl/rR600abp3eOecqWYRxnOUbZYS0KvEuBpZlogk+B2+DL5G7njn3GO++V+S7WQedIb3p1KqZn0R3hlVAENIpC5gJBWM2slgXoLz4Rer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwkLVXvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC674C4CED2;
	Fri,  1 Nov 2024 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730450690;
	bh=hFP28qqDVRgB/iKvSSyW9TfPZ4Jslyo2VBj6dqTndBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TwkLVXvYCaMFI97mmnq+k/ItgLFJxcTPn/fzrGWmJa1SoeboCyI1Ao6PQH6QLXX2B
	 jOkZo6/PyL55sgwUMdVkCwA0yl0e3K/JCeHlvjIpBhXCQdSiC+F2QfFx7tzDAARsv4
	 QKKtkOQgkbtZbu3N6rs45kHw1hx2hjX25tVNTJ6PfsDLthB/2bI8Zd9uJVSwUhUZWE
	 wKzW0YQ3riXz37ATM0fGtug+ZZoVA4Zu6Ty2VxBDnxO3l/KDgMi7dVigGD0o8I3pXm
	 dGVZQb+DYV9CGpAF9MmyyCKxYiTIRnpq6RhEqJUd9xUqOohcSW4/Fiv3m1LGNvBjYh
	 Z8hLoZByb8sJw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso263260866b.1;
        Fri, 01 Nov 2024 01:44:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBld1314Xf4P4vqo4Cb4DJ0+GdvA/GY8v8rm1w4RPaRnbW3MeiyrNle9BY8Q7KNZc+0yWLx0geFhayLw==@vger.kernel.org, AJvYcCWTY8gwhRqcLBzVaRrGBOzByyWzhrOLBi1mEC9Sw3bAMk/6QDMiYnHxjY+C/3qdKOaFMQOmzNcHkwgURvdu@vger.kernel.org
X-Gm-Message-State: AOJu0Yys22alv+JUcyZ7Z9d7WQzek5sDKBU+hGv5dIeEQZ5yyDIJgIDO
	AKKKf/s+/pPsVmbc6s9gW8m12gDGr2MJs4le1F7eseh6hWXv/Cngrs4qmQdXjUuSStKWy3vnXOC
	BwurNjOAHH+APxvosNqddFZ7SIAU=
X-Google-Smtp-Source: AGHT+IEVwtRe7s10AaJwV9WO4s8T9YvjzGOIPTgdCfRvbONjS/QQ4GuOliA1z4AHKzar52jyc8l6KPnXbjODHg7sZtU=
X-Received: by 2002:a17:907:6e86:b0:a99:5234:c56c with SMTP id
 a640c23a62f3a-a9e3a6210bdmr902147266b.33.1730450689405; Fri, 01 Nov 2024
 01:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101035133.925251-1-zhenghaoran@buaa.edu.cn>
In-Reply-To: <20241101035133.925251-1-zhenghaoran@buaa.edu.cn>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 1 Nov 2024 08:44:12 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5SAEs75APMgRLNGZD+Mg6ic04+78M_rseabtidf1w05w@mail.gmail.com>
Message-ID: <CAL3q7H5SAEs75APMgRLNGZD+Mg6ic04+78M_rseabtidf1w05w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Fix data race in log_conflicting_inodes
To: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 3:52=E2=80=AFAM Hao-ran Zheng <zhenghaoran@buaa.edu.=
cn> wrote:
>
> The Data Race occurs when the `log_conflicting_inodes()` function is
> executed in different threads at the same time. When one thread assigns
> a value to `ctx->logging_conflict_inodes` while another thread performs
> an `if(ctx->logging_conflict_inodes)` judgment or modifies it at the
> same time, a data contention problem may arise.

No, there's no problem at all.
A log context is thread local, it's never shared between threads.

>
> Further, an atomicity violation may also occur here. Consider the
> following case, when a thread A `if(ctx->logging_conflict_inodes)`
> passes the judgment, the execution switches to another thread B, at
> which time the value of `ctx->logging_conflict_inodes` has not yet
> been assigned true, which would result in multiple threads executing
> `log_conflicting_inodes()`.

No. When you make such claims, please provide a sequence diagram that
shows how the tasks interact, what their call stacks are, so that we
can see where the race happens.

But again, this is completely wrong because a log context (struct
btrfs_log_ctx) is never shared between threads.

Thanks.

>
> To address this issue, it is recommended to add locks to protect
> `logging_conflict_inodes` in the `btrfs_log_ctx` structure, and lock
> protection during assignment and judgment. This modification ensures
> that the value of `ctx->logging_conflict_inodes` does not change during
> the validation process, thereby maintaining its integrity.
>
> Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
> ---
>  fs/btrfs/tree-log.c | 7 +++++++
>  fs/btrfs/tree-log.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 9637c7cdc0cf..9cdbf280ca9a 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2854,6 +2854,7 @@ void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx, =
struct btrfs_inode *inode)
>         INIT_LIST_HEAD(&ctx->conflict_inodes);
>         ctx->num_conflict_inodes =3D 0;
>         ctx->logging_conflict_inodes =3D false;
> +       spin_lock_init(&ctx->logging_conflict_inodes_lock);
>         ctx->scratch_eb =3D NULL;
>  }
>
> @@ -5779,16 +5780,20 @@ static int log_conflicting_inodes(struct btrfs_tr=
ans_handle *trans,
>                                   struct btrfs_log_ctx *ctx)
>  {
>         int ret =3D 0;
> +       unsigned long logging_conflict_inodes_flags;
>
>         /*
>          * Conflicting inodes are logged by the first call to btrfs_log_i=
node(),
>          * otherwise we could have unbounded recursion of btrfs_log_inode=
()
>          * calls. This check guarantees we can have only 1 level of recur=
sion.
>          */
> +       spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_in=
odes_flags);

Even if this was remotely correct, why the irqsave? The fsync code is
never called under irq context.

>         if (ctx->logging_conflict_inodes)
> +               spin_unlock_irqrestore(&ctx->conflict_inodes_lock, loggin=
g_conflict_inodes_flags);
>                 return 0;
>
>         ctx->logging_conflict_inodes =3D true;
> +       spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_confli=
ct_inodes_flags);
>
>         /*
>          * New conflicting inodes may be found and added to the list whil=
e we
> @@ -5869,7 +5874,9 @@ static int log_conflicting_inodes(struct btrfs_tran=
s_handle *trans,
>                         break;
>         }
>
> +       spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_in=
odes_flags);
>         ctx->logging_conflict_inodes =3D false;
> +       spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_confli=
ct_inodes_flags);
>         if (ret)
>                 free_conflicting_inodes(ctx);
>
> diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
> index dc313e6bb2fa..0f862d0c80f2 100644
> --- a/fs/btrfs/tree-log.h
> +++ b/fs/btrfs/tree-log.h
> @@ -44,6 +44,7 @@ struct btrfs_log_ctx {
>         struct list_head conflict_inodes;
>         int num_conflict_inodes;
>         bool logging_conflict_inodes;
> +       spinlock_t logging_conflict_inodes_lock;
>         /*
>          * Used for fsyncs that need to copy items from the subvolume tre=
e to
>          * the log tree (full sync flag set or copy everything flag set) =
to
> --
> 2.34.1
>
>

