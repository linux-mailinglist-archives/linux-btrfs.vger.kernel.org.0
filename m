Return-Path: <linux-btrfs+bounces-18701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12235C33106
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FA384E495F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063B2FE561;
	Tue,  4 Nov 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNYWDjD5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72561265606;
	Tue,  4 Nov 2025 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291622; cv=none; b=X/RaVv978aH9/3FzG3RD6zz47ewSkTYmSSYx6Beuu8jyge0qpbY0rdmA2s7QP1mbwniWHjyRTYRcHWNZYICyAn1rbLzGYDb9ZN9XkxXphl4ISlc7061EPkZvBENqUWSIaPzZXZ7tl3NE9+j+l+F6P1FpzVnhuOlCUlIyDqG6Yy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291622; c=relaxed/simple;
	bh=/CCHDJbVJ3PWgu3hj3rkfqxctPOjN5sAFJlgZQdPyDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBid70M+OvUdhictrTbhXLgtLp/FBkdOTCX5kNCKrI1kDP8xiCHYsVVGOOry1D+Oeeoyepw0F6ViDQA3sqifhMj2PEBPhdDrLaQjkhTQpN57K1Lk4xGIbfiJYM6MnzpRVx/Z+XFq0fmiSERE+koBoSsqFBiKYsaCSRHy7PfRKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNYWDjD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51272C4CEF8;
	Tue,  4 Nov 2025 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291622;
	bh=/CCHDJbVJ3PWgu3hj3rkfqxctPOjN5sAFJlgZQdPyDs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KNYWDjD5H4LcgGeWXJ1yzM5k5fDQ7bBBihkDlSr4g+erlPrmiGFMrbn9nkVkIijRW
	 5T9Sro7r9CJaUiedryV/MpHwyzNFWO2JHFXHhPekGJDiVtG9t+bbAuRDPnACWvaC16
	 DfsFR7LN5xUj0anCuJEC2hRCQwDn//uUnokwEIAcsKlBDnKGsEO8QsTan/kr8fl5xi
	 HWxXJtEIIg9/fVKd2Ix0iL7z0ev86pMIWte/maX1eKrRRPW487xzvCF20tjzeyZz8k
	 7xw6dr4ae7fkVG5gcsnEr4Z/AD1hicIT5oWCHAPPuYzONVH40sUL6h/pwn072xgSUs
	 e0YoUamNLGoiQ==
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
Subject: [PATCH v4 12/15] block: improve zone_wplugs debugfs attribute output
Date: Wed,  5 Nov 2025 06:22:46 +0900
Message-ID: <20251104212249.1075412-13-dlemoal@kernel.org>
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

Make the output of the zone_wplugs debugfs attribute file more easily
readable by adding the name of the zone write plugs fields in the
output.

No functional changes.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7a7b0704f095..3104fda5809b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2313,8 +2313,10 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 	zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
-	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
-		   zwp_wp_offset, zwp_bio_list_size);
+	seq_printf(m,
+		"Zone no: %u, flags: 0x%x, ref: %u, wp ofst: %u, pending BIO: %u\n",
+		zwp_zone_no, zwp_flags, zwp_ref,
+		zwp_wp_offset, zwp_bio_list_size);
 }
 
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
-- 
2.51.0


