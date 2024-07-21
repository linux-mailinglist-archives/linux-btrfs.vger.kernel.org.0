Return-Path: <linux-btrfs+bounces-6631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E59384AE
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Jul 2024 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A485C281418
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Jul 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0616132F;
	Sun, 21 Jul 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxo6Tw0m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AB8F58
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Jul 2024 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721567906; cv=none; b=nCpmjra5N3e9r7Cno+MXPMz67K2ussbDw4ufZDp0tW8GVKUJQJtgI+iv+Z/DLT2Je/F97R8IVz2aUyEMONfGfx+hPGh5ASxwPbNam7kw1BvSozoih9WAKjJWAOQNOFJ3IZORa09PKYzRqr9Purrvi0Mqxx6+FKPiOef1lAylOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721567906; c=relaxed/simple;
	bh=O244JCLkQr2027E94v4EOX/33cwjdXZxwJWi+SZiwfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Apnx0T9B9p1j4RF15ythKsjQGYMUPWEn9AFtRqsEtiDAn7CwJJy8kRAo7Fhe40TwPtuySMk8Qmba+DKGI0xADT28d13UfmzYXLjhSoFylKEp8bS+ji8cQ+yl9cHFrie2dyH/57jxxTp8NNs+TIEpiMcZCvos+8J6AbPDcHGq+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xxo6Tw0m; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66ca536621cso866857b3.3
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Jul 2024 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721567903; x=1722172703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ea2d3jH1EFv8j3RrSTBtdF3Kfqc4vmiNJGy+Bxw5h8=;
        b=Xxo6Tw0m99QlEu/NKHPcTFJZrcbK8TG9CWz25ZYGO6DUW4sm/uXUcwiPE5nIToKC6c
         2JIUxfmk26ZKQKg25R4q4QfsvgXRpc8p+l6Bg6/G1wKaoxS4O50fiMv+kkHiBuEKRmIj
         b5zCmd/6m5TAhOa1BMiWnXxWBkRlrTi288vXFzijkpkWMo6hTwyKDixy6yWtvWk/iP50
         y3lgQYnn9IY1CCnjxBqNFLo0UwKfKmgbTiIR1QAADU3ZhxgqJ952XNb59q1Rx4CPaQ1n
         g4qkARg0PPESW0DXNpGW6bcZwDFhrYNfIVFdl6dwWJxrywT0z16TVKkolFxzZUFqTCPl
         Kseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721567903; x=1722172703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ea2d3jH1EFv8j3RrSTBtdF3Kfqc4vmiNJGy+Bxw5h8=;
        b=mKSy4PqGKfh6ILXh63pxFYd19DhZW9NzFZwqxTVYpIpqXc7ZtKsT46GfxjMqBsn7wa
         5qgVK8a038ERxFZ5Gf4fP3imxz21BdOSAff/et4+wRGURIbYDgo/w1U96mjKq6/ZLD6C
         VwW6nVTrLxwpAfey8ZYjRP9HNOiAV0vZzUxgtQyLj8+Brdc1fE5qfBEQDgbuHIUwZAw0
         7sFu4xvTY6JFEA67b2tAWY0ueU2qfVUqv9NLJxjWzbK1vkzYcNPejzhA9ZperY9e64zL
         xGcDfptGFPyUUKE/fCV1O7phB9GCWK3ZzTw1RFeW84DWpHRJPHVCXR1Rq/gYXtHacJAB
         SGJg==
X-Forwarded-Encrypted: i=1; AJvYcCU45Wiw1Z2GrOi57Y+dv/aSjr53k94ZVXOpyUjLZKEbsUwaTY66uW9tmHo5B6hWJqiYTtBLCZdeIlCKMG+N9yDwrj7ARMYff3/62DY=
X-Gm-Message-State: AOJu0YwBS11yTtSepEfzsDNFfdXnqr5nbmFLx+tk+uQdvV61XvFu8Thu
	+0GxUrLLoYwKHaP6RyhxQhg3S7/aixOYSIPA/Wdx0ZYijWacwKqwZm+XaJXfKnmB+WYODnFLoyD
	D5AnDZmddHZKo0Rfyco3plmNkeJoEDg==
