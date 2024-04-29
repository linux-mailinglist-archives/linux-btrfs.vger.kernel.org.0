Return-Path: <linux-btrfs+bounces-4605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A08B5A2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F67B26C92
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA6173177;
	Mon, 29 Apr 2024 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="c6w2JPnl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03E6F061
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397401; cv=none; b=t0+K1ZpPkxUyIFT7GjcYFOIrkma88/zCx/HThcepOVA0TxVk6SPjqcVB4W0+2oP3kmuXaq2OgS1xdRvCvRvpYQuU85Nl0mBoQUkfo7sYfjErQj0QNPXa85rkz1w1X6/48fAAGh5huPUDJznTmO1Gb5tM+jbvwvYS2OQiRXWgRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397401; c=relaxed/simple;
	bh=YGbDPi0JuDlU0hgLtxPiEPepBwlaJupeGP3H60dU4cg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vf78gSk4Qoi7Vs5peIYUpZB0WuFcVW9gy0jeCDKXKxEweE4T98WEf6Ow4iMJJ8xSyHLUDtvfn/0bnRD7Jw8me8AcxWSRJv8L1n6hHGhbgVFLLzbG7NFbTYE3Pn4qzOHSQTxXLWOPuS1z+ciTVVEV8e5mesbQ//F2mUILmDLD3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=c6w2JPnl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43a317135a5so35826531cf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397398; x=1715002198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/RFmZaq/0kMptzjzbqc1Lm9EPYN2ceZgwlM7sZe9EE=;
        b=c6w2JPnlYjaD9xfqaeRojxtgpe5HL0kyxAfl4VVq03s76+38F7WIE36Zi79UZylR5y
         DPLo6Tc/S/+1Xc4m1gBw+Bd2vPrqFYKPvk+eDUjU4rNgpayXPd9b6fjApJTHBT44m7KY
         z7j9/bv+sfMqLDZSuBKiPfTiGQvHrtUha+vQpCNDcNOro1+561qyzXXHdi7IWCppcJPS
         CvWNgRSg/n6TNAGH3jAS4rSnzUWQAJVAhhl3BPjjV7A7YfePVWicDDEOSEApZBBWtVYb
         GcPbclfpWJ8q1iC1QGKOlvcCNRsvwRmyLWUCp5nKzjPtb3eYchPEuLOn6JiQVZni4x7Q
         punQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397398; x=1715002198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/RFmZaq/0kMptzjzbqc1Lm9EPYN2ceZgwlM7sZe9EE=;
        b=ZT6mMcO7RyOFvFLVMB75k1YC73acxeanExT5/iNrTKgvO1WgGzrPDW3iJ6Q0c5nVEg
         GpSoVawdKwqmalEoecQQlPRlr0SIynTccN9TcQaDFQXWg3VYPnZIrB3JV3XWsMVJ6Uon
         DkCEPmDmBQxoUxp64KqKLIzxkpiI9/S6mKGTnxGBVUT1xVdq0Dhl7/cr8jy6Ywh0LmJ/
         Ed+eYR9Vsh457roOP5k6ffS1HZu0j5UF9R2mraj6JrUMyB0vWTCqzpLKapW6mXYUV7OQ
         NNRtEr2e+SErI6e6EHMlSiVFNgcadpfX9NWmDfGtJ/Blso11V0SQfdw6KM3VeDkvDllO
         KscA==
X-Gm-Message-State: AOJu0YzWzz1hztRyWIhVqci5uUhsA/+zJ6+OiRftOUMc/pT+kg3+rhxS
	QtVayrjU0yHnJP8AUqRqQp6L5VnbRKZ2i+nmIekTPfB1ul0d65VQPs0hdoqfS8OtR1EpYhgRMVw
	T
X-Google-Smtp-Source: AGHT+IGng+95vhaConYKbfVLDo4GlF5K3lPb7kqLNs0o3CvrIiVE63JjGAB3t642Brg10vVip8z47A==
X-Received: by 2002:ac8:6f10:0:b0:43a:f50e:c7e6 with SMTP id bs16-20020ac86f10000000b0043af50ec7e6mr3470884qtb.10.1714397398025;
        Mon, 29 Apr 2024 06:29:58 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w2-20020ac84d02000000b00435163abba5sm10363602qtv.94.2024.04.29.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:29:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 02/15] btrfs: remove all extra btrfs_check_eb_owner() calls
Date: Mon, 29 Apr 2024 09:29:37 -0400
Message-ID: <5bda8e7bb4a93c39c3af31e0a7b62a7191aa572d.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we have a handful of btrfs_check_eb_owner() calls in various
places and helpers that read extent buffers.  However we call this in
the endio handler for every metadata block, so these extra checks are
unnecessary, simply remove them from everywhere except the endio
handler.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   | 7 +------
 fs/btrfs/disk-io.c | 4 ----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1a49b9232990..48aa14046343 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1551,12 +1551,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 		if (ret) {
 			free_extent_buffer(tmp);
 			btrfs_release_path(p);
-			return -EIO;
-		}
-		if (btrfs_check_eb_owner(tmp, btrfs_root_id(root))) {
-			free_extent_buffer(tmp);
-			btrfs_release_path(p);
-			return -EUCLEAN;
+			return ret;
 		}
 
 		if (unlock_up)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e0bdf3ed2449..de71e793431d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -635,10 +635,6 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		free_extent_buffer_stale(buf);
 		return ERR_PTR(ret);
 	}
-	if (btrfs_check_eb_owner(buf, check->owner_root)) {
-		free_extent_buffer_stale(buf);
-		return ERR_PTR(-EUCLEAN);
-	}
 	return buf;
 
 }
-- 
2.43.0


