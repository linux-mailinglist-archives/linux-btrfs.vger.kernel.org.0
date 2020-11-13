Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE42B2033
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgKMQYB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQYA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:00 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9ACC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:00 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so9267450qkk.10
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w7cPmJ+Y8wboqlNkW+V7ayOfpi28XsbJ2qVVflcI7+I=;
        b=IuaBxJDRZ9B0oh21HQE1Hb5hGYGbDolAwL/JDhf8LM1OyFRwN++0lNC8Fm1TgEEtjk
         giX3WGGgRg88W1SdctXtgfrWF397zXrIEEU1i2sa/ZF1KVsoMVBCPpe3+FVKtbqdr18K
         HGCUHRHwxnBQT7D/ow5rUtPlupPFlrHHrrfaw5IzJcP7fz9N/Ydk+8ammGoliXUZMblP
         IQisI8AKBD6Wm91l+aufgJuBgs772paYHeeY3dOlr30OVFbFm3YgXAkoxksz5sPB6Kcf
         4hzgCOEJq91NzPhHW4rx0JsdspRvrv2pWFk3hoApMTlQE2MWnhQKJ9TTZWv3WJxYCi3d
         e1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7cPmJ+Y8wboqlNkW+V7ayOfpi28XsbJ2qVVflcI7+I=;
        b=FPZPtBR01E25ttk/TdrfnFehJFQQG7oCTzaGgebTtA8UBcdL962NYYpiz+Z0+p5ReB
         HE4HX+OxOxwjZtbtr5nc/EiqWL231mGVupWse2bb/VKF4+/ao/1nHhvN8ChHIGmnfMph
         q+Y6eQGSo1HDChMRT5v64DGrLqfZyg4AEKS87DY8BB20g7eEqzIm/dFGC12wEhwk5Ipu
         Icmj8wtOmYp+jBi8WJxo75j3YRQArpSJK/dSQmnB1JCYbQbdtQBUgWclNRNaYXUragai
         b23KUypOdeiIUDNXIxiIO0SebZ+D0QMVvV8XkbFY5N/XFH/kcVtiiqYb0PNtqKV+xOtQ
         U6tg==
X-Gm-Message-State: AOAM530fGfRrsP9J1jwKW9n4acjogbdFiHtfP3jGpY/B22QWdgVSMqkd
        8+sqvb1E+9F7NPID8/1ozn9BUAMvDgndqg==
X-Google-Smtp-Source: ABdhPJyP5dn5Jpzlwlts6AxMDkXSm4ASIV1RWCF1k0lNT/ug9GPEnw2K4VNHTHAN1cXV3nEgItb+uw==
X-Received: by 2002:a37:9fd0:: with SMTP id i199mr2703000qke.210.1605284634835;
        Fri, 13 Nov 2020 08:23:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n201sm7117045qka.32.2020.11.13.08.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/42] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
Date:   Fri, 13 Nov 2020 11:23:01 -0500
Message-Id: <f89cf41b6ef3cc8bdbf4ec2f3af04a91b20d8879.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e64c6a98ad54..ce6602a80324 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9191,8 +9191,11 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	ret = btrfs_set_inode_index(BTRFS_I(new_dir), &index);
 	if (ret)
-- 
2.26.2

