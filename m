Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C341BC25B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgD1PLQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 11:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:56346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgD1PLQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 11:11:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3D8E8AFAC;
        Tue, 28 Apr 2020 15:11:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F16B6DA8C9; Tue, 28 Apr 2020 17:10:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: add more codes to decoder table
Date:   Tue, 28 Apr 2020 17:10:29 +0200
Message-Id: <7557462b9680ecf965016165e100ae57f67d1182.1588086487.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588086487.git.dsterba@suse.com>
References: <cover.1588086487.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've grepped logs for 'errno=.*unknown' and found -95, -117 and -122,
now added to the table. The wording is adjusted so it makes sense in
context of filesystem.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 9e5d723a0d99..438ecba26557 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -90,6 +90,15 @@ const char * __attribute_const__ btrfs_decode_error(int errno)
 	case -EROFS:		/* -30 */
 		errstr = "Readonly filesystem";
 		break;
+	case -EOPNOTSUPP:	/* -95 */
+		errstr = "Operation not supported";
+		break;
+	case -EUCLEAN:		/* -117 */
+		errstr = "Filesystem corrupted";
+		break;
+	case -EDQUOT:		/* -122 */
+		errstr = "Quota exceeded";
+		break;
 	}
 
 	return errstr;
-- 
2.25.0

