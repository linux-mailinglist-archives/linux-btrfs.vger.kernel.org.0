Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824671412EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAQV1G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42547 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgAQV1G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so22892332qtq.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pM6Baxg4dx7swLymggU9GXTkL1FxfAoUeQLO3SfFwWk=;
        b=DIXcvBJmU4tCi6l3zxaVzYd8B3nK+9CTGahixG/Ll3rOBtNtaoeY2+LLNcZJt3b/NK
         O/SKeHXQdFWhrtWTdMwGgAenUwfUn0meU96RvB+zmNTA+0YkevPEDMo30m+jo8yjXHla
         1KVES01OfYc/0D3ieaugzBW0MTraHm38Xfi9LAB1RZMzo+K8+w24Us0ZtXV6wfq8T0WA
         q0lRvMmLZhN2luW98Pv6nDt8UYPgcIYlcbYeKbxaz1LDlvHDkaifcIpPh7TBiTlrLgfw
         c6UlDsuBzERUUWVFTrcJK4G0IDNKESZohgMondptI+fXBLWqcYHFzaYXi0UedRNOhkus
         u2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pM6Baxg4dx7swLymggU9GXTkL1FxfAoUeQLO3SfFwWk=;
        b=diyKmEPqjup38v73P5hkHUzvbs3bmdNLxqWUPzTt6I7BMl0Xab+xWF4I4rM1XL32Eo
         mzWyFu11756061HsWoxeX1UkFq3ptRljJkn7iqOP6lkBnz+0OcEGOUnvQEtgFbkued9C
         BMO1J0ozN74QO4RLXUG5jtZ4Nj59f7MjFf42Hb/+F2fGBD9w7C8fzYpcsCagLQUFJ96B
         GGkFmbMw60MsQShl5UhyAQXOMflcsyxe4YG2DdSvPQGLAtYCw0r8kQQwtg6IooKrKbld
         rzjJNxmxxbV6PKnZFYDm63sjVTtUW/XnItQosAyA/DoGMp04A8FtRZiyp1VvxFleSCwR
         5KbQ==
X-Gm-Message-State: APjAAAV+h90sjfC3/TftaCxA0A2CZ5MaCu3DQigCS5tYNDmeu+xkdCuM
        uGj4UBIRmKQG6ln85vYVeD8K6z+AVIqHjg==
X-Google-Smtp-Source: APXvYqwx+K6Vy+RANcIKRWdxkymWLWb3tbEh6E+ChJAPV8aWZa5gpIQOkzZd7U3Ng2hXat40/ipsCQ==
X-Received: by 2002:ac8:3496:: with SMTP id w22mr9507128qtb.47.1579296424678;
        Fri, 17 Jan 2020 13:27:04 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i5sm13487684qtv.80.2020.01.17.13.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 34/43] btrfs: hold a ref on the root in btrfs_recover_log_trees
Date:   Fri, 17 Jan 2020 16:25:53 -0500
Message-Id: <20200117212602.6737-35-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We replay the log into arbitrary fs roots, hold a ref on the root while
we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index db803765b500..5b05419a0f4c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6114,6 +6114,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		tmp_key.offset = (u64)-1;
 
 		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
+		if (!IS_ERR(wc.replay_dest)) {
+			if (!btrfs_grab_fs_root(wc.replay_dest))
+				wc.replay_dest = ERR_PTR(-ENOENT);
+		}
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
@@ -6170,6 +6174,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = NULL;
+		btrfs_put_fs_root(wc.replay_dest);
 		free_extent_buffer(log->node);
 		free_extent_buffer(log->commit_root);
 		kfree(log);
-- 
2.24.1

