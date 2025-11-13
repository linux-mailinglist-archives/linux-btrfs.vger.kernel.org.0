Return-Path: <linux-btrfs+bounces-18959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D87C59A96
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 20:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49A1B358EA9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6B31A81D;
	Thu, 13 Nov 2025 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Re/9yEGo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E031DDB9
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060887; cv=none; b=UQx7XE4+ifqrXrBNN11GGd3IJKvJIqC8v2CBavZS3N/KWuw7i61XJgX8ERInkoADJNBu04GveeygEUfIDJkpaIQPVorf8eWSrPdo/e8jG+RR5u0ASnuDdDp/YFBGc7VnYUCtBAKPkJqxfg4PZS6k2m7Wo9RDZBqQOjV9fS6smSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060887; c=relaxed/simple;
	bh=A6MzEujrewXrOXg9dYZ6+cHCWQldaSjQiRneNal6rtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmhZXXG36ZhyPSTNHQLI08NV4zgVMhMxSIcDmFV+F4jNdn+vbW+ZqXmL22c8hy+cl6pUTFoqVE49hHUEKJ1ZN/sDIIrbHdT0Fp1Hrj5asQsLZRLZZVAVXEuw5JJr/k3awupqYDI50DLCa4S8qnAhgEASr8TwQTU42yFXLogxmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Re/9yEGo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso8793165e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 11:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763060881; x=1763665681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAjyZtx51v+wc9nx4IfzhhpT8T8Q0pTa4XW+9/kICmY=;
        b=Re/9yEGoXAnwU/YTlyhwzMI+GbiUhqiVF/ayxBiE8vk2XVN1i6jw3nXbHuw7CeXg0I
         Carx/ByXD6KYrX+2BkcG1CR7XDqmkTSA4axfmOqQWDQSlMpKajuHLjtPZ4s8vfM4Ztpc
         Z20n+eyAke429iqD8sv0TH6mGSEuP7GXliIhfvbYpW6qSpV7hCMhVshZ6tXhUu6SLKfU
         gjoDrUqSVIHMh2B6Scgz+VeE1v8mfOdAm2HrI9pJYLU5X0LSJxXroj8MQKWCWPLRDFDL
         NcfgGww8UctSjjuZPlxECA8YYl9BCXybH4sfsz2+P/Y3jKA9ubPnqLM/TTOkfzHD2n5X
         hlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763060881; x=1763665681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EAjyZtx51v+wc9nx4IfzhhpT8T8Q0pTa4XW+9/kICmY=;
        b=I+F+TkBhxYeRbJSS5Tv9RL4VEOLWLLJSRC8TyHw8nP3ETgbi+9omUSxiXjTFp+pqdF
         DrwH87pAtGCK+zxNeLmrpCwOgBTa3Ku2rK/g5NF5lEdiMeRGzSHzAo1lVHWHAmNH4+hj
         0ORlTfYZUlX8h+ShJikxl7Fl4xYWgXw8XPUa3KK2Fs/sOB+jNE6qIQeesazWXxGoLHeR
         xKuS9xWlTP6H6rHpuBmpqp77KV0i+u4tPhUMEtZDY03pGIqKCjxnhiG2r+uwwi+Z9RqJ
         bm78mUxIWfAb0iAXazzqHiWaLx5HiIZ2q49PywFTpobInbL37PLQMLDcNz7fTMiRJ9YD
         fDlg==
X-Forwarded-Encrypted: i=1; AJvYcCWta7snJ1E5I9FUWGs8kV3xOUKgZXFIIdZmpusjKxdb5hWeBxKtunXFobXL6NIm8/N4cz0Q+aCxwdiXfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOeGlPaJRn9QEGwcgc4krA/dQXSDALtZ/X06pFmlfPPpz4mHl
	gBNedfi4uDMsUS2WjoPkMmzXIs/10cF1URQNfONJKOCFwTAVbuwg5RnvC1m3pz+pz/o4czKvuZV
	1f3alh46IuUyD0L9dfo50ar1ED9NwLO3FD21xj0MIjw==
X-Gm-Gg: ASbGncvgB6UkdY2YlIM+sJrnTfFfZk43yI4FrwSCHxx97oTBJ+jrTh2bofyPZXV9x7O
	3ki3JkKpBpcL2ARFb3vfrs6wlGpLqQ/EfDK9pCoY0hDWNM7a5GgvGwYWE4YSttDCo9Dlb7WYlEq
	FqwrmgkMNqjnNc0qeya9dbA9vrU1aJecWZsYp6AMESsNhvSRSd92vOtWo5SsnPU9wD6Gb2mi011
	uvN67ucR3fJYkVZcWYUGxWhS1D0BRSt/0cxWxSXGuYruldKi4WDAoBe9ip6gy4/h+fvImWSU2cj
	gGsNvdAlqncxhQJB7a+wjq3ojosUCLG38ixl1l2b0e7WTo1wFHiFkWyc4Q==
X-Google-Smtp-Source: AGHT+IEsxDa94oGiRPXt1gvelAkBHFGPeUIpmnobYOxGCcg/2sJ5Cw7X7/qsZSo2ICXB97TVu/y+rEI3TSLrRHAaVdM=
X-Received: by 2002:a05:600c:4703:b0:477:7b16:5f78 with SMTP id
 5b1f17b1804b1-4778feb2569mr4964025e9.37.1763060881139; Thu, 13 Nov 2025
 11:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com>
