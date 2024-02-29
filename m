Return-Path: <linux-btrfs+bounces-2949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151F86D41E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 21:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D21B238ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35ED1428F1;
	Thu, 29 Feb 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYEUV/mM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20B2E410;
	Thu, 29 Feb 2024 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238190; cv=none; b=RZkx5ezp2nAYPmP2HTCC33awPRHaCYmpV+JMVwUH01Y67LZyjW4Gp/dDvagE7b72TDx3w80oQxxlur1K+Ko1OtYDCvFmjPDJk7pqOHKpUT8vARYhR/QPs+fgdk3ehxt+eL3aLAzwBOAmQ0vrDBCUoctTF75F0SnWKWjL3VSnD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238190; c=relaxed/simple;
	bh=xabk9dEH5rv/Q3KXb8Xb68e7dDO1NHfgnoluRFT00wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4czLzGZIPlsY2tVmIQazcpe3kevpwDuN2fs7PKqUOPFeUSr2p4bo+A1qyBjXCLqGRxe4nOa9qAh2iKRxzKrihpql/wJCMDPch+h1EVFF5zapg4uBi92vbpjiPCpelXVTMHt6r4RAF1bDFEsZNEW7ifLiJ184hfBWveYJtWXLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYEUV/mM; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so17149121fa.0;
        Thu, 29 Feb 2024 12:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709238186; x=1709842986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPyP/8+yGh/Fz5Liv/iaUIqR/+KFIkJAldR0ybW8wvA=;
        b=YYEUV/mMjWjBq/fAhuss2TkWQzLPTavOxTICuGGRgM3CqlyDs7/QtxuPAzfQQE3IfM
         O9lpmWuV5YppcQMWcqcppyQ1NjYu6r3zU5dbB8mjDqML+U6hVaZCb1/SokvlSlAd3zyK
         hWs4DDRsc0gey38mdHzZkNLSEbM4KlqW4wIt9AC+nEpz9eVlNY/aFn0mvAOUfIumRO+V
         D5LqyU1IvW0cuDJAMqwMLAeStObaZmtEfv+MjV6TKYSI8REfyjwtLZ5dBOd7noFK/I6K
         ILCqxoi03T+gDftY/GKbb1NH4UAbnV9qbZ+ylNwv79ZmOwWCzCO2KMH+4AdZHlsSWRl6
         Jfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238186; x=1709842986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPyP/8+yGh/Fz5Liv/iaUIqR/+KFIkJAldR0ybW8wvA=;
        b=PdpiEdSc0wzWtYRSASHl59jWGN0lgoWizvqb/m4+GYdghJ8hI/xMEQEA1kV/VayuFK
         ba29isRD5n1evfcJa8HQLTInPAQNumeAbIzrFLCE4gT1tn5oMqsLI/9JtEPqdUQH0wwA
         hzJTfH+gCHRtBUgOCZ1JtN9vmezeO8B6M4GqP2OnYKvU3To+1GkTkFI/QLuBXXXhZdI4
         9f7ryn1YD+gYelMFlYwZtEJlVdGMMfFrgbjiNhcAxU72yJcvuz0ihVBGb3lar1iwGhBg
         W0UtSMvqK5jVF7IVBidB7wD1/7LpweObThCVy/zWoEEoH+4sMd85uCkrpJZ5oIM3WWu1
         VobQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbbZUpU80ZG1G7sQP6XaQbtbcuCYhzVD63Av62uro/i/sye6OI9uwIWv9ZUAXwa480c2j4gg+QdxWlpzDIgohDLzauYJc0hgHjczEmC7TrpD4P3ytuMgYHmGoqsm95sp3lG6ONMcys9as=
X-Gm-Message-State: AOJu0YxwHAxIA5GTXNPLqHZim1zpb0LU5eea6UX3MaajMJURbZT/NcZ6
	p3ZgQ/R/uwZUAZTUVr+r9x1oDbipo/RTJElRRynuP9jgu4ihPPjdJkHJgK7Pw6FqgKKw8p+Rjcc
	6jThugx0EKf+k/UZisZtfg7ulrTM=
