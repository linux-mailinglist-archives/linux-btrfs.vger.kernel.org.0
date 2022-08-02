Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5097587D73
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiHBNve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiHBNvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 09:51:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B2248D9
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 06:51:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D2113756D;
        Tue,  2 Aug 2022 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659448291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8y4B6ucbBDnG+CNvtrmouUgxGJTaKnYTPu9OLXyXw50=;
        b=Lao1U6XHW4ex5wO6GayG5nhBD2f0D05qCzD1C+VUy8mEN67JcVNjTsd2x1VLndrvXQzjbH
        VbQOZD//3XR1GVE4ZQcIbGm+Fhi/1bmR03MCcVslpPecxekhRyXfOPBMWorPgxWWlK7hGH
        QTsxta1236lJBq03J03vD+VvkMNsklA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1726D2C1DC;
        Tue,  2 Aug 2022 13:51:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 60E2FDA85A; Tue,  2 Aug 2022 15:46:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: sysfs: use sysfs_streq for string matching
Date:   Tue,  2 Aug 2022 15:46:28 +0200
Message-Id: <20220802134628.3464-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have own string matching helper that duplicates what sysfs_streq
does, with a slight difference that it skips initial whitespace. So far
this is used for the drive allocation policy. The initial whitespace
of written sysfs values should be rather discouraged and we should use a
standard helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 32714ef8e22b..84a992681801 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1150,25 +1150,6 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, generation, btrfs_generation_show);
 
-/*
- * Look for an exact string @string in @buffer with possible leading or
- * trailing whitespace
- */
-static bool strmatch(const char *buffer, const char *string)
-{
-	const size_t len = strlen(string);
-
-	/* Skip leading whitespace */
-	buffer = skip_spaces(buffer);
-
-	/* Match entire string, check if the rest is whitespace or empty */
-	if (strncmp(string, buffer, len) == 0 &&
-	    strlen(skip_spaces(buffer + len)) == 0)
-		return true;
-
-	return false;
-}
-
 static const char * const btrfs_read_policy_name[] = { "pid" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
@@ -1202,7 +1183,7 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 	int i;
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
-		if (strmatch(buf, btrfs_read_policy_name[i])) {
+		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
 			if (i != fs_devices->read_policy) {
 				fs_devices->read_policy = i;
 				btrfs_info(fs_devices->fs_info,
-- 
2.36.1

