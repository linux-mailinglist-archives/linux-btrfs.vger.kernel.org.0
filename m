Return-Path: <linux-btrfs+bounces-6448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ED7930D34
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 06:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DA71F213E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 04:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD6A183097;
	Mon, 15 Jul 2024 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTXh3gIp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20D28FC
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721017793; cv=none; b=jv9k95YmPAr5mcdJ4wMo541oe5scPOGd+Vs+b3F4fYDHp7Ti56Ga500EJTAj9QdLSWJvznF3XpfFLEyGzAlO2B3rB9d8Ka7aYFW5D8kh9jOQShj2pSoSRpsl8EZ3RRLV0WMz8ePMsLqp2QwyAeKSNcAXq9KffOSt7U68w65hr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721017793; c=relaxed/simple;
	bh=V2KV9NKM96hL3KtuToZo6hgfsa7H82f6ANNiSw/pYXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lj2yDYt+rdXTNQaf2ygliBW8DauAkGOaF4j2eYj5owOPDUSHvIJFovEHD6XUSFczX6V52gHtKqKjaU7TKvD8F7LgsIQmf/WA+FcysUsnt4sQob0FXc9EShS+NIXwLKltqt0FVxiaC7ZOeW2oZv+2GJ9Af8wzoKyCqG1TgodLG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTXh3gIp; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79f08b01ba6so328452885a.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 21:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721017790; x=1721622590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2KV9NKM96hL3KtuToZo6hgfsa7H82f6ANNiSw/pYXc=;
        b=YTXh3gIp4a5+j6owc6MPliFRnc65uPxqxDWQqrIcnD7jKz6UnoHR/pC423Tt1l724w
         0ChfwxYL6e04i4hRcUuALVbWs0LAkbVyZ/qM/P3q4u7OfBiieorwOVxOubUSqeOFij0A
         3T+mmZmnyJqoQy10LaNl03rlRRmW14lGGO7WhfORWEqrKB6AIoAyHaUr54ER4Z1aJkPM
         7cgH+xVThawB2PmlYzGQmKukfEjh+s79LVRSJmxnon18mPJsPbejCS5Whz2t8wOb0yvz
         nJZ/FR9CuY+NhmdkYuQV2Nutr+Zw+SKLVxZch2kqSMBNKmJxZ6hoyxAQ9YsjVMjc08PF
         X8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721017790; x=1721622590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2KV9NKM96hL3KtuToZo6hgfsa7H82f6ANNiSw/pYXc=;
        b=vH+fp34sD8IFdAyXQjQJxhc/Uoho63Y55a48Lx9ZjTz05x35YgNWMhvJxsK2nmMfZm
         OlOqnFN+DTYhAFFWDw18zlEKaNTCmGmeusBpGRdW/cp2QgJz572Zt8n+x5t73PDJiHz6
         Vt7BEyKk0pPeo8HriGulSTW2mzWAn86Ct/7aTLF+yyUirjRqUnYnEL47t0H+fFtgD5ru
         leiInnhSGdkhLZ2dXDN3u3vbxR8gDy9tiwTUzC9Mxb3IzkLo0P1LjoOv4YjMbyhoNlQV
         UT5qCX7a1GdWEht5fQUJ3vtr4cV+4M8dJuqd34Lzk+CFF06cY+xkdscXrc3XgZ47s2Hd
         rWNQ==
X-Gm-Message-State: AOJu0YxYOldgNCuFoERHHxDQnvbYiZcXkJ7m6klWWQRek8ks0thw5uuy
	cWR/PcUnkKZLgWn+s3lXGzrvyyidTtCX1lPDYn3yjTBBDlfh3mfaD4+AcDjZIQ/WHr+I3BCIRoe
	iNS0MVuQC6HsPIBgkdmUeb/koRp1jjx3ewf0=
X-Google-Smtp-Source: AGHT+IGXAE7o/sVzpXqahwXrpDU77wkTMlXfbr/QOyGapABjy0fM7b8uoI4HtZR/BrGA9eliqIIjgoXyres5r28oWpI=
X-Received: by 2002:a05:620a:2996:b0:79b:ee4e:8362 with SMTP id
 af79cd13be357-7a152f2a92amr2055384385a.0.1721017790287; Sun, 14 Jul 2024
 21:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
 <0bedfc5f-4658-4d01-98b3-34bc14f736f3@gmx.com>
In-Reply-To: <0bedfc5f-4658-4d01-98b3-34bc14f736f3@gmx.com>
From: Kai Krakow <hurikhan77@gmail.com>
Date: Mon, 15 Jul 2024 06:29:24 +0200
Message-ID: <CAMthOuNk273pZUSU1Npr-Zx7LscBxOsXeyWcQCgbYP=82TfreA@mail.gmail.com>
Subject: Re: btrfs crashes during routine btrfs-balance-least-used
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, Oliver Wien <ow@netactive.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Qu!

