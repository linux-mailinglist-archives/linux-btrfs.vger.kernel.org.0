Return-Path: <linux-btrfs+bounces-13107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D87FDA90E00
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 23:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D17B7AE682
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E768B224AE1;
	Wed, 16 Apr 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HjAlN1PL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE00DDDC
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840235; cv=none; b=c5JEaMpyKPKGr6XKYfmNLLE+gBHfp9X8jHCdXVXXaaI0i2W0fhVwnHZpAZ7oRQg575JRRVKjNG1rUCyimGe5HOH5j9VcPtCy2133UhA9GblCr1DC5//N3YwTlCCtXgKMiugxx012YkN6GQQJQE4Ixb8fhZ39pDKMsIUiEYHbFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840235; c=relaxed/simple;
	bh=V9shPnBOVEyoow6SRUOAAvzDKQXvwY9HjF4DqIqgw3A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OMVBMN9GZUEGP/K9giFOecvz08mUkN4aixcBm2ab4PAC47sUxEYYI4gIuHFrdL0uKImWkK/fodd04OgVadqY28XkVGljzw6LimLNTPDGw3ja9g2uf1iFCYEhUzCYAjbngi6aNRnMYUO2urZHMh7PZRoOJlq77NUJb0+8UCOym2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HjAlN1PL; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e6dee579f38so182102276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744840231; x=1745445031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXoZG+8BCJBZs45tO0cIdxM1Q/6NDR70zQWhqtGDHF8=;
        b=HjAlN1PLCFvRfBvFslQIz0C09fQ/vmIhEHb86ryo1pqQWLAJNfU4UQG5DDv49HIg3P
         4E1EzSNGaOEzCX4cPMN+f1QBmGyXlCPxA6E6dpGRdDp7IAInmuZXY3Vgfd5flWhyvgkd
         X//OHBW6xG6U2ygtoE1zG5sUswRtlTmVUh7wgcjFpWUgugryaJPWGRNKbZIXAfj10t+D
         aGl8opfgpfieT/mFKGjtZmfUc7500IEVQZawdlOTu5Y65hKfAt/vRbGrNGFIPMhk2FQd
         f2URxiWkN4W2Jm5XHRQAF7K2yMI/a2bAUz7h2Dri1WXXMFvO/3927cQZt9ObwmrdUjqD
         2CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744840231; x=1745445031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXoZG+8BCJBZs45tO0cIdxM1Q/6NDR70zQWhqtGDHF8=;
        b=n3clOFfbyIb0rLS9RAZ1UUvyi9BxFQLzpX0xcan43xrd/PQy/OF538FlCYQ+bWgqSh
         Nk78okaN8QQF+mLHKgLhoo3mLvXCAFvaSrqVq2ZpKTsgpJuK/TYRyPo39jGPBM3b4cLR
         A0JcJbVw4+upsJk6OBi50kW8KccXZo9ugaCZpkebOrNJe2dKFrGAnJ7Bwf4Id8NXkz0k
         sxy3+l8JnmbpYCZSt1Z0MFXG0cKvX3NsofeS/VKGHVNGuRo1ZgILZN330nmXWaIslNqE
         3M1n3W0vfO2mCzp3xaL1dOco+sZgW+RbJ8ZxzGURfUebIbWILmxRMz20IUbBzOn+PDU6
         i7Ag==
X-Gm-Message-State: AOJu0YzjtV/MnYxbsCVwMm9UXeJozWifAKgUgyHbdwYg2OdIrzrmCq00
	0c1QgUybWql4vyEwTibyYNR8qL+CTHIdzPnvRaoRR7VvtdixypyBLjGohX1GGOxp72vWAHpOCSo
	+dIM=
X-Gm-Gg: ASbGncv3T39z4g37e81q/lhIbuP4tSY841jQYw9qXBRqHsXI+whNZbe8yS5y7r3OkRH
	4OlFVTOoHH5MNnCqV6esNX+2BUNiTVkNeiZmY+XXPclm+U1yoF9kmOW8thZY5lttHcqqnJ0BWNT
	qp7eNwPVc3IlSdlkEzs9erTNyHv9qRbRdeIkEmy++fCmQuU1PCrdMRAeuUeMynZey+4G5KDlTVw
	1UMnkGiwsTKKwZ4Q8t7XHdTE5DYvg528qnqR4O4F6/IdrjYTq/FNTfVto8kDzhkSQrZxFBi6XhR
	pWwlnIpdjFX1OAu1z8fLcG2QGCNxjWSE03ClKZP0+7NTc/ssQpuMnlF3sw74Vkdh1KIu2PMQmxK
	wQQ==
