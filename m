Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A454184B62
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgCMPoz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:44:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39964 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgCMPoy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:44:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id j2so354311qkl.7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6S911f685BFTv1GemRJVoOEA35stlYJQ/+RuehFakk=;
        b=U/XE9ur97EwrDbnGKcaJUhzIvekZjGJ4e9BH99HV8fiiS/St5Hk3Q3HxKuDTLLsBqk
         ctveOlOoCkFRRVrZPubIfN9Frgm1Q32KhMfA6f8uqEoOGN0cX1/DxJT8hh/4EfDjoUX/
         4NAGjJVo3qSVZ15IvrwBkjD1WQ8aRcOp5j8SqbxoLWQH635xQZ6Xe5WXi1UwX2tNs1Js
         Pc34/v4V6Urs47+HuC4D4Q2YuvA89hy0IwuUHc1qw3HLZv26Tf5B8ePR8lFNJZYXiCPO
         SulRsRGvV8iMm/TMfVZPksJfFqGeCp3pJorAt4yvS6igYdOM+3bf8tqOdsnhsGwYWkzM
         TFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6S911f685BFTv1GemRJVoOEA35stlYJQ/+RuehFakk=;
        b=SBoZJzNbMIgkw2iid+X5fycv3VZGj5yPHzElthFJJovO9cvPgqkznuDvMZUGTMAHeJ
         qez+gE2STqtZ1gvAYGo88Y4HITr8ByAdSUcJlWOOjx4lxaTIXuYsLPl8Fum17b59UlYW
         slHltnsqoiCrhjzEXGy1/BByYbr7vGDxm1CaT4s2aZSztgdPpIpDP7TpNrPVfMP7L/EL
         W4YCfZdEstQzekxZ0Z4Q+QzxRtG11pvuiAsvZUC8UOQyl7jAnr2jKdUw07eSKFoj9k09
         G93fwW+b6k6ixKt9BiuSo/Cl7jr1EOPcXUnRzVq3WQfJka0n/dRSo8jADzDSR9/35gZx
         Vflw==
X-Gm-Message-State: ANhLgQ27NjdXuyxpO7ShpLHYUuYgUwndVA00JzVZF18Ot5EJcz7XvZhE
        ps5/0rfd+g7ddJ2agRpRDlPWcJtedek=
X-Google-Smtp-Source: ADFU+vvRn0bmYT1/McuqkZ4atGjPfkMjGfIfH6izSk8StWqNEZmpRVbcNMSfQe+P8wT8iD6fXvOk3w==
X-Received: by 2002:a37:702:: with SMTP id 2mr5712720qkh.134.1584114293196;
        Fri, 13 Mar 2020 08:44:53 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y197sm29347677qka.65.2020.03.13.08.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:44:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 1/8] btrfs: drop block from cache on error in relocation
Date:   Fri, 13 Mar 2020 11:44:41 -0400
Message-Id: <20200313154448.53461-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313154448.53461-1-josef@toxicpanda.com>
References: <20200313154448.53461-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have an error while building the backref tree in relocation we'll
process all the pending edges and then free the node.  However if we
integrated some edges into the cache we'll lose our link to those edges
by simply freeing this node, which means we'll leak memory and
references to any roots that we've found.

Instead we need to use remove_backref_node(), which walks through all of
the edges that are still linked to this node and free's them up and
drops any root references we may be holding.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4fb7e3cc2aca..507361e99316 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1244,7 +1244,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			free_backref_node(cache, lower);
 		}
 
-		free_backref_node(cache, node);
+		remove_backref_node(cache, node);
 		return ERR_PTR(err);
 	}
 	ASSERT(!node || !node->detached);
-- 
2.24.1

