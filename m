Return-Path: <linux-btrfs+bounces-19124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7A8C6D2FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 08:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C2634F7F4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D3F325737;
	Wed, 19 Nov 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S8IJqCxu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBCA2DC764
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537670; cv=none; b=GYP0QnAb786nxn4J6iPbyZbDvNEh0GRr/SPVtD0kUzp3OgnV7FBFtKdOohf4MccG/hSZxivJDzULhG8MAL6AHy8LBOH5S4mLvogtZjO94jT/ZMgDHhcVwxXoylZzLDgohsuUrwioTzkUV45y3W+nj9q9VjvndLFMupmRwIFJscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537670; c=relaxed/simple;
	bh=1SoBZt0cYL52372/pp1u0OUymR7UuS5XUtkBFNn2RSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtWNvcRH7XPl7A2bbAI97FBri6NAL4tc2ehtMAF3Qxknvm7/HBmH9XAvush49YB6KSswhQ+RV2ne4+NmJJ0S0Lt2u1HmCgkA31Hk+caBbMEs9x21GPHU2tGX6h9D4gfe3aOGsraLwAx8JEIrGNnZ5rtVsUHiyseLa+FPVUVQwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S8IJqCxu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c48e05aeso345348f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 23:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763537665; x=1764142465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e8ff4S6df/0n7yDxjbIR5wijc4V217M+RhYxscjhVE=;
        b=S8IJqCxuLfERv1hJkB96H6oNDp16VHabvVO58hxehPL7FR97gUhWaLnZaPGWjmLwr3
         1LrgiHe89mk0hV0h7ZC+LS2XfxGCMFIHSgdZjsdWA7NKYKwFCx7qPEcPwqDqYjlNtHcW
         hz0orzzE8k4yoL5RnCUycIPOoBBlhebYdTWHij+tolPSRdJCxYbsrk4DMkbxEA0qkHXE
         i4/HkrFrU93uFFI3/jOrc6eWk2T8RHjKBMtZi2BQCsVj6vj+kLh4IRpc9ve8qTx6Gyi1
         qwexjBa+uJkx+SMXM4AkH5JDbr4+Va1rPOoxC0tyvOUcAmcbSHSP+6XOwfk5lWDk5gVn
         M9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537665; x=1764142465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5e8ff4S6df/0n7yDxjbIR5wijc4V217M+RhYxscjhVE=;
        b=d4mV6dj1Z7x/m808wEi8sCsH0gesuxEmeRxQhwArOna+UbTy18H/Seh/oAoCFY00l9
         TPUOEhjHQUQ+10Wz1WRd3wV8VJnZVBxtrdghvihbPAWpDXbA1fXfBBMuS32VsMFAV7Um
         MYz+0M7hmUDpJbWkN0NxzhCv4GRtlvnPnNBiOzA/ZV6Rb3jjz7mXSsjpNEGwiTURMGGR
         xVjNPS7W5ObeTTPjp/Tb7x1RzQ0HyVTAZsAVMGrVFypzhvrP+UPtQoOU5ZgCbjrotCom
         v1ehr/bmFTJGv5A8kt4maOJS9z/kOvnO5jjk+7RxFUq1Ix+mbOjm0rZYwtMMyo+Ye/Lg
         UD9A==
X-Forwarded-Encrypted: i=1; AJvYcCUNmz+lPJWWpP6pwEtGaHNYSVW1LnEpE8YLYBAUBrMvL3bNk5MUQb9s4GQI2MhTI8NdHBQ3ZPF5M9c7qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gciLHIkUISEMvcjLmS14it3rUH3ukiKSTHtmih2yu9POkxFo
	7wpySojzhh8m/0rWegpKJR1ldwtpV/6+1fPsI1Sog1G2tTmH8UHWY2jPF2AplfHc5IFE7rpxaX1
	vdk47vV5B5AePkoRIMWa7Z6UkcZR6rCD6QOp8J7ohnA==
X-Gm-Gg: ASbGncth5yfumwhz59p+9RoK25I1XIeULuRtD0OqmhwTrufPBDvg7/uMO90avrF36do
	10N/UOmoZZN3y/EaTow72ziQehXb+3AvQvtdu8Jv7ZxFBwA93hEw6R4Cn9+ySVTHWrA1rv5tYAB
	dPq7kCtL37vs3Yf/S9WjGJRZT5UCFE13+ypci0m+HCXBuJh8CbFr5L481q/atMXyPN3mb6Graym
	b/mUwwbEh+7SRLAmYcFFR+pRn3EnqUqUP6UVpFZzzR0GXGkIfuqvL7WerLZuH5Xf0b132kWKUuj
	Rvob/3+Kkc8nMhhBCWs89k4RQZkTZMs2DGiIIdgmJl6j5LbF/d+or3GrVmDZDEGp5C2w
