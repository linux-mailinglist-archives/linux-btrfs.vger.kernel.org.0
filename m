Return-Path: <linux-btrfs+bounces-19719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE9DCBB45C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 23:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C0A300A1C6
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 22:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8112C2360;
	Sat, 13 Dec 2025 22:10:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530512080C1
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765663809; cv=none; b=LXffCj1Fy4EwRgUfMCVtkFCt8/4ahefPReljWUxlwaxYOV5gLr/PPMaVQqGiA3BW7JdQv/3sM9KGnYV6ekSV8vCphdjCqDFaYao2Mo2oxtsPoRaPiCxyjMotJt1++QE/6umXdA5GNFSsrakRsb1LqXtrC/90idIzU5PEuIoPHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765663809; c=relaxed/simple;
	bh=TZ0JnNU/77uqpaUO0v2+QHDIqbhcBSnuTpHEdqTN7c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFow+Wmf8k+k+pYProv8j2E3WaOVnAM81aUgLV+z4rfugAPUkpSUinFZcRMpyszwJfkh+RYNPQeKlGVnNp0n/NBnqM6mCGkKAl98/INMvCQNlJGEmpX8coAO695kJhErqM4Qz4ACoQjxyKbSCJOnnUGHwlTk/+3TH+L6y+VfSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4557c596339so1264819b6e.0
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 14:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765663805; x=1766268605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKlv92S/8RgHEPKDrT5CJC5BUDn/+OiF8TfPdVbdN5A=;
        b=SEh9ZgxdQWYQVwbu1hJsx0H5lkQItFWaeNIb9NHJ8f3IoPV7ztH0O9buP8a2QcQCj5
         Ndul9ux1q1KHUwLyG3qTjBLLVZgVQEBBjgsoAp3jfRSD9o6WxB+Kq/UCZpQ8zGkrhFv4
         w2dWt/Pj2whJDpiJGPrs8xaNXhAFSlzPOXtxdpXbir6/tuVkV/nZEge0r6qDw++W+Ma6
         zOIwNN1e4FVePBIq5jvdBb7eQtk9VyvelLZ2RCTfc0kgQ/MgOmKdEJ5TlmQQgwtV97lP
         RV7sYHjnGIRcjrky2Rz1YRXql+svhU5LfDhePnSv//18hdZrjoR+5VYVuJ8Q8QFK2baE
         20Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV4ra6RuPV0JE/i/MPZRXvPYpWizk0kQ/IjtRquzWh7WxQ9eyn7/PkdK6+V5CznUakZKHt7tvW+47FSMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoaj6/1eED10qaS44u/Ys/IePq35XC/6XLRCSayYv8DvVE+Lem
	vkzsG39SWXMfjeckj7KVnhuJRSbWyMtp3zZrgmwmhoGFFkT5INMF43jEh6MWwg==
X-Gm-Gg: AY/fxX4Di/33/AjO1pyQC+2YBY774VcjfqNQ9tk11ZJ+IWv4Yk3qbJLhsOiDYX17eMK
	4I8Yeq9ttGY5yS1aktunjJeK97iKg9D3+EIpJYUYHaCI+SLV0Vp+WLGtKs/hruIqBS36m0/4Xw9
	gEWG4W+DZZyq5xDJwckeQHvyHzro/h9ODENnmX3EE5roCj1rqoVKznmPA/HH9bGWEEnyEgZLOdS
	TtaSmTzbnM8k+PPEQRzjxjustV0LOnqfPh31Hbieck238ayvBemOnXnMhsUkKYFxNFSdIz3/cTU
	47R36Andww6M355ZpnRx12AphA1z1znElr479C9G9mziOGV2RRIz8Z9TrD1V1WzLIbghqCUFsak
	9cHm2l/W8cKZFip5jdej3aDg294dh+LaI0RAzNNqSUnZAL9Ym06HFtDs18BQRjzrol47Icfimn0
	T/hqWSEq+3jgpju9i5NU83PU8ncnZN7gTAAz2QpHgM75sEPmSQPiuKbT0shmR9P5htqHRy9Ifa
X-Google-Smtp-Source: AGHT+IGt0QBqYP3YHf1Q8CpocAurLMdYw+Nm4hfUUqelbI7C9wvT11RhthioiO5oNXIbPUDVj60W3g==
X-Received: by 2002:a05:6808:f8f:b0:450:c79d:92de with SMTP id 5614622812f47-455ac96070dmr2774218b6e.41.1765663804924;
        Sat, 13 Dec 2025 14:10:04 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-455bb6b895asm1423249b6e.16.2025.12.13.14.10.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 14:10:04 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c52fa75cd3so2075234a34.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 14:10:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+S4fRtxGmX266Rq/DscfzT48NE6VsZ2BPsKLiqnz1IJ/Jx7DeXtIwmXfq5XJc9S1i9Wl7XxiXSjZygg==@vger.kernel.org
X-Received: by 2002:a05:6830:43a5:b0:7c9:5ac6:12de with SMTP id
 46e09a7af769-7cae82d808emr3717334a34.5.1765663804370; Sat, 13 Dec 2025
 14:10:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022010215.GA167205@zen.localdomain> <20251023232737.3346933-1-loemra.dev@gmail.com>