Thanks for looking into this. We already started the restore, so we no
longer have any access to the corrupted disk images.

Am So., 14. Juli 2024 um 23:54 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
>
>
>
> =E5=9C=A8 2024/7/15 01:43, Kai Krakow =E5=86=99=E9=81=93:
> > Hello btrfs list!
> >
> > (also reported in irc)
> >
> > Our btrfs pool crashed during a routine btrfs-balance-least-used.
> > Maybe of interest: bees is also running on this filesystem, snapper
> > takes hourly snapshots with retention policy.
> >
> > I'm currently still collecting diagnostics, "btrfs check" log is
> > already 3 GB and growing.
> >
> > The btrfs runs on three devices vd{c,e,f}1 with data=3Dsingle meta=3Dra=
id1.
> >
> > Here's an excerpt from dmesg (full log https://gist.tnonline.net/TE):
>
> Unfortunately the full log is not really full.
>
> There should be extent leaf dump, and after that dump, showing the
> reason why we believe it's a problem.
>
> Is there any true full dmesg dump?

Yes, sorry. The gist has been truncated - mea culpa. I repasted it:
https://gist.tnonline.net/6Q

> But overall, most of the errors inside __btrfs_free_extent() would be
> extent tree corruption.
>
> > [...]
> >
> > "btrfs check" can only run in lowmem mode, it will crash with "out of
> > memory" (the system has 74G of RAM). Here's the beginning of the log:
> >
> > [1/7] checking root items
> > [2/7] checking extents
> > ERROR: shared extent 15929577472 referencer lost (parent: 1147747794944=
)
>
> I believe that's the cause, some extent tree corruption.
>
> > ERROR: shared extent 15929577472 referencer lost (parent: 1148095201280=
)
> > ERROR: shared extent 15929577472 referencer lost (parent: 1175758274560=
)
> > (repeating thousands of similar lines)
> >
> > Last gist: https://gist.tnonline.net/Z4 (meanwhile, this log is over
> > 3GB, I can upload it somewhere later).
> >
> > We have backups (daily backups stored inside borg on a remote host).
> >
> > Is there anything we can do? Restoring from backup will probably take
> > more than 24h (3 TB). The system runs web and mail hosts for more than
> > 100 customers.
> >
> > We did not try to run "btrfs check --repair" yet, nor
> > "--init-extent-tree". I'd rather try a quick repair before restoring.
> > But OTOH, I don't want to make it worse and waste time by trying.
>
> Considering the size of the metadata, I do not believe --repair nor
> --init-extent-tree is going to fully fix the problem.

Yes, I suspected that and cancelled the btrfs check. I still have the
log (3.8GB) but it's probably not useful, and I cancelled at step 3/7
after seeing it sitting there for hours without output but 100% CPU
usage on one core.

> > Unfortunately, the btrfs has been mounted rw again after unmounting
> > following the incident. This restarted the balance, and it seems it
> > changed the first error "btrfs check" found. I'll try
> > "ro,skip-balance" after btrfs-check finished. I think the file-system
> > is still fully readable and we can take one last backup.
> >
> > Also, I happily provide the logs collected if a dev wanted to look into=
 it.
>
> I guess there is no real full dmesg of that incident?
>
> The corrupted extent leaf has 260 items, but the dump only contains 36,
> nor the final reason line.

See above, I repasted it.

> The other thing is, does the server has ECC memory?
> It's not uncommon to see bitflips causing various problems (almost
> monthly reports).

I don't know the exact hosting environment, we are inside of a QEMU
VM. But I'm pretty sure it is ECC.

The disk images are hosted on DRBD, with two redundant remote block
devices on NVMe RAID. Our VM runs on KVM/QEMU. We are not seeing DRBD
from within the VM. Because the lower storage layer is redundant, we
are not running a data raid profile in btrfs but we use multiple block
devices because we are seeing better latency behavior that way.

> If the machine doesn't have ECC memory, then a memtest would be preferabl=
e.

I'll ask our data center operators about ECC but I'm pretty sure the
answer will be: yes, it's ECC.

We have been using their data centers for 20+ years and have never
seen a bit flip or storage failure.

I wonder if parallel use of snapper (hourly, with thinning after 24h),
bees (we are seeing dedup rates of 2:1 - 3:1 for some datasets in the
hosting services) and btrfs-balance-least-used somehow triggered this.
I remember some old reports where bees could trigger corruption in
balance or scrub, and evading that by pausing if it detected it. I
don't know if this is an issue any longer (kernel 6.6.30 LTS).


Thanks,
Kai

