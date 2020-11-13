Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB5B2B203B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgKMQYG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgKMQYF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:05 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA1CC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:04 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id v11so7014803qtq.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qTooTgRlnqiQbR2PmEQpf50dV/+wAgp2L09CTkPnzes=;
        b=WQ+3EH9GD/i5HMhXvif0+l7++EIXtR2q9EarM+G36M5zeY/hnE180sfJs+chLTc19+
         3rTdrhjbriVA0J1rfbq/eksLD8Xrk1649dur3xeQL3eDAHFNFmIAHwCh07LOccT7EKFQ
         XJY4khEwUA/l5A7dVhy8ms2pyNIg8SqhboZlXIixbnFomvWhUDApZ7T5aJ1X5mTv3/Bc
         +M4doOvLKamD7Rog0LYwSW115DrnFDk06U8n4vEVNFh+dXMrt+PuhbzWCD/oTlLAPDKX
         s1ieFRNC3iBqiQhEc0typLp1nPPN0eie2ZO52v8chdvAvyWIyeUkeeXEPHF/Ox0WkHoe
         P5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTooTgRlnqiQbR2PmEQpf50dV/+wAgp2L09CTkPnzes=;
        b=gCu6Yvpp5AWfxFez7q5ZixcmqgQW4JjzhoPQ5ils6XzMxG4u5H9dPORV+EUO6Xftd9
         pNckGxma1tw8yzFtF9nJ87/cz4yBcY7Z7wMHEXjUgdGD0ddODizJqZ8SBU+54axQwYuH
         nxQbNq6uPy6uaHD3km7y09zVS1w/PiBIi+ep9KqUa3IEuklMZDKaiIbcnIG05BSPzPvn
         +zTakMEf4KQsk7dGDe5ZXQTRrO6WEq5dyrYEg1KUZbGrrNkEcqz7ZcDeT42gWpKcWPaO
         pe/2/t9KaLOcu0XVqRrlKkdYGy2si233EKfK/Li4SuFp3dVGqil61AiSZC0sD8kyUTD+
         4ITg==
X-Gm-Message-State: AOAM531mKVQJkhmpf6VyS96Fmnbdo4nk7WQk+glZs5V8qOGJ1PZnXl7a
        LHRUOqwTH9PjKRUVqChENYKudWT06l1xiA==
X-Google-Smtp-Source: ABdhPJxfKuWnoyyEc2+otIX2mEDGs07H4wVCkr++2xPaT2VKx1lUBrLg2GXNUjIbZsHTAJuWoDBsWQ==
X-Received: by 2002:aed:3c78:: with SMTP id u53mr2788024qte.364.1605284638723;
        Fri, 13 Nov 2020 08:23:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b8sm6393945qtx.73.2020.11.13.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 13/42] btrfs: handle btrfs_record_root_in_trans failure in btrfs_recover_log_trees
Date:   Fri, 13 Nov 2020 11:23:03 -0500
Message-Id: <8055a43c75716d186b29441c5c78f6bdf04d47ed.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_recover_log_trees.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 955c9a36cfeb..1ad77e2399f7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6276,8 +6276,12 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = log;
-		btrfs_record_root_in_trans(trans, wc.replay_dest);
-		ret = walk_log_tree(trans, log, &wc);
+		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
+		if (ret)
+			btrfs_handle_fs_error(fs_info, ret,
+				"Couldn't record the root in the transaction.");
+		else
+			ret = walk_log_tree(trans, log, &wc);
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
-- 
2.26.2

