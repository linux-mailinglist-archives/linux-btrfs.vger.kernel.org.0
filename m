Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DC06EE4A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Apr 2023 17:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjDYPT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Apr 2023 11:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjDYPTz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Apr 2023 11:19:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0006C127
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Apr 2023 08:19:53 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63d4595d60fso36335138b3a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Apr 2023 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1682435993; x=1685027993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sDizfGPh31vHWrDpTWmA+/RFWaBGqJIC3btTyfDPj6I=;
        b=JsppdLkxQ3c76lOCindl/DGYYQL1qJlqn8h2Qop2K8beCQC9O16v5GVYlrseEzu0eS
         UCHZqBdZi7U7QHAH5KS/0SR3firzJb7UnL0nZevnCj3lazNBQqCfK/3aAEVRH4Pnwy9j
         Jgv89MJ4+W5GmUCU5vDUDQg/19Dhu+pRMV+l9gmzw2reI/rydifuJU040hohpTj1p+t1
         1OvwkWZmbF272Qt6r+HjlqxFTtHUCPx/6CXRA6hCiti8D/FT0KdyLX8IOH+HQeCcKZrT
         U3SqR5g647IKfj7XuYa6J0837uSPk07LHjTpKcexAL/QqWCNrVaBRukmK2pu18vlOSob
         XhLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1682435993; x=1685027993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sDizfGPh31vHWrDpTWmA+/RFWaBGqJIC3btTyfDPj6I=;
        b=rOMTbZywFCE/TcFFrTfjaN8hHHDai0AQHiDtGY7Ms4u533FsrHwBpj4nedICmNBh2S
         SJadvIx4s8OstM2vAmJ8XpvnE1u0NDq/bUQjr8ENnmggi3cIS46u2L8Age2e3G0KiuKj
         /ZXuAcfme7osO67IizalYqNHgHms6M8FefdglfCdNvjTUaUNWjoJh5o367lCnvsu2X4C
         HiZNRDnd4frYtUXHEahXOsherMYXfNDSJANT92hJDtMe/fDlV/Oa1/PoiUBVQFdmt+Zg
         xnVJUysPqMJ91nthJNR8EMUz9L+fcSQ8+O3qoo0oy8ChElkoTRvbYWdouLpg11CKSTG6
         jiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682435993; x=1685027993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDizfGPh31vHWrDpTWmA+/RFWaBGqJIC3btTyfDPj6I=;
        b=DmOjOZHysiNtvYuFlpeEQZBw9u7chNI9uZVnjG1dRclHC1UhIWs46aHzr1lZeuysrW
         66wXjU60x+FRv4fq12VdEVHaqNTsAMsUMqcYBkKtNFnIJNEjtLwZhXlZ2HwDpKXfChm1
         8XWW9hqtbXsGCHHVu5h3kk8BV7Mb6dhF4DdiIjpnFKrqb0e2RhnIO2wqVp4LKxqZ+qrb
         L3rokD/e/2HONWln5zE+gbKimuEayv0YA8fy2Ihcf1Qum8qf7rkA7IHjSK3OBDF98s/L
         y8BBhJQNBV58MDCJ7K4UsgRxaagrfO25QJEcUpUQ2MLWaHw5PLMP3scISHAmlWUg6ekL
         4Pdw==
X-Gm-Message-State: AAQBX9dRvDJmRVBmcBxqTSl7fp2KYy8np6tJkETmIGs1GixTEjvTeMPr
        sUPpbc/LGNMZQRIH1K8M1XX30iCgNezh+KKjfpcdz2laLZOpF5u1fA9JhczB0wHadiC2EbmhOS7
        7PSelykYJc+cajrVMeBGwrJqMP2ARbe6hvVWeD/zkP08srsPpfjEUJGWTJtBi9jTbHrh5RxF0sq
        z8i6xmT/oJyqw/
X-Google-Smtp-Source: AKy350ae8nFulwDgHq+snDZjB1oMe3gbrHlRkoVmCzulUfDEWv/rSkCnawMacytkD239Zphw8lZ94Q==
X-Received: by 2002:a17:903:41cf:b0:1a6:d9a6:a9b4 with SMTP id u15-20020a17090341cf00b001a6d9a6a9b4mr21828696ple.3.1682435992579;
        Tue, 25 Apr 2023 08:19:52 -0700 (PDT)
