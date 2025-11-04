Return-Path: <linux-btrfs+bounces-18702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081FC330DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CF9934C446
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF93043DB;
	Tue,  4 Nov 2025 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQwlhEOV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28210265606;
	Tue,  4 Nov 2025 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291624; cv=none; b=P+zTXtaX9I370VhdqLuGae/nZL0MdZKg95Uthz5szK6ddyK9nu1S0ZQllzyaWIu0QU49feHYMhnX4/eYUvYDohFM0Nzx1A+D+KAOAL8dFlTIuLpDjy4tt097dlAqCLxFe8MR64x5B8hwllAJzDmW2lj9fk6wTAwF5TlKiS/oM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291624; c=relaxed/simple;
	bh=JWmYWw8oLvPeODrbtz6Czn3MIm9DAjL1ZgvD1ztoMx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oxx8I/Y6oAsARxrWbhKX+7eo86pcA0dbnS/gJQ9S/1Yrdhw3AMU7T1TJ4QUmr0WLkS7zG+KONOAWSpXWQVm3dGBcriSYeAoq2rCnDP8fr1aytDW/naKIhwy6Is5RMKL542r9jk5XR5xXBA85673IwLl+1wZXffwrg+ihRGsJ4ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQwlhEOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A81C16AAE;
	Tue,  4 Nov 2025 21:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291624;
	bh=JWmYWw8oLvPeODrbtz6Czn3MIm9DAjL1ZgvD1ztoMx0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CQwlhEOVOi4A0fuladyw1Vn2VZJa2YsTttvxG5miRSR6iuUqFculFhuirrKRaVlvo
	 vH/U0tqFc7mk+YrH9U6RhYZPw9AQQ69UawViegJvcCsNYElv9UHx0cCtzzAl7duMuo
	 7n31X6oRIIIJrz0Om5NX81s8kofl0KxDuVwJH6HNmwC9qQqD8EbzZXQCCTqKJfWJON
	 b9Gc3zXXbymRoteQNS3MyziFfzDd6sRdlCnKroM7ueSG3UA7ezgqDyd0KxwavSLzK5
	 kwR7gRu3R/0rI0SMNlc8zhq8i1bqvXtGz32p7xBgC1bNXolN50z9veZKtjk7nAnWBR
	 hoafYZwb+ADVA==
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
Subject: [PATCH v4 13/15] block: add zone write plug condition to debugfs zone_wplugs
Date: Wed,  5 Nov 2025 06:22:47 +0900
Message-ID: <20251104212249.1075412-14-dlemoal@kernel.org>
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

Modify queue_zone_wplug_show() to include the condition of a zone write
plug to the zone_wplugs debugfs attribute of a zoned block device.
To improve readability and ease of use, rather than the zone condition
raw value, the zone condition name is given using blk_zone_cond_str().

Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3104fda5809b..bba64b427082 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2303,19 +2303,21 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 	unsigned int zwp_wp_offset, zwp_flags;
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
+	enum blk_zone_cond zwp_cond;
 	unsigned long flags;
 
 	spin_lock_irqsave(&zwplug->lock, flags);
 	zwp_zone_no = zwplug->zone_no;
 	zwp_flags = zwplug->flags;
 	zwp_ref = refcount_read(&zwplug->ref);
+	zwp_cond = zwplug->cond;
 	zwp_wp_offset = zwplug->wp_offset;
 	zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
 	seq_printf(m,
-		"Zone no: %u, flags: 0x%x, ref: %u, wp ofst: %u, pending BIO: %u\n",
-		zwp_zone_no, zwp_flags, zwp_ref,
+		"Zone no: %u, flags: 0x%x, ref: %u, cond: %s, wp ofst: %u, pending BIO: %u\n",
+		zwp_zone_no, zwp_flags, zwp_ref, blk_zone_cond_str(zwp_cond),
 		zwp_wp_offset, zwp_bio_list_size);
 }
 
-- 
2.51.0


