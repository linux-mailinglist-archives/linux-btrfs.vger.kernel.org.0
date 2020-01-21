Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE11437B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 08:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAUHec (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 02:34:32 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51405 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgAUHeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 02:34:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToHBwCa_1579592057;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHBwCa_1579592057)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 15:34:17 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Btrfs: remove macros tlv_put_u8/16/32
Date:   Tue, 21 Jan 2020 15:34:16 +0800
Message-Id: <1579592056-86333-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These 3 macros are never used after introduced from commit 31db9f7c23fb
("Btrfs: introduce BTRFS_IOC_SEND for btrfs send/receive"), maybe better
to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Chris Mason <clm@fb.com> 
Cc: Josef Bacik <josef@toxicpanda.com> 
Cc: David Sterba <dsterba@suse.com> 
Cc: linux-btrfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/btrfs/send.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 091e5bc8c7ea..75760934a084 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -639,9 +639,6 @@ static int tlv_put_btrfs_timespec(struct send_ctx *sctx, u16 attr,
 			goto tlv_put_failure; \
 	} while (0)
 
-#define TLV_PUT_U8(sctx, attrtype, data) TLV_PUT_INT(sctx, attrtype, 8, data)
-#define TLV_PUT_U16(sctx, attrtype, data) TLV_PUT_INT(sctx, attrtype, 16, data)
-#define TLV_PUT_U32(sctx, attrtype, data) TLV_PUT_INT(sctx, attrtype, 32, data)
 #define TLV_PUT_U64(sctx, attrtype, data) TLV_PUT_INT(sctx, attrtype, 64, data)
 #define TLV_PUT_STRING(sctx, attrtype, str, len) \
 	do { \
-- 
1.8.3.1

