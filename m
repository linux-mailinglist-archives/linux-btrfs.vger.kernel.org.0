Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1832D4C8A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Dec 2020 22:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbgLIVKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Dec 2020 16:10:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:49312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbgLIVKj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Dec 2020 16:10:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9E84B1C3
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Dec 2020 21:09:57 +0000 (UTC)
Date:   Wed, 9 Dec 2020 15:09:55 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH] btrfs-progs: Fix buffer pointer while reading
 exclusive_operation
Message-ID: <20201209210955.hcgai4ougmjeiwys@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While performing the sysfs read for the exclusive_operation, the buffer
pointer is incorrectly subtracted. This reads the file incorrectly and hence
BTRFS_EXCLOP_UNKNOWN is passed everytime the function is called.

Fixes: 1abf37eb btrfs-progs: add helpers for parsing filesystem exclusive operation
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/common/utils.c b/common/utils.c
index 3dc1fdc1..ff29cb81 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1952,7 +1952,7 @@ int get_fs_exclop(int fd)
 		return BTRFS_EXCLOP_UNKNOWN;
 
 	memset(buf, 0, sizeof(buf));
-	ret = sysfs_read_file(sysfs_fd, buf - 1, sizeof(buf));
+	ret = sysfs_read_file(sysfs_fd, buf, sizeof(buf));
 	close(sysfs_fd);
 	if (ret <= 0)
 		return BTRFS_EXCLOP_UNKNOWN;

-- 
Goldwyn
