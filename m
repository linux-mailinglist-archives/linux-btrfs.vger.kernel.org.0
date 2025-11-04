Return-Path: <linux-btrfs+bounces-18620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FABC2ED68
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9961A4F8BBB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C52258EEA;
	Tue,  4 Nov 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKoIYPIS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261B225A3D;
	Tue,  4 Nov 2025 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220173; cv=none; b=ncfvAKTqxeDaUz73IPn8qyzR8k/MuWDRVlM5new6r9xFOVn5hDCwdrMU7+ur8XfVhGVI0MjfvvUAMPZTuov6BmLQkjE/00IteAJMlyHdVOnmS/DYe+33uOXOyVZFmxuTVcXlGD9ZO4OmsN0rWj5J+rmh5I+aGToh2nzFggOSeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220173; c=relaxed/simple;
	bh=3XYBGkzqttaT+ciE+Af6N6/imfqeeydh9/goSdG+2ZU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgjwWjthjrQkFErNgmgjzCUtGEfntPg3EVkSkc7DYiUtmoiIdX3Y6jQeh1tNU2QZWFmK+9dRuIobPV6K2gBPHQGKW5Vo5BgPSc8owGSX4AwvcSNAn0k2iwRVQ2zy7/6pbMoqJ+q/UsMciTrJMZTshaQcYTK4NqQhIBTfTc4T8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKoIYPIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9125AC113D0;
	Tue,  4 Nov 2025 01:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220173;
	bh=3XYBGkzqttaT+ciE+Af6N6/imfqeeydh9/goSdG+2ZU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TKoIYPIS2z8xXEJAeeMi4CafBnxmPoXX5KSzH5Lsl2vH6tgxnu24TkAvsEmPASeCN
	 vnM3M6YzG1cCjTkOVxVDj64c+r9YxUHOJO3AU/qADG8Qe3+dM04XMGeypSv7WGL96Z
	 6FIjvYr8BIsxKVj7xxqfdVH2/y+D0QAwQ1GpDoYCxZbhf2+IgXPxztF0scN2E+j5rk
	 QLalEvgpaMHTp/ci096TB9+J1rC6nZ+WprD4Cexpt4WFwO8rRSrMoZTXiG6lXKyqNu
	 A7Ra7holVxQgkzZ/xD8SF/zKjNAIOiCPgzvyhtuTib1dK/Z9pJG/5+Rua7xhgxDl9e
	 ETC8Rzkrbk3hg==
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
Subject: [PATCH v3 13/15] block: add zone write plug condition to debugfs zone_wplugs
Date: Tue,  4 Nov 2025 10:31:45 +0900
Message-ID: <20251104013147.913802-14-dlemoal@kernel.org>
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

Modify queue_zone_wplug_show() to include the condition of a zone write
plug to the zone_wplugs debugfs attribute of a zoned block device.
To improve readability and ease of use, rather than the zone condition
raw value, the zone condition name is given using blk_zone_cond_str().

Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 2180d5256f9f..bf6495f0d49f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2295,19 +2295,21 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
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


