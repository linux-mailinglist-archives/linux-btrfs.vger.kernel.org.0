Return-Path: <linux-btrfs+bounces-19261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE192C7BAFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 21:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3DA03510B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 20:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C622DC349;
	Fri, 21 Nov 2025 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE9j8B6a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C122A4CC
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758358; cv=none; b=fXxyry2qNrxtfPJArT1mo0YdC5WcuVzLU2yLBRrtbLXGbwgUIRHbJmb7QW7Asmk1CLoQJdo09WPoSbnhYMXnUda5BbdCvCobQwnv3GPp8J8JaEnGyDJN3OfHIXfsUCF4NCsagqCT5nKqKR4U9KHh6qbrgluIIpifnYZIi8ckru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758358; c=relaxed/simple;
	bh=DoFG0lTfikLuf3OP5IN0e0os6gOYDnEedsrU82bBtdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRH/5OBlqM81k1B5c4YVYqF90IpEKxXTPByDwTNwcg5AgGEy1NKc/BGzbpTcsNT9qJ8XOqmXR+syZIke1S9hIA0X+1oVSCxu1j8GXaaAtB+T0B8ProfLDqHFy8b0ATAFO0BFwZDsIBBEroZ9qmOB/v2oFoWUIxBvhE2G4asBwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE9j8B6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58F2C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 20:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763758357;
	bh=DoFG0lTfikLuf3OP5IN0e0os6gOYDnEedsrU82bBtdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TE9j8B6akYQ9M9bk22qrn28IQJKWkjMGePMKQMb48K9mHYyCUWdSntjWSMD2Yr18E
	 /DigTgfiSUHawDc34a1oconUq/zhj4AtbhNy0rktz54Jg0fI0WsWOYdUQ6ti7NahDf
	 +48euzNJ8yy9ZWVhdC9oW6Zdkcie0KkaXkP3vtAJobbvbSLDGLWRYvzQ8vV5g5h+iB
	 JDn1VOIpfJPPE11ZPUHldXMztlbWgJ9BRzCJR2514v0BOJUaclVwgqqsj8y+ZLNMUh
	 3pN1E2fyIG1+u0xuhpKXttKCuG38LXhirdC0lNAq9Pvo9jkIKYQKWcqdbbNBypJeN1
	 P64/OSDFk/seQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b762de65c07so373773366b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 12:52:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKs7FG6zXtiQpU4RqYxAJ0RzIRA9pnfrwg0FLD7QpClHtYi9SWYuuOPn071sNvv3D6IotPT9uVTwdGlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxbNaZoPAMymfDwg9bWpH6fxZXlKK3bLfeli8hON8JFH0Yrv4
	4cokRA9LBmqb0ADQAVJFzM1kHKaEyUa1vZx7uSukqjGxHArpS335WD5MZIVW7vrIfrwiM/kvQZm
	V5N/w3Si+eLFQ1yaAlv0gRIpknPXCI1M=
X-Google-Smtp-Source: AGHT+IE4LqS6gUF9pR0x9D2H0xC26fOOwh2fWFEja9bi15rnygvL5O4DB2Smwi3q90A5RdNoUQF2hPbg+4oxkjsZY4E=
X-Received: by 2002:a17:907:3da6:b0:b73:32c7:6e6a with SMTP id
 a640c23a62f3a-b76715b3481mr430896366b.25.1763758356338; Fri, 21 Nov 2025
 12:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763736921.git.josef@toxicpanda.com> <7a9d970450cb1531d0a0da5d8e8615b06aba9137.1763736921.git.josef@toxicpanda.com>
 <CAL3q7H7phOax9p2s-pcaeGdE4rgpZc7NP1=0Ny+o93fXYKJ-Nw@mail.gmail.com> <bff15ad4-1f67-4733-acb4-cd04686f4ec4@gmx.com>
