Return-Path: <linux-btrfs+bounces-8637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B475D994669
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 13:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8E51F215E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F771CFEBE;
	Tue,  8 Oct 2024 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaxoIFTh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1217CA02;
	Tue,  8 Oct 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386310; cv=none; b=dRMS/FHpzaf8qY0THV8A4EEEUxkzXGdUWijpJzYIv3CmDpXCJPWfmbhoF5Sz/URN4Rf11kcpCdg6/BbNusYJKwaIPPGN2tX+4W4jgpOWUJDxTnqfZYcaPtmgVbOpN997XBBTNYfsdI0ypl1uisAHaItH69jpyEXjPe70TltcBRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386310; c=relaxed/simple;
	bh=LRuYmZ3/V33MHhyVWFvQWknFm8VBc1M0CHNL+tMK2dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUzpccR1PR1C3ncbc6XoYfIWnn3bif9J1d0FDKyV4s81wjJ0nehp6+8WVq2qr9xrXLVbECbE2ml4NNSqCPxoQXjtmrGO7B/i19j8I1UieTvWxG39tkMdzAreNWbGKVaKpSlsaGHfwTxvkZx5eBrkKSSFGXBng4Kl1EgTjAcrPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaxoIFTh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9941a48ac8so380659366b.3;
        Tue, 08 Oct 2024 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728386307; x=1728991107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKqlKPOONVYnAvGBMSSMOYAcjpTVpNTtTM7AOZrEN6w=;
        b=kaxoIFTh9YtPddWdAptsnbp2wXz2hxkCrYOEHUWsTU73TuWwAkt5jEqV86NFI7pECS
         IzWen4OJCeVGiwzgJlo/eRHesVsk7kb2IxgGEdQpcNzSlzRbniyvgM2sc1ET7+1oZh3V
         CcG1SMwJMlVtBmHDrB7f0SSUEFAeyZljz2UAzmkO7Ke/n7PBR+Fg5a6SZvZT3q2teYTp
         aJPd87FOgcbvJ4ZixUD9HHULvuXgJ1DTgBLAD8tVGv985qz6l086h/6dNYYod9uhYykK
         LIFpiO0/XGq/OeY6gmr+4c8t2Pr+AZMakYacuWfLqHYrkMVWlVHtKXMeqhetvLmrlxBd
         8U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728386307; x=1728991107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKqlKPOONVYnAvGBMSSMOYAcjpTVpNTtTM7AOZrEN6w=;
        b=YZnCLtjlh7udBAvregiBU0H1wf+Kf7x9qVSAm4BkpZnKJeug3rateDDE2EaEB0QUFU
         wjXIgHKuMp7mY1XMWitreueGXJPKs+kw1n1u+u0Q0Bxm8QMEn66zffBof1x9h958XXaR
         eC4d7G4K+ZK7G6t15Bcj71ynmxf998ugVlXZTP/Ws0iA2WpKGz5bQccQTKq6y5SF0tbH
         HNUgwhpmOC5Do7eFIH9ElIevvhuj1RWU/SYn8rNmR59ZkdtFaZDe9I9c4eomI/9/Dh1A
         Ba++mVX+4lUdL5e1VsuqKPe/auVXJO+uCrE+O7afR5AWfTbwDn2L1SsRDtWLAfR9pAVE
         o8tA==
X-Forwarded-Encrypted: i=1; AJvYcCXush49pFLuGmeyPdCJTnclvpoe+yQfw112TQIs9qq/DhzOlld0uW4E7gosVs++9pME7zNbAAhtW8j2E8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJX3tv848Jb+iqfBXLV4goBUgAoDuH2Pb08gTHVQygcIv6etR
	KRwuEitcsjym4bxk4sorzuspZpAqYZrV4eEk2UF3LZY59M+MSynMXywxFo9sP0HpMxiCyHwWxW7
	zvzCSjd2nj6tTgJp36KyB/lqFiV0huLd/z1KPSQfg
X-Google-Smtp-Source: AGHT+IHC8A9lDrVKFRuKfxW91lgfBljY33Zfl/zG4CfRhvvp1qgtnQfH1NS3Fu+GuBbLnr10mGJS5jr3YA7oJ6i2SBI=
X-Received: by 2002:a17:907:7e91:b0:a99:48a8:5a1c with SMTP id
 a640c23a62f3a-a9948a85b33mr950725766b.40.1728386306401; Tue, 08 Oct 2024
 04:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008064849.1814829-1-haisuwang@tencent.com> <b677188b-b41b-4a3d-8598-61e8ccdef075@gmx.com>
In-Reply-To: <b677188b-b41b-4a3d-8598-61e8ccdef075@gmx.com>
From: hs wang <iamhswang@gmail.com>
Date: Tue, 8 Oct 2024 19:18:14 +0800
Message-ID: <CALv5hoQwjE=4mqEst1ay5YF3eAj2TNdjtLmHbBNCwxsfDXJQTA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix the length of reserved qgroup to free
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, wqu@suse.com, boris@bur.io, linux-kernel@vger.kernel.org, 
	Haisu Wang <haisuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=BA=8C 15:56=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> =E5=9C=A8 2024/10/8 17:18, iamhswang@gmail.com =E5=86=99=E9=81=93:
