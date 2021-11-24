Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590C445B77A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhKXJeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:19 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhKXJeR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746267; x=1669282267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jfc/KCErquPyexUWVZVcZY6iL3KXxJrEE+HDGDRKcw=;
  b=CcsN2HdyHi3XDA1ZhcMDe1t2uezFmONiTY5PZ5gH0IR5l6byhUM5yUUt
   NmMIEDMmKwKyHGMlgUUicDwhFo4f1QQmaEn+iQkf7xecd/IRWcatOJESk
   UtgXsDbQP4giDxYNeX0jSEwd643feijJoWwgNVnJII1JD5isjZLLznz2r
   QYI9O4Srx+A04cGSWaVj404cizh/bBQ9XGhLKsAKpsDYujJhjV96H/ZKP
   DwopNLTflkd990kNADTOtpaErHzKol3Pp6258Bgo/VR3asDJPIEmwGiB/
   zZb2VqE021yi6QHlDAV8Wth5rN5SmxFZ/7zy5jYF1GBG5OsGow+jrFHPP
   g==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499385"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:07 +0800
IronPort-SDR: Ji63bjVabtHiX8tEOuTJxI8G54JkTDN70n5AMgxTryBfEycMgUNaL74D0Q62rBAvu0eFZZw/7S
 vU69VTvYx2fq8WKpaGEq/n1JSVEpMZ/vUxKcJhLOd89YGZbNK9+6VlyzsEb/kxlUIhIP/Jc/o+
 zT3CA+qeDXUk5R8tQU7uBoyR65s8Dw+XIYDVmqh+APscULxkiX1j3S2AVEnUvVDNZt2O6MVPnd
 hyordezCgrXXTCvF9X11NtfrAZgBg3YhaEuPuYUVpVAf8pqdnCgrfiyIfFLgb7aWR+MEqO8hWG
 IbD1vUmTFQOIasH5ZgZ2iL0D
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:00 -0800
IronPort-SDR: a6jYCxwZN9DSH98a23W4x/Ro1xqI7cH1Fs708RQCRrfc6i5Md52tJ4ZCXvAu6/C7ZhaUijfvVJ
 shAfpCBCGa8yMuuECYRKjWjGYndfnkN1QENUKFEHHgjh4e9R4VUXi/rp3NCGFry5NObto9kqug
 X6C2lhBmfh7FoX95Q+t4Ni6VEvksyjxcvV8iq/xYQzR+YFuTyp8HDjJOeVsUDXaP1MyeNEPIbf
 QBCS75LDQyrrRlmHr+r/mSjNd+APkJyNDUvaB7C6fEFIpLdhyrYHbp8bktI4FmBLR9dfUUbVKO
 5mg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:07 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 10/21] btrfs: move struct scrub_ctx to scrub.h
Date:   Wed, 24 Nov 2021 01:30:36 -0800
Message-Id: <c120d508b232845c70d4c5378c12b0152d7d700e.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move 'struct scrub_ctx' to the newly created scrub.h file.

This is a preparation step for moving zoned only code from scrub.c to
zoned.c.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 44 +----------------------------------------
 fs/btrfs/scrub.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 43 deletions(-)
 create mode 100644 fs/btrfs/scrub.h

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 70cf1f487748c..a2c42ff544701 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -21,6 +21,7 @@
 #include "raid56.h"
 #include "block-group.h"
 #include "zoned.h"
+#include "scrub.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -46,7 +47,6 @@ struct scrub_ctx;
  */
 #define SCRUB_PAGES_PER_RD_BIO	32	/* 128k per bio */
 #define SCRUB_PAGES_PER_WR_BIO	32	/* 128k per bio */
-#define SCRUB_BIOS_PER_SCTX	64	/* 8MB per device in flight */
 
 /*
  * the following value times PAGE_SIZE needs to be large enough to match the
@@ -151,48 +151,6 @@ struct scrub_parity {
 	unsigned long		bitmap[];
 };
 
-struct scrub_ctx {
-	struct scrub_bio	*bios[SCRUB_BIOS_PER_SCTX];
-	struct btrfs_fs_info	*fs_info;
-	int			first_free;
-	int			curr;
-	atomic_t		bios_in_flight;
-	atomic_t		workers_pending;
-	spinlock_t		list_lock;
-	wait_queue_head_t	list_wait;
-	struct list_head	csum_list;
-	atomic_t		cancel_req;
-	int			readonly;
-	int			pages_per_rd_bio;
-
-	/* State of IO submission throttling affecting the associated device */
-	ktime_t			throttle_deadline;
-	u64			throttle_sent;
-
-	int			is_dev_replace;
-	u64			write_pointer;
-
-	struct scrub_bio        *wr_curr_bio;
-	struct mutex            wr_lock;
-	int                     pages_per_wr_bio; /* <= SCRUB_PAGES_PER_WR_BIO */
-	struct btrfs_device     *wr_tgtdev;
-	bool                    flush_all_writes;
-
-	/*
-	 * statistics
-	 */
-	struct btrfs_scrub_progress stat;
-	spinlock_t		stat_lock;
-
-	/*
-	 * Use a ref counter to avoid use-after-free issues. Scrub workers
-	 * decrement bios_in_flight and workers_pending and then do a wakeup
-	 * on the list_wait wait queue. We must ensure the main scrub task
-	 * doesn't free the scrub context before or while the workers are
-	 * doing the wakeup() call.
-	 */
-	refcount_t              refs;
-};
 
 struct scrub_warning {
 	struct btrfs_path	*path;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
new file mode 100644
index 0000000000000..3eb8c8905c902
--- /dev/null
+++ b/fs/btrfs/scrub.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_SCRUB_H
+#define BTRFS_SCRUB_H
+
+#define SCRUB_BIOS_PER_SCTX	64	/* 8MB per device in flight */
+
+struct scrub_ctx {
+	struct scrub_bio	*bios[SCRUB_BIOS_PER_SCTX];
+	struct btrfs_fs_info	*fs_info;
+	int			first_free;
+	int			curr;
+	atomic_t		bios_in_flight;
+	atomic_t		workers_pending;
+	spinlock_t		list_lock;
+	wait_queue_head_t	list_wait;
+	struct list_head	csum_list;
+	atomic_t		cancel_req;
+	int			readonly;
+	int			pages_per_rd_bio;
+
+	/* State of IO submission throttling affecting the associated device */
+	ktime_t			throttle_deadline;
+	u64			throttle_sent;
+
+	int			is_dev_replace;
+	u64			write_pointer;
+
+	struct scrub_bio        *wr_curr_bio;
+	struct mutex            wr_lock;
+	int                     pages_per_wr_bio; /* <= SCRUB_PAGES_PER_WR_BIO */
+	struct btrfs_device     *wr_tgtdev;
+	bool                    flush_all_writes;
+
+	/*
+	 * statistics
+	 */
+	struct btrfs_scrub_progress stat;
+	spinlock_t		stat_lock;
+
+	/*
+	 * Use a ref counter to avoid use-after-free issues. Scrub workers
+	 * decrement bios_in_flight and workers_pending and then do a wakeup
+	 * on the list_wait wait queue. We must ensure the main scrub task
+	 * doesn't free the scrub context before or while the workers are
+	 * doing the wakeup() call.
+	 */
+	refcount_t              refs;
+};
+
+#endif /* BTRFS_SCRUB_H */
-- 
2.31.1