In-Reply-To: <bff15ad4-1f67-4733-acb4-cd04686f4ec4@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Nov 2025 20:51:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7vCNjkaR9AyTHXNjnk+zZmMeMZ3ePoMtQ99Vkzcpd4OA@mail.gmail.com>
X-Gm-Features: AWmQ_bmUjKfkvMBClgamM5DH7_jPrcRmhtXXXtrQgNMRxk3JwA9glEIcVWnShoE
Message-ID: <CAL3q7H7vCNjkaR9AyTHXNjnk+zZmMeMZ3ePoMtQ99Vkzcpd4OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: fix data race on transaction->state
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 8:29=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/11/22 01:59, Filipe Manana =E5=86=99=E9=81=93:
> > On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> >>
> >> Debugging a hang with btrfs on QEMU I discovered a data race with
> >> transaction->state. In wait_current_trans we do
> >>
> >> wait_event(fs_info->transaction_wait,
> >>             cur_trans->state>=3DTRANS_STATE_UNBLOCKED ||
> >>             TRANS_ABORTED(cur_trans));
> >>
> >> however we're doing this outside of the fs_info->trans_lock. This
> >> generally isn't super problematic because we hit
> >> wake_up(fs_info->transaction_wait) quite a bit, but it could lead to
> >> latencies where we miss wakeups, or in the worst case (like the compil=
er
> >> re-orders the load of the ->state outside of the wait_event loop) we
> >> could hang completely.
> >>
> >> Fix this by using a helper that takes the fs_info->trans_lock to do th=
e
> >> check safely.
> >>
> >> I've added a lockdep_assert for the other helper to make sure nobody
> >> uses that one without holding the lock.
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >>   fs/btrfs/transaction.c | 18 +++++++++++++++---
> >>   1 file changed, 15 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> >> index 89ae0c7a610a..863e145a3c26 100644
> >> --- a/fs/btrfs/transaction.c
> >> +++ b/fs/btrfs/transaction.c
> >> @@ -509,11 +509,25 @@ int btrfs_record_root_in_trans(struct btrfs_tran=
s_handle *trans,
> >>
> >>   static inline int is_transaction_blocked(struct btrfs_transaction *t=
rans)
> >>   {
> >> +       lockdep_assert_held(&trans->fs_info->trans_lock);
> >> +
> >
> > It seems odd to sneak this in when no other change in the patch
> > introduces a call to this function.
> > I would make this a separate patch.
> >
> >>          return (trans->state >=3D TRANS_STATE_COMMIT_START &&
> >>                  trans->state < TRANS_STATE_UNBLOCKED &&
> >>                  !TRANS_ABORTED(trans));
> >>   }
> >>
> >> +/* Helper to check transaction state under lock for wait_event */
> >> +static bool trans_unblocked(struct btrfs_transaction *trans)
> >
> > This could have a name that is closer to the other helper:
> > is_transaction_unblocked()
> >
> >> +{
> >> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> >> +       bool ret;
> >> +
> >> +       spin_lock(&fs_info->trans_lock);
> >> +       ret =3D trans->state >=3D TRANS_STATE_UNBLOCKED || TRANS_ABORT=
ED(trans);
> >> +       spin_unlock(&fs_info->trans_lock);
> >> +       return ret;
> >> +}
> >> +
> >>   /* wait for commit against the current transaction to become unblock=
ed
> >>    * when this is done, it is safe to start a new transaction, but the=
 current
> >>    * transaction might not be fully on disk.
> >> @@ -529,9 +543,7 @@ static void wait_current_trans(struct btrfs_fs_inf=
o *fs_info)
> >>                  spin_unlock(&fs_info->trans_lock);
> >>
> >>                  btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRA=
NS_UNBLOCKED);
> >> -               wait_event(fs_info->transaction_wait,
> >> -                          cur_trans->state >=3D TRANS_STATE_UNBLOCKED=
 ||
> >> -                          TRANS_ABORTED(cur_trans));
> >> +               wait_event(fs_info->transaction_wait, trans_unblocked(=
cur_trans));
> >
> > Instead of adding an helper and locking, couldn't this be simply:
> >
> > wait_event(fs_info->transaction_wait,
> > smp_load_acquire(cur_trans->state) >=3D TRANS_STATE_UNBLOCKED ||
> > TRANS_ABORTED(cur_trans));
>
> Not an expert on memory barriers, but isn't the key point here that
> we're accessing two different variables in a non-atomic way?

So what?
We can continue accessing the trans aborted case as we did because
it's not expected to happen, so any latency in the waiting due to a
transaction abort is fine.

>
> And to be honest, I really do not like introducing low level memory
> barrier callers, it's really hard to get it right.

I generally don't like it either. But here it saves quite some code
and it's for a very rare case anyway.

Plus there's also this inconsistency with the second patch, which
favors using smp_load_acquire() instead of taking the lock.

__nfs_lookup_revalidate() uses smp_load_acquire() precisely in the
same situation,
in a wait_var_event() condition to read dentry->d_fsdata, which is
updated under the protection of dentry->d_lock.


>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >>                  btrfs_put_transaction(cur_trans);
> >>          } else {
> >>                  spin_unlock(&fs_info->trans_lock);
> >> --
> >> 2.51.1
> >>
> >>
> >
>