Received: from naota-xeon.. (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm8426639plo.90.2023.04.25.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 08:19:51 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: export bitmap_test_range_all_{set,zero}
Date:   Wed, 26 Apr 2023 00:19:40 +0900
Message-Id: <327d53937163049c1b80a34bda2edb570b42aa78.1682435691.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

bitmap_test_range_all_{set,zero} defined in subpage.c are useful for other
components. Move them to misc.h and use them in zoned.c. Also, as
find_next{,_zero}_bit take/return "unsigned long" instead of "unsigned
int", convert the type to "unsigned long".

While at it, also rewrite the "if (...) return true; else return false;"
pattern.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/misc.h    | 20 ++++++++++++++++++++
 fs/btrfs/subpage.c | 22 ----------------------
 fs/btrfs/zoned.c   | 12 ++++++------
 3 files changed, 26 insertions(+), 28 deletions(-)

- v2
  - Reformat the code
  - Rewrite the return condition
  - Fix conversion in btrfs_find_allocatable_zones()

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 768583a440e1..c83366638fbd 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -143,4 +143,24 @@ static inline struct rb_node *rb_simple_insert(struct rb_root *root, u64 bytenr,
 	return NULL;
 }
 
+static inline bool bitmap_test_range_all_set(unsigned long *addr,
+					     unsigned long start,
+					     unsigned long nbits)
+{
+	unsigned long found_zero;
+
+	found_zero = find_next_zero_bit(addr, start + nbits, start);
+	return (found_zero == start + nbits);
+}
+
+static inline bool bitmap_test_range_all_zero(unsigned long *addr,
+					      unsigned long start,
+					      unsigned long nbits)
+{
+	unsigned long found_set;
+
+	found_set = find_next_bit(addr, start + nbits, start);
+	return (found_set == start + nbits);
+}
+
 #endif
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index dd46b978ac2c..045117ca0ddc 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -367,28 +367,6 @@ void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
 		unlock_page(page);
 }
 
-static bool bitmap_test_range_all_set(unsigned long *addr, unsigned int start,
-				      unsigned int nbits)
-{
-	unsigned int found_zero;
-
-	found_zero = find_next_zero_bit(addr, start + nbits, start);
-	if (found_zero == start + nbits)
-		return true;
-	return false;
-}
-
-static bool bitmap_test_range_all_zero(unsigned long *addr, unsigned int start,
-				       unsigned int nbits)
-{
-	unsigned int found_set;
-
-	found_set = find_next_bit(addr, start + nbits, start);
-	if (found_set == start + nbits)
-		return true;
-	return false;
-}
-
 #define subpage_calc_start_bit(fs_info, page, name, start, len)		\
 ({									\
 	unsigned int start_bit;						\
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 55bde1336d81..b7050a9cd882 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1061,7 +1061,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 
 		/* Check if zones in the region are all empty */
 		if (btrfs_dev_is_sequential(device, pos) &&
-		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
+		    !bitmap_test_range_all_set(zinfo->empty_zones, begin, nzones)) {
 			pos += zinfo->zone_size;
 			continue;
 		}
@@ -1160,23 +1160,23 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
 	const u8 shift = zinfo->zone_size_shift;
 	unsigned long begin = start >> shift;
-	unsigned long end = (start + size) >> shift;
+	unsigned long nbits = size >> shift;
 	u64 pos;
 	int ret;
 
 	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
 	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
 
-	if (end > zinfo->nr_zones)
+	if (begin + nbits > zinfo->nr_zones)
 		return -ERANGE;
 
 	/* All the zones are conventional */
-	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
+	if (bitmap_test_range_all_zero(zinfo->seq_zones, begin, nbits))
 		return 0;
 
 	/* All the zones are sequential and empty */
-	if (find_next_zero_bit(zinfo->seq_zones, end, begin) == end &&
-	    find_next_zero_bit(zinfo->empty_zones, end, begin) == end)
+	if (bitmap_test_range_all_set(zinfo->seq_zones, begin, nbits) &&
+	    bitmap_test_range_all_set(zinfo->empty_zones, begin, nbits))
 		return 0;
 
 	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
-- 
2.40.0

