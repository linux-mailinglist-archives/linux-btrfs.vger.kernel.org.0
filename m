Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07E01850F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCMVXk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45478 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgCMVXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so15138656qke.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0aVl2xfW9prr+r2/k26fIV/VINWNFMS/X6e+PTEB8Ro=;
        b=KNtCD+EOieAnmUR84NBb3ThWSSv9jiOvpyK21RLWywKWLFekA/1jck8+MJmHPi9djS
         FubAXTTKlDd8q2FLMBZgBTKuLsKExTYvXYUrwdz6AXkn1u8w7CXSTFCg2Qs8e3HIo9NE
         KMAlUJaRrSG5iElGQ+pLPDty4cLgL/DsziTCWFoSIkrIvxnGU4amBxcVq10/bnK/P6WT
         FGUiNuGT1zDfWFpPxI1KzQulJDfe7fQWVHnK82YpgEWsHGMR9f5/Pg5s2kXn9NBy/KgO
         O9ZQj+OivC3GDKTsc/CR9DEJx7PNkD8YW+FMNJJ6k7Fsgr8hK+nncxzj/u0jZXqx3n1x
         rPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aVl2xfW9prr+r2/k26fIV/VINWNFMS/X6e+PTEB8Ro=;
        b=LB/zF+4k/y/YvMUxNflqe6izxWJW4OKMk3X+xXo9On4oBBTLXvO4TtG4kbbnBpi+r/
         qddr/vn4WkHGGi5VdMzzVqmmYlfk2RG9vEnLdenw3Rfkt8FJnoT+Spffrw4oqcYypS51
         XAwfNVSDqJmaGxF+oaoazixSHvvNZvHSaBg3+Bgf7+dpou89rpB6SwAWOcxN/iSeVTuq
         wnymQuM/5A2qOgygTiOrW5M6ClqslX1YD7/T7sdgcERZknrssmRLEl7X7WhLMhNbDV1l
         /5cEN3PueAUeXnYblUE00utbi2jfV3VlbylLOXQdXsFLOzlUK0rC/Rqgs07V5WUR9goB
         MP9A==
X-Gm-Message-State: ANhLgQ0pIzBcX/yOgY/Oq3VeCqNDgafj6yhiIxKGHzIfvHmvy7nRYrbS
        6PBMSU37AzyLPJkEcDZf8rL1ilJd4jYK1A==
X-Google-Smtp-Source: ADFU+vt9hU8Obytqd6GiFG9yQjLzfXQYVjVEET/Xe2XpRuwfM9pNaWCEd/ChXoYxKlFXksiQvvvtEg==
X-Received: by 2002:a37:8e45:: with SMTP id q66mr15408622qkd.129.1584134619640;
        Fri, 13 Mar 2020 14:23:39 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d73sm12462954qkg.113.2020.03.13.14.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/13] btrfs: make should_end_transaction check time to run delayed refs
Date:   Fri, 13 Mar 2020 17:23:21 -0400
Message-Id: <20200313212330.149024-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently snapshot deletion checks to see if it needs to throttle itself
before ending a transaction, however this only checks if there's enough
space for delayed refs, not how much time it'll take to run those
delayed refs.  Fix this by checking btrfs_should_throttle_delayed_refs
as well, which takes into account how much time it'll take to run
delayed refs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8d34d7e0adb6..309a2a60040f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -859,7 +859,8 @@ static int should_end_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
-	if (btrfs_check_space_for_delayed_refs(fs_info))
+	if (btrfs_should_throttle_delayed_refs(trans) ||
+	    btrfs_check_space_for_delayed_refs(fs_info))
 		return 1;
 
 	return !!btrfs_block_rsv_check(&fs_info->global_block_rsv, 5);
-- 
2.24.1

