Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DEB4E5BC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 00:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345472AbiCWXZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 19:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbiCWXZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 19:25:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D61636C
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:23:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48C5C210E9
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 23:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648077819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bQA2E423eIrqbTUcQUW2j2cvq7j9AioaOeSOJsgVWCE=;
        b=mwICf4YBdRpKE9vmKsmXrUE31qKpJ04SUZgXr7WpRmJhS848u304A9nxHkAIjzzk9vYv32
        Tiuibl15ylbmP0CmpizGDle6jHvCcuglndqXLr3d6XvMKZx/cPvR6hOXqBpNM3o1pkRMzj
        ifVV2EbDA7VDskQ8KJ137DyipLXLUfk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EA3013302
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 23:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VjdTGvqrO2LMHQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 23:23:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: check: fix return value override in do_check_chunks_and_extents()
Date:   Thu, 24 Mar 2022 07:23:21 +0800
Message-Id: <f576d7a548b91d42d02b17d2dc52ee04d943a57d.1648077794.git.wqu@suse.com>
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

Patch "btrfs-progs: check: add check and repair ability for super num
devs mismatch" is causing fsck/014 to fail.

The cause is that in do_check_chunks_and_extents() we can override the
return value.

Fix it by simply exit early if we found any problems in chunk/extent
tree.
As super num devices is really a minor problem compared to any
chunk/extent tree corruption.

Please fold this one into patch "btrfs-progs: check: add check and
repair ability for super num devs mismatch".
As there are quite some comments update in devel branch already.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/check/main.c b/check/main.c
index 8465e91d1d43..dbf0a6b00564 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9133,6 +9133,14 @@ static int do_check_chunks_and_extents(void)
 		if (ret > 0)
 			ret = 0;
 	}
+
+	/*
+	 * If we have error unfixed, exit right now, as super num is
+	 * really a minor problem compared to any problems found above.
+	 */
+	if (ret)
+		return ret;
+
 	ret = check_and_repair_super_num_devs(gfs_info);
 	return ret;
 }
-- 
2.35.1

