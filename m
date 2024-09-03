Return-Path: <linux-btrfs+bounces-7760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B59692E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 06:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8B6283EDB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 04:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD601CCEEF;
	Tue,  3 Sep 2024 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amAUqtMq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5578195
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725338012; cv=none; b=jTuCAI65K8+AN5SontmHVlsq+0Cgyicev+2yxQjJWvTmyfrEqSSFykVxIVbIcqyIIkLkxHM51LcqL/iLJ/7/K19uopEMyoiZMXtp+aj5HuIjG39KLV9KW2pR159uCF/0eCNHVlcEL0zkbfV1VX8cL2jMVLOrQoIKVWVpB+2RnVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725338012; c=relaxed/simple;
	bh=JnLYOqeBYp14ac3ogCBj+Forpfs4SLa3kVevVvCZ7jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQOOIX/7GblLUbchxnVQFcg287zoYuTuMV9eibKJ4jaT71LKQ3o6Ib2adBiMKWw1YjgvPvKmB3j+NWAN9yDcvHIiaxvY0iZlpjcsuLMxhvZX8GYVzldQbUd4sDNo+5coO+dnBb5st+8ALZ0Tq4g/fcaLJM+JqdT5IVnSYJ1cUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amAUqtMq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso27753185e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 21:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725338009; x=1725942809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCeg7YMqb6dEltZok9bEqbd6te9UCN6uEwZtzwNHEgQ=;
        b=amAUqtMq6r0WmxQDXvLfl7/D4zSQm/bEU3Z7MydSs0gIGw+BZZ2mTWB1BTi7GA3pS7
         TuDX3Y7PhndPkN4h8nYaTyH7k57gCQ5ocg4EPoTYpXRVPPCw1u6DW53JFmGIyH9Nq262
         CavgiqegTpr16/HNSG9WsgwEp3vwpdVLVcUg3FBewHmrQTA4+Oc5AKGxc3x5tM0GHuJW
         7S3Sr99BgrG3fRSrtLfoa3l2ffdVEoOS8CkYPid9s/1246XTdBlpv1h+nwR7ULZvcNtz
         DoxpzyUTHb9eWWQZQddcwDefKOS5FuVs5wlhXW7J6WaCzPZep8GeT7wKLQhzUuiuQHsZ
         6FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725338009; x=1725942809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCeg7YMqb6dEltZok9bEqbd6te9UCN6uEwZtzwNHEgQ=;
        b=XmpoqiJLYuI/IVBCnY3UyfWxT69No+2nWku59pdy9v3dRY7cP+bMeNHn3xGaqN6YP3
         aTT7D8rLC0Y60tGDz6x6RBoGIUHCrq0K/Uju8V0Rnn+6K1FBXZZ8g4+mWo1nPsSYkmiP
         Do5MDKYt9F68hWFV1DR3rAmoPaNDELD0rY6tJ9FLqh1vWQyZT0BcPSv9Tc6IxQToeOls
         IQ6SJNYg7hPtKTJneMnWGGykIwSHrgvNbIE3WJUkoD96heajygLrHVXjZCElvA5ijO7U
         X1GlrqubDAbssvueWLYgpMUhRt5gKx1ooqUVXYkmLSKDW6GE6inhMtm2FiWFSHhHvlYq
         UwhQ==
X-Gm-Message-State: AOJu0YzhbfSS/IvGfKpvRwSWERsZK2HzU/2gnmQg9Suo8sxKI0XxbEba
	i49Iy22adoLMbM7vMbco4YAS+Rd18HwQE+Dr+R1ZZlnuSOq6MzJiye24KkfRBO3oAcMZiJo0Lfk
	qniq2tAAVjk3UEF1sy/rWXwgyvPY=
X-Google-Smtp-Source: AGHT+IHU3aKSOZR7CqrovMBrgUS+gqx/rjyl4GDAFV5TglgOceRjw8vy9hcDkX/UKm462peNJlAQ0KGDEkbTE9Uiwa8=
X-Received: by 2002:a05:600c:997:b0:42b:bbc0:d781 with SMTP id
 5b1f17b1804b1-42bbbc0d7f6mr74946085e9.3.1725338008756; Mon, 02 Sep 2024
 21:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMs-qv_QuHCA2pU4w4fiQbqnvo2PikmhM=AE+YrNzLsKxQ149w@mail.gmail.com>
 <20240902195929.GA26776@twin.jikos.cz>
In-Reply-To: <20240902195929.GA26776@twin.jikos.cz>
From: Xuefer <xuefer@gmail.com>
Date: Tue, 3 Sep 2024 12:33:18 +0800
Message-ID: <CAMs-qv99kdgrWeqN+piJpDSnWRCGT2adqka2eTUnjk09WphHQg@mail.gmail.com>
Subject: Re: is conventional zones used for metadata?
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, that explains a lot for what I saw happen and what I read
about emulated write pointer.
about "intermediate step", it may be true for compatibility and
migration, but conventional zones are IMHO really good for metadata.
regardless of the idea bout advantage, there's a bug about conventional zon=
es

sdd 3:0:0:0    disk ATA      HGST HSH721414ALE6M0   L4GMT10B VFGH8XBD
      sata
strace -f mkfs.btrfs -O zoned,raid-stripe-tree -L bak /dev/sdd -f
......
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
[pid 12871] munmap(0x7ffff71d3000, 266240) =3D 0
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

BLKDISCARD is not supported for conventional zones on my disk. I'm
afraid the emulated pointer is not reset to 0 as intended
https://bugzilla.kernel.org/show_bug.cgi?id=3D219170 this bug may also
be related. the ending result were the same: failed to clean btrfs
signature on "btrfs device delete" which sit on conventional zones

On Tue, Sep 3, 2024 at 3:59=E2=80=AFAM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Mon, Sep 02, 2024 at 11:35:35PM +0800, Xuefer wrote:
> > For zoned devices there're conventional zones and
> > Sequential-write-required zones. I use btrfs on HC620 (HGST
> > HSH721414ALE6M0). The conventional zones are about 131GiB in
> > total.but.My disk metadata is using 13GiB which should fit into
> > 131GiB.conventional but it uses a big size which causes unnecessary
> > big unusable zones.
> >
> >     Device zone unusable:        728.00GiB
> > Metadata,RAID1: Size:736.50GiB, Used:12.62GiB (1.71%)
> >    /dev/sde      736.50GiB
> >    /dev/sdf      736.50GiB
> >
> > this behavior make me wonder if btrfs take the advantage of
> > conventional zones for storing system/metadata data
>
> Currently, conventional zones are written to as if they were sequential,
> the same code that does the emulation on non-zoned devices. I found only
> one exception for the conventional zone, it's the superblock that is not
> appended each time but rather overwritten at the offset 0.
>
> IIRC the conventional+sequential devices were meant as intermediate step
> towards sequential-only devices. Filesystems that overwrite in place
> could have been adapted to use the conventional zones for metadata.
> There was a talk at LSF/MM 2015 https://lwn.net/Articles/637035/ and
> https://git.kernel.org/pub/scm/fs/xfs/xfs-documentation.git/tree/design/x=
fs-smr-structure.asciidoc .
>
> So, this depends if the mixed zone type devices are expected to be
> available in the future or if the current ones are the end of the
> line. We've seen that the host-aware have been also discontinued (and
> support removed from linux).

