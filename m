Return-Path: <linux-btrfs+bounces-3151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A687739E
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 20:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A765B2148F
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A84D9EC;
	Sat,  9 Mar 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6qctjnG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19722F07
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Mar 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710012402; cv=none; b=CP6Maj3EMquNShRbtjq25jXNY539QO2pqxG1MFtsuQjj2CTwp66Db1NZGbM61odB1t+UPtTUIVCI5u3IWVINzb7sBiTERUStAuPe2inno9EyQ0fzo53xabR31v89Rg6UsxxDa+af7PVbSaFGZ8PA8dl1fBfCAI22oJXBNkgot50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710012402; c=relaxed/simple;
	bh=hcXv21gJNVsd7m8cUHMB9/m9zCtUvU+ldr/rH/pjcbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJwoExurd1hrM4VzdQAGnHa9kK8TzFZ6Rq/29Ycw6hpW4SRz+LLi/TMR/Bdwl5K8IFULJKfe9mszvDs0uH3IN/yWuLRAbkOW5/LrQaBXCTFNQcxSDA4DgTa2EhcBTzjUSHS0/KGe4KS9afOpI1VzNetNKnyATt8ucPgalWksJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6qctjnG; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c213690558so855339b6e.0
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710012400; x=1710617200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvifnJziGpoEyozI7vO7NomDbqRQqTVaueP2+wvwZf8=;
        b=C6qctjnG1pLi1eYaW0JV3cborG8LHov/tTffKbG4uPomQlH5870WLLexULR9qFj5yj
         sWMY+vJLHpp0GKSPjIrplMs+tytYSXnohaL47skquomI3Vpjjvz6gyi93meMjWiwDEZ2
         in6xrNilck1FqT/g+7zjNvWS3prrJmXRIPqhEgjvBiXXWSemMJjH2H/V1a0mKYsgs60q
         TpmucWX3RD1XjKWlmFUMxEVxYe9SIVVHOqpeFAivsyveltkKisowiRWnpdIx3SSVJil3
         i6hKdU/ndW5e5X+EqJCcvrkVzZE/UL50qm7VITivKiBIoTw+0Po8ISEde5FIsmooaMGz
         iZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710012400; x=1710617200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvifnJziGpoEyozI7vO7NomDbqRQqTVaueP2+wvwZf8=;
        b=pHNn9SE/9KUCO9smZNFvs0himPrsqZdm/4UYLh4vlo2y33dEs+Ms/HiU0B5mN7um8O
         W6KXE125cdqnoTv4hY/QJiT9zHwiBR1twZTV9Wz+KiSenzWeSe487dQuIBNvAtOz9qhY
         nWSEN32kAd0geImj2NVpnTYb/+K78xUXXpAobu5QzkaWzz3MsBZK82FNlt5UwbJ33KU7
         Daiqx/CwDPzf44FZirk5/4XYuEk6Am+lyHymHwHj1oeBzdYySHCutpHnZSMZokwL3Sh4
         2fw+TctOnxpQBkAKga4An8VXAO/D+2eengPmzhGO07us8pGalS/rEVx1plWFOilx3x72
         rsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEsyN7DIa69zVDxjALDSqlcZDNpdCOJ0rhse3gGPvFOpz5VUgIE7kHdmd/hzow8p+EsPLlYR3kcTGy6pXFFWdxEHJI/TIwmiXcuSk=
X-Gm-Message-State: AOJu0YxB3N/6Cok3hqekfsO2qoNsk2lY1XLlbeoj6g0rQZHyJUyWXaGu
	AwArXofEK8FtrH53IL7KogR8x6797FfiKyzrsoJPETEEDKdFTjkfJYixvRZnR5nNMoVXWFXKkRA
	6ysVE6DU924cyykYrjr2H5bqFa0g=
X-Google-Smtp-Source: AGHT+IFWx3fNMLyUg+JBiwAMPBUA1cEa4Mxr7hF9c53P/pqmkV/WHwaJj/YuAKImSt8BnUM5Dwhd+5ZrBqokiWlfHas=
X-Received: by 2002:a05:6808:210c:b0:3c2:139b:cc36 with SMTP id
 r12-20020a056808210c00b003c2139bcc36mr2900256oiw.7.1710012400006; Sat, 09 Mar
 2024 11:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com>
 <ba3a8690-1604-429e-9e8a-7c381e6592f8@gmx.com> <fcfab114-c1a0-4059-990d-e4724b457437@cobb.uk.net>
In-Reply-To: <fcfab114-c1a0-4059-990d-e4724b457437@cobb.uk.net>
From: Michel Palleau <michel.palleau@gmail.com>
Date: Sat, 9 Mar 2024 20:26:28 +0100
Message-ID: <CAMFk-+ifZiN4PhqyLAbsCZxcaJ6CU_gXUxZRMPr3eC741X=4sQ@mail.gmail.com>
Subject: Re: scrub: last_physical not always updated when scrub is cancelled
To: Graham Cobb <g.btrfs@cobb.uk.net>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Qu,

