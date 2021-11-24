Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648A545B77D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhKXJeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:22 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32191 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbhKXJeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746272; x=1669282272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q1glLP4sT4hMYmABYjYwYRwYuJ2+Z8WPp8SZjGs2ZSs=;
  b=qeF2ereZDgysx8xy3SXkGb/8aR4w99RLzS6OMT/rDA7iEGengLq691MU
   TqJKB5GdKXtDCE0nFD2xCr0OBFQ6WFt99h864WsHS+j9nLJTAswNr+LLk
   a5R1VlsWjn8ul+ngKU2Qt/shguH60bkdoXPq3YyuqCU8Oeu3DB62pM7Dp
   4e2VHIdgTdQU60hzHxhQkoI2nvoqtz1sjq6d9uEkehqd+Mx/8u1BZLe9w
   VTU1oZKI8sgthexCorqbIlFBIkkgp3iZnSv15GxXGlRhq4b+T5P/fQnSm
   ks+eEKQMTZ/jz3ADlADvhB91mVZFK4diYxHQ/o+kgjxczRqM1t47/HNoP
   w==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499392"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:11 +0800
IronPort-SDR: jO6miHcbgQ+3MqT8d7pB5JE+OwdfnG3DcUBLuM1fyxSeSTm08gFwH0sErixuw4WdvRg9eGjDii
 NGHZ3fuI+QYDIsCy7CxlWknm9DnQbbAUuBFYpC2h2jy1zsJ445KMHV1JyELv4vLWvE1JsW7AVt
 zmlOcLgPNB9Mo+o6X2yl5iypQmERL5SY4BXY/dYfekEzZOk+51LpQqbhT/E1snIOBd6CrCA8Wi
 HHjwOeypLAeUyZAYEj/PspTU/6svBv5fiDNtpkA8bf7BPfC8GFMZ0MoIi/cXNyvSPSNsi+blMX
 cuxSqio/ZXmRMKpficDXYHyU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:04 -0800
IronPort-SDR: k1yo4ulkPrvJuNeybE05KY7Yjcak6YOinT3hHNeBULUe0vzLFGVyQnwUjPrLPiwXguXbM+M5UV
 nw2UsNIUc0GUmGyqbNdXRvRbnudm41f3rJFku17+NebHrTFzLk4BJ38k9uA7NasY0Ru38Xr/3K
 M8iLwKrNW3dIuIWH2X7o1bvDAz8N08RvW5f00TIZJA91vIABglGNNm8LCS2oNXBGOaq/am8XvR
 5jZBh9oXE4GGVc7K8XCZZaYcCAritFgQxw0/Z5v1Qb9DeoMbJhIybNxqACZmsLK3IOO1C97T1N
 ex4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:11 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 13/21] btrfs: make scrub_submit and scrub_wr_submit non-static
Date:   Wed, 24 Nov 2021 01:30:39 -0800
Message-Id: <d146a531c25f1ad1b621bb3b4db9c219181f46d1.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a preparation for moving zoned related code out of scrub.c and
into zoned.c.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 43 +++++++++++++++++++++----------------------
 fs/btrfs/scrub.h |  2 ++
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ccb74f2e75b92..e8fa305f71a10 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -204,7 +204,6 @@ static void scrub_remap_extent(struct btrfs_fs_info *fs_info,
 			       int *extent_mirror_num);
 static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 				    struct scrub_page *spage);
-static void scrub_wr_submit(struct scrub_ctx *sctx);
 static void scrub_wr_bio_end_io(struct bio *bio);
 static void scrub_wr_bio_end_io_worker(struct btrfs_work *work);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
@@ -1626,7 +1625,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		   spage->physical_for_dev_replace ||
 		   sbio->logical + sbio->page_count * sectorsize !=
 		   spage->logical) {
-		scrub_wr_submit(sctx);
+		btrfs_scrub_wr_submit(sctx);
 		goto again;
 	}
 
@@ -1638,7 +1637,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 			mutex_unlock(&sctx->wr_lock);
 			return -EIO;
 		}
-		scrub_wr_submit(sctx);
+		btrfs_scrub_wr_submit(sctx);
 		goto again;
 	}
 
@@ -1646,13 +1645,13 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	scrub_page_get(spage);
 	sbio->page_count++;
 	if (sbio->page_count == sctx->pages_per_wr_bio)
-		scrub_wr_submit(sctx);
+		btrfs_scrub_wr_submit(sctx);
 	mutex_unlock(&sctx->wr_lock);
 
 	return 0;
 }
 
-static void scrub_wr_submit(struct scrub_ctx *sctx)
+void btrfs_scrub_wr_submit(struct scrub_ctx *sctx)
 {
 	struct scrub_bio *sbio;
 
@@ -1989,7 +1988,7 @@ static void scrub_throttle(struct scrub_ctx *sctx)
 	sctx->throttle_deadline = 0;
 }
 
