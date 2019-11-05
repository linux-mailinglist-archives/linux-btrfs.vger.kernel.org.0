Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26C4F0063
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389546AbfKEO4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Nov 2019 09:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388635AbfKEO4d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Nov 2019 09:56:33 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AADB1217F5;
        Tue,  5 Nov 2019 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572965792;
        bh=W5uVvSmMjCeg/kPsx/uOm38SeQSZeJOHRYzDWiGJKUE=;
        h=From:To:Cc:Subject:Date:From;
        b=iPFFZuPfhxj/APLOQUMeU2N4Srzy99Ake3mtCmEYsro8/1/vS6bNP7j/IQyb+q9xY
         ciwGv+01UJGbldCbgBh/Gg9rvFJfY2b6P9BBdURy+duqR1jG/TTH5fFKAB6ProTwo6
         tvizmu2R7FA5/l8FwGlYlV6/6bbbiMs9/y/gyo2I=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/3] common: open files in ro mode for extent and hole count helpers
Date:   Tue,  5 Nov 2019 14:56:22 +0000
Message-Id: <20191105145622.11181-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The helper functions _count_extents() and _count_holes() open their input
file in RW mode to call fiemap, however opening it in RO mode is enough.
By opening them in RW mode it also makes it not possible to use them
against files residing in btrfs readonly snapshots for example.

So just open the files in RO mode in these functions.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index ef0c2509..238ffef9 100644
--- a/common/rc
+++ b/common/rc
@@ -3199,12 +3199,12 @@ _require_metadata_journaling()
 
 _count_extents()
 {
-	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
+	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
 }
 
 _count_holes()
 {
-	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep hole | wc -l
+	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep hole | wc -l
 }
 
 _count_attr_extents()
-- 
2.11.0

