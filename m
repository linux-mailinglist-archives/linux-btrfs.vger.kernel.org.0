Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0470B2BAF35
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgKTPpB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 10:45:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:40878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgKTPpB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 10:45:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605887100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=upMRMOErGqCihysCuI40ryGBNqj5MBoRUT7UoXwQC4Y=;
        b=TOE/PoNxnjEsjtFl87X6KpTrkbM3lTsTxpsXooXrPsLCSZcSNK/Rcd8EN2wG6taUB5bAg/
        pqKmVg9wONErtrirVp+KZdA6TT23LTkoC3KZwvT8XJWHSjDc5XVOrZ3byXLms8p4MJkbzy
        22+iSwQRm18uUWBkOnxXiklZROIfRqU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C8B9ACBA;
        Fri, 20 Nov 2020 15:45:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CF554DA6E1; Fri, 20 Nov 2020 16:43:13 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove stub device info from messages when we have no fs_info
Date:   Fri, 20 Nov 2020 16:43:12 +0100
Message-Id: <20201120154312.23976-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Without a NULL fs_info the helpers will print something like

	BTRFS error (device <unknown>): ...

This can happen in contexts where fs_info is not available at all or
it's potentially unsafe due to object lifetime. The <unknown> stub does
not bring much information and with the prefix makes the message
unnecessarily longer.

Remove it for the NULL fs_info case.

	BTRFS error: ...

Callers can add the device information to the message itself if needed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6693cfc14dfd..348f8899f4f4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -240,9 +240,13 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (__ratelimit(ratelimit))
-		printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
-			fs_info ? fs_info->sb->s_id : "<unknown>", &vaf);
+	if (__ratelimit(ratelimit)) {
+		if (fs_info)
+			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
+				fs_info->sb->s_id, &vaf);
+		else
+			printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
+	}
 
 	va_end(args);
 }
-- 
2.25.0

