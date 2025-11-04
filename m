Return-Path: <linux-btrfs+bounces-18619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64CC2ED92
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC58189DDF9
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE425743D;
	Tue,  4 Nov 2025 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1yre24h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90C22689C;
	Tue,  4 Nov 2025 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220170; cv=none; b=XRg55Wnss2hMEUrOHwV5XHnYosQG2B/gZjNsPDa3ImAZKVL/GI5RjHYDmoembm1JhRJMIgWJz3Wk11TZoevl5Mja+3sNaWxDXmDoZy9KIR2nWZc53/xzPtyW1xEe0IKgIpUlMcCn7fozZASCM0G5NQRRTSxDC4yWVu8o9RZRMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220170; c=relaxed/simple;
	bh=ELabnKiZFe6DwArSXoHXUHbKT9aZEi5tHHUKFPxhJ7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clzfwoOdO9svGsODU81HbwdgnsxyllGR5cFnLlYBH2LsVfZEeoDze2/ylvg/m1lS+LzLIetRM6TjVp60nDNJ9Nobr9vNdZ5NEhh1NMzADgCq8ZAnwmWw/6bjfUWmA++Z2U1NWMS+F1ZqZjIUo4MIZtdZ9SgYZPad1nXliv8PEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1yre24h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6965C16AAE;
	Tue,  4 Nov 2025 01:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220170;
	bh=ELabnKiZFe6DwArSXoHXUHbKT9aZEi5tHHUKFPxhJ7Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R1yre24h9zJReqcamtttSoEXcNiu9FDpe4sxkyd/c2b1sBtcSKsRFNGeAU9Jy0FxH
	 jjEOyaNxWyjyoyuAKNKKL8Ttw1h00u/nDVr6lA2hGbXDC2CrhBBPhjnrh7OzWJ+nD8
	 yleeMKkesq7mwKyUnIPoWq47TPrLMtxl39UpGOEYvwDg4/3SBGp7DSinOpuJKOwITV
	 y0NN4D0L2NBgMdrmooGj5M41z0tQYhBFQlAVwfnci0l2Hxti3UiAOD/x2zMzBceO/N
	 4GDlBreiUfPUWvGdfDJUK5LcOPZlLHNH72SczB5THaJZxzHGim02+co5frnWToiSOO
	 vcA3wcym8u+Uw==
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
Subject: [PATCH v3 12/15] block: improve zone_wplugs debugfs attribute output
Date: Tue,  4 Nov 2025 10:31:44 +0900
Message-ID: <20251104013147.913802-13-dlemoal@kernel.org>
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

Make the output of the zone_wplugs debugfs attribute file more easily
readable by adding the name of the zone write plugs fields in the
output.

No functional changes.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ea61ad7905c0..2180d5256f9f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2305,8 +2305,10 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
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


