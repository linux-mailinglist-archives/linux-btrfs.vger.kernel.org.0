Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268D3697E76
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBOOeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBOOeI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:08 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F3F392AF
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471647; x=1708007647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/oYWgvLRe6h3xVTHAWcQzQ9KLDOuCczBrh6j4HxEJ7o=;
  b=Wf11cIr8oVgpVI7AZRNHXRiBtQVBnNenk3r9tW7MRhdSk6KgYhBb9tc9
   l/OVVatYoy0FbNrevYjAfVxILef9BsYvLNrxijKB17ydgonva0ltcMR7m
   QpWWYsk7O0VlldtGFwxaXqadqsurcx3H2CStMZqeT0p9TWF4rUrDYV6+t
   AjIY3k0uNxWLeRYMbfSzjHU4KMBCvIJ6NmUzMxK8p0WlCNayzsIvkcMvt
   HXBJOaBUmARqQgU9gvkiAflQxcemtksN81fBVDPEj+aBoLyvYItKpG/Fk
   gtsHvNsyvSQNq8W7Hb4v0JNNoWLJFy7lvufVfgakSrgVr7oSPrHa2RcsJ
   w==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394079"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:50 +0800
IronPort-SDR: VB1M/d3r/5Muaor1CJdseIu7/o9a8Bmgy67Pm+jB6YkzVtjmzFzCaD0yYyWd7HvnjnaBl7gL6r
 okwq0dV0W0T3Ng6i4HcuhKVZ2KTFk76tTeQ3zAqbITKykezJIkHNzdts4+KPRa1yPz4p014EoF
 i3EutVJvYjzYUuWVxbDkQHvE910MAROF1UXw5Ayrdb2SGweBKtN4XAyes6zzLDhTELAIghM2Q8
 OxBlFVbMwt53srXAPfTihkuFiJQm32AWSoMDmp/zdem4zLN6Ce1BQ9k0QzwwauJMdD7SYVtzak
 mVs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:11 -0800
IronPort-SDR: iLX7NFfIoE2/a3o57p+FVXhGd+FgY0/KpjAlBtVsBYraWJVIkCRQ6st5RtCjv8is49V1Rq6GwU
 N0gJ+9LQVy3FryOmeNCsPmqnaRK00g/SSVv3E0OHP1h0fqxxBhmA1op2J/1Y+oGXw3RWID6fx6
 Ig4syq7Aozs6VvtS1766rvkc5b36FVuhBIbwDg0rSQwxheYMiHK5XPdIN+UcUZw7ENoyxlaok6
 AP+eyTbfuydvUcnobuE4RLBYYpGTkoI+eI3VSrO0QAoMjnzWUMNaKESF2vVEPJAt3kE8kOYpL0
 juk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:50 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 13/13] btrfs: add raid-stripe-tree to features enabled with debug
Date:   Wed, 15 Feb 2023 06:33:34 -0800
Message-Id: <d07d3f53a0df091a2c30278cf66da6ba1002b818.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Until the RAID stripe tree code is well enough tested and feature
complete, "hide" it behind CONFIG_BTRFS_DEBUG so only people who
want to use it are actually using it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index d0d80540b32b..dd151538d2b1 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -214,7 +214,8 @@ enum {
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
 	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	|	\
+	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
-- 
2.39.0

