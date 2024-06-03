Return-Path: <linux-btrfs+bounces-5418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0828D86F8
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 18:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3631F2252B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3913664B;
	Mon,  3 Jun 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdwqkX2U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D212DDAF
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431240; cv=none; b=gL5YqPn+qG20Ll3DShEJKrSK9Qu3HfRbyjGy+DIhrMXYH0AWVAoq/s3qMx2U6xZ3fmoN+6mC207rhLB2YgJYt9zrZfRSFfnSTjo1QvOtboDLmNI1UoertKmtZeOdULIJhhESLJo6lCAty/ITlEuIJRW3LYYQzrwgdjTI/VOFawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431240; c=relaxed/simple;
	bh=uPC7qqhMfbJ4fh7PEm3BL5cOnBc75qNb6Ncv8gCoX6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtnCHrHV9ErFlei9CXPbQDZWu8EIGdWwihtYIB3tiTy7qUwI199SgfjmMhpZeXf7OJtm+6FOj1b0QvCKYITgDi33xwdRXVJxF3xVHfPymgpHAXCHGJCgRGcYSUWvqTJJBAel4a7kmdHEvkTNbzjX18OIMbjW7z/gH9cAcrr5XnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdwqkX2U; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso4884359a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2024 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717431237; x=1718036037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMk0+nK9fO43kY1c/RgRwKzM2VeJL5gKZ52gzsIhN70=;
        b=cdwqkX2UxGKUaNE9Fok/7hwYLm0amj8ORLRiWW7ZErpG8DcMysKhq1IYLA6htn0sw6
         zeuWOh684wSrJzxmnDfgl+hiaHX71UX7KXA0/FgfBnFpGf0qnHRYpQZfHW83gTMCwi1O
         LNL5UP1KoZXC3/INTDqiOlq4zxLP/RfupqScKlR23qJonbKQtfGfkbzVv6y6baEx97ng
         x0s5VsCf6k22dHwVrE4epmZjwnm6fOdSECy838Vzi1+9DExbxw2RrDOh8KpRefNuHd4d
         x4tq0Rt24o/cgkCPOlxQ+bnLQJHy/xgVYb9i2nspAjvAg1mqvYA3Gwp768xQkQVZhRQu
         Xxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431237; x=1718036037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMk0+nK9fO43kY1c/RgRwKzM2VeJL5gKZ52gzsIhN70=;
        b=mBbpZpstyy1vaEx/5q2FTy2jSTxuveOcTdbmdO4Ve8qxsevRmYcfzeuU9l6AEkcoye
         nhvuFzcnp7lEQ/3JgSZvpy3l/O8GvrvuDUMCv7CsJQnMqQ/T/zjpQ2OoMctbxPmEefxV
         qZcuKo7Bd83ITLezfHuR94pGnUnQbtygkVRCdusB+px4x0VXm4sDP1uybotZDnGkdnlw
         7Z0MuvXRFo9SeXh5NsT5xs/XUCYvvQB3z1IW9Or662IvtCZUh+XQpdnXN9T6inLceIzm
         GvUi+i6MFBeePMeVh1gBmuilBO2k5K8tzVCKn6/h46Mrwc2TRGmjlGrz2dUzklAgJ5hh
         p3KQ==
X-Gm-Message-State: AOJu0Ywpbcbr9W+HFv1NMU+Aeib9IoHz+jGyE38z8LB0CR+WUvryJqMI
	Tm0aWxK+lyCStC7qtKB/+/P6We5Gulp687DFn4Fc7kYQ5j6ZrDou+yTIQg2me4T4lvDSr3zHQ9F
	6vWVtlw7t3cE5A05O1ItOsMMsgL4=
