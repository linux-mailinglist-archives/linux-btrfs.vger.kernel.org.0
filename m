Return-Path: <linux-btrfs+bounces-13161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54112A93825
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 15:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6928246594D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 13:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A413790B;
	Fri, 18 Apr 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OsEumgqB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FDD82866
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984652; cv=none; b=CdC7dDI0Ug2uIsnKLD3mlmo0bBMlPb5I+Y5lErqKoqGW2Ljb6Ios6UOmHbaxsYvZ7G6KTpPBpN8A/JpRINPOJV2JOZXc1+0/TrcU5pabG+63AMuJTNjGRIXB5ahGI4r2d+03QYM1GXEAbiDOBZPmCjKo/Pysiugs0oz5Ct3+qF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984652; c=relaxed/simple;
	bh=fUuU921Z01KDreCfo5bcq9QO505I716X7WKQlMpPY6A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C7OMlCg4MofLPtU73gwly70i8amUr6og6kvNrNaWFpJJXLhgKoJw9gxswd1XvWnuyOXAZziSGNxdL+bb0Lir6U7t2sU86f0nhZP/Etwv7oKbNlwCoeESPAYaLKo/rrBKDUmGhzDpOU2PZLGVonvvlL/C6RSEeZ0GzoUE+sNWiwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OsEumgqB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff37565154so16921367b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744984648; x=1745589448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TIunA4ELvEEnYfIYm45LyWHh/mp9hEXFMnGfesmvWOA=;
        b=OsEumgqBvg5toQBgE+sH++re7fTVeJYj2eZQEBdr/WOnI2qSZdwnQhig/eSnW1upBG
         XcUfnmKYnUVvaTw14Hq+oLV9CIdCOCD8FkFgkO0WWJfAeu8qaPnIOm75stnlFFQ9ndGZ
         Po+dLuzdvn+ggEuVgw1luwMviBOXyQeQi/VnTI7eOxAcKD111oC93CyeTyl5akv9WXQG
         x4bwAhCWMyn2y/OnHTUPEHfYIUgZNWauE2RU+BFu/C8r6x/iO36VpmncBVuRv7jtI634
         Bh+fXDNXmOX7tIngC2EaJDEv0Def0aa9k8FpGVdYxTY7Vy4bpdNVDtqPMsWnRwWkt3Mm
         r1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744984648; x=1745589448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIunA4ELvEEnYfIYm45LyWHh/mp9hEXFMnGfesmvWOA=;
        b=KxqDE81Ogs9uAdzp00/VOrd6y7mdmdpD8wp15c3EtVSAIoiavl/SHHsAPeAfHGS9mC
         umZ4QBpOKOD6XLIKy50ylzW6s378npEvfCwa+MkfRt93LVmRjWbWcKbZZmeRffdGmT1L
         2t4jvue47zDmFsrMOtyJApRT0knNSMZyDSvZ22QGvC/95rcsyv+NkOtD9kx6akJbkymL
         2/TSq5XSHasv93rt8DSwp17aMdAB5F1hHzpiycdxPJuTIOO+1eG7d92TUZRc8mL80Bzq
         /dL+bJ6+RO0ZzW3D1pZ6ikGT9r1uQJIfJU82zo2naDiA+OhLATPIxbwmCHtmHb9Xn3EE
         fVAQ==
X-Gm-Message-State: AOJu0YyCLBNkySmnANCsWNWmyb36Z+yKS3V5vconvTAOGbY9Iw3UFQVc
	sxNxTwmyHnQiZtJwK/a0cxJRxPjzJkE3P+8FTQ8vbN2GjnMz3xAqC3TiVXGRPXuxzgSsaSzKpS2
	d
X-Gm-Gg: ASbGncutrjhP3E4IRBpiSKlCbjNOcU5ujjZHpPwm5yyYfp072cdHjHFZkrDgRwv+BhX
	fKj6/oqAO2Ogk/MvYzLY8ykOZcHyCf+myZOKI1wi+ahRkzWv+BlBUYI5gp9P2+jn3RU9qj55su/
	qGJW010gwLiiluObg8P9pHVtQSRxbnLrfqlKRnLQY3R2KPxT2vZGtrqtTNY7Wg6b9AvwYs3O7qv
	PLc9Mf4LWFHbpsjADS9TpkpFF/LuxHYLhW4MekIuabKJCzJ7YzVPiuTHHnoQk68yPrpR+2nmlu4
	WuvkNYPoKNzqB0E3UDiui6Wk5ulkccbkgpJu8fIs2D+GX1vMhPS9Eubps/yTXt0sjbq9i2sVZrF
	JkQ==
X-Google-Smtp-Source: AGHT+IEeGZmfDGqckB6IePp+Rwz4vyPJafPclRHPdTfDT9xO0kzDfJ+nvG0rJLi2vbsGpQ+XWHAtrw==
X-Received: by 2002:a05:690c:350f:b0:6ef:77e3:efe6 with SMTP id 00721157ae682-706cccfa80amr39315537b3.13.1744984647989;
        Fri, 18 Apr 2025 06:57:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca45099fsm5229007b3.16.2025.04.18.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 06:57:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 0/3] btrfs: simplify extent buffer writeback
Date: Fri, 18 Apr 2025 09:57:20 -0400
Message-ID: <cover.1744984487.git.josef@toxicpanda.com>
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
 fs/btrfs/extent_io.c         | 581 ++++++++++++++++++-----------------
 fs/btrfs/extent_io.h         |   1 +
 fs/btrfs/fs.h                |   4 +-
 fs/btrfs/tests/btrfs-tests.c |  27 +-
 fs/btrfs/transaction.c       |   5 +-
 fs/btrfs/zoned.c             |  16 +-
 7 files changed, 327 insertions(+), 322 deletions(-)

-- 
2.48.1


