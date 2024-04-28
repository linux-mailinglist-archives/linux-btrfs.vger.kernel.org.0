Return-Path: <linux-btrfs+bounces-4576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E838B4B3A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Apr 2024 12:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B12AB21013
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Apr 2024 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794256B67;
	Sun, 28 Apr 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="F+mQE2QR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6D2F29
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Apr 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714299635; cv=none; b=LSNUs82iOn0c+8S2GJP5kAK4IZgdEiH2QPVtKuyO5achkQXQ1PXsCvoU6Ce/revWzpHB6z3uBUijFcgG0w4cZjrDOQkV+WHFrY/P7podG6GMcpep9VBgjRmzqcljZcu+2DQz83s9htaqsKMjQ1f6cPKmlQt2Ray5eXg3w6h+/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714299635; c=relaxed/simple;
	bh=x3HE1zGAC1r7qfTvCBS3olRe+Mjnn1/zDMnt5MJJ3Lw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1a3PUpnhhPwKTOKNvHluqsa+xg0PCnPYAIcu2T2ETrjjk4dy/Qiz9twjUL4ND+qnxKF8coO9WYuW49hdWaSpEbQMunCYQ9dhoE8vMPSxL82oXxhG4K8q/OkML7sJ/CUKXwyVXdxlmuL9zYcbZqq+garzbe6LG4rEujI4EYu6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=F+mQE2QR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51b2f105829so4392532e87.3
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Apr 2024 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1714299631; x=1714904431; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3HE1zGAC1r7qfTvCBS3olRe+Mjnn1/zDMnt5MJJ3Lw=;
        b=F+mQE2QRc07RvqmP5Ma9Wt2+3fZ54zpkbFkaHos7hONGK9uzFb3x5xAMhwxS7+AWyd
         w4AZQXw9e3zmrFPfvA/ihBkeaN1NACB/1+nmzvQiweI5KuCyoJ/9kC2+ZOyG7yOHxtM3
         IClucnsl059SoEOE1NdZtWTtTpFgkb6geBbJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714299631; x=1714904431;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3HE1zGAC1r7qfTvCBS3olRe+Mjnn1/zDMnt5MJJ3Lw=;
        b=VeNe6LaV3zI9ZvPBpI2W0DyhUzeLR8Ne0GGdoJ+dmnwCbuCtFqo8EhYwPlg7xi0Zaq
         XquFj92J/kWgmYlj8K5q1tMg3uvjHPKk1rTiZJzMAipVJyX3+cc09qRBlaQ9cc3mmBNO
         A+3afuRFeSVE03hTiAl8LHnTbho10nsyInvvgImkpMGJ5G6dQivt7K9ng/QKK6U1yn9u
         kaLf7CgQ2DEvLBDEfZA/Qs4GUYDBEfrns5C730uvOag12/YZ0fzBPZQIQeIUeXK3BJV7
         lfUbJFKo+E32H6giI63clH56mIo5bMh7pHeI1EzwcQIVwXpXmj7H0m3IHoQeKhZMj92z
         L6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs3R3d3cXy7AVP4l2x2HEtwK21qbInFfFCtXMcG5ckx/v6p+Gcd0v9rSqc72rJPzovR6OVsbuHuZceIHrqxU2bO5nBoL/b6VkDgtM=
X-Gm-Message-State: AOJu0YxPCY7AsgNTTcC1F9fwtssK4pen3jXphC4S/Y+pGD36u9jp/tIW
	L9lZELn+jhWvFZKw5Xiqqu4ktjAIhJvlQhtsQJjxVXvw8J966ZDspSITy93b2HPp2N/tAfJy+Nk
	k
X-Google-Smtp-Source: AGHT+IGuXnjhY8jXJjm+TiwsCuJs4oanZPaRH21KYWYRFAy8yVEzNMdId4J08UYmL7vaRLIomW379g==
X-Received: by 2002:a05:6512:10c3:b0:51d:a9db:cdd4 with SMTP id k3-20020a05651210c300b0051da9dbcdd4mr228101lfg.64.1714299630879;
        Sun, 28 Apr 2024 03:20:30 -0700 (PDT)
