Return-Path: <linux-btrfs+bounces-4859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272F08C0CBA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 10:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911DB1F22219
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D8149C78;
	Thu,  9 May 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieTZr3U+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B4B149C4F
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244028; cv=none; b=LqF9xawHSogprLJXOCInTHsHaFXuOjhd15TykMB9fJRB+W8e0c/AD+J9W3i8BILQdr/916fFfMcWe4HDkS2XVdP81L28qpqhLC8XH/2SghADD7p3icoXmc+CMeyLXE/vhlClUT9GpmSJLcyccd1kJx8Xydq1wr7vNf0wAd1aLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244028; c=relaxed/simple;
	bh=NJ3feP0UV80I0r+dV3L1B37HXuzOV4nS9w5ZSUGr3qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRDo65w1BpEoL7DBusYAMcp1SBJfl+9db9pjqhndk2mLVYDbmuPIJHkB+Yl2qWUFPvaxp02X5HzYWTdsFA97x5vqtkuCwfPW7LFuW3SbFy7njTGhr5kFAgiw6pE36744lZxgcGdYnC/Kj8ykoDjbcNgKrkBWs3YoDTCfljZvBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieTZr3U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE4DC2BBFC
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715244027;
	bh=NJ3feP0UV80I0r+dV3L1B37HXuzOV4nS9w5ZSUGr3qg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ieTZr3U+8QXSSkh6OmhC2UJrxL1a9mb1C8QzQLMozxpTi1xXuKkbq94UHzTH8mmh+
	 ZosD2UaUg/dn3/oPRa+m41fEhOrgKzYdRAkJu5OqbYvIKJZFd/lEFzXyeAUt0xGX/7
	 JSijpIVvkYAtmD4RpfEbssrlSrmejGHdPkl8PQy6hiDfDZFgXdehaNyNAEaIllhQKQ
	 VAQ5tDVQ4JH/S2kS3LmJsVX6QTwH06BBfA4lQmcnK8kOaeU7o2nA1ymeueMQx4q5Sp
	 PzWog0cePZDPsPt0/6j94QvG+9qRlRmhNJ66zT/PeJxUjZS6ecjoHwhpe67NUgBmEG
	 04kLMUUQPIJuA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a8f0d941so140848666b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 01:40:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YwK/T4CsdLocQyWS27Cgh7Mv6i88bb+xcjrDzaX8OaUgs8dZNLk
	56E9AcaAAAT2hG1K4WsAsbRMN33/0xpaS9ctUsxz4UPEiIoVl6aeuZQzxUBiYHNjfWJHhQ7AzRw
	PrANpNQ20FGGki6FQB6bwMN8NUX8=
X-Google-Smtp-Source: AGHT+IF9AacSfuESmxor8XTNioAN/bodeXw7Pbli4axz1UQm6YNNKRdOrgAHnSiDG5xM+j6MDWZoTBi8hdAntf964BI=
X-Received: by 2002:a17:906:ad88:b0:a59:a83b:d43d with SMTP id
 a640c23a62f3a-a59fb94baa1mr284977366b.16.1715244026256; Thu, 09 May 2024
 01:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715169723.git.fdmanana@suse.com> <a9cda79653d2aa3964dec05ec21b96ce8f8f8e4f.1715169723.git.fdmanana@suse.com>
 <cc2ecee5-5ef0-43d0-bd24-c0d538b34c97@gmx.com>