> > From: Haisu Wang <haisuwang@tencent.com>
> >
> > The dealloc flag may be cleared and the extent won't reach the disk
> > in cow_file_range when errors path. The reserved qgroup space is
> > freed in commit 30479f31d44d ("btrfs: fix qgroup reserve leaks in
> > cow_file_range"). However, the length of untouched region to free
> > need to be adjusted with the region size.
> >
> > Fixes: 30479f31d44d ("btrfs: fix qgroup reserve leaks in cow_file_range=
")
> > Signed-off-by: Haisu Wang <haisuwang@tencent.com>
>
> Right, just several lines before that, we increased @start by
> @cur_alloc_size if @extent_reserved is true.
>
> So we can not directly use the old range size.

Thanks for the review.

>
> You can improve that one step further by not modifying @start just for
> the error handling path, although that should be another patch.

Indeed, modify the start value based on @extent_reserved in
error path only is tricky and ambiguous.

I agree to keep the fix as simple as possible (like the previous patch),
since commit 30479f31d44d ("btrfs: fix qgroupreserve leaks in
cow_file_range") assigned to CVE-2024-46733 already.
A simple fix is easier to port to stable branch of different versions.
Also the possible change to keep @start is more like an
enhancement instead of a fix.

>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu

To make sure we are on the same page of keeping the @start
unchanged. I write a POC below for your opinion.
(Anyway, i will think/test again before convert POC to a PATCH.)

The @start will advanced in every succeed reservation, the
@cur_alloc_size can represent the @extent_reserved state
instead of using a standalone @extent_reserved flag.
In this case, the @start region no longer need to be modified
based on @extent_reserved state in the error path.

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5eefa2318fa8..0c35292550bd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1341,7 +1341,6 @@ static noinline int cow_file_range(struct
btrfs_inode *inode,
        struct extent_map *em;
        unsigned clear_bits;
        unsigned long page_ops;
-       bool extent_reserved =3D false;
        int ret =3D 0;

        if (btrfs_is_free_space_inode(inode)) {
@@ -1395,8 +1394,7 @@ static noinline int cow_file_range(struct
btrfs_inode *inode,
                struct btrfs_ordered_extent *ordered;
                struct btrfs_file_extent file_extent;

-               cur_alloc_size =3D num_bytes;
-               ret =3D btrfs_reserve_extent(root, cur_alloc_size, cur_allo=
c_size,
+               ret =3D btrfs_reserve_extent(root, num_bytes, num_bytes,
                                           min_alloc_size, 0, alloc_hint,
                                           &ins, 1, 1);
                if (ret =3D=3D -EAGAIN) {
@@ -1427,7 +1425,6 @@ static noinline int cow_file_range(struct
btrfs_inode *inode,
                if (ret < 0)
                        goto out_unlock;
                cur_alloc_size =3D ins.offset;
-               extent_reserved =3D true;

                ram_size =3D ins.offset;
                file_extent.disk_bytenr =3D ins.objectid;
@@ -1503,7 +1500,7 @@ static noinline int cow_file_range(struct
btrfs_inode *inode,
                        num_bytes -=3D cur_alloc_size;
                alloc_hint =3D ins.objectid + ins.offset;
                start +=3D cur_alloc_size;
-               extent_reserved =3D false;
+               cur_alloc_size =3D 0;

                /*
                 * btrfs_reloc_clone_csums() error, since start is increase=
d
@@ -1573,13 +1570,12 @@ static noinline int cow_file_range(struct
btrfs_inode *inode,
         * to decrement again the data space_info's bytes_may_use counter,
         * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
         */
-       if (extent_reserved) {
+       if (cur_alloc_size) {
                extent_clear_unlock_delalloc(inode, start,
                                             start + cur_alloc_size - 1,
                                             locked_folio, &cached, clear_b=
its,
                                             page_ops);
                btrfs_qgroup_free_data(inode, NULL, start,
cur_alloc_size, NULL);
-               start +=3D cur_alloc_size;
        }

        /*
@@ -1588,11 +1584,13 @@ static noinline int cow_file_range(struct
btrfs_inode *inode,
         * space_info's bytes_may_use counter, reserved in
         * btrfs_check_data_free_space().
         */
-       if (start < end) {
+       if (start + cur_alloc_size < end) {
                clear_bits |=3D EXTENT_CLEAR_DATA_RESV;
-               extent_clear_unlock_delalloc(inode, start, end, locked_foli=
o,
+               extent_clear_unlock_delalloc(inode, start + cur_alloc_size,
+                                            end, locked_folio,
                                             &cached, clear_bits, page_ops)=
;
-               btrfs_qgroup_free_data(inode, NULL, start, end - start
+ 1, NULL);
+               btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
+                               end - start - cur_alloc_size + 1, NULL);
        }
        return ret;
 }


Thanks,
Haisu Wang

>
> > ---
> >   fs/btrfs/inode.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index b0ad46b734c3..5eefa2318fa8 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1592,7 +1592,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >               clear_bits |=3D EXTENT_CLEAR_DATA_RESV;
> >               extent_clear_unlock_delalloc(inode, start, end, locked_fo=
lio,
> >                                            &cached, clear_bits, page_op=
s);
> > -             btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size=
, NULL);
> > +             btrfs_qgroup_free_data(inode, NULL, start, end - start + =
1, NULL);
> >       }
> >       return ret;
> >   }
>