Received: from able.exile.i.intelfx.name ([109.172.181.47])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c0a0900b00418916f5848sm36971039wmp.43.2024.04.28.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 03:20:30 -0700 (PDT)
Message-ID: <18c138d9f3e8fe3a040d8a3f284317267e417136.camel@intelfx.name>
Subject: Re: What's the difference between `btrfs sub del -c` and `btrfs fi
 sync`?
From: intelfx@intelfx.name
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	linux-btrfs@vger.kernel.org
Date: Sun, 28 Apr 2024 12:20:28 +0200
In-Reply-To: <e9a07ed8-facc-462f-9fe2-ede4d1e4a8bb@suse.com>
References: <63a537d0467f3bb7683bd412c25c006f8d092ced.camel@intelfx.name>
	 <71f2d380-9b11-4ed5-949c-0edc1ed56c60@gmx.com>
	 <c8bac058c40b15a242d4598172d6a89c2f97608b.camel@intelfx.name>
	 <e9a07ed8-facc-462f-9fe2-ede4d1e4a8bb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2024-04-27 at 09:34 +0930, Qu Wenruo wrote:
>=20
> =E5=9C=A8 2024/4/27 08:44, intelfx@intelfx.name =E5=86=99=E9=81=93:
> > On 2024-04-27 at 08:36 +0930, Qu Wenruo wrote:
> > >=20
> > > =E5=9C=A8 2024/4/27 08:22, intelfx@intelfx.name =E5=86=99=E9=81=93:
> > > > Hi,
> > > >=20
> > > > I've been trying to read btrfs-progs code to understand btrfs ioctl=
s
> > > > and one thing evades my understanding.
> > > >=20
> > > > A `btrfs subvolume delete --commit-{after,each}` operation involves
> > > > issuing two ioctls at the commit time: BTRFS_IOC_START_SYNC immedia=
tely
> > > > followed by BTRFS_IOC_WAIT_SYNC. Notably, the relevant comment says
> > > > "<...> issue SYNC ioctl <...>" and the function that encapsulates t=
he
> > > > two ioctls is called `wait_for_commit()`.
> > > >=20
> > > > On the other hand, a `btrfs filesystem sync` operation involves iss=
uing
> > > > just one ioctl, BTRFS_IOC_SYNC (encapsulated in a function called
> > > > `btrfs_util_sync_fd()`).
> > > >=20
> > > > I tried to look at the kernel code for the three ioctls but to my
> > > > untrained eye, they look like they are doing different things with
> > > > different side effects.
> > > >=20
> > > > What is the difference, and why is it needed (i.e. why are there tw=
o
> > > > sets of sync-related ioctls)?
> > >=20
> > > IIRC --commit-after/each only commit the current transaction, and it'=
s
> > > just doing the same `btrfs fi sync` after all/each subvolume deletion=
.
> > >=20
> > > The reason is to ensure the unlinking (not fully deleting) of the tar=
get
> > > subvolume fully committed to disk, so a sudden powerloss after the
> > > deletion won't lead to the re-appearing of the target subvolume(s)
> > >=20
> > >=20
> > > However there is a another behavior involved, `btrfs subvolume sync`,
> > > which is to wait for a deleted subvolume to be fully dropped.
> > > In the case of btrfs subvolume deletion, it can be a heavy load, thus
> > > btrfs only unlink the to-be-deleted subvolume, and mark it for
> > > background deletion.
> > > `btrfs subvolume sync` would wait for any such orphan subvolume to be
> > > deleted.
> > >=20
> > > Thanks,
> > > Qu
> > >=20
> > >=20
> > > >=20
> > > > Cheers,
> >=20
> > Thanks for the fast reply!
> >=20
> > Yes, I'm aware about `btrfs sub sync`. I understand that's a totally
> > different operation.
> >=20
> > What I was asking about was specifically the difference between
> > `btrfs _filesystem_ sync` and the operation that happens at the end of
> > a `btrfs subvolume delete --commit-after`.
> >=20
> > Or, in kernel terms: what exactly is the difference between issuing a
> > BTRFS_IOC_SYNC and issuing a BTRFS_IOC_START_SYNC immediately followed
> > by a BTRFS_IOC_WAIT_SYNC?
>=20
> If you go really deep, there is some small difference, but overall you=
=20
> can consider them the same, despite the START/WAIT_SYNC is an async=20
> operation, while IOC_SYNC would wait for it.
>=20
> >=20
> > It is not immediately obvious that the kernel code for the three ioctls
> > is equivalent (even if it is). For instance, BTRFS_IOC_SYNC begins with
> > a call to btrfs_start_delalloc_roots() whereas BTRFS_IOC_START_SYNC
> > begins with a call to btrfs_orphan_cleanup(), and the subsequent
> > transaction handling code seems subtly different.
> >=20
> There is a small difference, but not really effect end users.
>=20
> The IOC_SYNC would start and wait for the writeback of all dirty files.
> (AKA, the same behavior as `sync` command).
> Meanwhile IOC_START_SYNC would not trigger the writeback, just commit=20
> the metadata which is already dirty.
>=20
> For the --commit-after/each, IOC_START_SYNC is faster, since=20
> IOC_SNAP_DESTORY has already dirtied the necessary metadata, we only=20
> need to commit the dirtied metadata in current transaction, no need to=
=20
> wait for other data writeback.

I see, thanks. That's what I suspected, but wanted to check if my
(limited) understanding was correct.

It is unfortunate that ioctls that should be equivalent if judging by
the names alone, in fact have subtle semantic differences that aren't
documented anywhere. It's as if the ioctls were introduced specifically
for the relevant userspace tools, encoding specific assumptions valid
for their (only) consumers, without consideration of their wider
applicability...

Thanks,
--=20
Ivan Shapovalov / intelfx /

