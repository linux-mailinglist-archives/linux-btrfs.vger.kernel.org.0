Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC422B2032
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKMQYA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQX7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:59 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C32C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:59 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b16so6801585qtb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AUKOG8uy6oEISTtVsa9N9Vu5OLNM/vxxalFatwonkoU=;
        b=y1Rbs//9k+WwQOmLm12+M1roNbk9wEaJqjrdeyffSTH9URg+nftoqkewmmH5Gbch6R
         tHJJvZYmwHKRGNghg6zEjY3287nuyIY6U6uXXddNIDUvGfPvVUO5SGFFc6eiXwUmAEUX
         vaVxKBUPLx5nFSLjWaGvW0Kw5EXYvlP3bxPACIZwoQx8zVC8Lr8ahLug2lWjCfG9ohG3
         iDUggE4SLadvzzntnSUEUPPkaPooVVfE8U51T19oknDGMElO6gNZh7y1W0UOYPzovl94
         asnIIUoDa5rtMMB434COCwVjMGhObdHhXgPkRSBirpRcrSbhNRoewVltHMYe618jpD7K
         V9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUKOG8uy6oEISTtVsa9N9Vu5OLNM/vxxalFatwonkoU=;
        b=UIxU3vjHAjAkUwOm+u/wNID+K2e7qtrfsit/r7MG9EGpz56ctiAWfvptkaZ7SfjGcv
         yQvgaRC5MuXkRMRs2ezZUj+YD6NjVdw3oAuyh0R9jOvkSC5qvBP4a+7W3vgOTSOk32xy
         pLeFBUO7fWQGsFSgFdGYAdmnhPYjMtxAlD1XeI+9TXLLzDAHpy2oJ8j04pfarbuCoNC1
         ipBrIz5nqIDy8EVFEmsJ40xvGt153sdiigEaiAWlbIeYd5LsMYJXbZ6xpbamigfOli+/
         hqp4qau0Xfjr9DHm+JykS6CZB1lYS4c/QQWQFlStMVuXd7AtkJvwkTs9lnLQUpYvTSh3
         W9wg==
X-Gm-Message-State: AOAM532unNWzc2LaxwdiK2bR6U4FKFismZ3xJz0DDVudJgkbwr16dFg9
        Bnig32B3LncPftFT4Ceh4M8OLDZeMY5TYg==
X-Google-Smtp-Source: ABdhPJy7Zx+Sw1NfkPXkHBr4uS8h3tKo5CGp1T47rOexd4ajhs1hzQl8oDiAPOIFKYpif7EJanUSoA==
X-Received: by 2002:ac8:3805:: with SMTP id q5mr2789643qtb.53.1605284633054;
        Fri, 13 Nov 2020 08:23:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o5sm6865002qtt.60.2020.11.13.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/42] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename_exchange
Date:   Fri, 13 Nov 2020 11:23:00 -0500
Message-Id: <1930ec8f0af551d8bc12ef3701b035ec74df771d.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename_exchange.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c790cff41be5..e64c6a98ad54 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8883,8 +8883,11 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	/*
 	 * We need to find a free sequence number both in the source and
-- 
2.26.2

