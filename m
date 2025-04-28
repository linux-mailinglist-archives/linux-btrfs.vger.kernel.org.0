Return-Path: <linux-btrfs+bounces-13462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B64A9F3D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D59A3B33A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3226FD9E;
	Mon, 28 Apr 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="esKBGuwf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB52262FEC
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851985; cv=none; b=epIhLQERcnB1HhXB9CxHrhvpfuetqoEx5sarBAuYnOtrDoEQTLMupvUvpxqTZgjdaLQ8tng91n8/8+QFl8UV/lKIiMkz11gmq/6vvYmGWNldtR7gJ8YOCryhzyU+L0BBMc8pu4N6KfOokJSr1yJKvJ93kqg/6nyMGbwJShbvbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851985; c=relaxed/simple;
	bh=ZV01eZm/HiInwbLs6lON7ufUG1ZjS4ezwTBji+Ym4YE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cqu1JxPCgtAu8cc7jF6HUV4BpqqPiA4wMuFS0c23riycfeYlvYK9EBf9YUB2c91cyYkxNU7/YduLP/hgFIj4YI9fS4tCNNkZIj3qGaGtSnxPAXfP5lPPhx5cTVu4v+SHnjpOt/g45f6kOD3Gr7XzXEb6p/Np6ivdD3Bhg7iFxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=esKBGuwf; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-70565ccf3bcso51354687b3.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745851981; x=1746456781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMqIG/qjEVhDw8DYf2YzvaqyWwC+dXdGl6BuU7uk7kY=;
        b=esKBGuwfmWmC/LiiYfVELROe8KRruwtP1Dd2Mc/40L+mslUH2I94EQ4v+7itljL+FW
         YiaaKb2tB/wJIltjIPhWweP/7ehkBo01V9wMXo5EdbDrimJocY5FEZXKT2Co39shFhJ1
         +tLUZ4JJYs/vA96ND8tqGLsuDohBBTGHOTgdIFygRNd7Z9cWCL015wCnyJZwEgaSs6H5
         psJ6DfEVmSCLCPKqubc3odMTQtnr6LVIaoc8U6T8Ay/Kg9FHIU9Y79AOxe98+O3vWRgJ
         chU32K+0MXeURpRaSte+I9hvsYTEPgF9RBjfK8XwtjUFnDYaqrBOC9og1EYpHyX8pZBk
         ocmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851981; x=1746456781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMqIG/qjEVhDw8DYf2YzvaqyWwC+dXdGl6BuU7uk7kY=;
        b=HxIUrA6CuBwt2J3oexNUNJ32PfWvrS3TAY+S8d6IPbuh8U/aCAdHQ/3xS69N6iE+Z0
         ms/LPaP07Mw/zBbRAHywgINhadQZ5qaD9FKAWUl9lKxTUi4mBgH0flGKTw8ISvh1y6dK
         RKKT5NCsDFPGUnro+Wjd0GZWFQqxUKcrFsVUUYtp+VPspgAdjG0cfHtMGEnkwsgo3bwk
         AfIAnj41v6u9/f/0y6aAucky6uBDG6q95gDiRjEKySaro9iGTobiicr7IMmbtMQt85Gf
         bUieXirNgwOK0Nk4JZmo8hVypAPZ39zqHYJxeS4IbBxWO6VFDfntpXmTTwdg+F4YLh0R
         NC0Q==
X-Gm-Message-State: AOJu0YyXegeyyXFGn99asm9ieSumsk0McCSof/5hPI/01BeaD3rJwYy4
	u0i8eUMuGh2klIBUrSy8lwePtyHUE9W/obdggEh1fDWjhDYDd3MmDmlK0GfFdz0FRLxwS8zxMWf
	MIKkWHQ==
X-Gm-Gg: ASbGncspptdUmmpT0MBZUJBLTCwR0nYy80NwUEgsqu7EkU7gswT6ekXj0FIrG6RkLYX
	S6itsGm9GURU8mAMSMiOYRpbkDoxan5Uxjoy/pHcWlMY4IrczGvuhSPKXBvkgwz236WtDSWsIA5
	WoJ8snaKTUETB+H1nPGBLa1cN3+fWvhgbJjbNPh/QL+FYMvhUaUEJ60AmZPqeX7g/GBF6o4hJsV
	Yyoo3Q2q70C/30x/R4w0zE+D/PqLtgy2UhZ4Ttb+J9XslrSYUdy8qJpO45n/3l68xFiNMiL3a8x
	z205nPjDchrArgXxTc+1aUNH/8RR+Yhsd5R9Am2xxIMC2b7gFUuFg9h3edtRrRnSbshWqTRsKwE
	NJA==
X-Google-Smtp-Source: AGHT+IFalpF4a5ET5e3cuL2nIMiC7tDlJ/gWpAcwidzYVlJMASsF91ro+9YcdCB6714hpzsbmC7JrQ==
X-Received: by 2002:a05:690c:3:b0:700:b389:9246 with SMTP id 00721157ae682-708541f01e4mr156724727b3.38.1745851981428;
        Mon, 28 Apr 2025 07:53:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7086e54e5d3sm11644057b3.0.2025.04.28.07.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:53:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 0/3] btrfs: simplify extent buffer writeback
Date: Mon, 28 Apr 2025 10:52:54 -0400
Message-ID: <cover.1745851722.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/all/cover.1744822090.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/all/cover.1744840038.git.josef@toxicpanda.com/
v3: https://lore.kernel.org/all/cover.1744984487.git.josef@toxicpanda.com/
v4: https://lore.kernel.org/all/cover.1745519463.git.josef@toxicpanda.com/

v4->v6:
- Finally was convinced that double rcu_read_lock()'ing is ok, removed all the
  advanced xarray usage and replaced it with the basic helpers.
- Updated the various comments, and added one for the erase to indicate what
  we're doing there since 3 of us had to read the documentation.

v3->v4:
- Adressed the various comments from Filipe.
- Added more comments to the more subtle xarray usages to help explain what's
  going on.

v2->v3:
- Fixed a where I didn't use xa_unlock_irq(), per Daniel's review.
- Changed the name of the radix tree to buffer_tree, per Daniel's review.

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
  btrfs: set DIRTY and WRITEBACK tags on the buffer_tree
  btrfs: use buffer xarray for extent buffer writeback operations

 fs/btrfs/disk-io.c           |  15 +-
 fs/btrfs/extent_io.c         | 576 ++++++++++++++++++-----------------
 fs/btrfs/extent_io.h         |   2 +
 fs/btrfs/fs.h                |   4 +-
 fs/btrfs/tests/btrfs-tests.c |  28 +-
 fs/btrfs/transaction.c       |   5 +-
 fs/btrfs/zoned.c             |  16 +-
 7 files changed, 319 insertions(+), 327 deletions(-)

-- 
2.48.1


