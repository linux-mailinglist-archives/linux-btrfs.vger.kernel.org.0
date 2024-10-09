Return-Path: <linux-btrfs+bounces-8674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A57995DE6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 04:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09740283B55
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 02:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD313BADF;
	Wed,  9 Oct 2024 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhZqrEQt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF31C6BE;
	Wed,  9 Oct 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728441673; cv=none; b=L0MpWHHpG26Gkx/OUhLwT97KoiLjSkDnS4lduCyK4cDxN6RItbeHg+CLt31d/KMm8hRmXX84U9Ao/SLdJw6yPqTbr2ZROXY8ktU+9IJTSy+WlLvQUMFHHukrOhGjslPeC//DlTCbFUuIikLGOmIbtiTpG4zYcuT6kqZ7SC29XDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728441673; c=relaxed/simple;
	bh=tWcCI7B/nBfXzxAzaQyAbDJ9sH6IVxl0E8KQwMd/1Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpI6VsE2o1bwEJ0yCRDhYdiRkzqhHnuK2g9osmgy7WjsxzojWl2D+oYE7BQXTLzalzARjppKAF4oF5x5NEMfXrTNaQ91Iwli12dDSQEmJQui1grjedmE0VNnvOOD5ZkUaVbUFKaQ7+77tH+OiAkP7LMD2uHRFdqQ3amIkKkfLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhZqrEQt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99791e4defso70087766b.0;
        Tue, 08 Oct 2024 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728441670; x=1729046470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/Ss/99gPuDRFIjlaq/q3W+/ZoBlmKmsOT2xO3zXC4o=;
        b=mhZqrEQtbJfXBww2C7/qTSpgiet5Hp/LnEc6fWuTzLFoLS2F+H1d4nzY/WMjNAf7Xe
         i2TDTQUMasnYgsOuzNgxCdK6mAoDueEDBo78etmWEuIH7EbMJobXtXhjdb7TzHqFaAIo
         Ey3hiGjKlNVEv1ofSXd8CCc6KKDPtcAPefXJJbtbWQcV+fqg4x/QH0xeCNLaF7TyCa82
         bEjmGGl7WAxS+RfT1hH/m6LBEkA2mRrd6GTr6oyC5jgrDYHtdXTgamt8zy0FJrEHeB9D
         54jSaZ3TNdbKTdAJrgetalTv2AD7yfsbAV+HCOJWOO80uWUGQ+9AnrihCUZ8fD8sxHUM
         1aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728441670; x=1729046470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/Ss/99gPuDRFIjlaq/q3W+/ZoBlmKmsOT2xO3zXC4o=;
        b=AMoF4CpwpcNon/XlS90mFFx7K7JmrUGj3IL1EOY6MW/blQ3lnG+0gEhBruCL+c/O8m
         x1GlFEBYJu/FN9/pVh7/lS2j87O+qPnHQW5eeByEAMlmjQKfKo36KWdIrZJW+0Fdtafs
         plPWlGa43AtZSPPBaTkkxfxwqKVLBdcg35WyeBYJEaGpfoWKitG2AnxF53Ta554AoaOc
         TWsqFowz7zqjsI9QMONA0G/NCNilBo1PkmLpkO/TNpuQ1mBV3c3bGPKWDI6w3cj56vMC
         gIlY0ss259+/mbVrQXUAaHTrWSUgil+oq2t2M04hu3SvTQbczMWjTr1vW/A2kMEf5Su+
         7IFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPvbQl8/ls2uEsOUCvCs+70G0M0m6+hGsiJmKEeUM5yHYywKQMEvHYfHAVLiZlyHK9ipWMbybDKe9SCI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/3pr0MWBZboXmcTFTFCtYg9YhKs78SE8xLC/3lKHBwvD50I1
	V+V5OqTL1NNa1wwJIBe+MhPHRq7sU4amrxOGDA0FWDg4vJHSlYzv6ToSsf/7i4V+Z9CbjnDIi1w
	hTJl3wHrJu74YMoLaKcKcBPjfuUmA30Qw6URb8D5A
X-Google-Smtp-Source: AGHT+IHk1Dxo1jP+8mNvf0VnFXCfSvCSqXGfB1r6qIrhNfWdAP1tlrASuyP9kfDVwOUAbkNMQDnt97BPxCuaYbnRPsA=
X-Received: by 2002:a05:6402:1f4f:b0:5c5:da5e:68e with SMTP id
 4fb4d7f45d1cf-5c91d527013mr910764a12.3.1728441669777; Tue, 08 Oct 2024
 19:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008064849.1814829-1-haisuwang@tencent.com> <20241008161228.GA796369@zen.localdomain>
In-Reply-To: <20241008161228.GA796369@zen.localdomain>
From: hs wang <iamhswang@gmail.com>
Date: Wed, 9 Oct 2024 10:40:57 +0800
Message-ID: <CALv5hoR5zq0doKyBTCu0_0K5cqAvvCw=8V+JDjnFNcqCeetgtQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix the length of reserved qgroup to free
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, wqu@suse.com, linux-kernel@vger.kernel.org, 
	Haisu Wang <haisuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Boris Burkov <boris@bur.io> =E4=BA=8E2024=E5=B9=B410=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=B8=89 00:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 08, 2024 at 02:48:46PM +0800, iamhswang@gmail.com wrote:
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
> Good catch and fix, thank you!
> Reviewed-by: Boris Burkov <boris@bur.io>
>
Thanks for the review.

> Can you please share more information about how you reproduced and
> tested this issue for the fix? In one of the other emails in the chain,
> you also mentioned a CVE, so explaining the specific impact of the bug
> is helpful too.
>

Instead of hitting this in the real world, I get this while backporting the
CVE-2024-46733 fixes. I need to understand the full story and the extent
reservation/clean up context, found the free data region mismatch to the
dealloc region and the potential risky. So i write the fix of the inconsist=
ent
size.

> As far as I can tell, we risk freeing too much space past the real
> desired range if start gets bumped before this free, which could lead to
> prematurely freeing some other rsv marked data past end. This naturally
> leads to incorrect accounting, And I think would allow us to reserve
> this same range again. Though perhaps delalloc extent range stuff would
> prevent that. Between that, and the changesets gating most of the qgroup
> freeing, it's hard to actually see what happens :)
>
> Long ramble short: do you have a reproducer?
>

Sadly, i don't have a reproducer yet.

In another mail of the chain, Wenruo suggested it is possible to
polish the usage
of @startand @extent_reserved to make it more clear/safe. I will check more=
 to
finish this in another patch, together with generic fstest at least.

Thanks,
Haisu Wang

> > ---
> >  fs/btrfs/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
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
> >  }
> > --
> > 2.39.3
> >

