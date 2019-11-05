Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C466F0066
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 15:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbfKEO4q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Nov 2019 09:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbfKEO4q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Nov 2019 09:56:46 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3EAD217F5;
        Tue,  5 Nov 2019 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572965805;
        bh=iUobjqWyiOHpQFuEuNChvGI6bw32368NHyot+RqS4gE=;
        h=From:To:Cc:Subject:Date:From;
        b=BuqTCV1+UmdoY5Xt2Db1tDhx1/FAkYb3t+4ACXlm12sEvfQNa5Dhx79U+zQ39c3Rw
         8Xfi560QftGAk74/FJkaNL33N+75VHHmGcdKeKYO40BRWNPJ/GGrCxCmaIyROLaO3U
         8vO8xlz6+o7F26gEPAgsVSrlsIImPRDVUmXHlBRs=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/3] common: add helper to count number of exclusive extents in a file
Date:   Tue,  5 Nov 2019 14:56:40 +0000
Message-Id: <20191105145640.11231-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add a new helper that is similar to _count_extents() except that extents
that are shared several times by the file with itself (reflinked at
different file offsets) are accounted 1 time only, instead of N times.

This is motivated by a subsequent test for btrfs that will use this new
helper, to verify that send streams are issuing reflink operations.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/rc b/common/rc
index 238ffef9..3c412178 100644
--- a/common/rc
+++ b/common/rc
@@ -3202,6 +3202,15 @@ _count_extents()
 	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
 }
 
+# Similar to _count_extents() but if any extent is shared multiples times in
+# the file (reflinked to different file offsets), it is accounted as 1 extent
+# instead of N extents.
+_count_exclusive_extents()
+{
+	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | \
+		cut -d ' ' -f 3 | sort | uniq | wc -l
+}
+
 _count_holes()
 {
 	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep hole | wc -l
-- 
2.11.0

