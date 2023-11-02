Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62927DEC51
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 06:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348556AbjKBFeU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 01:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348533AbjKBFeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 01:34:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709B812C
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 22:34:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF5FA215EE
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 05:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698903250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9MXKkOVGBXEnhTBHXJFuZSDwCpHr5r3pxdIhgYGGlU=;
        b=IZpFFGVfM2o+Xn4/NLLqPRLMXhxdRKdtThq+EHl4Yc7fZa9eMUh6ljnxHyVTU89bNpmt2C
        yzvZ/4dL10beCQ7e8lILZZ+KvVRoWJGCYZGDHYz5yIHcD4xYjcgcKufm6NzBaIaJD9074U
        mB5ou0YqI7zvvrH+PaQYVlinGldPKsg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC23D13460
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 05:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IFxVKdE0Q2U/AwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Nov 2023 05:34:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: subvolume create: handle failure for strdup()
Date:   Thu,  2 Nov 2023 16:03:48 +1030
Message-ID: <8c3df11d55b5add76a6abfd7896762697520a136.1698903010.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698903010.git.wqu@suse.com>
References: <cover.1698903010.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function strdup() can return NULL if the system is out of memory,
thus we need to hanle the rare but possible -ENOMEM case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/subvolume.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 8504c380c9ee..bccc4968dad3 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -194,8 +194,17 @@ static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **a
 	}
 
 	dupname = strdup(dst);
+	if (!dupname) {
+		error("out of memory when duplicating %s", dst);
+		goto out;
+	}
 	newname = basename(dupname);
+
 	dupdir = strdup(dst);
+	if (!dupdir) {
+		error("out of memory when duplicating %s", dst);
+		goto out;
+	}
 	dstdir = dirname(dupdir);
 
 	if (!test_issubvolname(newname)) {
-- 
2.42.0

