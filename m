Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE83375CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhCKOcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:32:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233936AbhCKObe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:31:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1333F64FEB;
        Thu, 11 Mar 2021 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473093;
        bh=ziekMdAbJzsNFDCi2ZxRIQBbdARKcREVy4JnNc68k5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGLHH71Wq7S2T8v14GJXxAXhuPa7du+E4aX/2yxxPWLUq4CphIHyZo2Mq//QtT2fA
         Z+9eudWgnYXRPAYSAfwSKSHvRpnc662Zy/L1Xg/Sl6hMyvZ8UjF6flmsNDsWtECazd
         gR3re/T1Gd4EmY9ExLy/OlfO5kNupgiK8bs+9ZPoEZvggja/2M6SneA4HRte7kwMER
         c9csJNRutJcjR4wdqwmjjd6ZgRZ3hUmU//jMSrvUjwqQi8flwmZb1XFVljfrwkfkna
         s9F9j9q2JuR8jtba0dLu27G5MekDFSjTXv6uxDd5RVWe0Gzm90tVwTJBFXKloUZDoQ
         qblV9WXN3zPoA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 9/9] btrfs: update debug message when checking seq number of a delayed ref
Date:   Thu, 11 Mar 2021 14:31:13 +0000
Message-Id: <f6f7e3c17bd09979f0e41a024729ffd645ff5a65.1615472583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615472583.git.fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We used to encode two different numbers in the tree mod log counter used
for sequence numbers, one in the upper 32 bits and the other one in the
lower 32 bits. However that is no longer the case, we stopped doing that
since commit fcebe4562dec83 ("Btrfs: rework qgroup accounting").

So update the debug message at btrfs_check_delayed_seq to stop extracting
the two 32 bits counters and print instead the 64 bits sequence numbers.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 7a3131cbf1fb..8c1d78befb5b 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -514,9 +514,8 @@ int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq)
 
 	if (min_seq != 0 && seq >= min_seq) {
 		btrfs_debug(fs_info,
-			    "holding back delayed_ref %#x.%x, lowest is %#x.%x",
-			    (u32)(seq >> 32), (u32)seq,
-			    (u32)(min_seq >> 32), (u32)min_seq);
+			    "holding back delayed_ref %llu, lowest is %llu",
+			    seq, min_seq);
 		ret = 1;
 	}
 
-- 
2.28.0

