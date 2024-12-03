Return-Path: <linux-btrfs+bounces-10019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C46189E146C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 08:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F83B23F5E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 07:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A63193403;
	Tue,  3 Dec 2024 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I/gtNnJ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9618FDAE;
	Tue,  3 Dec 2024 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211638; cv=none; b=MJSNlaidRinEcFUdKMXj2K9O6SNv8SISmxeURwt4qgw/SU2ClwaNDpgkwJxVYn2DPw7tdgLmzsoy8ZT2teroUhg+ZpwHZFTKiVYqe09KnKwp0xOH4t2EjBF+p24l8jYWRdUKcVMuzPU17pTLPb9DTLGDTwqTFGL+hW/w0H7FNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211638; c=relaxed/simple;
	bh=rYT/BZ5dcvbrsAD7eprabGPsFGXueO8aKflsxttUX28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBFvDn6+r1AYq2efJvidxo+fgd+q8306kj9FxGoL+0hEov537zl7I88nOSf6jWhzjrYmLUeHcCF5BJvms3ThDwxTh5H+VGDJlAN14kfPyGABO8Z4oH/Jq+meVuBhMTGgBvXn4vRvUvBJ56xJlowV0MaemH82quo4JC97cR1WD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I/gtNnJ4; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733211636; x=1764747636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rYT/BZ5dcvbrsAD7eprabGPsFGXueO8aKflsxttUX28=;
  b=I/gtNnJ4N77a86dpwWH1k3Q44Rp/vss0M5cTNKK2ECj36yTrM8vcZWMM
   AriCefhI8oocqioPX73uzDz2PLRVD89E6Zqo5amP31uEWRVlCkHkl6/Lg
   9QbSVITJ6pCnvnvQac/3gzll2wmNU/sgbHIH0zK34SaH6szqJg0d+numi
   ki68qiYkpe5GeA2pevNEoJqPd/JViKzshs43S46P3b9toA/7sGODIjtyi
   bi6hl+UjjCwTJAUUjPq4AZlci19KSvowmwdnNJoyBhCdIZ8IDRpJh+fwU
   FSkmTGnZszVriMUxByeyhbMZSn1PnwR3kZbmzdxh4QCaT3pHIqAF1ppja
   A==;
X-CSE-ConnectionGUID: Dm5wGI45Tqah2hrzZ/XYew==
X-CSE-MsgGUID: yJge25jqR3yNmvSPEvOtBA==
X-IronPort-AV: E=Sophos;i="6.12,204,1728921600"; 
   d="scan'208";a="33962301"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2024 15:40:29 +0800
IronPort-SDR: 674ea74a_w/hdOlMTyobnp8bSIUhA8QLF7pkm/IVD7zZZqYmSe0hvQvV
 eztDAa/l0ZeMTqOicKsu6Kq1QuO07vP9Y0hDQNg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2024 22:38:03 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Dec 2024 23:40:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH RESEND v3] btrfs: handle bio_split() error
Date: Mon,  2 Dec 2024 23:40:22 -0800
Message-ID: <964809e5e81425b0fb28bfbee5beeb99b68b9562.1733211171.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e546fe1da9bd ("block: Rework bio_split() return value") changed
bio_split() so that it can return errors.

Add error handling for it in btrfs_split_bio() and ultimately
btrfs_submit_chunk().

Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

Resend because John asked me to do so.

 fs/btrfs/bio.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1f216d07eff6..af3db0a7ae4d 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 
 	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
 			&btrfs_clone_bioset);
+	if (IS_ERR(bio))
+		return ERR_CAST(bio);
+
 	bbio = btrfs_bio(bio);
 	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
 	bbio->inode = orig_bbio->inode;
@@ -678,7 +681,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 				&bioc, &smap, &mirror_num);
 	if (error) {
 		ret = errno_to_blk_status(error);
-		goto fail;
+		btrfs_bio_counter_dec(fs_info);
+		goto end_bbio;
 	}
 
 	map_length = min(map_length, length);
@@ -686,7 +690,15 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		map_length = btrfs_append_map_length(bbio, map_length);
 
 	if (map_length < length) {
-		bbio = btrfs_split_bio(fs_info, bbio, map_length);
+		struct btrfs_bio *split;
+
+		split = btrfs_split_bio(fs_info, bbio, map_length);
+		if (IS_ERR(split)) {
+			ret = errno_to_blk_status(PTR_ERR(split));
+			btrfs_bio_counter_dec(fs_info);
+			goto end_bbio;
+		}
+		bbio = split;
 		bio = &bbio->bio;
 	}
 
@@ -760,6 +772,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 		btrfs_bio_end_io(remaining, ret);
 	}
+end_bbio:
 	btrfs_bio_end_io(bbio, ret);
 	/* Do not submit another chunk */
 	return true;
-- 
2.47.0


