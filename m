Return-Path: <linux-btrfs+bounces-2209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B784CA98
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 13:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230821C20F78
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C9B5A0EF;
	Wed,  7 Feb 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC5LxznH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3A59B76
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308390; cv=none; b=LlTd6OG5jw7Lgb904hx43xlEunz6Kz3X7v7m9PtE314t3v8qUFcyWJneUb4UkTlBWx6LAropnE4ogg9g2m5uyCvZB/VvNmOB1VppACiqn2az6piuo5fcBC+6VHqy0wYrUEzYelEc2wNh/k9bpzKuGiU6K6YMyC7kyeOMz4zKfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308390; c=relaxed/simple;
	bh=1q5traz7ip4D1AWH0K5oCwCfcT2q9642TcvU4VDlmWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuSpVcbDEOBRkuGmRyDPcdvQMM6KMUlKDuC5RGo8pxiq64NHOh+9DkebswmA1jxhT6ZXxWguFiCvhK2zQLV4Ppu86NtCNEVNUUQumJ5p4+3t0TO4cziXm42+YK2omElU5FtFU8UxvTNm/dILIZpwjqyJRwE80Seenc+BUMxl9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC5LxznH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19761C433C7
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707308390;
	bh=1q5traz7ip4D1AWH0K5oCwCfcT2q9642TcvU4VDlmWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aC5LxznHHdSsPuVVK/1z2cftQN8YloEr4uBkCwkgpkiXChWpy1Iszp/529gtno07q
	 EUwCJb9mSbD1MtWajT2T8/qqGLigCHCkWjUfiR4zhz3YRvn2QUQZ1eo6YVFhhyBszH
	 Vz7pircA2X9ClMr5uG0/rdE1+WBZTMeahID1ZzLwjDOmjrve2/x5dMVm2XN7ySfTCk
	 k6bOfbtov9kkjAeaNrKrsJVC6TFJ2MC6PzjXFcapSU/Hcm1lGkXHDSdmpoHyWczcjc
	 lzxb7x+IrAtyyTYpmjhTfClKvhF3Gyqbjjwye28+arM/+iCltM16RA9FukqRcW1h2T
	 ShLjd2uXGugYg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51167e470f7so460247e87.2
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Feb 2024 04:19:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3S7Nsx5eLQrre/YHg+5k8yeQKeDNQaDam90r9mBLujflDxweCYke8Lh/LlJNKl49Ac+18DvXLIPuQEG9MAN77k5Iox5dggFBwVCU=
X-Gm-Message-State: AOJu0YzaqH5rpf/boYvina3xywuL8qYmmIFKwtR9I1Eb/zcAeIHWZg0L
	LFJavFxkT8yJQWdLy26XVcLHKdQHmxvGgAe7eZ8jhiqaTo2Fifwef5o3aHNmA2jWePiNn9G6FjS
	P8x5SYZwRyFgXQe/P0IKfhyt0Gw0=
X-Google-Smtp-Source: AGHT+IF6+ITorVQwgLH8HmE6+GxT6/MZR/0r0DXx7u9mzHwjljwgdAZgf26hmQZIlH0Dg3/QYbiDdKgLHiWhyVJRats=
X-Received: by 2002:a05:6512:68f:b0:511:6631:ba0e with SMTP id
 t15-20020a056512068f00b005116631ba0emr1396135lfe.46.1707308388206; Wed, 07
 Feb 2024 04:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707172743.git.wqu@suse.com> <2188d9521696a2c5f9bbb81479c6c94ea827a0aa.1707172743.git.wqu@suse.com>
 <CAL3q7H72pQ=3wPZpN9zow8+G4xnhSP5UKH1ev808Y5GYYB2BQw@mail.gmail.com> <54a1bb50-7fd2-440f-8563-a82c54bb2179@gmx.com>
