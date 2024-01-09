Return-Path: <linux-btrfs+bounces-1324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447FE8289CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 17:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A41F1C2460C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E2C3A8C6;
	Tue,  9 Jan 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPDyFlgf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A113A278
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 16:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C1DC41606
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704816808;
	bh=TgoJE4UJES9DGkvjBm3owgg2ZsPCRZdt/T4Gk9ZmRZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IPDyFlgf51M8B4mU/oaptumpPyhKyYtsa++bPJL4DTq7MtZf5hu1jIYpOV2oL1I6y
	 3j0rFCTgMIv90tbFa7PjEw8scJ9ystZyI4e85NURINbXN3H0WXnv7ifdSzqRDNqXv1
	 S3F3d1JF8dfs+HA2v201GHT/nH9ErnuSsPJzgegcDI1NANioSp88njdzSzrUtDpGfu
	 w7L9prBA9zntlzuK6juh31xR8TPeuLrDNZZH8bXlpXYSIJFF+LCT86PAF/FrK3oULj
	 KBEufuL52axMevup5xyEc9H1Qx/Lz9YKSnfTXHJtip0jVHpUnu66tr+Z2noYziClL7
	 rkGQvz99XVrBQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a277339dcf4so342589966b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jan 2024 08:13:28 -0800 (PST)
X-Gm-Message-State: AOJu0YwG/0+1G09KrgaZzWuJrWr+newRIu6n2cnosE9ecGCXLFjHtw3T
	lbmPYdiX23Tft3QGH+upWT5k2ZbT8AX80mZzvRU=
X-Google-Smtp-Source: AGHT+IHm/qbzgFTAPDkZH6Ue0wcx7k8vrJfMweywBcGSPsjLIDa925dlNZkIK6w5nIbOlZFVjeE3dvEqrLuSF8x1OHQ=
X-Received: by 2002:a17:907:9301:b0:a29:b035:c7f7 with SMTP id
 bu1-20020a170907930100b00a29b035c7f7mr833426ejc.32.1704816807241; Tue, 09 Jan
 2024 08:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <CAL3q7H5LEjZCkhTwgYJLSeQkG6NsY5AhE__na-2hCa7UuXuCzw@mail.gmail.com>
In-Reply-To: <CAL3q7H5LEjZCkhTwgYJLSeQkG6NsY5AhE__na-2hCa7UuXuCzw@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 9 Jan 2024 16:12:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6mPVRy2C5_yzv0AVtBLMVh0CF+UsUOC1jxfWmOsyas+A@mail.gmail.com>
Message-ID: <CAL3q7H6mPVRy2C5_yzv0AVtBLMVh0CF+UsUOC1jxfWmOsyas+A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target list
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, 
	Christoph Anton Mitterer <calestyo@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 2:55=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Fri, Jan 5, 2024 at 7:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> > [BUG]
> > The following script can lead to a very under utilized extent and we
> > have no way to use defrag to properly reclaim its wasted space:
> >
> >   # mkfs.btrfs -f $dev
> >   # mount $dev $mnt
> >   # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
> >   # sync
> >   # btrfs filesystem defrag $mnt/foobar
> >   # sync
>
> There's a missing truncate in the example.
>
> >
> > After the above operations, the file "foobar" is still utilizing the
> > whole 128M:
> >
> >         item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
> >                 generation 7 transid 8 size 4096 nbytes 4096
> >                 block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
> >                 sequence 32770 flags 0x0(none)
> >         item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
> >                 index 2 namelen 4 name: file
> >         item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
> >                 generation 7 type 1 (regular)
> >                 extent data disk byte 298844160 nr 134217728 <<<
> >                 extent data offset 0 nr 4096 ram 134217728
> >                 extent compression 0 (none)
> >
> > Meaning the expected defrag way to reclaim the space is not working.
> >
> > [CAUSE]
> > The file extent has no adjacent extent at all, thus all existing defrag
> > code consider it a perfectly good file extent, even if it's only
> > utilizing a very tiny amount of space.
> >
> > [FIX]
> > Add a special handling for under utilized extents, currently the ratio
> > is 6.25% (1/16).
> >
> > This would allow us to add such extent to our defrag target list,
> > resulting it to be properly defragged.
> >
> > Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> > Signed-off-by: Qu Wenruo <wqu@suse.com>

Also don't forget to add a Link tag pointing to the thread at lore.
Thanks.

> > ---
> >  fs/btrfs/defrag.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> > index c276b136ab63..cc319190b6fb 100644
> > --- a/fs/btrfs/defrag.c
> > +++ b/fs/btrfs/defrag.c
> > @@ -1070,6 +1070,17 @@ static int defrag_collect_targets(struct btrfs_i=
node *inode,
> >                 if (!next_mergeable) {
> >                         struct defrag_target_range *last;
> >
> > +                       /*
> > +                        * Special entry point utilization ratio under =
1/16 (only
> > +                        * referring 1/16 of an on-disk extent).
> > +                        * This can happen for a truncated large extent=
.
> > +                        * If we don't add them, then for a truncated f=
ile
> > +                        * (may be the last 4K of a 128M extent) it wil=
l never
>
> may be -> maybe
>
> > +                        * be defraged.
>
> defraged -> defragged
>
> > +                        */
> > +                       if (em->ram_bytes < em->orig_block_len / 16)
>
> Why 1 / 16?
> For a 128M extent for example, even 1 / 2 (64M) is a lot of wasted space.
> So I think a better condition is needed, probably to consider the
> absolute value of wasted/unused space too.
>
> And this should use em->len and not em->ram_bytes. The latter is
> preserved when spitting an extent map.
> You can even notice this in the tree dump example from the change log
> - the file extent's items ram bytes is 128M, not 4K.
>
> Thanks.
>
> > +                               goto add;
> > +
> >                         /* Empty target list, no way to merge with last=
 entry */
> >                         if (list_empty(target_list))
> >                                 goto next;
> > --
> > 2.43.0
> >
> >

