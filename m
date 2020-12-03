Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59DF2CDD7E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502033AbgLCSZO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502022AbgLCSZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:12 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA821C09424C
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:42 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y197so3006637qkb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IURlmIE58ARQOAEaOHeShyPcEluY8RP7eeBOsM9Ef/s=;
        b=YLv91oAPgtWSegN2cBRSBJzwUqLBLq6n4T7Dcl3xfvw5qedD56Fuftko6N40i56fVQ
         59wZWzQvPraEaxd1VM8z/tdatylX61LTNwuXnH1rED7GXEYfW+jDWwURWFoc1Q+NEIog
         H0Nwj3n336WiGhkCQbQOWs+7mdHMvuwp4WAOjDyANolFn4Ep5Radb28UDcldWbn50sPh
         RWmL10du3thSpY9cYGMkQNngfY9WkCHiHBIQ5yIT+6t7VVCdDMp7DteS4eotz4yJqceB
         EhMuhqZ7FRdmd1ePNDotqYQjfgY4uwxEgWkVB9xVSSlJTU3B5EA4zDBix3Biu50JFf05
         I6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IURlmIE58ARQOAEaOHeShyPcEluY8RP7eeBOsM9Ef/s=;
        b=bY1c18VQafeHFWBx21Q2981MVyY36wJrUpwXQw0AE8Iy4DxNoPM7PBNl+7iX9Fs6sg
         ctcJ8vqxqlFtufbo5rbzWDjoRy3F5icFnr7thJAJSCwobB7AePHUOodL34av9aabRPEA
         rPFZx5ZTvXMxIHw6ueAEqBbkaDI/DAviTs6IbI1sEMr20AP4uYJCGX1pTbHejjp2bazR
         ozN8yqwNubZXM72qFnaxKX1UMRwVhAx7L0nc1/i319VVuLvdMnUMQyCLdkP6WiIjpmDI
         TQA4SHTMkCCFaw/kwC0KjgwIxK2+EMRxDVVhZ1FNrT69QhjJRrGzKs0NI5/cM+epieXg
         98mA==
X-Gm-Message-State: AOAM532ZEcE2G/YLMGBSY1+UXpB//uCbgYHZBesvAWc8bPF3/G8Jxlg3
        fm5J3IySeR+cze8laM/OvoO0Z+DLWcMATsBl
X-Google-Smtp-Source: ABdhPJyUveGZcnKSdaNRLJ9/JgIlLM/GZYyLz41TVqVyckIFicqkkfjoh8XAvX5u+F6E4JdXezD89Q==
X-Received: by 2002:a05:620a:11a4:: with SMTP id c4mr4263262qkk.8.1607019821625;
        Thu, 03 Dec 2020 10:23:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 67sm2271147qkk.120.2020.12.03.10.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 23/53] btrfs: btrfs: handle btrfs_record_root_in_trans failure in relocate_tree_block
Date:   Thu,  3 Dec 2020 13:22:29 -0500
Message-Id: <9052fe172f26e1b3e2098c214e87b315df7fe3ee.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in relocate_tree_block.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 90a0a8500a83..4356af112025 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2552,7 +2552,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 				ret = -EUCLEAN;
 				goto out;
 			}
-			btrfs_record_root_in_trans(trans, root);
+			ret = btrfs_record_root_in_trans(trans, root);
+			if (ret)
+				goto out;
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2

