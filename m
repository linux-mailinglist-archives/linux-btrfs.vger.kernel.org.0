Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D292CC731
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbgLBTxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbgLBTx3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:29 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A5C08E9AA
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:16 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z188so2458843qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ux6kb1oPImsvcNd1bSX4gOEAsxeEfeZNSXoy0UM5v5A=;
        b=Obpzvc54ulx8GTRq2PuKO6EzySLWy06U/yRgmfcf9WYmNKUswB8t95NwCdXdswv8At
         59naaC00eAgYGfBy0Mfbf0kNP6Nlrjex9eNxXGa3itFruRowU0eiNMfh00RhIzciEPkh
         T4AHxxdPR9w2Ts0jnx9pHEESeC1lwEYMc9fI9DhmRCo6GCqtgUibHf/5IpkkjeE3e9mp
         sdJqIzfTVa6q3CmHUQCCTdvPsifk5hCQuA9utnjYFzGqKWHyKGjiRskQDEQ+VocblWOd
         CNCWhYn63xmgA01kAryyQEq4eeOIfyzyabbY5dsm/lg+7L+nfqfHIBFcm9b27x9uq4Gk
         scvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ux6kb1oPImsvcNd1bSX4gOEAsxeEfeZNSXoy0UM5v5A=;
        b=rHYlrbSnrMmTp++BzV96lxc8l2MAh9+F2JOJTkDGgm1jnPO8j8wmSvpZ2K+WWotnJe
         YcxDpiMch3wjnXJLrBuW/ubx97aKrUiDUMVYivkTzbyeIPErtI6KIaDTItUPoxC1c4Rf
         AQiGM/f8P+L+qFYkf3rForq0bP8M1EiqYDtBl2sAXvGocoSBu83nvPaZ2qVr6s1zWYq5
         fePp33ZR1AIu5OrfD4eeWv+rYXL5HCfvgUAnAwXXswbUpIS+PAXJXspLfyw/BCGZnSJK
         1JYIv/KGqlPTE+2j0KYBP08o2Uc15ExMNO24auxXRMGA786+mysQD8HoXwhOWYNDvP6a
         FULA==
X-Gm-Message-State: AOAM531ToOAZujkQhEczo7umOmKJc6sSTQcBKXWn7aQoyLsw9wkbfLJf
        z5n117Dm05Z+P0RjDNFKA0nc+j+E/CRG8Q==
X-Google-Smtp-Source: ABdhPJzP5+Unlt8siDQl7/nLYPmNYm33eAJDPdF8vIx1hZU3WFDddVtz8XQKRz1ambblf7YnVZLlvQ==
X-Received: by 2002:a05:620a:80d:: with SMTP id s13mr4147971qks.133.1606938735675;
        Wed, 02 Dec 2020 11:52:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u22sm2627138qkk.51.2020.12.02.11.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 34/54] btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
Date:   Wed,  2 Dec 2020 14:50:52 -0500
Message-Id: <92a4360d1451dacd1da485abfcc95dce801b0293.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
an error properly in prepare_to_merge.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 96cc9376b3a6..e41d14958b8b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1860,10 +1860,21 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		 */
 		if (!err)
 			btrfs_set_root_refs(&reloc_root->root_item, 1);
-		btrfs_update_reloc_root(trans, root);
+		ret = btrfs_update_reloc_root(trans, root);
 
+		/*
+		 * Even if we have an error we need this reloc root back on our
+		 * list so we can clean up properly.
+		 */
 		list_add(&reloc_root->root_list, &reloc_roots);
 		btrfs_put_root(root);
+
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			if (!err)
+				err = ret;
+			break;
+		}
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.26.2

