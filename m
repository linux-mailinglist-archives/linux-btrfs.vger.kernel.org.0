Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF82E2C30
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Dec 2020 20:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLYToG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Dec 2020 14:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgLYToG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Dec 2020 14:44:06 -0500
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58179C0613C1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Dec 2020 11:43:26 -0800 (PST)
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1kssYl-0001P2-QL; Fri, 25 Dec 2020 20:15:33 +0100
Received: from kilobyte by umbar.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1kssYl-0006W1-BV; Fri, 25 Dec 2020 20:15:31 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Fri, 25 Dec 2020 20:15:30 +0100
Message-Id: <20201225191530.25000-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=8.0 tests=ALL_TRUSTED=-1,BAYES_00=-1.9,
        TVD_RCVD_IP=0.001 autolearn=ham autolearn_force=no languages=
Subject: [PATCH] btrfs-progs: fix unterminated long opts for send
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any use of a long option would crash.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 cmds/send.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/send.c b/cmds/send.c
index b8e3ba12..3bfc69f5 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -496,7 +496,8 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		static const struct option long_options[] = {
 			{ "verbose", no_argument, NULL, 'v' },
 			{ "quiet", no_argument, NULL, 'q' },
-			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA }
+			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA },
+			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "vqec:f:i:p:", long_options, NULL);
 
-- 
2.30.0.rc2

