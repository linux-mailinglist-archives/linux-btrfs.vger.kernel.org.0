Return-Path: <linux-btrfs+bounces-773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B1C80B195
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 02:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020C61F21449
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 01:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD66EA5;
	Sat,  9 Dec 2023 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAPXbmeO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A469E7
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 17:50:51 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fa37df6da8so1638189fac.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Dec 2023 17:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702086650; x=1702691450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c1+e+DZOfEF3rKrlqy8ryeyNoOSURpA8wvnbr1Bex2E=;
        b=FAPXbmeO7paYsRK1/H0F12Fo/NygHfknRWJhTNexzIKTAE5t2XsftXAzEa3RlczGfy
         8goKH2OQ1keWg4iCcwAezTR1dCF9FvBTEg8Nk26TjduwX9QbGSh0NrHyn2IeS4aoGQ5E
         j9k41qsK1T/9kbyJ2uz6ZmIiVkNBb2a5qzr02P3x4w2A5PVqPaltifH9gTIrAU6MCcpk
         Vpn07aVm8IZxTRA/sqX3Edkmv2WL5dNCZr+fdiOy3ojeSiWzGkrE84wlRT1nDrBiWnGk
         MPbnd2EzZ315YjZ5NmUIW/AaJLpw8/VHZwTUtFGeC/eN9nsCJiLMmV/uGW7WSOmJzdsT
         j3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702086650; x=1702691450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1+e+DZOfEF3rKrlqy8ryeyNoOSURpA8wvnbr1Bex2E=;
        b=YNJkOgNWtMcvyUI2vDzfWruq68ZzTdlmf583oEUHaU99i5XwOF03oYncLc/tjkLrGO
         YtvDMY5ZSTa48B9xuoVt+MYa2sIsOCOZmoZUvPY5CBGwrvisZLbhhu8ceL2ngrLIqd3A
         uOE5fZfphsL0i45MWwN78lgaYIunuN6i1zzopCkMI9SQPqb5UVmf2vV0ov+yPHKM47yv
         UMv2QkG/1WoR1XYUJLi1/JGDO6mqam/fcBiIS4cjkGoMbK8j+/yBSy/KZO1rq4wUOwTP
         KMJYaNzHTWD8XspmP0ljBGHKnR+a1IKvtP2468KvkIW2V9OUg3t3T3eCbexo1BcURegB
         x7tw==
X-Gm-Message-State: AOJu0YyZtZZBCZ8mvn+0+i7fdVG9dZHJ5aHjfsJxIno9zo1QK9kdTC/Q
	RxwLVb5y3SQ2wicON9tphQgrtSAg650QUXlu65k=
X-Google-Smtp-Source: AGHT+IHUHKoLsKPn1vzCaG4rm24dVBRl4j95f0/24jy1lwzQmL02ujk3hs9cBm3GxR32k0HmQfBK3wiJPBbl2dYwJaY=
X-Received: by 2002:a05:6870:b027:b0:1fb:75c:3fee with SMTP id
 y39-20020a056870b02700b001fb075c3feemr1254588oae.78.1702086650330; Fri, 08
 Dec 2023 17:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+W5K0r4Jkhwm2ztJYwKQ1w91Cb0tObcd4PA6bLDOH18xbmYAg@mail.gmail.com>
 <8ba85386-fb30-415e-8ef1-05dcaf833c26@gmx.com>
In-Reply-To: <8ba85386-fb30-415e-8ef1-05dcaf833c26@gmx.com>
From: Stefan N <stefannnau@gmail.com>
Date: Sat, 9 Dec 2023 12:20:38 +1030
Message-ID: <CA+W5K0ouj3WN3en7q_1uGTzCqzuAiUJqQJot7zkRpH8M1-6vBA@mail.gmail.com>
Subject: Re: scrub: unrepaired sectors detected
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Qu,

Thanks for explaining that, and giving a path to remediation.

Could you please explain how you derived the bytenr range from the log
message, as my attempt to reverse engineer the maths was not
successful in the next reported error:

BTRFS error (device sdg): unrepaired sectors detected, full stripe
145932367691776 data stripe 2 errors 14-15

Cheers,

Stefan

