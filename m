Return-Path: <linux-btrfs+bounces-13094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DE1A9095E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 18:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5022C446DD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87E2144C7;
	Wed, 16 Apr 2025 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QUyHv93P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F172135A6
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822278; cv=none; b=ffkzWK7BAsViOMPn/3TJfbkJXN29iMcw4jOFBYIXlKlqXj0cGBXxdTJDe6H8Pk5JBmRfUqQsssmeXtMAukwpWksdQLfQi9KSLoo5iEVLPr/IhV1mI3VbVbsANihVivTwbZ9vV7iD/AyWGFxfG5F0ntFf+sKFCsOJz8D2xhYMoxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822278; c=relaxed/simple;
	bh=FOIQJFKAtvEndkOQUFgCgEPuEXA5Q6C8CVSx2yydqI0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SESnh2AYxj6UDK1M2HKJncWDLH0k3tnZqAoWAkH0u8xQ7qCa4KR69oT+NYsT7Eile1Eid2X7U7Y8AVUQZAQCCkQtUr2XNO215dnSbpPcnhHeuMJkuiBjKd+/Sd6ZvQHeO8WBLC4mSOHdSkaClGLS+v1p4Wt5FrVM2WWkvHLcbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QUyHv93P; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef9b8b4f13so63533017b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744822274; x=1745427074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9spp8DvS2JE9D8KTU1cJyCY6yDFFq1ulf4dKAIRvjE=;
        b=QUyHv93P/nGY0kgDcO7Qsh5e/QRYMrLOcbscVC6yI5P5/dsBoIqQbHCCXW2BYJvXb6
         2qtL+9ei+PeWi/t7XKg0Pg0iFpgW+3Tw2h7thyQuiUI2xz9v3ylBhz6NdbR//qSfbgip
         KtyyL3rhVzTE1kBEp9PDtN61u/f1A/lPum+dV3OcpgWhInG5NvqPmDJUwr48gu43bPEb
         sOZHTrhA0oNIA54FTpa3XBkb3m/GwSK363C9hvGvhAvyXDfXXX1PyOrd9iFBu+hk5g++
         ZMh47qiGtDu9z25wSjFkUGlOfPGwvi2SVBtiykV8MJpKFGm2Kl9KAxuH2JqCZoQau4iY
         VIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822274; x=1745427074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9spp8DvS2JE9D8KTU1cJyCY6yDFFq1ulf4dKAIRvjE=;
        b=LwT8Xe19cEi/p4uK6UwooO9biFCdPbjmcWIdDyDlBfJaZKBVgAyFdvaezFuKsG50/I
         m8vuWvzZdftC2WDXYqzhWLeLSKocD1y8UuGxgyAfwd2h5blfEcdjtXLKa97fMdal9j7C
         ds98cK63RZCvE4hlckTyt0BwXxFsru2Sqi6E7Q7zQY6ieR9BqIa1u4egTTAWCQiMo/PC
         hftSd3C8WPvlHLa6DTk1ZWfJM9u9r2Zb8SXBF7hG18Gnq+oujs1QWLwNbXtewUuVhi+X
         oIa+BTCkTC3vrJy2lIA8GFC9OG+aqdKHcrIDJkTRVs6xNKg86nFR949EfSBFPNe6P1rX
         QVNw==
X-Gm-Message-State: AOJu0YxbheyCQKZirrXQWgP99y06ekUGQ7srinXMNqzCthSUVLfmdbbM
	tcD9rxQa60aoeXojMHghe8B1SGpXhTBrfkBUWGLXuEMzI6nBY02IF/z23xEJCtUjwFQ9m6D5Y2R
	rnLlSuA==
X-Gm-Gg: ASbGnculh2WwCz6SLgzYrDoFzuurQ8gGhNez2144nRxSzpVg89j5miBadlBzLpfVvZm
	uy/oL99ymjxbTJzZjhtU/nL6DznQwtyYulryr4PF0sbNnRU9omI4qIjwQZ09sQBXN1MCLOovcUr
	BrtFoYM1P3r42mqsmLlIAz+q6QXLXWY5S8RHv4eEBoXNVarZ8kRMSGY1g1hBZXrrSoECICF9aKj
	uTZppHGee09XvL/8PUOfw63D4f4bmVuEdkZ4qnfw4tVVZlPP+k/4Ao+jVGS8Q63tmxvkj06YYfA
	A3VxZ4oBbPhCb2RbzKZWEmqJtBirWHY7lDYKiy2IAhvmKmhFDk/ZzzjMp9rbpSElE8MX3w/FwQz
	cdgjtjha6fdcT
X-Google-Smtp-Source: AGHT+IH1Mvhh3L5ZUy4PZATB9HXY1ip7XkvUiAckWByf60rSp+/cCb87R0SES/8g24UQ7V4bAbGEaA==
X-Received: by 2002:a05:690c:6a83:b0:702:d85:59b5 with SMTP id 00721157ae682-706b338f098mr35451787b3.33.1744822273608;
        Wed, 16 Apr 2025 09:51:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e375d74sm42654317b3.90.2025.04.16.09.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:51:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: simplify extent buffer writeback
Date: Wed, 16 Apr 2025 12:51:05 -0400
Message-ID: <cover.1744822090.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Josef Bacik (2):
  btrfs: set DIRTY and WRITEBACK tags on the buffer_radix
  btrfs: use buffer radix for extent buffer writeback operations

 fs/btrfs/disk-io.c     |  10 ++
 fs/btrfs/extent_io.c   | 385 ++++++++++++++++++++++-------------------
 fs/btrfs/extent_io.h   |   1 +
 fs/btrfs/transaction.c |   5 +-
 4 files changed, 224 insertions(+), 177 deletions(-)

-- 
2.48.1