X-Google-Smtp-Source: AGHT+IFSUOiYxMAFVv8qkkZPRRjuwWMbQMQ31xjkjfrGQETOu7lAsmTw/Dir42YGhyFw96kaWzL1/d6KOgmUrqltZp4=
X-Received: by 2002:a05:651c:82:b0:2d2:6574:4011 with SMTP id
 2-20020a05651c008200b002d265744011mr1996175ljq.30.1709238186076; Thu, 29 Feb
 2024 12:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOCpoWc_HQy4UJzTi9pqtJdO740Wx5Yd702O-mwXBE6RVBX1Eg@mail.gmail.com>
 <CAOCpoWf3TSQkUUo-qsj0LVEOm-kY0hXdmttLE82Ytc0hjpTSPw@mail.gmail.com>
 <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com>
 <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it> <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
 <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it>
In-Reply-To: <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it>
From: Patrick Plenefisch <simonpatp@gmail.com>
Date: Thu, 29 Feb 2024 15:22:55 -0500
Message-ID: <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
Subject: Re: [REGRESSION] LVM-on-LVM: error while submitting device barriers
To: kreijack@inwind.it
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, regressions@lists.linux.dev, dm-devel@lists.linux.dev, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:56=E2=80=AFPM Goffredo Baroncelli <kreijack@inwin=
d.it> wrote:
>
> > Your understanding is correct. The only thing that comes to my mind to
> > cause the problem is asymmetry of the SATA devices. I have one 8TB
> > device, plus a 1.5TB, 3TB, and 3TB drives. Doing math on the actual
> > extents, lowerVG/single spans (3TB+3TB), and
> > lowerVG/lvmPool/lvm/brokenDisk spans (3TB+1.5TB). Both obviously have
> > the other leg of raid1 on the 8TB drive, but my thought was that the
> > jump across the 1.5+3TB drive gap was at least "interesting"
>
>
> what about lowerVG/works ?
>

That one is only on two disks, it doesn't span any gaps

> However yes, I agree that the pair of disks involved may be the answer
> of the problem.
>
> Could you show us the output of
>
> $ sudo pvdisplay -m
>
>

