Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423B06BB8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 13:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfGQLgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 07:36:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:32653 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfGQLgi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 07:36:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 04:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="251465351"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2019 04:36:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 65B3145; Wed, 17 Jul 2019 14:36:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/4] uuid: Provide a GUID generator for raw buffer
Date:   Wed, 17 Jul 2019 14:36:31 +0300
Message-Id: <20190717113633.25922-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717113633.25922-1-andriy.shevchenko@linux.intel.com>
References: <20190717113633.25922-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In some cases we would like to generate a GUID and export it.
Though it would require either casting to internal kernel types or
an intermediate buffer. Instead we may achieve this by supplying
a pointer to raw buffer and make a complimentary API to existing one
for UUIDs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/uuid.h |  1 +
 lib/uuid.c           | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 8e4a5000da03..3780460a9a85 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -84,6 +84,7 @@ static inline bool uuid_is_null(const uuid_t *uuid)
 }
 
 void generate_random_uuid(unsigned char uuid[16]);
+void generate_random_guid(unsigned char guid[16]);
 
 extern void guid_gen(guid_t *u);
 extern void uuid_gen(uuid_t *u);
diff --git a/lib/uuid.c b/lib/uuid.c
index b6a1edb61d87..562d53977cab 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -40,6 +40,16 @@ void generate_random_uuid(unsigned char uuid[16])
 }
 EXPORT_SYMBOL(generate_random_uuid);
 
+void generate_random_guid(unsigned char guid[16])
+{
+	get_random_bytes(guid, 16);
+	/* Set GUID version to 4 --- truly random generation */
+	guid[7] = (guid[7] & 0x0F) | 0x40;
+	/* Set the GUID variant to DCE */
+	guid[8] = (guid[8] & 0x3F) | 0x80;
+}
+EXPORT_SYMBOL(generate_random_guid);
+
 static void __uuid_gen_common(__u8 b[16])
 {
 	prandom_bytes(b, 16);
-- 
2.20.1