X-Google-Smtp-Source: AGHT+IE25ibiC3NclevzeY52u4G8L6mK+0eLHQf1KESncJg+TUX2Qsj0JpGE6x1+tY7rVsmzFnIAkSU6Ywdg2QVT6PQ=
X-Received: by 2002:a05:690c:4047:b0:627:de5d:cf36 with SMTP id
 00721157ae682-66a6a80bae7mr42493787b3.39.1721567903259; Sun, 21 Jul 2024
 06:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com>
 <ba3a8690-1604-429e-9e8a-7c381e6592f8@gmx.com> <fcfab114-c1a0-4059-990d-e4724b457437@cobb.uk.net>
 <CAMFk-+ifZiN4PhqyLAbsCZxcaJ6CU_gXUxZRMPr3eC741X=4sQ@mail.gmail.com>
 <08a65231-59c2-4606-9be9-5182b7e47087@gmx.com> <CAMFk-+g5ztbJDPw4bDo5Bo3Z8mPstZpXSB9n_UwP+sGbSGwDAQ@mail.gmail.com>
 <CAMFk-+hBFke3_AngYmk6+hE=bF3xuR4wF+PJv+zA=3MtCN6V_g@mail.gmail.com>
In-Reply-To: <CAMFk-+hBFke3_AngYmk6+hE=bF3xuR4wF+PJv+zA=3MtCN6V_g@mail.gmail.com>
From: Michel Palleau <michel.palleau@gmail.com>
Date: Sun, 21 Jul 2024 15:18:12 +0200
Message-ID: <CAMFk-+g-nF+SK52qboQQgoOtLibMqjLChrs8UQLN+Gq9T0UDig@mail.gmail.com>
Subject: Re: scrub: last_physical not always updated when scrub is cancelled
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Qu,

I am not able to see the patches you have proposed in the kernel repository=
.
Has the fix been forgotten ? Or integrated with a different implementation =
?

Best Regards,
Michel Palleau

Le dim. 7 avr. 2024 =C3=A0 15:23, Michel Palleau <michel.palleau@gmail.com>=
 a =C3=A9crit :