X-Google-Smtp-Source: AGHT+IHYOBU1pdW0p3Kjah3WtBo/7Q1SKCXRP6eUlDCXObeONnnLyggnu9g7bz14otFyx8n/8hAoUg==
X-Received: by 2002:a05:6902:981:b0:e6d:fb0f:fcac with SMTP id 3f1490d57ef6-e7275f25641mr5161517276.40.1744840230696;
        Wed, 16 Apr 2025 14:50:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e70324047e8sm3814657276.3.2025.04.16.14.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:50:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/3] btrfs: simplify extent buffer writeback
Date: Wed, 16 Apr 2025 17:50:22 -0400
Message-ID: <cover.1744840038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/all/cover.1744822090.git.josef@toxicpanda.com/

v1->v2:
- Even though xarray underpins radix tree, it doesn't quite work the same so you
  can't use the xarray functions directly, so added a patch to convert the
  buffer_radix to buffer_xarray.

--- Original email ---

Hello,

We currently have two different paths for writing out extent buffers, a subpage
path and a normal path.  This has resulted in subtle bugs with subpage code that
took us a while to figure out.  Additionally we have this complex interaction of
get folio, find eb, see if we already started writing that eb out, write out the
eb.

We already have a radix tree for our extent buffers, so we can use that
similarly to how pagecache uses the radix tree.  Tag the buffers with DIRTY when
they're dirty, and WRITEBACK when we start writing them out.

The unfortunate part is we have to re-implement folio_batch for extent buffers,
so that's where most of the new code comes from.  The good part is we are now
down to a single path for writing out extent buffers, it's way simpler, and in
fact quite a bit faster now that we don't have all of these folio->eb
transitions to deal with.

I ran this through fsperf on a VM with 8 CPUs and 16gib of ram.  I used
smallfiles100k, but reduced the files to 1k to make it run faster, the
results are as follows, with the statistically significant improvements
marked with *, there were no regressions.  fsperf was run with -n 10 for
both runs, so the baseline is the average 10 runs and the test is the
average of 10 runs.

smallfiles100k results
      metric           baseline       current        stdev            diff
================================================================================
avg_commit_ms               68.58         58.44          3.35   -14.79% *
commits                    270.60        254.70         16.24    -5.88%
dev_read_iops                  48            48             0     0.00%
dev_read_kbytes              1044          1044             0     0.00%
dev_write_iops          866117.90     850028.10      14292.20    -1.86%
dev_write_kbytes      10939976.40   10605701.20     351330.32    -3.06%
elapsed                     49.30            33          1.64   -33.06% *
end_state_mount_ns    41251498.80   35773220.70    2531205.32   -13.28% *
end_state_umount_ns      1.90e+09      1.50e+09   14186226.85   -21.38% *
max_commit_ms                 139        111.60          9.72   -19.71% *
sys_cpu                      4.90          3.86          0.88   -21.29%
write_bw_bytes        42935768.20   64318451.10    1609415.05    49.80% *
write_clat_ns_mean      366431.69     243202.60      14161.98   -33.63% *
write_clat_ns_p50        49203.20         20992        264.40   -57.34% *
write_clat_ns_p99          827392     653721.60      65904.74   -20.99% *
write_io_kbytes           2035940       2035940             0     0.00%
write_iops               10482.37      15702.75        392.92    49.80% *
write_lat_ns_max         1.01e+08      90516129    3910102.06   -10.29% *
write_lat_ns_mean       366556.19     243308.48      14154.51   -33.62% *

As you can see we get about a 33% decrease runtime, with a 50%
throughput increase, which is pretty significant.  Thanks,

Josef

Josef Bacik (3):
  btrfs: convert the buffer_radix to an xarray
  btrfs: set DIRTY and WRITEBACK tags on the buffer_xarray
  btrfs: use buffer radix for extent buffer writeback operations

 fs/btrfs/disk-io.c           |  15 +-
 fs/btrfs/extent_io.c         | 581 ++++++++++++++++++-----------------
 fs/btrfs/extent_io.h         |   1 +
 fs/btrfs/fs.h                |   4 +-
 fs/btrfs/tests/btrfs-tests.c |  27 +-
 fs/btrfs/transaction.c       |   5 +-
 fs/btrfs/zoned.c             |  16 +-
 7 files changed, 327 insertions(+), 322 deletions(-)

-- 
2.48.1


