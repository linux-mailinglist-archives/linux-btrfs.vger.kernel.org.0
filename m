Return-Path: <linux-btrfs+bounces-14560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242AAD1D04
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 14:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2773A28FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2AD1E98FB;
	Mon,  9 Jun 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LASecYw1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48DF9CB
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749471489; cv=none; b=YP5TNGfj1T0FBrl7Io1AS1y1F3L+hXZ99DozVF/tOQlzh3Fh3nFGvzkUBXYFiJO10Qy17iXdhlFba8UVmGiV87XuxR+lJnGVnShYLERJeRdEnJ8zFwgiFpri4wMt46a1ub+6pRt4DO1/W6deg0VVEphKFpV3jjjleRUrJ8tdeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749471489; c=relaxed/simple;
	bh=N5HC8dp2BLOSQIlPlssv0SUh1gbKqIKwm/bkQdTZEcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLNTfXsmlPZm9GbqG3vCMbO5u/geQW03JmQeGKvLwjabA0EtR521DBeDNOeRwRyx8s1lwgi8dKFLgYxahhKCLzgh6k1HTeyf7EQsD3bI52V7g+/egWtlj9SSt8V1jaMo2JFSnrqN0ycc+yZhtPl2ivaOkfNs+D2nWjaj1a89eqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LASecYw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5124C4CEEB
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749471488;
	bh=N5HC8dp2BLOSQIlPlssv0SUh1gbKqIKwm/bkQdTZEcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LASecYw1pYJ5V1tifjQny04wvzNb3i4hqhpZBEIuA9Qf4Bua7ZJVYw8vbVDTz9Vuq
	 lO1SwZ/vpoAHWzhq7jNYjIX6n7jXeYCQFRDLnmrjSc/syC6T3pJCGnIRPgTYxnyQ+b
	 4Ssw5i9S63EG52CIltwZmQkZ826ArscGYa8rhg1nYuOW2TO1B0b6/NO6YzwtT/Dp0g
	 iDKdwCLeiKu2xOSXvOb7IJpunCuIcqbBDtjqnqfZjU2BktNHBFhd806lKmPuEG9YSe
	 VislHK4jkU7Ozj7z+jee3qCI3PQH55HlwG8jtZaVTgoCxI6YIugpqGLC/aFcgoefrs
	 vhWylnGOnasdQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so3472169a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Jun 2025 05:18:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YyDHJG5xOLsUiGXt8kvzj76Ri0Cp++lUx5LPVgzKCaEewGaNoxm
	995Ia3PG+wdCcEN2IkIR13qVnYZczL2auSW9d4b6faVKhcj8znuJtiV5jYo0X2VqyI6HsVLSEQH
	AWNBk8XV3vf1XWbdjhsTKS6bw040KrjA=
X-Google-Smtp-Source: AGHT+IFio/FLYmowURrBa1uQjPCCPcFxrlZSB3BsRXTAYigA9I7uVnMu4vUXCYWKArp7QstFxSAAGPMOPbxPnVCquWM=
X-Received: by 2002:a17:907:fdc1:b0:ad2:313f:f550 with SMTP id
 a640c23a62f3a-ade1aa147d2mr1152040166b.29.1749471487387; Mon, 09 Jun 2025
 05:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e4811c2208b00be4b3206f24db6b81691b3de74e.1749467712.git.wqu@suse.com>
In-Reply-To: <e4811c2208b00be4b3206f24db6b81691b3de74e.1749467712.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Jun 2025 13:17:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5MXb0QK02o39HWFS4CHVJ2ybD9SX7njzQbPYjTm5G7NA@mail.gmail.com>
X-Gm-Features: AX0GCFvgVbAwcGDKY8-Kw8-6ngg8XE9ZFipwvk61WJeXIBm_aDcQpUU1Jau2Myc
Message-ID: <CAL3q7H5MXb0QK02o39HWFS4CHVJ2ybD9SX7njzQbPYjTm5G7NA@mail.gmail.com>
Subject: Re: [PATCH RESEND] btrfs: add extra warning when qgroup is marked inconsistent
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 12:16=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Unlike qgroup rescan, which always shows whether it cleared the
> inconsistent flag, we do not have a proper way to show if qgroup is
> marked inconsistent.
>
> This was not a big deal before as there aren't that many locations that
> can mark qgroup  inconsistent.
>
> But with the introduction of drop_subtree_threshold, qgroup can be
> marked inconsistent very frequently, especially for dropping large
> subvolume.
>
> Although most user space tools relying on qgroup should do their own
> checks and queue a rescan if needed, we have no idea when qgroup is
> marked inconsistent, and will be much harder to debug.
>
> So this patch will add an extra warning (btrfs_warn_rl()) when the
> qgroup flag is flipped into inconsistent for the first time.
>
> Combined with the existing qgroup rescan messages, it should provide
> some clues for debugging.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Pure resent, I thought it was already merged but it's not the case.
> It will be very helpful for debugging qgroup related problems caused by
> qgroup being marked inconsistent.
> ---
>  fs/btrfs/qgroup.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index a1afc549c404..45f587bd9ce6 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -350,6 +350,8 @@ static void qgroup_mark_inconsistent(struct btrfs_fs_=
info *fs_info)
>  {
>         if (btrfs_qgroup_mode(fs_info) =3D=3D BTRFS_QGROUP_MODE_SIMPLE)
>                 return;
> +       if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTE=
NT))
> +               btrfs_warn_rl(fs_info, "qgroup marked inconsistent");

About half the callers already log some message right before or right
after calling this function.
But this won't tell us much about why/where the qgroup was marked
inconsistent for all the other callers.

Perhaps we can pass a string to this function and include it in the
warning message? And then remove the logging from all callers that do
it.
Additionally turning this into a macro, and then printing __FILE__ and
__LINE__ too, would make it a lot more useful for debugging.

Thanks.



>         fs_info->qgroup_flags |=3D (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT=
 |
>                                   BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN=
 |
>                                   BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING=
);
> --
> 2.49.0
>
>