I trimmed it, but kept the relevant bits (Free PE is thus not correct):


  --- Physical volume ---
  PV Name               /dev/lowerVG/lvmPool
  VG Name               lvm
  PV Size               <3.00 TiB / not usable 3.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              786431
  Free PE               82943
  Allocated PE          703488
  PV UUID               7p3LSU-EAHd-xUg0-r9vT-Gzkf-tYFV-mvlU1M

  --- Physical Segments ---
  Physical extent 0 to 159999:
    Logical volume      /dev/lvm/brokenDisk
    Logical extents     0 to 159999
  Physical extent 160000 to 339199:
    Logical volume      /dev/lvm/a
    Logical extents     0 to 179199
  Physical extent 339200 to 349439:
    Logical volume      /dev/lvm/brokenDisk
    Logical extents     160000 to 170239
  Physical extent 349440 to 351999:
    FREE
  Physical extent 352000 to 460026:
    Logical volume      /dev/lvm/brokenDisk
    Logical extents     416261 to 524287
  Physical extent 460027 to 540409:
    FREE
  Physical extent 540410 to 786430:
    Logical volume      /dev/lvm/brokenDisk
    Logical extents     170240 to 416260


  --- Physical volume ---
  PV Name               /dev/sda3
  VG Name               lowerVG
  PV Size               <2.70 TiB / not usable 3.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              707154
  Free PE               909
  Allocated PE          706245
  PV UUID               W8gJ0P-JuMs-1y3g-b5cO-4RuA-MoFs-3zgKBn

  --- Physical Segments ---
  Physical extent 0 to 52223:
    Logical volume      /dev/lowerVG/single_corig_rimage_0_iorig
    Logical extents     629330 to 681553
  Physical extent 52224 to 628940:
    Logical volume      /dev/lowerVG/single_corig_rimage_0_iorig
    Logical extents     0 to 576716
  Physical extent 628941 to 628941:
    Logical volume      /dev/lowerVG/single_corig_rmeta_0
    Logical extents     0 to 0
  Physical extent 628942 to 628962:
    Logical volume      /dev/lowerVG/single_corig_rimage_0_iorig
    Logical extents     681554 to 681574
  Physical extent 628963 to 634431:
    Logical volume      /dev/lowerVG/single_corig_rimage_0_imeta
    Logical extents     0 to 5468
  Physical extent 634432 to 654540:
    FREE
  Physical extent 654541 to 707153:
    Logical volume      /dev/lowerVG/single_corig_rimage_0_iorig
    Logical extents     576717 to 629329

  --- Physical volume ---
  PV Name               /dev/sdf2
  VG Name               lowerVG
  PV Size               <7.28 TiB / not usable 4.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              1907645
  Free PE               414967
  Allocated PE          1492678
  PV UUID               my0zQM-832Z-HYPD-sNfW-68ms-nddg-lMyWJM

  --- Physical Segments ---
  Physical extent 0 to 0:
    Logical volume      /dev/lowerVG/single_corig_rmeta_1
    Logical extents     0 to 0
  Physical extent 1 to 681575:
    Logical volume      /dev/lowerVG/single_corig_rimage_1_iorig
    Logical extents     0 to 681574
  Physical extent 681576 to 687044:
    Logical volume      /dev/lowerVG/single_corig_rimage_1_imeta
    Logical extents     0 to 5468
  Physical extent 687045 to 687045:
    Logical volume      /dev/lowerVG/lvmPool_rmeta_0
    Logical extents     0 to 0
  Physical extent 687046 to 1049242:
    Logical volume      /dev/lowerVG/lvmPool_rimage_0
    Logical extents     0 to 362196
  Physical extent 1049243 to 1056551:
    FREE
  Physical extent 1056552 to 1473477:
    Logical volume      /dev/lowerVG/lvmPool_rimage_0
    Logical extents     369506 to 786431
  Physical extent 1473478 to 1480786:
    Logical volume      /dev/lowerVG/lvmPool_rimage_0
    Logical extents     362197 to 369505
  Physical extent 1480787 to 1907644:
    FREE

  --- Physical volume ---
  PV Name               /dev/sdb3
  VG Name               lowerVG
  PV Size               1.33 TiB / not usable 3.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              349398
  Free PE               0
  Allocated PE          349398
  PV UUID               Ncmgdw-ZOXS-qTYL-1jAz-w7zt-38V2-f53EpI

  --- Physical Segments ---
  Physical extent 0 to 0:
    Logical volume      /dev/lowerVG/lvmPool_rmeta_1
    Logical extents     0 to 0
  Physical extent 1 to 349397:
    Logical volume      /dev/lowerVG/lvmPool_rimage_1
    Logical extents     0 to 349396


  --- Physical volume ---
  PV Name               /dev/sde2
  VG Name               lowerVG
  PV Size               2.71 TiB / not usable 3.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              711346
  Free PE               255111
  Allocated PE          456235
  PV UUID               xUG8TG-wvp0-roBo-GPo7-sbvn-aE7I-NAHU07

  --- Physical Segments ---
  Physical extent 0 to 416925:
    Logical volume      /dev/lowerVG/lvmPool_rimage_1
    Logical extents     369506 to 786431
  Physical extent 416926 to 437034:
    Logical volume      /dev/lowerVG/lvmPool_rimage_1
    Logical extents     349397 to 369505
  Physical extent 437035 to 711345:
    FREE


Finally, I am not sure if it's relevant, but I did struggle to expand
the raid1 volumes across gaps when creating this setup. I did file a
bug about that, though I am not sure if it's relevant, as I removed
integrity and cache for brokenDisk & lvmPool:
https://gitlab.com/lvmteam/lvm2/-/issues/6

Patrick