In-Reply-To: <54a1bb50-7fd2-440f-8563-a82c54bb2179@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 7 Feb 2024 12:19:11 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ncYG-PPiddp-rLiq6kcVMOo3EaPJQFJB6vE-gv3cyjg@mail.gmail.com>
Message-ID: <CAL3q7H7ncYG-PPiddp-rLiq6kcVMOo3EaPJQFJB6vE-gv3cyjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: defrag: add under utilized extent to defrag
 target list
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	Christoph Anton Mitterer <calestyo@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 8:41=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> On 2024/2/7 02:53, Filipe Manana wrote:
> > On Mon, Feb 5, 2024 at 11:46=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> The following script can lead to a very under utilized extent and we
> >> have no way to use defrag to properly reclaim its wasted space:
> >>
> >>    # mkfs.btrfs -f $dev
> >>    # mount $dev $mnt
> >>    # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
> >>    # sync
> >>    # truncate -s 4k $mnt/foobar
> >>    # btrfs filesystem defrag $mnt/foobar
> >>    # sync
> >>
> >> After the above operations, the file "foobar" is still utilizing the
> >> whole 128M:
> >>
> >>          item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
> >>                  generation 7 transid 8 size 4096 nbytes 4096
> >>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
> >>                  sequence 32770 flags 0x0(none)
> >>          item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
> >>                  index 2 namelen 4 name: file
> >>          item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
> >>                  generation 7 type 1 (regular)
> >>                  extent data disk byte 298844160 nr 134217728 <<<
> >>                  extent data offset 0 nr 4096 ram 134217728
> >>                  extent compression 0 (none)
> >>
> >> This is the common btrfs bookend behavior, that 128M extent would only
> >> be freed if the last referencer of the extent is freed.
> >>
> >> The problem is, normally we would go defrag to free that 128M extent,
> >> but defrag would not touch the extent at all.
> >>
> >> [CAUSE]
> >> The file extent has no adjacent extent at all, thus all existing defra=
g
> >> code consider it a perfectly good file extent, even if it's only
> >> utilizing a very tiny amount of space.
> >>
> >> [FIX]
> >> For a file extent without any adjacent file extent, we should still
> >> consider to defrag such under utilized extent, base on the following
> >> conditions:
> >>
> >> - utilization ratio
> >>    If the extent is utilizing less than 1/16 of the on-disk extent siz=
e,
> >>    then it would be a defrag target.
> >>
> >> - wasted space
> >>    If we defrag the extent and can free at least 16MiB, then it would =
be
> >>    a defrag target.
> >>
> >> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > As I said in my previous review, please include the lore link to the
> > report, it's always useful.
> >
> >> ---
> >>   fs/btrfs/defrag.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 42 insertions(+)
> >>
> >> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> >> index 8fc8118c3225..85c6e45d0cd4 100644
> >> --- a/fs/btrfs/defrag.c
> >> +++ b/fs/btrfs/defrag.c
> >> @@ -950,6 +950,38 @@ struct defrag_target_range {
> >>          u64 len;
> >>   };
> >>
> >> +/*
> >> + * Special entry for extents that do not have any adjacent extents.
> >> + *
> >> + * This is for cases like the only and truncated extent of a file.
> >> + * Normally they won't be defraged at all (as they won't be merged wi=
th
> >> + * any adjacent ones), but we may still want to defrag them, to free =
up
> >> + * some space if possible.
> >> + */
> >> +static bool should_defrag_under_utilized(struct extent_map *em)
> >
> > Can be made const.
> >
> >> +{
> >> +       /*
> >> +        * Ratio based check.
> >> +        *
> >> +        * If the current extent is only utilizing 1/16 of its on-disk=
 size,
> >> +        * it's definitely under-utilized, and defragging it may free =
up
> >> +        * the whole extent.
> >> +        */
> >> +       if (em->len < em->orig_block_len / 16)
> >> +               return true;
> >> +
> >> +       /*
> >> +        * Wasted space based check.
> >> +        *
> >> +        * If we can free up at least 16MiB, then it may be a good ide=
a
> >> +        * to defrag.
> >> +        */
> >> +       if (em->len < em->orig_block_len &&
> >> +           em->orig_block_len - em->len > SZ_16M)
> >
> > The first check, len < orig_block_len, is redundant, isn't it?
> > em->len can only be less than or equals to em->orig_block_len.
> > The second condition is enough to have.
>
> Not exactly, don't forget compressed file extents.

Right.

>
> >
> >> +               return true;
> >> +       return false;
> >> +}
> >> +
> >>   /*
> >>    * Collect all valid target extents.
> >>    *
> >> @@ -1070,6 +1102,16 @@ static int defrag_collect_targets(struct btrfs_=
inode *inode,
> >>                  if (!next_mergeable) {
> >>                          struct defrag_target_range *last;
> >>
> >> +                       /*
> >> +                        * This is a single extent without any chance =
to merge
> >> +                        * with any adjacent extent.
> >> +                        *
> >> +                        * But if we may free up some space, it is sti=
ll worth
> >> +                        * defragging.
> >> +                        */
> >> +                       if (should_defrag_under_utilized(em))
> >> +                               goto add;
> >> +
> >
> > So this logic is making some cases worse actually, making us use more
> > disk space.
> > For example:
> >
> > DEV=3D/dev/sdi
> > MNT=3D/mnt/sdi
> >
> > mkfs.btrfs -f $DEV
> > mount $DEV $MNT
> >
> > xfs_io -f -c "pwrite 0 128M" $MNT/foobar
> > sync
> > xfs_io -c "truncate 40M" $MNT/foobar
> > btrfs filesystem defrag $MNT/foobar
> >
> > After this patch, we get:
> >
> > item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
> > generation 7 type 1 (regular)
> > extent data disk byte 1104150528 nr 134217728
> > extent data offset 0 nr 8650752 ram 134217728
> > extent compression 0 (none)
> > item 7 key (257 EXTENT_DATA 8650752) itemoff 15757 itemsize 53
> > generation 8 type 1 (regular)
> > extent data disk byte 1238368256 nr 33292288
> > extent data offset 0 nr 33292288 ram 33292288
> > extent compression 0 (none)
>
> This behavior is unexpected, as we should redirty the whole 40M, but the
> first 8.25M didn't got re-dirtied is a big problem to me.
> Will look into the situation.
>
> >
> > So we're now using 128M + 32M of disk space where before defrag we used=
 128M.
