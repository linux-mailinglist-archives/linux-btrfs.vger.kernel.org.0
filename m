Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D055F299
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 08:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGDGLL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 02:11:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:54366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbfGDGLL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 02:11:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16612AF55
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2019 06:11:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2.1 01/10] btrfs-progs: image: Output error message for chunk tree build error
Date:   Thu,  4 Jul 2019 14:10:54 +0800
Message-Id: <20190704061103.20096-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704061103.20096-1-wqu@suse.com>
References: <20190704061103.20096-1-wqu@suse.com>
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
2.22.0

