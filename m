Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9651AC3F06
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfJARwR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 13:52:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729782AbfJARwR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:52:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8B90B1B5;
        Tue,  1 Oct 2019 17:52:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B413DDA88C; Tue,  1 Oct 2019 19:52:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: add 64bit safe helper for power of two checks
Date:   Tue,  1 Oct 2019 19:52:33 +0200
Message-Id: <04a85eb57e4b6827f22720e810704b4e8540bfdb.1569951996.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569951996.git.dsterba@suse.com>
References: <cover.1569951996.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As is_power_of_two takes unsigned long, it's not safe on 32bit
architectures, but we could pass any u64 value in seveal places. Add a
separate helper and also an alias that better expresses the purpose for
which the helper is used.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/misc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 7d564924dfeb..72bab64ecf60 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -47,4 +47,15 @@ static inline u64 div_factor_fine(u64 num, int factor)
 	return div_u64(num, 100);
 }
 
+/* Copy of is_power_of_two that is 64bit safe */
+static inline bool is_power_of_two_u64(u64 n)
+{
+	return n != 0 && (n & (n - 1)) == 0;
+}
+
+static inline bool has_single_bit_set(u64 n)
+{
+	return is_power_of_two_u64(n);
+}
+
 #endif
-- 
2.23.0

