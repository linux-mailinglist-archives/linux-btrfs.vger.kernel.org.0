Return-Path: <linux-btrfs+bounces-18446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6CC23611
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 07:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98AC189E02F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 06:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604F313526;
	Fri, 31 Oct 2025 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPTUKdy1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4C3126DE;
	Fri, 31 Oct 2025 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891435; cv=none; b=hxv2uXddU6ttCUTb9w8MF33I06OtJ03NY44Dl0wvLPXo3ArJQJ9edTTuIuuxRrtX9CzEK0wZyAOW87BYDdeDPxGYqrceKE0PcbZU2/nLe8CV/EhoD52D6i4qn6PXqZ7OOmiQ3f8f5Ijy5zl6J/JG2G7UjZLNkX/UotPUTIflqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891435; c=relaxed/simple;
	bh=AFRfC/+L9+8EqBO+j5hc4RIPbK+fIEpNfl2CvB6ilbs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EObpbWjrWRQOe/+W8kjurhxSJkv7GuXKB/wECWH1+sBCKdOqTDs8sFTjsxyHIw/bbwp972GRHQTWY9z6ii0av2D/eheB3QO9ykmJLrHlLUsdAvxlHU1v0sqXlDuDOSHfu7mDiwGXdnhJEKgqMU2/sIiiNqgRWX0dfj3t+DBn5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPTUKdy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD5FC16AAE;
	Fri, 31 Oct 2025 06:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891434;
	bh=AFRfC/+L9+8EqBO+j5hc4RIPbK+fIEpNfl2CvB6ilbs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MPTUKdy1RphP61c8KqphsqN3kuqRtta5Kfq2QnYZX5NLKLH5HoNUq/tBOpgJDJH0y
	 V1Re4wFweO5nA+uVbgWUZD9hTSw8xDQbchUjEkfLwYTmulZGpxdvbP316EPHxvuYk4
	 g21xK+qrOYi5GDpBr/HwSImAaLOQ9b9bGl3Z5cCpPaDvvwrif38/fo1FZIo4sJaaeI
	 KhQQHVa2Rd3ZiRmFosGf8RxSmRz+As1KFJtdo5GX4la7K6zDqW2JKr4oHjAWDTB3/z
	 WWKrGBll4sVmH43GTBo4xF/dERKkE7uT/X2uMDLz1Uhl43QS9B41bsIkC2sCT0Xpnl
	 asu0cumzmCIbQ==
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
Subject: [PATCH 11/13] block: add zone write plug condition to debugfs zone_wplugs
Date: Fri, 31 Oct 2025 15:13:05 +0900
Message-ID: <20251031061307.185513-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify queue_zone_wplug_show() to include the condition of a zone write
plug to the zone_wplugs debugfs attribute of a zoned block device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c8335654b1cd..1ccd78beb538 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2296,18 +2296,21 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 	unsigned int zwp_wp_offset, zwp_flags;
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
+	unsigned int zwp_cond;
 	unsigned long flags;
 
 	spin_lock_irqsave(&zwplug->lock, flags);
 	zwp_zone_no = zwplug->zone_no;
 	zwp_flags = zwplug->flags;
 	zwp_ref = refcount_read(&zwplug->ref);
+	zwp_cond = zwplug->cond;
 	zwp_wp_offset = zwplug->wp_offset;
 	zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
-	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
-		   zwp_wp_offset, zwp_bio_list_size);
+	seq_printf(m, "%u 0x%x %u 0x%x %u %u\n",
+		   zwp_zone_no, zwp_flags, zwp_ref,
+		   zwp_cond, zwp_wp_offset, zwp_bio_list_size);
 }
 
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
-- 
2.51.0


