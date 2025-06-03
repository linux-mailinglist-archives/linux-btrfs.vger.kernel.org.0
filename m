Return-Path: <linux-btrfs+bounces-14410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8323ACC8B8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E77B3A61C7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 14:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A9238D2B;
	Tue,  3 Jun 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD4nJ6fh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F62356CF
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959626; cv=none; b=fNsKwopdVJgeU0QJaduJdpz5IfWuczAvUHLBNttSy7NOFLWisaaKX4VhC+5w5zVW2P/RANFZ4xudhcYzdJkbrWLiM+pjLO6Ou8J68yhe0Hp9tRn8olBEfnoACkUIjRH/gplcKrmFUznKvR5IMBF7z9/cHJKskq8kpN6/N9dqsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959626; c=relaxed/simple;
	bh=gu3IiVII4pBQY1VXN7jxKpJg0r7xnUZr264WM6jpwR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEKgIKqbBnPVzCl6BnNuqS4pqWIziS18l45nvZUWhsOjQBBlZMb/bvJTr+euwtGaP5d2KUOhWsNf9WnKVR6lZ7725IOg2nmLaNOFCT6si8zJrXrRSSylIB1vsEgbxDzKcIQvUrMBgc9rBWs08H/c3TPyzowLJjYJ0+EE8GVCW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD4nJ6fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B482BC4CEF0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748959625;
	bh=gu3IiVII4pBQY1VXN7jxKpJg0r7xnUZr264WM6jpwR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DD4nJ6fh/M8AMWX9q5e5iMbc1UPGDrnEcXvxnvygytHTSV/7s/WxtjTUWFmTzPMCp
	 a6yQJ0TCBKL7gYxBXHJuTokRnSZQVKi9eogtoeEcHUMbfDIWQZPWqQyVodPlprs6pR
	 XTR9wmZ+Sbyqq+jWO+JCRf1fxSOdk8/b/Ah8bm+6JqS6HRoL4GpgajvtALzMtdoUm6
	 8VMEHQkZ+Pi5dGb1q1dWUh0vD4vlq9dbWN9wb+yqwe1NqDF+w+FRQztlZ8Xhuc20lT
	 /TqlrrbjyMV79Q6laj7g4EG4QEtnj/yJVEbYwarXnPJDRuGH8io0vJ9brgx4qJOsMH
	 I/QWOPczfz62w==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so11056825a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Jun 2025 07:07:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+8Ws+giJa/rUX/5pPmfRBWrmscPBXICGNAfR3WlF50vZfdvZyxDxtjaE41NFOFxg9DLFN7ZjEzHqXsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEz7ncuUBoAhAheGXpYmvLn9zYZVTc2Ho71o/jUlCnGaI8VpVo
	i9pGatYw1R417QeYMlzVrLwlZ8Td593Xc6b8r9j86KZgMox7lhxj4efEE28SRuJyFcb3ZM+Rw0I
	3BzRVDaOiE1DYM6fohEPkWUlsgHAdP8k=
X-Google-Smtp-Source: AGHT+IG88/1Hsx3R81t2X3IMWtVNXGdqwtuEW4utfK5wA9FZOR2lb4+TLHQDZWcW1iXsnVvo1gjotlw/4sseHYWiD9E=
X-Received: by 2002:a17:907:971c:b0:ad8:9428:6a3c with SMTP id
 a640c23a62f3a-adb36afd4bbmr1540130266b.11.1748959624284; Tue, 03 Jun 2025
 07:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603061401.217412-1-jth@kernel.org> <d8e6b335-a47a-4e31-afce-c7b9a87e6b43@wdc.com>
In-Reply-To: <d8e6b335-a47a-4e31-afce-c7b9a87e6b43@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Jun 2025 15:06:26 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7OOQF_VgBHtJ4iPHQ8Fbn=gu4-Wgb6Kn33PBoijwrS6g@mail.gmail.com>
X-Gm-Features: AX0GCFtcLPrDOCH3DBbKGk3ITmAFpC6Qe3bVKEFiid1hPsAEpC6VRNgDmaW5J_4
Message-ID: <CAL3q7H7OOQF_VgBHtJ4iPHQ8Fbn=gu4-Wgb6Kn33PBoijwrS6g@mail.gmail.com>
Subject: Re: [PATCH v4] btrfs: zoned: reserve data_reloc block group on mount
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <Naohiro.Aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 12:23=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 03.06.25 08:14, Johannes Thumshirn wrote:
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >
> > Create a block group dedicated for data relocation on mount of a zoned
> > filesystem.
> >
> > If there is already more than one empty DATA block group on mount, this
> > one is picked for the data relocation block group, instead of a newly
> > created one.
> >
> > This is done to ensure, there is always space for performing garbage
> > collection and the filesystem is not hitting ENOSPC under heavy overwri=
te
> > workloads.
> >
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Unfortunately this can result in a FS corruption if the accompanying
> mkfs patch is not applied.
>
> I think it is, because I'm not waiting for the transaction to be written
> out in case we need to allocate a chunk. Therefor metadata on DUP can
> get out of sync somehow when one copy is on a sequential zone and one on
> a conventional zone.

