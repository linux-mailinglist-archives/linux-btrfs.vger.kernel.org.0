Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794B3442B4A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 11:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhKBKFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 06:05:54 -0400
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:47107 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKBKFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 06:05:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05548989|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.03-0.00109778-0.968902;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.LmFtQ7A_1635847396;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LmFtQ7A_1635847396)
          by smtp.aliyun-inc.com(10.147.40.26);
          Tue, 02 Nov 2021 18:03:16 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: fix XX_flags_to_str() to always end with '\0'
Date:   Tue,  2 Nov 2021 18:03:16 +0800
Message-Id: <20211102100316.20256-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
We noticed 'btrfs check' output something like
  leaf 30408704 flags 0x0(P1逅?) backref revision 1
but we expected
  leaf 30408704 flags 0x0() backref revision 1

[CAUSE]
some XX_flags_to_str() failed to make sure the result string always end
with '\0' in some case.

[FIX]
add 'ret[0] = 0;' at the begining.

Signed-off-by: Wang Yugui (wangyugui@e16-tech.com)
---
 kernel-shared/print-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 39655590..1b6e4a02 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -210,6 +210,7 @@ static void bg_flags_to_str(u64 flags, char *ret)
 /* Caller should ensure sizeof(*ret)>= 26 "OFF|SCANNING|INCONSISTENT" */
 static void qgroup_flags_to_str(u64 flags, char *ret)
 {
+	ret[0] = '\0';
 	if (flags & BTRFS_QGROUP_STATUS_FLAG_ON)
 		strcpy(ret, "ON");
 	else
@@ -417,6 +418,7 @@ static void extent_flags_to_str(u64 flags, char *ret)
 {
 	int empty = 1;
 
+	ret[0] = '\0';
 	if (flags & BTRFS_EXTENT_FLAG_DATA) {
 		empty = 0;
 		strcpy(ret, "DATA");
@@ -1201,6 +1203,7 @@ static void header_flags_to_str(u64 flags, char *ret)
 {
 	int empty = 1;
 
+	ret[0] = '\0';
 	if (flags & BTRFS_HEADER_FLAG_WRITTEN) {
 		empty = 0;
 		strcpy(ret, "WRITTEN");
-- 
2.32.0

