Return-Path: <linux-btrfs+bounces-18612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9098C2ED42
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD35B1889B34
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA67211706;
	Tue,  4 Nov 2025 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtxmEWP/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952620A5C4;
	Tue,  4 Nov 2025 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220150; cv=none; b=LLX6SNRtnnr19y//gqavPU9BnomyBg7roqZrVGjbxgN6JaiF/fDwOLsFfv17G6zvyPEGXJlh98RmQ1K/5d4s7TgT/OKuBr/eFLOMS2mt79mK5wJnPjLbjE5H2qMjYQbOg4VW98aK1vAihtHly3kwt0atUtauHeoDz+UwM3MsW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220150; c=relaxed/simple;
	bh=IEl/o1R4ZMpbrO/F9SVsVKhT3QYFCOCgLXgkAfgAfUM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOzbUPDvmuq11rjc751Bwl5JMT9sbEpDtu/Lmcsmt+GJMZRiuL1UqQkjQhrGu0B4lv1Sus0je7aQycW2aUUzuwUKg4Cp+AGvcSuecvpsN/FLjOFEsxn7viLQKH5n6RTqBoy/I0+fSmJDQFPOYimxpskZIoioLazlPnR1D1YdBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtxmEWP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03837C16AAE;
	Tue,  4 Nov 2025 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220150;
	bh=IEl/o1R4ZMpbrO/F9SVsVKhT3QYFCOCgLXgkAfgAfUM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gtxmEWP/ngWMTFLMn/0vM5bmcpxkYhYDB53UrYiJVl5xaTuk+Qk/bYv1iwcha5mlA
	 DWHngIiaLKFkqVXIM6UFnCzXkvIL9ndBSyeFSeXcLz8jt1enq5wsm2lY4t9OLpY2CP
	 Xz2TJmdpvQLZXXMWxWLYqRQUjP/aofTbWFCadikQsoMWdCUZ7mRKTuOX6FTsMURRrx
	 //sj4V7m4x9Rv+4+9DZojMG3+RBREKZOZkaXwxD+raHjx4awTRegqNDB8AoCkX38BT
	 wowj1BXw0hUdEq/qj9DoCxi3i5FP6nOmdGpA9LrgyUk9hQtPHC60yckAtf0UeNwYwm
	 /06GAoO9FZ1KA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v3 05/15] block: reorganize struct blk_zone_wplug
Date: Tue,  4 Nov 2025 10:31:37 +0900
Message-ID: <20251104013147.913802-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize the fields of struct blk_zone_wplug to remove a hole after
the wp_offset field and avoid having the bio_work structure split
between 2 cache lines.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index de3524c17f67..d4fc87b0be6b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -39,6 +39,11 @@ static const char *const zone_cond_name[] = {
 /*
  * Per-zone write plug.
  * @node: hlist_node structure for managing the plug using a hash table.
+ * @bio_list: The list of BIOs that are currently plugged.
+ * @bio_work: Work struct to handle issuing of plugged BIOs
+ * @rcu_head: RCU head to free zone write plugs with an RCU grace period.
+ * @disk: The gendisk the plug belongs to.
+ * @lock: Spinlock to atomically manipulate the plug.
  * @ref: Zone write plug reference counter. A zone write plug reference is
  *       always at least 1 when the plug is hashed in the disk plug hash table.
  *       The reference is incremented whenever a new BIO needing plugging is
@@ -48,27 +53,22 @@ static const char *const zone_cond_name[] = {
  *       reference is dropped whenever the zone of the zone write plug is reset,
  *       finished and when the zone becomes full (last write BIO to the zone
  *       completes).
- * @lock: Spinlock to atomically manipulate the plug.
  * @flags: Flags indicating the plug state.
  * @zone_no: The number of the zone the plug is managing.
  * @wp_offset: The zone write pointer location relative to the start of the zone
  *             as a number of 512B sectors.
- * @bio_list: The list of BIOs that are currently plugged.
- * @bio_work: Work struct to handle issuing of plugged BIOs
- * @rcu_head: RCU head to free zone write plugs with an RCU grace period.
- * @disk: The gendisk the plug belongs to.
  */
 struct blk_zone_wplug {
 	struct hlist_node	node;
-	refcount_t		ref;
-	spinlock_t		lock;
-	unsigned int		flags;
-	unsigned int		zone_no;
-	unsigned int		wp_offset;
 	struct bio_list		bio_list;
 	struct work_struct	bio_work;
 	struct rcu_head		rcu_head;
 	struct gendisk		*disk;
+	spinlock_t		lock;
+	refcount_t		ref;
+	unsigned int		flags;
+	unsigned int		zone_no;
+	unsigned int		wp_offset;
 };
 
 static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
-- 
2.51.0


