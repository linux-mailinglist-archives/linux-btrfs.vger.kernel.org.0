Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1AB2FFFF1
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbhAVKOx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:14:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:56136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbhAVJ7I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 04:59:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2vvEqnBTmuFupWNIga98trZCfyZ8zEMUa3jTuOvNIY=;
        b=CFcNEt5wgK+b3luHLNXqlzx3Q/J72LIIn0jfUqNP+dzhywtS67h2c/tdQRzyiXQliLN07h
        olLoDgk4j8WO/grqpcKvM53izVHOaW9KWSPA1vZTwB/Wp955FUhDGZXvxcdGUXW0YqAUBm
        fqJJOOtbf+QGjPaUM/v03gz6CGltByk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34278AC45;
        Fri, 22 Jan 2021 09:58:07 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 01/14] btrfs: Document modified parameter of add_extent_mapping
Date:   Fri, 22 Jan 2021 11:57:52 +0200
Message-Id: <20210122095805.620458-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes fs/btrfs/extent_map.c:399: warning: Function parameter or member
'modified' not described in 'add_extent_mapping'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_map.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index bd6229fb2b6f..c540a37cbdb2 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -385,9 +385,12 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 }
 
 /**
- * add_extent_mapping - add new extent map to the extent tree
+ * Add new extent map to the extent tree
+ *
  * @tree:	tree to insert new map in
  * @em:		map to insert
+ * @modified:	bool indicating whether the given @em should be added to the
+ *	        modified list, which indicates the extent needs to be logged
  *
  * Insert @em into @tree or perform a simple forward/backward merge with
  * existing mappings.  The extent_map struct passed in will be inserted
-- 
2.25.1

