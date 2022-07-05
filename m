Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1A556643E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGEHiU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiGEHiP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:38:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211A13D09
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:38:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC91D224B3
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pb0pWgqh+XloG6uLmHSEsuxcpzByISClI/AhFBxLFQI=;
        b=DKGX6nNQGKIBTl7Tvvr/7/5fRrAunJITU1cG+QXgvRLRO4SYnpLS44NhoDiSqOmtmDbKYt
        /clxz2API/FbXnTdRaggxNw9c/2vbCf+1iT1qnZ/tgVRSkD4kTESs3lj0oy4cB8ianCKOV
        MPcqUNmpHZjAIw513dj7dYdjy4AK+ws=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5281E1339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IKDsB2Lqw2JTOwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:38:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs-progs: print-tree: remove duplicated definition for compat RO flags
Date:   Tue,  5 Jul 2022 15:37:42 +0800
Message-Id: <2dc05d30faf9cee819ec77a1cc9c8e7353f55abc.1657006141.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657006141.git.wqu@suse.com>
References: <cover.1657006141.git.wqu@suse.com>
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

In print_readable_compat_ro_flag(), we provide
BTRFS_FEATURE_COMPAT_RO_SUPP | BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID for supported flags.

However BTRFS_FEATURE_COMPAT_RO_SUPP already includes the latter two
flags.

Just remove the unnecessary flags.

Signed-off-by: Qu Wenruo <wqu@suse.com>

t#
---
 kernel-shared/print-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index a5886ff602ee..db486553f448 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1754,9 +1754,7 @@ static void print_readable_compat_ro_flag(u64 flag)
 	 */
 	return __print_readable_flag(flag, compat_ro_flags_array,
 				     compat_ro_flags_num,
-				     BTRFS_FEATURE_COMPAT_RO_SUPP |
-				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
-				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
+				     BTRFS_FEATURE_COMPAT_RO_SUPP);
 }
 
 static void print_readable_incompat_flag(u64 flag)
-- 
2.36.1

