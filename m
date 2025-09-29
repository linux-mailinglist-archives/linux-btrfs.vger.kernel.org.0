Return-Path: <linux-btrfs+bounces-17246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1BBA8670
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 10:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1593B47D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 08:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A476E23183F;
	Mon, 29 Sep 2025 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUc3fbdE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EE5220F20
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134674; cv=none; b=TQPqhzvRQeSiBGbpbQY6WbD5aZN0ZGMMt31yjaRJJxn2r/bbGjgvY0EyJUc4LZaEL+1+MGyUziFLuUJwzYXvtscD3+x6qsoEv8wHM2YD4kPyippjceIaFCpFaI8s7POqrL01bGFYTtDtQV/f52sr+eHSOSgyDmDpvTw847CFuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134674; c=relaxed/simple;
	bh=72QNnRwBTw3Zt4lBF90vKIZJQp1HTkQPyaID/Nw+AiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTmDjclGjl3WlEmW0kFaC5d31HQumfrokWAeomRG6SL5FogzzMlPSy5ZW/Inv085QYGHHLkrnwUZnTxQM0DYWaeod8LJL7hfYiozV0PGrEQdzjsv+h1S0bGRyarC20QL1GVjlCpwm2WSyuQn+zxeGYI0h16JX1lLcyjC4kKa7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUc3fbdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6467AC4CEF5
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 08:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759134674;
	bh=72QNnRwBTw3Zt4lBF90vKIZJQp1HTkQPyaID/Nw+AiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tUc3fbdEQ5klnjIVCAlunuh+Q2Eg6L1XF8sV2/wAt0/FWSSFxf2AVVrbHnofQRdS2
	 P2Cf4g+YDGhLEOxnxSG4VQrGyN9wQHDmGkBzZ7FtjoKpC9HaSezb/c2A2rXSW3G0YT
	 TNjnHyKF7HLImTReJ5d0hIsd76OaI2O6QKzGmLpAn6TjB1whDP7vTdQb4L0+tI0mnr
	 095d+8kbPMqHzGdoYaQji6cFcCJKeine6ymLrxZIBtbcP1++LxJV7XPIcGP57sVaJy
	 DPnpo0MVLt4U5fTl9YSX4kA4pe1RUB3mDxbMflCdBQT8dFzZwbw5/W0bNll+xhSJoH
	 5+SL/7L0m1EFQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3d50882cc2so216927266b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 01:31:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YykWFJ6s1I7t+K2fGNsIRt5k00UOweL/ZNjs939UTkSZrQ9bbLB
	7JfyQ7HzvpY/Wv0Ih2Qy9tscSmxZc0HFf4Prf8YWn46ahHAl+v9YGlgjt/nIYwfmNZpbL3Mcsp/
	AZQ9cmnrWJ/LTYFfkcQNRKqY2ZiMqBuQ=
X-Google-Smtp-Source: AGHT+IGcbThzXzn8marcT/BFCMXoDmLAfAYDHrDEssxEsbBTUI4CLZq1aF0JV2XpM/3RFxd+tijK7/gyxmGwpgRK4oo=
X-Received: by 2002:a17:907:2d24:b0:b04:5e64:d7cd with SMTP id
 a640c23a62f3a-b34bb419ffbmr1896747366b.46.1759134672920; Mon, 29 Sep 2025
 01:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929065802.2748-1-sunk67188@gmail.com>
In-Reply-To: <20250929065802.2748-1-sunk67188@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 29 Sep 2025 09:30:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5OvZrFZDzhds98vwLNXO1ttWjJVajCwQRhPHmt+dDJCQ@mail.gmail.com>
X-Gm-Features: AS18NWBfg6YF1UwZwUplwXJ_DtIdN53veGhUcEux20bhj_oTWizxEA5KDbv7TN8
Message-ID: <CAL3q7H5OvZrFZDzhds98vwLNXO1ttWjJVajCwQRhPHmt+dDJCQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reorganize error handling in btrfs_tree_mod_log_insert_key
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:31=E2=80=AFAM Sun YangKai <sunk67188@gmail.com> w=
rote:
>
> Restructure the error handling flow in btrfs_tree_mod_log_insert_key
> to address memory allocation failures more cleanly.
>
> No functional changes are made - this is purely a code readability
> improvement.
>
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/tree-mod-log.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> index 9e8cb3b7c064..4fd7859ad7dc 100644
> --- a/fs/btrfs/tree-mod-log.c
> +++ b/fs/btrfs/tree-mod-log.c
> @@ -267,9 +267,8 @@ int btrfs_tree_mod_log_insert_key(const struct extent=
_buffer *eb, int slot,
>         if (!tree_mod_need_log(eb->fs_info, eb))
>                 return 0;
>
> +       /* Allocation error is handled later. */
>         tm =3D alloc_tree_mod_elem(eb, slot, op);
> -       if (!tm)
> -               ret =3D -ENOMEM;

I prefer the current way we do things.
First it's less confusing to see some action right after the memory
allocation, rather than much later like this patch proposes.

>
>         if (tree_mod_dont_log(eb->fs_info, eb)) {
>                 kfree(tm);
> @@ -278,16 +277,14 @@ int btrfs_tree_mod_log_insert_key(const struct exte=
nt_buffer *eb, int slot,
>                  * need to log.
>                  */
>                 return 0;
> -       } else if (ret !=3D 0) {
> -               /*
> -                * We previously failed to allocate memory and we need to=
 log,
> -                * so we have to fail.
> -                */
> -               goto out_unlock;

Second, having this check and comment here makes it very explicit when
the memory allocation is a problem.

>         }
>
> -       ret =3D tree_mod_log_insert(eb->fs_info, tm);
> -out_unlock:
> +       /* Deal with allocation error. */

This is a useless comment... The existing comment is much more helpful
and the fact that's in the else statement above, makes it easier to
grok.

I also wonder why you picked only this function, since this pattern is
followed in several other functions...

Not a fan of the proposed change.

> +       if (tm)
> +               ret =3D tree_mod_log_insert(eb->fs_info, tm);
> +       else
> +               ret =3D -ENOMEM;
> +
>         write_unlock(&eb->fs_info->tree_mod_log_lock);
>         if (ret)
>                 kfree(tm);
> --
> 2.51.0
>
>

