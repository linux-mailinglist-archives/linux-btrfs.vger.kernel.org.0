Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7161AF948
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Apr 2020 12:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgDSKOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Apr 2020 06:14:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30626 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725927AbgDSKOh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Apr 2020 06:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587291274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8baLkYkh/KcmTrmqVwBM6+ZAc7sVyDzY0epJyjGRumI=;
        b=UwlL/VrPRJRfuISzF5Bneo8vyScJMyDeTi1ZYqYjsCl2d0x2BLB5EIgRYKmlmMBltFQ/lc
        jTYDNz3kwkRkv+HlMqHtsYVK/I3cUmeAeliURztWzBvSp0N1AI1STGk4ksDv0NoHOc1XTN
        C3bpHQLOJZYPB+ZSLlI5KsznThWvsio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-IW6iJNaTNWq4C8M4BsYEhA-1; Sun, 19 Apr 2020 06:14:32 -0400
X-MC-Unique: IW6iJNaTNWq4C8M4BsYEhA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 261DD107ACC9;
        Sun, 19 Apr 2020 10:14:31 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFB6D7E7FA;
        Sun, 19 Apr 2020 10:14:28 +0000 (UTC)
Date:   Sun, 19 Apr 2020 12:14:32 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
Cc:     Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH] btrfs: move enum btrfs_compression_type to the UAPI header
Message-ID: <20200419101432.GA32249@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It is passed in struct btrfs_ioctl_defrag_range_args.compress_type
to BTRFS_IOC_DEFRAG_RANGE, so it has to be a part of UAPI.
Also, rely on enum definition rules to get BTRFS_NR_COMPRESS_TYPES
value and mark it as non-ABI.

Complements: 33ca913349962208 ("btrfs: uapi/linux/btrfs.h migration, move struct btrfs_ioctl_defrag_range_args")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 fs/btrfs/compression.h     |  9 +--------
 include/uapi/linux/btrfs.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index d253f7a..3483b26 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_COMPRESSION_H
 #define BTRFS_COMPRESSION_H
 
+#include <linux/btrfs.h>
 #include <linux/sizes.h>
 
 /*
@@ -100,14 +101,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
-enum btrfs_compression_type {
-	BTRFS_COMPRESS_NONE  = 0,
-	BTRFS_COMPRESS_ZLIB  = 1,
-	BTRFS_COMPRESS_LZO   = 2,
-	BTRFS_COMPRESS_ZSTD  = 3,
-	BTRFS_NR_COMPRESS_TYPES = 4,
-};
-
 struct workspace_manager {
 	struct list_head idle_ws;
 	spinlock_t ws_lock;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index e6b6cb0f..82cc9ac 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -558,6 +558,16 @@ struct btrfs_ioctl_clone_range_args {
  */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
+
+enum btrfs_compression_type {
+	BTRFS_COMPRESS_NONE  = 0,
+	BTRFS_COMPRESS_ZLIB  = 1,
+	BTRFS_COMPRESS_LZO   = 2,
+	BTRFS_COMPRESS_ZSTD  = 3,
+
+	BTRFS_NR_COMPRESS_TYPES /* non-ABI */
+};
+
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
-- 
2.1.4

