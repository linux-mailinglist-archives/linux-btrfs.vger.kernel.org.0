Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C192B2058
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKMQY7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgKMQY6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:58 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89675C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:58 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id n63so7041148qte.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VTZdy2m1RrihnqbZRGhaPdSI5yS7jkNQiHYllhpm3CQ=;
        b=psB4u/l5GDvsFIXvdfvqc8rz70ID7uVFNxn4Eq+/pcq4rb0ntbzhHu36aPOIbuzwE0
         re2eOCXpRwHq8lZOsGhU2ZoDZ7ni82qNZ2x5oY8/FV61seetfLPg9/tQHDM29VC9zNbF
         Y36ZObD2qt0JbW2kIsVdfOGxPu5XbsMwRvyycERKqUYtvGLTaztuDfxxKFtLwLVOgw4H
         gO+6rdXFqhJYz9E/nq4qomTQuTzYlpRz0FUjb28Bbn0myJkhDe/roNh2Ci23mOBtaoDV
         75ESh+Dbwqufh0MkrSCghJUzHeDXUxFttwEqzS7yzQcjc8h8OmlVwcjdNTbrPQEzOFa3
         T2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTZdy2m1RrihnqbZRGhaPdSI5yS7jkNQiHYllhpm3CQ=;
        b=U0SaNYkwlHMhPJTQkRZBgnGG3JWTxAxYWfy4G4ANNxw+d+5srt4Id4WTTgy4DhmgBl
         i5mkhCFqLPCqxB2TffbecmV7Ax+HFirt9w82ePLsB8cjJULmGqpvQItU1fkNP2gdLvmW
         h74LA9T0ChNqN41E9zElzgJJfa53/eicFYTnvgIHY0s0ut2kLTeVzrAZy0RQ8nI7QPjD
         CAhLbq9BYPyMYiEgWhEUoALhd7/r/p91dkUimTdmb/HZlpDn+LlACxHFfmNYB40qIF1q
         GLLLAqYRjAbozwpsGpzaagX9/wJFe6mgfrHA/KdIqXkF/OTORfFvKqX30khbh6xcSSrg
         bKAw==
X-Gm-Message-State: AOAM530MWB6wwYzVZ5VZ8zh1NQtNTszdIAuZRXMEURHLAbtw+JqTH6mQ
        dbZKolrnbd/IcM8wLmgyz3y05BLBydnaLg==
X-Google-Smtp-Source: ABdhPJy+VzfY+QZe9Yoiko/fg+bSj/uzmnNtCARzJNuQ4uQ/+rxiZz2wlq6N08WUAhSjxDvviiocQg==
X-Received: by 2002:aed:2c02:: with SMTP id f2mr2849196qtd.48.1605284692543;
        Fri, 13 Nov 2020 08:24:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z20sm7474858qtb.31.2020.11.13.08.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 42/42] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Fri, 13 Nov 2020 11:23:32 -0500
Message-Id: <0dd220f8afa98f6dfa8c0cac05994ce40b0be651.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a few places where we don't check the return value of
btrfs_commit_transaction in relocation.c.  Thankfully all these places
have straightforward error handling, so simply change all of the sites
at once.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 97c1d967b528..8b17827de608 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1917,7 +1917,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3403,8 +3403,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3563,7 +3562,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
-- 
2.26.2

