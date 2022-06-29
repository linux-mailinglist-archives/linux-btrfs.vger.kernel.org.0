Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0D55FEE3
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 13:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiF2Liz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 07:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiF2Liy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 07:38:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4F23EA89
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 04:38:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC9501F915;
        Wed, 29 Jun 2022 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656502731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mr46B25ZUmI7GGQ5t6X0E3WzxzV6Pf3dl/rRvmfxgMo=;
        b=tL3h0ntz3WnvxLfQCfHSy9GEJQEqRVPYTeVHkeVDiwaJMDhAwDjPMS7uWKU74AbAirvRCt
        hOZG2iMVwhKsjXrTQHSYEJMdWCxEFgziBQYLYsi22sGvR7NurtDarCmtvnswQ8poHqnpEz
        +HWFwTjxTRqtTqwBf5tnMD7a/LdFHDo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAF30133D1;
        Wed, 29 Jun 2022 11:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0M6THck5vGLFPwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 29 Jun 2022 11:38:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 1/8] fs: fat: unexport file_fat_read_at()
Date:   Wed, 29 Jun 2022 19:38:22 +0800
Message-Id: <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656502685.git.wqu@suse.com>
References: <cover.1656502685.git.wqu@suse.com>
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

That function is only utilized inside fat driver, unexport it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/fat/fat.c  | 4 ++--
 include/fat.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index df9ea2c028fc..dcceccbcee0a 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1243,8 +1243,8 @@ out_free_itr:
 	return ret;
 }
 
-int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
-		     loff_t maxsize, loff_t *actread)
+static int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
+			    loff_t maxsize, loff_t *actread)
 {
 	fsdata fsdata;
 	fat_itr *itr;
diff --git a/include/fat.h b/include/fat.h
index bd8e450b33a3..a9756fb4cd1b 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -200,8 +200,6 @@ static inline u32 sect_to_clust(fsdata *fsdata, int sect)
 int file_fat_detectfs(void);
 int fat_exists(const char *filename);
 int fat_size(const char *filename, loff_t *size);
-int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
-		     loff_t maxsize, loff_t *actread);
 int file_fat_read(const char *filename, void *buffer, int maxsize);
 int fat_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info);
 int fat_register_device(struct blk_desc *dev_desc, int part_no);
-- 
2.36.1

