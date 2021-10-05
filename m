Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF831422C97
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhJEPhg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 11:37:36 -0400
Received: from mta-10-3.privateemail.com ([198.54.127.62]:59335 "EHLO
        MTA-10-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJEPhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 11:37:36 -0400
X-Greylist: delayed 103153 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 11:37:36 EDT
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
        by mta-10.privateemail.com (Postfix) with ESMTP id 1DFB718000A4;
        Tue,  5 Oct 2021 11:35:45 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.218])
        by mta-10.privateemail.com (Postfix) with ESMTPA id 5E3D218000A6;
        Tue,  5 Oct 2021 11:35:44 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: add otime support to send_utimes()
Date:   Tue,  5 Oct 2021 11:35:14 -0400
Message-Id: <20211005153514.4281-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 766702ef49b8 ("Btrfs: add/fix comments/documentation for
send/receive") suggests that, otime support should be added to
send_utimes() after btrfs gets otime support. So, since btrfs has had otime
support for many years, we should add otime support to send_utimes().

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 72f9b865e847..0bee9f7a45da 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2544,7 +2544,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, eb, &ii->atime);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, eb, &ii->mtime);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_CTIME, eb, &ii->ctime);
-	/* TODO Add otime support when the otime patches get into upstream */
+	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_OTIME, eb, &ii->otime);
 
 	ret = send_cmd(sctx);
 
-- 
2.33.0

