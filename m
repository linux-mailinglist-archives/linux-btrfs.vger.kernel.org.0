Return-Path: <linux-btrfs+bounces-18694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EBEC3310C
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C2C3ABD4A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BB42FFF80;
	Tue,  4 Nov 2025 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYpGvEnI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326C1A9F90;
	Tue,  4 Nov 2025 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291608; cv=none; b=R2tGRChOse1R0/DXjjDSfBzsMAwjbrkdReKZJFA3zLdjy7Z6IQZufK9QyDAMEeg5wOSkCCIJMmUggoagGHw0EqzQqwugt0BCTMnVB/C3ejk/F68Rp6dyvY07QVY1utohnV4GfoHrHuMs8I9eI2HPxqTv8HMgmp8ihGIs4DY60s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291608; c=relaxed/simple;
	bh=2EfCk3eYpYsd2FRAsj4V2+AIABRSzPxnsTzWZwJoh/A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqhxV9RbtklltfIEwgyKLIucdEJ9SQYijnXKnMbhFWRKDGipEs6aixcIdJSlBJW2T2cIJjBAfNWCGAEA0tsR+x9wJ3ALS3mhmu1a1jSrPBs1JPJVFQMZaRRuxteHG6A928x2P0acub2LaHv3Km4OT1Gnw+rjl9Tl+EbPgouuvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYpGvEnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED6FC116D0;
	Tue,  4 Nov 2025 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291607;
	bh=2EfCk3eYpYsd2FRAsj4V2+AIABRSzPxnsTzWZwJoh/A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OYpGvEnI7hpjwpl9tKrVQ3TIVkgWggDHeZdrkuOYCTRznpYBESn0NLGhwlN8LCQGP
	 YjulCmiRj5lRiNqCN15nnSqDvPDcr1nV1MxhDXpuGHa8apgh6Cd8Uiyzpw+gL3vPce
	 s/yAY+7wLZoKyPaRnCt0yl/lNrtkJF7tFklvTqpyoGMuNWVzggK2EYpo3skJsVgx78
	 y9B6I57Kd7AI2zvegFixbH+Bj3rsvvVnckEDhBYY0ULkcSg9+4F3o7jKZx4Wply0xH
	 DmNl+J0hS91SrcYCfI6AaTBUWCZWfaq9JeOfJk+z588+IVp4I58QTLibmr0ro+c2/y
	 IDflLpAfVNo0A==
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
Subject: [PATCH v4 05/15] block: reorganize struct blk_zone_wplug
Date: Wed,  5 Nov 2025 06:22:39 +0900
Message-ID: <20251104212249.1075412-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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


