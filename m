Return-Path: <linux-btrfs+bounces-8500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B198F2F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB661F22B66
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48E1AAE32;
	Thu,  3 Oct 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Ma+VlN7z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A31A7AF7
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970203; cv=none; b=GrAD0QUscEeySzy0StGpflHFK5Bbgk1+ynX7URApYM25WjJMe6ognKwc1zOOYpszI5q8UqWBwPjjXhcg9ERlTthnFmk2AMHNIVDeLjzwfn0NkmpdamWH3vJ6Ub+wnvBOB9/+Pc8VVSm9v0vG2ahvyKAYuSZhviXMZA4BzdL2s+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970203; c=relaxed/simple;
	bh=ZWAo77Cg01PM4hpmTcBlgxLPVdDt+UMKii47LVzjMZg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlMSMfyG0mTOlxC8GZaM65gTcDmrJLL0MlXTD2lHbaBxbT2XAkkgV+A5/84nTA2MA7QF84wFOxIcYc4aZYNNhxxuf7E71oxTV368C7ZIGXI0OM6W3CzbGVAgA7yDldanHTmflzY/mL/stawNv5NiZc5idEwVMShox2c6jQAgsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Ma+VlN7z; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4581ee65b46so9500981cf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970200; x=1728575000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGuzAj+AZwW5RVj2QGieSQk3YM0J+fHoDbIspTtORCo=;
        b=Ma+VlN7zDDMB2ZIj2PMQraMNFRxo6bMmLAz16OI8Rc7j6GG8UQsG+Yo6aM6oXsELU9
         HjfKOJ0cFOCmw3RB7Bm3zEpvxfRXszRJ+v9Ea/utlVzg2FtH2tY/QE9yaNMZXdqZt3l3
         wWMaZd9hQVWR24rgK1vqOgUERe+oJRKgj61D9cAUyiwGUwdl573nlg8XIxCDW25xTSfD
         vKsC+GItO6T3jZOfN3wXwTM5OzGBBd+X7kVQU1g71pfxGMh3jg1bO1fDIis0LEfv1bw1
         6duZ+g56T7DlsjJNQWsdetYUl9FAD80vh+yHZLsJ2VYzjx+G+obFXTTxFm0yhVG04Cyl
         dfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970200; x=1728575000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGuzAj+AZwW5RVj2QGieSQk3YM0J+fHoDbIspTtORCo=;
        b=eMepwG1DZRALp0u3zeCWg9VsQxFCjYGq+SxEPKoc5xteTOth+xFkz31WdRlsJ8uMrQ
         cqLDHj5cQlTd+sl00m4nlVPtqbcRVwmuKeh3yuwecbrrd8/iW47MWjQkWM0m6JSTSggF
         +uQT501UjRlDWH0jbxFdfxaHWBZx5h0rRYQ4nTzdUPClFZVljpMl26nqWP+r7pQSddfz
         t8GI7lGUCo/gF8bS3476ThsUSy0sfcxWrlnFYiS2+MZ3fxs1cTwLwgY4hF8UJ8ckeug6
         cEwBhzX5psnVt/Yl/+DL/35nz6RzrozEMoBvqTNrMrji3d5Ev898+ZPkQ1FPAMvoccVp
         rGXA==
X-Gm-Message-State: AOJu0YwKjr1Z+hChZNgs1Yvp5ATe5rWnQ5CWtCTh0rX9y9cWpDWMlk/a
	ilSOA06VyI3QQvGp9osL85iYOMOfMUJtmEvEHkctsZXqPeHCaVLxL97BzA/SZh8hJ5kQzUYrxSy
	g
X-Google-Smtp-Source: AGHT+IEJfg/yDaWiBBuwQzjF8wK4YJBRz9BhYti1cfQwan4pte3F12rdaCa708PNoVcJuEdEc/6jww==
X-Received: by 2002:a05:622a:3ce:b0:458:59bb:74f6 with SMTP id d75a77b69052e-45d80559c67mr115998771cf.52.1727970199802;
        Thu, 03 Oct 2024 08:43:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92f0262asm6579981cf.80.2024.10.03.08.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 01/10] btrfs: convert BUG_ON in btrfs_reloc_cow_block to proper error handling
Date: Thu,  3 Oct 2024 11:43:03 -0400
Message-ID: <8f6d53a745813c8267a20b1dc1caa4fb722423bb.1727970062.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This BUG_ON is meant to catch backref cache problems, but these can
arise from either bugs in the backref cache or corruption in the extent
tree.  Fix it to be a proper error and change it to an ASSERT() so that
developers notice problems.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f3834f8d26b4..3c89e79d0259 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4399,8 +4399,20 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		WARN_ON(!first_cow && level == 0);
 
 		node = rc->backref_cache.path[level];
-		BUG_ON(node->bytenr != buf->start &&
-		       node->new_bytenr != buf->start);
+
+		/*
+		 * If node->bytenr != buf->start and node->new_bytenr !=
+		 * buf->start then we've got the wrong backref node for what we
+		 * expected to see here and the cache is incorrect.
+		 */
+		if (node->bytenr != buf->start &&
+		    node->new_bytenr != buf->start) {
+			btrfs_err(fs_info,
+"bytenr %llu was found but our backref cache was expecting %llu or %llu",
+				  buf->start, node->bytenr, node->new_bytenr);
+			ASSERT(0);
+			return -EUCLEAN;
+		}
 
 		btrfs_backref_drop_node_buffer(node);
 		atomic_inc(&cow->refs);
-- 
2.43.0


