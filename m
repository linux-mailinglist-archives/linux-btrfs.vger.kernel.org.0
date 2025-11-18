Return-Path: <linux-btrfs+bounces-19082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB4C69DA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0C494F88E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFDC3563DF;
	Tue, 18 Nov 2025 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L210PxOP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30634315A
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474742; cv=none; b=X39vSyRoVyeI2vor2bp1XbkQKOPsArqR7ZqWFJMzHm9VQ0wNHjfIUdz7wZcL0XxLNJKWam+JkEqjgwL1nOML1kYtPjRAItALNG4rQ/HsvQ0T7gkMaYeLdNuZhCsMxytDExOqCQINXAeCDZEGREFUtokjufc9tfTc3pe64OJI6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474742; c=relaxed/simple;
	bh=qqAkfCuD+wNSX2WSX5EV66Xko/oPJkGWSPIcfIKoH4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSf1sgc+wZW33FjvPqnu+kZdys1m5D5lejGkPhZ+wNqc37ZsHRlScUcDGZbC5HeFb4BGGx92Cb/vga63ESblTmgTouOE1e+OybhpnOVZyf70IkrcDvj6Kxu4GRDvqGbwpypmRsNh5xrixncn+mhU0YCsrLxzc8gtGAHqBQsuIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L210PxOP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso4461145f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 06:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763474737; x=1764079537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUoVQo1l+9o14WaqZPhzvrR/V9FOLNMHPM8Fa6Bp+pc=;
        b=L210PxOP935XkSE/7FwbNRMSs14SAu717kLdGoMNX2rqx5KIcFIOj6PWL+nK1TQFiB
         IEEqcvk/bd6KwfhyLTmZLu9p7hVfUJT+pbPXdULFSSZflfUHPQtTv/KTGKdwKvQMw2Y0
         BM8dByMgxoP9KSQ7SCFQ2LLswoaaWsPA0u/lWxMWXzwoXhEP9m5zihRs0X60Kcl/coXI
         D8L/J7WUno7Vo0yio6A3vr1Gf1juXMF8KVJTelVZJAQQvMfISzHntniR8q0FRD5L1d3e
         aRrUIsW29ApJvNSGlgPR7Ih7LRuqXj/47OVSpELC3M99jrrwoD6KuHhZUXmpjo86VzZu
         2P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763474737; x=1764079537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUoVQo1l+9o14WaqZPhzvrR/V9FOLNMHPM8Fa6Bp+pc=;
        b=bQzoLECsIi1JdeIRCSilmG7qrrkUm3D9CROSAvzI3I6s+t2BYg1tFUNgPvMcns/U4+
         UBVSdTb3l0eGa68noepAWX9P4mWv4xjOpFFbgHeQV48s4Hir+IC8rfjfFlaz51IP0ue8
         DN25koBGKsV8k2dmXhvXUyCLE4Lh/HBDeZiKHo+i+he6ilHSoyh+3I8pEPcPg1e2hRTC
         zYjNBHabEl06kb1658ZuFuIDLENUvkvEHm+PtcEH9zfszoEdAGxXl3ejkVDRTusTaq00
         6qG9vW4PPObggPa41PrC9TWBLRyl5qR77EKMeVwgUFy+VlYCjd0AMgPaoXoZ4dzEkDEU
         vK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDV0SZHYaArNXEXnR13MlZRVn3Ebm6ntWyVRppaHcDyuWgZ5NkhLPgLCvIp3dAjyzRcqQ/G8DeK5/ntg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrvGis5x39Qt1MkTABxLhwpX3VwYqUb4ZGEphy3BdELCXx3u9F
	8bG9LvWTYwAjz6CLLxQhDAYH8aI1cB+H875glwO8vGIDE8SG7v+dtJBO0+ID8CiSuBL1VPav7GN
	tzltioNp/ZTcbJHp5KCZZ9+/ZOz2JwJch/xefH0jbDw==
X-Gm-Gg: ASbGnctKPu02cFPXdqsuD1GdvKa1SOtY1LBmNcwtaGQdfADpUUH8nD0AjPAA++rIlg1
	7qt3EvYDpeuKHYm/VNrgrI4axJEUE+tkeCw8VerGpfTnW72/cK8ZT6z5cye4dE5nltuEOgIgc3z
	xPDbBEake8Uf3PknoUqtObVZ5Pi0eohiY+kaSoLx3nBByJDk3k3F9dpwZ6RU1zLT15iBCIv0hyg
	DhPwUmV4Xrn5qXMOXfP3n2g5XXQbpiuQXtuv5o5DKomvSlKIuliKoOQB9AKcFoUmIJqYFKXUFwW
	AinOtWgrwJrpt6X8kTbogYAIHpBqvILFknoNf2O2QOCyCLNcS+LsPQYYauAwFT/P01sk
