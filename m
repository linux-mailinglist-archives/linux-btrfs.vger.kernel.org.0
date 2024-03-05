Return-Path: <linux-btrfs+bounces-3019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD38725DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE5BB21BD5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22054175B1;
	Tue,  5 Mar 2024 17:45:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34317583
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660717; cv=none; b=katVNIhT/Nfr9rMS/vRi8QqAJn7kUQT1l2PxapbN/iVeUMjoBnJI0ermvPaje2A+9a04Gm2cw4PrBUGr45DZ+8m6eyS79fr0FoEySiH5ZMNdINzvBoiRaN4tecRT64k/M+5VNoM452dy2JAbjvug/CI6KUEjXD0BfqeKjsynYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660717; c=relaxed/simple;
	bh=IsePTlOOrrY+PtgSBJ/oAdEDQA2yIEUijGkssqsdR4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx7zk0JPUo3Gy0IWXVPj5TGTzmJFO5yHp8Ny709zADMjz79pZbNt/8Ce/5nQwHu2GHnvk7Gx/g/WD6iWTSzJRRj0Re8q3xuKcNNiVG3eo0tUpP2DQgHsJyt6P2kWh7n+ZJu/MkrzziMy3hSmE/5XuAOVg/Pylfi1/zpf0HluXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6901a6dca63so38211746d6.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 09:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709660715; x=1710265515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gge8MXN2cBaJhAIuFm/jj/2ek2UAvG5SbyWzw+LqrLU=;
        b=ueEjsWPpftLT7I30jQOVno9w2lkbuypjgjkyI+c6oxRwNd9e6u6xNAxsN5n6zl94uP
         N7MwXCuRfj4QnetdNYoe+VzN0cCjmm0LjKECyyUrzMOVdo3mT2EJhEaHCta8QV809VEQ
         M7d9V3fXbHdg+EdevGBpsM1B/h7NCRrBUs+xS41oQBrtSiiKffXXHTLRDNz+nHfrB3To
         gJMzp26slhKVg9a/2YLpLDx6MoDfqGKKbDhBLRceg70lDjfTynxjUauOflX6NLmK8hqx
         XDBVjozFDSsqR98owsow8gpiwkvJ8WOwYErYQbqx0SVhFmib+oPI6quyryRXsGQzeCQY
         1WZg==
X-Forwarded-Encrypted: i=1; AJvYcCXMmeM3ysgldDKdVYDHSbwAbKW6PE7M1J3dimev1SOyYirsARtL0z/n+oM/bnWctGFpGrOvyBSaFV+t+ciwwh16/fuFxOoqqyeziF4=
X-Gm-Message-State: AOJu0Yx0BVunUJTj0XVUZTrMWazTTc+6+039j+3T5kUEEkk3TRchdHkP
	d76unlaQv0ysjfKlpk7BerxLjTuvl0/sUYbo0HKgH4tIe/oihRjXrNWs1dDbAA==
X-Google-Smtp-Source: AGHT+IEGQenmJZKbs3r2wugRgZMmiHwHXfXTF7+9Vyf8Oe9KTMxb0vnDidm2CHu6mpJiWDFoJRg7Vw==
X-Received: by 2002:ad4:4045:0:b0:690:7770:e6d4 with SMTP id r5-20020ad44045000000b006907770e6d4mr3044733qvp.34.1709660714673;
        Tue, 05 Mar 2024 09:45:14 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id ny4-20020a056214398400b0068fe4669e71sm6425247qvb.91.2024.03.05.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:45:14 -0800 (PST)
Date: Tue, 5 Mar 2024 12:45:13 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Patrick Plenefisch <simonpatp@gmail.com>
Cc: Goffredo Baroncelli <kreijack@inwind.it>, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	regressions@lists.linux.dev, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, ming.lei@redhat.com
Subject: Re: LVM-on-LVM: error while submitting device barriers
Message-ID: <ZedaKUge-EBo4CuT@redhat.com>
References: <CAOCpoWc_HQy4UJzTi9pqtJdO740Wx5Yd702O-mwXBE6RVBX1Eg@mail.gmail.com>
 <CAOCpoWf3TSQkUUo-qsj0LVEOm-kY0hXdmttLE82Ytc0hjpTSPw@mail.gmail.com>
 <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com>
 <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it>
 <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
 <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it>
 <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
 <a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it>

On Thu, Feb 29 2024 at  5:05P -0500,
Goffredo Baroncelli <kreijack@inwind.it> wrote:

