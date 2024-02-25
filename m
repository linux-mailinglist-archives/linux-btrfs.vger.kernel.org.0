Return-Path: <linux-btrfs+bounces-2751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73F862C92
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 20:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C9C1C2095B
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1046318E27;
	Sun, 25 Feb 2024 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="To2k844y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5B63CF
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708889436; cv=none; b=UnWEnGs8y22BXsTfeeeka5s7n/ppvzH3MIdAFmc9hgWdiwRvB+mTlom6gNW0iduCU7+SbNxgJEV0wVdHtu9LvA3rq4wNKRF2fWfFbPBaZJJ+zrfAYgp7D3R8POSPpy3BMscEVKaEhApf2iuC+CVzpCDFrjK8MzA7ssCGoFWfnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708889436; c=relaxed/simple;
	bh=qekmkvFPPS6rXFtr3LF7mPFALiDNM3k40B2q9lmOsD8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ne5++fPRqWzMB+PTpfhM8B1EyTSmWczDjg9u/VGBo67hnCX26cCYc/Ids/xop5StFM7UNNixnMjPZFszPU0w68aFrmlU7h1+tNN7maNX6y5RBdkyVSoWn8reuc2wuUZTHRorb9PDoA8EgEZIXhkxbSpTonyV03+UZBTdKMIGXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=To2k844y; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f51ba7043so17695876d6.3
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1708889433; x=1709494233; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNNdxxhuELQOy8An9XzQn7b5fYWBTTeB+Zr461cPnYg=;
        b=To2k844yZw8sfemLlETJ0tI8Z7MHrG2Ee7YXazRcB9HbXhzjd165CxYjJoDHn0d/wz
         qVM2z3ftHMPo7wj6CeoHG9Sa+KJ1qDeBC2cYv8UftbkgkWr/JybJl1C/It2ulxU44Up+
         dYu41VVCs6uj/+6c6mlYErjmwA75nlH0T2Fys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708889433; x=1709494233;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNNdxxhuELQOy8An9XzQn7b5fYWBTTeB+Zr461cPnYg=;
        b=aTJBD4ZkYy7ERAZMk0q91HLE7mvbyxENrPiuQU/1478ZjOqjVrHanFctqc9Vm0X2zx
         AwjAODxhAn2zyvagFgBAT6YQa6eKaFdd5f2K3uvOPETbFnmdYlB9sXoCJH1Zw2ofx2qy
         kO0a0gwr3ZXHiAzritDtbqFZxI+BE536y+yY5COfNKUT4RUHfdifGUgQlD4xXlhGs+m9
         hASNzb1ZIjimGqsg9IBE4pzwb75UpIdIDZ8/q4qUoGah29z2RRxx/2EeSZ/5ALkCdxlk
         WXNr3ulrrWFJh6tGdBSuQkQiWihIj4w05K6zhYEzN9K7Gi6Dec9EEZy7prfPcrUluvwO
         a4aQ==
X-Gm-Message-State: AOJu0YwscZjKeYBynMRmxtGBWqaAE5mZiSAoAXFCRoREkhDGwV/WOROZ
	mpDYiA6qo6Mgfj4SiIamL8D8RsYj5Jiu5bTlcLtEwu2wBYbjqF/DVfJcbu/DtPMo2wuGgYrEkFO
	h5K8h3u7Qn7TfTbEwfRmgLB2FEF/ITl2bWdg=
X-Google-Smtp-Source: AGHT+IFHElyMgBydVG5p9GXZcCHdL4F0hXD2xmMXjDbIroVsWMlNBAgXYsTi4fX5qNzrelg6a/agw8/DhZklr1+n52A=
X-Received: by 2002:a0c:9cc1:0:b0:68f:e051:b1f2 with SMTP id
 j1-20020a0c9cc1000000b0068fe051b1f2mr7079272qvf.24.1708889433004; Sun, 25 Feb
 2024 11:30:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tavian Barnes <tavianator@tavianator.com>
Date: Sun, 25 Feb 2024 14:30:22 -0500
Message-ID: <CABg4E-=u7m_g3HCFUYHS-+RC==pefkUZXiTT2Aor86jruHSF9Q@mail.gmail.com>
Subject: Corruption while bisecting (was: [PATCH] btrfs: tree-checker: dump
 the page status if hit something wrong)
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Well, bad news: I started bisecting from v6.0 and after a couple
rounds, my root fs is really corrupted:

UUID:             e1902620-c206-4e34-9f24-e66cdb6b8872
Scrub started:    Sun Feb 25 18:47:29 2024
Status:           finished
Duration:         0:20:18
Total to scrub:   2.72TiB
Rate:             2.29GiB/s
Error summary:    csum=2073625
  Corrected:      0
  Uncorrectable:  2073625
  Unverified:     0

All the errors seem confined to one of the four disks which is strange:

BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242230988800 on dev /dev/mapper/slash3 physical 914556321792
BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242227580928 on dev /dev/mapper/slash3 physical 914555469824
BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242228105216 on dev /dev/mapper/slash3 physical 914555600896
BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242230202368 on dev /dev/mapper/slash3 physical 914556125184
BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242233348096 on dev /dev/mapper/slash3 physical 914556911616
BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242227843072 on dev /dev/mapper/slash3 physical 914555535360
BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242228367360 on dev /dev/mapper/slash3 physical 914555666432
BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242229415936 on dev /dev/mapper/slash3 physical 914555928576
BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242229940224 on dev /dev/mapper/slash3 physical 914556059648
BTRFS error (device dm-0): unable to fixup (regular) error at logical
7242228891648 on dev /dev/mapper/slash3 physical 914555797504
BTRFS warning (device dm-0): checksum error at logical 7242227843072
on dev /dev/mapper/slash3, physical 914555535360, root 136483, inode
60736199, offset 720896, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
BTRFS warning (device dm-0): checksum error at logical 7242228891648
on dev /dev/mapper/slash3, physical 914555797504, root 136483, inode
60736199, offset 1769472, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
BTRFS warning (device dm-0): checksum error at logical 7242228105216
on dev /dev/mapper/slash3, physical 914555600896, root 136483, inode
60736199, offset 983040, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
BTRFS warning (device dm-0): checksum error at logical 7242228367360
on dev /dev/mapper/slash3, physical 914555666432, root 136483, inode
60736199, offset 1245184, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
BTRFS warning (device dm-0): checksum error at logical 7242230988800
on dev /dev/mapper/slash3, physical 914556321792, root 136483, inode
60736199, offset 3866624, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
BTRFS warning (device dm-0): checksum error at logical 7242229940224
on dev /dev/mapper/slash3, physical 914556059648, root 136483, inode
60736199, offset 2818048, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
BTRFS warning (device dm-0): checksum error at logical 7242228891648
on dev /dev/mapper/slash3, physical 914555797504, root 136483, inode
60736199, offset 1769472, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
BTRFS warning (device dm-0): checksum error at logical 7242233348096
on dev /dev/mapper/slash3, physical 914556911616, root 136483, inode
60736199, offset 6225920, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
BTRFS warning (device dm-0): checksum error at logical 7242230202368
on dev /dev/mapper/slash3, physical 914556125184, root 136483, inode
60736199, offset 3080192, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
BTRFS warning (device dm-0): checksum error at logical 7242227843072
on dev /dev/mapper/slash3, physical 914555535360, root 136483, inode
60736199, offset 720896, length 4096, links 1 (path:
var/cache/pacman/pkg/agda-2.6.3-27-x86_64.pkg.tar.zst)
scrub_stripe_report_errors: 344892 callbacks suppressed
...

-- 
Tavian Barnes