Not familiar with the zone specific problems, but in order to use a
new chunk, there's no need to commit a transaction.
And if for some weird reason that is a problem for the zoned case, how
about committing the transaction after allocating the chunk? Does it
still cause any issue?

>
>
> >   fs/btrfs/disk-io.c |  1 +
> >   fs/btrfs/zoned.c   | 61 +++++++++++++++++++++++++++++++++++++++++++++=
+
> >   fs/btrfs/zoned.h   |  3 +++
> >   3 files changed, 65 insertions(+)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 3def93016963..b211dc8cdb86 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3562,6 +3562,7 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
> >               goto fail_sysfs;
> >       }
> >
> > +     btrfs_zoned_reserve_data_reloc_bg(fs_info);
> >       btrfs_free_zone_cache(fs_info);
> >
> >       btrfs_check_active_zone_reservation(fs_info);
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 19710634d63f..a31aa129cb0f 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -17,6 +17,7 @@
> >   #include "fs.h"
> >   #include "accessors.h"
> >   #include "bio.h"
> > +#include "transaction.h"
> >
> >   /* Maximum number of zones to report per blkdev_report_zones() call *=
/
> >   #define BTRFS_REPORT_NR_ZONES   4096
> > @@ -2443,6 +2444,66 @@ void btrfs_clear_data_reloc_bg(struct btrfs_bloc=
k_group *bg)
> >       spin_unlock(&fs_info->relocation_bg_lock);
> >   }
> >
> > +void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
> > +{
> > +     struct btrfs_space_info *data_sinfo =3D fs_info->data_sinfo;
> > +     struct btrfs_space_info *space_info =3D data_sinfo->sub_group[0];
> > +     struct btrfs_trans_handle *trans;
> > +     struct btrfs_block_group *bg;
> > +     struct list_head *bg_list;
> > +     u64 alloc_flags;
> > +     bool initial =3D false;
> > +     bool did_chunk_alloc =3D false;
> > +     int index;
> > +     int ret;
> > +
> > +     if (!btrfs_is_zoned(fs_info))
> > +             return;
> > +
> > +     if (fs_info->data_reloc_bg)
> > +             return;
> > +
> > +     if (sb_rdonly(fs_info->sb))
> > +             return;
> > +
> > +     ASSERT(space_info->subgroup_id =3D=3D BTRFS_SUB_GROUP_DATA_RELOC)=
;
> > +     alloc_flags =3D btrfs_get_alloc_profile(fs_info, space_info->flag=
s);
> > +     index =3D btrfs_bg_flags_to_raid_index(alloc_flags);
> > +
> > +     bg_list =3D &data_sinfo->block_groups[index];
> > +again:
> > +     list_for_each_entry(bg, bg_list, list) {
> > +             if (bg->used > 0)
> > +                     continue;
> > +
> > +             if (!initial) {
> > +                     initial =3D true;
> > +                     continue;
> > +             }
> > +
> > +             fs_info->data_reloc_bg =3D bg->start;
> > +             set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_f=
lags);
> > +             btrfs_zone_activate(bg);
> > +
> > +             return;
> > +     }
> > +
> > +     if (did_chunk_alloc)
> > +             return;
> > +
> > +     trans =3D btrfs_join_transaction(fs_info->tree_root);
> > +     if (IS_ERR(trans))
> > +             return;
> > +
> > +     ret =3D btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_A=
LLOC_FORCE);
> > +     btrfs_end_transaction(trans);
> > +     if (ret =3D=3D 1) {
> > +             did_chunk_alloc =3D true;
> > +             bg_list =3D &space_info->block_groups[index];
> > +             goto again;
> > +     }
> > +}
> > +
> >   void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
> >   {
> >       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> > diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> > index 9672bf4c3335..6e11533b8e14 100644
> > --- a/fs/btrfs/zoned.h
> > +++ b/fs/btrfs/zoned.h
> > @@ -88,6 +88,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs=
_info, u64 logical,
> >   void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
> >                                  struct extent_buffer *eb);
> >   void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
> > +void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info);
> >   void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
> >   bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
> >   void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info,=
 u64 logical,
> > @@ -241,6 +242,8 @@ static inline void btrfs_schedule_zone_finish_bg(st=
ruct btrfs_block_group *bg,
> >
> >   static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group=
 *bg) { }
> >
> > +static inline void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_i=
nfo *fs_info) { }
> > +
> >   static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_inf=
o) { }
> >
> >   static inline bool btrfs_zoned_should_reclaim(const struct btrfs_fs_i=
nfo *fs_info)
>

