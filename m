Return-Path: <linux-btrfs+bounces-4234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FB48A406E
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 07:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA82A282691
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 05:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115381BF27;
	Sun, 14 Apr 2024 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Sp6YIDQ5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E5FBF6
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713073810; cv=none; b=d1lGBghedansfnndbcDD2YIEBTEE3pHUqp1d78NxxeF/xualg4GcRxdkFHTIcYj4+hf+jSQwNUWvV23IgjxgNdCOVvP4HoZbKKLCBI3O9TV2Sah43blLagN9GkQKs54zzNKkVcDBmMBo2PjvXfKxbI1O622RjuFRUcAXekVQb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713073810; c=relaxed/simple;
	bh=v95ko6+Heb952f3SY6dhY8E1pETsQFmvTr3d8rjOCac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hFqt7YOr0ir9p25/SG5gCEBxZVEmn/3s3wj4o9tjk12DvsXSE8wIsYbaZYQLzEnaYBmjQgEXGBPVHHw4f9NVy13+zmMd9rpFFCt7C0d5n+/cIx8W+XFLqDbQtCC0V6EFyrq9a6bYaZRJcs4E1yGEPGkjQSHxli5d6tvU3GivrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Sp6YIDQ5; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d68c08df7so156899285a.2
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713073804; x=1713678604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=swtumEW1uP0vmb1NsMO/J0wehpw6CfyoxB8qDjTTkZ0=;
        b=Sp6YIDQ5SgXGkLEXrLBfA4qUn/dqpdZqyPMnMx5VpWMnZ3moX06ZluUqO+xMqOoiEN
         IeoeWnPjJqUX3EkmC5iwQPcdOZQWUV+Nbhqyu18PjCqLzGNy/PZMzJjzLkDIKYlPiU+O
         1nbaPnnwbxPSo8yq5IlR3In/WacIlaXTf2+4QUjx5SaxYEI7Xx3OZwxg7qIdBQ2nwqtj
         ERS23dLJZR21hE+d4b+c/Khm1h5ZW0zU8qG4fWS71gko1HcwOuxDudApQGnLtCgBKT7C
         zr2/ypKrm76roPFhzmP3DbZw36Af3gJtilgiVb88SRxgWQcPYRRG/0DzPJu/jg7HFgaD
         YNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713073804; x=1713678604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swtumEW1uP0vmb1NsMO/J0wehpw6CfyoxB8qDjTTkZ0=;
        b=YNj2g/loeiDct0d0r2CoDH/+CNAKUkD41RNxteXUKUjZe7K3TmYV30LzigXziRl+zQ
         ZQl7d2p7i3Jkz/MzCmYpSpXsbYzBoEUA1Vhz7md3wn4AHA3LOJfLT6HEU7WsFQRAPI1w
         5rfvZ52wl+DndB4S3nsK5Sx807CErB4zu+nnmvmi52FHrvtQ+nadnlZGDAbBxPnrgioi
         4k9/xXZw+uE5QdduPxAT+AVnI/bkaDdYjPE/o6qJzY7MOI/fCkrLOvsP8kk8RrQA2UiD
         Tq7yaaG8HPCrI4s5CGYDPt4Flex4sSSkuE3xpIxpUUS/3W2e//p1XLJZCs47OFYSGTz2
         DMRg==
X-Gm-Message-State: AOJu0Yyr+cDynJy80UHwXpdpDUY3nBb0xvlZIv1oHFZugaG5YL9jafYC
	6FVUf2mg4gltf5zDP/P1fiivSS43C6oWvEQEm6ubWDrvXUJaViCs0GgoKOuwtvRFYnc1+UMhMJW
	s
X-Google-Smtp-Source: AGHT+IFT0kdnBH5LyDqLAIZ9JogWKAXXt3RCJ5TMp26rUwtD0LaZY7L97YY4vR70WkMH68M5dIaSCA==
X-Received: by 2002:ac8:7d41:0:b0:436:92d8:77dd with SMTP id h1-20020ac87d41000000b0043692d877ddmr7804322qtb.63.1713073804521;
        Sat, 13 Apr 2024 22:50:04 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bp36-20020a05622a1ba400b00436a8ee913csm2291928qtb.41.2024.04.13.22.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 22:49:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: set start on clone before calling copy_extent_buffer_full
Date: Sun, 14 Apr 2024 01:49:50 -0400
Message-ID: <5062a746cf151bfbc217c00e149740956e748abb.1713073723.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our subpage testing started hanging on generic/560 and I bisected it
down to Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during
fiemap to avoid re-allocations").  This is subtle because we use
eb->start to figure out where in the folio we're copying to when we're
subpage, as our ->start may refer to an area inside of the folio.

We were copying with ->start set to the previous value, and then
re-setting ->start in order to be used later on by fiemap.  However this
changed the offset into the eb that we would read from, which would
cause us to not emit EOF sometimes for fiemap.  Thanks to a bug in the
duperemove that the CI vms are using this manifested as a hung test.

Fix this by setting start before we co copy_extent_buffer_full to make
sure that we're copying into the same offset inside of the folio that we
will read from later.

With this fix we now pass generic/560 on our subpage tests.

Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap toavoid re-allocations")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 49f7161a6578..a3d0befaa461 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2809,13 +2809,17 @@ static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *p
 		goto out;
 	}
 
-	/* See the comment at fiemap_search_slot() about why we clone. */
-	copy_extent_buffer_full(clone, path->nodes[0]);
 	/*
 	 * Important to preserve the start field, for the optimizations when
 	 * checking if extents are shared (see extent_fiemap()).
+	 *
+	 * Additionally it needs to be set before we call
+	 * copy_extent_buffer_full because for subpagesize we need to make sure
+	 * we have the correctly calculated offset.
 	 */
 	clone->start = path->nodes[0]->start;
+	/* See the comment at fiemap_search_slot() about why we clone. */
+	copy_extent_buffer_full(clone, path->nodes[0]);
 
 	slot = path->slots[0];
 	btrfs_release_path(path);
-- 
2.43.0


