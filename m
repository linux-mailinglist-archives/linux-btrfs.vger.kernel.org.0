Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB124FAA88
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 07:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfKMG7s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 01:59:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:48084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfKMG7r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 01:59:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5491CADEF;
        Wed, 13 Nov 2019 06:59:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: common: Keep $seqres.dmesg in $RESULT_DIR
Date:   Wed, 13 Nov 2019 14:59:38 +0800
Message-Id: <20191113065938.34720-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently fstests will remove $seqres.dmesg if nothing wrong happened.
It saves some space, but sometimes it may not provide good enough
history for developers to check.
E.g. some unexpected dmesg from fs, but not serious enough to be caught
by current filter.

So instead of deleting the ordinary $seqres.dmesg, just keep them, so
we can archive them for later review.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/rc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index b988e912..59a339a6 100644
--- a/common/rc
+++ b/common/rc
@@ -3625,10 +3625,8 @@ _check_dmesg()
 	if [ $? -eq 0 ]; then
 		_dump_err "_check_dmesg: something found in dmesg (see $seqres.dmesg)"
 		return 1
-	else
-		rm -f $seqres.dmesg
-		return 0
 	fi
+	return 0
 }
 
 # capture the kmemleak report
-- 
2.23.0

