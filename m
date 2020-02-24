Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8A16AA45
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBXPh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:37:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:19218 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgBXPhz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:37:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 07:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="260374554"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 24 Feb 2020 07:37:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BA74E252; Mon, 24 Feb 2020 17:37:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/4] uuid: Provide a GUID generator for raw buffer
Date:   Mon, 24 Feb 2020 17:37:50 +0200
Message-Id: <20200224153752.35063-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com>
References: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com>
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
2.25.0

