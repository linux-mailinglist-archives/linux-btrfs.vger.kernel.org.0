Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425AE1B12A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgDTRJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 13:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRJK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 13:09:10 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBF4206D9;
        Mon, 20 Apr 2020 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587402549;
        bh=/09lFz86nyjgOxhAxgGqNyvCbXjNDXalZtzZZTnqodE=;
        h=From:To:Cc:Subject:Date:From;
        b=oIvhkGvh8dNq1KRn0wMOb5dpf7Heg+flEnRxEb+xiCTGqgBib7EsCIdC/D7hY14WW
         FB0tIf5KtSYrlkU6eK6r2EumZ6YwynScbH+SkU9GThHXcaqlEliDKqNpZCTzRnT0KC
         uusGL6hlPGtrMCjLEZGygRZwJORLaMIR0gqK8mwI=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/4] fsx: fix infinite/too long loops when generating ranges for clone operations
Date:   Mon, 20 Apr 2020 18:09:05 +0100
Message-Id: <20200420170905.9944-1-fdmanana@kernel.org>
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
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 ltp/fsx.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 56479eda..ab64b50a 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2013,16 +2013,24 @@ test(void)
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

