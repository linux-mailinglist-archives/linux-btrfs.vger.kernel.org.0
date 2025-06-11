Return-Path: <linux-btrfs+bounces-14597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF92AD50C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C131895824
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E67262815;
	Wed, 11 Jun 2025 10:03:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03C25A2A4
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636199; cv=none; b=bJ3gH+fvOOIZkyX7TrB0XlnvFqOrvrVWb4hPtNGQb5jRGDuBqrZY3KFiqliXdQcJrY74nAAPx5GRKp///0fTQMtq3E3GmTAjM0/d7bKf5ybXuQyepiJwH97CXfwaePlOeGrGQNuN2nZwEDnGSQGGJXHWZrglm7/i6U1DHnbqoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636199; c=relaxed/simple;
	bh=wliJUKWoviwXqYBf7NFx882FlpHbK6234ZD3G/1WSPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cf+qGTW/VZhK/tGkEwjzh+hQlcvcuWTccldRRjyqVAaKmSFGWN1ahnaKBXqB7lZXrCwIisivh80leggIZMctP7K2UsfDF4VHMWuLNU/XD1XbJQj74TwIhl9TX38iBj+0Sq9EnCWXFA48LymZ+snoMnebZbxW6Hm43w7Jukp0QMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so508731f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 03:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636196; x=1750240996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IXnZmnVMwT0IswClHHqdEmzGa2VU6WoRpaiiAOQHrk=;
        b=g0RmSKQUFJSluDCl5D6qJ/FMe0BDqwiOW0aCvYSgpo9Lj2kdgX7xLoB7jrHDOBWykb
         PLisq1RaCGpms6xMGC3PUMy/IYC8IvXQZWLh/2qCr8Uj7zguijZ3/aCOD/CBTcUhXTTU
         prQuYV/k3pCmlUHrtG/XnUULLO4zgsPT84L8ouDcC+VO8PAZ5hbfpnujkYkeGlf+CyJH
         ipsCtpOXvBBuFh/gWQ0o06Ftba3M5NiagMOmmlHOmT5w+FesxTvKmAeXFCGzN3LmV5//
         hi0mLPOyIgsc3qb2cMVbLzd04Pzxy13s0cTXe+FT5SPoSoc7QQyWsaleNon0Qa1/Zw95
         BJqA==
X-Gm-Message-State: AOJu0YxtFmWh792ASIzVJf0bNnV4fRmAyxrCXLT2O7FwMySyyIyosbKh
	xjFNW13/xjT0Ib48UzvP9pZinIse0dGzIftuuXEMv9CSvznjyIjJrmHNtRQSEw==
X-Gm-Gg: ASbGncv7G0piOgN5TQQmCcECQTaqnzvYk+frYmoBRIvJNg/3t/EDze/9WCg60vcgTAR
	wf0OradDGrKWnQOibzy/TNkAZAhCwSbdglluO8KYZ4MTCJBvzDSiUnD6pCMd3UVliRxfWWN0ee1
	e23/tZ87siV/Xjw9TryCf0xJ3rLjlHP9Jqv46Snv2i9U2Vhd7UrmreO3XSxd0rfC2G/ayxBfoDH
	X9caX7JSgjieHYmEBW37jNUuIDxI9NT2fO15bYfoAc1AxbYjCsBB+cp9llBFSm+Ob7UNo9IrnQZ
	seq9Or4XmiNXzjyYn+8ql6AsudEGPkNFEoE8tQaw0u/xU1LZDkVu5grxzDkokTV8+iGHdVrbW0d
	TwzylW9CH81KsnUrz9vByTp1RSTpwiNhlfE3HsybdxKAxBLGLlQ==
X-Google-Smtp-Source: AGHT+IGEDyIepcjH5M8Tii15i5PlYB/hfa3ZBMXINn0U+mQVLdoutK6zbkrkN6NLrABlr5xl85xw5w==
X-Received: by 2002:a05:6000:4308:b0:3a4:e624:4ec9 with SMTP id ffacd0b85a97d-3a5581e7666mr2282493f8f.3.1749636195666;
        Wed, 11 Jun 2025 03:03:15 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f02asm14654274f8f.83.2025.06.11.03.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:03:13 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/5] btrfs: use the super_block as bdev holder
Date: Wed, 11 Jun 2025 12:02:58 +0200
Message-ID: <20250611100303.110311-1-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This is a series I've picked up from Christoph, it changes the
block_device's bdev holder from fs_type to the super block.

As the re-base was non trivial, I opted to drop Boris' Reviewed-by tags.

Here's the original cover letter:
Hi all,

this series contains the btrfs parts of the "remove get_super" from June
that managed to get lost.

I've dropped all the reviews from back then as the rebase against the new
mount API conversion led to a lot of non-trivial conflicts.

Josef kindly ran it through the CI farm and provided a fixup based on that.



Link to rebase v1:
https://lore.kernel.org/linux-btrfs/20240214-hch-device-open-v1-0-b153428b4f72@wdc.com/

Link to original posting:
https://lore.kernel.org/linux-btrfs/b083ae24-2273-479f-8c9e-96cb9ef083b8@wdc.com/

Christoph Hellwig (5):
  btrfs: always open the device read-only in btrfs_scan_one_device
  btrfs: call btrfs_close_devices from ->kill_sb
  btrfs: split btrfs_fs_devices.opened
  btrfs: open block devices after superblock creation
  btrfs: use the super_block as holder when mounting file systems

 fs/btrfs/disk-io.c |  4 +--
 fs/btrfs/super.c   | 70 +++++++++++++++++++++++++++-------------------
 fs/btrfs/volumes.c | 62 ++++++++++++++++++++--------------------
 fs/btrfs/volumes.h |  8 ++++--
 4 files changed, 80 insertions(+), 64 deletions(-)

-- 
2.49.0


