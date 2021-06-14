Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585423A6C4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 18:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhFNQqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 12:46:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37832 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhFNQqq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 12:46:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4038A21994;
        Mon, 14 Jun 2021 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623689082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p+OSrYtE3+hs044mobAuWvYC+kElD53cTfFcB7g39XE=;
        b=FuObNnayStjWkCWCwhHO1r8DjBstuhQGIWhNKMUENuzrjNk/YR88zWk/rf21LmboilsRzY
        w0Lnc86BQh6WKjslbRKLijuOuq9UG4DvkoBzl7c+iMhgU8AV3tMRsLzWQY7bCVelAuB94P
        8fBTk+who+i0d9XQcCwu4mdGalAaegI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3A980A3B96;
        Mon, 14 Jun 2021 16:44:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F06DDAF4C; Mon, 14 Jun 2021 18:41:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: props: change how empty value is interpreted
Date:   Mon, 14 Jun 2021 18:41:53 +0200
Message-Id: <20210614164153.23326-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Based on user feedback and actual problems with compression property,
there's no support to unset any compression options, or to force no
compression flag.

Note: This has changed recently in e2fsprogs 1.46.2, 'chattr +m'
(setting NOCOMPRESS).

In btrfs properties, the empty value should really mean reset to
defaults, for all properties in general. Right now there's only the
compression one, so this change should not cause too many problems.

Old behaviour:

  $ lsattr file
  ---------------------- file
  # the NOCOMPRESS bit is set
  $ btrfs prop set file compression ''
  $ lsattr file
  ---------------------m file

This is equivalent to 'btrfs prop set file compression no' in current
btrfs-progs as the 'no' or 'none' values are translated to an empty
string.

This is where the new behaviour is different: empty string drops the
compression flag (-c) and nocompress (-m):

  $ lsattr file
  ---------------------- file
  # No change
  $ btrfs prop set file compression ''
  $ lsattr file
  ---------------------- file
  $ btrfs prop set file compression lzo
  $ lsattr file
  --------c------------- file
  $ btrfs prop get file compression
  compression=lzo
  $ btrfs prop set file compression ''
  # Reset to the initial state
  $ lsattr file
  ---------------------- file
  # Set NOCOMPRESS bit
  $ btrfs prop set file compression no
  $ lsattr file
  ---------------------m file

This obviously brings problems with backward compatibility, so this
patch should not be backported without making sure the updated
btrfs-progs are also used and that scripts have been updated to use the
new semantics.

Summary:

- old kernel:
  no, none, "" - set NOCOMPRESS bit
- new kernel:
  no, none - set NOCOMPRESS bit
  "" - drop all compression flags, ie. COMPRESS and NOCOMPRESS

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/props.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index a17e53e700b1..b1cb5a8c2999 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -260,6 +260,10 @@ static int prop_compression_validate(const char *value, size_t len)
 	if (btrfs_compress_is_valid_type(value, len))
 		return 0;
 
+	if ((len == 2 && strncmp("no", value, 2) == 0) ||
+	    (len == 4 && strncmp("none", value, 4) == 0))
+		return 0;
+
 	return -EINVAL;
 }
 
@@ -269,7 +273,17 @@ static int prop_compression_apply(struct inode *inode, const char *value,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int type;
 
+	/* Reset to defaults */
 	if (len == 0) {
+		BTRFS_I(inode)->flags &= ~BTRFS_INODE_COMPRESS;
+		BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
+		BTRFS_I(inode)->prop_compress = BTRFS_COMPRESS_NONE;
+		return 0;
+	}
+
+	/* Set NOCOMPRESS flag */
+	if ((len == 2 && strncmp("no", value, 2) == 0) ||
+	    (len == 4 && strncmp("none", value, 4) == 0)) {
 		BTRFS_I(inode)->flags |= BTRFS_INODE_NOCOMPRESS;
 		BTRFS_I(inode)->flags &= ~BTRFS_INODE_COMPRESS;
 		BTRFS_I(inode)->prop_compress = BTRFS_COMPRESS_NONE;
-- 
2.31.1

