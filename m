Return-Path: <linux-btrfs+bounces-5429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17478FA681
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 01:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DFB1F2937A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF5784055;
	Mon,  3 Jun 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pykyj8ft"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009981DDF6
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457326; cv=none; b=dh0WIuqvL6ZULRIEALjb+sOrxWnHlLbJezbBpuLF4xhuHuomOa8ocESwml1BKPQwvyLoEguaMCJso7iW2zqN0Hfyce8IFdK6b2hf514c5vyq0Px00WvOs+2kU5+uSd0a1wrdJB6uMq0pRUaNEw239KQDaWzRo1XEdaOV64Zm0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457326; c=relaxed/simple;
	bh=fMGLobeFhNEbt6b0/CdICvzIvHmZmiOS7Q7P2eLYwEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMF+ald2D+SOaOaXmAWeg4w5R2q6hEEzNx5v2H9GxZe2XpRDzocjdbzZTxJG7Wzs2WdTgSPufOwyx3jmEs2BqkWlj+eZrZ+h57Crig5Cecbgi0eZhhpJ0t0RAG9j/TrVKGwp/C/YPDvbSo0VDgRAUVt2a86gOf3lT4t33pfq0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pykyj8ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E56C32781
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 23:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717457325;
	bh=fMGLobeFhNEbt6b0/CdICvzIvHmZmiOS7Q7P2eLYwEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pykyj8ftDzQ9cTuHqQsnSOqyw3NEMK+SgqtLu4ICYfPp6tUhx3ImzrGeiaSwavprD
	 ovXq4nL5vIZC861YnBTz0mptcss0hpYrVYCRLPljgwF9Bh8AsD8WzDSlGfZ7PP3EoB
	 uHQEZG1UDdBY7vWpuUW2tgHBB58HX5/w760cmMpBo18RwG2aGT52BbwCP18FsXKksj
	 Fgxxauf9Y0ZxGutgHMGm3yQG8thps6DLsaIQPLe1SEDh8VhNF1Wn2bHxZnSW9CUPlP
	 vt23qHtfIjzCa3/cVDMBSkwhhHlRp2YBzKY3IXNn5MuBq6Ed4Aj0+yyhJl7vIW5hU/
	 JACZJp5OFE2oQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a68f10171bdso227044366b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2024 16:28:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLcR0jtK/7A+iLAvpcj2cZlMaMLuzh5f1pwnNFnGtOiHSfmemz
	/PT7D6y6/TSw858ogf5tf67HwUKeYsIpOZ5K8z9RSVnzx2HcTRZPculZCnVSFalIw1un3KEjkC+
	V2z/kTKJntGJMnEJXcPdDZttEOlk=
X-Google-Smtp-Source: AGHT+IHHxbGrKnnqv13DBdw1yDQaweuTeECdnQwu4BSIGc1ivcByA9mF5VINngG9iSdXXCL5gZwcaNh8JDJVQdk03lM=
X-Received: by 2002:a17:906:b20d:b0:a68:e0fc:c64f with SMTP id
 a640c23a62f3a-a68e0fcc727mr473222866b.15.1717457324057; Mon, 03 Jun 2024
 16:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a4d66f6922f5219c7c8c37d88a919304abdbb55.1717416325.git.fdmanana@suse.com>
 <c445c0fb-7a61-4127-9281-13a7c84494a7@gmx.com> <CAL3q7H651tkJgzOOO3VU46oPs3N1x21kDww-V5xWH3URP6buaw@mail.gmail.com>
 <03ec8f07-12b4-420c-8153-e8c9cd288d79@gmx.com>
In-Reply-To: <03ec8f07-12b4-420c-8153-e8c9cd288d79@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 4 Jun 2024 00:28:07 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5uKab2k+894+2sJmR2aZH-JsZ3pOE3WT2-anNg4qkqgA@mail.gmail.com>
Message-ID: <CAL3q7H5uKab2k+894+2sJmR2aZH-JsZ3pOE3WT2-anNg4qkqgA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix leak of qgroup extent records after
 transaction abort
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 12:21=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/6/4 08:39, Filipe Manana =E5=86=99=E9=81=93:
> > On Mon, Jun 3, 2024 at 11:58=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
> [...]
> >>> We can currently have no delayed references because we ran them all
> >>> during a transaction commit and the transaction was aborted after tha=
t
> >>> due to some error in the commit path.
> >>>
> >>> So fix this by ensuring we btrfs_qgroup_destroy_extent_records() at
> >>> btrfs_destroy_delayed_refs() even if we don't have any delayed refere=
nces.
> >>
> >> Will it cause some underflow for delayed_refs->num_entries?
> >>
> >> As in the rb tree iteration code, we would try to decrease
> >> delayed_refs->num_entries again.
> >
> > What underflow, where?
> >
> > btrfs_qgroup_destroy_extent_records() doesn't do anything to the
> > counter (or delayed refs).
> >
> > Or are you seeing that delayed_refs->num_entries can be 0 while the
> > delayed_refs->href_root rb tree is not empty?
> > How is that possible?
>
> Never mind, I was originally referring to the "atomic_dec()" call inside
> "while ((n =3D rb_first_cached())" loop.
>
> But btrfs_run_delayed_refs_for_head() has ensured the entry is properly
> removed from ref_tree before decreasing the "delayed_refs->num_entries",
> it should be safe.
>
> I'd prefer to call btrfs_qgroup_destory_extent_records() inside the "if
> (atomic_read() =3D=3D 0)" branch to be a little more easier to read.
> But it's only a preference.

Maybe it makes the diff more immediate to understand.
But the final code is certainly less verbose and clear enough:

while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL) {
    (...)
}
btrfs_qgroup_destroy_extent_records(trans);

As opposed to:

if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
    btrfs_qgroup_destroy_extent_records(trans);
    spin_unlock(&delayed_refs->lock);
    return;
}

while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL) {
    (...)
}
btrfs_qgroup_destroy_extent_records(trans);


More code for absolutely nothing, not even better readability.


>
> Thanks,
> Qu
>
> >
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com
> >>> Link: https://lore.kernel.org/linux-btrfs/0000000000004e7f980619f9183=
5@google.com/
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>> ---
> >>>    fs/btrfs/disk-io.c | 10 +---------
> >>>    1 file changed, 1 insertion(+), 9 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >>> index 8693893744a0..b1daaaec0614 100644
> >>> --- a/fs/btrfs/disk-io.c
> >>> +++ b/fs/btrfs/disk-io.c
> >>> @@ -4522,18 +4522,10 @@ static void btrfs_destroy_delayed_refs(struct=
 btrfs_transaction *trans,
> >>>                                       struct btrfs_fs_info *fs_info)
> >>>    {
> >>>        struct rb_node *node;
> >>> -     struct btrfs_delayed_ref_root *delayed_refs;
> >>> +     struct btrfs_delayed_ref_root *delayed_refs =3D &trans->delayed=
_refs;
> >>>        struct btrfs_delayed_ref_node *ref;
> >>>
> >>> -     delayed_refs =3D &trans->delayed_refs;
> >>> -
> >>>        spin_lock(&delayed_refs->lock);
> >>> -     if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
> >>> -             spin_unlock(&delayed_refs->lock);
> >>> -             btrfs_debug(fs_info, "delayed_refs has NO entry");
> >>> -             return;
> >>> -     }
> >>> -
> >>>        while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=
=3D NULL) {
> >>>                struct btrfs_delayed_ref_head *head;
> >>>                struct rb_node *n;

