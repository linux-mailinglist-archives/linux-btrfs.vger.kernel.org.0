Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35C415A68
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbhIWI6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 04:58:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32772 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbhIWI6Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 04:58:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 63A961FD74
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 08:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632387413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EWK+yFFQ+b7UdE66HOme9E1uQq0imyxe6x+yOuh12ps=;
        b=DxipVSL2PccgUAHkygSJ2ox7JGiD96H7CrpqExYy6KCm9mXjUj2d3kOSsHltH9PUsgHJyd
        XA7sYGWhehBgc4qknHmp6VPYXPAmVrL+km3+Atlxpe8yRXI2hmeI4aFnza+1gOZTravFEY
        lR6cwX+hT4JR6BLpdnBD2b3xHQ97ccc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E8DB13DCA
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 08:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hi8zF1RBTGG4LAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 08:56:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: check: fix indent --clear-ino-cache option
Date:   Thu, 23 Sep 2021 16:56:49 +0800
Message-Id: <20210923085649.109622-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Help string for "--clear-ino-cache" option is not following the indent
of other help strings:

      repair options:
           --init-csum-tree            create a new CRC tree
           --init-extent-tree          create a new extent tree
           --clear-space-cache v1|v2   clear space cache for v1 or v2
           --clear-ino-cache 	    clear ino cache leftover items

The problem is caused by the usage of tab instead of space as indent.

Fix it by using space instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 661c996a2cb1..182105691775 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10354,7 +10354,7 @@ static const char * const cmd_check_usage[] = {
 	"       --init-csum-tree            create a new CRC tree",
 	"       --init-extent-tree          create a new extent tree",
 	"       --clear-space-cache v1|v2   clear space cache for v1 or v2",
-	"       --clear-ino-cache 	    clear ino cache leftover items",
+	"       --clear-ino-cache           clear ino cache leftover items",
 	"  check and reporting options:",
 	"       --check-data-csum           verify checksums of data blocks",
 	"       -Q|--qgroup-report          print a report on qgroup consistency",
-- 
2.33.0