X-Google-Smtp-Source: AGHT+IHB4jBPJtyWa0413RgEfh0Pwc62G6cEVW/OsT7ocnNvJJ7o2C5WkJWMWfgJixlosmcwM1jbtVItJC3PlkR+L4I=
X-Received: by 2002:a05:6000:2385:b0:429:cc35:7032 with SMTP id
 ffacd0b85a97d-42cb20e1d1dmr1328905f8f.23.1763537664847; Tue, 18 Nov 2025
 23:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com> <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com> <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
 <84128576-17f4-460a-9d2f-9e40f43f2ef7@gmx.com>
In-Reply-To: <84128576-17f4-460a-9d2f-9e40f43f2ef7@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 19 Nov 2025 08:34:13 +0100
X-Gm-Features: AWmQ_blTB249VwtrI46O7KovsaVIPjYnR23sonc6CfqEYNQbvH4P9N_et08DGVw
Message-ID: <CAPjX3FedNEUeGr3sROdHaT0iKhHDfsi4V=GQHcmvhx6wEJqUcg@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2025 at 22:05, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> =E5=9C=A8 2025/11/19 00:35, Daniel Vacek =E5=86=99=E9=81=93:
> > On Thu, 13 Nov 2025 at 21:16, Qu Wenruo <wqu@suse.com> wrote:
> [...]
> >> Then why put the original bio pointer into the super generic btrfs_bio=
?
> >
> > When encryption is enabled, it's not going to be the original bio but
> > rather the encrypted one.
> >
> > But giving it another thought and checking the related fscrypt code,
> > the encrypted bio is allocated in  blk_crypto_fallback_encrypt_bio()
> > and freed in blk_crypto_fallback_encrypt_endio() before calling
> > bio_endio() on our original plaintext bio.
> > This means we have no control over the bounce bio lifetime and we
> > cannot store the pointer and use it asynchronously.
>
> Sorry I didn't get the point why we can not calculate the csum async.
>
> Higher layer just submit a btrfs_bio, its content is the encrypted conten=
ts.
>
> As long as it's still a btrfs_bio, we have all the needed structures to
> do async csum.
> We still need to submit the bio for writes, and that means we have
> enough time to calculate the csum async, and before the endio function
> called, we're able to do whatever we need, the bio won't be suddenly
> gone during the submission.
>
> Unless you mean the encrypted bio is not encapsulated by btrfs_bio, but
> a vanilla bio.

That's the case. The bounce bio is created when you submit the
original one. The data is encrypted by fscrypt, then the csum hook is
called and the new bio submitted instead of the original one. Later
the endio frees the new one and calls endio on the original bio. This
means we don't have control over the bounce bio and cannot use it
asynchronously at the moment. The csum needs to be finished directly
in the hook.

Anyways, the hook changes are not upstreamed yet, so you can only see
it on the mailing list. And that's also why this patch makes more
sense to be sent later together with those changes.

--nX