X-Google-Smtp-Source: AGHT+IED3QFMhTIo+CfSkL7d6u/Yo14QhxpLJfvtrUintIpX5sMvPn9yfEkok9aIi05OzvzT3Horf1/1RNaKG5kM2NQ=
X-Received: by 2002:a05:6000:2f83:b0:42b:3257:f175 with SMTP id
 ffacd0b85a97d-42b593537f8mr16826029f8f.28.1763474736943; Tue, 18 Nov 2025
 06:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com> <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com>
In-Reply-To: <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 18 Nov 2025 15:05:25 +0100
X-Gm-Features: AWmQ_bnYISIl_7_2iBRjR3YXjA0oKCu_vSSkOJXoJ3J3dg3bey4L9Dn-47aFRiQ
Message-ID: <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Nov 2025 at 21:16, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/11/14 05:37, Daniel Vacek =E5=86=99=E9=81=93:
> > On Wed, 12 Nov 2025 at 22:02, Qu Wenruo <wqu@suse.com> wrote:
> >> =E5=9C=A8 2025/11/13 06:06, Daniel Vacek =E5=86=99=E9=81=93:
> >>> From: Josef Bacik <josef@toxicpanda.com>
> >>>
> >>> We only ever needed the bbio in btrfs_csum_one_bio, since that has th=
e
> >>> bio embedded in it.  However with encryption we'll have a different b=
io
> >>> with the encrypted data in it, and the original bbio.  Update
> >>> btrfs_csum_one_bio to take the bio we're going to csum as an argument=
,
> >>> which will allow us to csum the encrypted bio and stuff the csums int=
o
> >>> the corresponding bbio to be used later when the IO completes.
> >>
> >> I'm wondering why we can not do it in a layered bio way.
> >>
> >> E.g. on device-mapper based solutions, the upper layer send out the bi=
o
> >> containing the plaintext data.
> >> Then the dm-crypto send out a new bio, containing the encrypted data.
> >
> > This is similar but fscrypt works on FS level. It gets the original
> > plaintext bio (the btrfs_bio::bio one) and gives us a callback with
> > the encrypted bio to calculate the checksum of the encrypted data. No
> > plaintext bio goes to the storage layer.
>
> Then why put the original bio pointer into the super generic btrfs_bio?

When encryption is enabled, it's not going to be the original bio but
rather the encrypted one.

But giving it another thought and checking the related fscrypt code,
the encrypted bio is allocated in  blk_crypto_fallback_encrypt_bio()
and freed in blk_crypto_fallback_encrypt_endio() before calling
bio_endio() on our original plaintext bio.
This means we have no control over the bounce bio lifetime and we
cannot store the pointer and use it asynchronously. We'll need to
always compute the checksum synchronously for encrypted bios. In that
case we don't need to store it in btrfs_bio::csum_bio at all. For the
regular (unencrypted) case we can keep using the &bbio->bio.

I'll drop the csum_bio for there is no use really.

--nX

> I thought it's more common to put the original plaintext into the
> encryption specific structure, like what we did for compression.
>
> Thanks,
> Qu
>
> >
> > --nX
> >
> >> The storage layer doesn't need to bother the plaintext bio at all, the=
y
> >> just write the encrypted one to disk.
> >>
> >> And it's the dm-crypto tracking the plaintext bio <-> encrypted bio ma=
pping.
> >>
> >>
> >> So why we can not just create a new bio for the final csum caculation,
> >> just like compression?
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >>> Signed-off-by: Daniel Vacek <neelx@suse.com>
> >>> ---
> >>> Compared to v5 this needed to adapt to recent async csum changes.
> >>> ---
> >>>    fs/btrfs/bio.c       |  4 ++--
> >>>    fs/btrfs/bio.h       |  1 +
> >>>    fs/btrfs/file-item.c | 17 ++++++++---------
> >>>    fs/btrfs/file-item.h |  2 +-
> >>>    4 files changed, 12 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> >>> index a73652b8724a..a69174b2b6b6 100644
> >>> --- a/fs/btrfs/bio.c
> >>> +++ b/fs/btrfs/bio.c
> >>> @@ -542,9 +542,9 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
> >>>        if (bbio->bio.bi_opf & REQ_META)
> >>>                return btree_csum_one_bio(bbio);
> >>>    #ifdef CONFIG_BTRFS_EXPERIMENTAL
> >>> -     return btrfs_csum_one_bio(bbio, true);
> >>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, true);
> >>>    #else
> >>> -     return btrfs_csum_one_bio(bbio, false);
> >>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, false);
> >>>    #endif
> >>>    }
> >>>
> >>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> >>> index deaeea3becf4..c5a6c66d51a0 100644
> >>> --- a/fs/btrfs/bio.h
> >>> +++ b/fs/btrfs/bio.h
> >>> @@ -58,6 +58,7 @@ struct btrfs_bio {
> >>>                        struct btrfs_ordered_sum *sums;
> >>>                        struct work_struct csum_work;
> >>>                        struct completion csum_done;
> >>> +                     struct bio *csum_bio;
> >>>                        struct bvec_iter csum_saved_iter;
> >>>                        u64 orig_physical;
> >>>                };
> >>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> >>> index 72be3ede0edf..474949074da8 100644
> >>> --- a/fs/btrfs/file-item.c
> >>> +++ b/fs/btrfs/file-item.c
> >>> @@ -765,21 +765,19 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root=
 *root, struct btrfs_path *path,
