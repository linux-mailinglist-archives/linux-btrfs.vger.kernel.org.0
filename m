Return-Path: <linux-btrfs+bounces-19249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6073AC7A936
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6405234AB45
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962FC2BD58A;
	Fri, 21 Nov 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABeIM4/6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CA26560B
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739003; cv=none; b=jMZdNt9s2butv9NTP8yrA5wius2r0pb1NTFvpcXDh8mPnQXtOyyxyGb1nwyLpuzd2jjnZvbu/tC/1IAW8UPIHbx4LFHJrv3HTy2mkvru9qgst/IYTZe0rKmHCrv0N363YKmUXZ28BznRX1xTQYRfBqPbt/IjJ9PRNwJn3ZyuH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739003; c=relaxed/simple;
	bh=efZWS3HBmGGcCG7Wfs/GcVGZvjYXGQk48+hpHyEnuHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6W+zj+M8HuTkCj3vvDSeim0afLXBQuJoNuQXeXvUB7xiAWND53KgubZAhdxBrXh0XUyMBgRV2ADq7SK+Crl2eqGSsceJxv1YnRsfhGPLQZZ+k8CFoU9dz4YM8fgfXVjo8nuCu8bAQkdxNbyV2zBjUbDAQbqR40BWbGbbQKnZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABeIM4/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D73C4CEFB
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763739003;
	bh=efZWS3HBmGGcCG7Wfs/GcVGZvjYXGQk48+hpHyEnuHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ABeIM4/6/zxDNbckumLiS0il4RWXYDsaGMhdyNCuzVZmR3eyM6T/IuoqkResk70PS
	 SoIMv5fungr5i3+GpRdAOgwfwayfcDqJSbGXb2FYBTOuwa+CLgunwnBmZ7OxRqNKd8
	 UCwcvhalSHO8XcegBsvdnKsfieOQCoCe6DLmTnIyH8b6WUE9xnZI86tHZXY6fq8ztT
	 PiBRJCiIxZWhpMsF++vCWn1fM8n55sJ2EUpRmCurkOkxwFSv5nkl46hpnkZ9HMNBPv
	 1szCK2f3IdUU5aBZpM8LZfqKJsdmz8NexnFzH3r1WzHPGxbCR6/mYVVzRP9uwqaEou
	 LhCh92p4auiyg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b73161849e1so151098966b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 07:30:03 -0800 (PST)
X-Gm-Message-State: AOJu0Yy/ZNs2WPo8Jhxy/GNKletCUkv8ESejVZ5fZn1dwHWEkBfzzfWf
	C2QJ5o5QRxjWx3wf2x5hux7KBAUkrmNUq0Z0+pzYwHkjVmkHgl2ygAvFH/BRBmLK+cT5P+SmhX0
	3bUamZjs7KM9ghbf+ZjRXceB1kU25ors=
X-Google-Smtp-Source: AGHT+IFwx2SN5jcQu+hCJM5GqPo2NbId/yG4Vfhz4SztoDc4Hstl8Aip9RqxGAg1t8lEQQVIkc/49ahEr4W6TlAk174=
X-Received: by 2002:a17:907:d8e:b0:b72:5e29:5084 with SMTP id
 a640c23a62f3a-b767150b9a3mr274401966b.4.1763739002187; Fri, 21 Nov 2025
 07:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763736921.git.josef@toxicpanda.com> <7a9d970450cb1531d0a0da5d8e8615b06aba9137.1763736921.git.josef@toxicpanda.com>
In-Reply-To: <7a9d970450cb1531d0a0da5d8e8615b06aba9137.1763736921.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Nov 2025 15:29:25 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7phOax9p2s-pcaeGdE4rgpZc7NP1=0Ny+o93fXYKJ-Nw@mail.gmail.com>
X-Gm-Features: AWmQ_bkn0yltK94UDeaaR4HbqRDOT-CY3pY5t6EuJp7BCbGBZFqeUDaR2_AByK8
Message-ID: <CAL3q7H7phOax9p2s-pcaeGdE4rgpZc7NP1=0Ny+o93fXYKJ-Nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: fix data race on transaction->state
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Debugging a hang with btrfs on QEMU I discovered a data race with
> transaction->state. In wait_current_trans we do
>
> wait_event(fs_info->transaction_wait,
>            cur_trans->state>=3DTRANS_STATE_UNBLOCKED ||
>            TRANS_ABORTED(cur_trans));
>
> however we're doing this outside of the fs_info->trans_lock. This
> generally isn't super problematic because we hit
> wake_up(fs_info->transaction_wait) quite a bit, but it could lead to
> latencies where we miss wakeups, or in the worst case (like the compiler
> re-orders the load of the ->state outside of the wait_event loop) we
> could hang completely.
>
> Fix this by using a helper that takes the fs_info->trans_lock to do the
> check safely.
>
> I've added a lockdep_assert for the other helper to make sure nobody
> uses that one without holding the lock.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/transaction.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 89ae0c7a610a..863e145a3c26 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -509,11 +509,25 @@ int btrfs_record_root_in_trans(struct btrfs_trans_h=
andle *trans,
>
>  static inline int is_transaction_blocked(struct btrfs_transaction *trans=
)
>  {
> +       lockdep_assert_held(&trans->fs_info->trans_lock);
> +

It seems odd to sneak this in when no other change in the patch
introduces a call to this function.
I would make this a separate patch.

>         return (trans->state >=3D TRANS_STATE_COMMIT_START &&
>                 trans->state < TRANS_STATE_UNBLOCKED &&
>                 !TRANS_ABORTED(trans));
>  }
>
> +/* Helper to check transaction state under lock for wait_event */
> +static bool trans_unblocked(struct btrfs_transaction *trans)

This could have a name that is closer to the other helper:
is_transaction_unblocked()

> +{
> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       bool ret;
> +
> +       spin_lock(&fs_info->trans_lock);
> +       ret =3D trans->state >=3D TRANS_STATE_UNBLOCKED || TRANS_ABORTED(=
trans);
> +       spin_unlock(&fs_info->trans_lock);
> +       return ret;
> +}
> +
>  /* wait for commit against the current transaction to become unblocked
>   * when this is done, it is safe to start a new transaction, but the cur=
rent
>   * transaction might not be fully on disk.
> @@ -529,9 +543,7 @@ static void wait_current_trans(struct btrfs_fs_info *=
fs_info)
>                 spin_unlock(&fs_info->trans_lock);
>
>                 btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_U=
NBLOCKED);
> -               wait_event(fs_info->transaction_wait,
> -                          cur_trans->state >=3D TRANS_STATE_UNBLOCKED ||
> -                          TRANS_ABORTED(cur_trans));
> +               wait_event(fs_info->transaction_wait, trans_unblocked(cur=
_trans));

Instead of adding an helper and locking, couldn't this be simply:

wait_event(fs_info->transaction_wait,
smp_load_acquire(cur_trans->state) >=3D TRANS_STATE_UNBLOCKED ||
TRANS_ABORTED(cur_trans));

Thanks.

>                 btrfs_put_transaction(cur_trans);
>         } else {
>                 spin_unlock(&fs_info->trans_lock);
> --
> 2.51.1
>
>

