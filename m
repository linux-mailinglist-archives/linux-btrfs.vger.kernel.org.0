Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47FA390729
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 19:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhEYRMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 13:12:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:33996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhEYRMh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 13:12:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621962666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmyEfB/+idAc/pAxEBdpj9v5P/SmFU4PzfpWtmqlKpk=;
        b=XQZUplO7VbfwMv9NdjMDal6pl2J8y5OkLmIBGTvJwDDmo4CQjtGX7izTsjSLHYQuuJsFEe
        3STvRC8o3cgGzOmSTWQms2IEtn3tzbK4zo6ChtGvM/7b651vbdYhyiN9XIuyAVOg7d6f9E
        DvAAOea6k+evyH7A910IRuUoC/SB4e4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A586AEEB;
        Tue, 25 May 2021 17:11:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1EDEEDA70B; Tue, 25 May 2021 19:08:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/9] btrfs: clear log tree recovering status if starting transaction fails
Date:   Tue, 25 May 2021 19:08:30 +0200
Message-Id: <2a572b691dd9f79de5649894dd24ea555913e1c7.1621961965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621961965.git.dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a log recovery is in progress, lots of operations have to take that
into account, so we keep this status per tree during the operation. Long
time ago error handling revamp patch 79787eaab461 ("btrfs: replace many
BUG_ONs with proper error handling") removed clearing of the status in
an error branch. Add it back as was intended in e02119d5a7b4 ("Btrfs:
Add a write ahead tree log to optimize synchronous operations").

There are probably no visible effects, log replay is done only during
mount and if it fails all structures are cleared so the stale status
won't be kept.

Fixes: 79787eaab461 ("btrfs: replace many BUG_ONs with proper error handling")
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c6d4aeede159..5c1d58706fa9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6372,6 +6372,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 error:
 	if (wc.trans)
 		btrfs_end_transaction(wc.trans);
+	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.29.2

