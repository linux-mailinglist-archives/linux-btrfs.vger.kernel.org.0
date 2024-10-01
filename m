Return-Path: <linux-btrfs+bounces-8395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9AE98C216
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC051F22AD4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4761CB312;
	Tue,  1 Oct 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le0IGMl7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D31C8FCE
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798316; cv=none; b=UunW8p9tgut3tyhwd7pHUf5ynXQ0G9+8x0m0qF29Az5mNnqgLlzccyJ2EZJRODVvM0ENb/pXb4Vn6Cnu+PWvcSOm9AUxljZxMysVkBrDuEHhs5qjuydQgl0/GF45RTo3Z8nCNYWZjN9et7svEzuBnG6gotrU82lHSL3TcHDRHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798316; c=relaxed/simple;
	bh=L/wuqTLpX1754x6XhyoN2TkoWP1ezj5qGAw6Hpdh5DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLeLBA511iJAnJdw8en6DnRyAdw+yOpNCuPxtvhOjCNXYK+8vkym2jSGeoGBzrvWfuHa2+ktUZFrZ/QbHIL2y63/g5D3+xVkN3smIcKFDksFGPsYEyPokcVl4mdFU6YotWePmT9mmolfzD0M9lRdiF1JsIEG8gl9an0Y3wGpuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le0IGMl7; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398b589032so5175776e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727798313; x=1728403113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EcjbuoERFIK9353GMqHUEfYDTleZa6XyNigsMCNTleU=;
        b=Le0IGMl7qN3/YNklPclYi+KmQoK9mdRd9DtZF65g8hPMWOUJ89fM4+mWaaUJjaKn6S
         gIzoUJD4Eonn3aV2mBJ8ylEaL/VtXfyWkWq1MPOPtC/sh05a2YPoJJTTGr9475jS1A8A
         XdgmToMsagqEMhXueCjiyuSz2Ls3LhTCHDt3Mgd5Xqgl49UJQgaSO9hCKqdZAibnj98l
         w2T/I7hYZaTKamT4tA2vKQFIukAwG0CRjDxuIlxQRj/+K09udXplmbATtxBKjkicl7tw
         bbGRWRnLtOTtoK5VOEv9Nc53AkR6M5rIo7f/H5MrKLKCGSFjSelrEhIuMMnLtavVeBWJ
         PAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798313; x=1728403113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcjbuoERFIK9353GMqHUEfYDTleZa6XyNigsMCNTleU=;
        b=uJViLm9F6NFztu7ALGfr0LzIpdP+7OE7XHCgNqUxUqlfTkOJ9QULJYTxegL674iYQp
         9aXXjquBXY0YzGonNBEXYwKUZFIUPaj9Go4m5a+rjCFOJnjZ275sxXFnmKzkJy6NEhLn
         llVoFUo038aMIt6aRWPnYOquuf/4XwDfIceugciuW+92VLDRPeCGvXDGM5Smwg4atQ3y
         SEMiz4VzKKSJ7u7AtQB80uKoyoShoK2b40ORwDtpdFQdY97bNj9tnLMEVgA2/pJS5hGA
         EOy565NaopFTE1LuRtyTthdzGH7lgZ27w1YHnnwfSTmFV9vfHis7PWsSKWYllKZ10VG5
         S5iw==
X-Gm-Message-State: AOJu0YwFBtQ7Sv7igkn1uec+9yZ9DzEmaCLT8CwWMReTyzlrvQ2V67wY
	TwLqYldK10wgqPXMVD+ErQG9ea4V3cvqttnmhC7xNeQm7WSnXDP9Z7DKGu6jMdrYR/53NznF6eq
	+Xrx1sWPWhOkioqGguseagANuWidQgaoe
X-Google-Smtp-Source: AGHT+IGhl7UuieqM+kUZvYsD+pDNn4P7n0HSnmQUa0eNSJKjmIULjUOxXhLfb/Uvkj/Ihpeb7SKGCkDpcKv72RHzU68=
X-Received: by 2002:a05:6512:158f:b0:52c:e17c:cd7b with SMTP id
 2adb3069b0e04-5389fc44ff1mr11632676e87.22.1727798312648; Tue, 01 Oct 2024
 08:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3cb3a38-32a2-4b91-9512-4703f7c5a73a@app.fastmail.com>
