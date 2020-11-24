Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307FD2C29FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 15:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbgKXOpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 09:45:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:40696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388319AbgKXOpF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 09:45:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606229104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Nwfa0KncmJ0maRuTd7T+Vfx8Ql7Hp5c3NNq209RoRds=;
        b=I9nqeZtVlGh3Euo8JMdLIwEz8rCc0k3+6SThBaOfxl16s5eyq4gvCIJKPpzCJMKndGH421
        T4MQQ3eC32hv71pf2bUhk/Q9N9ziYGH8268bRC8p8Z1+t/44YRvFzuSbGlTXOMySP2k1Fl
        WxG9e2Q8x05W700FivLI3LpLS94cbx8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E165AC2D;
        Tue, 24 Nov 2020 14:45:04 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove noinline attribute from wait_for_commit
Date:   Tue, 24 Nov 2020 16:45:02 +0200
Message-Id: <20201124144502.3168362-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is a plain wrapper that noinline makes no sense.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e5a5c3604a9b..fd4293cf69cf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -829,7 +829,7 @@ btrfs_attach_transaction_barrier(struct btrfs_root *root)
 }

 /* wait for a transaction commit to be fully complete */
-static noinline void wait_for_commit(struct btrfs_transaction *commit)
+static void wait_for_commit(struct btrfs_transaction *commit)
 {
 	wait_event(commit->commit_wait, commit->state == TRANS_STATE_COMPLETED);
 }
--
2.25.1

