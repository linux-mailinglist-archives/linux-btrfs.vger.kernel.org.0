Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1F3F5138
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhHWTYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhHWTYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:11 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1CEC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id ay33so8929426qkb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=haEq+oceLKT8S03Enh3GPudNLF3te/kv5vFDwKoeJog=;
        b=bgQBSDETl0ZlKL1kAh0s9SaDMnnh/lXtDbZ18Dhl+xxVbXjd8xSwq9at7scC/OTxDe
         qWXvIvg9P3O5nqYee7WAtoK81AMgkOWJ/SvR4TuudnGVVaup9UnnVvzGALOz+zSkgXCv
         S9krPKfkCCXwq7z0FqjYeKcoHxB4jCFuYtu2J9fNSnwcT4TOXP+K0D3GVUrSFW0m99Gr
         LyWf1t0Oc9WJhD85RhcsjqAi8ug+1CJbL/yLU5H5NCV1w1TinBDJhPM4vihOUPPA1RGT
         HEDRMTPEs7KTKP4p/9Y5lfZeVHTwqy7PGGeu/iOSGbARyLEdyeVvA+F5ouKReO5lCrk8
         +L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=haEq+oceLKT8S03Enh3GPudNLF3te/kv5vFDwKoeJog=;
        b=C1dHsyn9VN61L9YfVkoS4qfln6R+buNQhAxKBm0/F2g4i6R0tYuD0LTuyY8IJHixAd
         HUM5gJGJauZlI8pt+yW7b7a7hhYYVgpa+oSS6Xm2kGzC6ToCsLm/KFmYBJMkC0U6j4sM
         PdAGI1A0+fy0pKPf47oLhpnkZos++6vNRKQqIApdG2d3s7MFOSCaqeVSjXZqwRTlD7/r
         x+7Q+FmxTjs5xX9CNiCRXDf03tmzK2c80gmuIhmLeed4PQ0oDdR6/3GnCFUjQoRdbYy/
         p5xsDsC77HQKRSESXqGHCoNuGbyhlIFjdL578fj2CM5NPwy7rQjbT8HC6LEu5U8ZLi0a
         R5Vg==
X-Gm-Message-State: AOAM531Suf52gkMUdLsCVzzbixeGnGl18XesB6xeQpoK0udVFKiTxN4Z
        yd+8i/P+Tpgi/6keSAr/qO0glZvS4siwKA==
X-Google-Smtp-Source: ABdhPJz//BYSqv0hcasu3geX7PywDpL5PWuIOmmMz2GPcvwBzjuJfab6yrYvSTAjKrYz/3ff7KKPVA==
X-Received: by 2002:a37:652:: with SMTP id 79mr22966452qkg.197.1629746607092;
        Mon, 23 Aug 2021 12:23:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 21sm9138758qkk.51.2021.08.23.12.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 6/9] btrfs-progs: check: detect and fix problems with super_bytes_used
Date:   Mon, 23 Aug 2021 15:23:10 -0400
Message-Id: <e2eeab5354051cf5125cd98254dc8121a0da0f37.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629746415.git.josef@toxicpanda.com>
References: <cover.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not detect problems with our bytes_used counter in the super
block.  Thankfully the same method to fix block groups is used to re-set
the value in the super block, so simply add some extra code to validate
the bytes_used field and then piggy back on the repair code for block
groups.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/check/main.c b/check/main.c
index 6f77b5ff..19d1c153 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8660,12 +8660,14 @@ static int check_block_groups(struct block_group_tree *bg_cache)
 	struct btrfs_trans_handle *trans;
 	struct cache_extent *item;
 	struct block_group_record *bg_rec;
+	u64 used = 0;
 	int ret = 0;
 
 	for (item = first_cache_extent(&bg_cache->tree);
 	     item;
 	     item = next_cache_extent(item)) {
 		bg_rec = container_of(item, struct block_group_record, cache);
+		used += bg_rec->actual_used;
 		if (bg_rec->disk_used == bg_rec->actual_used)
 			continue;
 		fprintf(stderr,
@@ -8675,6 +8677,19 @@ static int check_block_groups(struct block_group_tree *bg_cache)
 		ret = -1;
 	}
 
+	/*
+	 * We check the super bytes_used here because it's the sum of all block
+	 * groups used, and the repair actually happens in
+	 * btrfs_fix_block_accounting, so we can kill both birds with the same
+	 * stone here.
+	 */
+	if (used != btrfs_super_bytes_used(gfs_info->super_copy)) {
+		fprintf(stderr,
+			"super bytes used %llu mismatches actual used %llu\n",
+			btrfs_super_bytes_used(gfs_info->super_copy), used);
+		ret = -1;
+	}
+
 	if (!repair || !ret)
 		return ret;
 
-- 
2.26.3

