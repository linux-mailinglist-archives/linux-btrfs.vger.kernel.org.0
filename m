Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6583570EFA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbjEXHl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbjEXHl5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 03:41:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231628F
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 00:41:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6BD51F8AF
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684914114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vWXCQxtBz9MeG5eAvn5ZK7HbiFICHkqVFgk/FisX2s=;
        b=DLCk2zNnz75x90do85JsdkiD9WZifpSzYo1fbiOPYN8h/GmkJHsgMGF7drMzZdaWYItxqF
        /RvPXHIY6AfgXl7wZKDURJTnVK6ocROv8gQZMqwa2Cub43Mn5OjowRLlp7h6H6KaS9Z7x0
        aCZSxNJzECZaJWSgns9bNcuFXsOSL9s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18B9013425
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AAw3NcG/bWSiRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs-progs: tune: implement resume support for data csum objectid change
Date:   Wed, 24 May 2023 15:41:29 +0800
Message-Id: <dd9b8d324a06067f7cb93628d41c1c8276594138.1684913599.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684913599.git.wqu@suse.com>
References: <cover.1684913599.git.wqu@suse.com>
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

When the csum conversion is interrupted when changing data csum
objectid, we should just resume the objectid conversion.

This situation can be detected by comparing the old and new csum items.
They should both exist but doesn't intersect (interrupted halfway), or
only new csum items exist (interrupted after we have deleted old csums).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index 2ec2d6cc5271..dad39c3ec854 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -885,8 +885,26 @@ static int resume_data_csum_change(struct btrfs_fs_info *fs_info,
 	    new_csum_last >= old_csum_last)
 		goto delete_old;
 
-	/* Other cases are not yet supported. */
-	return -EOPNOTSUPP;
+	/*
+	 * Both csums exist but not covering each other, or only new csum exists.
+	 *
+	 * This means we have already deleted all the old csums, is going to or
+	 * have already started objectid change.
+	 */
+	if ((old_csum_found && new_csum_found && old_csum_last <= new_csum_first) &&
+	    (!old_csum_found && new_csum_found))
+		goto change;
+
+	/* The remaining cases should not be possible. */
+	error("unexpected resume condition:");
+	error("old csum found=%d start=%llu last=%llu new csum found=%d start=%llu last=%llu",
+		old_csum_found,
+		old_csum_found ? old_csum_first : 0,
+		old_csum_found ? old_csum_last : 0,
+		new_csum_found,
+		new_csum_found ? new_csum_first : 0,
+		new_csum_found ? new_csum_last : 0);
+	return -EUCLEAN;
 
 new_data_csums:
 	ret = generate_new_data_csums_range(fs_info, resume_start, new_csum_type);
@@ -899,6 +917,7 @@ delete_old:
 	ret = delete_old_data_csums(fs_info);
 	if (ret < 0)
 		return ret;
+change:
 	ret = change_csum_objectids(fs_info);
 	if (ret < 0)
 		return ret;
-- 
2.40.1

