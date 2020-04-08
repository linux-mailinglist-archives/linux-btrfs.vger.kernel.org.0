Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFEB1A1EDF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgDHKgJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 06:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDHKgJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 06:36:09 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2CA620753;
        Wed,  8 Apr 2020 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586342168;
        bh=lqnX6aqfXprmHrTHkjUwHROnv21mqZCBRr4TcuCabGc=;
        h=From:To:Cc:Subject:Date:From;
        b=dRbedabZEWbIMUldmdM4rbjA7f8mXcHAXQfKDQapr83gXDgwtlMNXyMUBu2nkZbyj
         NbdzA9IvMgFZvRilDt8ZJFZu07O2rv43blU3LrX0+h9Yton5x7mPYKGCTL9D2Jnxjm
         P8IV7WzrvtPsQwaHFCZXP6O1JvBiaVSsJES7pB/I=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/4] fsx: fix infinite/too long loops when generating ranges for clone operations
Date:   Wed,  8 Apr 2020 11:36:04 +0100
Message-Id: <20200408103604.11395-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

While running generic/457 I've had fsx taking a lot of CPU time and not
making any progress for over an hour. Attaching gdb to the fsx process
revealed that fsx was in the loop that generates the ranges for a clone
operation, in particular the loop seemed to never end because the range
defined by 'offset2' kept overlapping with the range defined by 'offset'.
So far this happened two times in one of my test VMs with generic/457.

Fix this by breaking out of the loop after trying 30 times, like we
currently do for dedupe operations, which results in logging the operation
as skipped.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsx.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index fa383c94..5949ebf0 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2004,16 +2004,24 @@ test(void)
 			keep_size = random() % 2;
 		break;
 	case OP_CLONE_RANGE:
-		TRIM_OFF_LEN(offset, size, file_size);
-		offset = offset & ~(block_size - 1);
-		size = size & ~(block_size - 1);
-		do {
-			offset2 = random();
-			TRIM_OFF(offset2, maxfilelen);
-			offset2 = offset2 & ~(block_size - 1);
-		} while (range_overlaps(offset, offset2, size) ||
-			 offset2 + size > maxfilelen);
-		break;
+		{
+			int tries = 0;
+
+			TRIM_OFF_LEN(offset, size, file_size);
+			offset = offset & ~(block_size - 1);
+			size = size & ~(block_size - 1);
+			do {
+				if (tries++ >= 30) {
+					size = 0;
+					break;
+				}
+				offset2 = random();
+				TRIM_OFF(offset2, maxfilelen);
+				offset2 = offset2 & ~(block_size - 1);
+			} while (range_overlaps(offset, offset2, size) ||
+				 offset2 + size > maxfilelen);
+			break;
+		}
 	case OP_DEDUPE_RANGE:
 		{
 			int tries = 0;
-- 
2.11.0

