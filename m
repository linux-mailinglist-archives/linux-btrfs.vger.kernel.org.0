Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3955947D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiFXIB3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 04:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiFXIB2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 04:01:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94EB6B8C9
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 01:01:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F1F01F8D2;
        Fri, 24 Jun 2022 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656057686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ht4dKFfn03I4X4x9YcpISq+moTfWPFSXQ/s7MgzcHfE=;
        b=qpayMrkbRJAv0+c3yNg5qe7gQxoY+k+7JEtWjbis+OoR4fXcXvcBqYNSJG9bTnyb/DGCSG
        AONPM0okG0KN8eKQ3WOFSI5wN147K2Pgqa51esdAoHReOp1vhkZBF9lER5ObcMvX33eQLl
        ajfxAzoJmHWV/aGE7q89ncb/aCBWb7g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C07B13ACA;
        Fri, 24 Jun 2022 08:01:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UIoYCFZvtWLmXAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 24 Jun 2022 08:01:26 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: remove MIXED_BACKREF sysfs file
Date:   Fri, 24 Jun 2022 11:01:22 +0300
Message-Id: <20220624080123.1521917-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624080123.1521917-1-nborisov@suse.com>
References: <20220624080123.1521917-1-nborisov@suse.com>
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

This feature has been the default for about 13 year. At this point it's
safe to consider it an indispensable feature of BTRFS as such there's
no need to advertise it in sysfs. Simply remove the sysfs file.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d4502f0e4fca..715d1e725f2a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -276,7 +276,6 @@ static umode_t btrfs_feature_visible(struct kobject *kobj,
 	return mode;
 }
 
-BTRFS_FEAT_ATTR_INCOMPAT(mixed_backref, MIXED_BACKREF);
 BTRFS_FEAT_ATTR_INCOMPAT(default_subvol, DEFAULT_SUBVOL);
 BTRFS_FEAT_ATTR_INCOMPAT(mixed_groups, MIXED_GROUPS);
 BTRFS_FEAT_ATTR_INCOMPAT(compress_lzo, COMPRESS_LZO);
@@ -308,7 +307,6 @@ BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
  *                               can be changed on a mounted filesystem.
  */
 static struct attribute *btrfs_supported_feature_attrs[] = {
-	BTRFS_FEAT_ATTR_PTR(mixed_backref),
 	BTRFS_FEAT_ATTR_PTR(default_subvol),
 	BTRFS_FEAT_ATTR_PTR(mixed_groups),
 	BTRFS_FEAT_ATTR_PTR(compress_lzo),
-- 
2.25.1

