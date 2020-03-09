Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445CF17EB3B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCIVdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41782 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgCIVdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id b1so5299995pgm.8
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxYA4f0TuPQvGE8I8jGJR/1USh/D4L87np7YSieLKvw=;
        b=o5jlimRF/5SO3LREAA0ogBcStk92LjU2DTqaAHN1ruKrk33PUUNqPDjCiGZ9hl8zGe
         2HXw7zMVSbZC7HgMUXG/eRTv5yeGWTdjd/B8N+hz2LoG2jGY3UVHiYwHFM7Mdx0Brxd7
         eK31EdmoXPsC5tXAN/5gZIb2ysqTTGaoMHrHumxopUX8Ad3mNH7T7YKph/UuFWR5Hyr0
         DHAmMCBJaKexmzx9S3edPr1l42agJEAtSO5Z+gItT7DPFBWz/xe9s5S3BmIjuZqnU1Kb
         nIbfKV1SMsUkGrVgMRTDrAn2gdN/IrXWQvwHUtVS5s0lVXDyLEkZC+fbYtlf3QdD6EoU
         MywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxYA4f0TuPQvGE8I8jGJR/1USh/D4L87np7YSieLKvw=;
        b=V5pr6EpjnNA8hTqY67Z8iqDsmXRxvELo/AalSF+RyrDoXIfVAG7VQM7zwUdU4qkUXo
         wN8Bn1HBk+x/MMMPx/t8oZ64PKPvMCnA3zmH3JauEq4NDjp6yTKPlZoHLDGjQ6Fc9mJF
         s7Dy2+SSkSzoHU0KjqN5opKLBWnsbQWWzhy16gbh7w5AQ3Zm735TE47ZP4PGTOgPcRYe
         S6kCTz5CMa5Y+MxQHXNV0VbzYCiuWKHetyktpRxkjTezjQjMU6K0o9T0NyXce4+3LZYO
         wmpRfYTLU1b18dFY/JETpfzd5D7ALBnY3hVv9s4aZuyrx3Y8YSEkXtNGefSCHPArpZXR
         rg/A==
X-Gm-Message-State: ANhLgQ22vs9w/0tCW/3Vnax1C8OD+Wlh5nYCuwWxxbu2gENjj0gP+0kC
        fbWP6CQik+gXD3dD7xGyKc+gHRhn2CM=
X-Google-Smtp-Source: ADFU+vsS8C9I71toE89a9e1pIehBuDOyFNzJKIrXL40iWn/qEQmyNgLse6qqFccsAwU3ppw1RrEy9g==
X-Received: by 2002:a63:d10c:: with SMTP id k12mr17348081pgg.392.1583789578991;
        Mon, 09 Mar 2020 14:32:58 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:32:58 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/15] btrfs: don't do repair validation for checksum errors
Date:   Mon,  9 Mar 2020 14:32:30 -0700
Message-Id: <b1ab11a92dceaff04ca6269689584c7ab9045674.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The purpose of the validation step is to distinguish between good and
bad sectors in a failed multi-sector read. If a multi-sector read
succeeded but some of those sectors had checksum errors, we don't need
to validate anything; we know the sectors with bad checksums need to be
repaired.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 279731bff0a8..104374854cf1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2640,8 +2640,6 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	bool need_validation = false;
-	u64 len;
-	int i;
 	struct bio *bio;
 	int read_mode = 0;
 	blk_status_t status;
@@ -2654,15 +2652,19 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 		return ret;
 
 	/*
-	 * We need to validate each sector individually if the I/O was for
-	 * multiple sectors.
+	 * If there was an I/O error and the I/O was for multiple sectors, we
+	 * need to validate each sector individually.
 	 */
-	len = 0;
-	for (i = 0; i < failed_bio->bi_vcnt; i++) {
-		len += failed_bio->bi_io_vec[i].bv_len;
-		if (len > inode->i_sb->s_blocksize) {
-			need_validation = true;
-			break;
+	if (failed_bio->bi_status != BLK_STS_OK) {
+		u64 len = 0;
+		int i;
+
+		for (i = 0; i < failed_bio->bi_vcnt; i++) {
+			len += failed_bio->bi_io_vec[i].bv_len;
+			if (len > inode->i_sb->s_blocksize) {
+				need_validation = true;
+				break;
+			}
 		}
 	}
 
-- 
2.25.1

