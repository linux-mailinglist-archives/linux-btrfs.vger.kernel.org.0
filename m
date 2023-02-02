Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63390687470
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Feb 2023 05:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjBBEeG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Feb 2023 23:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBBEeF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Feb 2023 23:34:05 -0500
X-Greylist: delayed 41263 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 20:34:03 PST
Received: from mx2.rus.uni-stuttgart.de (mx2.rus.uni-stuttgart.de [129.69.192.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B953E54
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Feb 2023 20:34:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mx2.rus.uni-stuttgart.de (Postfix) with ESMTP id 61C4C200B9
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 05:34:01 +0100 (CET)
X-Virus-Scanned: USTUTT mailrelay AV services at mx2.rus.uni-stuttgart.de
Received: from mx2.rus.uni-stuttgart.de ([127.0.0.1])
        by localhost (mx2.rus.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lGpijuB0CfN5 for <linux-btrfs@vger.kernel.org>;
        Thu,  2 Feb 2023 05:33:59 +0100 (CET)
Received: from dsimail.dsi.uni-stuttgart.de (mailrelay.dsi.uni-stuttgart.de [129.69.71.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx2.rus.uni-stuttgart.de (Postfix) with ESMTPS
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 05:33:59 +0100 (CET)
Received: from daof.dsi.uni-stuttgart.de (unknown [130.134.188.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: daofadmin)
        by dsimail.dsi.uni-stuttgart.de (Postfix) with ESMTPSA id 5996E1200A3;
        Thu,  2 Feb 2023 05:33:54 +0100 (CET)
Received: by daof.dsi.uni-stuttgart.de (Postfix, from userid 1000)
        id 4EA7137AF8E; Wed,  1 Feb 2023 20:33:47 -0800 (PST)
From:   Holger Jakob <jakob@dsi.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Holger Jakob <jakob@dsi.uni-stuttgart.de>
Subject: [PATCH v2 2/2] Fixed issue with metadata getting modified in dry run mode
Date:   Wed,  1 Feb 2023 20:33:45 -0800
Message-Id: <20230202043345.14010-2-jakob@dsi.uni-stuttgart.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230202043345.14010-1-jakob@dsi.uni-stuttgart.de>
References: <7b2b7360-9008-7d88-02db-1ca4f07a6df6@oracle.com>
 <20230202043345.14010-1-jakob@dsi.uni-stuttgart.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In Dry run the following error appeared and aborted execution

ERROR: failed to access 'XYZ' to restore metadata/xattrs: No such file or directory

The patch is skipping the metadata and xattrs handling when dry run is enabled

Signed-off-by: Holger Jakob <jakob@dsi.uni-stuttgart.de>
---
 cmds/restore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 18edc8ca..0b1f00a5 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1117,7 +1117,7 @@ next:
 		path.slots[0]++;
 	}
 
-	if (restore_metadata || get_xattrs) {
+	if ((restore_metadata || get_xattrs) && !dry_run) {
 		snprintf(path_name, PATH_MAX, "%s%s", output_rootdir, in_dir);
 		fd = open(path_name, O_RDONLY);
 		if (fd < 0) {
-- 
2.35.3