-static void scrub_submit(struct scrub_ctx *sctx)
+void btrfs_scrub_submit(struct scrub_ctx *sctx)
 {
 	struct scrub_bio *sbio;
 
@@ -2053,7 +2052,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		   sbio->logical + sbio->page_count * sectorsize !=
 		   spage->logical ||
 		   sbio->dev != spage->dev) {
-		scrub_submit(sctx);
+		btrfs_scrub_submit(sctx);
 		goto again;
 	}
 
@@ -2065,7 +2064,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 			sbio->bio = NULL;
 			return -EIO;
 		}
-		scrub_submit(sctx);
+		btrfs_scrub_submit(sctx);
 		goto again;
 	}
 
@@ -2073,7 +2072,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 	atomic_inc(&sblock->outstanding_pages);
 	sbio->page_count++;
 	if (sbio->page_count == sctx->pages_per_rd_bio)
-		scrub_submit(sctx);
+		btrfs_scrub_submit(sctx);
 
 	return 0;
 }
@@ -2125,7 +2124,7 @@ static void scrub_missing_raid56_worker(struct btrfs_work *work)
 
 	if (sctx->is_dev_replace && sctx->flush_all_writes) {
 		mutex_lock(&sctx->wr_lock);
-		scrub_wr_submit(sctx);
+		btrfs_scrub_wr_submit(sctx);
 		mutex_unlock(&sctx->wr_lock);
 	}
 
@@ -2281,7 +2280,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		}
 
 		if (flags & BTRFS_EXTENT_FLAG_SUPER)
-			scrub_submit(sctx);
+			btrfs_scrub_submit(sctx);
 	}
 
 	/* last one frees, either here or in bio completion for last page */
@@ -2335,7 +2334,7 @@ static void scrub_bio_end_io_worker(struct btrfs_work *work)
 
 	if (sctx->is_dev_replace && sctx->flush_all_writes) {
 		mutex_lock(&sctx->wr_lock);
-		scrub_wr_submit(sctx);
+		btrfs_scrub_wr_submit(sctx);
 		mutex_unlock(&sctx->wr_lock);
 	}
 
@@ -3048,9 +3047,9 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 						logic_end - logic_start);
 	}
 	scrub_parity_put(sparity);
-	scrub_submit(sctx);
+	btrfs_scrub_submit(sctx);
 	mutex_lock(&sctx->wr_lock);
-	scrub_wr_submit(sctx);
+	btrfs_scrub_wr_submit(sctx);
 	mutex_unlock(&sctx->wr_lock);
 
 	btrfs_release_path(path);
@@ -3063,9 +3062,9 @@ static void sync_replace_for_zoned(struct scrub_ctx *sctx)
 		return;
 
 	sctx->flush_all_writes = true;
-	scrub_submit(sctx);
+	btrfs_scrub_submit(sctx);
 	mutex_lock(&sctx->wr_lock);
-	scrub_wr_submit(sctx);
+	btrfs_scrub_wr_submit(sctx);
 	mutex_unlock(&sctx->wr_lock);
 
 	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
@@ -3233,9 +3232,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		if (atomic_read(&fs_info->scrub_pause_req)) {
 			/* push queued extents */
 			sctx->flush_all_writes = true;
-			scrub_submit(sctx);
+			btrfs_scrub_submit(sctx);
 			mutex_lock(&sctx->wr_lock);
-			scrub_wr_submit(sctx);
+			btrfs_scrub_wr_submit(sctx);
 			mutex_unlock(&sctx->wr_lock);
 			wait_event(sctx->list_wait,
 				   atomic_read(&sctx->bios_in_flight) == 0);
@@ -3464,9 +3463,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	}
 out:
 	/* push queued extents */
-	scrub_submit(sctx);
+	btrfs_scrub_submit(sctx);
 	mutex_lock(&sctx->wr_lock);
-	scrub_wr_submit(sctx);
+	btrfs_scrub_wr_submit(sctx);
 	mutex_unlock(&sctx->wr_lock);
 
 	blk_finish_plug(&plug);
@@ -3778,9 +3777,9 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * changes to 0.
 		 */
 		sctx->flush_all_writes = true;
-		scrub_submit(sctx);
+		btrfs_scrub_submit(sctx);
 		mutex_lock(&sctx->wr_lock);
-		scrub_wr_submit(sctx);
+		btrfs_scrub_wr_submit(sctx);
 		mutex_unlock(&sctx->wr_lock);
 
 		wait_event(sctx->list_wait,
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 3eb8c8905c902..8d17fac108556 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -48,4 +48,6 @@ struct scrub_ctx {
 	refcount_t              refs;
 };
 
+void btrfs_scrub_submit(struct scrub_ctx *sctx);
+void btrfs_scrub_wr_submit(struct scrub_ctx *sctx);
 #endif /* BTRFS_SCRUB_H */
-- 
2.31.1

