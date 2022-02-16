Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187BE4B85FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 11:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiBPKiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 05:38:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiBPKiF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 05:38:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC60165C21
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 02:37:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 981121F37D
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645007872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=x34m4n5XzUcvzjgERo8+7039LCqRyyYBj7CtJ/Qnzyo=;
        b=cyCH7Gud3NFcKCaxCso/hCaPwb+9Hsh1gqGj4+sgvRAs3P2/dp7EndaI7SYWDoPZHW1fQ3
        mdqXH/EUM1vRY9DKxbI3hxCzuspgC3/IGLgstrA3gUUOyz/JBX4D1vRlafkn7tpzMOL1yH
        qBD925whmGgJZ5WL4BfIhNx/SsFald4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2DD513A95
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 10:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nt+RKf/TDGLYFQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 10:37:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: cmds/prop: don't change fattr string to "" if it's "none" or "no"
Date:   Wed, 16 Feb 2022 18:37:34 +0800
Message-Id: <ebaa6a2cae0296d00ea8fd3ee771a0c563e6a4f3.1645007807.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since kernel commit 548c8c6f55b ("btrfs: props: change how empty value is
interpreted"), "" for btrfs.compression fattr has its own meaning (no
special compression setting, fallback to default values).

And the new "" meaning is different from NOCOMPRESSION, so the change
needs corresponding btrfs-progs change to separate the behaviors.

This patch will remove the special handling for "none"/"no", so that we
can properly set "none"/"no" for btrfs.compression fattr, other than
always falling back to "".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/property.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/cmds/property.c b/cmds/property.c
index b3ccc0ff69b0..bfe118285abb 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -189,13 +189,11 @@ static int prop_compression(enum prop_object_type type,
 	memcpy(xattr_name + XATTR_BTRFS_PREFIX_LEN, name, strlen(name));
 	xattr_name[XATTR_BTRFS_PREFIX_LEN + strlen(name)] = '\0';
 
-	if (value) {
-		if (strcmp(value, "no") == 0 || strcmp(value, "none") == 0)
-			value = "";
+	if (value)
 		sret = fsetxattr(fd, xattr_name, value, strlen(value), 0);
-	} else {
+	else
 		sret = fgetxattr(fd, xattr_name, NULL, 0);
-	}
+
 	if (sret < 0) {
 		ret = -errno;
 		if (ret != -ENOATTR)
-- 
2.35.1

