Return-Path: <linux-btrfs+bounces-4010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6FB89B247
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 15:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956B7B2257E
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Apr 2024 13:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1563838F;
	Sun,  7 Apr 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HioEF+ab"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96373770B
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Apr 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712496247; cv=none; b=a1vocIL9EB4U0FtvEZLQpxcqBHG/M5jjOFqb48nee7z/XekMtmKqTjTE8rLrx1ja91TVuQYx0bZ+q3QriAyDwniq04logCSe8zqJudsIYulhHeM8e6c0VyZMBPPXP5x/KiQih2TvIyelZFq4uglUobUYd8OBzp+mCwYydpRiui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712496247; c=relaxed/simple;
	bh=0Tlnu3s3FOJimWwfK/YlObU9Y3mlBVPTN1PwsMxQO/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XybYXqbTetKLb1+Ds8BMp+ERGDPGL90UqLJ3d29qD1zUbqdjh2bIMT3vc/OOTd5gEfM9J8lpq3F2fINkTLm1hg/AzQ7kgHu4u0xqEvmzsSOI0YUhOri3yB3jqT0gIsS63UnU/Y4YP/YHVWiolLQwzIfhcGa9ECVKqXcAonpbrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HioEF+ab; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so3764742276.1
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Apr 2024 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712496245; x=1713101045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/HoQUKMstvjSpb27TXryeawd+cl0KQR2HGgQHo7S+I=;
        b=HioEF+abc9e08zcsJ7u3SuX5LBZXYR8pUK8veybv0s3Kx6XObzfYd68JfAnExMvgpa
         n9IgLa8WRzKN22z2UWi53gIb0jtxaczULIAcNWy10LT94tglRLJoTJ7qqKlyEETlU6yN
         b0UAXZmk48ucRmYzo5QYy3TAOcFEfZpEB6qr4dmd75h6x4hfsw4xa9fbRFy50xlwY+27
         kGcifck087apF0QMnKYTWQ5beOw94dg2i6oNdm+f5wpj+PBGgICXRQPA7i2/aG5xPKv1
         ix6DYmu5LOoP6S4THolbm8iQGbx0SwVUsVyz9ywB/aZGBeG8P95bPAi1VDEeNdhO2Ks6
         o4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712496245; x=1713101045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/HoQUKMstvjSpb27TXryeawd+cl0KQR2HGgQHo7S+I=;
        b=JItibK4FCntdE7P4acPuU160TgCQWByEzM7+kgrlW2HTkgnYqhMQMfDvJ1jzzg8X0V
         ksA4jn513RhwFXCJJLJq2M2mRUC30wFjvrUN/rCdnkn2/B1KVOhwCYR5t9hSCa4poHno
         pCwmijJG6o9r3tDEp4YrcCncvZJUZ9KCrNvWgawIxvY7ZY8fTdw+IJrlOZ4omJiEIHEk
         7on+zRaObgnUdZ4zV05C+9ne7ICT/q0ez7a2rKGH7cZV2sgwxAQrXQeEuMSz2H21LvQ5
         kD7mZqfC+9ooqChGwoGsleQ7+l/RMfbyMyvJ/wBdC/1RGbf+ZQz5fFs/xbJB+L8HFwF7
         OKRw==
X-Forwarded-Encrypted: i=1; AJvYcCUkbte7war+6L+DPmacF55G+1QFxt/J5hW3Y6hyJGDFzHVVOSI27WGDhz+SsHJF5Z7O5mM8Ru3GKm3Ghxc4wlkfxkMuS5YeoiOrxxI=
X-Gm-Message-State: AOJu0YyPbW7Q4/U71cmfRYLfgrx0aLZRBvPToRFfMXHngL+mN43uIG6q
	x6wfw49VbT47T0Rd5aNtHulBKnepNaDfMLeOlnLFob9UFz6FHQg3Fw2jiMRj90JYYBkMX2z4GQb
	zLp6vCafKk1kwtDCouRD8yRaMHWxefSja
X-Google-Smtp-Source: AGHT+IE7W54YNbHl8dzQpo94FEBUIazHoOIXu77Ju/DorNdyvM00KPAxYo4GNB6Q47zRmT/v9yr/I+bkGMw/UT1ctgk=
X-Received: by 2002:a05:6902:1007:b0:dc2:40d8:ac5e with SMTP id
 w7-20020a056902100700b00dc240d8ac5emr5640388ybt.1.1712496244597; Sun, 07 Apr
 2024 06:24:04 -0700 (PDT)
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
In-Reply-To: <CAMFk-+g5ztbJDPw4bDo5Bo3Z8mPstZpXSB9n_UwP+sGbSGwDAQ@mail.gmail.com>
From: Michel Palleau <michel.palleau@gmail.com>
Date: Sun, 7 Apr 2024 15:23:53 +0200
Message-ID: <CAMFk-+hBFke3_AngYmk6+hE=bF3xuR4wF+PJv+zA=3MtCN6V_g@mail.gmail.com>
Subject: Re: scrub: last_physical not always updated when scrub is cancelled
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Qu,

