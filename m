Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7733330CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 22:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhCIVWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 16:22:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:60761 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhCIVVw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 16:21:52 -0500
IronPort-SDR: kb2KjBP6Zlhv/wu7311KlRETGLSymZFVw6L/lLQIMkwIa4ZHAVfZvr/frK7Kj+hwirUa5ciYwF
 XCLDh1cmnSZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249698113"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="249698113"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 13:21:50 -0800
IronPort-SDR: DZHac8nRvPxZ4s8fABJrstCU7clqI57Eh+j7MKulxeGFSlLyq0h7Am51PRgQTPeESnFm99kgGQ
 0aukMtcCbysA==
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="509424712"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 13:21:50 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/highmem: Convert memzero_page() to kmap_local_page()
Date:   Tue,  9 Mar 2021 13:21:36 -0800
Message-Id: <20210309212137.2610186-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210309212137.2610186-1-ira.weiny@intel.com>
References: <20210309212137.2610186-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The memset() does not need to be performed atomically.  Use
kmap_local_page() which will improved performance for this call.

Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/highmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 832b49b50c7b..0dc0451cf1d1 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -334,9 +334,9 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 
 static inline void memzero_page(struct page *page, size_t offset, size_t len)
 {
-	char *addr = kmap_atomic(page);
+	char *addr = kmap_local_page(page);
 	memset(addr + offset, 0, len);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 }
 
 #endif /* _LINUX_HIGHMEM_H */
-- 
2.28.0.rc0.12.gb6a658bd00c9

