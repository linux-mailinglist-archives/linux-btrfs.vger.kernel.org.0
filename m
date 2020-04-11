Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F81A52A3
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Apr 2020 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDKPsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Apr 2020 11:48:03 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7575 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDKPsD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Apr 2020 11:48:03 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85e91e69f3a8-16554; Sat, 11 Apr 2020 23:47:43 +0800 (CST)
X-RM-TRANSID: 2ee85e91e69f3a8-16554
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.104.145.126])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e91e69cf7b-7c289;
        Sat, 11 Apr 2020 23:47:42 +0800 (CST)
X-RM-TRANSID: 2ee35e91e69cf7b-7c289
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] btrfs: Fix backref.c selftest compilation warning
Date:   Sat, 11 Apr 2020 23:49:15 +0800
Message-Id: <20200411154915.9408-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix missing braces compilation warning in the ARM
compiler environment:
    fs/btrfs/backref.c: In function ‘is_shared_data_backref’:
    fs/btrfs/backref.c:394:9: warning: missing braces around initializer [-Wmissing-braces]
      struct prelim_ref target = {0};
    fs/btrfs/backref.c:394:9: warning: (near initialization for ‘target.rbnode’) [-Wmissing-braces]

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 9c380e7..0cc0257 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -391,7 +391,7 @@ static int is_shared_data_backref(struct preftrees *preftrees, u64 bytenr)
 	struct rb_node **p = &preftrees->direct.root.rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	struct prelim_ref *ref = NULL;
-	struct prelim_ref target = {0};
+	struct prelim_ref target = {};
 	int result;
 
 	target.parent = bytenr;
-- 
2.7.4



