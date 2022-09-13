Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606F25B688B
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIMHUD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 03:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiIMHTw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 03:19:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E1311165
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 00:19:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC76F5BEE8
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663053585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWDwslo1Y4C8Y6uoyGwp+2ZLuS6kc87S4Ywh7naJBM0=;
        b=XeGhtk5OQZOLRND4SuotAetxGVPXc4qcbATjb05deH8XDDQ6SLaFHUn8eT27ZY80elIr+t
        ySDLQqKk/Xp27h0a2BgPw4NwDrCyJW/uYjWSG/Nuqg/j7BeOjcOE151eliRKXwjgtc4wNO
        gt1637+c8Vcva6+189wME2lJtW9o8h0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5041813AB5
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kAZOBxEvIGMOfAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:19:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: unexport csum_tree_block()
Date:   Tue, 13 Sep 2022 15:19:25 +0800
Message-Id: <2e7fa0afb6a4788de55bb1c4067dbfb41a4d96b8.1663053391.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663053391.git.wqu@suse.com>
References: <cover.1663053391.git.wqu@suse.com>
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

The function csum_tree_block() is not really utilized by anyone, all
current callers just use csum_tree_block_size().

Furthermore there is a stale definition in common/utils.h which is using
the old "struct btrfs_root" as the first argument, while we have already
migrated to "struct btrfs_fs_info".

So just unexport csum_tree_block() and remove the stale definition.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/utils.h          | 2 --
 kernel-shared/disk-io.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/common/utils.h b/common/utils.h
index ea05fe5b21fe..f6cdb7f4dc70 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -61,8 +61,6 @@ int set_label(const char *btrfs_dev, const char *label);
 int check_arg_type(const char *input);
 int get_label_mounted(const char *mount_path, char *labelp);
 int get_label_unmounted(const char *dev, char *label);
-int csum_tree_block(struct btrfs_fs_info *root, struct extent_buffer *buf,
-		    int verify);
 int ask_user(const char *question);
 int lookup_path_rootid(int fd, u64 *rootid);
 int find_mount_fsroot(const char *subvol, const char *subvolid, char **mount);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 2701c464cbfc..857280cc7cb7 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -208,8 +208,8 @@ int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size,
 	return __csum_tree_block_size(buf, csum_size, 1, 1, csum_type);
 }
 
-int csum_tree_block(struct btrfs_fs_info *fs_info,
-		    struct extent_buffer *buf, int verify)
+static int csum_tree_block(struct btrfs_fs_info *fs_info,
+			   struct extent_buffer *buf, int verify)
 {
 	u16 csum_size = fs_info->csum_size;
 	u16 csum_type = fs_info->csum_type;
-- 
2.37.3