In-Reply-To: <20251023232737.3346933-1-loemra.dev@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Sat, 13 Dec 2025 17:09:28 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_UqjNBVcCnqeTzJtGjyMVrNv7bNPuZ5et=iOaKraKmuw@mail.gmail.com>
X-Gm-Features: AQt7F2pgyoQCvkMmyoQxy2XM_OuKasJ351j-zoE7PeynmqAgZyUZVM_iXPx1qoQ
Message-ID: <CAEg-Je_UqjNBVcCnqeTzJtGjyMVrNv7bNPuZ5et=iOaKraKmuw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
To: Leo Martins <loemra.dev@gmail.com>
Cc: Boris Burkov <boris@bur.io>, Chris Murphy <lists@colorremedies.com>, kernel-team@fb.com, 
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:27=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> On Tue, 21 Oct 2025 18:02:15 -0700 Boris Burkov <boris@bur.io> wrote:
>
> > On Tue, Oct 21, 2025 at 08:37:18PM -0400, Chris Murphy wrote:
> > > Thanks for the response.
> > >
> > > On Tue, Oct 21, 2025, at 6:39 PM, Leo Martins wrote:
> > >
> > > >
> > > > Wanted to provide some data from the Meta rollout to give more cont=
ext on the
> > > > decision to enable dynamic+periodic reclaim by default for data. Al=
l the before
> > > > numbers are with bg_reclaim_threshold set to 30.
> > > >
> > > > Enabling dynamic+periodic reclaim for data block groups dramaticall=
y decreases
> > > > number of reclaims per host, going from 150/day to just 5/day (p99)=
, and from
> > > > 6/day to 0/day (p50). The trade-offs are increases in fragmentation=
, and a
> > > > slight uptick in enospcs.
> > > >
> > > > I currently don't have direct fragmentation metrics, though that is=
 a
> > > > work in progress, but I'm tracking FP as a proxy for fragmentation.
> > > >
> > > > FP =3D (allocated - used) / allocated
> > > > So if there are 100G allocated for data and 80G are used, FP =3D (1=
00 -
> > > > 80) / 100 =3D 20%.
> > > >
> > > > FP has increased from 30% to 45% (p99), and from 5% to 7% (p50).
> > > > Enospc rates have gone from around 0.5/day to 1/day per 100k hosts.
> >
> > Leo, correct me if I'm wrong, but we have yet to investigate a system
> > where unallocated steadily marched down to 0 since the introduction of
> > dynamic reclaim and then it ENOSPC'd, right? If there is a strong,
> > undeniable increase in ENOSPCs we should absolutely look for such
> > systems in those regions to motivate further improvements with
> > full/filling filesystems.
>
> After digging some more the only examples I found of btrfs enospcing
> from lack of unallocated are true enospcs where either data or metadata
> were entirely full.
>
> >
> > There is also the confounding variable of the bug fixed here:
> > https://lore.kernel.org/linux-btrfs/22e8b64df3d4984000713433a89cfc14309=
b75fc.1759430967.git.boris@bur.io/
> > that has been plaguing our fleet causing ENOSPC issues.
>
> Yes, a deeper look revealed that the increase in ENOSPCs is
> due to this bug and not dynamic+periodic reclaim. In fact,
> the hosts with dynamic+periodic reclaim enabled see a relatively
> smaller rate of enospc (about 2x less) than the rest of the fleet.
>
> >
> > > > This is a doubling in rate, but still a very small absolute number
> > > > of enospcs. The unallocated space on disk decreases by ~15G (p99)
> > > > and ~5G (p50) after rollout.
> > >
> > > I'm curious how it compares with default btrfsmaintenance btrfs-balan=
ce.timer/service  - I'm guessing this is a bit harder to test at Meta in pr=
oduction due to the strictly time based trigger. And customization ends up =
being a choice between even higher reclaim or higher enospc.
> > >
> >
> > Yeah, we don't have that data unfortunately.
> >
> > > > That being said I don't think bg_reclaim_threshold is enabled by de=
fault,
> > > > and I am comfortable saying dynamic+periodic reclaim is better than=
 no
> > > > automatic reclaim!
> > >
> > > So there are still corner cases occurring even with dynamic periodic =
reclaim. What do those look like? Is the file system unable to write metada=
ta for arbitrary deletes to back the file system out? Or is it stuck in som=
e cases?
> > >
> >
> > I would imagine the cases that are tough for dynamic reclaim are:
> > 1. genuinely quite full fs
> > 2. rapidly needs a big hunk of metadata between entering the dynamic
> >    reclaim zone but before the cleaner thread / reclaim worker can run.
>
> Concerning point 1 it seems like dynamic+periodic reclaim actually does a=
 pretty good
> job here. I haven't seen any signs of thrashing with low unallocated spac=
e.
>
> >
> > > ext4 users are used to 5% of space being held in reserve for root use=
r processes. I'm not sure if xfs has such a concept. Btrfs global reserve i=
s different in that even root can't use it, it's really reserved for the ke=
rnel. But sometimes it's still possible to exhaust this metadata space, and=
 be unable to delete files or balance even 1 data bg to back the file syste=
m out of the situation. The wedged in file system that keeps going read-onl=
y and appears stuck is a big concern since users have no idea what to do. A=
nd internet searches tend to produce results that are less help than no hel=
p.
> > >
> > > --
> > > Chris Murphy
> >
> > Anyway, I think Leo's forthcoming detailed per-BG fragmentation data
> > should be the most telling. System level fragmentation percentage
> > isn't the most useful IMO.
> >
> > Thanks,
> > Boris
>
> Since the uptick in enospcs is not actually linked to dynamic+periodic
> reclaim I now feel confident saying that dynamic+periodic reclaim
> should be enabled by default for data.
>

So have we done this yet? If not, what's holding this up?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

