Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7D2F94BD
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 19:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbhAQSzV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 13:55:21 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:38389 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728664AbhAQSzU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 13:55:20 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-36.iol.local with ESMTPA
        id 1DCAlJgx8i3tS1DCAlXz65; Sun, 17 Jan 2021 19:54:39 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1610909679; bh=sMy2DEf9GJpDJMg4POKm1o99GnD71UVaPKRMjCRp71c=;
        h=From;
        b=SG4sCvQXNfuWRMU028NBRtk4ZRmRyFyVxWi/BE8hYJA/j9VIqXly1zomafCZhGSQt
         WmwujEIJQH1UdKPQW84TVeajswk+jF3+4JRZJCq2MeBslKOWij9eoD/Q/OqVScqJg9
         yU/K9T02dTSVrhAhaZ6yMpR/tM6LLx2VjS7AD6F8/vi1fWvefresyG8viMNI5L7hQd
         tU277aAo/NDpW5p0mvMxZ5UBqbLrKYQZQQ+39HDXAMJRnxNEAvXkYL82bsnJ8QQD36
         EASDfvMciHNvlliou+fKQmQ7wUB9Zg0JZWAan86wMxmN3Jx5596vNWB1qCUJuLnKcD
         WTyRwG4uuenAQ==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=600487ef cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=V5MRcGaKH_fqCW5OQCMA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/5] Add flags for dedicated metadata disks
Date:   Sun, 17 Jan 2021 19:54:32 +0100
Message-Id: <20210117185435.36263-3-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117185435.36263-1-kreijack@libero.it>
References: <20210117185435.36263-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOxzuVv6vOXgl1ERwkvz25hNFma0tmqiJOJr+/xS5vrd73p/7znYVfwyKiU+45TTBalP2nklPUvb7qERVXTNoZ4RIFkXVsAxDraVVFsUIfmIsIg80kHv
 6Tw1FTjXmWsxRLfDRnBf4cE+ZtOcJHDL2c0AalQVZE6+UgoVlzcBSwcptHRso/uQOpIB/txy7VJ/YjBo7j5nlZZt19mBTR4O/zdc2GrvScFM+YEp9AohtyxV
 odulQW5GVb9RhdC1W6vzFXQ/rrYEO/lMKDzeg2Af7f0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

---
 include/uapi/linux/btrfs_tree.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 58d7cff9afb1..701ad550d596 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -361,6 +361,9 @@ struct btrfs_key {
 	__u64 offset;
 } __attribute__ ((__packed__));
 
+/* dev_item.type */
+#define BTRFS_DEV_PREFERRED_METADATA	(1ULL << 0)
+
 struct btrfs_dev_item {
 	/* the internal btrfs device id */
 	__le64 devid;
-- 
2.30.0