In-Reply-To: <e3cb3a38-32a2-4b91-9512-4703f7c5a73a@app.fastmail.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Tue, 1 Oct 2024 16:57:55 +0100
Message-ID: <CAL3q7H7=rUCjG7=QaizVTqUTvOMHJEHmg6RCFxZ5TD+FdH9fsg@mail.gmail.com>
Subject: Re: 6.11.0, possible regression resuming balance
To: Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 6:57=E2=80=AFPM Chris Murphy <lists@colorremedies.c=
om> wrote:
>
> kernel 6.11.0
> btrfs-progs 6.11
>
> I think there's a regression in balance resume. Both automatic (mount tim=
e) and manual (btrfs command line) are affected. The balance command immedi=
ately exits with 0 status in kernel messages, i.e. the kernel thinks it sho=
uld resume but then just exits.
>
> Example 1 is a balance running, interrupted by a power failure, and then =
resumed on next mount.
>
> The original balance command:
>
> $ sudo btrfs balance start -dvrange=3D100962140160..1325128482817 /mnt/fi=
rst
>
> ...
> [207090.400019] kernel: BTRFS info (device dm-0): relocating block group =
996496375808 flags data
> [207126.164580] kernel: BTRFS info (device dm-0): found 19 extents, stage=
: move data extents
> [207130.579625] kernel: BTRFS info (device dm-0): found 19 extents, stage=
: update data pointers
> [207132.733915] kernel: BTRFS info (device dm-0): relocating block group =
995422633984 flags data
> [207174.119093] kernel: BTRFS info (device dm-0): found 19 extents, stage=
: move data extents
> [207177.504472] kernel: BTRFS info (device dm-0): found 19 extents, stage=
: update data pointers
> [207179.227876] kernel: BTRFS info (device dm-0): relocating block group =
994348892160 flags data
> [207226.481484] kernel: BTRFS info (device dm-0): found 26 extents, stage=
: move data extents
> [207232.177170] kernel: BTRFS info (device dm-0): found 26 extents, stage=
: update data pointers
> [207252.918904] kernel: BTRFS info (device dm-0): relocating block group =
993275150336 flags data
> [POWERFAILURE]
> ...
> $ journalctl -k -o short-monotonic --no-hostname | grep -i btrfs
> ...
> [ 7933.811228] kernel: BTRFS: device label first devid 1 transid 28265 /d=
ev/mapper/first (253:0) scanned by mount (1231)
> [ 7933.813593] kernel: BTRFS info (device dm-0): first mount of filesyste=
m fddd56d3-8eb0-4841-af2d-4f722fdffeaf
> [ 7933.813753] kernel: BTRFS info (device dm-0): using xxhash64 (xxhash64=
-generic) checksum algorithm
> [ 7933.813824] kernel: BTRFS info (device dm-0): using free-space-tree
> [ 7942.065893] kernel: BTRFS info (device dm-0): checking UUID tree
> [ 7943.116362] kernel: BTRFS info (device dm-0): balance: resume -dusage=
=3D90,vrange=3D100962140160..1325128482817
> [ 7943.132048] kernel: BTRFS info (device dm-0): balance: ended with stat=
us: 0
>
> (993275150336-100962140160)/1024^3=3D831GiB and the vast majority of thos=
e are >90% full, a few are <50% full.  The kernel message for resume at [ 7=
943.116362] appears on its own, I didn't prompt it manually with a resume c=
ommand. So the kernel detects that resume is indicated, but then ends immed=
iately.
>
>
> Example 2 is the same file system. I paused the balance, then tried to re=
sume it but the same thing happens.
>
> $ btrfs balance start -dvrange=3D100962140160..1325128482817 /mnt/first
>
> [187020.876597] kernel: BTRFS info (device dm-0): balance: start -dvrange=
=3D100962140160..1325128482817
> [187020.944695] kernel: BTRFS info (device dm-0): relocating block group =
1325128482816 flags data
> [187047.993704] kernel: BTRFS info (device dm-0): found 576 extents, stag=
e: move data extents
> [187050.773509] kernel: BTRFS info (device dm-0): found 576 extents, stag=
e: update data pointers
> [187052.242351] kernel: BTRFS info (device dm-0): relocating block group =
1324054740992 flags data
> [187099.305246] kernel: BTRFS info (device dm-0): found 53171 extents, st=
age: move data extents
> [187130.645529] kernel: BTRFS info (device dm-0): found 53171 extents, st=
age: update data pointers
> [187136.587658] kernel: BTRFS info (device dm-0): relocating block group =
1322980999168 flags data
> [187178.681986] kernel: BTRFS info (device dm-0): found 25 extents, stage=
: move data extents
> [187181.168150] kernel: BTRFS info (device dm-0): found 25 extents, stage=
: update data pointers
> [187182.283792] kernel: BTRFS info (device dm-0): relocating block group =
1321907257344 flags data
> [187191.382548] sudo[7025]:    chris : TTY=3Dpts/5 ; PWD=3D/home/chris ; =
USER=3Droot ; COMMAND=3D/usr/sbin/btrfs balance pause /mnt/first
> [187215.318442] kernel: BTRFS info (device dm-0): found 12 extents, stage=
: move data extents
> [187217.044154] kernel: BTRFS info (device dm-0): found 12 extents, stage=
: update data pointers
> [187217.382086] kernel: BTRFS info (device dm-0): balance: paused
> [187288.869557] sudo[7055]:    chris : TTY=3Dpts/5 ; PWD=3D/home/chris ; =
USER=3Droot ; COMMAND=3D/usr/sbin/btrfs balance resume /mnt/first
> [187285.581049] kernel: BTRFS info (device dm-0): balance: resume -dusage=
=3D90,vrange=3D100962140160..1325128482817

On resume, because no usage filter was provided in the original
balance start command,  we automatically add usage=3D90.
That's why you're not getting a lot of block groups relocated, because
they are fuller than 90%.

Setting the usage 90% on resume is done here:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/bt=
rfs/volumes.c?h=3Dv6.11.1#n3686

And it's been like that since 2012, so it doesn't seem like a
regression as you're suggesting.

The reasoning makes some sense, the goal is to avoid relocating again
block groups we previously relocated before the crash or balance
pause, in case they fall within the same vrange after relocation.

Thanks.


> [187285.596390] kernel: BTRFS info (device dm-0): balance: ended with sta=
tus: 0
> [187311.081127] sudo[7060]:    chris : TTY=3Dpts/5 ; PWD=3D/home/chris ; =
USER=3Droot ; COMMAND=3D/usr/sbin/btrfs balance resume /mnt/first
>
> The 2nd resume command results in no kernel message, but a message on CLI=
 "ERROR: balance resume on '/mnt/first' failed: Not in progress"
>
> So it really seems like resume isn't working?
>
>
>
> --
> Chris Murphy
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