> In that case you can not even submit it through btrfs_submit_bbio().
>
> Thanks,
> Qu
>
> > We'll need to
> > always compute the checksum synchronously for encrypted bios. In that
> > case we don't need to store it in btrfs_bio::csum_bio at all. For the
> > regular (unencrypted) case we can keep using the &bbio->bio.
> >
> > I'll drop the csum_bio for there is no use really.
> >
> > --nX
> >
> >> I thought it's more common to put the original plaintext into the
> >> encryption specific structure, like what we did for compression.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> --nX
> >>>
> >>>> The storage layer doesn't need to bother the plaintext bio at all, t=
hey
> >>>> just write the encrypted one to disk.
> >>>>
> >>>> And it's the dm-crypto tracking the plaintext bio <-> encrypted bio =
mapping.
> >>>>
> >>>>
> >>>> So why we can not just create a new bio for the final csum caculatio=
n,
> >>>> just like compression?
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>>
> >>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >>>>> Signed-off-by: Daniel Vacek <neelx@suse.com>
> >>>>> ---
> >>>>> Compared to v5 this needed to adapt to recent async csum changes.
> >>>>> ---
> >>>>>     fs/btrfs/bio.c       |  4 ++--
> >>>>>     fs/btrfs/bio.h       |  1 +
> >>>>>     fs/btrfs/file-item.c | 17 ++++++++---------
> >>>>>     fs/btrfs/file-item.h |  2 +-
> >>>>>     4 files changed, 12 insertions(+), 12 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> >>>>> index a73652b8724a..a69174b2b6b6 100644
> >>>>> --- a/fs/btrfs/bio.c
> >>>>> +++ b/fs/btrfs/bio.c
> >>>>> @@ -542,9 +542,9 @@ static int btrfs_bio_csum(struct btrfs_bio *bbi=
o)
> >>>>>         if (bbio->bio.bi_opf & REQ_META)
> >>>>>                 return btree_csum_one_bio(bbio);
> >>>>>     #ifdef CONFIG_BTRFS_EXPERIMENTAL
> >>>>> -     return btrfs_csum_one_bio(bbio, true);
> >>>>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, true);
> >>>>>     #else
> >>>>> -     return btrfs_csum_one_bio(bbio, false);
> >>>>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, false);
> >>>>>     #endif
> >>>>>     }
> >>>>>
> >>>>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> >>>>> index deaeea3becf4..c5a6c66d51a0 100644
> >>>>> --- a/fs/btrfs/bio.h
> >>>>> +++ b/fs/btrfs/bio.h
> >>>>> @@ -58,6 +58,7 @@ struct btrfs_bio {
> >>>>>                         struct btrfs_ordered_sum *sums;
> >>>>>                         struct work_struct csum_work;
> >>>>>                         struct completion csum_done;
> >>>>> +                     struct bio *csum_bio;
> >>>>>                         struct bvec_iter csum_saved_iter;
> >>>>>                         u64 orig_physical;
> >>>>>                 };
> >>>>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> >>>>> index 72be3ede0edf..474949074da8 100644
> >>>>> --- a/fs/btrfs/file-item.c
> >>>>> +++ b/fs/btrfs/file-item.c
> >>>>> @@ -765,21 +765,19 @@ int btrfs_lookup_csums_bitmap(struct btrfs_ro=
ot *root, struct btrfs_path *path,
> >>>>>         return ret;
> >>>>>     }
> >>>>>
> >>>>> -static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter =
*src)
> >>>>> +static void csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, =
struct bvec_iter *iter)
> >>>>>     {
> >>>>>         struct btrfs_inode *inode =3D bbio->inode;
> >>>>>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >>>>>         SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> >>>>> -     struct bio *bio =3D &bbio->bio;
> >>>>>         struct btrfs_ordered_sum *sums =3D bbio->sums;
> >>>>> -     struct bvec_iter iter =3D *src;
> >>>>>         phys_addr_t paddr;
> >>>>>         const u32 blocksize =3D fs_info->sectorsize;
> >>>>>         int index =3D 0;
> >>>>>
> >>>>>         shash->tfm =3D fs_info->csum_shash;
> >>>>>
> >>>>> -     btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
> >>>>> +     btrfs_bio_for_each_block(paddr, bio, iter, blocksize) {
> >>>>>                 btrfs_calculate_block_csum(fs_info, paddr, sums->su=
ms + index);
> >>>>>                 index +=3D fs_info->csum_size;
> >>>>>         }
> >>>>> @@ -791,19 +789,18 @@ static void csum_one_bio_work(struct work_str=
uct *work)
> >>>>>
> >>>>>         ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
> >>>>>         ASSERT(bbio->async_csum =3D=3D true);
> >>>>> -     csum_one_bio(bbio, &bbio->csum_saved_iter);
> >>>>> +     csum_one_bio(bbio, bbio->csum_bio, &bbio->csum_saved_iter);
> >>>>>         complete(&bbio->csum_done);
> >>>>>     }
> >>>>>
> >>>>>     /*
> >>>>>      * Calculate checksums of the data contained inside a bio.
> >>>>>      */
> >>>>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
> >>>>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bo=
ol async)
> >>>>>     {
> >>>>>         struct btrfs_ordered_extent *ordered =3D bbio->ordered;
> >>>>>         struct btrfs_inode *inode =3D bbio->inode;
> >>>>>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >>>>> -     struct bio *bio =3D &bbio->bio;
> >>>>>         struct btrfs_ordered_sum *sums;
> >>>>>         unsigned nofs_flag;
> >>>>>
> >>>>> @@ -822,12 +819,14 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio=
, bool async)
> >>>>>         btrfs_add_ordered_sum(ordered, sums);
> >>>>>
> >>>>>         if (!async) {
> >>>>> -             csum_one_bio(bbio, &bbio->bio.bi_iter);
> >>>>> +             struct bvec_iter iter =3D bio->bi_iter;
> >>>>> +             csum_one_bio(bbio, bio, &iter);
> >>>>>                 return 0;
> >>>>>         }
> >>>>>         init_completion(&bbio->csum_done);
> >>>>>         bbio->async_csum =3D true;
> >>>>> -     bbio->csum_saved_iter =3D bbio->bio.bi_iter;
> >>>>> +     bbio->csum_bio =3D bio;
> >>>>> +     bbio->csum_saved_iter =3D bio->bi_iter;
> >>>>>         INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> >>>>>         schedule_work(&bbio->csum_work);
> >>>>>         return 0;
> >>>>> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
> >>>>> index 5645c5e3abdb..d16fd2144552 100644
> >>>>> --- a/fs/btrfs/file-item.h
> >>>>> +++ b/fs/btrfs/file-item.h
> >>>>> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_h=
andle *trans,
> >>>>>     int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
> >>>>>                            struct btrfs_root *root,
> >>>>>                            struct btrfs_ordered_sum *sums);
> >>>>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
> >>>>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bo=
ol async);
> >>>>>     int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
> >>>>>     int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start=
, u64 end,
> >>>>>                              struct list_head *list, int search_com=
mit,
> >>>>
> >>
> >
>

