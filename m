Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542E2476E73
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 11:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhLPKAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 05:00:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49020 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbhLPKAO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 05:00:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCA781F3A5;
        Thu, 16 Dec 2021 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639648813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0OQ3LOUrKUgvSOLb4eqNUSkeGBeOw9X6fkVXId+hYpY=;
        b=PHEIgzBXCfOvACgrvwLU2Rl1G37y18jUapFa4ppwckWBiwBzgbvKG1hYSYpzrVK3eqREXe
        e3safZVBgxTVsIQvveVY2n2ILkbQ40BymYWXs8lbeB2PjCZOl7PBz/Mv/TLq2U5QzFAEiH
        mutUKF5NzA2H5qAvo8TCDfd3Mro2bGc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8934613C32;
        Thu, 16 Dec 2021 10:00:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0IfPHi0Ou2FkFAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 16 Dec 2021 10:00:13 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: remove redundant fs uuid validation from make_btrf
Date:   Thu, 16 Dec 2021 12:00:12 +0200
Message-Id: <20211216100012.911835-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

cfg->fs_uuid is either 0 or set to the value of the -U parameter
passed to mkfs.btrfs. However the value of the latter is already being
validated in the main mkfs function. Just remove the duplicated checks
in make_btrfs as they effectively can never be executed.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 mkfs/common.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index fec23e64b2b2..72e84bc01712 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -260,18 +260,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(&super, 0, sizeof(super));

 	num_bytes = (cfg->num_bytes / cfg->sectorsize) * cfg->sectorsize;
-	if (*cfg->fs_uuid) {
-		if (uuid_parse(cfg->fs_uuid, super.fsid) != 0) {
-			error("cannot not parse UUID: %s", cfg->fs_uuid);
-			ret = -EINVAL;
-			goto out;
-		}
-		if (!test_uuid_unique(cfg->fs_uuid)) {
-			error("non-unique UUID: %s", cfg->fs_uuid);
-			ret = -EBUSY;
-			goto out;
-		}
-	} else {
+	if (!*cfg->fs_uuid) {
 		uuid_generate(super.fsid);
 		uuid_unparse(super.fsid, cfg->fs_uuid);
 	}
--
2.17.1

