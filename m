Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B217BCD4
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 13:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCFMfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 07:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCFMfV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 07:35:21 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915972072A;
        Fri,  6 Mar 2020 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583498121;
        bh=xQQWeHB1WiRGeNHaQSy3w3984hPzpCUhKbuEmKT+c34=;
        h=From:To:Cc:Subject:Date:From;
        b=M/FnftsvTRwuBmreZUbbgf3bY6UJ9UqDzLMX+Ef3vrzPWPVgylzJENr1UTaZFMSSZ
         hqGEY1+yuoIh9PabuwOmwamN75H4JfcwsStkYp/o5akFlH0MGZFxEAjsURfHNtLM2i
         obhjEbwCiTFT5osTxhVcvWc1wkZpodiljtiZiGfs=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fsx: fix bug where zero range operations never use the keep size flag
Date:   Fri,  6 Mar 2020 12:35:17 +0000
Message-Id: <20200306123517.16729-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We are never using the FALLOC_FL_KEEP_SIZE flag for zero range operations
even when we intend to use it. So fix it by setting that flag for the
call to fallocate(2) if the 'keep_size' parameter is true.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 06d08e4e..7f7b7a87 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1199,6 +1199,9 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
 	unsigned end_offset;
 	int mode = FALLOC_FL_ZERO_RANGE;
 
+	if (keep_size)
+		mode |= FALLOC_FL_KEEP_SIZE;
+
 	if (length == 0) {
 		if (!quiet && testcalls > simulatedopcount)
 			prt("skipping zero length zero range\n");
-- 
2.11.0

