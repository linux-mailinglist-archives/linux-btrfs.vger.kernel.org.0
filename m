Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43540D43C
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 10:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhIPIFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 04:05:15 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53916
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234850AbhIPIFC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 04:05:02 -0400
Received: from LT2ubnt.fritz.box (unknown [46.253.247.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DCFF53F345;
        Thu, 16 Sep 2021 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631779367;
        bh=71e9OL1S5S9bgGjtBy4TW+RgQHRN9YyU18N5+1yA9QI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=PMCGl7vLUNxpUlgJ8rS0iozq/xQIR0bgx4ChWsqP1LYd5+9hUJREshiWMS85MuGlW
         fD9f/DeUN/KQd4p9nmczBR102hS9t1hGg66gMDVV05wCN8jbFazvxcrT8+3I+zsd81
         vrRxYyYbd9NlSmiWfH49LqrjFZATHWxrtzvkiLkL7oXZn6Eyuw00/6djH6YdV1rUbk
         iP4Ff7Vp+H0UNpWP55ZVaZu2QqUWmsgFcH7Pws8QRob7yYAY89HS2NCyCpLXvB+RuO
         9aIiE7kC+YSQSk6DUwNSGOx49lybBEbzwlJZJsgueuuqH4lzZdagVuwqyI2J2yNLf8
         hHaiECE5UeXKQ==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] fs: btrfs: avoid superfluous messages
Date:   Thu, 16 Sep 2021 10:02:45 +0200
Message-Id: <20210916080245.42757-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Output like the following is quite irritating:

    => bootefi hello
    Scanning disk mmc2.blk...
    No valid Btrfs found
    Bad magic number for SquashFS image.
    ** Unrecognized filesystem type **
    Scanning disk mmc1.blk...
    No valid Btrfs found
    Bad magic number for SquashFS image.
    ** Unrecognized filesystem type **
    Scanning disk mmc0.blk...
    No valid Btrfs found
    Bad magic number for SquashFS image.
    ** Unrecognized filesystem type **

It is expected that most partitions don't contain a Btrfs. This is only
worth a debug message.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 12f9579fcf..7a4fb0d259 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <common.h>
 #include <fs_internal.h>
+#include <log.h>
 #include <uuid.h>
 #include <memalign.h>
 #include "kernel-shared/btrfs_tree.h"
@@ -918,7 +919,7 @@ static int btrfs_scan_fs_devices(struct blk_desc *desc,
 
 	ret = btrfs_scan_one_device(desc, part, fs_devices, &total_devs);
 	if (ret) {
-		fprintf(stderr, "No valid Btrfs found\n");
+		log_debug("No valid Btrfs found\n");
 		return ret;
 	}
 	return 0;
-- 
2.32.0