>
> Hello Qu,
>
> Do you know in which kernel release the fix is or will be integrated ?
> Thank you.
>
> Best Regards,
> Michel
>
> Le dim. 10 mars 2024 =C3=A0 20:43, Michel Palleau
> <michel.palleau@gmail.com> a =C3=A9crit :
> >
> > That's perfectly fine for me.
> > I was just testing corner cases and reporting my findings.
> > Indeed, cancelling or even getting the progress right after scrub
> > starting is not a use case.
> >
> > Thank you for the fast support.
> > Michel
> >
> >
> > Le sam. 9 mars 2024 =C3=A0 21:31, Qu Wenruo <quwenruo.btrfs@gmx.com> a =
=C3=A9crit :
> > >
> > >
> > >
> > > =E5=9C=A8 2024/3/10 05:56, Michel Palleau =E5=86=99=E9=81=93:
> > > > Hello Qu,
> > > >
> > > > I have tested your patches today, with
> > > > - btrfs scrub status | fgrep last_phys in one console, every second
> > > > - btrfs scrub start/resume in another
> > > >
> > > > last_phys is now increasing steadily (while before it was remaining
> > > > constant for several minutes).
> > > >
> > > > But there is still a small window after resuming a scrub where the
> > > > value reported by scrub status is not consistent.
> > > > Here is the output of btrfs scrub status | fgrep last_phys every se=
cond:
> > > >         last_physical: 0
> > > >         last_physical: 80805888
> > > >         last_physical: 1986068480
> > > > ...
> > > >         last_physical: 50135564288
> > > >         last_physical: 52316602368
> > > >         last_physical: 52769587200
> > > > ... (scrub has been cancelled)
> > > >         last_physical: 52769587200
> > > >         last_physical: 52719255552  <-- reported value is smaller t=
han before
> > >
> > > IIRC restarted scrub doesn't fully follow the start/end parameter pas=
sed
> > > in, mostly due to our current scrub code is fully chunk based.
> > >
> > > This means, even if we updated our last_physical correctly on a
> > > per-stripe basis, after resuming a canceled one, we would still resta=
rt
> > > at the last chunk, not the last extent.
> > >
> > > To change this behavior, it would require some extra work.
> > >
> > > >         last_physical: 54866739200
> > > >         last_physical: 57014222848
> > > > ...
> > > >         last_physical: 74621911040
> > > >         last_physical: 76844892160
> > > >         last_physical: 77566312448
> > > > ... (scrub has been cancelled)
> > > >         last_physical: 77566312448
> > > >         last_physical: 0            <-- reported value is 0, scrub
> > > > process has not updated last_phys field yet
> > > >         last_physical: 79562801152
> > > >         last_physical: 81819336704
> > > >
> > > > I think a smaller last_physical indicates that the resume operation
> > > > has not started exactly from last_physical, but somewhere before.
> > > > It can be a little surprising, but not a big deal.
> > >
> > > Yes, the resume would only start at the beginning of the last chunk.
> > >
> > > > last_physical: 0 indicates that scrub has not yet written last_phys=
.
> > > >
> > > > Then I chained scrub resume and scrub cancel. I saw once that
> > > > last_physical was getting smaller than before.
> > > > But I never saw a reset of last_physical. It looks like last_phys i=
s
> > > > always written before exiting the scrub operation.
> > > >
> > > > To fix progress reporting a last_physical at 0, I propose the follo=
wing change:
> > > > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > > > index 9a39f33dc..a43dcfd6a 100644
> > > > --- a/fs/btrfs/scrub.c
> > > > +++ b/fs/btrfs/scrub.c
> > > > @@ -2910,6 +2910,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info
> > > > *fs_info, u64 devid, u64 start,
> > > >     sctx =3D scrub_setup_ctx(fs_info, is_dev_replace);
> > > >     if (IS_ERR(sctx))
> > > >         return PTR_ERR(sctx);
> > > > +    sctx->stat.last_physical =3D start;
> > > >
> > > >     ret =3D scrub_workers_get(fs_info);
> > > >     if (ret)
> > >
> > > The snippet looks mostly fine, but as I explained above, the scrub
> > > progress always restarts at the last chunk, thus even if we reset the
> > > last_physical here, it would soon be reset to a bytenr smaller than
> > > @start, and can be a little confusing.
> > >
> > > Although I don't really have any better idea on the value to set.
> > >
> > > Maybe @last_physical set to 0 for a small window won't be that bad?
> > > (Indicating scrub has not yet scrubbed any content?)
> > >
> > > Thanks,
> > > Qu
> > > >
> > > > Best Regards,
> > > > Michel
> > > >
> > > > Cordialement,
> > > > Michel Palleau
> > > >
> > > >
> > > > Le ven. 8 mars 2024 =C3=A0 10:45, Graham Cobb <g.btrfs@cobb.uk.net>=
 a =C3=A9crit :
> > > >>
> > > >> By the way, I have noticed this problem for some time, but haven't=
 got
> > > >> around to analysing it, sorry. I had actually assumed it was a rac=
e
> > > >> condition in the user mode processing of cancelling/resuming scrub=
s.
> > > >>
> > > >> In my case, I do regular scrubs of several disks. However, this is=
 very
> > > >> intrusive to the overall system performance and so I have scripts =
which
> > > >> suspend critical processing which causes problems if it times out =
(such
> > > >> as inbound mail handling) during the scrub. I suspend these proces=
ses,
> > > >> run the scrub for a short while, then cancel the scrub and run the=
 mail
> > > >> for a while, then back to suspending the mail and resuming the scr=
ub.
> > > >> Typically it means scrubs on the main system and backup disks take
> > > >> several days and get cancelled and resumed *many* times.
> > > >>
> > > >> This has worked for many years - until recently-ish (some months a=
go),
> > > >> when I noticed that scrub was losing track of where it had got to.=
 It
