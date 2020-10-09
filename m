Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06DD289926
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbgJIUJ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 16:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391110AbgJIUIY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 16:08:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1406AC0613AB
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 13:07:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q63so11899419qkf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l2yK7ssGtYclsDwXxCx9nxPY11OspLOvX43o0ydPIMc=;
        b=YI35wXCPqSeRyfrZJV7tOPDhIb3Fb3FQrRyfsbqKG0T8n4Ng/1Ap6CLihnZ52GTG0D
         POh053s+UJx59BrK3O7i6qptuAJ7EaMoyeWqXLb6H+rHDuw14i65rdU66iDGCRLG9kXO
         LCzk9NaWPtuDJr/DDRGr8mDTh0E2jzqnZsddAOKocvPr6C4J1K/TqsiRJ2JLBMnFOiUf
         7yM0a3Va0bPdW/DQvmwDEDUmJMn7bovgglwLP58ug+0h55fr05OBSuY7/NRY4WQ9ECJw
         7dg0g14nvxR8VUmKRgQo8ny6DdPta7jlG3MLoyCBE07rklVvapinw6tzHBkZcicmeLsx
         kCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2yK7ssGtYclsDwXxCx9nxPY11OspLOvX43o0ydPIMc=;
        b=eOGr32Hv7FPzhCrxMTzrs5FVNfVFHAgIJh9axGZJ9KPXpnOpmtWi6C8B7k5jDeVKdM
         1vhxG7NQtgj2DbP3Ts+1US73mVC4g507yRis2o7Vh5kPqd1c0LWgEa9zVpfPGFSi2VWn
         Zirgnjm0plHTqI/VSD+3AUee6ynFwTwtFr82liBXC0cSC2F8owduZhIE4wImo5oU3PZI
         kZKZKgICHC+PqDaRKNfkr1yXbZ5mT/2ZQbOMimf0nN5EYanK1p9BipkB909Eotzlr6J0
         UsfpbczqFoF3jfPyfgKQZcXxZvFuckrkn36J1/XQVT94upyX9vCb35SDFg64eCf3WqpL
         u+7Q==
X-Gm-Message-State: AOAM532vm4VRQxjvNF53g956Y7yohnzF56UOk/rOspdgGGnNYH62TpwG
        hCMbx7aW7w+UdH7n2cX4/qETXbL7uL3Jk9eo
X-Google-Smtp-Source: ABdhPJyOaJZQJeO38Wi0txkaltPbIq5grFhhpMxrvS3Fd5HlC1rV9tCq/dFfn4BehWyLhmBzoFFnbQ==
X-Received: by 2002:a37:bf87:: with SMTP id p129mr15169612qkf.203.1602274049910;
        Fri, 09 Oct 2020 13:07:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g7sm7133847qtc.19.2020.10.09.13.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:07:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 4/8] btrfs: add a helper to print out rescue= options
Date:   Fri,  9 Oct 2020 16:07:16 -0400
Message-Id: <9519d52d87d0cd2d65ba651a8a1282106d988d76.1602273837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602273837.git.josef@toxicpanda.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to have a lot of rescue options, add a helper to collapse
the /proc/mounts output to rescue=option1:option2:option3 format.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f99e89ec46b2..be56fe15cd74 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1392,11 +1392,18 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
 	return btrfs_commit_transaction(trans);
 }
 
+#define print_rescue_option(opt, name)						\
+	if (btrfs_test_opt(info, opt)) {					\
+		seq_printf(seq, "%s%s", printed ? ":" : ",rescue=",  name);	\
+		printed = true;							\
+	}									\
+
 static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 {
 	struct btrfs_fs_info *info = btrfs_sb(dentry->d_sb);
 	const char *compress_type;
 	const char *subvol_name;
+	bool printed = false;
 
 	if (btrfs_test_opt(info, DEGRADED))
 		seq_puts(seq, ",degraded");
@@ -1428,8 +1435,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",ssd");
 	if (btrfs_test_opt(info, NOTREELOG))
 		seq_puts(seq, ",notreelog");
-	if (btrfs_test_opt(info, NOLOGREPLAY))
-		seq_puts(seq, ",rescue=nologreplay");
+	print_rescue_option(NOLOGREPLAY, "nologreplay");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
-- 
2.26.2

