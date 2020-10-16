Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3C29085A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410108AbgJPP3b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407477AbgJPP3a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:30 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14D6C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i22so2216702qkn.9
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0MSsz6C6/qJTpq+PhQqbvsOarnY1YcBhqdx9TT4q8z0=;
        b=V+dwo/PZpm1jkddagfWykzS2cz5Z1kBHcbs/4wAKU+KdUSxIYEw+RscZVbU1IB0FLK
         YXfHIgqGzATQu8VZN9qUkTgJtnucnIhS7WwONQvf6fkd8uZk/Xw4QEqYk/WjmRIP21fE
         XHDP+pM2f1thBinjTDZF0Cicel72S1cypp1A2devp+CY6689ICvnVN4OV5JkIEED7jmC
         gMi0o9qhSdvhSyODEm/8/P/U1jn5PnbQZ64msc+O4dXYLiZp8PiP54Dxr3P9hPtYEUAe
         Gs3kaOIQdXBsD7UgnzcZxgPJh0kroWvYBUQQjyExGllhDEe0CGdP4GxLAE34wSsgOs12
         nWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MSsz6C6/qJTpq+PhQqbvsOarnY1YcBhqdx9TT4q8z0=;
        b=MlvcCzkjksyPUMJL3Wi3I2FZYTxwBZM5m42huw0QAq4Ri+2DcRAxkgxPJsnxy9ctuX
         3gzrT2Wkf55Mb9DAOdKsAuJxzImKAaKnWqo1vAQdjAJfWScYtDHM0eOJkT8s0dOyljTJ
         6oddBhErPqZuQ9CRE9ltCcct5a+o8wvBJSKTiK/ixAy0lr/dwVlzy9e/EQcd9gtIwXZD
         kZ8+eNs+c46P6cfd9aJO+HdF916XCcmSjve3oI4KvGWm8kOgz1a93rgfMasUAvsQVf4a
         ZQXVjoxip/LK2TpYnla7GT+AYExIlJsPUdCRoUZAotYBdwyXhO9ClT0MFQ2s+qG1UFKz
         ha5w==
X-Gm-Message-State: AOAM532gcGIwSxtYQLTba/7QKcFmIi8Cbv3brGcA2qY3ITIL5TGg3bV1
        kAAKVNHO7IAwR5AwZ41PHz8B8w9ajfilEP2C
X-Google-Smtp-Source: ABdhPJzz08VY2hpzCAfYY7vxTIeSznmNdG3bD0NlrJ0xuxFXTF7QRiw2Z1aktldUchJlITr5B4PwhA==
X-Received: by 2002:ae9:ec0a:: with SMTP id h10mr4476136qkg.102.1602862169520;
        Fri, 16 Oct 2020 08:29:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l125sm998463qke.23.2020.10.16.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:29:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 4/8] btrfs: add a helper to print out rescue= options
Date:   Fri, 16 Oct 2020 11:29:16 -0400
Message-Id: <4d3297668dd9ab26681b5632232fb1f6eb00cb73.1602862052.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602862052.git.josef@toxicpanda.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to have a lot of rescue options, add a helper to collapse
the /proc/mounts output to rescue=option1:option2:option3 format.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f99e89ec46b2..f41f7af27ff7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1392,11 +1392,19 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
 	return btrfs_commit_transaction(trans);
 }
 
+static void print_rescue_option(struct seq_file *seq, const char *s,
+				bool *printed)
+{
+	seq_printf(seq, "%s%s", (*printed) ? ":" : ",rescue=", s);
+	*printed = true;
+}
+
 static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 {
 	struct btrfs_fs_info *info = btrfs_sb(dentry->d_sb);
 	const char *compress_type;
 	const char *subvol_name;
+	bool printed = false;
 
 	if (btrfs_test_opt(info, DEGRADED))
 		seq_puts(seq, ",degraded");
@@ -1429,7 +1437,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	if (btrfs_test_opt(info, NOTREELOG))
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
-		seq_puts(seq, ",rescue=nologreplay");
+		print_rescue_option(seq, "nologreplay", &printed);
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
-- 
2.26.2

