Return-Path: <linux-btrfs+bounces-19019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F32C5F118
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 20:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6591D3AFBF1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA882F3C0A;
	Fri, 14 Nov 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="YXFX1VdJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4931197A
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149166; cv=none; b=lqVop9eXLcZVptJPm+7iC6I6oIB/ocE35WB3pYmE6rSbu4mvvPCYm0aldUW5ADQM0saPAAIIeIaK9WmMscyR780Kormx5bGOFzEakYhB6ewwdigw7L39Xgwo0mp+KqaCD39T/IZrB/0cWbViS2M7qrj18uLXvcLx3IKP3ztt6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149166; c=relaxed/simple;
	bh=Gg94zcvxqWVQ3XTTTynfd90sJLPVI5Fol1gyuExMvkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdmtJQ8hPAN/jmvmj1nePUzFMwBAhlQRnlYBuqhD6fToftTzcXFpdW9h5dLCivOltC87L1+bYqgiTv5l64RvwA/UUS4X1DJumQdZcJ64ogI/53nU2E2saI1mtj0fZ/0c0mWSr9PRU26/HznsqsHN+yuJGi0lVX61vWnBnEqvxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=YXFX1VdJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2957850c63bso25328555ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1763149164; x=1763753964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tavLr036pG63tigGC/Pibenu75r7sClmuoJWM6BfG84=;
        b=YXFX1VdJUHAKsEzL0MAcl9yH2rFOqkW/B4TY+YlkKymT+B4J/afkw9ThjU4yv0HboM
         Al6zyOKPduBvZGxWwrw/YaJ7wvPjP7xdJyZoVf40/rreyatOHV0xBBY8+r6PvkmmCHYu
         BwoJHv9PzYyZOqYTbe5frdwd0+yFVDovDRfXowLMGjuL0Q/8qVKqo3XFuPROltlaBMkv
         Y0JSPdTRlhsj620hdAzw6KfKGTbXe46FltmDo4QkcG+HP5HzYHyULLawSTMePkK4V7GD
         gM4gPHdBHUGnHnSl0aQyMvi9T2q+EFsw07AZVu1sQLwG7sJWniPaAoZEjw6Kwn2qaVCj
         AXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763149164; x=1763753964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tavLr036pG63tigGC/Pibenu75r7sClmuoJWM6BfG84=;
        b=GUOdGr9TYMar+/29d62qDHJMC2LqzSkjtQahgx0OnyUD5QiIBDf8wt/X/O2+APaQ7A
         dowwm4fIwlq/wJXkN1JOTNNfeYTE9rcx7jsfO8bGu8k7XXF2ugbLgOyHl64CHf/qP03e
         oRM+Qq2SXHguj1wMAMe1uMo5UICiYAOQFdwuCH1zrnj+8q3PtUosvwW/Fo9EhDCf++hi
         xdJ6oWUz9GNzdcdPpJVATR+0Jx64UT6BPtSI+AbG+d+kKUDt5GFZ0s23/PbaNxDWLob7
         WwQpFkKwf4axaW1yAccD/jJYLEKQcSTxYgWjl00HMtgfC2jau0ol054sdsQjKA903Yx6
         j7Og==
X-Forwarded-Encrypted: i=1; AJvYcCVVWSv3r/SMDzpWHX5fiynEgK4MYGidz+sOrInCGeaZ2/slVtZKiQxcRnZEsF1JLFEaWOzxqyzpA6nB9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPEPwjKjfrYDZat5atKPDmfftg5Blm5oZTWCd4YX0kOV1H3bh
	Wn/DRFhb+KBfhPi6KgSkCDfSFta6q4OMdkT5hySpm4mcQJYDBLug6GcdcvsdcHkrHE8=
