Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB1D498141
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 14:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbiAXNiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 08:38:54 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:46322 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiAXNix (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 08:38:53 -0500
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1nBzWQ-008LxX-4p; Mon, 24 Jan 2022 14:36:40 +0100
Received: from [2a02:a31c:8245:f980::4] (helo=valinor.angband.pl)
        by barad-dur.angband.pl with esmtp (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1nBzWO-0005oW-UK; Mon, 24 Jan 2022 14:36:37 +0100
Received: from kilobyte by valinor.angband.pl with local (Exim 4.95)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1nBzWM-000GHq-QA;
        Mon, 24 Jan 2022 14:36:34 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-btrfs@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Mon, 24 Jan 2022 14:36:32 +0100
Message-Id: <20220124133632.62597-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_HELO_NONE=0.001,SPF_PASS=-0.001,TVD_RCVD_IP=0.001 autolearn=no
        autolearn_force=no languages=en
Subject: [PATCH] btrfs-progs: subv del: hide a bogus warning on an unprivileged delete
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Checking the default subvolume uses TREE_SEARCH which is a CAP_SYS_ADMIN
only operation, and thus will fail when unprivileged, even if we have
permissions to actually delete the subvolume.

This produces a warning even if all is ok.  Let's hide it if we're not
root (root but !CAP is odd enough to warn).

Fixes 87804a3f0663a4d1891395bd97b8e81e6f183e66
Ref: https://bugs.debian.org/998840
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 cmds/subvolume.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 6aac7dd1..e767e20d 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -376,7 +376,8 @@ again:
 
 	err = btrfs_util_get_default_subvolume_fd(fd, &default_subvol_id);
 	if (err) {
-		warning("cannot read default subvolume id: %m");
+		if (!geteuid())
+			warning("cannot read default subvolume id: %m");
 		default_subvol_id = 0;
 	}
 
-- 
2.34.1