I have tested your patches today, with
- btrfs scrub status | fgrep last_phys in one console, every second
- btrfs scrub start/resume in another

last_phys is now increasing steadily (while before it was remaining
constant for several minutes).

But there is still a small window after resuming a scrub where the
value reported by scrub status is not consistent.
Here is the output of btrfs scrub status | fgrep last_phys every second:
       last_physical: 0
       last_physical: 80805888
       last_physical: 1986068480
...
       last_physical: 50135564288
       last_physical: 52316602368
       last_physical: 52769587200
... (scrub has been cancelled)
       last_physical: 52769587200
       last_physical: 52719255552  <-- reported value is smaller than befor=
e
       last_physical: 54866739200
       last_physical: 57014222848
...
       last_physical: 74621911040
       last_physical: 76844892160
       last_physical: 77566312448
... (scrub has been cancelled)
       last_physical: 77566312448
       last_physical: 0            <-- reported value is 0, scrub
process has not updated last_phys field yet
       last_physical: 79562801152
       last_physical: 81819336704

I think a smaller last_physical indicates that the resume operation
has not started exactly from last_physical, but somewhere before.
It can be a little surprising, but not a big deal.
last_physical: 0 indicates that scrub has not yet written last_phys.

Then I chained scrub resume and scrub cancel. I saw once that
last_physical was getting smaller than before.
But I never saw a reset of last_physical. It looks like last_phys is
always written before exiting the scrub operation.

To fix progress reporting a last_physical at 0, I propose the following cha=
nge:
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9a39f33dc..a43dcfd6a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2910,6 +2910,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info
*fs_info, u64 devid, u64 start,
   sctx =3D scrub_setup_ctx(fs_info, is_dev_replace);
   if (IS_ERR(sctx))
       return PTR_ERR(sctx);
+    sctx->stat.last_physical =3D start;

   ret =3D scrub_workers_get(fs_info);
   if (ret)

Best Regards,
Michel

Cordialement,
Michel Palleau


