Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA112CC738
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbgLBTxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389849AbgLBTxg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:36 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2883C061A48
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:40 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id y11so1301912qvu.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ak6MdgHVZgfQ23eyX7yqKDQ81qYG2eiQWsu5biXUKO0=;
        b=uXST3Yd+/Eabybklv+x1UwyYcKGehZ4YIYMezceUDqm5BbKtWPqOrczcWBv4OUUqNL
         ysxXJXCuR06g0mXdJJ2NKCRhLM5dpAawFsWbBK6juBCumyBYZt5zY7rbgqxGmBBTEiav
         oSWsj0YLtoinzPDPNv1R9S0ldiNC5MR48EfVuYJ13/fFYcxEYwP6KE0VGesjiHihhhUW
         5ioYQGfYhCk7FARLsWfQeDUTaywzDO+NlByVYpl0eDGgHXzObzXn6A1B52YNmR29HeNw
         +60aTYTzrvA7ce5GmKkW/UIvAPeuRGD+VyVSkw1sDCoH9SbM3T0+duMxrMMIp6b/jiwJ
         6y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ak6MdgHVZgfQ23eyX7yqKDQ81qYG2eiQWsu5biXUKO0=;
        b=g3s751e7p5XneEkbnSLyuh2rwWt1odjCTmoGkMrQynLvyFfmn2roiagns/EO1GDvEt
         20XW0on8098jIHwW0of0S6qKc0dcBFnGw9GXhjy9qqZYyIKHAwI8PZKwtRs/M8QvR3QV
         SQGmzTfDiGu78zBXxff/QBfAHIH9gfr5y7mMSqYC09egZl5S3kEovZ7YBHWPLnJo011c
         +umFLBO4p+j0WptPNIyU6g3moP3RIeaFLQ/y6NrarGtqJBFPtX4nH9vRZcQ2sSLWKxTg
         +ShGyS/fV9xb7EMtf7hBMuk/cdXNaSXvG7sLl3f4G+HfcgBR3V800NhXNrzVdH6WIJe4
         LeuA==
X-Gm-Message-State: AOAM5300SX9UCHmQvleD1uSjR6288lV/VuUl8FkDUI0p2YpjA2FCAhaX
        IMdCwsRpO6UOBX868RkU089JwkzXuMCVRw==
X-Google-Smtp-Source: ABdhPJwrmXfdBK7oqjlFDpboOgSYQZeoFiXWHrXN0U4R2qSopvxmv7AkfBAe3UuSj4prGOymqZDmTg==
X-Received: by 2002:ad4:4908:: with SMTP id bh8mr4486761qvb.58.1606938759885;
        Wed, 02 Dec 2020 11:52:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z81sm2617479qkb.116.2020.12.02.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 47/54] btrfs: cleanup error handling in prepare_to_merge
Date:   Wed,  2 Dec 2020 14:51:05 -0500
Message-Id: <6e41922428a5b89b5ef0d7d47f8274e11468ee2c.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This probably can't happen even with a corrupt file system, because we
would have failed much earlier on than here.  However there's no reason
we can't just check and bail out as appropriate, so do that and convert
the correctness BUG_ON() to an ASSERT().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 695a52cd07b0..d4656a8f507d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1870,8 +1870,14 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 				false);
-		BUG_ON(IS_ERR(root));
-		BUG_ON(root->reloc_root != reloc_root);
+		if (IS_ERR(root)) {
+			list_add(&reloc_root->root_list, &reloc_roots);
+			btrfs_abort_transaction(trans, (int)PTR_ERR(root));
+			if (!err)
+				err = PTR_ERR(root);
+			break;
+		}
+		ASSERT(root->reloc_root == reloc_root);
 
 		/*
 		 * set reference count to 1, so btrfs_recover_relocation
-- 
2.26.2

