Return-Path: <linux-btrfs+bounces-10628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C89F9D0A
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2024 00:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEDA18914C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2024 23:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D022686D;
	Fri, 20 Dec 2024 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL1cllvZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3E1C0DD3
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734736329; cv=none; b=K8GlnOZSCJdUbhrKJk31k/1RwW/oUv/wegQydRAEcEE+Is0Uk3eEQXloNhJ9rSKjecplAN9XrYrJSp7ThuSDhOLkisKvaoqSjVFcc6CmKdVVP0IE8SIPLu4ost7CVQaQI6mdpnccVyhiBPH+/EIDsHQkzVM7pjQ1hg2AvaKRW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734736329; c=relaxed/simple;
	bh=qSa85hjglkiLadXwBg6OjJBdtjA7g4nM20UUSJEQXEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6G8BTLyH6S2w8yVP+tryOeDhWr2QNoUYux6DA8fTPr6f+ppFBrwxjirzN7O8S+U5THen508lFalfyhChyQbFsSjuAmt04L9rymtL2g69BuOIY7lALS56izCZpO88Gm64hAcN/xRR02/Vp93NvzjmEcSTTCOIJBLyDbeuu22R6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL1cllvZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee74291415so1836002a91.3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2024 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734736327; x=1735341127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HX6J+jHGIKgnxcalsW67Ld/gUMrYMM7HU2UOq5HKCSc=;
        b=NL1cllvZaNnrmqvhSxjDpFGAbA6FGTS/IjDklLDSNsm1ttFyvYovT+107msGkQgrxZ
         ayG3xeIrJ4RUhVFNJLdMxtzplrGqV81fXzcKZJz5WQqmc3i9IhILPhsSjt/ccmiPQeBS
         ohc3vWxVcAwYL88tXC2OHEQYMhI1zYZKl3pKWkpl6nT597kWHPJF5ZQDw851S5Ef6+PG
         hNVUDfYAEjVGUralFA2SS/fSup0ov1pt8mf/+2nq0baU++IO14mz/LwEoedtwYYw1a67
         OsXdXUIp35peZrQSUJMzj28HhZ0dQZXoe/oCmox9lezND9XwJlyxfbw/webGUaUlB26O
         RvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734736327; x=1735341127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX6J+jHGIKgnxcalsW67Ld/gUMrYMM7HU2UOq5HKCSc=;
        b=Kb7bxhPbZDUMqg9nfeGCPZdJccsI3hig4HpypXNnPzj/YG/OW4qIP2I365eWynVhVR
         NGwtY84S0Q430vb4uS5jdgM+LaomRuJCgj2OZLn7Rbr1VM7qvVamAeshh6Tp3o3VMfCg
         mxr5k1riql5mOrZVlxqDD6P6ZKblvPHomjnJpQF3zo5Al3wLbGq9CzZ96ZFXYw2EEC4I
         4bL24xad4O02vMyoAQZ6ppaQANnLfc4aH48/dnj6MCYrCpu0CsrhzADGRm0MM2jODWCt
         6gIyPncEzJjsh/1Q7w+EEaqpLTBah8LX2SqbAyP005vVDaok38pCvDyF1EdgZc8TTRp5
         3tAw==
X-Gm-Message-State: AOJu0YxIAO9EcNzOaEgcUzHa1RWAUdJBL2Eg4eSN2ZJZghDWWhGCpij/
	hEgQmgYZKwBk6Tm00PBDPGJLq4Mg9ql4IIXn8i2TcWR5yf3OZ5Xd9KdBXJvoLJTe2+rf75hmrqW
	uoElQaNAnajCJ8ug9Z+6YfY6QHjiGpOWW
X-Gm-Gg: ASbGncuWsP+sxlhs/oNH3j8mH1t48kID+8B+YjtVBxn/X4IPybWSKqQ/we6eonTj3GU
	VACSfQVJ9GboSNT7VB8Skx+qQNBxXcviXcLv+Sjg=
