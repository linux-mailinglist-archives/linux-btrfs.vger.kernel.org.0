Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C02FCFE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbhATMP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:15:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:37880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730330AbhATK10 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:27:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P1O78DNJDlp6+SGgyO/dnm1uWOi3+9sI5aPoeV140Ao=;
        b=chs6IecdBBv+keMmo1Izf3ySrK+7IeX8MSQ7YTl8AF5i3RqaPFWaUwT4CByo1IAbvj0U/q
        YNzJQksSJK0yhs2kurG5ZI/AKz6atlXBLYLMp3vXk8az9J5+IZLeJ+eGdWDiNn8cZts1ZA
        7AxXN34ylb6lbWqLx2gGkco2A0cobbg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57B26AFF0;
        Wed, 20 Jan 2021 10:25:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 06/14] btrfs: Document now parameter of peek_discard_list
Date:   Wed, 20 Jan 2021 12:25:18 +0200
Message-Id: <20210120102526.310486-7-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120102526.310486-1-nborisov@suse.com>
References: <20210120102526.310486-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes fs/btrfs/discard.c:203: warning: Function parameter or member 'now' not described in 'peek_discard_list'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/discard.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 2b8383d41144..0b9f69f6de56 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -186,9 +186,10 @@ static struct btrfs_block_group *find_next_block_group(
 
 /**
  * peek_discard_list - wrap find_next_block_group()
- * @discard_ctl: discard control
+ * @discard_ctl:   discard control
  * @discard_state: the discard_state of the block_group after state management
  * @discard_index: the discard_index of the block_group after state management
+ * @now:           time when discard was invoked, in ns
  *
  * This wraps find_next_block_group() and sets the block_group to be in use.
  * discard_state's control flow is managed here.  Variables related to
-- 
2.25.1

