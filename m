Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76425943D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 00:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiHOV5A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 17:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350477AbiHOV4U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 17:56:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A35A61D51
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 12:34:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A33CC34CA2;
        Mon, 15 Aug 2022 19:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660592044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=vInumailDKJ00cekPKKdKodFs+fgM0zjHT43b/B7WCs=;
        b=NghlkBWDNJ/+MKYU2niHiA7glzlmtddx29sP6cD/ll814ZxClM35448ityGzee9favhT1D
        g8Fh9GtaMmzyuIF6LpVUfCKXLLsN6cYYz9/o8UMwxJInF12gQcoAdGrCYm7rdkIzZ3x6ks
        z32wEWzmL6L/LsJRq59o8x27AbHz8J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660592044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=vInumailDKJ00cekPKKdKodFs+fgM0zjHT43b/B7WCs=;
        b=FPaHtFlu2boqXgmT2qFce63mBOAxZ1pajrAnv9nRPl6sVgp5hrmgg4MtBIfzHafc0AET7J
        ox/3rvKBM7ySdDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 503E713A99;
        Mon, 15 Aug 2022 19:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tHgCC6yf+mLsXQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Mon, 15 Aug 2022 19:34:04 +0000
Date:   Mon, 15 Aug 2022 14:34:02 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: [PATCH] Check if root is readonly while setting xattr
Message-ID: <20220815193402.7fmuwafu3qpalniz@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For a filesystem which has btrfs read-only property set to true, all
write operations including xattr should be denied. However, security
xattr can still be changed even if btrfs ro property is true.

This patch checks if the root is read-only before performing the set
xattr operation.

Testcase: 

#!/bin/bash

DEV=/dev/vdb
MNT=/mnt

mkfs.btrfs -f $DEV
mount $DEV $MNT
echo "file one" > $MNT/f1
setfattr -n "security.one" -v 2 $MNT/f1
btrfs property set $MNT ro true

# Following statement should fail
setfattr -n "security.one" -v 1 $MNT/f1

umount $MNT

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 7421abcf325a..5bb8d8c86311 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -371,6 +371,9 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
 				   const char *name, const void *buffer,
 				   size_t size, int flags)
 {
+	if (btrfs_root_readonly(BTRFS_I(inode)->root))
+		return -EROFS;
+
 	name = xattr_full_name(handler, name);
 	return btrfs_setxattr_trans(inode, name, buffer, size, flags);
 }

-- 
Goldwyn
