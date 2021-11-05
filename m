Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8C24469FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhKEUso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhKEUso (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:44 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3075C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d21so8297167qtw.11
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rg/IjMPlPfL33FJPhmbLuem6SioCUK7Z9ZpA4q6dSZA=;
        b=MlOiT5TD8ckLXunO7A1N1YQunOeUqJlDtD4H/2jdb40oLkCVqOum25uE2LfHz9aRZu
         d4Vbn8Hz0sftFtKOe4m7GqbfxhbebBaoPH4rr59JMaS/KTIcaQN+Zg2nD/MDpxVNWKTj
         KRywrTSfEmtxiy615Nqo2ogFiPKvzP5ffdlj2J7+AGbjWInda+0Cc7357uDOlI/lOvT+
         Tw8z6VxT/Zqsn4Vvhu3N5UOBd3zjJzacfu9nKe66KPR2XC3EeGOyqhqpOOoFVf5Bgkoq
         +Oh0GjZ5TRVwcxY2CTu1t0tIv9zxPaMfDK541Ex/NKZZaaVjMcyhmtS71LSGfoOSlwwC
         2uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rg/IjMPlPfL33FJPhmbLuem6SioCUK7Z9ZpA4q6dSZA=;
        b=OwVEjffpuGU0A95mLgezMxfKJUETIu9jG6/CD9QqH4wOAGaWeeBtRq6GS0sE6W1fM5
         64tfXOKgMOBZIC0AzDZubeYLozqjf+Zv0wApj6EuhYIvkv0dY4htCM9EXZa+IfsL+eYd
         AgV5A7SzbxttvgeMRPW/fDZzH/xFxFukhuAWIL5S7cjHXb19aK4iXuWpagKfNoL+eeGZ
         E8j+ihKsxPDepAQRiVWmEDMr/CICWSsGKcG4CfhOGzQcRV+CW9AQaqMoXgew/+KULR9R
         0sctEE6WfN4fnpadNuaF22P+o/aDspK8m9OwyHciq57+XYvXvt7KE9woRpURYAOqz1h7
         8sYQ==
X-Gm-Message-State: AOAM531qCcVNWOVO98tbH22jpG/0VMnvh1bQeE+Q2hTxbGWkw15FwMaY
        n3ECJGHcsYnSGZuIXMFCzE7Kx8xQZKwwyA==
X-Google-Smtp-Source: ABdhPJxF5OB6Dn2RtqiRsfWR+7jjyncHFT84P2s3ytsyCgRKpTGi3d7I3PHqvxVNcOo+n4METEI7ng==
X-Received: by 2002:a05:622a:1905:: with SMTP id w5mr23482484qtc.207.1636145162906;
        Fri, 05 Nov 2021 13:46:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v19sm7100556qtk.6.2021.11.05.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/25] btrfs: remove SANITY_TESTS check form find_parent_nodes
Date:   Fri,  5 Nov 2021 16:45:33 -0400
Message-Id: <7fec7de2b2142ed5dd4e2a45602c6c68290a51b0.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We define __TRANS_DUMMY always, so this extra ifdef stuff is not needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 17766b7635f9..12276ff08dd4 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1212,12 +1212,8 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		goto out;
 	BUG_ON(ret == 0);
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	if (trans && likely(trans->type != __TRANS_DUMMY) &&
 	    time_seq != BTRFS_SEQ_LAST) {
-#else
-	if (trans && time_seq != BTRFS_SEQ_LAST) {
-#endif
 		/*
 		 * We have a specific time_seq we care about and trans which
 		 * means we have the path lock, we need to grab the ref head and
-- 
2.26.3

