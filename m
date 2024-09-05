Return-Path: <linux-btrfs+bounces-7847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE696CCDD
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 04:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31F9283695
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 02:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287013E043;
	Thu,  5 Sep 2024 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9IFY7qX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1977113
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504997; cv=none; b=iscMtlKodaz/FIuudTeDFpvSROgTJqUeRU8kLwT55RNcryCkSdP0kEUhHZgxjmqMKAxD+CECSU/xUmcVuYmposF3KP7qTjKjMgqYG8HmQxVj522H2ZqPF4V1LC4hTFMYp1AbE8aQjEYRkqyjtaCh+L/TSF/sQ9X1YIl/nHxYchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504997; c=relaxed/simple;
	bh=QYy7hvAXIQwHiFmVwpmJpEeCcQvrah10RfUpLgmU3II=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=duTzqfcL6+E5dwd5F5bu+OPXi4koSoI1Ny6elbCfUGV4rL1kk6S7BkxTZDvIhDgVcX15YHTMFh5WuE3p2GZ4Fk+D6P/x5HsYDoJ6DzwSEgGJpNOd7nki/y6s6de3J3UEzUXtEAlVWTTH5k6NQA5ZZ49CXh7vf4Izc9V88liFueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9IFY7qX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c26b5f1ea6so375790a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2024 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725504993; x=1726109793; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=67Ds8mfFLExo9eHdpP62xWjvMlDvzeaZvHLur/D/dEI=;
        b=J9IFY7qXc3lMrbcrDekO26IgirEc4DsUN2dZolQRxTwF6xJBk5SO2q8wNewDwIhb3o
         iGs0djVvhNoxX8e+SkpSaRGv71TV2uYaFCoxqsj+QJnjqILnAQdGoXhToBttbQMlpuF6
         HRtYuKKeIC3zRqjYV4r6LRHZFjGNWTDGRRz7M/EXjCEV8rDEHBir4D8usiDHfPG489fe
         0kYV/relZID/jWtL0eiSZWxZJfs+HxiB3ZAZrILUbfWIqRf9G2GvZfeRi+PF1ndPrRaa
         mQxxmx3QqT/3jcTCSi13RQuo+FZgkNPV9Yx/2r1NrCzYThiZafh9muHaqx0YdfhonbDc
         3s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725504993; x=1726109793;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67Ds8mfFLExo9eHdpP62xWjvMlDvzeaZvHLur/D/dEI=;
        b=oonxBsqcyVssN3KPDG//6uSgmdTKIL0TJC4C+eviVpiAzXVJLfQvPBCFCx4txy2cu3
         dqu3DLS6OzsZAKVO1LAIMMsGWKE09FWA0VCTZI1bspQiXMmKaIkT8tp/ZkKSShwr2ue4
         mqnp+hKyQ3gxT7en6/egh+mTx0vcfOF6tJtxzcCoqqvi9C1X/dgjFdBnCJrSx+WERhw9
         l7K89UhpjNWLok7DDPwVwOfBk7FMX8fFY8AQMvdFMHxOkqg61DHEAZ53do8667sHXhcb
         VChFmNhpLyXJQMO8erUF54YB0SeA1m4X4MKIXycTGQbwJ0OF62/+z95xgYGnIpMPz/h7
         l0pA==
X-Gm-Message-State: AOJu0YwmrqRlbARlzDwWgEsPVsA/2bk37LN7iuYDrzZbfEfOkIPTDybz
	tyf+3ahhhKWgic7ZsjNOubl4VJerlhAFMP4P184dx1Z+dyywGBQHGBje2RfgptcEt5pNUqsMJXJ
	AwRJlCZZ07GAWATnyCXevZ/ab0koFYkbr
X-Google-Smtp-Source: AGHT+IEDp/FHN4JmPHmr/t43nu6M8SYBgf5pUWYnNa6/30Wrja7c/M+KDTiRDO701t+8vyghOOdy6DZah1n6Ihw+yto=
X-Received: by 2002:a17:907:e88:b0:a80:f6a0:9c3c with SMTP id
 a640c23a62f3a-a8a3eccb81amr428847266b.0.1725504992611; Wed, 04 Sep 2024
 19:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: - <facespkz@gmail.com>
