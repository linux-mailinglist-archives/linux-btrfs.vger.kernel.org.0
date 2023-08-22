Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ECC783AB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 09:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjHVHSX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 03:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjHVHRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 03:17:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDC31A4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 00:17:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 14EC01F892
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 07:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692688525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2IQyYjd+Jm03zpxA1BVQdD96WFAJCxrZQNAXXdExCU=;
        b=qXFniv2Bnj5Guv8cNsv6Mrcqk4PiPhmo+sO8enVASQ1mHVHm8kPhB8M7UAb9hF/MTIwtb6
        QLXNu4V/nhAHQzkirB4MfB/Iyt8pLFVt52/bDi+71TUBazCVoptr2UXeOtwv2lfuSFp9t5
        UTn8WsTdZTJgVT+ElUR6ZsJWGM0t2lE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69A6813919
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 07:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QKIuDYxg5GSDTwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 07:15:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: check: add advice to avoid --init-csum-tree
Date:   Tue, 22 Aug 2023 15:15:18 +0800
Message-ID: <f97557777956f2369d988f0cc6d5cf2d3aae4172.1692688214.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692688214.git.wqu@suse.com>
References: <cover.1692688214.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We already had a report about "btrfs check --init-csum-tree" screwing up
a seemingly fine btrfs (which can pass "btrfs check --readonly" without
error).

This is mostly due to the fact that --init-csum-tree just screw up the
csum tree root, and rely on extent tree repair code to repair the damage
caused by ourselves.

This patch would recommend the end users to go "btrfstune --csum" if
that option is present.

This has some extra benefits:

- More protection/tests on interrupred conversion

- No unrelated changes to subvolume and extent trees
  But this requires the original fs to be mostly fine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/check/main.c b/check/main.c
index d66e10e8fd4d..9a52463269b1 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10153,6 +10153,15 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		printf("\tsome software or hardware bugs can fatally damage a volume.\n");
 		printf("\tThe operation will start in %d seconds.\n", delay);
 		printf("\tUse Ctrl-C to stop it.\n");
+
+#if EXPERIMENTAL
+		if (init_csum_tree) {
+			printf("\n");
+			printf("\t--init-csum-tree is considered dangerous, if your fs is fine,\n");
+			printf("\tplease use \"btrfstune --csum\" instead, which is considered\n");
+			printf("\tmuch safer\n");
+		}
+#endif
 		while (delay) {
 			printf("%2d", delay--);
 			fflush(stdout);
-- 
2.41.0

