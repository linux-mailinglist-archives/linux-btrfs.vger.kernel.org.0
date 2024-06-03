Return-Path: <linux-btrfs+bounces-5417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C028D8656
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 17:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A376D1F226FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AEB1311A1;
	Mon,  3 Jun 2024 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENgWU1nP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B28320D
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429637; cv=none; b=MVU8gcJJqtOihd7aaEplu56cKeyjdTRaip2t0fp4dwYkovXk20ZZKaXWLEzbkyA4ophYpFg6+UdL0PjRzHF/614W1VEH563l7qHJo/fIFuf3v78MPXhko4bAw9+2wFJWlb+dexFNk6tXRWSHdi/Qt02vgTva44YubcxNuP1N+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429637; c=relaxed/simple;
	bh=l9DK/er+0sDMO8IjglwPmCtOFlTu+hiTMFaIuYPrVFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxMccKDVlShzBONQayHQay7Lf9hJ4QyLZg7I4HPJSb+u2OPJwvlvDFn0sukMMFQXp6b7BgXrFnhNzcau3gCGA7qTXjhUjOimWzTyCVV4jOaky3qFbV5XCDBoOT6MdYR6QliB/011Q1nxbfJI6oAZ9+/D3vBzBfpQyzfWu67IHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENgWU1nP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D58FC4AF07
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717429637;
	bh=l9DK/er+0sDMO8IjglwPmCtOFlTu+hiTMFaIuYPrVFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ENgWU1nPzg5Bv89EuQ8KHCHxwfw/rY7ixAGCltAm8sDMu99WveMqZiOajsSEWuPew
	 b3EA1prsdqFnN/qbOcpdBul0oChZoBa+sk/EpWfhD6t9JIOPm+lCpP+JLDiL7n++p9
	 froFLg8R713O6fdCeW5yhlVxO6jAUPCGH/kP6Uamw1XWrhtQHVFhUEzABebEKMB9Ud
	 vHZ3RmjUftusOC+lJZwwp8rPMNHvhY4ERw96jzWJYXinf9i3gptKX+SgxbLXIAg+7d
	 EsN1cytjCDKc2JYLydz6Tt5HtzcO2p7bCurAIFMTsSJyhdigIGMPkXED7SjCBNRcuI
	 VDerP662S3yJA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a69024f2433so172584366b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2024 08:47:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw02JNfTlMGsNATVdLI2zg3mHBUlIH8ovhgoZJ5+X6nVI2chQF/
	bwkD5pxzvTTTwKW/8MTj9EtCVE154B1weCg8Qo4i5owrzuaySGlY/hYeNhV62fJ0+QMT9Ycc3PM
	d3CD9JEj4iBU0bFXsx2jE2UVdv1U=
X-Google-Smtp-Source: AGHT+IHNA8RfiujFyXNdqpoEi3J7VCnRERwvZbgoWaEsq+dKao2ScSicZl+8aE7uVhNCSrrG8mQXYreH6JpSdxNYWE8=
X-Received: by 2002:a17:907:3da0:b0:a68:ea80:f54b with SMTP id
 a640c23a62f3a-a68ea80f721mr371360566b.18.1717429635823; Mon, 03 Jun 2024
 08:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603153410.79244-1-sunjunchao2870@gmail.com>
In-Reply-To: <20240603153410.79244-1-sunjunchao2870@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 3 Jun 2024 16:46:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H54K=kmYb2F_oua5Z_vjeFQoaDvDL9eGb-7eo85JapxFw@mail.gmail.com>
Message-ID: <CAL3q7H54K=kmYb2F_oua5Z_vjeFQoaDvDL9eGb-7eo85JapxFw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Adjust the layout of the btrfs_inode structure to
 save memory.