X-Google-Smtp-Source: AGHT+IGnhRjGMV7Wo3OLLvF5+sMzoZesMF5xkgCZL0/XJJHjkYwLrrgYEb2do4bSroKKYYQL1jAfQv2hQYhFrDs9GTw=
X-Received: by 2002:a50:d603:0:b0:57a:2cf9:f614 with SMTP id
 4fb4d7f45d1cf-57a3644a0b8mr6362946a12.32.1717431236231; Mon, 03 Jun 2024
 09:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603153410.79244-1-sunjunchao2870@gmail.com> <CAL3q7H54K=kmYb2F_oua5Z_vjeFQoaDvDL9eGb-7eo85JapxFw@mail.gmail.com>
In-Reply-To: <CAL3q7H54K=kmYb2F_oua5Z_vjeFQoaDvDL9eGb-7eo85JapxFw@mail.gmail.com>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Mon, 3 Jun 2024 12:13:44 -0400
Message-ID: <CAHB1Nai2Kbty3HWojubAz97YO96+9BMEDaZZF+x4BW9n0jV7tw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Adjust the layout of the btrfs_inode structure to
 save memory.
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Filipe Manana <fdmanana@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=B8=80 11:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jun 3, 2024 at 4:34=E2=80=AFPM Junchao Sun <sunjunchao2870@gmail.=
com> wrote:
> >
> > Using pahole, we can see that there are some padding holes in
> > the current btrfs_inode structure. Adjusting the layout of
> > btrfs_inode can reduce these holes, decreasing the size of
> > the structure by 8 bytes (although there are still 5 bytes of padding).
> >
> > Here is the output generated by pahole:
> >
> >         u8                         defrag_compress;      /*    26     1=
 */
> >
> >         /* XXX 5 bytes hole, try to pack */
> >
> >         spinlock_t                 lock;                 /*    32    64=
 */
> >         ...
> >         unsigned int               outstanding_extents;  /*   432     4=
 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         spinlock_t                 ordered_tree_lock;    /*   440    64=
 */
> >         ...
> >         u64                        i_otime_sec;          /*   800     8=
 */
> >         u32                        i_otime_nsec;         /*   808     4=
 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         struct list_head           delayed_iput;         /*   816    16=
 */
>
>
> > What branch is this based on?
> >
> > On for-next, which is what you should be using, it doesn't help reduce
> > the size of the structure, it remains at 1024 bytes.
> > And as far as I can see, it also doesn't result in better locality
> > (fields used together now in the same cache line).
> >
> > And it's just moving the hole from one place to another.

