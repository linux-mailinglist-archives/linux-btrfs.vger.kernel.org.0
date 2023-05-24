Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6570EFA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbjEXHl5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 03:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbjEXHlz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 03:41:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31AD8F
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 00:41:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACEB522435
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684914112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIAw/2Qb+ZXZkszKOZh52aoZ9E4wSHooqysN4RC4IBs=;
        b=jcfIS0LzIxvjkh+3AfIfReNLU6ANRThYKEBcEFaa+CtU6uyw54j4vucbq9B9m8DR3fUwE+
        i+FwA1KuUYGWPdgvhgJb2kUrvwFlLzAmRg/bfFU6ThRI6U5xG/YjmqvRLiM2c8IKswXlcs
        kdVXHlZSBoetcw9I3CzY31CwnCPigeA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0374C13425
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6OkHML+/bWSiRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs-progs: tune: implement resume support for empty csum tree
Date:   Wed, 24 May 2023 15:41:27 +0800
Message-Id: <6a45bc14a406c86552e6446f9e78dae3489f26b5.1684913599.git.wqu@suse.com>
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

We have a very rare chance to hit a fs with empty csum tree but still
has CHANGING_DATA_CSUM flag.

The window is very small, but it's still possible, so handle it by
jumping directly to metadata csum change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index 05bddaa48d27..aef3b05a0d9d 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -828,6 +828,13 @@ static int resume_data_csum_change(struct btrfs_fs_info *fs_info,
 	if (ret == 0)
 		new_csum_found = true;
 
+	/*
+	 * No csum item found at all, this fs has empty csum tree.
+	 * Just go metadata change.
+	 */
+	if (!old_csum_found && !new_csum_found)
+		goto new_meta_csum;
+
 	/*
 	 * Only old csums exists. This can be one of the two cases:
 	 * - Only the csum change item inserted, no new csum generated.
-- 
2.40.1

