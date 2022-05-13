Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FDE525DE8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378686AbiEMIvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378617AbiEMIvc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 04:51:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA552311D5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 01:51:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 09B1021887
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652431890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Bh6tvwiD3IakXfTciancT1Fh08OLpd/CKdZ/yQHLEcI=;
        b=UXKR/INt9RymKFMjN1TnjHdp61OCbEJveEGDhPdIpHcifwqwJL03ocKUbjIkRONvuv91Wk
        t/x470BHPSt38s2LRE6B36knqNWWRgK2jNqjgu5bgSAa7LwdzVifAp1ZDjtHiv1mY+LOj0
        2lsaQKQXgm27H1eiXclXOxYFSdXMHuY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C03A13446
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B3uZChEcfmI8agAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:51:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: convert: initialize the target fs label
Date:   Fri, 13 May 2022 16:51:10 +0800
Message-Id: <bde751b337d81bed2754ae69544fb7fd43d8191f.1652431869.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

[BUG]
When running some tests, I notice that my debug build of btrfs-convert
is throwing out garbage for target fs label:
  $ ./btrfs-convert  ~/test.img
  btrfs-convert from btrfs-progs v5.17

  Source filesystem:
    Type:           ext2
    Label:
    Blocksize:      4096
    UUID:           29d159a8-cb46-41d3-8089-3c5c65e4afae
  Target filesystem:
    Label:          @pcwU	<<< Garbage here
    Blocksize:      4096
    Nodesize:       16384
    UUID:           682bf5f2-8cb1-4390-b9ac-6883cd87ed39
    Checksum:       crc32c
  ...

[CAUSE]
The fslabel[] array is just not initialized, thus it can contain
garbage.

[FIX]
Initialize fslabel[] array to all zero.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert/main.c b/convert/main.c
index b72d1e51ee3e..c22d810163c8 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1822,7 +1822,7 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 	int usage_error = 0;
 	int progress = 1;
 	char *file;
-	char fslabel[BTRFS_LABEL_SIZE];
+	char fslabel[BTRFS_LABEL_SIZE] = {0};
 	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
 	u16 csum_type = BTRFS_CSUM_TYPE_CRC32;
 	u32 copy_fsid = 0;
-- 
2.36.1

