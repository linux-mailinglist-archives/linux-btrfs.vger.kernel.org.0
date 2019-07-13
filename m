Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5967C6C
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2019 01:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfGMXPD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 19:15:03 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:53454 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfGMXPC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 19:15:02 -0400
Received: from [2a02:a31c:853f:a300::4] (helo=valinor.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1hmREH-0000VH-RN; Sun, 14 Jul 2019 01:14:59 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1hmREH-000Bke-CP; Sun, 14 Jul 2019 01:14:57 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Sun, 14 Jul 2019 01:14:54 +0200
Message-Id: <20190713231454.45129-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:a31c:853f:a300::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=8.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_PASS=-0.001 autolearn=no autolearn_force=no languages=en
Subject: [PATCH] btrfs-progs: fix a printf format string fatal warning
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At least in Debian, default build flags include -Werror=format-security,
for good reasons in most cases.  Here, the string comes from strftime --
and though I don't suspect any locale would be crazy enough to have %X
include a '%' char, the compiler has no way to know that.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 common/format-output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/format-output.c b/common/format-output.c
index c5f1b51f..98fb8607 100644
--- a/common/format-output.c
+++ b/common/format-output.c
@@ -280,7 +280,7 @@ void fmt_print(struct format_ctx *fctx, const char* key, ...)
 
 			localtime_r(&ts, &tm);
 			strftime(tstr, 256, "%Y-%m-%d %X %z", &tm);
-			printf(tstr);
+			printf("%s", tstr);
 		} else {
 			putchar('-');
 		}
-- 
2.22.0

