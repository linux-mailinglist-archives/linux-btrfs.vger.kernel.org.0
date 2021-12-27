Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D847FBD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Dec 2021 11:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhL0K1A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Dec 2021 05:27:00 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:43676 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbhL0K1A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Dec 2021 05:27:00 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Dec 2021 05:26:59 EST
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 3F3696C00733;
        Mon, 27 Dec 2021 12:18:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1640600330; bh=bs1E7OoqIx81sSocBr936l+8bwV3sY89H+jSoVxBp6M=;
        h=From:To:Cc:Subject:Date;
        b=r3s/cftjMtso/Y49b4awjaDykKbrghex2OmbDgODLpAZUxjPTZABsP5Qme1ZrIehG
         n0NqULX/Vr3SwhZ/88dPCTjCAbDOstnr36YwUKch0Pj0HM0OxJxaLY07ZydTQ1oewD
         myi4MF+pZ6VHiMupbVWz9J81o/Kw1eFRT8MPBq7A=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 31EBB6C0072E;
        Mon, 27 Dec 2021 12:18:50 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id RUvop0kWHgmA; Mon, 27 Dec 2021 12:18:50 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id DC8BC6C0072B;
        Mon, 27 Dec 2021 12:18:49 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs: remove unnecessary parameter type from compression_decompress_bio
Date:   Mon, 27 Dec 2021 18:18:39 +0800
Message-Id: <20211227101839.77682-1-l@damenly.su>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 885mlYpNBD+giECgR3rABwY+s1k3Ua26u/vYoxBbgAiJPFTkYip5XRGxnW10RX+5ujkX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_decompress_bio, the only caller of compression_decompress_bio gets
type from @cb and passes it to compression_decompress_bio.
However, compression_decompress_bio can get compression type directly
from @cb.

So remove the parameter and access it through @cb.
No functional change.

Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/compression.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 32da97c3c19d..f941b7ed23f5 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -96,10 +96,10 @@ static int compression_compress_pages(int type, struct list_head *ws,
 	}
 }
 
-static int compression_decompress_bio(int type, struct list_head *ws,
-		struct compressed_bio *cb)
+static int compression_decompress_bio(struct list_head *ws,
+				      struct compressed_bio *cb)
 {
-	switch (type) {
+	switch (cb->compress_type) {
 	case BTRFS_COMPRESS_ZLIB: return zlib_decompress_bio(ws, cb);
 	case BTRFS_COMPRESS_LZO:  return lzo_decompress_bio(ws, cb);
 	case BTRFS_COMPRESS_ZSTD: return zstd_decompress_bio(ws, cb);
@@ -1359,7 +1359,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
 	int type = cb->compress_type;
 
 	workspace = get_workspace(type, 0);
-	ret = compression_decompress_bio(type, workspace, cb);
+	ret = compression_decompress_bio(workspace, cb);
 	put_workspace(type, workspace);
 
 	return ret;
-- 
2.30.1

