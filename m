Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7129EB3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgJ2MDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:03:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:33026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgJ2MDN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:03:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603972992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UuliTuPqMbWq27q/dNDTCzYDx7SKTv25MWhrkC0Q8U=;
        b=D7VS/fQ7mDfybq73YKIDo6F5gU+Gky69Ey/E9cXLQX5iFFSDDTQ1KiQ2zT9BKwJBx+0jq2
        Hl4WvmbqbUmIYPOIILc8YqxF5XmEnJoKAuxdtoDFp+jxgEeF/tPO+X4ONZYUJRA1DPhCYF
        O0F4llDshI4rNHQn2xhPsEXaDEOJFBY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93F6BACF1;
        Thu, 29 Oct 2020 12:03:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75167DA7D9; Thu, 29 Oct 2020 13:01:37 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 8/8] btrfs: scrub: update message regarding read-only status
Date:   Thu, 29 Oct 2020 13:01:37 +0100
Message-Id: <430a7645f00ee787a9fb54f0f32e6b20dd0c0a24.1603972767.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603972767.git.dsterba@suse.com>
References: <cover.1603972767.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Based on user feedback update the message printed when scrub fails to
start due to write requirements. To make a distinction add a device id
to the messages.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 54a4f34d4c1c..04351b55dd14 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3870,8 +3870,9 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	if (!is_dev_replace && !readonly &&
 	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-		btrfs_err_in_rcu(fs_info, "scrub: device %s is not writable",
-				rcu_str_deref(dev->name));
+		btrfs_err_in_rcu(fs_info,
+			"scrub on devid %llu: filesystem on %s is not writable",
+				 devid, rcu_str_deref(dev->name));
 		ret = -EROFS;
 		goto out;
 	}
-- 
2.25.0