Le ven. 8 mars 2024 =C3=A0 10:45, Graham Cobb <g.btrfs@cobb.uk.net> a =C3=
=A9crit :
>
> By the way, I have noticed this problem for some time, but haven't got
> around to analysing it, sorry. I had actually assumed it was a race
> condition in the user mode processing of cancelling/resuming scrubs.
>
> In my case, I do regular scrubs of several disks. However, this is very
> intrusive to the overall system performance and so I have scripts which
> suspend critical processing which causes problems if it times out (such
> as inbound mail handling) during the scrub. I suspend these processes,
> run the scrub for a short while, then cancel the scrub and run the mail
> for a while, then back to suspending the mail and resuming the scrub.
> Typically it means scrubs on the main system and backup disks take
> several days and get cancelled and resumed *many* times.
>
> This has worked for many years - until recently-ish (some months ago),
> when I noticed that scrub was losing track of where it had got to. It
> was jumping backwards, or even, in some cases, setting last_physical
> back to 0 and starting all over again!!
>
> I haven't had time to track it down - I just hacked the scripts to
> terminate if it happened. Better to have the scrub not complete than to
> hobble performance forever!
>
> If anyone wants to try the scripts they are in
> https://github.com/GrahamCobb/btrfs-balance-slowly (see
> btrfs-scrub-slowly). A typical invocation looks like:
>
> /usr/local/sbin/btrfs-scrub-slowly --debug --portion-time $((10*60))
> --interval $((5*60)) --hook hook-nomail /mnt/data/
>
> As this script seem to be able to reproduce the problem fairly reliably
> (although after several hours - the filesystems I use this for range
> from 7TB to 17TB and each take 2-3 days to fully scrub with this script)
> they may be useful to someone else. Unfortunately I do not expect to be
> able to build a kernel to test the proposed fix myself in the next
> couple of weeks.
>
> Graham
>
>
> On 08/03/2024 00:26, Qu Wenruo wrote:
> >
> >
> > =E5=9C=A8 2024/3/8 07:07, Michel Palleau =E5=86=99=E9=81=93:
> >> Hello everyone,
> >>
> >> While playing with the scrub operation, using cancel and resume (with
> >> btrfs-progs), I saw that my scrub operation was taking much more time
> >> than expected.
> >> Analyzing deeper, I think I found an issue on the kernel side, in the
> >> update of last_physical field.
> >>
> >> I am running a 6.7.5 kernel (ArchLinux: 6.7.5-arch1-1), with a basic
> >> btrfs (single device, 640 GiB used out of 922 GiB, SSD).
> >>
> >> Error scenario:
> >> - I start a scrub, monitor it with scrub status and when I see no
> >> progress in the last_physical field (likely because it is scrubbing a
> >> big chunk), I cancel the scrub,
> >> - then I resume the scrub operation: if I do a scrub status,
> >> last_physical is 0. If I do a scrub cancel, last_physical is still 0.
> >> The state file saves 0, and so next resume will start from the very
> >> beginning. Progress has been lost!
> >>
> >> Note that for my fs, if I do not cancel it, I can see the
> >> last_physical field remaining constant for more than 3 minutes, while
> >> the data_bytes_scrubbed is increasing fastly. The complete scrub needs
> >> less than 10 min.
> >>
> >> I have put at the bottom the outputs of the start/resume commands as
> >> well as the scrub.status file after each operation.
> >>
> >> Looking at kernel code, last_physical seems to be rarely updated. And
> >> in case of scrub cancel, the current position is not written into
> >> last_physical, so the value remains the last written value. Which can
> >> be 0 if it has not been written since the scrub has been resumed.
> >>
> >> I see 2 problems here:
> >> 1. when resuming a scrub, the returned last_physical shall be at least
> >> equal to the start position, so that the scrub operation is not doing
> >> a step backward,
> >> 2. on cancel, the returned last_physical shall be as near as possible
> >> to the current scrub position, so that the resume operation is not
> >> redoing the same operations again. Several minutes without an update
> >> is a waste.
> >>
> >> Pb 1 is pretty easy to fix: in btrfs_scrub_dev(), fill the
> >> last_physical field with the start parameter after initialization of
> >> the context.
> >
> > Indeed, we're only updating last_physical way too infrequently.
> >
> >> Pb 2 looks more difficult: updating last_physical more often implies
> >> the capability to resume from this position.
> >
> > The truth is, every time we finished a stripe, we should update
> > last_physical, so that in resume case, we would waste at most a stripe
> > (64K), which should be minimal compared to the size of the fs.
> >
> > This is not hard to do inside flush_scrub_stripes() for non-RAID56
> > profiles.
> >
> > It may needs a slightly more handling for RAID56, but overall I believe
> > it can be done.
> >
> > Let me craft a patch for you to test soon.
> >
> > Thanks,
> > Qu
> >
> >
> >>
> >> Here are output of the different steps:
> >>
> >> # btrfs scrub start -BR /mnt/clonux_btrfs
> >> Starting scrub on devid 1
> >> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
> >> Scrub started:    Thu Mar  7 17:11:17 2024
> >> Status:           aborted
> >> Duration:         0:00:22
> >>          data_extents_scrubbed: 1392059
> >>          tree_extents_scrubbed: 57626
> >>          data_bytes_scrubbed: 44623339520
> >>          tree_bytes_scrubbed: 944144384
> >>          read_errors: 0
> >>          csum_errors: 0
> >>          verify_errors: 0
> >>          no_csum: 1853
> >>          csum_discards: 0
> >>          super_errors: 0
> >>          malloc_errors: 0
> >>          uncorrectable_errors: 0
> >>          unverified_errors: 0
> >>          corrected_errors: 0
> >>          last_physical: 36529242112
> >>
> >> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
> >> scrub status:1
> >> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1392059|t=
ree_extents_scrubbed:57626|data_bytes_scrubbed:44623339520|tree_bytes_scrub=
bed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:1853|csum=
_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corrected=
_errors:0|last_physical:36529242112|t_start:1709827877|t_resumed:0|duration=
:22|canceled:1|finished:1
> >>
> >> # btrfs scrub resume -BR /mnt/clonux_btrfs
> >> Starting scrub on devid 1
> >> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
> >> Scrub started:    Thu Mar  7 17:13:07 2024
> >> Status:           aborted
> >> Duration:         0:00:07
> >>          data_extents_scrubbed: 250206
> >>          tree_extents_scrubbed: 0
> >>          data_bytes_scrubbed: 14311002112
> >>          tree_bytes_scrubbed: 0
> >>          read_errors: 0
> >>          csum_errors: 0
> >>          verify_errors: 0
> >>          no_csum: 591
> >>          csum_discards: 0
> >>          super_errors: 0
> >>          malloc_errors: 0
> >>          uncorrectable_errors: 0
> >>          unverified_errors: 0
> >>          corrected_errors: 0
> >>          last_physical: 0
> >>
> >> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
> >> scrub status:1
> >> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1642265|t=
ree_extents_scrubbed:57626|data_bytes_scrubbed:58934341632|tree_bytes_scrub=
bed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:2444|csum=
_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corrected=
_errors:0|last_physical:0|t_start:1709827877|t_resumed:1709827987|duration:=
29|canceled:1|finished:1
> >>
> >> Best Regards,
> >> Michel Palleau
> >>
> >
>

