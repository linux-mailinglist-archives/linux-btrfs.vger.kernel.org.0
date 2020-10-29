Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905FA29EB35
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgJ2MDF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:03:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:32826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2MDC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:03:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603972981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLmS+CYBgiF6GLApXm1gvMNjOw3ZXatjRzlfQ7VF0H4=;
        b=jfbgqxHk3FXKx4vwADrnb9xrEPhuJ0/uiaw+VdDLElXR4+RUdhp+Xvl8CfOyL5/nFfqGSk
        LIMJjGx1LZcJV5umStg6IJGtnGLvwXiiL9T7bmcZuPyuUeajVudi3rxGebPAx0TAfn/oEn
        kNCjvUugGgpec0sMH2QKteynHP21pgk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1689BACF1;
        Thu, 29 Oct 2020 12:03:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 372E4DA7D9; Thu, 29 Oct 2020 13:01:26 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/8] btrfs: send: use helpers to access root_item::ctransid
Date:   Thu, 29 Oct 2020 13:01:26 +0100
Message-Id: <14dd40acf1cc3fd82ae77f23033b7efa18e22e42.1603972767.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603972767.git.dsterba@suse.com>
References: <cover.1603972767.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have helpers to access the on-disk item members, use that for
root_item::ctransid instead of raw le64_to_cpu.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 340c76a12ce1..d719a2755a40 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2410,7 +2410,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 			    sctx->send_root->root_item.uuid);
 
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_CTRANSID,
-		    le64_to_cpu(sctx->send_root->root_item.ctransid));
+		    btrfs_root_ctransid(&sctx->send_root->root_item));
 	if (parent_root) {
 		if (!btrfs_is_empty_uuid(parent_root->root_item.received_uuid))
 			TLV_PUT_UUID(sctx, BTRFS_SEND_A_CLONE_UUID,
@@ -2419,7 +2419,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 			TLV_PUT_UUID(sctx, BTRFS_SEND_A_CLONE_UUID,
 				     parent_root->root_item.uuid);
 		TLV_PUT_U64(sctx, BTRFS_SEND_A_CLONE_CTRANSID,
-			    le64_to_cpu(sctx->parent_root->root_item.ctransid));
+			    btrfs_root_ctransid(&sctx->parent_root->root_item));
 	}
 
 	ret = send_cmd(sctx);
@@ -5101,7 +5101,7 @@ static int send_clone(struct send_ctx *sctx,
 		TLV_PUT_UUID(sctx, BTRFS_SEND_A_CLONE_UUID,
 			     clone_root->root->root_item.uuid);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_CLONE_CTRANSID,
-		    le64_to_cpu(clone_root->root->root_item.ctransid));
+		    btrfs_root_ctransid(&clone_root->root->root_item));
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_CLONE_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_CLONE_OFFSET,
 			clone_root->offset);
-- 
2.25.0

