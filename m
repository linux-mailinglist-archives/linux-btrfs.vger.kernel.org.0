Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D555E7BE42F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376523AbjJIPNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376478AbjJIPNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:13:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6DF119;
        Mon,  9 Oct 2023 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864406; x=1728400406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mw29f1QIt7U37r6p+V4Yyfpi9cV1+O/PtDoSzXpXBFY=;
  b=O6L/5LimJBecOPUb4EF/dGVcLKyAGaVBau+lEDMdGu8azVl1/I/UL5iD
   S5ZtwtzDc+dDoBLUE+WV6Jict+wfwaxQLEep5Gf1Nt0C3I2Taxe/QHpzq
   h3VOqSa+jMRMWRgr+lTgPx0qPF4DdkjQz8RVra+zZxjCiE+CTvBtSDnDh
   Vqw1X8qnFRfgyp7HACSe336PGvni1ycubSRQOqvbXuVbtW0v4bR+8Kb09
   QbdyEH6lNHDJ9m5xS9iu47pIwbcVNSJjaFYGoSwYQqrOdI0icdJj1Dijt
   +5oWyygg6pCjVSswIlQufZvDmIVpymoPl28grYCa44Xq5SQlS1KtfYkRO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369232116"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369232116"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869287992"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869287992"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2023 08:13:18 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] s390/cio: rename bitmap_size() -> idset_bitmap_size()
Date:   Mon,  9 Oct 2023 17:10:17 +0200
Message-ID: <20231009151026.66145-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009151026.66145-1-aleksander.lobakin@intel.com>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

bitmap_size() is a pretty generic name and one may want to use it for
a generic bitmap API function. At the same time, its logic is not
"generic", i.e. it's not just `nbits -> size of bitmap in bytes`
converter as it would be expected from its name.
Add the prefix 'idset_' used throughout the file where the function
resides.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
idset_new() really wants its vmalloc() + memset() pair to be replaced
with vzalloc().
---
 drivers/s390/cio/idset.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 45f9c0736be4..0a1105a483bf 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -16,7 +16,7 @@ struct idset {
 	unsigned long bitmap[];
 };
 
-static inline unsigned long bitmap_size(int num_ssid, int num_id)
+static inline unsigned long idset_bitmap_size(int num_ssid, int num_id)
 {
 	return BITS_TO_LONGS(num_ssid * num_id) * sizeof(unsigned long);
 }
@@ -25,11 +25,12 @@ static struct idset *idset_new(int num_ssid, int num_id)
 {
 	struct idset *set;
 
-	set = vmalloc(sizeof(struct idset) + bitmap_size(num_ssid, num_id));
+	set = vmalloc(sizeof(struct idset) +
+		      idset_bitmap_size(num_ssid, num_id));
 	if (set) {
 		set->num_ssid = num_ssid;
 		set->num_id = num_id;
-		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
+		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));
 	}
 	return set;
 }
@@ -41,7 +42,8 @@ void idset_free(struct idset *set)
 
 void idset_fill(struct idset *set)
 {
-	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
+	memset(set->bitmap, 0xff,
+	       idset_bitmap_size(set->num_ssid, set->num_id));
 }
 
 static inline void idset_add(struct idset *set, int ssid, int id)
-- 
2.41.0

