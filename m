Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F0E6BB8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfGQLgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 07:36:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:1951 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfGQLgi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 07:36:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 04:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="319286219"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2019 04:36:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 783D340E; Wed, 17 Jul 2019 14:36:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/4] uuid: Remove no more needed macro
Date:   Wed, 17 Jul 2019 14:36:33 +0300
Message-Id: <20190717113633.25922-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717113633.25922-1-andriy.shevchenko@linux.intel.com>
References: <20190717113633.25922-1-andriy.shevchenko@linux.intel.com>
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
2.20.1

