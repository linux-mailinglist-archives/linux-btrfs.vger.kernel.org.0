Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFFF527724
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiEOKzZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiEOKzY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 06:55:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546C515811
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 03:55:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC15D1F8A4
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652612121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfIo3ICz44q7yw/HymnYpa0aZ95nApZdg8csEPLW6OM=;
        b=JelWx5Lv4g721lEvjTEgP/jaYUust3hn2LPkf6psU3AP6Umg3W/Fk8l4Vg8b6MRaeJ5cSY
        KOU2RahJWzMcvUQ1ixrI5VoM2q7YMO6Up/9gkmLEHlSUmtdLveReCX3z+n15Fq5VQlz0cP
        T38+AYKH6eBfDukzSmJ6g72LPjObNLQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7B6213491
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UEU3JBjcgGLsfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs-progs: mkfs: add support for RAID56J creation
Date:   Sun, 15 May 2022 18:54:57 +0800
Message-Id: <ca02098b92b797eb94a098e6773123280e27ca7c.1652611957.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652611957.git.wqu@suse.com>
References: <cover.1652611957.git.wqu@suse.com>
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

The major part is already done in the RAID56J feature introduce commit,
for mkfs the only special part is about setting the
BTRFS_FEATURE_INCOMPAT_RAID56_JOURNAL flag and the extra incompat flags.

Unlike kernel, btrfs-progs doesn't automatically set the flag based on
the chunk type, but has to do it at mkfs time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 9 +++++++++
 mkfs/main.c         | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 23a92c21a2cc..86637606e6af 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -142,6 +142,15 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "new extent tree format"
 	},
+	{
+		.name		= "raid56-journal",
+		.flag		= BTRFS_FEATURE_INCOMPAT_RAID56_JOURNAL,
+		.sysfs_name	= "raid56_journal",
+		VERSION_TO_STRING2(compat, 6,10),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "write-ahead journal for RAID56"
+	},
 #endif
 	/* Keep this one last */
 	{
diff --git a/mkfs/main.c b/mkfs/main.c
index 4e0a46a77aa5..1187440c8db2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1286,6 +1286,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			"\t to be used besides testing or evaluation.\n");
 	}
 
+	if ((data_profile | metadata_profile) & BTRFS_BLOCK_GROUP_JOURNAL_MASK)
+		features |= BTRFS_FEATURE_INCOMPAT_RAID56_JOURNAL;
+
 	if ((data_profile | metadata_profile) &
 	    (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4)) {
 		features |= BTRFS_FEATURE_INCOMPAT_RAID1C34;
-- 
2.36.1

