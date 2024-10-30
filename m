Return-Path: <linux-btrfs+bounces-9234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AF69B5A51
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 04:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B62F1B2252E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B751991BD;
	Wed, 30 Oct 2024 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoYH8AO5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280815E96;
	Wed, 30 Oct 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258576; cv=none; b=kb0mIoSu86NKeDLt8aXwJMvZcZEgI8Ivesfb/A1dmEYCJz9ma9LifkOeB+g9EHtod/LdpDPqaXWb8xIf44c3jzN7o3TMcsNda5+IZbHvYrMylrLNt9EbhpbZL1ejDO+AjHcrWg5RSp/pD0SiBkjj1DxLSJSr/0+JpWmR/lf10eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258576; c=relaxed/simple;
	bh=7LdLeyC91oYolHTxW8qO5k7n1UFa1LaDj5VPQLULCuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJHDOdagV8tz7ZTdMxpVwKZgG5bilq1INvmUBLObiEpNc9ayScuDT9YnKBbewFDSN76/zC6Gnof5h9V8Me/UquBFpMJw16OpujH4v3UKUkzekew5wfaKqv96rBOPGDBadRwCBkwb74YF9twXW+t8Ej3PD1TNL3qWSc3NWLOS1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoYH8AO5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so7203374a12.0;
        Tue, 29 Oct 2024 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730258572; x=1730863372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To+9twS6JlN4C9uCDBQQCtjCfMww1W/Bkv+Om9NWJIc=;
        b=MoYH8AO52fg2Je3wIoMFlHxnbLTaJmrCw71etrJzU65ZUlMHZKI7fAh1alN2R2GiBL
         shSgM+1dUjvEQu+Ey8s/7U/GXF6NpjR8UsOzuMz1QaJDL8vwTgeupw42P4i1G7QvKeAe
         Majodwl3ngrYlPqsJIOb6qCOTrNsiDuIlWYOk/5EDi+1DiNib7QooEieFkLE7QjCu9gI
         66RANDkDzHG1WYnje2TG1fv0s5wuDV2oeqwPbAA0iROx7R1P2CtDZHV9OFci5pmQirgM
         Sw/PL7awbFGpPVSJQ3WVVGAxxg6/R6UUZN83ofLva0bRm6OwebFCwLbHbVpPL0mNZbOs
         PGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730258572; x=1730863372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To+9twS6JlN4C9uCDBQQCtjCfMww1W/Bkv+Om9NWJIc=;
        b=NYtBgjXpbX9Y0qV1W+5z0KiI0KwJ2RyaBAZAXTS+W/+37KW5tXX0RS4TTeRb78pE//
         oPcUIWEGSZ8XybiT90C6I3u3Dl62a1+5Xf34fW0Bh2t3Rvy+J4fmNb8DHvT/zh4XgOLL
         RdSjs3YZu81rx+XWVSl811luBgPMMhLVLKh0lO2Y3oEhNb4XBh4ptNSDSqTpuHJFHM9L
         ND7gHZ+dXjR90Mv6GgCmSUnuOzrxi+Wi3BCG/7Tu7F9d+fXcGRBCzKQ1MFOJnz3uf4Gj
         pMGDJbk/HvyU00CIL39F2Rb4O/FOJ6AuCsHHznnH+DDRLNTg7GZihq/IbzWJ0KS3KkMK
         xDRA==
X-Forwarded-Encrypted: i=1; AJvYcCXSA8gL/AWUebuqyuke2N32JQDC72p4gEiqzBepRqp61FW9zaS6P1DWk+mQjhXupIAb4zNc3vL5jsqP0Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Yqy2XS8tchEs0fxg7Uafeg8dfs1Foaj7vR5NdrC8lHEuao18
	hiLh+aiP89Rfsm6HYSBwiXLt24YbGRH7UCU6zrQFkDv8/79nE8lYFJgVOLhY2AUIO7GaRBl9sM1
	KOfTV3DarbSpwvwLxtflAbhTagaY=
X-Google-Smtp-Source: AGHT+IEsG/L+s3k3Lf5oCaIQBOgD8O/tG2xqN/WjAMGdKRHg1CwbulOeVA7wg43Unry5XWnV4uxM/biJS7HiMz5NgEI=
X-Received: by 2002:a17:907:940e:b0:a99:ce2f:b0ff with SMTP id
 a640c23a62f3a-a9de5eccebcmr1418601066b.33.1730258572257; Tue, 29 Oct 2024
 20:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025065448.3231672-1-haisuwang@tencent.com>
 <20241025065448.3231672-3-haisuwang@tencent.com> <4d0603d4-1503-4e8f-bfe2-ed205b598072@gmx.com>
