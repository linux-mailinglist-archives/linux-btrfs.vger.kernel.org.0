Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86FB6EBC32
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Apr 2023 03:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDWBEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Apr 2023 21:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDWBED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Apr 2023 21:04:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8238B198B
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Apr 2023 18:04:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C94FC1F8AC
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Apr 2023 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682211839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0bys/2qDx1I9bu4dSmLbQENb5oKve8zKHSB7F1FizqQ=;
        b=aySDrqi+fNCmI+ULx79/GkiAIblux79Riv18d9jNoYrh320j/V1nMVnLRBWka4VPKw0u/r
        r0yv/W+hlMcjhw/2C+JxJW6N9xrJfguhRkmXRlH+GrIklPDpJ6SzTbp1eZnFF/rsYQbY7n
        8vltU8zzoFANSs49FPrCzpg+s89VZDI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B94113499
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Apr 2023 01:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9pw0A/+DRGSpIgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Apr 2023 01:03:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: receive: output the parent subvolume uuid if it can not be found
Date:   Sun, 23 Apr 2023 09:03:42 +0800
Message-Id: <2aaffadeec6e3e6b03365e1bb20fd0e102801cf9.1682211774.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's a known problem that a received subvolume would lose its UUID after
switching to RW.
Thus it can lead to later receive problems for snapshotting and cloning.

In that case, we just output a simple error message liks:

  ERROR: cannot find parent subvolume

Or

  ERROR: clone: did not find source subvol

Normally we need to use "btrfs receive --dump" to know what the missing
subvolume UUID is, which would cost extra time communicating.

This patch would:

- Add extra subvolumd UUID output
- Unify the error messages to the same format

Now the error messages would look like:

  ERROR: snapshot: cannot find parent subvolume 1b4e28ba-2fa1-11d2-883f-b9a761bde3fb
  ERROR: clone: cannot find source subvolume 1b4e28ba-2fa1-11d2-883f-b9a761bde3fb

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/receive.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index ef40d91cc7a5..1e8f30f68552 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -297,7 +297,8 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
 			ret = -ENOENT;
 		else
 			ret = PTR_ERR(parent_subvol);
-		error("cannot find parent subvolume");
+		uuid_unparse(parent_uuid, uuid_str);
+		error("snapshot: cannot find parent subvolume %s", uuid_str);
 		goto out;
 	}
 
@@ -749,11 +750,14 @@ static int process_clone(const char *path, u64 offset, u64 len,
 					NULL,
 					subvol_search_by_received_uuid);
 		if (IS_ERR_OR_NULL(si)) {
+			char uuid_str[BTRFS_UUID_UNPARSED_SIZE];
+
 			if (!si)
 				ret = -ENOENT;
 			else
 				ret = PTR_ERR(si);
-			error("clone: did not find source subvol");
+			uuid_unparse(clone_uuid, uuid_str);
+			error("clone: cannot find source subvol %s", uuid_str);
 			goto out;
 		}
 		/* strip the subvolume that we are receiving to from the start of subvol_path */
-- 
2.39.2

