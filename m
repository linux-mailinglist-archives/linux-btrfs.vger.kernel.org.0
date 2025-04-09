Return-Path: <linux-btrfs+bounces-12906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3BA82140
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AC04678A4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCA125D8F0;
	Wed,  9 Apr 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi1Gt42H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AF25522F;
	Wed,  9 Apr 2025 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191948; cv=none; b=keSlLKMPUTE4S0EOswwo478jeBiFlUn8rplFylI7kWVMtb4Og8MKX4x3xbLb7SgKKfSbXjtqkdQJ2scVzbXZNsT+9RXsQHOtAfR/rinIwrJJPMWb491ENiP8eRaVpE2FWc/aSR1ylJ02R/Uc/ZgopgQwDfcrqF/R5RA7AEIOa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191948; c=relaxed/simple;
	bh=U7X30dmS1Fsg8OD383bJkqAVWwjWEApCOe5B+eDDT74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAYa/VlA2/cpvbLpSOrf6qeCFLSl14jTvOyCMf8afPg0kSgAs2XC2lVBWPPSZRhc5t7p7mT/1dDZVieWv3hoxcORFbZgH/2woWjEMOHXaKBw/MUEt6qct75udHQEWc7xtbDzA0oARUMzsEmZn4byuqL7FepoolLhN8fWrCJeuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi1Gt42H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201F1C4CEEC;
	Wed,  9 Apr 2025 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744191948;
	bh=U7X30dmS1Fsg8OD383bJkqAVWwjWEApCOe5B+eDDT74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mi1Gt42HsmQjtXUxbADreN46HyTc+Cm3YU7Umphm8Irmc/RXs4qWjbzJ2BwVuSRGp
	 PWrnwJYNLAeeK/77weHVm7YIG9Z88l1ZQbBkwZlvJ09GsA2HC91/SpBknq86yRSZz3
	 FZPhg38lCa+jcpYet1K9H8tW5w5acXWr28bWwWeWTLDd4e0lNCa1yZcWlirVFqvxXu
	 Cr7NRy28Xib0lRqifgsVNhfltA8iI3c6P81UagBNl5yVCUfBMgd6jWVnZOVW7ZDcEl
	 e5jinigYR6ZoPYRgOv2p+9OHLqLvBj5LjKrr/0JwXiQ7+mgZYlFzQ2hQvy3mxctAuD
	 PKYg+lWlVoGMA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac3b12e8518so1193846066b.0;
        Wed, 09 Apr 2025 02:45:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR2qtW9Pbunmowe1ZiaaG5ysZw7mabm7vzDxkbnE5ZgMkXwOIM9UCnjGkazwG/wg5B/SEaje/FMz2KAH/U@vger.kernel.org, AJvYcCX7jKFXtZJWlgw5CLb6TEaN4h0P+n9Kddpr/Qpcg//QKWwfqDy3/WIVFJF39NCnhcO8yYlqFQj1hgNRgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrB3D2VSzRMMHwgADGtR11wcSKSLFSowANNuHBsCpMwfKgLt8
	u1f5b3zrlGrPeoDkeXlRMelBYz5T9SsD5iraxCgpAop5wMjKPhBTzNWsHaNtJjCT57O7RFQMq6n
	zMiC/aZGh4oDuHAF/zRQTPykqw94=
X-Google-Smtp-Source: AGHT+IG8iVTaKGJydkJy62ivtt+8m9F1Rw+6YluVf0P9U4TepkF99CocRhQfZ1VIdmnaLGWs1tNyo/pneweaUOh4Eao=
X-Received: by 2002:a17:906:4fcc:b0:ac7:6222:4869 with SMTP id
 a640c23a62f3a-aca9d6f4aaamr149043966b.37.1744191946668; Wed, 09 Apr 2025
 02:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <20250408224749.GD13292@twin.jikos.cz>
In-Reply-To: <20250408224749.GD13292@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Apr 2025 10:45:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6sYN_nmqwJb861qm08Fb5hBr_4QrxJCzeq6Quwh04bjA@mail.gmail.com>
X-Gm-Features: ATxdqUGDRMWD7iTqMUuJo2rKdKpU9xkiE-BQebVMAV6ihrJKizLPNzex5SJ3EbI
Message-ID: <CAL3q7H6sYN_nmqwJb861qm08Fb5hBr_4QrxJCzeq6Quwh04bjA@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: use BTRFS_PATH_AUTO_FREE in insert_balance_item()
To: dsterba@suse.cz
Cc: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 11:50=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Apr 08, 2025 at 06:29:30AM -0600, Yangtao Li wrote:
> > All cleanup paths lead to btrfs_path_free so we can define path with th=
e
> > automatic free callback.
> >
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  fs/btrfs/volumes.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index c8c21c55be53..a962efaec4ea 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3730,7 +3730,7 @@ static int insert_balance_item(struct btrfs_fs_in=
fo *fs_info,
> >       struct btrfs_trans_handle *trans;
> >       struct btrfs_balance_item *item;
> >       struct btrfs_disk_balance_args disk_bargs;
> > -     struct btrfs_path *path;
> > +     BTRFS_PATH_AUTO_FREE(path);
> >       struct extent_buffer *leaf;
> >       struct btrfs_key key;
> >       int ret, err;
> > @@ -3740,10 +3740,8 @@ static int insert_balance_item(struct btrfs_fs_i=
nfo *fs_info,
> >               return -ENOMEM;
> >
> >       trans =3D btrfs_start_transaction(root, 0);
> > -     if (IS_ERR(trans)) {
> > -             btrfs_free_path(path);
> > +     if (IS_ERR(trans))
> >               return PTR_ERR(trans);
> > -     }
> >
> >       key.objectid =3D BTRFS_BALANCE_OBJECTID;
> >       key.type =3D BTRFS_TEMPORARY_ITEM_KEY;
> > @@ -3767,7 +3765,6 @@ static int insert_balance_item(struct btrfs_fs_in=
fo *fs_info,
> >       btrfs_set_balance_sys(leaf, item, &disk_bargs);
> >       btrfs_set_balance_flags(leaf, item, bctl->flags);
> >  out:
> > -     btrfs_free_path(path);
>
> The pattern where btrfs_free_path() is not called at the end and is
> followed by other code is probably not worth converting. It would be
> possible to replace it by
>
>         btrfs_release_path(path);
>         path =3D NULL;

Should be btrfs_free_path() instead, otherwise it leaks memory.
Or just do the release without setting the path to NULL and leaving
the path auto free.

>
> that drops the locks and refs from the path but this does not save us
> much compared to the straightforward BTRFS_PATH_AUTO_FREE() conversions.
> Also release will still keep the object allocated although we don't need
> it. As a principle, resources, locks and critical sections should be as
> short as possible.
>
> Unfortunatelly I've probably fished all the trivial and almost-trivial
> conversions, we don't want 100% use of BTRFS_PATH_AUTO_FREE(), only when
> it improves the code.
>
> You may still find cases worth converting, the typical pattern is
> btrfs_path_alloc() somewhere near top of the function and
> btrfs_free_path() called right before a return.
>

