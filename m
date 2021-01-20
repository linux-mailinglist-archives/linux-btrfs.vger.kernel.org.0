Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684152FD02C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbhATMCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:02:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:36130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbhATK0O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:26:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5lF3H6yD58RaL6mBaomXNvI7aVHTGT3vlQnwnwNMTA=;
        b=YMpttjXnled3KLhZh+sJrycAePSsVOqD2nHhuwuq+goz8mIl8lkhf4bRNywv5TEe67BjT4
        qNNlZrC3ophj8I5R6QG9W4KIySDUUALsgnQfFuP8QSO2KPjFyCc1LhNaQZilQ4kg8yifrm
        pJ2rp9m3IdDA5EbfAU4obcZHGapz0Qk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D219AC97;
        Wed, 20 Jan 2021 10:25:28 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 01/14] btrfs: Document modified paramater of add_extent_mapping
Date:   Wed, 20 Jan 2021 12:25:13 +0200
Message-Id: <20210120102526.310486-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120102526.310486-1-nborisov@suse.com>
References: <20210120102526.310486-1-nborisov@suse.com>
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

