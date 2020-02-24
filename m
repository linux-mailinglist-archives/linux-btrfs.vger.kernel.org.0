Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD16616AA46
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgBXPh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:37:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:49060 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgBXPh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:37:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 07:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="231158516"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2020 07:37:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D19CC367; Mon, 24 Feb 2020 17:37:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/4] uuid: Remove no more needed macro
Date:   Mon, 24 Feb 2020 17:37:52 +0200
Message-Id: <20200224153752.35063-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com>
References: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

uuid_le_gen() is no used anymore, remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/uuid.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 3780460a9a85..d41b0d3e9474 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -98,7 +98,6 @@ int guid_parse(const char *uuid, guid_t *u);
 int uuid_parse(const char *uuid, uuid_t *u);
 
 /* backwards compatibility, don't use in new code */
-#define uuid_le_gen(u)		guid_gen(u)
 #define uuid_le_to_bin(guid, u)	guid_parse(guid, u)
 
 static inline int uuid_le_cmp(const guid_t u1, const guid_t u2)
-- 
2.25.0

