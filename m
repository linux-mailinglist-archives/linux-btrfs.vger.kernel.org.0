Return-Path: <linux-btrfs+bounces-7762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DA8969333
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574101C22EFE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 05:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155A1CDFB5;
	Tue,  3 Sep 2024 05:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epV4q0kl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A57195
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725341077; cv=none; b=KOJUcXh2U1btLVE8C3jnnscVWr9KZJhq6Gbq9IBK3Si4dPSuH3B38FB5Mpls9ST6vvwd8bLoPS6ih55mCwRXzFiTGXZLbvssHXCSERGXW7B0Fwh+BwDIvJwRPhIYjRwFitMRXvF0S5rVh+qupjgtTLkvhMrnjh/rpqXUKG2x384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725341077; c=relaxed/simple;
	bh=FcztNhuGiCef1fb1JslXcZpW2ifjolJLNKFViQy1yBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTJF6Wo63ll5Yxg+JU/HnJcjm2AC9qKWqiPASnNlJlQkzSa2EDqosoGX+gd6q0kh9vwzEBwO36+BB4dTXMCchTFhDP472PA7Hgg+bdrpkKMeMX4oG+KDIS0hCof77K2A579R0eLHZ0ORPNaWeNkH44fY+AUQiIt6Bad1RRAp8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epV4q0kl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c326c638so1670973f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725341074; x=1725945874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K50spLaE/79NWodWctV8pib+2s6zmggNjOJvlDdunys=;
        b=epV4q0klnskcFXnraEaEH85SQWvgTosJMBK452SywMDPTvV7UzYE/KP+OJl38awTMM
         DALoovkQA//FqK77+w9O0z2Wgh+mexNAiQq8YUKtjtgBKYs9MuddSQDSIwtoQA8WsoTx
         g0kQcBaopc3W3Ki7S3XndFWMnLTVqhxL8s+pkU72bzBTnEKHxGjBZl0yZRWjU2cyS82M
         Hj15IWbMxjVPNPaRfQgJD+GX900FRU55YtQaf+xXvUuE/RDXyR+8hLyep9zopSJYMeDX
         Iv3x8SKf2O6bHauvxHEQ4SveIrKqf79w/58VtxZuEexfvhGwmfitY9vKyP0YUH+K7mHa
         n+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725341074; x=1725945874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K50spLaE/79NWodWctV8pib+2s6zmggNjOJvlDdunys=;
        b=olOcYERKnUvwGZROux8im1ryd2cJpLLWU/3IQIQxRiZN47PJG9b7gKxxg2WdTsm0mL
         lv8KI8Xb0VDY+NbxnvzFZKjeBpWev/CY6nInYfAo5V6/gM3cq9pEaPP7gwYVW1WEm5Lc
         lwgoPoRMmQYxtVjjyfc+tSk1xxrd8So/sv7FSMcrPaWoxwDIyVVXmE2tldDIfvaGfwRe
         3KLH245UWESKxOKZm7W14BlqVUsMV1IYxJx2ImIrrUAPicYFKr7cRS2895kPl86RM69w
         435t+pxcYjd6kXuzf3zQEVywlh/Rx5vo8pvg5LMJ8Ib3p/e00IUHwoRKrowDlfsRrkL+
         tpeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPdhmNNZSMoD+zlGVzfHeAa/29mRzRgauswwIIg3VLOqw69IXBZzo1FbNtbVOTkHw5XLeGdrMlkXFxkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnopZWuZQ4kV0iVepeeS6DzZq64XR8wAhmEPonJW0Wz9iEDW+X
	Tg5xS0hY+PsT2OWLhshmeoBPQmbFYhArVbdtACOB8PEtQbfS9XArR4xYkI/xLrBOC7ALD95QAi+
	8Yt+g9Q210YD2LiVNSOviMvdtDBU=