> >>>        return ret;
> >>>    }
> >>>
> >>> -static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *s=
rc)
> >>> +static void csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, st=
ruct bvec_iter *iter)
> >>>    {
> >>>        struct btrfs_inode *inode =3D bbio->inode;
> >>>        struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >>>        SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> >>> -     struct bio *bio =3D &bbio->bio;
> >>>        struct btrfs_ordered_sum *sums =3D bbio->sums;
> >>> -     struct bvec_iter iter =3D *src;
> >>>        phys_addr_t paddr;
> >>>        const u32 blocksize =3D fs_info->sectorsize;
> >>>        int index =3D 0;
> >>>
> >>>        shash->tfm =3D fs_info->csum_shash;
> >>>
> >>> -     btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
> >>> +     btrfs_bio_for_each_block(paddr, bio, iter, blocksize) {
> >>>                btrfs_calculate_block_csum(fs_info, paddr, sums->sums =
+ index);
> >>>                index +=3D fs_info->csum_size;
> >>>        }
> >>> @@ -791,19 +789,18 @@ static void csum_one_bio_work(struct work_struc=
t *work)
> >>>
> >>>        ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
> >>>        ASSERT(bbio->async_csum =3D=3D true);
> >>> -     csum_one_bio(bbio, &bbio->csum_saved_iter);
> >>> +     csum_one_bio(bbio, bbio->csum_bio, &bbio->csum_saved_iter);
> >>>        complete(&bbio->csum_done);
> >>>    }
> >>>
> >>>    /*
> >>>     * Calculate checksums of the data contained inside a bio.
> >>>     */
> >>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
> >>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool=
 async)
> >>>    {
> >>>        struct btrfs_ordered_extent *ordered =3D bbio->ordered;
> >>>        struct btrfs_inode *inode =3D bbio->inode;
> >>>        struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >>> -     struct bio *bio =3D &bbio->bio;
> >>>        struct btrfs_ordered_sum *sums;
> >>>        unsigned nofs_flag;
> >>>
> >>> @@ -822,12 +819,14 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, =
bool async)
> >>>        btrfs_add_ordered_sum(ordered, sums);
> >>>
> >>>        if (!async) {
> >>> -             csum_one_bio(bbio, &bbio->bio.bi_iter);
> >>> +             struct bvec_iter iter =3D bio->bi_iter;
> >>> +             csum_one_bio(bbio, bio, &iter);
> >>>                return 0;
> >>>        }
> >>>        init_completion(&bbio->csum_done);
> >>>        bbio->async_csum =3D true;
> >>> -     bbio->csum_saved_iter =3D bbio->bio.bi_iter;
> >>> +     bbio->csum_bio =3D bio;
> >>> +     bbio->csum_saved_iter =3D bio->bi_iter;
> >>>        INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> >>>        schedule_work(&bbio->csum_work);
> >>>        return 0;
> >>> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
> >>> index 5645c5e3abdb..d16fd2144552 100644
> >>> --- a/fs/btrfs/file-item.h
> >>> +++ b/fs/btrfs/file-item.h
> >>> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_han=
dle *trans,
> >>>    int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
> >>>                           struct btrfs_root *root,
> >>>                           struct btrfs_ordered_sum *sums);
> >>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
> >>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool=
 async);
> >>>    int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
> >>>    int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u=
64 end,
> >>>                             struct list_head *list, int search_commit=
,
> >>
>

