Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30627651F83
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 12:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiLTLNo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 06:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiLTLNh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 06:13:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF9D19019
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 03:13:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD44E6132F
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 11:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5EC433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 11:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671534816;
        bh=buODtMqPpZaMzbrctujKELqhVSaCxg+lAHqnwObQZsU=;
        h=From:To:Subject:Date:From;
        b=KMpZyhc+jxrFTtpmnzy02yh5QWm8CDCXhFD9uWSyy6s5f6vZFPPAz5SkWlBxehA5D
         i7Hqt3oQ9udEO6+UvbQmnemKcHPN2xVWTLoNgUbNECRgXNNp60An6Wt6h8raLmWbQS
         DQoWYc6eMbtog/1SVCLaaKf7hajV1iyApsINfWPkF9POZgCLhI+Emc6SHXRm87tIET
         fO2Zv5aHs0vxh0v8jPztKuJFiOg/DK5OFYZl8IVVbL+9KNVcaz7LWY6Nlob+jwqzWQ
         kYYeHyebk158nElUuur2eBfrT4vyBAhErGb3jiSs4o2HpOnJjEO2cFkESNUgLVBIJK
         vgNhZZGIArKlg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix fscrypt name leak after failure to join log transaction
Date:   Tue, 20 Dec 2022 11:13:33 +0000
Message-Id: <c76a4f058227e32861e0afe1e1851137304a2169.1671534537.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a new name, we don't expect to fail joining a log transaction
since we know at least one of the inodes was logged before in the current
transaction. However if we fail for some unexpected reason, we end up not
freeing the fscrypt name we previously allocated. So fix that by freeing
the name in case we failed to join a log transaction.

Fixes: ab3c5c18e8fa ("btrfs: setup qstr from dentrys using fscrypt helper")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a3c43f0b1c95..fb52aa060093 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7459,8 +7459,11 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		 * not fail, but if it does, it's not serious, just bail out and
 		 * mark the log for a full commit.
 		 */
-		if (WARN_ON_ONCE(ret < 0))
+		if (WARN_ON_ONCE(ret < 0)) {
+			fscrypt_free_filename(&fname);
 			goto out;
+		}
+
 		log_pinned = true;
 
 		path = btrfs_alloc_path();
-- 
2.35.1

