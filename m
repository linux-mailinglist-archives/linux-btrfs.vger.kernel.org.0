Return-Path: <linux-btrfs+bounces-5427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5988FA638
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 01:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74291F24B50
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668B013C90F;
	Mon,  3 Jun 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htkAl9s1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026582D9C
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456231; cv=none; b=PHrc9Fhg2s6mKbggsFrMXIpPrKuCJOn8CBa+5DHgQqker6yPJqpPJbVzli90SSbN3oI1D4e0JcD4pTqQhXctaLdPhUaCmXBtKTdl+5lRw5eBFMjZR1Fd8P/gZ/k88Db9vp3wOrSofPnSN/XrtA+lM/eVtFP+NF1mS5EUANdiOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456231; c=relaxed/simple;
	bh=ocY4F3pF+4UMxvTE91OlP0IfWhBT/acSNkxNcl1obvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzBgd70jP54YzsyhJfO7N2gcTAA+b0vgAcv5WFFFwWO7oX1NhZic531YoMOV8hkIGT60Wg8s4F+Nla3EEMavJCX4jm9/IQO3S4bQPimyvn4O6rTB9BQ4B/kZzNxI0YLrveKqu01ujciHAKxTO6BEjj7YB4wY1TctHmJqoxbl+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htkAl9s1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28350C32782
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456231;
	bh=ocY4F3pF+4UMxvTE91OlP0IfWhBT/acSNkxNcl1obvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=htkAl9s1wATqbJSX6zmI/0VpclzqejUcYIv08/H4zIbIcj7/cXr+gp/OeEWK8ge5B
	 TYJrsyNVgsXRFlkFZc0Lc5wqMqLArrx/nOsycZ45Rz7DCpHm8fCrHAaiH0m1+du3B1
	 7x78vGi1IHg3JNhxWYd0sJXOSYfnckBgCDeUjw+5sgmyJfK01yaixaydQe8NqPwNCn
	 25BZ86JBplztp7soHO5gTuR1/UhGcECicYXAysIRx12FjxkIHKU+bHchAr2Xszmhvt
	 QWR8Xd1oetEfW5wkVSZpD/fnI7niW2BqeFxK55VVOCFoOFUrwGLJPcKmTNcHSTJCbP
	 UDRxFfQsVzJvg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso488919a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2024 16:10:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YzxlblLnuP7KVQNVMs68Tw7AH3/VHmhcfJZnO7EXTjfb5RULmG2
	LxycfrpREts7yjCx1SoQ931klecLtaq0Ytl0OnIuRX0RkGB6Rjidoo1M/EfLahujYI/bw9g6E9u
	XxfaN3EmxT6GR2HG39LkC5X+J2Pg=
X-Google-Smtp-Source: AGHT+IHX5HjHR3lVqZRehYXsA3IXJl2hjL6DJObUeljDYJJWDr/Be34uRpH6KZC7j+OwpZHHHt7+Zj+4VlxJvUrvw8I=
X-Received: by 2002:a17:906:fb06:b0:a68:c2f4:eac with SMTP id
 a640c23a62f3a-a68c30351f7mr443413666b.59.1717456229654; Mon, 03 Jun 2024
 16:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a4d66f6922f5219c7c8c37d88a919304abdbb55.1717416325.git.fdmanana@suse.com>
 <c445c0fb-7a61-4127-9281-13a7c84494a7@gmx.com>
In-Reply-To: <c445c0fb-7a61-4127-9281-13a7c84494a7@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 4 Jun 2024 00:09:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H651tkJgzOOO3VU46oPs3N1x21kDww-V5xWH3URP6buaw@mail.gmail.com>
Message-ID: <CAL3q7H651tkJgzOOO3VU46oPs3N1x21kDww-V5xWH3URP6buaw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix leak of qgroup extent records after
 transaction abort
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 11:58=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/6/3 21:36, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Qgroup extent records are created when delayed ref heads are created an=
d
> > then released after accounting extents at btrfs_qgroup_account_extents(=
),
> > called during the transaction commit path.
> >
> > If a transaction is aborted we free the qgroup records by calling
> > btrfs_qgroup_destroy_extent_records() at btrfs_destroy_delayed_refs(),
> > unless we don't have delayed references. We are incorrectly assuming
> > that no delayed references means we don't have qgroup extents records.
> >
> > We can currently have no delayed references because we ran them all
> > during a transaction commit and the transaction was aborted after that
> > due to some error in the commit path.
> >
> > So fix this by ensuring we btrfs_qgroup_destroy_extent_records() at
> > btrfs_destroy_delayed_refs() even if we don't have any delayed referenc=
es.
>
> Will it cause some underflow for delayed_refs->num_entries?
>
> As in the rb tree iteration code, we would try to decrease
> delayed_refs->num_entries again.

What underflow, where?

btrfs_qgroup_destroy_extent_records() doesn't do anything to the
counter (or delayed refs).

Or are you seeing that delayed_refs->num_entries can be 0 while the
delayed_refs->href_root rb tree is not empty?
How is that possible?

>
> Thanks,
> Qu
> >
> > Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/linux-btrfs/0000000000004e7f980619f91835@=
google.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/disk-io.c | 10 +---------
> >   1 file changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 8693893744a0..b1daaaec0614 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -4522,18 +4522,10 @@ static void btrfs_destroy_delayed_refs(struct b=
trfs_transaction *trans,
> >                                      struct btrfs_fs_info *fs_info)
> >   {
> >       struct rb_node *node;
> > -     struct btrfs_delayed_ref_root *delayed_refs;
> > +     struct btrfs_delayed_ref_root *delayed_refs =3D &trans->delayed_r=
efs;
> >       struct btrfs_delayed_ref_node *ref;
> >
> > -     delayed_refs =3D &trans->delayed_refs;
> > -
> >       spin_lock(&delayed_refs->lock);
> > -     if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
> > -             spin_unlock(&delayed_refs->lock);
> > -             btrfs_debug(fs_info, "delayed_refs has NO entry");
> > -             return;
> > -     }
> > -
> >       while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D =
NULL) {
> >               struct btrfs_delayed_ref_head *head;
> >               struct rb_node *n;

