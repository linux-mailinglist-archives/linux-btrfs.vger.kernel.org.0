Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F365964D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 23:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiHPVnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 17:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiHPVnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 17:43:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEAD80B56
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 14:43:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34E72337DF;
        Tue, 16 Aug 2022 21:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660686179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=e6o8iT33dGrvPeNXI05sMVJOlXUeUTMmHPgdqvh9A6g=;
        b=I9qkJ0vbvJTSQs1xMP5+8qbegC8OLAWSiIbd++zx5KNlavoF9f8OUnjlicgNoj9wgFAPtd
        ipBhqhMsxEsVnzwM1jA/s0i3p3hl0u4iaSO1g2GOhuECbrHeIQqNDvSt/koWqq+pl2Ag78
        oGyfXNOcoRjnMzITu1jokJ9e89Rh+2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660686179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=e6o8iT33dGrvPeNXI05sMVJOlXUeUTMmHPgdqvh9A6g=;
        b=78DhsRGZC8g4DpihBpJa6iDvrQiMzR6cEf6bFxzP7zei6rWiJ5kgFNV+jDu+deWT1hFu9b
        akalNKFpsCJih2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6E971345B;
        Tue, 16 Aug 2022 21:42:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iWxWGmIP/GJjIQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 16 Aug 2022 21:42:58 +0000
Date:   Tue, 16 Aug 2022 16:42:56 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org
Subject: [PATCH v2] btrfs: Check if root is readonly while setting security
 xattr
Message-ID: <20220816214256.t5ikj7pyqe6l6qgn@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For a filesystem which has btrfs read-only property set to true, all
write operations including xattr should be denied. However, security
xattr can still be changed even if btrfs ro property is true.

This happens because xattr_permission() does not have any restrictions
on security.*, system.*  and in some cases trusted.* from VFS and
the decision is left to the underlying filesystem. See comments in
xattr_permission() for more details.

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
btrfs property set /mnt ro true

# Following statement should fail
setfattr -n "security.one" -v 1 $MNT/f1

umount $MNT

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>


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
