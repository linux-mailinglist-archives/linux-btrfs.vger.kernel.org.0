Return-Path: <linux-btrfs+bounces-12141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CA3A59528
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 13:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD4116D3A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C71E4BE;
	Mon, 10 Mar 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMdANTgX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37989225416
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611161; cv=none; b=hYe4tOpCYuCtqU/KctsYOpJvmaMpT0x2wcNiUrxaUjbfu+L65o6yyPW2W4pbyLyTr13tmFiQl09AyzNVvQx6k2tCukNVhoY4Rm1IJLAUJAp5II12jI8T3128SYKlLNKC+qOjWOuzL8Y7b8dRf3gwbeYknY+HjSnKZsOYLFZHDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611161; c=relaxed/simple;
	bh=GY1F4BubLjcbbEc0gcQ9Vxa+Zw/EMUI+VkTjpm0z470=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUtZu+YDyLIue7RwYnl0+T/7DTalCYuVKztx4I92VZ2ea5vvBmZHWnu+DD2vDWbLn+OH2CyCisHITlZ4q4TAeIuwsmQF8vUVE6VHAGgzm2Q1+xiTKtxCE9814uuJ6qE3xBE+K5u57nqgYSM1wvgrOpxIm1lWpUh59V90xo/AvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMdANTgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF81C4AF0B
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 12:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741611159;
	bh=GY1F4BubLjcbbEc0gcQ9Vxa+Zw/EMUI+VkTjpm0z470=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qMdANTgXn+WwEn1oYp1C526HZ+MTWjmeoCZizwJmMTNr+xK13IQEobvMGAuPw7q39
	 fumPWaVv+MuxlSsSp+baZ+TXv6ptEkuAeD7yImkJkavLUaJmrPVnI/Zf1dJtbFFWis
	 hdR7S3Zcg1GL4rSAd9FEndLf6XokCHvTVfOUKiN1jRxRODtlv69wc6scNzS5j+rL7e
	 ot08TQrWzaValoGp20a+66JqppjhQ8kzOOb4RiNPE1RBbEe9FcYVkWJabQxvf5EB/K
	 TsOYVBC40sQThaiZl8qJCRbjBusuCpN5uWOwHivLJfB1aV4P2R6SDbm/jteO6sHTlH
	 NcfN1b56+BnEA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso123284266b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 05:52:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwuqY4Ey0bIIkFwW3e4KsTkEOqhDo9ZYa5FNm1GnYUgRMajZpuW
	H6+Ue8ckuCdBbOLZGaYaguSgfsSahjyEb5Ki2BfCtJAjmo9JiWYpzkezAGLcO9zL6rzmIiwClbl
	3Zq8uLuEXKZ9GuR6S/1/wb8P60sQ=
X-Google-Smtp-Source: AGHT+IHDNE4YPB+YvfMbZ+Wv4M5FT/ZqEAXUE1PIBcO4uiL/n3Z/7IGOe7kR4K5uLyUzibATSvKI1OIwuceOepIFQCM=
X-Received: by 2002:a17:907:d27:b0:ac2:9210:d966 with SMTP id
 a640c23a62f3a-ac29210e1a7mr627788966b.48.1741611158210; Mon, 10 Mar 2025
 05:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741306938.git.boris@bur.io> <817581cbc85cfda4c2232fecbfdb6b615b7067ca.1741306938.git.boris@bur.io>
 <CAL3q7H75p9GUAav64pvTZf4SVpQ=rbcVHAuo5zUEeAytkxXkYA@mail.gmail.com> <20250307214040.GC3554015@zen.localdomain>
In-Reply-To: <20250307214040.GC3554015@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 10 Mar 2025 12:52:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7UyqVzyTjSzuMD3-u_GRJrx+HxjQPE63p_isrnPc=ugA@mail.gmail.com>
X-Gm-Features: AQ5f1JrWs5LT_7hB6G_Umye-mH-Brb5WzYU1U341Iyq9qmEy3at9leS5yIAqgP4
Message-ID: <CAL3q7H7UyqVzyTjSzuMD3-u_GRJrx+HxjQPE63p_isrnPc=ugA@mail.gmail.com>
Subject: Re: [PATCH 4/5] btrfs: explicitly ref count block_group on new_bgs list
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 9:39=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Mar 07, 2025 at 02:37:28PM +0000, Filipe Manana wrote:
> > On Fri, Mar 7, 2025 at 12:31=E2=80=AFAM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > All other users of the bg_list list_head inc the refcount when adding=
 to
> > > a list and dec it when deleting from the list. Just for the sake of
> > > uniformity and to try to avoid refcounting bugs, do it for this list =
as
> > > well.
> >
> > Please add a note that the reason why it's not ref counted is because
> > the list of new block groups belongs to a transaction handle, which is
> > local and therefore no other tasks can access it.
> >
>
> Just to make sure, I understand you correctly: you'd like me to add this
> as a historical note to the commit message? Happy to do so if that's what
> you mean.

Yes, that's what I meant.

>
> Otherwise, I'm confused about your intent. If you are saying that it's
> better to not refcount it, then we can drop this patch, it's not a fix,
> just another "try to establish invariants" kinda thing.

Was just saying it's not needed due to being a local list and we can
detect if the block group is in that list with the
BLOCK_GROUP_FLAG_NEW flag.

>
> > >
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/block-group.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index 2db1497b58d9..e4071897c9a8 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -2801,6 +2801,7 @@ void btrfs_create_pending_block_groups(struct b=
trfs_trans_handle *trans)
> > >                 spin_lock(&fs_info->unused_bgs_lock);
> > >                 list_del_init(&block_group->bg_list);
> > >                 clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime=
_flags);
> > > +               btrfs_put_block_group(block_group);
> > >                 spin_unlock(&fs_info->unused_bgs_lock);
> > >
> > >                 /*
> > > @@ -2939,6 +2940,7 @@ struct btrfs_block_group *btrfs_make_block_grou=
p(struct btrfs_trans_handle *tran
> > >         }
> > >  #endif
> > >
> > > +       btrfs_get_block_group(cache);
> > >         list_add_tail(&cache->bg_list, &trans->new_bgs);
> > >         btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
> >
> > There's a missing btrfs_put_block_group() call at
> > btrfs_cleanup_pending_block_groups().
>
> Good catch, thanks.

Yep, as you noticed later, it was added in patch 2/5 instead of this one (4=
/5).
So it just needs to be moved from that patch to this one.

Thanks.

>
> >
> > Thanks.
> >
> >
> > >
> > > --
> > > 2.48.1
> > >
> > >

