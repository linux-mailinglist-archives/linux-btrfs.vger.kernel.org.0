Return-Path: <linux-btrfs+bounces-12655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E0A74F9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 18:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B463AA634
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417841DC9AD;
	Fri, 28 Mar 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/VKgnnr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894148F5B
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183457; cv=none; b=J1/U78wINqSA0F3nShbJIotwJYgjgAnwWvphx3rJnjOlEBcsimzCuxuc8mjTbaVse4rqpq4EsdCFRs+iS09Dgob8TD66XTV6MeK1DiS9VX4EQPpQ90eOW0F1BFo5KSvxzz9AVlYIctzaInUowvofLqWqWxtpFxeHf3wbxvpP4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183457; c=relaxed/simple;
	bh=xD5kXaJ0mpfjAfbqu00QVFtSCYeUJEFVNdci+2NiAxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8g4sboQklGqtkwTjtWFUK4P+y7c9eMwg+7UXQlA3c2R5xO0+0cCG3L3zXRVCQwz1tvkdNjzg6CQ9Z3ZaE3iWwSfd9MsgXuamvPeOyEUpNtvseniH83XgwBarqM+Dk4ZezNH/4zotf4DCT70EJf36ukIs64jkUPGCEfGdylSfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/VKgnnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F137AC4CEE9
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743183457;
	bh=xD5kXaJ0mpfjAfbqu00QVFtSCYeUJEFVNdci+2NiAxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r/VKgnnrSCzIbEg/6spjH0KdsY9wWRuBeoJVGx7+6GqYxYUv4byjF/rWIufsQQjs+
	 akV4+kihIrxZT5O6cJFic4vM3vbxOMvF9W8KKpH9lPiDp+TH/CZ+ahNl2oEXKiFgdF
	 TaE5cm8YcRFaXjfDROyEsbj3f9nLF+QkoCcdSzU5OpEU7euX3ifUulmHMUdVE8JhJg
	 bMnhd6RaCbvxZegydVrOIbchI1awNGdniq0J1dNVPAsFwubp7K+UeLLlrcU8z85mj7
	 zP2N9L/CROKiRUdgSAAj6F9m3QdVQsHLiKcqmMgBU1cuzI9FOX8RqJkAFl92ystmH8
	 +Z7o5Ny2UedAg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso367234566b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 10:37:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy5uyfp1OKSENjVBFPB58pzA7Uhiic84CZXaH8xFrTmTEdIfrSJ
	9w12hVE1Mno8cj8WCILuD5q4fPsJi6SwloUAxVVqzBjcTIgoaEIkh6U2GYZn0rbyFGrDSu1bHfY
	81VfKYHg5sD1ojFh9EZ+NnN0SMCI=
X-Google-Smtp-Source: AGHT+IGJqZCkhBh9uWvYq0abddwymGkfYMav1dgkcpualH9nAQz8G3MncwJkz1tU7ctXyZaYAcX15cPhSTpVJPu6T70=
X-Received: by 2002:a17:907:868a:b0:ac3:ad7b:5618 with SMTP id
 a640c23a62f3a-ac7389e6750mr1493166b.3.1743183455495; Fri, 28 Mar 2025
 10:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743113694.git.wqu@suse.com> <428b3c09f6df2820865640e2cf91a7cc0c1b4119.1743113694.git.wqu@suse.com>
In-Reply-To: <428b3c09f6df2820865640e2cf91a7cc0c1b4119.1743113694.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Mar 2025 17:36:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6MMhKLBOyWVd-7nxXBH_3=e2HJndEc1ea8RDT9A8ysTQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoSl5zaWV72blSgm4kN8XQOstqQmRGyYUx9PlxNC1J2MPL_OhacRF9zSDE
Message-ID: <CAL3q7H6MMhKLBOyWVd-7nxXBH_3=e2HJndEc1ea8RDT9A8ysTQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: subpage: fix a bug that blocks large folios
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 10:33=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Inside the macro, subpage_calc_start_bit(), we needs to calculate the
> offset to the beginning of the folio.
>
> But we're using offset_in_page(), on systems with 4K page size and 4K fs
> block size, this means we will always return offset 0 for a large folio,
> causing all kinds of errors.
>
> Fix it by using offset_in_folio() instead.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/subpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 5b69c447fec9..5fbdd977121e 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -202,7 +202,7 @@ static void btrfs_subpage_assert(const struct btrfs_f=
s_info *fs_info,
>                            btrfs_blocks_per_folio(fs_info, folio);      \
>                                                                         \
>         btrfs_subpage_assert(fs_info, folio, start, len);               \
> -       __start_bit =3D offset_in_page(start) >> fs_info->sectorsize_bits=
; \
> +       __start_bit =3D offset_in_folio(folio, start) >> fs_info->sectors=
ize_bits; \
>         __start_bit +=3D blocks_per_folio * btrfs_bitmap_nr_##name;      =
 \
>         __start_bit;                                                    \
>  })
> --
> 2.49.0
>
>

