Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61B42FFFBE
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbhAVKFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:05:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:58228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbhAVKAS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 05:00:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvI5gl2SqYzEciFjbblPT00fom5R5ei9XyNrcn61e4M=;
        b=POm8Rabkit4KK+ThUJy2OMo45i/uliVayP3R2Nj66/TVpFmoDNYpje0mYidSZUkJe/VgR7
        4OSLtFzatdEcyD+tAZgNtfxmzNHGN5R1UBa0ZqxmD6eGnHoDjN2osIJ3aMzbP8RzW0hFCf
        /9XlZUF3iFUpAna9RantU4gB2izj84E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57C8FAF7B;
        Fri, 22 Jan 2021 09:58:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 06/14] btrfs: Document now parameter of peek_discard_list
Date:   Fri, 22 Jan 2021 11:57:57 +0200
Message-Id: <20210122095805.620458-7-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes fs/btrfs/discard.c:203: warning: Function parameter or member 'now' not described in 'peek_discard_list'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/discard.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 2b8383d41144..306ff20af70f 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -185,10 +185,12 @@ static struct btrfs_block_group *find_next_block_group(
 }
 
 /**
- * peek_discard_list - wrap find_next_block_group()
- * @discard_ctl: discard control
+ * Wrap find_next_block_group()
+ *
+ * @discard_ctl:   discard control
  * @discard_state: the discard_state of the block_group after state management
  * @discard_index: the discard_index of the block_group after state management
+ * @now:           time when discard was invoked, in ns
  *
  * This wraps find_next_block_group() and sets the block_group to be in use.
  * discard_state's control flow is managed here.  Variables related to
-- 
2.25.1

