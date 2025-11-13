Return-Path: <linux-btrfs+bounces-18939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3653AC56D63
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBA744E53E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3664230102A;
	Thu, 13 Nov 2025 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WyR6hg2l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABD2E5D32
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029460; cv=none; b=o/8AudgV1sGMpSOch3HTG3Bto1uV83XhAPwg9QD30d1erz+gu51rLi6cKj8JwTW4lVjeBe3lmJgsCDsi5X+sJHsdouQNoyzcFr1eDf/t1JTpNqE5BbMV1PZ9d25U+lblKP0yXdoOHHnVb1FxNHxQXFjOaY+RzfXoyfkty5lola0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029460; c=relaxed/simple;
	bh=jxroY9nwWDuq4LI3+9Qzhsj7RBi60JelTQs921UWwmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlMZz6OJH76ZvKUyIm7py/VEtaX4b03WHQW+dADCkfosk8r47kKFX6uNdyqg3RK0ReAppZtVu0BUu1cKpEkkU2mTMQ2MwYeguKpZtbffOq2+otdMjXjnS0pQB6B/RChsNHZiBl9T8N47/RaQZqVufVYdjk4uMh65x+LTmHHbVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WyR6hg2l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47774d3536dso5377625e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 02:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763029456; x=1763634256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+FPMHxnGOMdFWetUEW8LxYImY7etC+o0HZEmAekoQ4=;
        b=WyR6hg2lPS2bXvM/00FnekMRf9KOZcRXa60aUE/JQz0Qwc5WihOGL/b1T0vrWcFpzW
         KxeeTxfNp8EfrKArp/Q4T4411hJlzaB9iDbS9mo9Uv6O2Psh6jTeVrlxbVCZfhTcCQLP
         SPA7LsbvrTUkGlP/feR3tKO6fpAsfBa456TZnOfz5jL8pUUV9AwI1hwDgChd7CQYxKP/
         sbQu+CnVMq/nD50Soq/MmpvgvwqHAprCsgm15eh3ggw1IIeZxFYrYTNMvlZAx+YhvSAW
         Pt6swDCWPxOayRhg/TWhigQS1PQW/p0XUgyzbwy3FMIgT4wd3i8e5bDx4FgHuo9K+8vm
         xV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029456; x=1763634256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+FPMHxnGOMdFWetUEW8LxYImY7etC+o0HZEmAekoQ4=;
        b=NoV6hB1b9SWXpjIZbxyfdCHWtI9iHzUth6FfKVRV9mEU1akorCk+OThOqRYc+ik3Md
         QyEeGYkfhqYoFLVS4UDKomgqF0iU+64ZZp2vsq2eqsg4ehBfakEERjMZ0jRUxLqACs4T
         dAHo65B6hozUAK/1y8/B0A5xS7+z0p96fIJimUzKRtyC+UQ1kUuBBd9R9h4jVbAFKRPH
         dpxDwsO1KCMZ6O9xaZOTatl+ZBrQZiJfo+NBBUB9h0FtfP27nNOUHPtWWaLdzT6AtfU8
         DbRalDsK83a0qMzswk4uXrum0G7BSPNvsLZrdsxGK3ygf8/BBxASOG0dLYs4eqBq6Qp+
         rjVA==
X-Forwarded-Encrypted: i=1; AJvYcCU/u2SO0pnEJbfZ/w2IMfONH5YRvX9J/Yi0OZli29H9YfyLf7UAs0VYpgPxeqRAe7yOdDJb/fyBy5/O/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYr0v/o/obAX/aBWBlBKhK7uVod2uJlLandjiUjCmy0HbD8vw
	RvC7mA8+1swYGBSeM9xu2AcT0Dn/bgziIObMjZ0ccbLQY3h6gIvmqN0nbMm7URFNbBVonqUZZy8
	xmI0pqQjHGv4bVFfNizt+H9Ko8mWNCK6Ox6JlBvWcIg==
X-Gm-Gg: ASbGncs9/cKXd6q2+tCL0q4X/P5imtfvbBpeARiUin4dft0oVYGTFY0/2nV2Pkdosxi
	6tFY4870kZt75Egdtn/cgc8bqwE2LsrBQLWj4tlQB+FgUYKw+pvKNE9rSbshOpndnd7ZTDV/I/T
	y/IAJ/OgBQfICzZOQJz6PIwjfwlGsAHQoLoPqKpJKLuqgoknTsAcxxDm6gk1i8AyurMzsK1A7P8
	z8kaw+n+jn85znMyG2DeANzp9OmHNuGP/yUYeVBsj6Qne7KR0TDkGpfakN8AUbmb8NmwSke1Bn1
	JY2dHO2TxBtF3gEvgLx4GQf0mBALFw8yhU0E38n76IkDmtxIUQISvwP6Kw==
