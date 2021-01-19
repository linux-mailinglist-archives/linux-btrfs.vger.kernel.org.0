Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889652FB9DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbhASOi0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 09:38:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:37154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404797AbhASM1j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 07:27:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611059212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5lF3H6yD58RaL6mBaomXNvI7aVHTGT3vlQnwnwNMTA=;
        b=euHdnfW625xz9ENaQ7dTPMh1IjYXR1xHHagGe3j3l5ZqCZLxf4RoFGrhQrHwMvfvG3KF9+
        +09TCbah781vAnbaPxRBHh1aoyVZ0kOA9WZDQBLtyYrIrRWCV6aU70KHnN91a4kurbQ6jC
        eANXPP2E7JfbqNQMjRLtsWQnPDnJGYA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C7FEAB7F;
        Tue, 19 Jan 2021 12:26:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 01/13] btrfs: Document modified paramater of add_extent_mapping
Date:   Tue, 19 Jan 2021 14:26:37 +0200
Message-Id: <20210119122649.187778-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119122649.187778-1-nborisov@suse.com>
References: <20210119122649.187778-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes fs/btrfs/extent_map.c:399: warning: Function parameter or member
'modified' not described in 'add_extent_mapping'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_map.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index bd6229fb2b6f..aa1ff6f2ade9 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -388,6 +388,8 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
  * add_extent_mapping - add new extent map to the extent tree
  * @tree:	tree to insert new map in
  * @em:		map to insert
+ * @modified:	bool indicating whether the given @em should be added to the
+ *	        modified list, which indicates the extent needs to be logged
  *
  * Insert @em into @tree or perform a simple forward/backward merge with
  * existing mappings.  The extent_map struct passed in will be inserted
-- 
2.25.1