Oh, I was not using the newest commit. I checkouted to the newest
commit, the same thing has been done by 398fb9131f3("btrfs: reorder
btrfs_inode to fill gaps").
Sorry for the noise and thanks for your review!
>
> Before the patch, pahole on for-next gives:
>
> struct btrfs_inode {
>         struct btrfs_root *        root;                 /*     0     8 *=
/
>         u8                         prop_compress;        /*     8     1 *=
/
>         u8                         defrag_compress;      /*     9     1 *=
/
>
>         /* XXX 2 bytes hole, try to pack */
>
>         spinlock_t                 lock;                 /*    12     4 *=
/
>         struct extent_map_tree     extent_tree;          /*    16    32 *=
/
>         struct extent_io_tree      io_tree;              /*    48    24 *=
/
>         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>         struct extent_io_tree *    file_extent_tree;     /*    72     8 *=
/
>         struct mutex               log_mutex;            /*    80    32 *=
/
>         unsigned int               outstanding_extents;  /*   112     4 *=
/
>         spinlock_t                 ordered_tree_lock;    /*   116     4 *=
/
>         struct rb_root             ordered_tree;         /*   120     8 *=
/
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         struct rb_node *           ordered_tree_last;    /*   128     8 *=
/
>         struct list_head           delalloc_inodes;      /*   136    16 *=
/
>         long unsigned int          runtime_flags;        /*   152     8 *=
/
>         u64                        generation;           /*   160     8 *=
/
>         u64                        last_trans;           /*   168     8 *=
/
>         u64                        logged_trans;         /*   176     8 *=
/
>         int                        last_sub_trans;       /*   184     4 *=
/
>         int                        last_log_commit;      /*   188     4 *=
/
>         /* --- cacheline 3 boundary (192 bytes) --- */
>         union {
>                 u64                delalloc_bytes;       /*   192     8 *=
/
>                 u64                first_dir_index_to_log; /*   192     8=
 */
>         };                                               /*   192     8 *=
/
>         union {
>                 u64                new_delalloc_bytes;   /*   200     8 *=
/
>                 u64                last_dir_index_offset; /*   200     8 =
*/
>         };                                               /*   200     8 *=
/
>         union {
>                 u64                defrag_bytes;         /*   208     8 *=
/
>                 u64                reloc_block_group_start; /*   208     =
8 */
>         };                                               /*   208     8 *=
/
>         u64                        disk_i_size;          /*   216     8 *=
/
>         union {
>                 u64                index_cnt;            /*   224     8 *=
/
>                 u64                csum_bytes;           /*   224     8 *=
/
>         };                                               /*   224     8 *=
/
>         u64                        dir_index;            /*   232     8 *=
/
>         u64                        last_unlink_trans;    /*   240     8 *=
/
>         union {
>                 u64                last_reflink_trans;   /*   248     8 *=
/
>                 u64                ref_root_id;          /*   248     8 *=
/
>         };                                               /*   248     8 *=
/
>         /* --- cacheline 4 boundary (256 bytes) --- */
>         u32                        flags;                /*   256     4 *=
/
>         u32                        ro_flags;             /*   260     4 *=
/
>         struct btrfs_block_rsv     block_rsv;            /*   264    48 *=
/
>         struct btrfs_delayed_node * delayed_node;        /*   312     8 *=
/
>         /* --- cacheline 5 boundary (320 bytes) --- */
>         u64                        i_otime_sec;          /*   320     8 *=
/
>         u32                        i_otime_nsec;         /*   328     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct list_head           delayed_iput;         /*   336    16 *=
/
>         struct rw_semaphore        i_mmap_lock;          /*   352    40 *=
/
>         /* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
>         struct inode               vfs_inode
> __attribute__((__aligned__(8))); /*   392   632 */
>
>         /* size: 1024, cachelines: 16, members: 36 */
>         /* sum members: 1018, holes: 2, sum holes: 6 */
>         /* forced alignments: 1 */
> } __attribute__((__aligned__(8)));
>
> After the patch is gives:
>
> struct btrfs_inode {
>         struct btrfs_root *        root;                 /*     0     8 *=
/
>         u8                         prop_compress;        /*     8     1 *=
/
>         u8                         defrag_compress;      /*     9     1 *=
/
>
>         /* XXX 2 bytes hole, try to pack */
>
>         spinlock_t                 lock;                 /*    12     4 *=
/
>         struct extent_map_tree     extent_tree;          /*    16    32 *=
/
>         struct extent_io_tree      io_tree;              /*    48    24 *=
/
>         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>         struct extent_io_tree *    file_extent_tree;     /*    72     8 *=
/
>         struct mutex               log_mutex;            /*    80    32 *=
/
>         spinlock_t                 ordered_tree_lock;    /*   112     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct rb_root             ordered_tree;         /*   120     8 *=
/
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         struct rb_node *           ordered_tree_last;    /*   128     8 *=
/
>         struct list_head           delalloc_inodes;      /*   136    16 *=
/
>         long unsigned int          runtime_flags;        /*   152     8 *=
/
>         u64                        generation;           /*   160     8 *=
/
>         u64                        last_trans;           /*   168     8 *=
/
>         u64                        logged_trans;         /*   176     8 *=
/
>         int                        last_sub_trans;       /*   184     4 *=
/
>         int                        last_log_commit;      /*   188     4 *=
/
>         /* --- cacheline 3 boundary (192 bytes) --- */
>         union {
>                 u64                delalloc_bytes;       /*   192     8 *=
/
>                 u64                first_dir_index_to_log; /*   192     8=
 */
>         };                                               /*   192     8 *=
/
>         union {
>                 u64                new_delalloc_bytes;   /*   200     8 *=
/
>                 u64                last_dir_index_offset; /*   200     8 =
*/
>         };                                               /*   200     8 *=
/
>         union {
>                 u64                defrag_bytes;         /*   208     8 *=
/
>                 u64                reloc_block_group_start; /*   208     =
8 */
>         };                                               /*   208     8 *=
/
>         u64                        disk_i_size;          /*   216     8 *=
/
>         union {
>                 u64                index_cnt;            /*   224     8 *=
/
>                 u64                csum_bytes;           /*   224     8 *=
/
>         };                                               /*   224     8 *=
/
>         u64                        dir_index;            /*   232     8 *=
/
>         u64                        last_unlink_trans;    /*   240     8 *=
/
>        union {
>                 u64                last_reflink_trans;   /*   248     8 *=
/
>                 u64                ref_root_id;          /*   248     8 *=
/
>         };                                               /*   248     8 *=
/
>         /* --- cacheline 4 boundary (256 bytes) --- */
>         u32                        flags;                /*   256     4 *=
/
>         u32                        ro_flags;             /*   260     4 *=
/
>         struct btrfs_block_rsv     block_rsv;            /*   264    48 *=
/
>         struct btrfs_delayed_node * delayed_node;        /*   312     8 *=
/
>         /* --- cacheline 5 boundary (320 bytes) --- */
>         u64                        i_otime_sec;          /*   320     8 *=
/
>         u32                        i_otime_nsec;         /*   328     4 *=
/
>         unsigned int               outstanding_extents;  /*   332     4 *=
/
>         struct list_head           delayed_iput;         /*   336    16 *=
/
>         struct rw_semaphore        i_mmap_lock;          /*   352    40 *=
/
>         /* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
>         struct inode               vfs_inode
> __attribute__((__aligned__(8))); /*   392   632 */
>
>         /* size: 1024, cachelines: 16, members: 36 */
>         /* sum members: 1018, holes: 2, sum holes: 6 */
>         /* forced alignments: 1 */
> } __attribute__((__aligned__(8)));
>
> So no gains at all as far as I can see.
>
> Thanks.
>
> >
> > Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/btrfs/btrfs_inode.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index 7f7c5a92d2b8..184c31bbf2df 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -118,14 +118,6 @@ struct btrfs_inode {
> >         /* held while logging the inode in tree-log.c */
> >         struct mutex log_mutex;
> >
> > -       /*
> > -        * Counters to keep track of the number of extent item's we may=
 use due
> > -        * to delalloc and such.  outstanding_extents is the number of =
extent
> > -        * items we think we'll end up using, and reserved_extents is t=
he number
> > -        * of extent items we've reserved metadata for. Protected by 'l=
ock'.
> > -        */
> > -       unsigned outstanding_extents;
> > -
> >         /* used to order data wrt metadata */
> >         spinlock_t ordered_tree_lock;
> >         struct rb_root ordered_tree;
> > @@ -260,6 +252,14 @@ struct btrfs_inode {
> >         u64 i_otime_sec;
> >         u32 i_otime_nsec;
> >
> > +       /*
> > +        * Counters to keep track of the number of extent item's we may=
 use due
> > +        * to delalloc and such.  outstanding_extents is the number of =
extent
> > +        * items we think we'll end up using, and reserved_extents is t=
he number
> > +        * of extent items we've reserved metadata for. Protected by 'l=
ock'.
> > +        */
> > +       unsigned outstanding_extents;
> > +
> >         /* Hook into fs_info->delayed_iputs */
> >         struct list_head delayed_iput;
> >
> > --
> > 2.39.2
> >
> >