In-Reply-To: <cc2ecee5-5ef0-43d0-bd24-c0d538b34c97@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 May 2024 09:39:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4pv+CtV=joMazn9EMVeC24otxKoR0zThBzaq7qzF-HCQ@mail.gmail.com>
Message-ID: <CAL3q7H4pv+CtV=joMazn9EMVeC24otxKoR0zThBzaq7qzF-HCQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] btrfs: unify index_cnt and csum_bytes from struct btrfs_inode
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:30=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/5/8 21:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The index_cnt field of struct btrfs_inode is used only for two purposes=
:
> >
> > 1) To store the index for the next entry added to a directory;
> >
> > 2) For the data relocation inode to track the logical start address of =
the
> >     block group currently being relocated.
> >
> > For the relocation case we use index_cnt because it's not used for
> > anything else in the relocation use case - we could have used other fie=
lds
> > that are not used by relocation such as defrag_bytes, last_unlink_trans
> > or last_reflink_trans for example (amongs others).
> >
> > Since the csum_bytes field is not used for directories, do the followin=
g
> > changes:
> >
> > 1) Put index_cnt and csum_bytes in a union, and index_cnt is only
> >     initialized when the inode is a directory. The csum_bytes is only
> >     accessed in IO paths for regular files, so we're fine here;
> >
> > 2) Use the defrag_bytes field for relocation, since the data relocation
> >     inode is never used for defrag purposes. And to make the naming bet=
ter,
> >     alias it to reloc_block_group_start by using a union.
> >
> > This reduces the size of struct btrfs_inode by 8 bytes in a release
> > kernel, from 1040 bytes down to 1032 bytes.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/btrfs_inode.h   | 46 +++++++++++++++++++++++++--------------=
-
> >   fs/btrfs/delayed-inode.c |  3 ++-
> >   fs/btrfs/inode.c         | 21 ++++++++++++------
> >   fs/btrfs/relocation.c    | 12 +++++------
> >   fs/btrfs/tree-log.c      |  3 ++-
> >   5 files changed, 54 insertions(+), 31 deletions(-)
> >
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index e577b9745884..19bb3d057414 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -215,11 +215,20 @@ struct btrfs_inode {
> >               u64 last_dir_index_offset;
> >       };
> >
> > -     /*
> > -      * Total number of bytes pending defrag, used by stat to check wh=
ether
> > -      * it needs COW. Protected by 'lock'.
> > -      */
> > -     u64 defrag_bytes;
> > +     union {
> > +             /*
> > +              * Total number of bytes pending defrag, used by stat to =
check whether
> > +              * it needs COW. Protected by 'lock'.
> > +              * Used by inodes other than the data relocation inode.
> > +              */
> > +             u64 defrag_bytes;
> > +
> > +             /*
> > +              * Logical address of the block group being relocated.
> > +              * Used only by the data relocation inode.
> > +              */
> > +             u64 reloc_block_group_start;
> > +     };
> >
> >       /*
> >        * The size of the file stored in the metadata on disk.  data=3Do=
rdered
> > @@ -228,12 +237,21 @@ struct btrfs_inode {
> >        */
> >       u64 disk_i_size;
> >
> > -     /*
> > -      * If this is a directory then index_cnt is the counter for the i=
ndex
> > -      * number for new files that are created. For an empty directory,=
 this
> > -      * must be initialized to BTRFS_DIR_START_INDEX.
> > -      */
> > -     u64 index_cnt;
> > +     union {
> > +             /*
> > +              * If this is a directory then index_cnt is the counter f=
or the
> > +              * index number for new files that are created. For an em=
pty
> > +              * directory, this must be initialized to BTRFS_DIR_START=
_INDEX.
> > +              */
> > +             u64 index_cnt;
> > +
> > +             /*
> > +              * If this is not a directory, this is the number of byte=
s
> > +              * outstanding that are going to need csums. This is used=
 in
> > +              * ENOSPC accounting. Protected by 'lock'.
> > +              */
> > +             u64 csum_bytes;
> > +     };
> >
> >       /* Cache the directory index number to speed the dir/file remove =
*/
> >       u64 dir_index;
> > @@ -256,12 +274,6 @@ struct btrfs_inode {
> >        */
> >       u64 last_reflink_trans;
> >
> > -     /*
> > -      * Number of bytes outstanding that are going to need csums.  Thi=
s is
> > -      * used in ENOSPC accounting. Protected by 'lock'.
> > -      */
> > -     u64 csum_bytes;
> > -
> >       /* Backwards incompatible flags, lower half of inode_item::flags =
 */
> >       u32 flags;
> >       /* Read-only compatibility flags, upper half of inode_item::flags=
 */
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 1373f474c9b6..e298a44eaf69 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -1914,7 +1914,8 @@ int btrfs_fill_inode(struct inode *inode, u32 *rd=
ev)
> >       BTRFS_I(inode)->i_otime_nsec =3D btrfs_stack_timespec_nsec(&inode=
_item->otime);
> >
> >       inode->i_generation =3D BTRFS_I(inode)->generation;
> > -     BTRFS_I(inode)->index_cnt =3D (u64)-1;
> > +     if (S_ISDIR(inode->i_mode))
> > +             BTRFS_I(inode)->index_cnt =3D (u64)-1;
> >
> >       mutex_unlock(&delayed_node->mutex);
> >       btrfs_release_delayed_node(delayed_node);
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 4fd41d6b377f..9b98aa65cc63 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3856,7 +3856,9 @@ static int btrfs_read_locked_inode(struct inode *=
inode,
> >       inode->i_rdev =3D 0;
> >       rdev =3D btrfs_inode_rdev(leaf, inode_item);
> >
> > -     BTRFS_I(inode)->index_cnt =3D (u64)-1;
> > +     if (S_ISDIR(inode->i_mode))
> > +             BTRFS_I(inode)->index_cnt =3D (u64)-1;
> > +
> >       btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
> >                               &BTRFS_I(inode)->flags, &BTRFS_I(inode)->=
ro_flags);
> >
> > @@ -6268,8 +6270,10 @@ int btrfs_create_new_inode(struct btrfs_trans_ha=
ndle *trans,
> >               if (ret)
> >                       goto out;
> >       }
> > -     /* index_cnt is ignored for everything but a dir. */
> > -     BTRFS_I(inode)->index_cnt =3D BTRFS_DIR_START_INDEX;
> > +
> > +     if (S_ISDIR(inode->i_mode))
> > +             BTRFS_I(inode)->index_cnt =3D BTRFS_DIR_START_INDEX;
> > +
> >       BTRFS_I(inode)->generation =3D trans->transid;
> >       inode->i_generation =3D BTRFS_I(inode)->generation;
> >
> > @@ -8435,8 +8439,12 @@ struct inode *btrfs_alloc_inode(struct super_blo=
ck *sb)
> >       ei->disk_i_size =3D 0;
> >       ei->flags =3D 0;
> >       ei->ro_flags =3D 0;
> > +     /*
> > +      * ->index_cnt will be propertly initialized later when creating =
a new
> > +      * inode (btrfs_create_new_inode()) or when reading an existing i=
node
> > +      * from disk (btrfs_read_locked_inode()).
> > +      */
>
> Would above comment be a little confusing?
> As the comment is for csum_bytes, without checking the definition it's
> not clear that csum_bytes and index_cnt is shared.
>
> Maybe just removing it would be good enough?

I found the comment useful, and no better place to put it.
If everyone finds it useless, I'll remove it.

Thanks.

>
> Other wise looks good to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
>
> >       ei->csum_bytes =3D 0;
> > -     ei->index_cnt =3D (u64)-1;
> >       ei->dir_index =3D 0;
> >       ei->last_unlink_trans =3D 0;
> >       ei->last_reflink_trans =3D 0;
> > @@ -8511,9 +8519,10 @@ void btrfs_destroy_inode(struct inode *vfs_inode=
)
> >       if (!S_ISDIR(vfs_inode->i_mode)) {
> >               WARN_ON(inode->delalloc_bytes);
> >               WARN_ON(inode->new_delalloc_bytes);
> > +             WARN_ON(inode->csum_bytes);
> >       }
> > -     WARN_ON(inode->csum_bytes);
> > -     WARN_ON(inode->defrag_bytes);
> > +     if (!root || !btrfs_is_data_reloc_root(root))
> > +             WARN_ON(inode->defrag_bytes);
> >
> >       /*
> >        * This can happen where we create an inode, but somebody else al=
so
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 8b24bb5a0aa1..9f35524b6664 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -962,7 +962,7 @@ static int get_new_location(struct inode *reloc_ino=
de, u64 *new_bytenr,
> >       if (!path)
> >               return -ENOMEM;
> >
> > -     bytenr -=3D BTRFS_I(reloc_inode)->index_cnt;
> > +     bytenr -=3D BTRFS_I(reloc_inode)->reloc_block_group_start;
> >       ret =3D btrfs_lookup_file_extent(NULL, root, path,
> >                       btrfs_ino(BTRFS_I(reloc_inode)), bytenr, 0);
> >       if (ret < 0)
> > @@ -2797,7 +2797,7 @@ static noinline_for_stack int prealloc_file_exten=
t_cluster(
> >       u64 alloc_hint =3D 0;
> >       u64 start;
> >       u64 end;
> > -     u64 offset =3D inode->index_cnt;
> > +     u64 offset =3D inode->reloc_block_group_start;
> >       u64 num_bytes;
> >       int nr;
> >       int ret =3D 0;
> > @@ -2951,7 +2951,7 @@ static int relocate_one_folio(struct inode *inode=
, struct file_ra_state *ra,
> >                             int *cluster_nr, unsigned long index)
> >   {
> >       struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> > -     u64 offset =3D BTRFS_I(inode)->index_cnt;
> > +     u64 offset =3D BTRFS_I(inode)->reloc_block_group_start;
> >       const unsigned long last_index =3D (cluster->end - offset) >> PAG=
E_SHIFT;
> >       gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping);
> >       struct folio *folio;
> > @@ -3086,7 +3086,7 @@ static int relocate_one_folio(struct inode *inode=
, struct file_ra_state *ra,
> >   static int relocate_file_extent_cluster(struct inode *inode,
> >                                       const struct file_extent_cluster =
*cluster)
> >   {
> > -     u64 offset =3D BTRFS_I(inode)->index_cnt;
> > +     u64 offset =3D BTRFS_I(inode)->reloc_block_group_start;
> >       unsigned long index;
> >       unsigned long last_index;
> >       struct file_ra_state *ra;
> > @@ -3915,7 +3915,7 @@ static noinline_for_stack struct inode *create_re=
loc_inode(
> >               inode =3D NULL;
> >               goto out;
> >       }
> > -     BTRFS_I(inode)->index_cnt =3D group->start;
> > +     BTRFS_I(inode)->reloc_block_group_start =3D group->start;
> >
> >       ret =3D btrfs_orphan_add(trans, BTRFS_I(inode));
> >   out:
> > @@ -4395,7 +4395,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_=
extent *ordered)
> >   {
> >       struct btrfs_inode *inode =3D BTRFS_I(ordered->inode);
> >       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> > -     u64 disk_bytenr =3D ordered->file_offset + inode->index_cnt;
> > +     u64 disk_bytenr =3D ordered->file_offset + inode->reloc_block_gro=
up_start;
> >       struct btrfs_root *csum_root =3D btrfs_csum_root(fs_info, disk_by=
tenr);
> >       LIST_HEAD(list);
> >       int ret;
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 5146387b416b..0aee43466c52 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -1625,7 +1625,8 @@ static noinline int fixup_inode_link_count(struct=
 btrfs_trans_handle *trans,
> >               if (ret)
> >                       goto out;
> >       }
> > -     BTRFS_I(inode)->index_cnt =3D (u64)-1;
> > +     if (S_ISDIR(inode->i_mode))
> > +             BTRFS_I(inode)->index_cnt =3D (u64)-1;
> >
> >       if (inode->i_nlink =3D=3D 0) {
> >               if (S_ISDIR(inode->i_mode)) {

