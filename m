Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BBA587869
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 09:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiHBHxF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiHBHxE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 03:53:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30E115E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 00:53:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC55B33A96
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 07:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659426782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeGIfw2Qk1J74Idjhmkkv0uOzzQcB13W/NJiu7vtZYg=;
        b=N3l2bzvU6AH53glZ1TGOFud23M6lVDDETNRIJMAN4aKDnP+GEsYauO3Rte1rKpIPanKz61
        YB+uM40cXPqDl8vtit07X9BX2LQOBUQJq7swvHW7+WcPuHZKVgrA6Cnm+DQeupgOGUaOeg
        TMa5knkca0+zG7v9qxvOYRErp9Wmohc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2223413A8E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 07:53:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sLkgOd3X6GKlOgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 07:53:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs-progs: fix a BUG_ON() condition for write_data_to_disk()
Date:   Tue,  2 Aug 2022 15:52:42 +0800
Message-Id: <3ed19a7c38fb1144d3425f9b52e3f669d5a9279d.1659426744.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659426744.git.wqu@suse.com>
References: <cover.1659426744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The BUG_ON() condition in write_data_to_disk() is no longer correct.

Now write_raid56_with_parity() will return the bytes written of last
stripe.

Thus a success writeback can trigger the BUG_ON(ret).

Fix the condition to (ret < 0).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index a05249815bb1..48bcf2cf2f96 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -990,7 +990,7 @@ int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
 			memcpy(eb->data, buf + total_write, this_len);
 			ret = write_raid56_with_parity(info, eb, multi,
 						       stripe_len, raid_map);
-			BUG_ON(ret);
+			BUG_ON(ret < 0);
 
 			free(eb);
 			kfree(raid_map);
-- 
2.37.0

