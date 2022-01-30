Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF694A3664
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jan 2022 13:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354824AbiA3Mxg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jan 2022 07:53:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354822AbiA3Mxf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jan 2022 07:53:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1AB96210E7
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jan 2022 12:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643547214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pMv2CFJ+jUk2lh8EZG0Q0I2+UNMqMpUZH2UUick9Rfo=;
        b=IzsZQykqPgNylAb34DtfYKNMu5x4FMa0k4XJdwI7NdTYP8XQxqhVXl2I+lBJWCZYHgUcgF
        vil3JNRVtpMOueuvxqTvdMpQN8YsAWYwr5ryi+/Ue7nfsRAay1K7nE21RBRHKasbW/LLIb
        0KbNpcKc3Dn540jSBzju8KY2qlt7Pbs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D1871344B
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jan 2022 12:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Ki8CE2K9mFcCwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jan 2022 12:53:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't hold CPU for too long when defragging a file
Date:   Sun, 30 Jan 2022 20:53:15 +0800
Message-Id: <c572e24e1556b87cadb20761edbc7e33bb93ad20.1643547144.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a user report about "btrfs filesystem defrag" causing 120s
timeout problem.

For btrfs_defrag_file() it will iterate all file extents if called from
defrag ioctl, thus it can take a long time.

There is no reason not to release the CPU during such a long operation.

Add cond_resched() after defragged one cluster.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This is a long existing bug, and it should also be applied to older
kernels.
But at v5.16 we have a large rework on defrag (which caused quite some
regression though), thus there will be a specific backport for kernels
older than v5.16.
---
 fs/btrfs/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 961c38660b55..bf90e809f3b2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1695,6 +1695,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			ret = 0;
 			break;
 		}
+		cond_resched();
 	}
 
 	if (ra_allocated)
-- 
2.35.0

