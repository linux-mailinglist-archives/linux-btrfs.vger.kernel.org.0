Return-Path: <linux-btrfs+bounces-1515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1383049E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 12:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB511C2163F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6391DFC6;
	Wed, 17 Jan 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhw0PQ2W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AB1DDE9
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491400; cv=none; b=U4ciHVWxqfbHh3iwrKmNSCtqbKJHqfLuDjS8eG0/hpDPUheQyoE30WYFMUPzafkpk6p4SIPKwe1Hd8YemI2FE/3N3dTXAjaKLXY7JBO/dkDSA9+pm288jFQaFD6xwfY4t4ukCsBDwTu2NgNZiTZfaWi+B2a2EhFMlpZ+s859xMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491400; c=relaxed/simple;
	bh=HyB+zrnwyGO7/VW5ER4nZow+O1fSAf5UIpb6bp+pv/4=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=sMxTxT0imc8hhjBYfEKb6bxfbXB1HpzGzaLmUombP7C3DWbn5hMLuwg4GKDhH2so6FFspCGU8wS6f9Bp+HczrNkKl9y6e+DKZkMtlG1s4S+S6D/jG6xz9AnePluEK7i+hYvAFaTiy1ZjsS/wi/V/vNTeqKcN7xHeb0gNgClqPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhw0PQ2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC211C433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705491399;
	bh=HyB+zrnwyGO7/VW5ER4nZow+O1fSAf5UIpb6bp+pv/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uhw0PQ2WgNiICDjp0lUfOKGl3LjXWQkUexZXBA00S2RkU3WI9y0S3uS8B5deKLCTj
	 3Ei1wVgYXx2sBpybNiQ2xX6W+N1fpowO2O6PvL6CEtW8CMb/yqoxLqrOIOeElkDURC
	 GpIVC/YzrnOVl00nhqv3zg8cCrdQ/11Lln3yP2LpoxRur8auWi7gCyXDbK2rPemdUL
	 5L9ViIFAdAhpJDZoQ/gN2chQO6rLI3wOFU6lI1ZwEbMw0sjRT5nRxU0Sp9W3jH+9+d
	 sVk60BDsJCS83CAlEtlp/TpCTRqF1EVUwUVDYPVOG92OLODEO6v//3BGzKeDBQ1fc2
	 lPBK1OSViebkg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2dc7827a97so371649866b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 03:36:39 -0800 (PST)
X-Gm-Message-State: AOJu0YxNl0EZS2XFDp2mNjzRFzmoCFmNyDxBTGKoFPTosFeAU+pAxjTt
	6tKNyHhs53Felv5dUiMbb99ZL6LOch8WYQq4lNc=
X-Google-Smtp-Source: AGHT+IG9Hr2jO7PmcHpZYm9a/Me5ndYeqm44rCv9t/eCiBFVMPTuG/Cc9gvQKd/Xnp5Gm0BvxnHKSqlNUOySezxar8c=
X-Received: by 2002:a17:906:784f:b0:a28:e1a1:ca79 with SMTP id
 p15-20020a170906784f00b00a28e1a1ca79mr3838360ejm.88.1705491398249; Wed, 17
 Jan 2024 03:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <022e1767f333e36d22e0c6f859334ae9433e42a4.1705487315.git.johannes.thumshirn@wdc.com>
In-Reply-To: <022e1767f333e36d22e0c6f859334ae9433e42a4.1705487315.git.johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Jan 2024 11:36:01 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7sTX2jsguSZtZ9XwtPEsCyegXO22E3Y6j=qLg=UnoJCg@mail.gmail.com>
Message-ID: <CAL3q7H7sTX2jsguSZtZ9XwtPEsCyegXO22E3Y6j=qLg=UnoJCg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove duplicate recording of physical address
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:34=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Remove the duplicate physical recording of the original write physical
> address in case of a single device write.
>
> This duplicated code is most likely present due to a rebase error.
>
> Fixes: 02c372e1f016e ("btrfs: add support for inserting raid stripe exten=
ts")

The Fixes tag is meant to be used for bug fixes or significant
performance regressions,
but this is just removing a redundant piece of code that doesn't cause
any of those problems.
With such a tag, an unnecessary stable backport will happen automatically.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Anyway, apart from the unnecessary tag, it looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/bio.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 928f512cdb4a..2d20215548db 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -509,8 +509,6 @@ static void __btrfs_submit_bio(struct bio *bio, struc=
t btrfs_io_context *bioc,
>         if (!bioc) {
>                 /* Single mirror read/write fast path. */
>                 btrfs_bio(bio)->mirror_num =3D mirror_num;
> -               if (bio_op(bio) !=3D REQ_OP_READ)
> -                       btrfs_bio(bio)->orig_physical =3D smap->physical;
>                 bio->bi_iter.bi_sector =3D smap->physical >> SECTOR_SHIFT=
;
>                 if (bio_op(bio) !=3D REQ_OP_READ)
>                         btrfs_bio(bio)->orig_physical =3D smap->physical;
> --
> 2.43.0
>
>