Date: Wed, 4 Sep 2024 19:56:20 -0700
Message-ID: <CACENFKgFRa+9S1ryFVpboHBCJLD6H2JP-gu6vbwYerDogHzXRg@mail.gmail.com>
Subject: Unable to mount BTRFS volume after I/O failure (failed to read chunk root)
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone, a couple years ago (2022-12-30) I used an external
drive to move files around between it and another external drive.
One of the hard drives reported I/O errors in the middle of copying
one of the folders (ironically, after I had already deleted these
folders from the source drive).
After the I/O error, I tried unplugging the drive and plugging it back
in (i don't know, either). But now, it doesn't mount. I opened up the
terminal to mount it through there, and found out that I had
encountered a fatal error.

================================================================================
# mount /dev/sdb1 /mnt
mount: /mnt: can't read superblock on /dev/sdb1.
       dmesg(1) may have more information after failed mount system call.

# dmesg | tail -8
[  113.299043] BTRFS: device fsid f9b35423-c290-44cb-9c0b-c2e3b40af99f
devid 1 transid 1158 /dev/sdb1 scanned by mount (2291)
[  113.313442] BTRFS info (device sdb1): first mount of filesystem
f9b35423-c290-44cb-9c0b-c2e3b40af99f
[  113.313462] BTRFS info (device sdb1): using crc32c (crc32c-intel)
checksum algorithm
[  113.313470] BTRFS info (device sdb1): using free-space-tree
[  113.328151] BTRFS error (device sdb1): parent transid verify failed
on logical 23707648 mirror 1 wanted 1158 found 1154
[  113.332392] BTRFS error (device sdb1): parent transid verify failed
on logical 23707648 mirror 2 wanted 1158 found 1154
[  113.332559] BTRFS error (device sdb1): failed to read chunk root
[  113.361455] BTRFS error (device sdb1): open_ctree failed
================================================================================

So far I've tried every non-destructive path I could think of,
including btrfs restore, and a notoriously destructive btrfs check
--repair.

================================================================================
$ sudo btrfs restore -D /dev/sdb1 /mnt
parent transid verify failed on 23707648 wanted 1158 found 1154
parent transid verify failed on 23707648 wanted 1158 found 1154
parent transid verify failed on 23707648 wanted 1158 found 1154
Ignoring transid failure
parent transid verify failed on 1120368508928 wanted 1158 found 1135
parent transid verify failed on 1120368508928 wanted 1158 found 1135
parent transid verify failed on 1120368508928 wanted 1158 found 1135
Ignoring transid failure
ERROR: root [2 0] level 0 does not match 2

WARNING: could not setup extent tree, skipping it
parent transid verify failed on 1120372424704 wanted 1158 found 1136
parent transid verify failed on 1120372424704 wanted 1158 found 1136
parent transid verify failed on 1120372424704 wanted 1158 found 1136
Ignoring transid failure
ERROR: root [7 0] level 0 does not match 2

WARNING: could not setup csum tree, skipping it
parent transid verify failed on 1120369197056 wanted 1158 found 1136
parent transid verify failed on 1120369197056 wanted 1158 found 1136
parent transid verify failed on 1120369197056 wanted 1158 found 1136
Ignoring transid failure
ERROR: root [10 0] level 0 does not match 1

WARNING: could not setup free space tree, skipping it
parent transid verify failed on 1120368885760 wanted 1158 found 1149
parent transid verify failed on 1120368885760 wanted 1158 found 1149
parent transid verify failed on 1120368885760 wanted 1158 found 1149
Ignoring transid failure
ERROR: root [4 0] level 0 does not match 1

Couldn't setup device tree
Could not open root, trying backup super
================================================================================

Even then, the tools didn't want anything to do with it. To this day,
they still see a partition on the drive.

================================================================================
# btrfs fi show /dev/sdb1
Label: none  uuid: f9b35423-c290-44cb-9c0b-c2e3b40af99f
    Total devices 1 FS bytes used 1.38TiB
    devid    1 size 1.82TiB used 1.39TiB path /dev/sdb1
================================================================================

So, I left it alone. I haven't done anything with it since, besides
undeleting files from the source drive (NTFS), with little luck. These
were relatively fresh deletes, too.
I've been able to use DMDE to recreate a file structure, but because I
mounted the drive with compression enabled (i don't know, either),
sections of some files were compressed with zstd. Every 4096 bytes.

I'm not asking for support with DMDE, but it did inspire me to give
this another shot. Is it still possible to restore this file system to
a state where I can copy everything off of it before I trash it for
good?
I have an image of the volume on a third hard drive, just in case I
manage to mess up the file system even further.

Thanks,
facespkz