X-Gm-Gg: ASbGncv+0I2sKXv+G7WD4SA1HKpePjtqkFzLN1Qv1Lvn6k4mAMcXS5ETGhmhItPaxWz
	k7O4pJ6TTAjZb9h89N2fnPKWIwxjh2YI9FxEKs1UUBEHF1PzJlw0pOewv3zLxYYtAbC3YtapN4q
	bofJHfhwfNT48ScGs0GUsrP824JtL/vWVBHwDmok5Tu3FWSFUy434t/Co4V21SzZltAYXjpuH//
	ryQCS/RPiaFpFGNuVxEgdH0JyWYeAXzDn4oxSz0R7QLegGUpnfTm6A50XYh0dR2bjVDLVesk5+l
	3E1CJkQ4BjGBCgUUPLTcpbRs6PYz1kjkH6tT2Zr2Q7KTQ0+IQiGt8Zbu+ue4kCX1tkCkVpAU3LE
	X6z/HY+uF+N2l0idxLU9bdj5p7rx66WBKZJlm0cJ5P/WZSoR7qScLJRA5fpvPVfcFIrrX7xlnaw
	4zBU7mr3exTOy/
X-Google-Smtp-Source: AGHT+IGGrHC2AIZ0Km169BwzHrymQfZjImARw8BbmjGAS2uV1DjPSYHcuNdmc0xN11aKitAqtfnZMg==
X-Received: by 2002:a17:903:2f07:b0:295:592f:9496 with SMTP id d9443c01a7336-29867fd0ddfmr51094975ad.20.1763149164125;
        Fri, 14 Nov 2025 11:39:24 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c253b30sm63168895ad.46.2025.11.14.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:39:23 -0800 (PST)
Date: Fri, 14 Nov 2025 11:39:21 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [QUESTION] Debugging some file data corruption
Message-ID: <aReFaSpMe3yxoBMA@mozart.vkv.me>
References: <20251111170142.635908-1-calvin@wbinvd.org>
 <cd54e3a7-d676-46fe-8922-bb97d4e775cc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd54e3a7-d676-46fe-8922-bb97d4e775cc@gmx.com>

On Wednesday 11/12 at 07:32 +1030, Qu Wenruo wrote:
> With LUKS in the middle, it makes any corruption pattern very human
> unreadable.
> 
> I guess it's not really feasible to try to reproduce the problem again since
> it has 10TiB data involved?

I can try again. It only takes 10 minutes of my time to get it started,
even if it takes a few days to run, I've got spare machines for it.

> But if you can spend a lot of time waiting for data copy, mind to try
> the following combination(s)?
> 
> - btrfs on mdraid1
> - btrfs RAID1 on raw two HDDs

Will do.

> Considering there is no bad/bad combinations, I strongly doubt if it's
> mdraid1 itself causing problems.
> 
> Does the mdraid1 has something like write-behind feature enabled?

No, nothing special, I'm creating the array using:

    mdadm --create -l 1 -n 2 --write-zeroes /dev/sda /dev/sdb

> > Then, I re-ran the offline scrubs: drive A now shows all the errors
> > originally seen across both drives, and drive B is now clean.
> > 
> > Finally, I ran userspace checksums of the full set of files on the
> > newly clean drive B: they perfectly match an older copy in my backups.
> > 
> > This proves that:
> > 
> >      1) RAID mismatches and btrfs checksum failures are strictly 1:1.
> >      2) For every RAID mismatch, strictly one mirror was corrupted.
> >      3) No slient corruption occurred, btrfs caught everything.
> > 
> > The hard drives are brand new, so that is my current suspicion.
> 
> I won't suspect HDD as the first culprit. Since no powerloss there is no
> FLUSH/FUA bugs involved, and all corruptions are related to data but not
> metadata, if it's really HDD I guess we should have at least one or two
> metadata corruption too.

