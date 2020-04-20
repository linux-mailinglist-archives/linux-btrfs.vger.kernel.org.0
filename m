Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981551B12A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDTRJA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 13:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRI7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 13:08:59 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA258206D9;
        Mon, 20 Apr 2020 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587402539;
        bh=tPDZwM/4wQHICe/qYNofhfEPheexviXoxm4aIF+HkMM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZodWwYFXm/PO6kL7uIaDEoy5WDPQfGh/BuqL/cXnoHzPt7N+Sb3IGKy9HHogrOu6P
         glYU41MYxa7VfXOvbFskposhG9HEtLvgw+fT0+yRGPtXq2OHiw8kCPNjVqcaN//svc
         AmREQUqe4TU5Ri1ZvaRbttxMWA+fMyqkMeJ/pFp8=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/4] fsx: allow zero range operations to cross eof
Date:   Mon, 20 Apr 2020 18:07:38 +0100
Message-Id: <20200420170738.9879-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently we are limiting the range for zero range operations to stay
within the i_size boundary. This is not optimal because like this we lose
coverage of the filesystem's zero range implementation, since zero range
operations are allowed to cross the i_size. Fix this by limiting the range
to 'maxfilelen' and not 'file_size', and update the 'file_size' after each
zero range operation if needed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 9d598a4f..56479eda 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1244,6 +1244,17 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
 	}
 
 	memset(good_buf + offset, '\0', length);
+
+	if (!keep_size && end_offset > file_size) {
+		/*
+		 * If there's a gap between the old file size and the offset of
+		 * the zero range operation, fill the gap with zeroes.
+		 */
+		if (offset > file_size)
+			memset(good_buf + file_size, '\0', offset - file_size);
+
+		file_size = end_offset;
+	}
 }
 
 #else
@@ -2141,7 +2152,7 @@ have_op:
 		do_punch_hole(offset, size);
 		break;
 	case OP_ZERO_RANGE:
-		TRIM_OFF_LEN(offset, size, file_size);
+		TRIM_OFF_LEN(offset, size, maxfilelen);
 		do_zero_range(offset, size, keep_size);
 		break;
 	case OP_COLLAPSE_RANGE:
-- 
2.11.0