In-Reply-To: <4d0603d4-1503-4e8f-bfe2-ed205b598072@gmx.com>
From: hs wang <iamhswang@gmail.com>
Date: Wed, 30 Oct 2024 11:22:40 +0800
Message-ID: <CALv5hoSEPXi3dNXg1DMKJQ3R3OnzVew+tNJQssWGt2g4O8aSiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: simplify regions mark and keep start unchanged
 in err handling
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, wqu@suse.com, boris@bur.io, linux-kernel@vger.kernel.org, 
	Haisu Wang <haisuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=B8=89 11:01=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> =E5=9C=A8 2024/10/25 17:24, iamhswang@gmail.com =E5=86=99=E9=81=93:
> > From: Haisu Wang <haisuwang@tencent.com>
> >
> > Simplify the regions mark by using cur_alloc_size only to present
> > the reserved but may failed to alloced extent. Remove the ram_size
> > as well since it is always consistent to the cur_alloc_size in the
> > context. Advanced the start mark in normal path until extent succeed
> > alloced and keep the start unchanged in error handling path.
> >
> > PASSed the fstest generic/475 test for a hundred times with quota
> > enabled. And a modified generic/475 test by removing the sleep time
> > for a hundred times. About one tenth of the tests do enter the error
> > handling path due to fail to reserve extent.
> >
>
> Although this patch is already merged into for-next, it looks like the
> next patch will again change the error handling, mostly render the this
> one useless:
>
> https://lore.kernel.org/linux-btrfs/2a0925f0264daf90741ed0a7ba7ed4b4888cf=
778.1728725060.git.wqu@suse.com/
>
> The newer patch will change the error handling to a simpler one, so
> instead of 3 regions, there will be only 2.
>
Sounds better and a completely rewrite, i will catch up the details.

> There will be no change needed from your side, I will update my patches
> to solve the conflicts, just in case if you find the error handling is
> different in the future.
>

Thanks. Understanding the changes, may compile and play after the polishmen=
t.

Best regards,
Haisu Wang

