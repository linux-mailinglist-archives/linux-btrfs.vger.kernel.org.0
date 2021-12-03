Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E60A467235
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 07:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378653AbhLCGvs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 01:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhLCGvr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 01:51:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F5C06174A;
        Thu,  2 Dec 2021 22:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cgumDvF/SvvAwGatAQcfW/TSl74/7WNzdYZKLNvlSWI=; b=YJadRQGoEGNKj7n6OYngPI/7mE
        buIYGRT373KpxW9c+J86+urCWUoWSpwLjpW29gXuMqVAukzkqPXYMyXDAZo3kNun2uQnd43cieb7X
        J9PMatTOWubUDtjpdo37TPJ/F7OMEF8IW7YzVDvP2hIolHmJ/vkxSx/DTFPa9noXBlli3S9ZFWdZI
        9lkOLPKRj61m00k09v4XuuybkqyxEcuxPzcljuHXh5qpHNWZ0c0VPQV25zX5zblGcjvZf7CxmyYGo
        jNjAX0ByXTlXe0YD0fFvca0UO4HpxOgTm1cURRJKvby/Pj9hK2WQp5vmIcH49zWlZ+I6TxtAAMHKh
        V27vBtyA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt2Mo-00EbYm-Gy; Fri, 03 Dec 2021 06:48:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: convert comment to kernel-doc format
Date:   Thu,  2 Dec 2021 22:48:20 -0800
Message-Id: <20211203064820.27033-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Complete kernel-doc notation for btrfs_zone_activate() to prevent
kernel-doc warnings:

zoned.c:1784: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Activate block group and underlying device zones
zoned.c:1784: warning: missing initial short description on line:
 * Activate block group and underlying device zones

Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
---
 fs/btrfs/zoned.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211202.orig/fs/btrfs/zoned.c
+++ linux-next-20211202/fs/btrfs/zoned.c
@@ -1781,7 +1781,7 @@ struct btrfs_device *btrfs_zoned_get_dev
 }
 
 /**
- * Activate block group and underlying device zones
+ * btrfs_zone_activate - Activate block group and underlying device zones
  *
  * @block_group: the block group to activate
  *
