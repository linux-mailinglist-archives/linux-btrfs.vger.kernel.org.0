Return-Path: <linux-btrfs+bounces-21063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNFBOrqJd2m9hgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21063-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 16:35:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CF08A330
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41AE6301BA64
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D833F364;
	Mon, 26 Jan 2026 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs0wm8jC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF51625
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441713; cv=none; b=SBuTsFNR4HzhDC8xYVCuuGXuY6cB39t8DhpZhmR5f9FnrLfmj2sLFv3Fqh4cSAr5OyANMAHYdYCbkBw+Xm9gOV2EOi5Ac/dRiEklZyiib2ddh6jDyGipKxW9dVbHXyyAHiC2Ip6Ja9xcX8wJA1aYCoQJPon0d0e/UVKlSJrlmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441713; c=relaxed/simple;
	bh=5pTuL0v9Slf8/w/bTMFiaZFYMlLZhdAqeVhOAn6Z1fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOuFJ4zHvX5LGrhvhOGa+La6y5mr+Jx9P2ZBXWiq173RoNAItEyFjb5doqyYBvOCYhpOFXIzJIL9AHjr3UDJZJNKcfQtsJXpnW+wH5xyEQUcjTut8y3i4sVt+kNQxhhuzNHvPMO0bKZBkhf7j2TCGGkV6eOMraJsCGQYb7f7vBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs0wm8jC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7A4C4AF0B
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769441712;
	bh=5pTuL0v9Slf8/w/bTMFiaZFYMlLZhdAqeVhOAn6Z1fE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gs0wm8jCw6c9or/hrrW258yKu+yBWW5dCINMww0n+qPTgQNMHvKW2pQoFJRgd6ny+
	 pq4CR21gxj1BmhK87MpW/tuz9vgirFxGUplcLCucrxs3IkuoAF9t8Tv0Jg9r6QrDCA
	 USIfYPFxgTgqsf8G89fZFeYKHtuh3Rc4FtW+UNTQNHZOQxs0Cn/sfPZ+qjsl4VvFRv
	 IpuyE8P7OVTbdohs9Y2pa+q1479KesCoRtBrNep5iC5arRyKAw++wyjEPoMRk7Ue9M
	 ejjgakKHgeGLFYHSQnOi828Vqhhpw2Tdc8DanQ43h2ocGt5aWLjxHhBV0Ps5ozouBw
	 nhchrpPmD2G8g==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so670754066b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 07:35:12 -0800 (PST)
X-Gm-Message-State: AOJu0YxYYExoA10TO7s0pfWHsIYlnLxk9a+kkhRY1A2gCdA8jzLe70op
	tVDe5cJTKx+werUEGFHtbgsLQFpo91iz5Gv1YQQeZ9CVdzOttBn36NEACq5oTQFVE46/x4ZB4Vf
	Ua/KB9nr/hHOUzGMpuzqD7HPtTr6Gi6U=
X-Received: by 2002:a17:907:3da3:b0:b8a:f225:ede1 with SMTP id
 a640c23a62f3a-b8d2e85bff4mr330231666b.41.1769441711117; Mon, 26 Jan 2026
 07:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126083639.602258-1-jinbaohong@synology.com> <20260126083639.602258-2-jinbaohong@synology.com>
In-Reply-To: <20260126083639.602258-2-jinbaohong@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Jan 2026 15:34:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6a60hDYih4_2kuf02_V24sUsZTv9+GF1xzdQV_MPVD5A@mail.gmail.com>
X-Gm-Features: AZwV_QjxyautZRpYr6j73_cOJIzkolyFWrrUVC2bUFCdDckcATNEAlTixYQEqVk
Message-ID: <CAL3q7H6a60hDYih4_2kuf02_V24sUsZTv9+GF1xzdQV_MPVD5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: continue trimming remaining devices on failure
To: jinbaohong <jinbaohong@synology.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, 
	Robbie Ko <robbieko@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21063-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,synology.com:email]
X-Rspamd-Queue-Id: 57CF08A330
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 8:36=E2=80=AFAM jinbaohong <jinbaohong@synology.com=
> wrote:
>
> Commit 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle
> error better") intended to make device trimming continue even if one
> device fails, tracking failures and reporting them at the end. However,
> it used 'break' instead of 'continue', causing the loop to exit on the
> first device failure.
>
> Additionally, user interrupts (-ERESTARTSYS) were incorrectly counted
> as device failures. Interrupts should stop the operation immediately
> without being reported as device errors.
>
> Fix this by:
> 1. Replacing 'break' with 'continue'.
> 2. Stopping immediately on user interrupt without counting it as a
>    device failure, but still setting dev_ret to -ERESTARTSYS so
>    the error is properly returned to the caller
> 3. Converting -EINTR from mutex_lock_interruptible() to -ERESTARTSYS
>    for consistent interrupt handling
>
> Fixes: 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle err=
or better")
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: jinbaohong <jinbaohong@synology.com>
> ---
>  fs/btrfs/extent-tree.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 0ce2a7def0f3..b299e369649b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6539,8 +6539,10 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>                 u64 bytes;
>
>                 ret =3D mutex_lock_interruptible(&fs_info->chunk_mutex);
> -               if (ret)
> +               if (ret) {
> +                       ret =3D -ERESTARTSYS;

So here we should return what mutex_lock_interruptible() returns,
which is -EINTR.

If you look at the comments in include/linux/errno.h, where
ERESTARTSYS is defined, you can read:

/*
 * These should never be seen by user programs.  To return one of ERESTART*
 * codes, signal_pending() MUST be set.  Note that ptrace can observe these
 * at syscall exit tracing, but they will never be left for the debugged us=
er
 * process to see.
 */

There are several kernel places that convert an internal ERESTARTSYS
to EINTR to return to user space, so that confirms it.

Example, in fs/open.c:

SYSCALL_DEFINE1(close, unsigned int, fd)
{
   (...)
   /* can't restart close syscall because file table entry was cleared */
   if (retval =3D=3D -ERESTARTSYS ||
       retval =3D=3D -ERESTARTNOINTR ||
       retval =3D=3D -ERESTARTNOHAND ||
       retval =3D=3D -ERESTART_RESTARTBLOCK)
   retval =3D -EINTR;

   return retval;
}

Or in fs/xfs/scrub/common.c:

int
xchk_perag_drain_and_lock(
   struct xfs_scrub *sc)
{
(...)
   error =3D xfs_group_intent_drain(pag_group(sa->pag));
   if (error =3D=3D -ERESTARTSYS)
      error =3D -EINTR;
(...)


>                         break;
> +               }
>
>                 btrfs_find_first_clear_extent_bit(&device->alloc_state, s=
tart,
>                                                   &start, &end,
> @@ -6685,10 +6687,14 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, =
struct fstrim_range *range)
>                 ret =3D btrfs_trim_free_extents(device, &group_trimmed);
>
>                 trimmed +=3D group_trimmed;
> +               if (ret =3D=3D -ERESTARTSYS) {
> +                       dev_ret =3D -ERESTARTSYS;

And either replace it with -EINTR.

Otherwise it looks fine, thanks.

> +                       break;
> +               }
>                 if (ret) {
>                         dev_failed++;
>                         dev_ret =3D ret;
> -                       break;
> +                       continue;
>                 }
>         }
>         mutex_unlock(&fs_devices->device_list_mutex);
> --
> 2.34.1
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