> Thanks,
> Qu
>
> > Suggested-by: Qu Wenruo <wqu@suse.com>
> > Signed-off-by: Haisu Wang <haisuwang@tencent.com>
> > ---
> >   fs/btrfs/inode.c | 32 ++++++++++++++------------------
> >   1 file changed, 14 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 3646734a7e59..7e67a6d50be2 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1359,7 +1359,6 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >       u64 alloc_hint =3D 0;
> >       u64 orig_start =3D start;
> >       u64 num_bytes;
> > -     unsigned long ram_size;
> >       u64 cur_alloc_size =3D 0;
> >       u64 min_alloc_size;
> >       u64 blocksize =3D fs_info->sectorsize;
> > @@ -1367,7 +1366,6 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >       struct extent_map *em;
> >       unsigned clear_bits;
> >       unsigned long page_ops;
> > -     bool extent_reserved =3D false;
> >       int ret =3D 0;
> >
> >       if (btrfs_is_free_space_inode(inode)) {
> > @@ -1421,8 +1419,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >               struct btrfs_ordered_extent *ordered;
> >               struct btrfs_file_extent file_extent;
> >
> > -             cur_alloc_size =3D num_bytes;
> > -             ret =3D btrfs_reserve_extent(root, cur_alloc_size, cur_al=
loc_size,
> > +             ret =3D btrfs_reserve_extent(root, num_bytes, num_bytes,
> >                                          min_alloc_size, 0, alloc_hint,
> >                                          &ins, 1, 1);
> >               if (ret =3D=3D -EAGAIN) {
> > @@ -1453,9 +1450,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >               if (ret < 0)
> >                       goto out_unlock;
> >               cur_alloc_size =3D ins.offset;
> > -             extent_reserved =3D true;
> >
> > -             ram_size =3D ins.offset;
> >               file_extent.disk_bytenr =3D ins.objectid;
> >               file_extent.disk_num_bytes =3D ins.offset;
> >               file_extent.num_bytes =3D ins.offset;
> > @@ -1463,14 +1458,14 @@ static noinline int cow_file_range(struct btrfs=
_inode *inode,
> >               file_extent.offset =3D 0;
> >               file_extent.compression =3D BTRFS_COMPRESS_NONE;
> >
> > -             lock_extent(&inode->io_tree, start, start + ram_size - 1,
> > +             lock_extent(&inode->io_tree, start, start + cur_alloc_siz=
e - 1,
> >                           &cached);
> >
> >               em =3D btrfs_create_io_em(inode, start, &file_extent,
> >                                       BTRFS_ORDERED_REGULAR);
> >               if (IS_ERR(em)) {
> >                       unlock_extent(&inode->io_tree, start,
> > -                                   start + ram_size - 1, &cached);
> > +                                   start + cur_alloc_size - 1, &cached=
);
> >                       ret =3D PTR_ERR(em);
> >                       goto out_reserve;
> >               }
> > @@ -1480,7 +1475,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >                                                    1 << BTRFS_ORDERED_R=
EGULAR);
> >               if (IS_ERR(ordered)) {
> >                       unlock_extent(&inode->io_tree, start,
> > -                                   start + ram_size - 1, &cached);
> > +                                   start + cur_alloc_size - 1, &cached=
);
> >                       ret =3D PTR_ERR(ordered);
> >                       goto out_drop_extent_cache;
> >               }
> > @@ -1501,7 +1496,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >                        */
> >                       if (ret)
> >                               btrfs_drop_extent_map_range(inode, start,
> > -                                                         start + ram_s=
ize - 1,
> > +                                                         start + cur_a=
lloc_size - 1,
> >                                                           false);
> >               }
> >               btrfs_put_ordered_extent(ordered);
> > @@ -1519,7 +1514,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >               page_ops =3D (keep_locked ? 0 : PAGE_UNLOCK);
> >               page_ops |=3D PAGE_SET_ORDERED;
> >
> > -             extent_clear_unlock_delalloc(inode, start, start + ram_si=
ze - 1,
> > +             extent_clear_unlock_delalloc(inode, start, start + cur_al=
loc_size - 1,
> >                                            locked_folio, &cached,
> >                                            EXTENT_LOCKED | EXTENT_DELAL=
LOC,
> >                                            page_ops);
> > @@ -1529,7 +1524,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >                       num_bytes -=3D cur_alloc_size;
> >               alloc_hint =3D ins.objectid + ins.offset;
> >               start +=3D cur_alloc_size;
> > -             extent_reserved =3D false;
> > +             cur_alloc_size =3D 0;
> >
> >               /*
> >                * btrfs_reloc_clone_csums() error, since start is increa=
sed
> > @@ -1545,7 +1540,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >       return ret;
> >
> >   out_drop_extent_cache:
> > -     btrfs_drop_extent_map_range(inode, start, start + ram_size - 1, f=
alse);
> > +     btrfs_drop_extent_map_range(inode, start, start + cur_alloc_size =
- 1, false);
> >   out_reserve:
> >       btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> >       btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
> > @@ -1599,13 +1594,12 @@ static noinline int cow_file_range(struct btrfs=
_inode *inode,
> >        * to decrement again the data space_info's bytes_may_use counter=
,
> >        * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
> >        */
> > -     if (extent_reserved) {
> > +     if (cur_alloc_size) {
> >               extent_clear_unlock_delalloc(inode, start,
> >                                            start + cur_alloc_size - 1,
> >                                            locked_folio, &cached, clear=
_bits,
> >                                            page_ops);
> >               btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size=
, NULL);
> > -             start +=3D cur_alloc_size;
> >       }
> >
> >       /*
> > @@ -1614,11 +1608,13 @@ static noinline int cow_file_range(struct btrfs=
_inode *inode,
> >        * space_info's bytes_may_use counter, reserved in
> >        * btrfs_check_data_free_space().
> >        */
> > -     if (start < end) {
> > +     if (start + cur_alloc_size < end) {
> >               clear_bits |=3D EXTENT_CLEAR_DATA_RESV;
> > -             extent_clear_unlock_delalloc(inode, start, end, locked_fo=
lio,
> > +             extent_clear_unlock_delalloc(inode, start + cur_alloc_siz=
e,
> > +                                          end, locked_folio,
> >                                            &cached, clear_bits, page_op=
s);
> > -             btrfs_qgroup_free_data(inode, NULL, start, end - start + =
1, NULL);
> > +             btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_siz=
e,
> > +                             end - start - cur_alloc_size + 1, NULL);
> >       }
> >       return ret;
> >   }
>