Do you know in which kernel release the fix is or will be integrated ?
Thank you.

Best Regards,
Michel

Le dim. 10 mars 2024 =C3=A0 20:43, Michel Palleau
<michel.palleau@gmail.com> a =C3=A9crit :
>
> That's perfectly fine for me.
> I was just testing corner cases and reporting my findings.
> Indeed, cancelling or even getting the progress right after scrub
> starting is not a use case.
>
> Thank you for the fast support.
> Michel
>
>
> Le sam. 9 mars 2024 =C3=A0 21:31, Qu Wenruo <quwenruo.btrfs@gmx.com> a =
=C3=A9crit :
> >
> >
> >
> > =E5=9C=A8 2024/3/10 05:56, Michel Palleau =E5=86=99=E9=81=93:
> > > Hello Qu,
> > >
> > > I have tested your patches today, with
> > > - btrfs scrub status | fgrep last_phys in one console, every second
> > > - btrfs scrub start/resume in another
> > >
> > > last_phys is now increasing steadily (while before it was remaining
> > > constant for several minutes).
> > >
> > > But there is still a small window after resuming a scrub where the
> > > value reported by scrub status is not consistent.
> > > Here is the output of btrfs scrub status | fgrep last_phys every seco=
nd:
> > >         last_physical: 0
> > >         last_physical: 80805888
> > >         last_physical: 1986068480
> > > ...
> > >         last_physical: 50135564288
> > >         last_physical: 52316602368
> > >         last_physical: 52769587200
> > > ... (scrub has been cancelled)
> > >         last_physical: 52769587200
> > >         last_physical: 52719255552  <-- reported value is smaller tha=
n before
> >
> > IIRC restarted scrub doesn't fully follow the start/end parameter passe=
d
> > in, mostly due to our current scrub code is fully chunk based.
> >
> > This means, even if we updated our last_physical correctly on a
> > per-stripe basis, after resuming a canceled one, we would still restart
> > at the last chunk, not the last extent.
> >
> > To change this behavior, it would require some extra work.
> >
> > >         last_physical: 54866739200
> > >         last_physical: 57014222848
> > > ...
> > >         last_physical: 74621911040
> > >         last_physical: 76844892160
> > >         last_physical: 77566312448
> > > ... (scrub has been cancelled)
> > >         last_physical: 77566312448
> > >         last_physical: 0            <-- reported value is 0, scrub
> > > process has not updated last_phys field yet
> > >         last_physical: 79562801152
> > >         last_physical: 81819336704
> > >
> > > I think a smaller last_physical indicates that the resume operation
> > > has not started exactly from last_physical, but somewhere before.
> > > It can be a little surprising, but not a big deal.
> >
> > Yes, the resume would only start at the beginning of the last chunk.
> >
> > > last_physical: 0 indicates that scrub has not yet written last_phys.
> > >
> > > Then I chained scrub resume and scrub cancel. I saw once that
> > > last_physical was getting smaller than before.
> > > But I never saw a reset of last_physical. It looks like last_phys is
> > > always written before exiting the scrub operation.
> > >
> > > To fix progress reporting a last_physical at 0, I propose the followi=
ng change:
> > > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > > index 9a39f33dc..a43dcfd6a 100644
> > > --- a/fs/btrfs/scrub.c
> > > +++ b/fs/btrfs/scrub.c
> > > @@ -2910,6 +2910,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info
> > > *fs_info, u64 devid, u64 start,
> > >     sctx =3D scrub_setup_ctx(fs_info, is_dev_replace);
> > >     if (IS_ERR(sctx))
> > >         return PTR_ERR(sctx);
> > > +    sctx->stat.last_physical =3D start;
> > >
> > >     ret =3D scrub_workers_get(fs_info);
> > >     if (ret)
> >
> > The snippet looks mostly fine, but as I explained above, the scrub
> > progress always restarts at the last chunk, thus even if we reset the
> > last_physical here, it would soon be reset to a bytenr smaller than
> > @start, and can be a little confusing.
> >
> > Although I don't really have any better idea on the value to set.
> >
> > Maybe @last_physical set to 0 for a small window won't be that bad?
> > (Indicating scrub has not yet scrubbed any content?)
> >
> > Thanks,
> > Qu
> > >
> > > Best Regards,
> > > Michel
> > >
> > > Cordialement,
> > > Michel Palleau
> > >
> > >
> > > Le ven. 8 mars 2024 =C3=A0 10:45, Graham Cobb <g.btrfs@cobb.uk.net> a=
 =C3=A9crit :