I should have mentioned this: there were a few metadata corruptions, but
the first online scrub fixed them (DUP), so I didn't get a chance to see
what their contents were. Here's the full log:

    [Oct 5 00:45] [ T307779] BTRFS: device fsid 3bd1727b-c8ae-4876-96b2-9318c1f9556f devid 1 transid 121 /dev/mapper/md0_crypt (253:1) scanned by mount (307779)
    [  +0.000875] [ T307779] BTRFS info (device dm-1): first mount of filesystem 3bd1727b-c8ae-4876-96b2-9318c1f9556f
    [  +0.000054] [ T307779] BTRFS info (device dm-1): using blake2b (blake2b-256-generic) checksum algorithm
    [  +3.510409] [ T307779] BTRFS info (device dm-1): enabling ssd optimizations
    [  +0.000052] [ T307779] BTRFS info (device dm-1): enabling free space tree
    [  +0.000015] [ T307779] BTRFS info (device dm-1): use zstd compression, level 1
    [  +9.793525] [ T307802] BTRFS info (device dm-1): scrub: started on devid 1
    [Oct 5 01:30] [ T307812] BTRFS error (device dm-1): scrub: fixed up error at logical 316151431168 on dev /dev/mapper/md0_crypt physical 310791110656
    [  +0.000070] [ T307812] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
    [Oct 5 05:16] [ T308052] BTRFS error (device dm-1): scrub: unable to fixup (regular) error at logical 1850055917568 on dev /dev/mapper/md0_crypt physical 1858654240768
    [  +0.082724] [ T308052] BTRFS warning (device dm-1): scrub: checksum error at logical 1850055917568 on dev /dev/mapper/md0_crypt, physical 1858654240768 root 5 inode 387 offset 40929132544 length 4096 links 1 (path: REDACTED)
    [  +0.000077] [ T308052] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
    [Oct 5 06:51] [ T312207] BTRFS warning (device dm-1): scrub: tree block 2493640359936 mirror 2 has bad csum, has 0x4086e4014eeb997db83ae7255c333697ed4d740338405795861d6f3d0c7848af want 0xbdbcdc764674915f8899d9c164916bd7aad34693e78e9e9ba479b2339e12ef1c
    [  +0.077111] [ T312207] BTRFS error (device dm-1): scrub: fixed up error at logical 2493640343552 on dev /dev/mapper/md0_crypt physical 2510828601344
    [  +0.000065] [ T312207] BTRFS error (device dm-1): scrub: fixed up error at logical 2493640343552 on dev /dev/mapper/md0_crypt physical 2510828601344
    [  +0.000026] [ T312207] BTRFS error (device dm-1): scrub: fixed up error at logical 2493640343552 on dev /dev/mapper/md0_crypt physical 2510828601344
    [  +0.000016] [ T312207] BTRFS error (device dm-1): scrub: fixed up error at logical 2493640343552 on dev /dev/mapper/md0_crypt physical 2510828601344
    [Oct 5 07:47] [ T312650] BTRFS error (device dm-1): scrub: unable to fixup (regular) error at logical 2878389944320 on dev /dev/mapper/md0_crypt physical 2896685498368
    [  +0.079176] [ T312650] BTRFS warning (device dm-1): scrub: checksum error at logical 2878389944320 on dev /dev/mapper/md0_crypt, physical 2896685498368 root 5 inode 431 offset 2979594240 length 4096 links 1 (path: REDACTED)
    [  +0.000079] [ T312650] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
    [Oct 5 08:42] [ T312757] BTRFS error (device dm-1): scrub: fixed up error at logical 3255455711232 on dev /dev/mapper/md0_crypt physical 3273751265280
    [  +0.000066] [ T312757] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
    [Oct 5 12:31] [ T316045] BTRFS error (device dm-1): scrub: unable to fixup (regular) error at logical 4804342972416 on dev /dev/mapper/md0_crypt physical 4836597170176
    [  +0.106254] [ T316045] BTRFS warning (device dm-1): scrub: checksum error at logical 4804342972416 on dev /dev/mapper/md0_crypt, physical 4836597170176 root 5 inode 12231 offset 626524160 length 4096 links 1 (path: REDACTED)
    [  +0.000082] [ T316045] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
    [Oct 5 12:40] [ T316489] BTRFS error (device dm-1): scrub: unable to fixup (regular) error at logical 4864481624064 on dev /dev/mapper/md0_crypt physical 4896735821824
    [  +0.018418] [ T316489] BTRFS warning (device dm-1): scrub: checksum error at logical 4864481624064 on dev /dev/mapper/md0_crypt, physical 4896735821824 root 5 inode 12268 offset 635633664 length 4096 links 1 (path: REDACTED)
    [  +0.000067] [ T316489] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
    [Oct 5 15:18] [ T317014] BTRFS error (device dm-1): scrub: unable to fixup (regular) error at logical 5960080556032 on dev /dev/mapper/md0_crypt physical 5996629721088
    [  +0.088397] [ T317014] BTRFS warning (device dm-1): scrub: checksum error at logical 5960080556032 on dev /dev/mapper/md0_crypt, physical 5996629721088 root 5 inode 15079 offset 43859968 length 4096 links 1 (path: REDACTED)
    [  +0.000078] [ T317014] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
    [ +11.379069] [ T319380] BTRFS error (device dm-1): scrub: unable to fixup (regular) error at logical 5961402220544 on dev /dev/mapper/md0_crypt physical 5997951385600
    [  +0.000245] [ T319380] BTRFS warning (device dm-1): scrub: checksum error at logical 5961402220544 on dev /dev/mapper/md0_crypt, physical 5997951385600 root 5 inode 15079 offset 612937728 length 4096 links 1 (path: REDACTED)
    [  +0.000038] [ T319380] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
    [Oct 5 16:39] [ T320461] BTRFS error (device dm-1): scrub: fixed up error at logical 6508309970944 on dev /dev/mapper/md0_crypt physical 6551301586944
    [  +0.000066] [ T320461] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
    [Oct 5 16:44] [ T319972] BTRFS error (device dm-1): scrub: unable to fixup (regular) error at logical 6542744813568 on dev /dev/mapper/md0_crypt physical 6585736429568
    [  +0.072550] [ T319972] BTRFS warning (device dm-1): scrub: checksum error at logical 6542744813568 on dev /dev/mapper/md0_crypt, physical 6585736429568 root 5 inode 16518 offset 103481344 length 4096 links 1 (path: REDACTED)
    [  +0.000079] [ T319972] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
    [Oct 5 20:28] [ T320144] BTRFS error (device dm-1): scrub: unable to fixup (regular) error at logical 8062253727744 on dev /dev/mapper/md0_crypt physical 8112761536512
    [  +0.059861] [ T320144] BTRFS warning (device dm-1): scrub: checksum error at logical 8062253727744 on dev /dev/mapper/md0_crypt, physical 8112761536512 root 5 inode 349790 offset 16443854848 length 4096 links 1 (path: REDACTED)
    [  +0.000069] [ T320144] BTRFS error (device dm-1): bdev /dev/mapper/md0_crypt errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
    [Oct 5 21:01] [ T307802] BTRFS info (device dm-1): scrub: finished on devid 1 with status: 0

    UUID:             3bd1727b-c8ae-4876-96b2-9318c1f9556f
    Scrub started:    Sun Oct  5 00:45:20 2025
    Status:           finished
    Duration:         20:15:56
    Total to scrub:   7.54TiB
    Rate:             108.38MiB/s
    Error summary:    verify=4 csum=11
      Corrected:      7
      Uncorrectable:  8
      Unverified:     0

