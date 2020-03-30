Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95FD1974C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgC3HCF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 03:02:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:54586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbgC3HCF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 03:02:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78888ACA2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Mar 2020 07:02:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: check: Sanitize the return value for qgroup error
Date:   Mon, 30 Mar 2020 15:01:59 +0800
Message-Id: <20200330070159.50077-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
btrfs check can return strange return value for shell:
 [Inferior 1 (process 48641) exited with code 0213]
					      ^^^^

[CAUSE]
It's caused by the incorrect handling of qgroup error.

qgroup_report_ret can be -117 (-EUCLEAN), using that value with exit()
can cause overflow, causing return value not properly recognized.

[FIX]
Fix it by sanitize the return value to 0 or 1.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 37c5b35a36bd..8e29337c5c23 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10458,7 +10458,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			goto out;
 		}
 		if (qgroup_report_ret && (!qgroups_repaired || ret))
-			err |= qgroup_report_ret;
+			err |= !!qgroup_report_ret;
 		ret = 0;
 	} else {
 		fprintf(stderr,
-- 
2.26.0

