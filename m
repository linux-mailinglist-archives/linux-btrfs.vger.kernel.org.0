Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3C1A1EDE
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 12:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgDHKf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 06:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDHKf6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 06:35:58 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D135020753;
        Wed,  8 Apr 2020 10:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586342157;
        bh=8QVO30BHDBcabGdLbwR5eUB3BhOHkhInXscyDaLbJgA=;
        h=From:To:Cc:Subject:Date:From;
        b=Z2na5MJXqpI4DKs9VTBs1gY9P8tIJ35TdPmku/9D0zW8RIi/xuIh5+nuIpmQSQtTB
         4xDYScXoZSRChS6N1NP+NveywC0MKxpo8s7mw/IGwG3TANRJDknxwVz22uzrNlRIVp
         2pY0VoRRb91aNkWUxzraDkgNjzBI8uoAs4cr1ugY=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/4] fsx: add missing file size update on zero range operations
Date:   Wed,  8 Apr 2020 11:35:52 +0100
Message-Id: <20200408103552.11339-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When a zero range operation increases the size of the test file we were
not updating the global variable 'file_size' which tracks the current
size of the test file. This variable is used to for example compute the
offset for a source range of clone, dedupe and copy file range operations.

So just fix it by updating the 'file_size' global variable whenever a zero
range operation does not use the keep size flag and its range goes beyond
the current file size.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 9d598a4f..fa383c94 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1212,6 +1212,8 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
 	}
 
 	end_offset = keep_size ? 0 : offset + length;
+	if (!keep_size && end_offset > file_size)
+		file_size = end_offset;
 
 	if (end_offset > biggest) {
 		biggest = end_offset;
-- 
2.11.0