That scrub missed about half the data errors, which makes sense to me:
the mdraid1 "randomly" reads a given block from one or the other
underlying drive.

But the metadata doesn't make sense to me: the one scrub appears to have
seen and fixed *all* the metadata errors, because my later offline
scrubs of each individual drive saw no metadata errors. Seems unlikely.

I'll make sure to only run offline scrubs next time, so I can inspect
the metadata corruptions too (and for the btrfs-raid1, so I can inspect
the corruptions at all before they're fixed up).

> > I've
> > used the same two-drive USB enclosure extensively with older HDDs and
> > never seen a problem. I'm running this FIO job to test them:
> > 
> >      [global]
> >      numjobs=1
> >      loops=20
> >      ioengine=io_uring
> >      rw=randrw
> >      percentage_random=5%
> >      rwmixwrite=95
> >      iodepth=32
> >      direct=1
> >      size=5%
> >      blocksize_range=1k-32m
> >      sync=none
> >      refill_buffers=1
> >      random_distribution=random
> >      random_generator=tausworthe64
> >      verify=xxhash
> >      verify_fatal=1
> >      verify_dump=1
> >      do_verify=1
> >      verify_async=$ncpus
> >      [hdd-sdb-test]
> >      filename=/dev/sdb
> >      [hdd-sdc-test]
> >      filename=/dev/sdc
> > 
> > ...but no luck hitting anything after about 18 hours.
> 
> I didn't have a good experience using fio to find corruption, thus if you
> hit the problem by simplying copying data (I guess through 'cp'?), then
> maybe stick to the working reproducer?
> 
> Although copying 10TiB into HDDs will take over 40 hours, still much longer
> than your fio workload.

Makes sense. I'll stick to making copies like the original workload,
and report back if I can trigger it again.

Thanks,
Calvin

