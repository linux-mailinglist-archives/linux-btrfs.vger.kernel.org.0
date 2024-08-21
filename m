Return-Path: <linux-btrfs+bounces-7365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F2F95A251
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB48D287245
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F6214EC7F;
	Wed, 21 Aug 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Z3eMAEF5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9B136E09
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256129; cv=none; b=j6yEjFMf6zkhtvgDa3+mBtR+JoTQxcGH1z8uGIk6yr+cV0kCFQZNfuNegKluwgSMptqwxNdcdkh6+N9QmvCEs4RUVKQmw/HOON8MfMQmeesFmZmdv1MQM6cWAn8H7IpwxvTduvK78n54jcxAeD4mdRhLanzjuWxxFqwWWbKGXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256129; c=relaxed/simple;
	bh=XBip5Y/NNBEkywcE6KZU7V+D52S7tnohNwd4WhbYMZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rA28ysIniZTnhu3Xjx4cKg1JziV/FjfvxT02AkXA0WZsQS3xGXXMrb6zuZAz9BvE3dBbulv2TRWakz1G6fipD4HUVEz+J75a0ygskNsamHJBr+qKfD5rVTORYHD6K43nKttOZKht2hEBcUevaS/aZqHVk2so12Fv070woKCjP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Z3eMAEF5; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e026a2238d8so7107538276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724256126; x=1724860926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7dpHbb8WQoB01X/8K4OundUOrmDFWOwYySNKwJSWeU=;
        b=Z3eMAEF5V60+aV7aAg1fUg1EwvU7ecXi/zyYIjiKymQAc1Vx0Y2D0WbebP6haxL3/f
         60erXrBvikLxKV74Ag3JyTlFFJaeoTKX3DoG++GlEprKW5gSTFyAZhsihg1NE//sORdF
         lqc/rQYRN2VmeyyO9xvHInOlPzkCwZEK8ig2xldJKKkR4nYlcqd/AzHx3wcTcDnAkv+9
         XlUe01q9GCfYDKKuyJKF7p4XLJPJY1HgIFz74b29cwOMHVb2FTu2EFcvB0Jv2f6wZ0T2
         4r6dSZHtwLi/ekm9lySik6yAii24GcjnjLBRlX/8f4RjnKhITfULjM2B7C1hCuBODCWb
         JHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256126; x=1724860926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7dpHbb8WQoB01X/8K4OundUOrmDFWOwYySNKwJSWeU=;
        b=OP1P2q8tv4Gha0CzdObPuhhTFCgIRpn4lhMXp2xHTkJRrRRkXnFrGkp4G//TRltQU6
         RyGnHTSxuyis0ya5iEzd8fjgy+OwHXTHbt92ftAtWIsefeWbR+JOV7NWKq3uYVDA3MTT
         gOJ/GHvgI+K77BKw0GzpVi0RSxFivuvEeRnaFEFOMLFTOax3w8TJsjW+dvhxn+IjfQjL
         JEOaJq4LyuqeG2dLW4Xnd2fXVxfKpQ1bOAfjeF/YHZ+dPsDE5z+P51C+z/6zncY+UqGb
         IrURCNK3GHCdEvX2ApqfVQLuT6qs073qRnhC6HdpQS/ectgiRFzukGB3txyYKMKdqhjb
         RS5g==
X-Gm-Message-State: AOJu0Ywkkjmo+dN9NTk7Zhqp8Jx8Fs652X6sHdP2G/IhG9vDK170bg06
	W+LErbBgX4kyu9NOwVCiyRCxiEEh3doOb0NZF33T4xTcrnqX5+I9BwDJiP2M7oozWlj2CDum58s
	d
X-Google-Smtp-Source: AGHT+IEQ9tRC5vWdBIXbduVX1Mbh5Z3NIsbvixhFNS3NVC0iGyVUCfdfWZILYqYwlKWAVLPuunek5A==
X-Received: by 2002:a05:6902:2602:b0:e0b:c50c:e26a with SMTP id 3f1490d57ef6-e166553a936mr3432897276.35.1724256126336;
        Wed, 21 Aug 2024 09:02:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e6fee1sm3080689276.33.2024.08.21.09.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:02:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/3] btrfs: no longer hold the extent lock for the entire read
Date: Wed, 21 Aug 2024 12:01:58 -0400
Message-ID: <cover.1724255475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

One of the biggest obstacles to switching to iomap is that our extent locking is
a bit wonky.  We've made a lot of progress on the write side to drastically
narrow the scope of the extent lock, but the read side is arguably the most
problematic in that we hold it until the readpage is completed.

This patch series addresses this by no longer holding the lock for the entire
IO.  This is safe on the buffered side because we are protected by the page lock
and the checks for ordered extents when we start the write.

The direct io side is the more problematic side, since we could now end up with
overlapping and concurrent direct writes in direct read ranges.  To solve this
problem I'm introducing a new extent io bit to do range locking for direct IO.
This will work basically the same as the extent lock did before, but only for
direct IO.  We are saved by the normal inode lock and page cache in the mixed
buffered and direct case, so this shouldn't carry the same iomap+locking
reloated woes that the extent lock did.

This will also allow us to remove the page fault restrictions in the direct IO
case, which will be done in a followup series.

I've run this through the CI and a lot of local testing, I'm keeping it small
and targeted because this is a pretty big logical shift for us, so I want to
make sure we get good testing on it before I go doing the other larger projects.
Thanks,

Josef

Josef Bacik (3):
  btrfs: introduce EXTENT_DIO_LOCKED
  btrfs: take the dio extent lock during O_DIRECT operations
  btrfs: do not hold the extent lock for entire read

 fs/btrfs/compression.c    |  2 +-
 fs/btrfs/direct-io.c      | 72 ++++++++++++++++++++------------
 fs/btrfs/extent-io-tree.c | 52 +++++++++++------------
 fs/btrfs/extent-io-tree.h | 38 +++++++++++++++--
 fs/btrfs/extent_io.c      | 88 +++------------------------------------
 5 files changed, 111 insertions(+), 141 deletions(-)

-- 
2.43.0


