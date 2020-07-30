Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B42C23352F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgG3PSN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 11:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3PSN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 11:18:13 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA61C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 08:18:13 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t6so7744700qvw.1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0T53Sx48tDdI/Fu443GQEFly2iHA6L8UIMrgUwjF0Cc=;
        b=TS1T9NitH/5rv5dD/GJqaojUDkymkjbEQBVGLArqHJLFPbNTeI3dx+QLbj47bpX+L8
         gCHa2ax/ylaXMo/+2D9RUOgUOUCn1sqt6H/187Y5niMcRVXi43SMU4RQ9Vi9+58t5FYt
         bXkFmIWHsJMwMxyfkNemTBv/3JQ/JmSXwAbbtC6rPlKK6UMYTLgakzRnDi410bUaiK7U
         isJhrEBNG758XEqvgDaJiZqEO1QGdj5K9Y7Dd9VHs2UMroeK93587qihbSP+aGWqLwft
         oLouCUUWBSTnzZNGSTxGXEQuba/kDCIthqw1jp+kWJUpfw52rPbDIdzqjQBtGQDW5a5w
         nU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0T53Sx48tDdI/Fu443GQEFly2iHA6L8UIMrgUwjF0Cc=;
        b=Li8bV1d10pqVWQJ+5Y1sjpITrQz5LBYfHwQPwAfxaqGlXoGx8MvUv3nNIAtd1D0oss
         ZmCF92DsmFxoMbqNqWAprQN2dSPZNtZ8zLguSenHVLsAWMWixAY4Nnkh562TaPx9GE9z
         X6kuPNRb8gdwEtU+aknlj5r4RnzZazSpBKHMMVqujyqNczFa4zzy11sQ42xPDqU80fJH
         botD0z+KmKMwPFFCOQReQUKSsMHQhyQltVjeQWsgrJNeLGW5/ke1TAbUZ+c9l7n8DPxw
         j10OYhHc0SsjsH24icT/FS8oCnxl3WdqVBjaZ6zcDZWAAuves/aEsgt1XSYKq4wMkbXX
         tiQw==
X-Gm-Message-State: AOAM5324ACYgfAHJcvr3dovPo9zaymxmR1BcZPU+nV7Iu+eZobUYJ85c
        DX3uZTR8xdzJG5TcJckk1bnAN4tDMobY2w==
X-Google-Smtp-Source: ABdhPJzfl9tptihcePPoiHqF+W62oCigypXZ/5zVaQIgJdkDqDA8bMcvGFKA6UmS67XRFPSSRjJ3mA==
X-Received: by 2002:a0c:f2c8:: with SMTP id c8mr3417630qvm.64.1596122291592;
        Thu, 30 Jul 2020 08:18:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c133sm4457534qkb.111.2020.07.30.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 08:18:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] btrfs: make sure SB_I_VERSION doesn't get unset by remount
Date:   Thu, 30 Jul 2020 11:18:09 -0400
Message-Id: <20200730151809.4889-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's some inconsistency around SB_I_VERSION handling with mount and
remount.  Since we don't really want it to be off ever just work around
this by making sure we don't get the flag cleared on remount.

Reported-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5bcdad3ee258..0a9d8b7664f7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1960,6 +1960,12 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	}
 out:
+	/*
+	 * We need to set S_I_VERSION here otherwise it'll get cleared by VFS,
+	 * since the absence of the flag means it can be toggled off by remount.
+	 */
+	*flags |= SB_I_VERSION;
+
 	wake_up_process(fs_info->transaction_kthread);
 	btrfs_remount_cleanup(fs_info, old_opts);
 	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-- 
2.24.1

