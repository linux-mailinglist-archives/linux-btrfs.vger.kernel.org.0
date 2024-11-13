Return-Path: <linux-btrfs+bounces-9578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B36A9C6ACA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 09:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9162E1F23434
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02FA18B48F;
	Wed, 13 Nov 2024 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CGBxiWr/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE3A175D38;
	Wed, 13 Nov 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487553; cv=none; b=oIGsX2lpKV4vYeHJzgR2JfYahh9D2DMZK/x8EU0UfGCL1Evel0x1pkTEUyb0D9nDxRUalVmNJ13WTkaKHFKMnNcNO4996juaSO9SIKkfkjQo9/gHMbe0LP+laAUQILFOP71yZcbjc02zh6AhpsXBfrRczsyAofd+jbXUI6HYsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487553; c=relaxed/simple;
	bh=qGs4eU46X52hjiF67Flo54tUniSY6aArQLkzF4HaOIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYjK1RKvqEeySZEBy5i5AV2rTf0zBp9oegCBr78+t3FiVewuSN7HFaEfjfr7MR1MbpBGCSXmN4XC2iODkal6S/b/H5BWD7nWCAhS2Nc96aICORFKB6v/nfnx1pLyVA82sbjVr5etHA8vrDuJjlQ6+rnRHcSQxMs0TQczrWMiaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CGBxiWr/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1PxjEEk41/mannGHx0Ve4FxT55xxBXXicPwWn7FNrpU=; b=CGBxiWr/8jtqVOyy84fzqcQyUN
	Thx0P/R3kU7BXN1IjX0gDDzugwxttiADFs9FY+GCtWCve3NnURQ4RyWOJummZSN9+P2ejJCB3wR5P
	A5n8LajYWXXdXQqOyOV1ll4b8YvvlKVIh7UC20cjw32VWAFdX0L4QPBKVFESNN1b52IOnbz1bUsvc
	HHY7vfwu860olEbEBHJ5FxbIXpK9tahmfLlyZ1GkeGuJ/QCmc2nG9sZL7DNwsrdgZT6EVr2zJVf71
	JvMnxHyL+TlKCQILl5dfKhL852g4wnmyFAEfwZJeulDMwWLIVQijTiKf7/Fu/0mvm9ESXrUwhLtL2
	9a2pyoNg==;
Received: from 2a02-8389-2341-5b80-9e61-c6cf-2f07-a796.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9e61:c6cf:2f07:a796] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tB90X-000000068h4-0nmy;
	Wed, 13 Nov 2024 08:45:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] block: export blk_validate_limits
Date: Wed, 13 Nov 2024 09:45:35 +0100
Message-ID: <20241113084541.34315-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113084541.34315-1-hch@lst.de>
References: <20241113084541.34315-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

While block drivers do the validation as part of committing them to the
queue, users that use the limit outside of a block device context have
to validate the limits and fill in the calculated values as well.

So far btrfs is the only user of queue limits without a block device,
and it has gotten away with that more or less by accident.  But with
commit 559218d43ec9 ("block: pre-calculate max_zone_append_sectors")
this became fatal for setups that have small max zone append size,
as it won't be limited now.

Export blk_validate_limits so that it can be called directly from btrfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   | 3 ++-
 include/linux/blkdev.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 7d6b296997c2..f1d4dfdc37a7 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -222,7 +222,7 @@ static void blk_validate_atomic_write_limits(struct queue_limits *lim)
  * Check that the limits in lim are valid, initialize defaults for unset
  * values, and cap values based on others where needed.
  */
-static int blk_validate_limits(struct queue_limits *lim)
+int blk_validate_limits(struct queue_limits *lim)
 {
 	unsigned int max_hw_sectors;
 	unsigned int logical_block_sectors;
@@ -365,6 +365,7 @@ static int blk_validate_limits(struct queue_limits *lim)
 		return err;
 	return blk_validate_zoned_limits(lim);
 }
+EXPORT_SYMBOL_GPL(blk_validate_limits);
 
 /*
  * Set the default limits for a newly allocated queue.  @lim contains the
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 65f37ae70712..cd905afaf51a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -948,6 +948,7 @@ queue_limits_start_update(struct request_queue *q)
 int queue_limits_commit_update(struct request_queue *q,
 		struct queue_limits *lim);
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
+int blk_validate_limits(struct queue_limits *lim);
 
 /**
  * queue_limits_cancel_update - cancel an atomic update of queue limits
-- 
2.45.2


