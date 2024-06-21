Return-Path: <linux-btrfs+bounces-5888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3B912D91
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 20:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41581C234F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959D17B423;
	Fri, 21 Jun 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="g/M20fIk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B17016A936
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996030; cv=none; b=IBfnWs4gRFaJ1W/HxdZ+s6cGE1nWF4BqGVGhDdBCQ4FIT1F0/GIpxnAy9B3siSh9Ud6IMpIubCUaLKcL4tpVhiKluA05gkxVUriX8Pc3zi+hFeswOPUINfVIry0OQbwaPyeKm7Yb3GB6nclRTTF3igkJ9Sd0HozvAPXtvS22Bm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996030; c=relaxed/simple;
	bh=5P0uYUzn1adrjANuMJVO7VAQX9tUdd34rRxV4sOe1FM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvdpJS/mu+gASwtBz/0/UmsmsNyEOeq+pI1EMOsiHeEGEog9DwIEOzcTgWmNMJvhZkKUBBc/tJV4a5KumD/vZNMD/ZZhq2DybJSwM6dpTXAuF/OZIl5dGuAhwgmA238KganG9wMXujD1euQTeL43XtLw7Z+4pv6vgZ9M2DY9p3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=g/M20fIk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-71910dfb8c0so46029a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718996027; x=1719600827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGjYvHjFsVR9RIfXuu9eT3qmQnI0mFRP7udVRsH//b0=;
        b=g/M20fIkvxLoK/C1tyJLZC48lzA9FRtxY9KKOOscK7LpK4LDjR2XXsmhMaVNzRx11d
         1CgsRwuFLDrx//LDgtY+tfbn9WHIv6oFaUgAJ38fsM9TSiG+OEOmPckwj+qbEpSmaVVe
         JLmekeiYlaKNi6I2rLZCMnmKRR7su9BczOom95Lo8IzYFZjyrZS0nsnaQljmkNaM4/O+
         4gvoSLRQ7wMgb+EDkXIyWAtkk9fjfWeJalyITTfXev9+HSZJ5dJ4Kaao6BK435noGgyC
         9G9Ptrpe+mnGAL5HvsW40rYxdG3pbMP1BK7fzIRO/d7owq5XND7I7PrUatnYznQvsSuL
         0BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996027; x=1719600827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGjYvHjFsVR9RIfXuu9eT3qmQnI0mFRP7udVRsH//b0=;
        b=wDdG8CoeAw2RvvDHCgIkMb+LCVwxrv4vBMWmcZvD2lRSDQYSMLJF7J2eTFp3a3VMK1
         bp97Pal7o4Bb1Hkm+V1KmptytCzLQ31C6WkPWfTGihbpFL441wreDPCTz3Kvs24l7j8e
         LZxPeQF6Lk2p4ztfxbKouBrh0+yzd2j/TqX8eFrJ6BrQCP9BXx4/f2PSyJiiVVBtWvcQ
         RmHR515zSyo5YwrbAk7BstZMbfHjDZ2WmlmDwVOicvOrgJ8h8aHRvYdpLNfIiCRDZlXR
         6Jw20mrv0gCyOauSzKpXRnaKOQySfFg+DZxTIbsVR4nvuXyCCcFpFbwg0jn+Udky0wRV
         Ndug==
X-Gm-Message-State: AOJu0Yxxqa/KIQt+n+qywJul5Jkue4RQni3nqH19ZNWsF6mBRBQRlESp
	c6hu4TSvzk+hmYzx6SHokvG3GlvFeCcI2ArSCqzzbhkeKPnX3bzWmc+eUZf958hBoiKysFPktlz
	V
X-Google-Smtp-Source: AGHT+IG4O+smVmLabIAgLizixCzHzWbOCUT8PUd0DcZnefmc39ew8TxAJfgS7K0UCyqo068G/JESjA==
X-Received: by 2002:a17:90a:f404:b0:2c7:aec2:ce8 with SMTP id 98e67ed59e1d1-2c7b5af48bdmr8684296a91.7.1718996027037;
        Fri, 21 Jun 2024 11:53:47 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:1ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e06e7sm3957366a91.21.2024.06.21.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:53:46 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 0/8] btrfs-progs: add subvol list options for sane path behavior
Date: Fri, 21 Jun 2024 11:53:29 -0700
Message-ID: <cover.1718995160.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Hello,

btrfs subvol list's path handling has been a constant source of
confusion for users. None of -o, -a, or the default do what users
expect. This has been broken for a decade; see [1].

This series adds two new options, -O and -A, which do what users
actually want: list subvolumes below a path, or list all subvolumes,
with minimal path shenanigans. This approach is conservative and tries
to maintain backwards compatibility, but it's worth discussing whether
we should instead fix the existing options/default, or more noisily
deprecate the existing options.

One additional benefit of this is that -O can be used by unprivileged
users.

Patch 1 fixes a libbtrfsutil bug I encountered while testing this.
Patches 2 and 3 fix libbtrfsutil's privilege checks to work in user
namespaces. Patches 4 and 5 remove some unused subvol list code. Patch 6
documents and tests the current, insane behavior. Patch 7 converts
subvol list to use libbtrfsutil. This is a revival of one of my old
patches [2], but is much easier now that libbtrfs has been pared down.
Patch 8 adds the new options, including documentation and tests.

Thanks!
Omar

1: https://lore.kernel.org/all/bdd9af61-b408-c8d2-6697-84230b0bcf89@gmail.com/
2: https://lore.kernel.org/all/6492726d6e89bf792627e4431f7ba7691f09c3d2.1518720598.git.osandov@fb.com/

Omar Sandoval (8):
  libbtrfsutil: fix accidentally closing fd passed to subvolume iterator
  libbtrfsutil: don't check for UID 0 in subvolume_info()
  libbtrfsutil: don't check for UID 0 in subvolume iterator
  btrfs-progs: subvol list: remove unused raw layout code
  btrfs-progs: subvol list: remove unused filters
  btrfs-progs: subvol list: document and test actual behavior of paths
  btrfs-progs: subvol list: use libbtrfsutil
  btrfs-progs: subvol list: add sane -O and -A options

 Documentation/btrfs-subvolume.rst             |   37 +-
 cmds/subvolume-list.c                         | 1081 +++++------------
 libbtrfsutil/python/tests/test_subvolume.py   |   18 +
 libbtrfsutil/subvolume.c                      |   50 +-
 .../026-subvolume-list-path-filtering/test.sh |  156 +++
 5 files changed, 565 insertions(+), 777 deletions(-)
 create mode 100755 tests/cli-tests/026-subvolume-list-path-filtering/test.sh

-- 
2.45.2


