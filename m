Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7D47BC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 09:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfFQH7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 03:59:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:43826 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbfFQH7s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 03:59:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D56DFAE89
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2019 07:59:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: Remove unnecessary fallthrough attribute in test_num_disk_vs_raid()
Date:   Mon, 17 Jun 2019 15:59:35 +0800
Message-Id: <20190617075936.12113-4-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617075936.12113-1-wqu@suse.com>
References: <20190617075936.12113-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/utils.c b/utils.c
index 0b271517551b..2709ced97f97 100644
--- a/utils.c
+++ b/utils.c
@@ -1928,7 +1928,6 @@ int test_num_disk_vs_raid(u64 metadata_profile, u64 data_profile,
 		__attribute__ ((fallthrough));
 	case 1:
 		allowed |= BTRFS_BLOCK_GROUP_DUP;
-		__attribute__ ((fallthrough));
 	}
 
 	if (dev_cnt > 1 && profile & BTRFS_BLOCK_GROUP_DUP) {
-- 
2.22.0