> > >>
> > >> By the way, I have noticed this problem for some time, but haven't g=
ot
> > >> around to analysing it, sorry. I had actually assumed it was a race
> > >> condition in the user mode processing of cancelling/resuming scrubs.
> > >>
> > >> In my case, I do regular scrubs of several disks. However, this is v=
ery
> > >> intrusive to the overall system performance and so I have scripts wh=
ich
> > >> suspend critical processing which causes problems if it times out (s=
uch
> > >> as inbound mail handling) during the scrub. I suspend these processe=
s,
> > >> run the scrub for a short while, then cancel the scrub and run the m=
ail
> > >> for a while, then back to suspending the mail and resuming the scrub=
.
> > >> Typically it means scrubs on the main system and backup disks take
> > >> several days and get cancelled and resumed *many* times.
> > >>
> > >> This has worked for many years - until recently-ish (some months ago=
),
> > >> when I noticed that scrub was losing track of where it had got to. I=
t
> > >> was jumping backwards, or even, in some cases, setting last_physical
> > >> back to 0 and starting all over again!!
> > >>
> > >> I haven't had time to track it down - I just hacked the scripts to
> > >> terminate if it happened. Better to have the scrub not complete than=
 to
> > >> hobble performance forever!
> > >>
> > >> If anyone wants to try the scripts they are in
> > >> https://github.com/GrahamCobb/btrfs-balance-slowly (see
> > >> btrfs-scrub-slowly). A typical invocation looks like:
> > >>
> > >> /usr/local/sbin/btrfs-scrub-slowly --debug --portion-time $((10*60))
> > >> --interval $((5*60)) --hook hook-nomail /mnt/data/
> > >>
> > >> As this script seem to be able to reproduce the problem fairly relia=
bly
> > >> (although after several hours - the filesystems I use this for range
> > >> from 7TB to 17TB and each take 2-3 days to fully scrub with this scr=
ipt)
> > >> they may be useful to someone else. Unfortunately I do not expect to=
 be
> > >> able to build a kernel to test the proposed fix myself in the next
> > >> couple of weeks.
> > >>
> > >> Graham
> > >>
> > >>
> > >> On 08/03/2024 00:26, Qu Wenruo wrote:
> > >>>
> > >>>
> > >>> =E5=9C=A8 2024/3/8 07:07, Michel Palleau =E5=86=99=E9=81=93:
> > >>>> Hello everyone,
> > >>>>
> > >>>> While playing with the scrub operation, using cancel and resume (w=
ith
> > >>>> btrfs-progs), I saw that my scrub operation was taking much more t=
ime
> > >>>> than expected.
> > >>>> Analyzing deeper, I think I found an issue on the kernel side, in =
the
> > >>>> update of last_physical field.
> > >>>>
> > >>>> I am running a 6.7.5 kernel (ArchLinux: 6.7.5-arch1-1), with a bas=
ic
> > >>>> btrfs (single device, 640 GiB used out of 922 GiB, SSD).
> > >>>>
> > >>>> Error scenario:
> > >>>> - I start a scrub, monitor it with scrub status and when I see no
> > >>>> progress in the last_physical field (likely because it is scrubbin=
g a
> > >>>> big chunk), I cancel the scrub,
> > >>>> - then I resume the scrub operation: if I do a scrub status,
> > >>>> last_physical is 0. If I do a scrub cancel, last_physical is still=
 0.
