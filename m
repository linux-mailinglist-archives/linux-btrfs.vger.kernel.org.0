Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0945553FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 21:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351124AbiFVTIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 15:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiFVTIM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 15:08:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784051146F
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 12:08:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1F7301F86A;
        Wed, 22 Jun 2022 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655924890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=f6lLshYhxEV5Eas+7x91ISZfY2wos7J9Qda6/NCJh/I=;
        b=ePGxAGpcqNKTKKJ9MKmqAMsKArKn/o66E+PrmPKWMMwuE3rvIpCHffIRDgFgwddmZZgLQF
        1L0R5KooavD7PkX/aSqdGHgeChIFpiQWX/YjLf2fuX4bWp/HlbWFr96+21aQ3P01ybHfnb
        A2P1QiGR8eazGWNyJUpOHtnK6+N0h+0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0EF222C141;
        Wed, 22 Jun 2022 19:08:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7C90DA82F; Wed, 22 Jun 2022 21:03:32 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     forza@tnonline.net, David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: print checksum type and implementation at mount time
Date:   Wed, 22 Jun 2022 21:03:31 +0200
Message-Id: <20220622190331.5480-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Per user request, print the checksum type and implementation at mount
time among the messages. The checksum is user configurable and the
actual crypto implementation is useful to see for performance reasons.
The same information is also available after mount in
/sys/fs/FSID/checksum file.

Example:

  [25.323662] BTRFS info (device vdb): using sha256 (sha256-generic) checksum algorithm

Link: https://github.com/kdave/btrfs-progs/issues/483
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8592eaf6de53..debfc756d67e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2410,6 +2410,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 
 	fs_info->csum_shash = csum_shash;
 
+	btrfs_info(fs_info, "using %s (%s) checksum algorithm",
+			btrfs_super_csum_name(csum_type),
+			crypto_shash_driver_name(csum_shash));
 	return 0;
 }
 
-- 
2.36.1

