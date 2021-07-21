Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D35D3D0EFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 14:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhGUMDE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 08:03:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44572 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhGUMDD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 08:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626871420; x=1658407420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+AOmYnp5eWwCpHbiJveVjM12q0Aiis7WZQe+HfKdN1k=;
  b=Mf2Ucni6WB/4VfagXOb/D87rkHtOjZWzhE8pNS6pw8b4JbGXmRi4Xa0O
   WbWc6suDXxDnpl1PN5iSdATsWPmKPrLVxDt7ohbBUw0AELjIELwEz/9qP
   XRZTbx0jcu+o9qqzghWEaiDv2UP06u0zi/l5h9Or9YWZ9xXTPxmnvucs4
   g9I/vF306xeINUP3Xd6Wfca82lMrK08QUKjmw7yhai5m6T//5U4dEnCu3
   iTvgh4RJtj49fPOfFdUKbIagiFzoYQXrS+wt3mY25BIZs+cB5RwO/azHZ
   OEVIKz0Y7Lnip/5Qh15QnkZV3aUBUJsZIWlMxfuUrNewrwkjA53HxWTNt
   g==;
X-IronPort-AV: E=Sophos;i="5.84,258,1620662400"; 
   d="scan'208";a="174366712"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 20:43:40 +0800
IronPort-SDR: GCoQug1cBxEWJodie1R+kLOcuDONRUG7AnUAhM+by73Fcz0XEqCYrne4y7g56OShTsTUOXXKzM
 Uiy2rhkingLDLW/a5q4K1kXjW6Q0cosFBsgRVYPaZLHMVBdS/LX6eT2ax7JCVGrDCoE4RyUYx9
 fZ20Q7jsq20d/6T3xk6XF/Sa85iGTg/U0DRdFSaGoaCHkPxgyBMczzuZ01+C4jqXNvXNkvvEdT
 aaNjxeKkrREo88DOhFB57QSWOSs5TyMU4OuwFgPsAhRZ7Gk6uVC0cFny0Mf51AIREJBnkIds2b
 Zh3Wfaz/WNB8Q1irZVYdeAvs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 05:19:55 -0700
IronPort-SDR: RJSbz3nvaJqmgbTocMX6w3UNFHfD/f6H55O/Jr9AQm1WE3tftR2Gkl4mGKsiz885NCMIDE9wzK
 qs6ZenpakotAMjLE4IH3RRBe1PCtkfAsNKIbK7NtL+x/xE0VKD0LQJakYLDxrV1f51bx0gPthY
 RFRMq+zjgI1/S4q9ijCTJrnZAAcQ1qlv+dF1pUOOGDzjv0G9rlxJBi4Xg/yV8inZ7nrTszQE0c
 +OpClsyde+CmYVRbJLfy2Nzl3XpK/iJehHqpyh5siTGcKX2hGZ5Qf5mf5YaAc49wp37F3J6Z4N
 yMg=
WDCIronportException: Internal
Received: from my8nr8qf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.83])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jul 2021 05:43:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 3/3] btrfs: drop unnecessary ASSERT from btrfs_submit_direct()
Date:   Wed, 21 Jul 2021 21:43:34 +0900
Message-Id: <13a38aa3e4b99f11970f96a85ce0a71498ff0737.1626871138.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626871138.git.naohiro.aota@wdc.com>
References: <cover.1626871138.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When on SINGLE block group, btrfs_get_io_geometry() will return "the
size of the block group - the offset of the logical address within the
block group" as geom.len. Since we allow up to 8 GB zone size on zoned
btrfs, we can have up to 8 GB block group, so can have up to 8 GB
geom.len. With this setup, we easily hit the "ASSERT(geom.len <=
INT_MAX);".

The ASSERT looks like to guard btrfs_bio_clone_partial() and bio_trim()
which both take "int" (now "unsigned int" with the previous patch). So to
be precise the ASSERT should check if clone_len <= UINT_MAX. But
actually, clone_len is already capped by bio.bi_iter.bi_size which is
unsigned int. So the ASSERT is not necessary.

Drop the ASSERT and properly compare submit_len and geom.len in u64. Then,
let the implicit casting to convert it to unsigned int.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f60314c36c5..8cd1a4f0174a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8206,8 +8206,8 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 	u64 start_sector;
 	int async_submit = 0;
 	u64 submit_len;
-	int clone_offset = 0;
-	int clone_len;
+	u64 clone_offset = 0;
+	u64 clone_len;
 	u64 logical;
 	int ret;
 	blk_status_t status;
@@ -8255,9 +8255,9 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 			status = errno_to_blk_status(ret);
 			goto out_err_em;
 		}
-		ASSERT(geom.len <= INT_MAX);
 
-		clone_len = min_t(int, submit_len, geom.len);
+		clone_len = min(submit_len, geom.len);
+		ASSERT(clone_len <= UINT_MAX);
 
 		/*
 		 * This will never fail as it's passing GPF_NOFS and
-- 
2.32.0

