Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7812C2D12EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgLGOAM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLGOAL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:11 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74852C061A56
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:25 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id l7so1141110qvt.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bBHljed/hOeQde1atZqVw4f0tMOP5fQffY0QKaWshdA=;
        b=b+2SN19nPTNt7Ycll5BTsl+xGPFJhqHHJJqdlYAOrSVBn4FZLzmq+XJZbQKmYa0dlL
         qADhRE/rUe8V+xXshyoaC5U1fnwNHObejINm6F4LWQi6FLyUjkG3ZvaLQOKmwufE9UvA
         Q9GP/pwYnryuiSpzz6pb5kPYUqeBtrCNTGp04oMiedHgugWjsBQS+Y0361drHALIduOg
         UXtCvx73tBZVhaaXeXsUQX498mzkPRvANPmj8Yub+oZwb9TG9NMSE1l/JHsVIyB4sY+7
         KcLHIXJpHhHlWKLMBwMFcmnjVgjJQWROjWtU9KMkrQABVrSs7jxC09M7e8bjwOtlJnRJ
         S1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBHljed/hOeQde1atZqVw4f0tMOP5fQffY0QKaWshdA=;
        b=l/1ZDIbE68DO3hqtZszYFL8F+Owgk/ZCSzya8RBig7o1U81NgdOtj3r7ViptRaLEnr
         3Np+6+dNH0A0XaqM5wPnZDSzXP9O2fpq1yVNkzPaTLcyzlfyWwErmLTpZEHUTx+hI2+k
         o/Z8vCLkd5jek+GKQLFjXP5cDPjuQxEZi36bja+RDHmiD6yC/8U8vWA/PBgC5SWOd39N
         dabXQ6Q5ihhZSjWzJ6ipnRG8c7J5MADMaiab+ikZbKeJ3ooEu6TaIEfxF9woa2citlZi
         vKhHFQlhxKF5OBrQn4EGi9nbVsQ7MNQgFTvfOc8OAPoQ2JwZi3SroObpwRqq9w6mgU3a
         iarw==
X-Gm-Message-State: AOAM532sS89tEtic3H2IE4Q3HFSwCoODtGZCauwmeZDZeluKg0oCXfjR
        iEJjrnQcHyDTGa0AJnYCj+QVNRpBTDoMafjO
X-Google-Smtp-Source: ABdhPJy/VwG3ZxT2eS5ce5CAIdsYMtTLCga/OCGTV1yWX1KmfO8urKWk4ABbzCfKeF2Jp9OJWYoX/A==
X-Received: by 2002:a05:6214:10c6:: with SMTP id r6mr16349290qvs.44.1607349564313;
        Mon, 07 Dec 2020 05:59:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h67sm11877237qkd.107.2020.12.07.05.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 51/52] btrfs: fix reloc root leak with 0 ref reloc roots on recovery
Date:   Mon,  7 Dec 2020 08:57:43 -0500
Message-Id: <21a1a7949abbf7ec444a9e11147f91985eb21e1f.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When recovering a relocation, if we run into a reloc root that has 0
refs we simply add it to the reloc_control->reloc_roots list, and then
clean it up later.  The problem with this is __del_reloc_root() doesn't
do anything if the root isn't in the radix tree, which in this case it
won't be because we never call __add_reloc_root() on the reloc_root.

This exit condition simply isn't correct really.  During normal
operation we can remove ourselves from the rb tree and then we're meant
to clean up later at merge_reloc_roots() time, and this happens
correctly.  During recovery we're depending on free_reloc_roots() to
drop our references, but we're short-circuiting.

Fix this by continuing to check if we're on the list and dropping
ourselves from the reloc_control root list and dropping our reference
appropriately.  Change the corresponding BUG_ON() to an ASSERT() that
does the correct thing if we aren't in the rb tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 61b0931c8ad1..79c1e5348593 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -671,9 +671,7 @@ static void __del_reloc_root(struct btrfs_root *root)
 			RB_CLEAR_NODE(&node->rb_node);
 		}
 		spin_unlock(&rc->reloc_root_tree.lock);
-		if (!node)
-			return;
-		BUG_ON((struct btrfs_root *)node->data != root);
+		ASSERT(!node || (struct btrfs_root *)node->data == root);
 	}
 
 	/*
-- 
2.26.2

