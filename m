Return-Path: <linux-btrfs+bounces-19662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E267FCB66BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 17:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58CAA3001BDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D2B30FC34;
	Thu, 11 Dec 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ/yrTnf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8762E2F2608
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469241; cv=none; b=e0SniR/PT7a8ybQmWm0f9QgEarSQ2V+uzjH5GGvozAst8j51P1jmz0phRknp1QzP2nA43aUYD4zP4e8sT3UV/zAbqBJbtpKHlDJBHdNW0frgpQ+1/tQp5P1+U1EJ/3WD9l9Km96YG9fvqgkQuhSlMmeIBc8oZm3/74m5zu0XpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469241; c=relaxed/simple;
	bh=kYyvVFkdD7eBoLhEw8VjQzcRhuUgBrbLKN+DpyPmuc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idxzhauHgM7n+yg3NDahDisfDghRfPYq2JnUauGh4FigBc/pqDtg5YPKlShK3PDZVLjBb4oWF1fGBnZbJPxR6KuBjqpssV6M+ltqUwVxVJiT/RpjowSRXxwhySnr9KG9C/YyJ2IbNB3M6+zr33KKF9MTPm6jHwRtz84Y114m618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ/yrTnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531B7C16AAE
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765469241;
	bh=kYyvVFkdD7eBoLhEw8VjQzcRhuUgBrbLKN+DpyPmuc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MJ/yrTnfm13e5VZwSKFxpJJGaAWv0gY6F1T8m9YvEHFfTV3JEi9s5jbmQeS3cK7A6
	 396SQ95K/K/OtQ7plOupM5YCLsy24+YoSPpgJgQx5mk5Zky8nVzn6ITzWiuZocU8kV
	 Ss4Or5n39+t5vvyOmmx6uVIsEugNK9nsq/Ifq/gmPBzcDOiq2bFypLEF97QFD64YKi
	 E0i+fj99OQ6vLLRbqIVod+C75jFOmaIO4xQniS6cfg/UO5Ad2IvMHcCJ3P1gKnTY+p
	 pmfjEwVXO2vafJlYypT1pdM2ixLVL5VA6Ko/KocU7FG3F1UKpLb5KCTG+rS4SYHDSE
	 hhu0i5QDjm7lQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79f98adea4so43212766b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 08:07:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yyj5vVMGy872vD2PqUWbhxaTo5vMX+iG2YhquMs5C9moKElYHkh
	3z4Sv5NJZxDyHj4uy7n53cfKk8CzEp8m3lIXVsMUCVC5lLTbDZp5/yaYYsCN/Ot3rMeSqHCnJgl
	JzEE4JsEjF1Y2V+iuCGM6EWrPlijYvhs=
X-Google-Smtp-Source: AGHT+IHqonXr6eptzHf/utolGMtYPsW2kskFA0JeiCqXICY/SOLMd/dK2c2YMQz2SeeO3ES2jLl24EffrWIh+PimGlU=
X-Received: by 2002:a17:907:940e:b0:b73:7d96:5c97 with SMTP id
 a640c23a62f3a-b7ce847609fmr714088466b.34.1765469239725; Thu, 11 Dec 2025
 08:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765418669.git.wqu@suse.com> <4d0eff22caa7217a4c1972a755043ee3324c5348.1765418669.git.wqu@suse.com>
 <CAL3q7H7O4dZzjo6tEoUMbkTbj6mJhh+ngM3s=Yudew5a2h0GDQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7O4dZzjo6tEoUMbkTbj6mJhh+ngM3s=Yudew5a2h0GDQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Dec 2025 16:06:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H49_x14PMriJxRDxdyCuUqFow0Ytj0O40dvKTMcGfWzjQ@mail.gmail.com>
X-Gm-Features: AQt7F2qJeHHlv4C_cvylJ2CFHzzS4qGTix2BVYZWf6nlW40mkK9YSPQIwkyk5vI
Message-ID: <CAL3q7H49_x14PMriJxRDxdyCuUqFow0Ytj0O40dvKTMcGfWzjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: add an ASSERT() to catch ordered extents
 without datasum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 11:41=E2=80=AFAM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Thu, Dec 11, 2025 at 2:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> > Inside btrfs_finish_one_ordered(), there are only very limited
> > situations where the OE has no checksum:
> >
> > - The OE is completely truncated or error happened
> >   In that case no file extent is going to be inserted.
> >
> > - The inode has NODATASUM flag
> >
> > - The inode belongs to data reloc tree
> >
> > Add an ASSERT() using the last two cases, which will help us to catch
> > problems described in commit 18de34daa7c6 ("btrfs: truncate ordered
> > extent when skipping writeback past i_size"), and prevent future simila=
r
> > cases.
>
> How exactly does this new assertion catches that case described in that c=
ommit?
> We had csums there, just not for the whole range of the ordered
> extent, just for the range from its start offset to the rounded up
> i_size (which is less than the ordered extent's end offset).

Rather than checking for the presence of checksums, and if they cover
the whole range, the best is to check if we have an ordered range that
crosses EOF...
Since it's also a bug if we have a nocow ordered extent that crosses EOF.

Something like this (only compile tested):

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0cbac085cdaf..76f7eab7a750 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3139,6 +3139,11 @@ int btrfs_finish_one_ordered(struct
btrfs_ordered_extent *ordered_extent)
                        goto out;
        }

+       ASSERT(start + logical_len <=3D
+              round_up(i_size_read(&inode->vfs_inode), fs_info->sectorsize=
),
+              "start=3D%llu logical_len=3D%llu i_size=3D%lld sectorsize=3D=
%u",
+              start, logical_len, i_size_read(&inode->vfs_inode),
fs_info->sectorsize);
+
        /*
         * If it's a COW write we need to lock the extent range as we will =
be
         * inserting/replacing file extent items and unpinning an extent ma=
p.



>
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  fs/btrfs/inode.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 461725c8ccd7..740de9436d24 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3226,6 +3226,21 @@ int btrfs_finish_one_ordered(struct btrfs_ordere=
d_extent *ordered_extent)
> >                 goto out;
> >         }
> >
> > +       /*
> > +        * If we have no data checksum, either the OE is:
> > +        * - Fully truncated
> > +        *   Those ones won't reach here.
> > +        *
> > +        * - No data checksum
> > +        *
> > +        * - Belongs to data reloc inode
> > +        *   Which doesn't have csum attached to OE, but cloned
> > +        *   from original chunk.
> > +        */
> > +       if (list_empty(&ordered_extent->list))
> > +               ASSERT(inode->flags & BTRFS_INODE_NODATASUM ||
> > +                      btrfs_is_data_reloc_root(inode->root));
>
> No need to inode->root, we have a local variable with the root already.
>
> > +
> >         ret =3D add_pending_csums(trans, &ordered_extent->list);
> >         if (unlikely(ret)) {
> >                 btrfs_abort_transaction(trans, ret);
> > --
> > 2.52.0
> >
> >