> > Before the defrag we had:
> >
> > item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
> > generation 7 type 1 (regular)
> > extent data disk byte 1104150528 nr 134217728
> > extent data offset 0 nr 41943040 ram 134217728
> > extent compression 0 (none)
> >
> > So something's not good in this logic.
> >
> > Also, there's something else worth considering here, which is extent sh=
aredness.
>
> This is a known problem for defrag, thus for snapshot/reflink it's
> really on the end user to determine whether they really need defrag.

It is a known problem for defrag that is intentional, because the goal
of defrag is to optimize extent layout,
reduce the number of extents, and have larger extents to optimize reads.

However this new behavior, rewriting "lone" extents, we are adding to
here defrag is different, as its goal is
to release unused space. So having it increase space in case an extent
is shared, goes against the goal of
eliminating wasted space.

From a user perspective it's confusing. It's documented that for the
normal mode we can break extent sharing
because the intention is to optimize extent layout to optimize reads
(and also reduce metadata).
Now this new defrag mode, which gets a new flag in the path, its goal
is only to reduce wasted space...

>
> Thanks,
> Qu
> > If an extent is shared we don't want to always dirty the respective
> > range and rewrite it, as that may result in using more disk space...
> >
> > Example:
> >
> > xfs_io -f -c "pwrite 0 128M" $MNT/foobar
> > btrfs subvolume snapshot $MNT $MNT/snap
> > xfs_io -c "truncate 16M" $MNT/foobar
> > btrfs filesystem defrag $MNT/foobar
> >
> > We end up consuming an additional 16M of data without any benefits.
> > Without this patch, this wouldn't happen.
> >
> > Thanks.
> >
> >
> >>                          /* Empty target list, no way to merge with la=
st entry */
> >>                          if (list_empty(target_list))
> >>                                  goto next;
> >> --
> >> 2.43.0
> >>
> >>
> >