X-Google-Smtp-Source: AGHT+IGlZ3AItegYUnwTNf3RApaigXh6Mk4BLYBbx0iSFoP28KDOTfINAYehOKo6/DhYlnXC21hjHR+y1B16LMYOKzA=
X-Received: by 2002:adf:f344:0:b0:360:791c:aff2 with SMTP id
 ffacd0b85a97d-374bf1c6cf6mr5582625f8f.47.1725341073581; Mon, 02 Sep 2024
 22:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>
 <20240902203127.GD26776@twin.jikos.cz>
In-Reply-To: <20240902203127.GD26776@twin.jikos.cz>
From: Xuefer <xuefer@gmail.com>
Date: Tue, 3 Sep 2024 13:24:23 +0800
Message-ID: <CAMs-qv_m5fyj1mmN=p5BHkpuOL3LF6eaMdFNcDCazHqLSLxLdA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: handle broken write pointer on zones
To: dsterba@suse.cz
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
	HAN Yuwei <hrx@bupt.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:31=E2=80=AFAM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Sat, Aug 31, 2024 at 01:32:49AM +0900, Naohiro Aota wrote:
> > Btrfs rejects to mount a FS if it finds a block group with a broken wri=
te
> > pointer (e.g, unequal write pointers on two zones of RAID1 block group)=
.
> > Since such case can happen easily with a power-loss or crash of a syste=
m,
> > we need to handle the case more gently.
> >
> > Handle such block group by making it unallocatable, so that there will =
be
> > no writes into it. That can be done by setting the allocation pointer a=
t
> > the end of allocating region (=3D block_group->zone_capacity). Then, ex=
isting
> > code handle zone_unusable properly.
>
> This sounds like the best option, this makes the zone read-only and
> relocation will reset it back to a good state. Alternatives like another
> state or error bits would need tracking them and increase complexity.
>
> > Having proper zone_capacity is necessary for the change. So, set it as =
fast
> > as possible.
> >
> > We cannot handle RAID0 and RAID10 case like this. But, they are anyway
> > unable to read because of a missing stripe.
> >
> > Fixes: 265f7237dd25 ("btrfs: zoned: allow DUP on meta-data block groups=
")
> > Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid s=
tripe tree")
> > CC: stable@vger.kernel.org # 6.1+
> > Reported-by: HAN Yuwei <hrx@bupt.moe>
> > Cc: Xuefer <xuefer@gmail.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
> Reviewed-by: David Sterba <dsterba@suse.com>
>
> > @@ -1650,6 +1653,23 @@ int btrfs_load_block_group_zone_info(struct btrf=
s_block_group *cache, bool new)
> >               goto out;
> >       }
> >
> > +     if (ret =3D=3D -EIO && profile !=3D 0 && profile !=3D BTRFS_BLOCK=
_GROUP_RAID0 &&
> > +         profile !=3D BTRFS_BLOCK_GROUP_RAID10) {
> > +             /*
> > +              * Detected broken write pointer.  Make this block group
> > +              * unallocatable by setting the allocation pointer at the=
 end of
> > +              * allocatable region. Relocating this block group will f=
ix the
> > +              * mismatch.
> > +              *
> > +              * Currently, we cannot handle RAID0 or RAID10 case like =
this
> > +              * because we don't have a proper zone_capacity value. Bu=
t,
> > +              * reading from this block group won't work anyway by a m=
issing
> > +              * stripe.
> > +              */
> > +             cache->alloc_offset =3D cache->zone_capacity;
>
> Mabe print a warning, this looks like a condition that should be
> communicated back to the user.
indeed, and possible case by bug e.g.:
strace -f mkfs.btrfs -O zoned,raid-stripe-tree -L bak /dev/sdd -f
.....
[pid 12871] ioctl(3, BLKDISCARD, [0, 268435456]) =3D -1 EOPNOTSUPP
(Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [268435456, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [536870912, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [805306368, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [1073741824, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [1342177280, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [1610612736, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [1879048192, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [2147483648, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [2415919104, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [2684354560, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [2952790016, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [3221225472, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
[pid 12871] ioctl(3, BLKDISCARD, [3489660928, 268435456]) =3D -1
EOPNOTSUPP (Operation not supported)
Conventional zones are not reset/cleared, the emulated pointers are not cle=
ared

