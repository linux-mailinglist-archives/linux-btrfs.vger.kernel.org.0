Return-Path: <linux-btrfs+bounces-12658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4878A75005
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 19:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDEC3BAAEA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4301DE89C;
	Fri, 28 Mar 2025 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjYlHaUN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9731DA10C
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184682; cv=none; b=ZOjWAutAzKmd8c90wOh3YU2tmG3o8Y7lIP7kJwnRuxg04jJr4AWPub9fwNZem1n+YbymeJNxRDJewj2AszewDUEksNyJP9X+igtRXux6tuA/wp4stfa1ozDHr3nkjfk+kvkWLyJ3SLR8F84NWBLtNkGTOIvbADurMbF9hDj4miU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184682; c=relaxed/simple;
	bh=+uZHNs8bHyN0ctflQu2Jy7gfGRnTcYNKWAmCje5RNU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUJSqtqtIJhrW/Z32bm/CJBLmTloMVWjfhHkf5cfU6B7v+2rT8UUEFhBGDN53Vyr582wFNoYpKgzv5dQf6mLibzrGaJir7LuaWvt2LuGa+KwklkZqXOdIk+TpfKYR0T9W2E4AeNuDZG41PYXQ9jX2ySnqQ08LYzSja5iYVPcLkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjYlHaUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B579C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743184681;
	bh=+uZHNs8bHyN0ctflQu2Jy7gfGRnTcYNKWAmCje5RNU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XjYlHaUN6zNp9SOnyCFs3p8OH2WQ9JIyGT1wzgLhQ31WVcs50pR3PngZPMBYE1qRS
	 BuU3TkYOo2s+pqwW4bHdhB6OKLC5Z18Gt0pFK0CNKUUMsZpADfI2JsypAHl6vdzVmr
	 0g3TChoXcQ5FtZnN5ePAg2J1hkp/ujiinzkrDpOa/j1gB9xPEvtsuQjqpkn7YrBMfB
	 EPH2EGH2cqd+UBC9+B5s/wGCKB3eT9ReVB9mnqXBJi3iRZZKFMeYEP1JgU379D4ISQ
	 zs3ZH2eswbdevkJ9/DMEfr/MeSBcSwtse22GUjRqnQAaDXqA25L6PQUpdg3BJO/fxU
	 n4Uf1HRSB5PRw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab78e6edb99so310439066b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 10:58:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YxvrUkR9wAIxcF6d66JJ52sSt/+9aSm7bMO8A21vI9M7/Ft+fEI
	zA8cAuQoly3L8L+hF5N30TEZHSekbzQ6gJ7zcxGJ5r74trCQnkzCE2id9HsETMJrEBQ+sWQS5rq
	vXLW9j6fVu9qc3mgJVcg7AxaLODU=
X-Google-Smtp-Source: AGHT+IE0h5b6E3SwjFQ2io3Ea1mCmqKRAqePE30jba6dfpHxCwIt6PWXlHCLN+AXYZLUL0e9nQ1xLj072CcYcYncTms=
X-Received: by 2002:a17:907:9693:b0:ab7:6fa9:b0a9 with SMTP id
 a640c23a62f3a-ac73895f72dmr11814366b.11.1743184679943; Fri, 28 Mar 2025
 10:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743113694.git.wqu@suse.com> <64d8a34bed1360c4771ead6a66e3c6df0ab86a7f.1743113694.git.wqu@suse.com>
In-Reply-To: <64d8a34bed1360c4771ead6a66e3c6df0ab86a7f.1743113694.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Mar 2025 17:57:22 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4hxQbKfcuW+hPEFkiJk3KX9bRzNbjLms+Z1z_U=9PNPw@mail.gmail.com>
X-Gm-Features: AQ5f1JqULwmweW4IbYz7_EoKMGhd234_45JEiWbZoT1pGqbBei1widuAF8xjTLw
Message-ID: <CAL3q7H4hxQbKfcuW+hPEFkiJk3KX9bRzNbjLms+Z1z_U=9PNPw@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: prepare btrfs_punch_hole_lock_range() for
 large data folios
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 10:33=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> The function btrfs_punch_hole_lock_range() needs to make sure there is
> no other folio in the range, thus it goes with filemap_range_has_page(),
> which works pretty fine.
>
> But if we have large folios, under the following case
> filemap_range_has_page() will always return true, forcing
> btrfs_punch_hole_lock_range() to do a very time consuming busy loop:
>
>         start                            end
>         |                                |
>   |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
>    \         /                         \   /
>     Folio A                            Folio B
>
> In above case, folio A and B contains our start/end index, and there is

