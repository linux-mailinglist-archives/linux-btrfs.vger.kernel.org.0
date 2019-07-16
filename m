Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9036D6AB4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 17:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbfGPPEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 11:04:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:49677 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbfGPPEW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 11:04:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 08:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,498,1557212400"; 
   d="scan'208";a="251183689"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Jul 2019 08:04:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9242CFD; Tue, 16 Jul 2019 18:04:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Sterba <dsterba@suse.cz>
Subject: [PATCH v2 1/3] uuid: Add inline helpers to operate on raw buffers
Date:   Tue, 16 Jul 2019 18:04:16 +0300
Message-Id: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sometimes we may need to copy UUID from or to the raw buffer, which
is provided outside of kernel and can't be declared as UUID type.
With current API this operation will require an explicit casting
to one of UUID types and length, that is always a constant
derived as sizeof of the certain UUID type.

Provide a helpful set of inline helpers to minimize developer's effort
in the cases when raw buffers are involved.

Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/uuid.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 0c631e2a73b6..b8e431d65222 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -43,11 +43,26 @@ static inline void guid_copy(guid_t *dst, const guid_t *src)
 	memcpy(dst, src, sizeof(guid_t));
 }
 
+static inline void guid_copy_from_raw(guid_t *dst, const __u8 *src)
+{
+	memcpy(dst, (const guid_t *)src, sizeof(guid_t));
+}
+
+static inline void guid_copy_to_raw(__u8 *dst, const guid_t *src)
+{
+	memcpy((guid_t *)dst, src, sizeof(guid_t));
+}
+
 static inline bool guid_is_null(const guid_t *guid)
 {
 	return guid_equal(guid, &guid_null);
 }
 
+static inline bool guid_is_null_raw(const __u8 *guid)
+{
+	return guid_equal((const guid_t *)guid, &guid_null);
+}
+
 static inline bool uuid_equal(const uuid_t *u1, const uuid_t *u2)
 {
 	return memcmp(u1, u2, sizeof(uuid_t)) == 0;
@@ -58,16 +73,41 @@ static inline void uuid_copy(uuid_t *dst, const uuid_t *src)
 	memcpy(dst, src, sizeof(uuid_t));
 }
 
+static inline void uuid_copy_from_raw(uuid_t *dst, const __u8 *src)
+{
+	memcpy(dst, (const uuid_t *)src, sizeof(uuid_t));
+}
+
+static inline void uuid_copy_to_raw(__u8 *dst, const uuid_t *src)
+{
+	memcpy((uuid_t *)dst, src, sizeof(uuid_t));
+}
+
 static inline bool uuid_is_null(const uuid_t *uuid)
 {
 	return uuid_equal(uuid, &uuid_null);
 }
 
+static inline bool uuid_is_null_raw(const __u8 *uuid)
+{
+	return uuid_equal((const uuid_t *)uuid, &uuid_null);
+}
+
 void generate_random_uuid(unsigned char uuid[16]);
 
 extern void guid_gen(guid_t *u);
 extern void uuid_gen(uuid_t *u);
 
+static inline void guid_gen_raw(__u8 *guid)
+{
+	guid_gen((guid_t *)guid);
+}
+
+static inline void uuid_gen_raw(__u8 *uuid)
+{
+	uuid_gen((uuid_t *)uuid);
+}
+
 bool __must_check uuid_is_valid(const char *uuid);
 
 extern const u8 guid_index[16];
-- 
2.20.1