In-Reply-To: <7de34b24-f189-402a-98f9-83e595b53244@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 13 Nov 2025 20:07:50 +0100
X-Gm-Features: AWmQ_bm5e9mrM5a5vhsV5AmyPzpFuUm3vYIE6i7Nj1XSGibhcaUWXTaTtjRK8JU
Message-ID: <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 at 22:02, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/11/13 06:06, Daniel Vacek =E5=86=99=E9=81=93:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > We only ever needed the bbio in btrfs_csum_one_bio, since that has the
> > bio embedded in it.  However with encryption we'll have a different bio
> > with the encrypted data in it, and the original bbio.  Update
> > btrfs_csum_one_bio to take the bio we're going to csum as an argument,
> > which will allow us to csum the encrypted bio and stuff the csums into
> > the corresponding bbio to be used later when the IO completes.
>
> I'm wondering why we can not do it in a layered bio way.
>
> E.g. on device-mapper based solutions, the upper layer send out the bio
> containing the plaintext data.
> Then the dm-crypto send out a new bio, containing the encrypted data.

This is similar but fscrypt works on FS level. It gets the original
plaintext bio (the btrfs_bio::bio one) and gives us a callback with
the encrypted bio to calculate the checksum of the encrypted data. No
plaintext bio goes to the storage layer.

--nX

> The storage layer doesn't need to bother the plaintext bio at all, they
> just write the encrypted one to disk.
>
> And it's the dm-crypto tracking the plaintext bio <-> encrypted bio mappi=
ng.
>
>
> So why we can not just create a new bio for the final csum caculation,
> just like compression?
>
> Thanks,
> Qu
>
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> > Compared to v5 this needed to adapt to recent async csum changes.
> > ---
> >   fs/btrfs/bio.c       |  4 ++--
> >   fs/btrfs/bio.h       |  1 +
> >   fs/btrfs/file-item.c | 17 ++++++++---------
> >   fs/btrfs/file-item.h |  2 +-
> >   4 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index a73652b8724a..a69174b2b6b6 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -542,9 +542,9 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
> >       if (bbio->bio.bi_opf & REQ_META)
> >               return btree_csum_one_bio(bbio);
> >   #ifdef CONFIG_BTRFS_EXPERIMENTAL
> > -     return btrfs_csum_one_bio(bbio, true);
> > +     return btrfs_csum_one_bio(bbio, &bbio->bio, true);
> >   #else
> > -     return btrfs_csum_one_bio(bbio, false);
> > +     return btrfs_csum_one_bio(bbio, &bbio->bio, false);
> >   #endif
> >   }
> >
> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index deaeea3becf4..c5a6c66d51a0 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
> > @@ -58,6 +58,7 @@ struct btrfs_bio {
> >                       struct btrfs_ordered_sum *sums;
> >                       struct work_struct csum_work;
> >                       struct completion csum_done;
> > +                     struct bio *csum_bio;
> >                       struct bvec_iter csum_saved_iter;
> >                       u64 orig_physical;
> >               };
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 72be3ede0edf..474949074da8 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -765,21 +765,19 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *=
root, struct btrfs_path *path,
> >       return ret;
> >   }
> >
> > -static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src=
)
> > +static void csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, stru=
ct bvec_iter *iter)
> >   {
> >       struct btrfs_inode *inode =3D bbio->inode;
> >       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >       SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> > -     struct bio *bio =3D &bbio->bio;
> >       struct btrfs_ordered_sum *sums =3D bbio->sums;
> > -     struct bvec_iter iter =3D *src;
> >       phys_addr_t paddr;
> >       const u32 blocksize =3D fs_info->sectorsize;
> >       int index =3D 0;
> >
> >       shash->tfm =3D fs_info->csum_shash;
> >
> > -     btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
> > +     btrfs_bio_for_each_block(paddr, bio, iter, blocksize) {
> >               btrfs_calculate_block_csum(fs_info, paddr, sums->sums + i=
ndex);
> >               index +=3D fs_info->csum_size;
> >       }
> > @@ -791,19 +789,18 @@ static void csum_one_bio_work(struct work_struct =
*work)
> >
> >       ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
> >       ASSERT(bbio->async_csum =3D=3D true);
> > -     csum_one_bio(bbio, &bbio->csum_saved_iter);
> > +     csum_one_bio(bbio, bbio->csum_bio, &bbio->csum_saved_iter);
> >       complete(&bbio->csum_done);
> >   }
> >
> >   /*
> >    * Calculate checksums of the data contained inside a bio.
> >    */
> > -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
> > +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool a=
sync)
> >   {
> >       struct btrfs_ordered_extent *ordered =3D bbio->ordered;
> >       struct btrfs_inode *inode =3D bbio->inode;
> >       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> > -     struct bio *bio =3D &bbio->bio;
> >       struct btrfs_ordered_sum *sums;
> >       unsigned nofs_flag;
> >
> > @@ -822,12 +819,14 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bo=
ol async)
> >       btrfs_add_ordered_sum(ordered, sums);
> >
> >       if (!async) {
> > -             csum_one_bio(bbio, &bbio->bio.bi_iter);
> > +             struct bvec_iter iter =3D bio->bi_iter;
> > +             csum_one_bio(bbio, bio, &iter);
> >               return 0;
> >       }
> >       init_completion(&bbio->csum_done);
> >       bbio->async_csum =3D true;
> > -     bbio->csum_saved_iter =3D bbio->bio.bi_iter;
> > +     bbio->csum_bio =3D bio;
> > +     bbio->csum_saved_iter =3D bio->bi_iter;
> >       INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> >       schedule_work(&bbio->csum_work);
> >       return 0;
> > diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
> > index 5645c5e3abdb..d16fd2144552 100644
> > --- a/fs/btrfs/file-item.h
> > +++ b/fs/btrfs/file-item.h
> > @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handl=
e *trans,
> >   int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
> >                          struct btrfs_root *root,
> >                          struct btrfs_ordered_sum *sums);
> > -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
> > +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool a=
sync);
> >   int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
> >   int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 =
end,
> >                            struct list_head *list, int search_commit,
>