> > > >> was jumping backwards, or even, in some cases, setting last_physic=
al
> > > >> back to 0 and starting all over again!!
> > > >>
> > > >> I haven't had time to track it down - I just hacked the scripts to
> > > >> terminate if it happened. Better to have the scrub not complete th=
an to
> > > >> hobble performance forever!
> > > >>
> > > >> If anyone wants to try the scripts they are in
> > > >> https://github.com/GrahamCobb/btrfs-balance-slowly (see
> > > >> btrfs-scrub-slowly). A typical invocation looks like:
> > > >>
> > > >> /usr/local/sbin/btrfs-scrub-slowly --debug --portion-time $((10*60=
))
> > > >> --interval $((5*60)) --hook hook-nomail /mnt/data/
> > > >>
> > > >> As this script seem to be able to reproduce the problem fairly rel=
iably
> > > >> (although after several hours - the filesystems I use this for ran=
ge
> > > >> from 7TB to 17TB and each take 2-3 days to fully scrub with this s=
cript)
> > > >> they may be useful to someone else. Unfortunately I do not expect =
to be
> > > >> able to build a kernel to test the proposed fix myself in the next
> > > >> couple of weeks.
> > > >>
> > > >> Graham
> > > >>
> > > >>
> > > >> On 08/03/2024 00:26, Qu Wenruo wrote:
> > > >>>
> > > >>>
> > > >>> =E5=9C=A8 2024/3/8 07:07, Michel Palleau =E5=86=99=E9=81=93:
> > > >>>> Hello everyone,
> > > >>>>
> > > >>>> While playing with the scrub operation, using cancel and resume =
(with
> > > >>>> btrfs-progs), I saw that my scrub operation was taking much more=
 time
> > > >>>> than expected.
> > > >>>> Analyzing deeper, I think I found an issue on the kernel side, i=
n the
> > > >>>> update of last_physical field.
> > > >>>>
> > > >>>> I am running a 6.7.5 kernel (ArchLinux: 6.7.5-arch1-1), with a b=
asic
> > > >>>> btrfs (single device, 640 GiB used out of 922 GiB, SSD).
> > > >>>>
> > > >>>> Error scenario:
> > > >>>> - I start a scrub, monitor it with scrub status and when I see n=
o
> > > >>>> progress in the last_physical field (likely because it is scrubb=
ing a
> > > >>>> big chunk), I cancel the scrub,
> > > >>>> - then I resume the scrub operation: if I do a scrub status,
> > > >>>> last_physical is 0. If I do a scrub cancel, last_physical is sti=
ll 0.
> > > >>>> The state file saves 0, and so next resume will start from the v=
ery
> > > >>>> beginning. Progress has been lost!
> > > >>>>
> > > >>>> Note that for my fs, if I do not cancel it, I can see the
> > > >>>> last_physical field remaining constant for more than 3 minutes, =
while
> > > >>>> the data_bytes_scrubbed is increasing fastly. The complete scrub=
 needs
> > > >>>> less than 10 min.
> > > >>>>
> > > >>>> I have put at the bottom the outputs of the start/resume command=
s as
> > > >>>> well as the scrub.status file after each operation.
> > > >>>>
> > > >>>> Looking at kernel code, last_physical seems to be rarely updated=
. And
> > > >>>> in case of scrub cancel, the current position is not written int=
o
> > > >>>> last_physical, so the value remains the last written value. Whic=
h can
> > > >>>> be 0 if it has not been written since the scrub has been resumed=
.
> > > >>>>
> > > >>>> I see 2 problems here:
> > > >>>> 1. when resuming a scrub, the returned last_physical shall be at=
 least