contains -> contain
index -> indexes
there is -> there are

> no other folios in the range.
> Thus there is no other folios and we do not need to retry inside

is -> are.

"Thus there is no other folios" is repeated from the previous
sentence, so it can be just:

Thus we do not need to retry inside...

> btrfs_punch_hole_lock_range().
>
> To prepare for large data folios, introduce a helper,
> check_range_has_page(), which will:
>
> - Grab all the folios inside the range
>
> - Skip any large folios that covers the start and end index

covers -> cover
index -> indexes

>
> - If any other folios is found return true

is found -> are found

>
> - Otherwise return false
>
> This new helper is going to handle both large folios and regular ones.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 5d10ae321687..417c90ffc6fa 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2157,6 +2157,54 @@ static int find_first_non_hole(struct btrfs_inode =
*inode, u64 *start, u64 *len)
>         return ret;
>  }
>
> +/*
> + * The helper to check if there is no folio in the range.
> + *
> + * We can not utilized filemap_range_has_page() in a filemap with large =
folios
> + * as we can hit the following false postive:

 postive -> positive

> + *
> + *        start                            end
> + *        |                                |
> + *  |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
> + *   \         /                         \   /
> + *    Folio A                            Folio B
> + *
> + * That large folio A and B covers the start and end index.

covers -> cover
index -> indexes

Anyway, those are minor things, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.



> + * In that case filemap_range_has_page() will always return true, but th=
e above
> + * case is fine for btrfs_punch_hole_lock_range() usage.
> + *
> + * So here we only ensure that no other folio is in the range, excluding=
 the
> + * head/tail large folio.
> + */
> +static bool check_range_has_page(struct inode *inode, u64 start, u64 end=
)
> +{
> +       struct folio_batch fbatch;
> +       bool ret =3D false;
> +       const pgoff_t start_index =3D start >> PAGE_SHIFT;
> +       const pgoff_t end_index =3D end >> PAGE_SHIFT;
> +       pgoff_t tmp =3D start_index;
> +       int found_folios;
> +
> +       folio_batch_init(&fbatch);
> +       found_folios =3D filemap_get_folios(inode->i_mapping, &tmp, end_i=
ndex,
> +                                         &fbatch);
> +       for (int i =3D 0; i < found_folios; i++) {
> +               struct folio *folio =3D fbatch.folios[i];
> +
> +               /* A large folio begins before the start. Not a target. *=
/
> +               if (folio->index < start_index)
> +                       continue;
> +               /* A large folio extends beyond the end. Not a target. */
> +               if (folio->index + folio_nr_pages(folio) > end_index)
> +                       continue;
> +               /* A folio doesn't cover the head/tail index. Found a tar=
get. */
> +               ret =3D true;
> +               break;
> +       }
> +       folio_batch_release(&fbatch);
> +       return ret;
> +}
> +
>  static void btrfs_punch_hole_lock_range(struct inode *inode,
>                                         const u64 lockstart,
>                                         const u64 lockend,
> @@ -2188,8 +2236,7 @@ static void btrfs_punch_hole_lock_range(struct inod=
e *inode,
>                  * locking the range check if we have pages in the range,=
 and if
>                  * we do, unlock the range and retry.
>                  */
> -               if (!filemap_range_has_page(inode->i_mapping, page_lockst=
art,
> -                                           page_lockend))
> +               if (!check_range_has_page(inode, page_lockstart, page_loc=
kend))
>                         break;
>
>                 unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, locken=
d,
> --
> 2.49.0
>
>