> On 29/02/2024 21.22, Patrick Plenefisch wrote:
> > On Thu, Feb 29, 2024 at 2:56 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> > > 
> > > > Your understanding is correct. The only thing that comes to my mind to
> > > > cause the problem is asymmetry of the SATA devices. I have one 8TB
> > > > device, plus a 1.5TB, 3TB, and 3TB drives. Doing math on the actual
> > > > extents, lowerVG/single spans (3TB+3TB), and
> > > > lowerVG/lvmPool/lvm/brokenDisk spans (3TB+1.5TB). Both obviously have
> > > > the other leg of raid1 on the 8TB drive, but my thought was that the
> > > > jump across the 1.5+3TB drive gap was at least "interesting"
> > > 
> > > 
> > > what about lowerVG/works ?
> > > 
> > 
> > That one is only on two disks, it doesn't span any gaps
> 
> Sorry, but re-reading the original email I found something that I missed before:
> 
> > BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
> > 0, rd 0, flush 1, corrupt 0, gen 0
> > BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > tolerance is 0 for writable mount
> > BTRFS: error (device dm-75) in write_all_supers:4379: errno=-5 IO
> > failure (errors while submitting device barriers.)
> 
> Looking at the code, it seems that if a FLUSH commands fails, btrfs
> considers that the disk is missing. The it cannot mount RW the device.
> 
> I would investigate with the LVM developers, if it properly passes
> the flush/barrier command through all the layers, when we have an
> lvm over lvm (raid1). The fact that the lvm is a raid1, is important because
> a flush command to be honored has to be honored by all the
> devices involved.

Hi Patrick,

Your initial report (start of this thread) mentioned that the
regression occured with 5.19. The DM changes that landed during the
5.19 merge window refactored quite a bit of DM core's handling for bio
splitting (to simplify DM's newfound support for bio polling) -- Ming
Lei (now cc'd) and I wrote these changes:

e86f2b005a51 dm: simplify basic targets
bdb34759a0db dm: use bio_sectors in dm_aceept_partial_bio
b992b40dfcc1 dm: don't pass bio to __dm_start_io_acct and dm_end_io_acct
e6926ad0c988 dm: pass dm_io instance to dm_io_acct directly
d3de6d12694d dm: switch to bdev based IO accounting interfaces
7dd76d1feec7 dm: improve bio splitting and associated IO accounting
2e803cd99ba8 dm: don't grab target io reference in dm_zone_map_bio
0f14d60a023c dm: improve dm_io reference counting
ec211631ae24 dm: put all polled dm_io instances into a single list
9d20653fe84e dm: simplify bio-based IO accounting further
4edadf6dcb54 dm: improve abnormal bio processing

I'll have a closer look at these DM commits (especially relative to
flush bios and your stacked device usage).

The last commit (4edadf6dcb54) is marginally relevant (but likely most
easily reverted from v5.19-rc2, as a simple test to see if it somehow
a problem... doubtful to be cause but worth a try).

(FYI, not relevant because it is specific to REQ_NOWAIT but figured I'd
 mention it, this commit earlier in the 5.19 DM changes was bogus:
 563a225c9fd2 dm: introduce dm_{get,put}_live_table_bio called from dm_submit_bio
 Jens fixed it with this stable@ commit:
 a9ce385344f9 dm: don't attempt to queue IO under RCU protection)

> > > However yes, I agree that the pair of disks involved may be the answer
> > > of the problem.
> > > 
> > > Could you show us the output of
> > > 
> > > $ sudo pvdisplay -m
> > > 
> > > 
> > 
> > I trimmed it, but kept the relevant bits (Free PE is thus not correct):
> > 
> > 
> >    --- Physical volume ---
> >    PV Name               /dev/lowerVG/lvmPool
> >    VG Name               lvm
> >    PV Size               <3.00 TiB / not usable 3.00 MiB
> >    Allocatable           yes
> >    PE Size               4.00 MiB
> >    Total PE              786431
> >    Free PE               82943
> >    Allocated PE          703488
> >    PV UUID               7p3LSU-EAHd-xUg0-r9vT-Gzkf-tYFV-mvlU1M
> > 
> >    --- Physical Segments ---
> >    Physical extent 0 to 159999:
> >      Logical volume      /dev/lvm/brokenDisk
> >      Logical extents     0 to 159999
> >    Physical extent 160000 to 339199:
> >      Logical volume      /dev/lvm/a
> >      Logical extents     0 to 179199
> >    Physical extent 339200 to 349439:
> >      Logical volume      /dev/lvm/brokenDisk
> >      Logical extents     160000 to 170239
> >    Physical extent 349440 to 351999:
> >      FREE
> >    Physical extent 352000 to 460026:
> >      Logical volume      /dev/lvm/brokenDisk
> >      Logical extents     416261 to 524287
> >    Physical extent 460027 to 540409:
> >      FREE
> >    Physical extent 540410 to 786430:
> >      Logical volume      /dev/lvm/brokenDisk
> >      Logical extents     170240 to 416260

Please provide the following from guest that activates /dev/lvm/brokenDisk:

lsblk
dmsetup table

Please also provide the same from the host (just for completeness).

Also, I didn't see any kernel logs that show DM-specific errors.  I
doubt you'd have left any DM-specific errors out in your report.  So
is btrfs the canary here?  To be clear: You're only seeing btrfs
errors in the kernel log?

Mike