> > > >>>> equal to the start position, so that the scrub operation is not =
doing
> > > >>>> a step backward,
> > > >>>> 2. on cancel, the returned last_physical shall be as near as pos=
sible
> > > >>>> to the current scrub position, so that the resume operation is n=
ot
> > > >>>> redoing the same operations again. Several minutes without an up=
date
> > > >>>> is a waste.
> > > >>>>
> > > >>>> Pb 1 is pretty easy to fix: in btrfs_scrub_dev(), fill the
> > > >>>> last_physical field with the start parameter after initializatio=
n of
> > > >>>> the context.
> > > >>>
> > > >>> Indeed, we're only updating last_physical way too infrequently.
> > > >>>
> > > >>>> Pb 2 looks more difficult: updating last_physical more often imp=
lies
> > > >>>> the capability to resume from this position.
> > > >>>
> > > >>> The truth is, every time we finished a stripe, we should update
> > > >>> last_physical, so that in resume case, we would waste at most a s=
tripe
> > > >>> (64K), which should be minimal compared to the size of the fs.
> > > >>>
> > > >>> This is not hard to do inside flush_scrub_stripes() for non-RAID5=
6
> > > >>> profiles.
> > > >>>
> > > >>> It may needs a slightly more handling for RAID56, but overall I b=
elieve
> > > >>> it can be done.
> > > >>>
> > > >>> Let me craft a patch for you to test soon.
> > > >>>
> > > >>> Thanks,
> > > >>> Qu
> > > >>>
> > > >>>
> > > >>>>
> > > >>>> Here are output of the different steps:
> > > >>>>
> > > >>>> # btrfs scrub start -BR /mnt/clonux_btrfs
> > > >>>> Starting scrub on devid 1
> > > >>>> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
> > > >>>> Scrub started:    Thu Mar  7 17:11:17 2024
> > > >>>> Status:           aborted
> > > >>>> Duration:         0:00:22
> > > >>>>           data_extents_scrubbed: 1392059
> > > >>>>           tree_extents_scrubbed: 57626
> > > >>>>           data_bytes_scrubbed: 44623339520
> > > >>>>           tree_bytes_scrubbed: 944144384
> > > >>>>           read_errors: 0
> > > >>>>           csum_errors: 0
> > > >>>>           verify_errors: 0
> > > >>>>           no_csum: 1853
> > > >>>>           csum_discards: 0
> > > >>>>           super_errors: 0
> > > >>>>           malloc_errors: 0
> > > >>>>           uncorrectable_errors: 0
> > > >>>>           unverified_errors: 0
> > > >>>>           corrected_errors: 0
> > > >>>>           last_physical: 36529242112
> > > >>>>
> > > >>>> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
> > > >>>> scrub status:1
> > > >>>> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:139=
2059|tree_extents_scrubbed:57626|data_bytes_scrubbed:44623339520|tree_bytes=
_scrubbed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:185=
3|csum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|cor=
rected_errors:0|last_physical:36529242112|t_start:1709827877|t_resumed:0|du=
ration:22|canceled:1|finished:1
> > > >>>>
> > > >>>> # btrfs scrub resume -BR /mnt/clonux_btrfs
> > > >>>> Starting scrub on devid 1
> > > >>>> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
> > > >>>> Scrub started:    Thu Mar  7 17:13:07 2024
> > > >>>> Status:           aborted
> > > >>>> Duration:         0:00:07
> > > >>>>           data_extents_scrubbed: 250206
> > > >>>>           tree_extents_scrubbed: 0
> > > >>>>           data_bytes_scrubbed: 14311002112
> > > >>>>           tree_bytes_scrubbed: 0
> > > >>>>           read_errors: 0
> > > >>>>           csum_errors: 0
> > > >>>>           verify_errors: 0
> > > >>>>           no_csum: 591
> > > >>>>           csum_discards: 0
> > > >>>>           super_errors: 0
> > > >>>>           malloc_errors: 0
> > > >>>>           uncorrectable_errors: 0
> > > >>>>           unverified_errors: 0
> > > >>>>           corrected_errors: 0
> > > >>>>           last_physical: 0
> > > >>>>
> > > >>>> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
> > > >>>> scrub status:1
> > > >>>> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:164=
2265|tree_extents_scrubbed:57626|data_bytes_scrubbed:58934341632|tree_bytes=
_scrubbed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:244=
4|csum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|cor=
rected_errors:0|last_physical:0|t_start:1709827877|t_resumed:1709827987|dur=
ation:29|canceled:1|finished:1
> > > >>>>
> > > >>>> Best Regards,
> > > >>>> Michel Palleau
> > > >>>>
> > > >>>
> > > >>

