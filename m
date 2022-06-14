Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8254BDF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 00:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356998AbiFNW47 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 18:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354011AbiFNW46 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 18:56:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4620A36E34
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:56:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0319D1F9BD
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655247417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4K3OOKL3xPcmTQ8M3SZS2NHCdqXLzRWaV7h5dGOjVyU=;
        b=FSKdxjgD2nwAvMX36xA8qeCTSVIP+p7uczhmtEJZkkqUL82UKWYISCLTqVB3ILdakKartV
        HbtCLp+EC3yYlkpTHWElZXHlARY1fSz029/48MTGe8mTPKIOk95I3/+UnUcPU8CYxV1ahh
        xMA2UtiggKDf0fW7cPiOpko4XmBK/fU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 574BA139EC
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id METnCDgSqWI3cAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:56:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH DRAFT 4/6] btrfs-progs: print-tree: support btrfs_super_block::reserved_bytes
Date:   Wed, 15 Jun 2022 06:56:32 +0800
Message-Id: <0cbdab998ab2a6d42ab4a9763f432ef381ed2a57.1655247047.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655247047.git.wqu@suse.com>
References: <cover.1655247047.git.wqu@suse.com>
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

This only needs two things:

- Add readable flags for EXTRA_SUPER_RESERVED flag

- Add optional output for reserved_bytes

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index db486553f448..918ebe02144a 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1668,6 +1668,7 @@ struct readable_flag_entry {
 static struct readable_flag_entry compat_ro_flags_array[] = {
 	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE),
 	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE_VALID),
+	DEF_COMPAT_RO_FLAG_ENTRY(EXTRA_SUPER_RESERVED),
 };
 static const int compat_ro_flags_num = sizeof(compat_ro_flags_array) /
 				       sizeof(struct readable_flag_entry);
@@ -2051,6 +2052,11 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 	printf("block_group_root_level\t%llu\n",
 	       (unsigned long long)btrfs_super_block_group_root_level(sb));
 
+	if (btrfs_super_compat_ro_flags(sb) &
+	    BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED)
+		printf("reserved_bytes\t\t%u\n",
+			btrfs_super_reserved_bytes(sb));
+
 	uuid_unparse(sb->dev_item.uuid, buf);
 	printf("dev_item.uuid\t\t%s\n", buf);
 
-- 
2.36.1

