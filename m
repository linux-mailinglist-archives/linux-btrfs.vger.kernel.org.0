Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EE50259E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350465AbiDOGeD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 02:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiDOGdz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 02:33:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2445BD33
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 23:31:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D7861F74D
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650004286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Gw5kNAhuzhvnNbUc8WjiNySvFb7nVfxC0wMV4blhgPY=;
        b=cUsVE42InNgg+KNa4uJFERBaTdgNlu1MwxigHBxwLxA43oPZYQNDo0IwSt99OtteSOJ9rn
        eQf0PYQ+IM4VN4toCGcaANfVak7NCXyOnZ6BPDlTkYbp0k9Cp9+32CWUCbOSqpGOiE1Kfy
        m4ynqokpMBMowUUdBlyPnYE62JHcJj8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3BF513A9B
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 06:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iShUKTwRWWLfeAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 06:31:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs-progs: discourage users from setting seed flag on multi-device filesystem
Date:   Fri, 15 Apr 2022 14:31:07 +0800
Message-Id: <ab69c04203bc44a71c1efe2dde9df2eb5b392405.1650004139.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

Currently kernel and btrfs-progs all maintain two fs_devices, one for rw
devices, one for read-only (seed) devices.

The reason is we allow seed flag set on multi-device filesystems.

However I'm not sure if most seed device usage care about multi-device
support.

If we can deprecate multi-device seed filesystem support, in the long
run we can replace the seed fs_devices with just one btrfs_device
pointer and make sense much cleaner.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfstune.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/btrfstune.c b/btrfstune.c
index c9a92349a44c..52bef8ba2ced 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -51,6 +51,9 @@ static int update_seeding_flag(struct btrfs_root *root, int set_flag)
 	disk_super = root->fs_info->super_copy;
 	super_flags = btrfs_super_flags(disk_super);
 	if (set_flag) {
+		struct list_head *list;
+		int num_devs = 0;
+
 		if (super_flags & BTRFS_SUPER_FLAG_SEEDING) {
 			if (force)
 				return 0;
@@ -59,6 +62,20 @@ static int update_seeding_flag(struct btrfs_root *root, int set_flag)
 						device);
 			return 1;
 		}
+		list_for_each(list, &root->fs_info->fs_devices->devices)
+			num_devs++;
+		/*
+		 * Multi-device seed fs is still supported in kernel, but
+		 * that's really making fs_devices more complex than it should
+		 * be, especially multi-device seed is rarely used.
+		 */
+		if (num_devs > 1) {
+			warning("setting seed flag on mult-device fs is not recommended");
+			if (!force) {
+				error("abort setting seed, use -f to force it");
+				return 1;
+			}
+		}
 		super_flags |= BTRFS_SUPER_FLAG_SEEDING;
 	} else {
 		if (!(super_flags & BTRFS_SUPER_FLAG_SEEDING)) {
-- 
2.35.1

