Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C32BDDDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405469AbfIYMOD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 08:14:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:59700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405211AbfIYMOC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 08:14:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7C58ABCE
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 12:14:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 01/10] btrfs-progs: image: Output error message for chunk tree build error
Date:   Wed, 25 Sep 2019 20:13:47 +0800
Message-Id: <20190925121356.118038-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925121356.118038-1-wqu@suse.com>
References: <20190925121356.118038-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/image/main.c b/image/main.c
index 28ef1609b5ff..fb407f33f858 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2406,8 +2406,10 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 
 	if (!multi_devices && !old_restore) {
 		ret = build_chunk_tree(&mdrestore, cluster);
-		if (ret)
+		if (ret) {
+			error("failed to build chunk tree");
 			goto out;
+		}
 		if (!list_empty(&mdrestore.overlapping_chunks))
 			remap_overlapping_chunks(&mdrestore);
 	}
-- 
2.23.0