On Wed, 6 Dec 2023 at 06:35, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2023/12/5 18:21, Stefan N wrote:
> > Hi all,
> >
> > I'm having trouble getting an array to perform a scrub or replace, and
> > would appreciate any assistance. I have two empty disks I can use to
> > move things around, but the intended outcome is to use them to replace
> > two of the smaller disks.
> >
> > $ uname -a ; btrfs --version ; btrfs fi show
> > Linux $hostname 6.5.0-13-generic #13-Ubuntu SMP PREEMPT_DYNAMIC Fri
> > Nov  3 12:16:05 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> > btrfs-progs v6.3.2
> > Label: none  uuid: 3cde0d85-f53e-4db6-ac2c-a0e6528c5ced
> >          Total devices 8 FS bytes used 71.32TiB
> >          devid    1 size 16.37TiB used 16.37TiB path /dev/sdg
> >          devid    2 size 10.91TiB used 10.91TiB path /dev/sdf
> >          devid    3 size 16.37TiB used 16.36TiB path /dev/sdd
> >          devid    4 size 16.37TiB used 12.54TiB path /dev/sda
> >          devid    5 size 10.91TiB used 10.91TiB path /dev/sde
> >          devid    6 size 10.91TiB used 10.91TiB path /dev/sdc
> >          devid    7 size 16.37TiB used 16.37TiB path /dev/sdh
> >          devid    8 size 10.91TiB used 10.91TiB path /dev/sdb
> >
> > $ btrfs fi df /mnt/point/
> > Data, RAID6: total=71.97TiB, used=71.23TiB
> > System, RAID1C3: total=36.00MiB, used=6.62MiB
> > Metadata, RAID1C3: total=91.00GiB, used=85.09GiB
> > GlobalReserve, single: total=512.00MiB, used=0.00B
> > $
> >
> > Attempting to scrub
> > BTRFS error (device sdg): unrepaired sectors detected, full stripe
> > 145926853230592 data stripe 2 errors 5-13
>
> This is introduced in recent kernels, to detect full stripe RAID56
> stripes which contains sectors which can not be repaired.
>
> This is pretty new behavior as an extra safenet, as sometimes such scrub
> itself can further corrupt the P/Q stripes and cause unrepairable sectors.
>
> And I'm afraid that's already the case here.
> Older RAID56 code (and even the newer one) still has the old write-hole
> problem, thus previous power loss can reduce the redundancy and
> eventually lead to data corruption.
>
> Newer scrub code is addressing this by detecting and error out, other
> than further spreading the corruption.
> > BTRFS info (device sdg): scrub: not finished on devid 2 with status: -5
> >
> > Scrub device /dev/sdf (id 2) canceled
> > Scrub started:    Thu Nov 30 08:01:03 2023
> > Status:           aborted
> > Duration:         32:17:10
> >          data_extents_scrubbed: 89766644
> >          tree_extents_scrubbed: 0
> >          data_bytes_scrubbed: 5856020676608
> >          tree_bytes_scrubbed: 0
> >          read_errors: 0
> >          csum_errors: 0
> >          verify_errors: 0
> >          no_csum: 0
> >          csum_discards: 0
> >          super_errors: 0
> >          malloc_errors: 0
> >          uncorrectable_errors: 0
> >          unverified_errors: 0
> >          corrected_errors: 0
> >          last_physical: 7984173809664
> >
> > Attempting to do replace using brand new disks, failed at ~50%, ran
> > twice with two different pairs of disks
> > Disk /dev/sdi: 16.37 TiB, 18000207937536 bytes, 35156656128 sectors
> > Disk /dev/sdl: 16.37 TiB, 18000207937536 bytes, 35156656128 sectors
> >
> > BTRFS error (device sdg): unrepaired sectors detected, full stripe
> > 145926853230592 data stripe 2 errors 5-13
> > BTRFS error (device sdg): btrfs_scrub_dev(/dev/sdf, 2, /dev/sdl) failed -5
> >
> > The data is fairly replaceable so typically have been previously been
> > deleting files that fail checks and performing roughly 3-monthly
> > scrubs and weekly balances (musage/dusage=50).
>
> This can be something happened in the past but only caught by newer kernel.
>
> Anyway if you're fine to delete some files (only 9 sectors affected),
> you can try to locate the inodes for the following bytenr range:
>
>   [145926853382144, 145926853414912]
>
> The way to go is using "btrfs logical-resolve -o <bytenr> <mnt>".
>
> And delete all the involved files, increase the bytenr by 4k, try again
> until no more output for every 4K block in above range.
>
> Normally it should only be one or two files.
>
> Then retry scrub, re-do the loop until the scrub can finish properly.
>
> Thanks,
> Qu
>
> >
> > Any help would be appreciated!
> >
> > Cheers,
> >
> > Stefan
> >