To: Junchao Sun <sunjunchao2870@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:34=E2=80=AFPM Junchao Sun <sunjunchao2870@gmail.co=
m> wrote:
>
> Using pahole, we can see that there are some padding holes in
> the current btrfs_inode structure. Adjusting the layout of
> btrfs_inode can reduce these holes, decreasing the size of
> the structure by 8 bytes (although there are still 5 bytes of padding).
>
> Here is the output generated by pahole:
>
>         u8                         defrag_compress;      /*    26     1 *=
/
>
>         /* XXX 5 bytes hole, try to pack */
>
>         spinlock_t                 lock;                 /*    32    64 *=
/
>         ...
>         unsigned int               outstanding_extents;  /*   432     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         spinlock_t                 ordered_tree_lock;    /*   440    64 *=
/
>         ...
>         u64                        i_otime_sec;          /*   800     8 *=
/
>         u32                        i_otime_nsec;         /*   808     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct list_head           delayed_iput;         /*   816    16 *=
/

What branch is this based on?

On for-next, which is what you should be using, it doesn't help reduce
the size of the structure, it remains at 1024 bytes.
And as far as I can see, it also doesn't result in better locality
(fields used together now in the same cache line).

And it's just moving the hole from one place to another.

Before the patch, pahole on for-next gives:

struct btrfs_inode {
        struct btrfs_root *        root;                 /*     0     8 */
        u8                         prop_compress;        /*     8     1 */
        u8                         defrag_compress;      /*     9     1 */

        /* XXX 2 bytes hole, try to pack */

        spinlock_t                 lock;                 /*    12     4 */
        struct extent_map_tree     extent_tree;          /*    16    32 */
        struct extent_io_tree      io_tree;              /*    48    24 */
        /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
        struct extent_io_tree *    file_extent_tree;     /*    72     8 */
        struct mutex               log_mutex;            /*    80    32 */
        unsigned int               outstanding_extents;  /*   112     4 */
        spinlock_t                 ordered_tree_lock;    /*   116     4 */
        struct rb_root             ordered_tree;         /*   120     8 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct rb_node *           ordered_tree_last;    /*   128     8 */
        struct list_head           delalloc_inodes;      /*   136    16 */
        long unsigned int          runtime_flags;        /*   152     8 */
        u64                        generation;           /*   160     8 */
        u64                        last_trans;           /*   168     8 */
        u64                        logged_trans;         /*   176     8 */
        int                        last_sub_trans;       /*   184     4 */
        int                        last_log_commit;      /*   188     4 */
        /* --- cacheline 3 boundary (192 bytes) --- */
        union {
                u64                delalloc_bytes;       /*   192     8 */
                u64                first_dir_index_to_log; /*   192     8 *=
/
        };                                               /*   192     8 */
        union {
                u64                new_delalloc_bytes;   /*   200     8 */
                u64                last_dir_index_offset; /*   200     8 */
        };                                               /*   200     8 */
        union {
                u64                defrag_bytes;         /*   208     8 */
                u64                reloc_block_group_start; /*   208     8 =
*/
        };                                               /*   208     8 */
        u64                        disk_i_size;          /*   216     8 */
        union {
                u64                index_cnt;            /*   224     8 */
                u64                csum_bytes;           /*   224     8 */
        };                                               /*   224     8 */
        u64                        dir_index;            /*   232     8 */
        u64                        last_unlink_trans;    /*   240     8 */
        union {
                u64                last_reflink_trans;   /*   248     8 */
                u64                ref_root_id;          /*   248     8 */
        };                                               /*   248     8 */
        /* --- cacheline 4 boundary (256 bytes) --- */
        u32                        flags;                /*   256     4 */
        u32                        ro_flags;             /*   260     4 */
        struct btrfs_block_rsv     block_rsv;            /*   264    48 */
        struct btrfs_delayed_node * delayed_node;        /*   312     8 */
        /* --- cacheline 5 boundary (320 bytes) --- */
        u64                        i_otime_sec;          /*   320     8 */
        u32                        i_otime_nsec;         /*   328     4 */

        /* XXX 4 bytes hole, try to pack */

        struct list_head           delayed_iput;         /*   336    16 */
        struct rw_semaphore        i_mmap_lock;          /*   352    40 */
        /* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
        struct inode               vfs_inode
__attribute__((__aligned__(8))); /*   392   632 */

        /* size: 1024, cachelines: 16, members: 36 */
        /* sum members: 1018, holes: 2, sum holes: 6 */
        /* forced alignments: 1 */
} __attribute__((__aligned__(8)));

After the patch is gives:

struct btrfs_inode {
        struct btrfs_root *        root;                 /*     0     8 */
        u8                         prop_compress;        /*     8     1 */
        u8                         defrag_compress;      /*     9     1 */

        /* XXX 2 bytes hole, try to pack */

