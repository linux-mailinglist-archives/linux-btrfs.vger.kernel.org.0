Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6A2D12E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgLGN77 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLGN76 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:58 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662CFC094253
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:05 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id z188so12492383qke.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BQnifcFL/WPLj7otSCT+NzpZ09jzZaVeOVpCVlLc5Lw=;
        b=IdahBfhfmwVzpct8qQc5c+dBQnywShN53KzdMBQnJ9Awh7Ugx/xlfGLKs8n8h6JWO5
         ogUomYKfa9SOQ6CpeeMfHd1vHI4ZvYPT+JRVT0yzR0C8gixtAIAmVORnZihqth+xiRVT
         a9c40tcN/racOdPDKmuOBuAFNv+9cVB71vzkwRSBBy4yJgqTT42tvfTfdl6/id3Ty8nh
         AxOrNyBWXsv5MMBN+QOGL5DacXGGO4n49RHs3JHYl3xkp+Cx1O0C128Rj1tAC+nuwDdf
         +W7K0poQXxbfDA5ORDcM7y9GV7bt/qQxc1udQv4ZkBOS0xL7c3ZAbg5GW/nrU6X8Nrdy
         K7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQnifcFL/WPLj7otSCT+NzpZ09jzZaVeOVpCVlLc5Lw=;
        b=V59qw9NOUn1YPctjAYDOmKPB32QLm8oFxG8YMCdWdnoRhdoPbK8+O+gs6HxIqDeMHj
         TBVK6WsB4oNE4cFwb3OUhc7UJfB0kAUg2LoWDHHfmrqPw64PYQDaZURUesZhOVhUSn56
         3x1RMp7nLNZCIjFfRNpi6dSWQLpa5nQDnkc3lKzuxDeCQKsvoD/gtJQv4DEXdiBW9YA+
         BMwUgpfWmkvu3UQMo7FOb8D269HLgkcsSM9pcDs8G3DdDDxQJve/nj4NTYGIZMaBcK5k
         Xe+gZ6gl/FEwmwJLe9vilTyjoxFKu9R72bKHQVB+1MbSu3j45HsmO65kmJy6k8AnK0zx
         /xXw==
X-Gm-Message-State: AOAM531l/LcWpZ2ps/gEiJF4v51RHsnOdhaPjxtm7gBP9+zuLG3HS6vL
        dGCu/G7cLVcoToExuKCN/qjuJQfSd9xpWxp3
X-Google-Smtp-Source: ABdhPJyLy84YUILlwCndHKpRVHrbhQ1ltUKLawZdVOOUrSTOg4Wv42zlQg0f3KIBNHeLNqlz2M5itA==
X-Received: by 2002:a37:7f07:: with SMTP id a7mr12274843qkd.455.1607349544317;
        Mon, 07 Dec 2020 05:59:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 94sm11828769qtg.57.2020.12.07.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 40/52] btrfs: handle extent reference errors in do_relocation
Date:   Mon,  7 Dec 2020 08:57:32 -0500
Message-Id: <844a6954b7b5d09c3099e9a33660286fbddc9ae3.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already deal with errors appropriately from do_relocation, simply
handle any errors that come from changing the refs at this point
cleanly.  We have to abort the transaction if we fail here as we've
modified metadata at this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e025cb052d77..bff7e99f3654 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2426,10 +2426,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb));
 			ret = btrfs_inc_extent_ref(trans, &ref);
-			BUG_ON(ret);
-
-			ret = btrfs_drop_subtree(trans, root, eb, upper->eb);
-			BUG_ON(ret);
+			if (!ret)
+				ret = btrfs_drop_subtree(trans, root, eb,
+							 upper->eb);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 next:
 		if (!upper->pending)
-- 
2.26.2

