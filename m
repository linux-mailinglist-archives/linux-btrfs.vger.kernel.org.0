Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBAD421ECC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhJEGXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:23:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51010 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEGXy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:23:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47182223BF
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 06:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633414923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1mSi3J2Q8rsavsCnyc5DaAVI0e3dP0aF86cvQM9Ei5k=;
        b=gdOxpYORfc+KgW3vgFcmoPab90/m/60GvfltdUUEx/n8xczs0CwsYbJ0DzejMGY9YVq8VE
        nZ9qpZTjsWCfFRhnEJ4I9RdjhXlKb5qZzTfAYFuIyYPX40XfEe0wq78KbW/iD3QqTuhQei
        iMMYCf0Yki6kEy9htGWw55FbOwAGrfc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D77E1342A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 06:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lHleFArvW2EDLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 06:22:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: compression: update the comment for alloc_compressed_bio()
Date:   Tue,  5 Oct 2021 14:21:44 +0800
Message-Id: <20211005062144.68489-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This comment will include all parameters, not only the new
@next_stripe_start.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 69a19d51fa35..cba82fdae7e5 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -438,9 +438,19 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * To allocate a compressed_bio, which will be used to read/write on-disk data.
+ * To allocate a compressed_bio, which will be used to read/write on-disk
+ * (aka, compressed) data.
  *
- * @next_stripe_start:	Disk bytenr of next stripe start
+ * @cb:		The compressed_bio structure, which records all the needed
+ * 		info to bind the compressed data to the uncompressed page cache.
+ * @disk_byten:	The logical bytenr where the compressed data will be read from
+ * 		or written to.
+ * @endio_func:	The endio function to call after the IO for compressed data is
+ * 		finished.
+ * @next_stripe_start:
+ * 		The Return value of Logical bytenr of where next stripe start.
+ * 		To inform the caller to only fill the bio up to the stripe
+ * 		boundary.
  */
 static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
 					unsigned int opf, bio_end_io_t endio_func,
-- 
2.33.0

