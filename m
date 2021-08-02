Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9E13DD5B0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhHBMeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 08:34:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34572 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhHBMeU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Aug 2021 08:34:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA6961FF87;
        Mon,  2 Aug 2021 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627907645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BewH+bks2/FkGv7UN96IANRKQHoVG5sgtPnw02H5Zk0=;
        b=oDQylJcV138PxNeTzs4kncNASimQYkKB3hqKj4Q45W+CoZsKDZviUZLCkQb0w5TyK/C0e7
        xot9hR6tev/dcod9p0bEQxKc3uHLkm8QnbcRi575xngtIZq3S1ywFGpP68VU/TvqAI3h0T
        VrBUeuYTDw1LoB0ZvmXd5Hag+NA6sh8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CCA213C6C;
        Mon,  2 Aug 2021 12:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q0AvCjzmB2GBagAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Mon, 02 Aug 2021 12:34:04 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, fdmanana@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: tree-log: Check btrfs_lookup_data_extent return value
Date:   Mon,  2 Aug 2021 09:34:00 -0300
Message-Id: <20210802123400.2687-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function btrfs_lookup_data_extent calls btrfs_search_slot to verify if
the EXTENT_ITEM exists in the extent tree. btrfs_search_slot can return
values bellow zero if an error happened.

Function replay_one_extent currently check if the search found something
(0 returned) and increments the reference, and if not, it seems to evaluate as
'not found'.

Fix the condition by checking if the value was bellow zero and return early.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 Found while inspecting some btrfs_search_slot call sites.

 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 567adc3de11a..867ea0be0665 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -753,7 +753,9 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			 */
 			ret = btrfs_lookup_data_extent(fs_info, ins.objectid,
 						ins.offset);
-			if (ret == 0) {
+			if (ret < 0) {
+				goto out;
+			} else if (ret == 0) {
 				btrfs_init_generic_ref(&ref,
 						BTRFS_ADD_DELAYED_REF,
 						ins.objectid, ins.offset, 0);
-- 
2.26.2