> > >>>> The state file saves 0, and so next resume will start from the ver=
y
> > >>>> beginning. Progress has been lost!
> > >>>>
> > >>>> Note that for my fs, if I do not cancel it, I can see the
> > >>>> last_physical field remaining constant for more than 3 minutes, wh=
ile
> > >>>> the data_bytes_scrubbed is increasing fastly. The complete scrub n=
eeds
> > >>>> less than 10 min.
> > >>>>
> > >>>> I have put at the bottom the outputs of the start/resume commands =
as
> > >>>> well as the scrub.status file after each operation.
> > >>>>
> > >>>> Looking at kernel code, last_physical seems to be rarely updated. =
And
> > >>>> in case of scrub cancel, the current position is not written into
> > >>>> last_physical, so the value remains the last written value. Which =
can
> > >>>> be 0 if it has not been written since the scrub has been resumed.
> > >>>>
> > >>>> I see 2 problems here:
> > >>>> 1. when resuming a scrub, the returned last_physical shall be at l=
east
> > >>>> equal to the start position, so that the scrub operation is not do=
ing
> > >>>> a step backward,
> > >>>> 2. on cancel, the returned last_physical shall be as near as possi=
ble
> > >>>> to the current scrub position, so that the resume operation is not
> > >>>> redoing the same operations again. Several minutes without an upda=
te
> > >>>> is a waste.
> > >>>>
> > >>>> Pb 1 is pretty easy to fix: in btrfs_scrub_dev(), fill the
> > >>>> last_physical field with the start parameter after initialization =
of
> > >>>> the context.
> > >>>
> > >>> Indeed, we're only updating last_physical way too infrequently.
> > >>>
> > >>>> Pb 2 looks more difficult: updating last_physical more often impli=
es
> > >>>> the capability to resume from this position.
> > >>>
> > >>> The truth is, every time we finished a stripe, we should update
> > >>> last_physical, so that in resume case, we would waste at most a str=
ipe
> > >>> (64K), which should be minimal compared to the size of the fs.
> > >>>
> > >>> This is not hard to do inside flush_scrub_stripes() for non-RAID56
> > >>> profiles.
> > >>>
> > >>> It may needs a slightly more handling for RAID56, but overall I bel=
ieve
> > >>> it can be done.
> > >>>
> > >>> Let me craft a patch for you to test soon.
> > >>>
> > >>> Thanks,
> > >>> Qu
> > >>>
> > >>>
> > >>>>
> > >>>> Here are output of the different steps:
> > >>>>
> > >>>> # btrfs scrub start -BR /mnt/clonux_btrfs
> > >>>> Starting scrub on devid 1
> > >>>> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
> > >>>> Scrub started:    Thu Mar  7 17:11:17 2024
> > >>>> Status:           aborted
> > >>>> Duration:         0:00:22
> > >>>>           data_extents_scrubbed: 1392059
> > >>>>           tree_extents_scrubbed: 57626
> > >>>>           data_bytes_scrubbed: 44623339520
> > >>>>           tree_bytes_scrubbed: 944144384
> > >>>>           read_errors: 0
> > >>>>           csum_errors: 0
> > >>>>           verify_errors: 0
> > >>>>           no_csum: 1853
> > >>>>           csum_discards: 0
> > >>>>           super_errors: 0
> > >>>>           malloc_errors: 0
> > >>>>           uncorrectable_errors: 0
> > >>>>           unverified_errors: 0
> > >>>>           corrected_errors: 0
> > >>>>           last_physical: 36529242112
> > >>>>
> > >>>> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
> > >>>> scrub status:1
> > >>>> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:13920=
59|tree_extents_scrubbed:57626|data_bytes_scrubbed:44623339520|tree_bytes_s=
crubbed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:1853|=
csum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corre=
cted_errors:0|last_physical:36529242112|t_start:1709827877|t_resumed:0|dura=
tion:22|canceled:1|finished:1
> > >>>>
> > >>>> # btrfs scrub resume -BR /mnt/clonux_btrfs
> > >>>> Starting scrub on devid 1
> > >>>> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
> > >>>> Scrub started:    Thu Mar  7 17:13:07 2024
> > >>>> Status:           aborted
> > >>>> Duration:         0:00:07
> > >>>>           data_extents_scrubbed: 250206
> > >>>>           tree_extents_scrubbed: 0
> > >>>>           data_bytes_scrubbed: 14311002112
> > >>>>           tree_bytes_scrubbed: 0
> > >>>>           read_errors: 0
> > >>>>           csum_errors: 0
> > >>>>           verify_errors: 0
> > >>>>           no_csum: 591
> > >>>>           csum_discards: 0
> > >>>>           super_errors: 0
> > >>>>           malloc_errors: 0
> > >>>>           uncorrectable_errors: 0
> > >>>>           unverified_errors: 0
> > >>>>           corrected_errors: 0
> > >>>>           last_physical: 0
> > >>>>
> > >>>> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
> > >>>> scrub status:1
> > >>>> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:16422=
65|tree_extents_scrubbed:57626|data_bytes_scrubbed:58934341632|tree_bytes_s=
crubbed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:2444|=
csum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corre=
cted_errors:0|last_physical:0|t_start:1709827877|t_resumed:1709827987|durat=
ion:29|canceled:1|finished:1
> > >>>>
> > >>>> Best Regards,
> > >>>> Michel Palleau
> > >>>>
> > >>>
> > >>