X-Google-Smtp-Source: AGHT+IH0GpNu8OcPILF9Raq62UJjxwwibg/WeH8wca4boQwL20l6JfnXHmXw07G1pw0XikDdZBojMrIekGw68Rb/UZE=
X-Received: by 2002:a05:600c:314f:b0:477:7a94:6918 with SMTP id
 5b1f17b1804b1-4778bd79d4cmr21403655e9.18.1763029456551; Thu, 13 Nov 2025
 02:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113093110.2619692-1-neelx@suse.com> <6a7a088c-4e6f-4787-8513-bbe20658edcb@gmx.com>
In-Reply-To: <6a7a088c-4e6f-4787-8513-bbe20658edcb@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 13 Nov 2025 11:24:04 +0100
X-Gm-Features: AWmQ_bn5c3UWw6CQ-Qsx1wLxtICQ4huiztB1GrTObIhN7OfC3h1YIZgCqILwE3M
Message-ID: <CAPjX3FdSsL+-MYf2onDZSmdroppZre6o0Ciw8xFPg4qZUJhnQQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: simplify async csum synchronization
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Nov 2025 at 10:44, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> =E5=9C=A8 2025/11/13 20:01, Daniel Vacek =E5=86=99=E9=81=93:
> > We don't need the completion csum_done which marks the csum work
> > has been executed. We can simply flush_work() instead.
> >
> > This way we can slim down the btrfs_bio structure by 32 bytes matching
> > it's size to what it used to be before introducing the async csums.
> > Hence not making any change with respect to the structure size.
> > ---
> > This is a simple fixup for "btrfs: introduce btrfs_bio::async_csum" in
> > for-next and can be squashed into it.
> > ---
> >   fs/btrfs/bio.c       | 2 +-
> >   fs/btrfs/bio.h       | 1 -
> >   fs/btrfs/file-item.c | 6 +++---
> >   3 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index a73652b8724a..fd6e4278a62f 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -106,7 +106,7 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_s=
tatus_t status)
> >       ASSERT(in_task());
> >
> >       if (bbio->async_csum)
> > -             wait_for_completion(&bbio->csum_done);
> > +             flush_work(&bbio->csum_work);
> >
> >       bbio->bio.bi_status =3D status;
> >       if (bbio->bio.bi_pool =3D=3D &btrfs_clone_bioset) {
> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index deaeea3becf4..0b09d9122fa2 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
> > @@ -57,7 +57,6 @@ struct btrfs_bio {
> >                       struct btrfs_ordered_extent *ordered;
> >                       struct btrfs_ordered_sum *sums;
> >                       struct work_struct csum_work;
> > -                     struct completion csum_done;
> >                       struct bvec_iter csum_saved_iter;
> >                       u64 orig_physical;
> >               };
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 72be3ede0edf..3e9241f360c8 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -792,7 +792,6 @@ static void csum_one_bio_work(struct work_struct *w=
ork)
> >       ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
> >       ASSERT(bbio->async_csum =3D=3D true);
> >       csum_one_bio(bbio, &bbio->csum_saved_iter);
> > -     complete(&bbio->csum_done);
> >   }
> >
> >   /*
> > @@ -805,6 +804,7 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool=
 async)
> >       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >       struct bio *bio =3D &bbio->bio;
> >       struct btrfs_ordered_sum *sums;
> > +     struct workqueue_struct *wq;
> >       unsigned nofs_flag;
> >
> >       nofs_flag =3D memalloc_nofs_save();
> > @@ -825,11 +825,11 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bo=
ol async)
> >               csum_one_bio(bbio, &bbio->bio.bi_iter);
> >               return 0;
> >       }
> > -     init_completion(&bbio->csum_done);
> >       bbio->async_csum =3D true;
> >       bbio->csum_saved_iter =3D bbio->bio.bi_iter;
> >       INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> > -     schedule_work(&bbio->csum_work);
> > +     wq =3D bio->bi_opf & REQ_META? fs_info->endio_meta_workers: fs_in=
fo->endio_workers;
>
> Metadata will not go into btrfs_csum_one_bio(), thus it's fixed to
> endio_workers().

I suspected, but I was not sure so rather be safe than sorry.
That simplifies it quite nicely. Thanks.

> > +     queue_work(wq, &bbio->csum_work);
> >       return 0;
> >   }
> >
>

