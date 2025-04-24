Return-Path: <linux-btrfs+bounces-13394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A054A9B665
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 20:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF10926DF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E22900B8;
	Thu, 24 Apr 2025 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="tys7ksps"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8028F92A
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519588; cv=none; b=jzXiFUsodqgCVY9w4sIINamdhYx490H/LdBFnm3mcOgbFulHE3pkmrMo835VPxPGLC53MzaLpe5Mact7wygdzxlTndrkOafjwAxMKWAAL2UJMZO58wlPF/k5f0tPPe4KM7dSSU5s/1r6Z3MZGQOLR/K/5sJXnKLB1YZAiujMpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519588; c=relaxed/simple;
	bh=u6lPGeLFg1uKD9A02hlxkdJcJS0zf+3u/wHEIMzi6/8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dxGonz2S4gWKecyqiyn6ZaStXNicErM1vd25PUlvkxz/U+UkZcLfpMVoiAk95gncWuiN8mjfYUyKaQRFEnxX2eIOscUQ18lyKVliZSvAeQAowMn+yhx/GsfACTlHdYro3TGoIV+qRPjhpEo2mAFcX6Yj4L3f62sKliwNodqQ0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=tys7ksps; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-7c0e135e953so152607685a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745519584; x=1746124384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpVTwcNvKQquf7yzNcXi09etrZnxbzK5LTIJcXa+VyI=;
        b=tys7kspsRPbpMaEMqA7lDkeMd156HMt86sc8EfxPCw5tOkJYQWNSWJG2JevDG/Uo1i
         0LkADDypgLZlBczQB5mjpT1ESfImTBdZAWUSrMojPGRRtAvITLEDZ1HySvnb5ChiWK0z
         zkPUskWCJjja4amSmx9egFnajm8qshNOLqbvChJNkikzvaTeHqMyminCwhLooSjbtrZg
         ncjui9HGiFN723yTlWR9haPu3lkJjqwsCi98CJAkOyT2CA2pVGQ9tYZ1MbFUo7Iz484a
         Hyy+5b0vzRc2ZTeBrIwikrtZmOjTzuKNKiu7Cc5wZEbiUshTxZVf+jkjh7evAsvvYddZ
         z31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519584; x=1746124384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpVTwcNvKQquf7yzNcXi09etrZnxbzK5LTIJcXa+VyI=;
        b=OcBGStCGIn5+PxD7SoKbFwt0YU8znCTKJ6zmWctG/7iar5E1c6F6JFZJJENFINa+F2
         tlsa5a7KMYR8IFGZRRTfOXc+KqR2A9gLS0F7DGFa8WI/XxZLU6vIXRlVF6a8RxamZvix
         e1yXAEdWnTsb0sPAtrah25L6iLJpA4c/dD5BgePUFf9DLRRVqniBMkm8LU4b9xmaDIBs
         JEiyWCR8gtG3oXw/xprSXTrbXNy8ivjLVWBtr18tJxjcWHIijHVjnbbxvd4WGeRsY/DK
         h4VBgyRizRUbilKTldnW27uFWAh7gYm9MNYeaA0/SPT4y24oYS672KQHYyyDp1OYX08U
         l9lQ==
X-Gm-Message-State: AOJu0YzgipDUyUgtnh6argWLkV0MFTNkJ+4zHCxalzGTmeYiW838e7FD
	NgNjt3hOZV840jfrXwKVa5HhtzoTvdSK88gBHEWidIz4qvJ+Oi0oNI8Yl/ChnuJ1IxcyaXDhRtJ
	6w84nBJeO
X-Gm-Gg: ASbGncvBixoZWrNHJK86kz8Vi3xHBqxAQ0wjPhlU1OJuKQY64IvXkgm2ezSS4Zm9phP
	HOgKxpruvMEXj5qdH5CPrkKVJW6V0kjVGnd1Y/pM4koshwpRUoqNJKxf4pZNPOralmjApWrh9Sh
	jEZ7LxHliQk94tZ/6M0AKf/dtIBRo1xQhullwR4inxgEzNsCRF2mnSKxqcRal34IBPbbhJvqM2B
	4T2jK2Hh1YjbRjW2o4sdt46HKV0hQa0vZmU8xfH3xItGEpP/d4iuPGOMSt0iWaeviaaMEcxrrtV
	CfH2uWJL63yFl9kL1z8+d365+YevzYtyrxco9Jj/R99+y25u0Fpn3PsuY+RzusCz5J6uRCdUdzq
	2+qNa85sb/zuY
X-Google-Smtp-Source: AGHT+IGDgF3UPOkwajMPXv9Lu8WQicJO5CFgIQorMXv0gQfX+c3aJiE40HseamgmxWE47xBUWLO1fA==
X-Received: by 2002:a05:620a:258e:b0:7c7:a6c1:71bc with SMTP id af79cd13be357-7c956f44e8cmr630484785a.43.1745519584208;
        Thu, 24 Apr 2025 11:33:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cdc62bsm118470685a.55.2025.04.24.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:33:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 0/3] btrfs: simplify extent buffer writeback
Date: Thu, 24 Apr 2025 14:32:55 -0400
Message-ID: <cover.1745519463.git.josef@toxicpanda.com>
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
  btrfs: use buffer radix for extent buffer writeback operations

 fs/btrfs/disk-io.c           |  15 +-
 fs/btrfs/extent_io.c         | 588 ++++++++++++++++++-----------------
 fs/btrfs/extent_io.h         |   2 +
 fs/btrfs/fs.h                |   4 +-
 fs/btrfs/tests/btrfs-tests.c |  28 +-
 fs/btrfs/transaction.c       |   5 +-
 fs/btrfs/zoned.c             |  16 +-
 7 files changed, 331 insertions(+), 327 deletions(-)

-- 
2.48.1


