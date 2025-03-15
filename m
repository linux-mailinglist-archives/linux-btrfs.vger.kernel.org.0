Return-Path: <linux-btrfs+bounces-12304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58524A630A0
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD173BA0D8
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10398204694;
	Sat, 15 Mar 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="KnXF5An4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F43F1F8736
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059434; cv=none; b=D9ww5xhL3Pg54WMiIgM3Myp+qvVLkYg5FVO2qZ/RXmuoANnLnAEosVoLpCq4qjMkw043dOcWVBTjmziMKQlVp833M88ToYCZybDyil84mD7v2gBE1sO6s6GFZDyQqGAo5jDUnh6t7mtMUpHexGW/cpkFp2GwcfB7eaPlATAUvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059434; c=relaxed/simple;
	bh=eMiVf6KfqTI5zgd9NGL4oAR5xBqRGI9Xup1XAQCrP2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=al4A0jPAYAN+yv0AMh8k7eixkexzlzssl3Z2hdhDZTz7sH/98GHpHX4GlF0oJ9yIApleQQxZkIS9zBNi+i0DnM8kXKXaLzUseEGNqX1bUwliZNC5pCLof9r2Yp1+uQbmY3quZ7J7aFdB5L6BfWSjFfp+S6VnyC7NRsi4yE6Yo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=KnXF5An4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225df540edcso29566965ad.0
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1742059431; x=1742664231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fOkW6M/g6NHBx2eUo/ctcQ4zIQwQjQgCpK4kWc44uQ=;
        b=KnXF5An4RS51ew0LlHVxKsUl7Q407I0m5pdTa7iXaAVYxayN/lE+EdAfU+voTmSl3V
         qin08og7qFH4OYTMoDJfsNZhTkouGOICu/YBj4ucUVQu3MkmlgnPlPFoYQ9cExhJwIpM
         iKHQ54+bJoiCaVwla7QpgZEIuiKi6LhWE4S86gPXThoiT7heDYgTLdAflxijcjOjdRC/
         SRC+VzmZg9vUDJ6pKUiwye70cMDXYkHO1jTG42OVk41Hjr7QbapclXk1TtOVAcf/RDIy
         mfb6BHl9EVKTBBgkCyttJupi3Z+cKrEHJa5YdGTqT9WoorEq3T0woK0Ltfkh67DtDE6t
         50fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742059431; x=1742664231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fOkW6M/g6NHBx2eUo/ctcQ4zIQwQjQgCpK4kWc44uQ=;
        b=Px9Bn9JbpvXUOq5H5x4ik7QZwX+chaTFW1J1xkuspDdu5LMjzkZvpHHFYC3kPEdvpx
         ni13mvS89U6wqqY1+BKYsYdDhiNfOW1vDKmTjb0XzSehzYDKe+zDaGTX6kxxbYEz3C+C
         9pOxmg6k6fOpM3aU4L6i54XliDEpB9QEbBbE8mAjLLWBeogT4b1kjCDsN3Ys3Bd2fWOh
         07i5W/dGMFTR8+H/W4YbffZGY6rK7xNBIoIMXy9vQeV2T3xn0uJsDaRq6vRTIXG4VBsF
         gsm4YuGo3yJ6cLnPJ0xCIk/fplscaq9Huc8mZPs0TM+sv0OsJKc1D/O95y+TozYplC//
         qPxQ==
X-Gm-Message-State: AOJu0YyJXjUTe0UrlmsRnK8QayKvF7SUPYzWHJScnGp+zIF7uEQE7uyU
	aPUU/N7es7SIgAHomqhPlO4kfKkJyc2BA1f5so9dqJND6doZAZ6lRLx/em6h6Bw=
X-Gm-Gg: ASbGncsqLbpne8tbRFapa8b1uNfwCYSvlh79xyZvR8b4fwUeJwCOKCcpcoMcc1CM50l
	fBerR9k7FIeVHDYicpJzU/me4PWTwe8bwIy+yLxdO9ru8CdSZZ2qn1KRuBO2lZKhvATTvBm8tV4
	6BndyWSUSPjKKHp8pAXPONqDAxtHwyjSAMBjOtD/qyYXiflOwgcH7O9QRAAw5bnsdKbwxRQMUJG
	WlxnAlDpDuO3oDWVBhZweUPNaRAFHd4PHTzuPSoToN7aWzPV0olVJkFLWjVgf/E0jWahEy30eS8
	llk0YBymKmCzdwsh/yzTJVbZGatlXNHKR4o22gdCFw==
X-Google-Smtp-Source: AGHT+IHKTM3f6+ScrhlzObjxpZKu4z2AtYffjEWvQjvgTGHXpcQR1TE6tL40+vpAUTLVL9K0i9NNag==
X-Received: by 2002:a05:6a20:4388:b0:1ee:c7c8:cae with SMTP id adf61e73a8af0-1f5c2864feamr8994248637.9.1742059431366;
        Sat, 15 Mar 2025 10:23:51 -0700 (PDT)
Received: from sidong.. ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115512f0sm4673013b3a.49.2025.03.15.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 10:23:50 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 0/3] introduce io_uring_cmd_import_fixed_vec
Date: Sat, 15 Mar 2025 17:23:16 +0000
Message-ID: <20250315172319.16770-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patche series introduce io_uring_cmd_import_vec. With this function,
Multiple fixed buffer could be used in uring cmd. It's vectored version
for io_uring_cmd_import_fixed(). Also this patch series includes a usage
for new api for encoded read/write in btrfs by using uring cmd.

There was approximately 10 percent of performance improvements through benchmark.
The benchmark code is in
https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c

./main -l
Elapsed time: 0.598997 seconds
./main -l -f
Elapsed time: 0.540332 seconds

v2:
 - don't export iou_vc, use bvec for btrfs
 - use io_is_compat for checking compat
 - reduce allocation/free for import fixed vec

v3:
 - add iou_vec cache in io_uring_cmd and use it
 - also encoded write fixed supported

Sidong Yang (3):
  io-uring/cmd: add iou_vec field for io_uring_cmd
  io-uring/cmd: introduce io_uring_cmd_import_fixed_vec
  btrfs: ioctl: introduce btrfs_uring_import_iovec()

 fs/btrfs/ioctl.c             | 32 +++++++++++++++++++++--------
 include/linux/io_uring/cmd.h | 15 ++++++++++++++
 io_uring/io_uring.c          |  2 +-
 io_uring/opdef.c             |  1 +
 io_uring/uring_cmd.c         | 39 ++++++++++++++++++++++++++++++++++++
 io_uring/uring_cmd.h         |  3 +++
 6 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.43.0