        spinlock_t                 lock;                 /*    12     4 */
        struct extent_map_tree     extent_tree;          /*    16    32 */
        struct extent_io_tree      io_tree;              /*    48    24 */
        /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
        struct extent_io_tree *    file_extent_tree;     /*    72     8 */
        struct mutex               log_mutex;            /*    80    32 */
        spinlock_t                 ordered_tree_lock;    /*   112     4 */

        /* XXX 4 bytes hole, try to pack */

        struct rb_root             ordered_tree;         /*   120     8 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct rb_node *           ordered_tree_last;    /*   128     8 */
        struct list_head           delalloc_inodes;      /*   136    16 */
        long unsigned int          runtime_flags;        /*   152     8 */
        u64                        generation;           /*   160     8 */
        u64                        last_trans;           /*   168     8 */
        u64                        logged_trans;         /*   176     8 */
        int                        last_sub_trans;       /*   184     4 */
        int                        last_log_commit;      /*   188     4 */
        /* --- cacheline 3 boundary (192 bytes) --- */
        union {
                u64                delalloc_bytes;       /*   192     8 */
                u64                first_dir_index_to_log; /*   192     8 *=
/
        };                                               /*   192     8 */
        union {
                u64                new_delalloc_bytes;   /*   200     8 */
                u64                last_dir_index_offset; /*   200     8 */
        };                                               /*   200     8 */
        union {
                u64                defrag_bytes;         /*   208     8 */
                u64                reloc_block_group_start; /*   208     8 =
*/
        };                                               /*   208     8 */
        u64                        disk_i_size;          /*   216     8 */
        union {
                u64                index_cnt;            /*   224     8 */
                u64                csum_bytes;           /*   224     8 */
        };                                               /*   224     8 */
        u64                        dir_index;            /*   232     8 */
        u64                        last_unlink_trans;    /*   240     8 */
       union {
                u64                last_reflink_trans;   /*   248     8 */
                u64                ref_root_id;          /*   248     8 */
        };                                               /*   248     8 */
        /* --- cacheline 4 boundary (256 bytes) --- */
        u32                        flags;                /*   256     4 */
        u32                        ro_flags;             /*   260     4 */
        struct btrfs_block_rsv     block_rsv;            /*   264    48 */
        struct btrfs_delayed_node * delayed_node;        /*   312     8 */
        /* --- cacheline 5 boundary (320 bytes) --- */
        u64                        i_otime_sec;          /*   320     8 */
        u32                        i_otime_nsec;         /*   328     4 */
        unsigned int               outstanding_extents;  /*   332     4 */
        struct list_head           delayed_iput;         /*   336    16 */
        struct rw_semaphore        i_mmap_lock;          /*   352    40 */
        /* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
        struct inode               vfs_inode
__attribute__((__aligned__(8))); /*   392   632 */

        /* size: 1024, cachelines: 16, members: 36 */
        /* sum members: 1018, holes: 2, sum holes: 6 */
        /* forced alignments: 1 */
} __attribute__((__aligned__(8)));

So no gains at all as far as I can see.

Thanks.

>
> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
> ---
>  fs/btrfs/btrfs_inode.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 7f7c5a92d2b8..184c31bbf2df 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -118,14 +118,6 @@ struct btrfs_inode {
>         /* held while logging the inode in tree-log.c */
>         struct mutex log_mutex;
>
> -       /*
> -        * Counters to keep track of the number of extent item's we may u=
se due
> -        * to delalloc and such.  outstanding_extents is the number of ex=
tent
> -        * items we think we'll end up using, and reserved_extents is the=
 number
> -        * of extent items we've reserved metadata for. Protected by 'loc=
k'.
> -        */
> -       unsigned outstanding_extents;
> -
>         /* used to order data wrt metadata */
>         spinlock_t ordered_tree_lock;
>         struct rb_root ordered_tree;
> @@ -260,6 +252,14 @@ struct btrfs_inode {
>         u64 i_otime_sec;
>         u32 i_otime_nsec;
>
> +       /*
> +        * Counters to keep track of the number of extent item's we may u=
se due
> +        * to delalloc and such.  outstanding_extents is the number of ex=
tent
> +        * items we think we'll end up using, and reserved_extents is the=
 number
> +        * of extent items we've reserved metadata for. Protected by 'loc=
k'.
> +        */
> +       unsigned outstanding_extents;
> +
>         /* Hook into fs_info->delayed_iputs */
>         struct list_head delayed_iput;
>
> --
> 2.39.2
>
>

