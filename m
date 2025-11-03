Return-Path: <linux-btrfs+bounces-18558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DAC2C209
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083D21892606
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD94314B89;
	Mon,  3 Nov 2025 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUa638yv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E030E835;
	Mon,  3 Nov 2025 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176929; cv=none; b=j4cKFnCb2Tog0npfoMdp2hioT+iXfL1C9wxhuFA33apJMR9dDdGxP5IhtYfacRblgg4KngwiVvon2WMWfiYb1SDyQCp1l9/mQVTkmk86KhI3dFnmXnCA7+6A1KNHXXchpDXsz4OZ+L7HBj86Wfe3LqehGPhcuFKTbzp2i5VoHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176929; c=relaxed/simple;
	bh=n64XgPi0fdjsnGjaoD1g0R4/axIwKJz+qT5JsKed4pE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKW686OS/NtIkN+gl7KeJc8rtfR6u3w6QO/ExxS4Bf4yBbjtW6osjammYC2Rb3Jioh4lxww39NIc8kFzSfEZquS9sJf3+/ATWeduuOf60e2B17BlICeA+fFNuHya7f9VzFF3SD2Ju+eGYuXyFSk7ZwlBdUekalNRrsKiF3eQSlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUa638yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6B4C4CEE7;
	Mon,  3 Nov 2025 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176929;
	bh=n64XgPi0fdjsnGjaoD1g0R4/axIwKJz+qT5JsKed4pE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FUa638yvGARpy4pul/g3fDhaBDBuxhpcVuBhWLBPX+rYDdXwcRyGP20TqHWIFgHcZ
	 hDPopBAHh+Q4cmrKvgjBEO84cVASHNRzHEVB0M6uH21fXTHKqN4WqWn2VG5KAITYzt
	 aChVrAKCP4TYLddjqftJwEBJLnVzAfEuw8e/Pl16T0VioejAmj/HrqqrKaAgDCBMaa
	 X6ao7n5PQ0VFIl0SfGsFJ4wsHrxwO/Qw/+Vo3Q6MWQBPTTRBgRUHKBXgy1+2bhPEgK
	 H1ea8UYpwDIwJ+O/5TYZ/hy+UOi1m51B+8n+FUFsWprgdmILnQACw5NdJ5ybALxqDJ
	 lM7XYpB//Qe7A==
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
Subject: [PATCH v2 08/15] block: refactor blkdev_report_zones() code
Date: Mon,  3 Nov 2025 22:31:16 +0900
Message-ID: <20251103133123.645038-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for implementing cached report zone, split the main part
of the code of blkdev_report_zones() into the helper function
blkdev_do_report_zones(), with this new helper taking as argument a
struct blk_report_zones_args pointer instead of a report callback
function and its private argument.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e43ae56b19c3..6b4639f11896 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -204,6 +204,21 @@ struct blk_report_zones_args {
 	void		*data;
 };
 
+static int blkdev_do_report_zones(struct block_device *bdev, sector_t sector,
+				  unsigned int nr_zones,
+				  struct blk_report_zones_args *args)
+{
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
+		return -EOPNOTSUPP;
+
+	if (!nr_zones || sector >= get_capacity(disk))
+		return 0;
+
+	return disk->fops->report_zones(disk, sector, nr_zones, args);
+}
+
 /**
  * blkdev_report_zones - Get zones information
  * @bdev:	Target block device
@@ -226,19 +241,12 @@ struct blk_report_zones_args {
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
-	struct gendisk *disk = bdev->bd_disk;
 	struct blk_report_zones_args args = {
 		.cb = cb,
 		.data = data,
 	};
 
-	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
-		return -EOPNOTSUPP;
-
-	if (!nr_zones || sector >= get_capacity(disk))
-		return 0;
-
-	return disk->fops->report_zones(disk, sector, nr_zones, &args);
+	return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
-- 
2.51.0


