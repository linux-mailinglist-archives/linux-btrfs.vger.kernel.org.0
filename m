Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D82B2048
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKMQYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKMQY3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:29 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E780C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:29 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 199so9272652qkg.9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YKxxLwnqY0dE33UbL41cv2pSEoetw5+6HlE3R38vch8=;
        b=uA6OgBSGzW0tcrPdOHmeIl62jgwawnz81/2wdHjpwTgpkCPPlWJK4fXkDBipjkKnBo
         taC6aDbkeI0+2lbyJ+PlJNrXmePw8rjac1z38yFTtJB1zC6mxpT/eLWTa2HF6TX4ZR8v
         vzQgx3b3wnrbb/2++MZnH/FxVdZCltX3W57RKtTQHM6GfHMTJXwvWh5w8O/mSLrts91+
         DdL2UvCLUoSgcd9mFvfeZw2+VtDKseQU1qyTWZc+B5q3eBkRIVkAhVlsoUaeHnKoKvPC
         l3GjLh7DosH9uAcvYf1zioB1H/XX5wdRwsTH58IvzZPZkxYjdBg1oj3MReznFxn1S6cA
         UT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKxxLwnqY0dE33UbL41cv2pSEoetw5+6HlE3R38vch8=;
        b=bTnto/h3liLKUsu1AUPqmwwmbt7p1T7OR6CBA/PTd1GxoDWfOY3GOjf8hFvcPr1BuO
         UEsW4vhx05eeJZy+LJZiIcy0vT+XGREKCpRw23f8GZrJQN4H1XVk4iopuHtORE13z1Mg
         AKrzP6aK1Hd5CVAQVzPY0+egNsw545MJADw+kws3rJgm++VKRNA9ZyvvWBBZhClYXKgn
         6glOmPNaZQ8xRWbjRUgVXoqZy50akMKbZVP5CHPMiTV1D2CIlqYnJ5qFQsFeFYzU5pCo
         bodU2x+kSAgml7Ug8BQlssczu/Mr1YEZW8+5Boco7LxZrCIukEwBR92u+FWoacPsgtir
         IPQw==
X-Gm-Message-State: AOAM5314pS8Riu4OTr8qAsiTzI9kLzIyGuK7dTySD5k+5+cEj390DppC
        Hq87HbK3aemMEcTWQSm1sGMlNhavZ5M3Pw==
X-Google-Smtp-Source: ABdhPJxDb51dXrJyqU6RjmENHjCDcgIjm2lkDJmOzXPtbX9QO+sL4ZuUV8G1EKkWqSUs8lXbun1lGw==
X-Received: by 2002:a37:6412:: with SMTP id y18mr2793154qkb.84.1605284663206;
        Fri, 13 Nov 2020 08:24:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l62sm7196902qkf.121.2020.11.13.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 26/42] btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
Date:   Fri, 13 Nov 2020 11:23:16 -0500
Message-Id: <331d580cf682a9f4e0f3f182de0692aef998304f.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
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
index 16deb9e3f764..75272ef03486 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1872,10 +1872,21 @@ int prepare_to_merge(struct reloc_control *rc, int err)
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