X-Google-Smtp-Source: AGHT+IFsx/SzItc3XeD0BDmTS5jYX12S+g2qWHyOAg4tOUoXdKQzWUw6jkDW00qzILi9vDrRPiysEF99NbN7F+DoZok=
X-Received: by 2002:a17:90b:134d:b0:2ea:4c4f:bd20 with SMTP id
 98e67ed59e1d1-2f452eed773mr6479976a91.32.1734736327070; Fri, 20 Dec 2024
 15:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJhrHS2b5fv7wmchdqkCy-jEWZ7hD_3YUgCO_oUCNaf9ossq6w@mail.gmail.com>
 <56d3885e-5651-4fd4-af6d-89897f8bd240@gmx.com> <CAJhrHS1xgfrp=Wpk18xCBGUEi2tYxaqCxrMQG5UEGSUbR4G-_w@mail.gmail.com>
 <d5372478-70f4-4a3c-bf9d-26366f955e5e@gmx.com> <2809427a-41f5-4b59-9d03-2c2012e16f76@gmx.com>
In-Reply-To: <2809427a-41f5-4b59-9d03-2c2012e16f76@gmx.com>
From: Ben Millwood <thebenmachine@gmail.com>
Date: Fri, 20 Dec 2024 23:11:55 +0000
Message-ID: <CAJhrHS3tE22AYSRjBLRC4vkdGaUxX-ibKoXt=K4RAvEbLq3_7Q@mail.gmail.com>
Subject: Re: dev extent physical offset [...] on devid 1 doesn't have
 corresponding chunk
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry for the delayed reply. I left this for a few days to see how the
check would get along.

I think probably the terminal I was doing the check in was resized a
bit, so the output got a little shuffled around, but it now looks like
this:

root@vigilance:~# btrfs check --progress --mode lowmem
/dev/masterchef-vg/btrfs
Opening filesystem to check...
Checking filesystem on /dev/masterchef-vg/btrfs
UUID: a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
[1/7] checking root items                      (0:46:43 elapsed,
68928137 items checked)
[2/7] checking extents                         (14:49:23 elapsed,
2419[2/7] checking extents                         (14:49:24 elapsed,
2419[
2/7] checking extents                         (14:49:25 elapsed,
2419[2/7] checking extents                         (14:49:26 elapsed,
2419[2
ERROR: device extent[1, 1997265698816, 576716800] did not find the
related chunkhecked)
[2/7] checking extents                         (164:06:57 elapsed,
34215503 items checked)

so it looks like the check has noticed the same problem that the mount
has, at least.

I don't actually understand all this terminology -- is the "items
checked" number for checking extents counting towards the same total
as the "root items" number? Or is there any other way of estimating
how far it needs to count? (Obviously using that to estimate time
remaining would be highly approximate, but hopefully I could still
find out if it's measured in weeks or years).

On Sun, 15 Dec 2024 at 04:46, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> Do you still remember if there is any error message for the
> clear-space-cache interruption and the next RW mount of it?

I can't say confidently at this stage, but I think there was no error
at clear-space-cache interruption time. I think it's highly possible I
could have missed an error at my next RW mount attempt, I was probably
trying a lot of mounts and often only paying attention to the part of
the error I thought I could debug. (there has been no next
*successful* mount of this disk, RW or otherwise...)

> Thanks,
> Qu
> >
> > Meanwhile I have created a branch for you to manually fix the bug:
> > https://github.com/adam900710/btrfs-progs/tree/orphan_dev_extent_cleanup
> >
> > Since the lowmem is still running, you can prepare an environment to
> > build btrfs-progs, so after the lowmem check finished, you can use that
> > branch to delete the offending item by:
> >
> > # ./btrfs-corrupt-block -X <device>

(I have been able to build this but haven't run it yet, since I'm
still waiting to see if the check says anything interesting)


> > Thanks,
> > Qu
> >
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>> smartctl appears
> >>>> not to work with this disk, so I can't easily say whether the disk is
> >>>> or is not healthy.
> >>>>
> >>>
> >
> >
>

