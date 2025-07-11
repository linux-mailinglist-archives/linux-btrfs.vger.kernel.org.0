Return-Path: <linux-btrfs+bounces-15455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF158B0164D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D9717FF2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625120C023;
	Fri, 11 Jul 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/dOqXb2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FB1FBCAF
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222758; cv=none; b=qVSIMatFisgtznwbVJnXohJJF5ZozzD+51okb4bJAmsvPPvMrCU8m+oLUVtW6jiJKxemgO7d9UrSg2op8Ih/nIEG9xFK73tB1xtQtzX5+ZBTErKeOE9WMrj6DxrbhzxoVNACWwrYJlIER9A/l8lOao/fdFTdnfUtWxD7ixXBms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222758; c=relaxed/simple;
	bh=nbJf1/64IdjhIY6HZRyY1SIspuje6PKYaDCQZhkg5aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caAMEH1oI8BrgPPM7nPNRTDTooSYwEN/GbEDAPVtB4BX2rYPJW432k1FBgKSBGlNPYrSF7iQ1GxKuJzNDyNks41IhAj86pRoBSgLZOqfUSIyDLD7+ULR9PH0+RMUOafedRNS23bx97dgEUxejO7qKzojy5ELCT61z38+pFt/SA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/dOqXb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA58C4CEEF
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222758;
	bh=nbJf1/64IdjhIY6HZRyY1SIspuje6PKYaDCQZhkg5aY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a/dOqXb2/gOoQsPYrBKfDrvx3rkC8EBYtvIqn/Iwc9xYxTbfh45zlj1MCFSdqGwAc
	 cxuY5vaVWLyx16Jf4XGpX6RokTAnKYXMV2/Jql7azU3IOJ0qAkkziCQcBAUQ5D+fej
	 uzN5iT8JUBo4Li2HkRW/ekmYjBINsH4N1ub+/1IxgCM3N+oAAQ9pUT5uC63SiHyhoO
	 48y9JGrY4rw56Bdtoo8fhEjpPsuJVGxMAL0aW/x3JGAUvaOlNJzc+/lB4vwdAHH10L
	 J4QfwJRlPFIgmCns+pghtiPmcLbdvnJ0D+vYakb4ODMOkT/jYhrDKawg+B3d3IFjCp
	 kukHSQb3Jrtrg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0b6532345so529976166b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 01:32:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YycxMEzbDB1zEx4qm62DqnPypyz5URNyuwLnbxWD7as7dmB/dR8
	RGKuWjTKwg9aAyqR85+iwFa8TA/fumvdI3ZGAIxoMgmo2FWHwF7H4hbqrA1TQe72Mkjv5YAhoRg
	IZT6B6GYNHzMrAb6rooQm1ockEyWzsvY=
X-Google-Smtp-Source: AGHT+IFBWUFPYGxCZK7NyN9Xg3Ejrwpr935q8vOc+D2gJfJnyunQD6l1IPvH264XTw54BYTP86dm5VyrLR+6tnggEzk=
X-Received: by 2002:a17:907:1c27:b0:ae0:a7a1:593c with SMTP id
 a640c23a62f3a-ae6e24c5479mr622060266b.25.1752222757281; Fri, 11 Jul 2025
 01:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
 <1f074a1d-c423-4edf-a7ee-4642d3565759@gmx.com>
In-Reply-To: <1f074a1d-c423-4edf-a7ee-4642d3565759@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 11 Jul 2025 09:32:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Df1=p575hQb9bVDc_6my0KtJ4jmp86ybk41JYxL3L+A@mail.gmail.com>
X-Gm-Features: Ac12FXxnB38lYq081B3QNDZh_6-zuMKQRijfEeoagmDgbAASq9X9HsoWCktq4pc
Message-ID: <CAL3q7H7Df1=p575hQb9bVDc_6my0KtJ4jmp86ybk41JYxL3L+A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: set EXTENT_NORESERVE before range unlock in btrfs_truncate_block()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 8:47=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/7/9 17:56, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Set the EXTENT_NORESERVE bit in the io tree before unlocking the range =
so
> > that we can use the cached state and speedup the operation, since the
> > unlock operation releases the cached state.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
>
> > ---
> >   fs/btrfs/inode.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index d7a2ea7d121f..d060a64f8808 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -4999,11 +4999,12 @@ int btrfs_truncate_block(struct btrfs_inode *in=
ode, u64 offset, u64 start, u64 e
> >                                 block_end + 1 - block_start);
> >       btrfs_folio_set_dirty(fs_info, folio, block_start,
> >                             block_end + 1 - block_start);
> > -     btrfs_unlock_extent(io_tree, block_start, block_end, &cached_stat=
e);
> >
> >       if (only_release_metadata)
> >               btrfs_set_extent_bit(&inode->io_tree, block_start, block_=
end,
> > -                                  EXTENT_NORESERVE, NULL);
> > +                                  EXTENT_NORESERVE, &cached_state);
> > +
> > +     btrfs_unlock_extent(io_tree, block_start, block_end, &cached_stat=
e);
>
> Feel free to use the same cached_state for fallback_to_cow(), which is
> calling btrfs_clear_extent_bits(), which doesn't benefit from the cached
> state.

Ah indeed, sent here:

https://lore.kernel.org/linux-btrfs/db0dd3c800bc997511aa800e0b90616ca7b8b4b=
5.1752222571.git.fdmanana@suse.com/

Thanks.
>
> That's the only other location where I can find an extent bit operation
> after extent unlock.
>
> Thanks,
> Qu
>
> >
> >   out_unlock:
> >       if (ret) {
>

