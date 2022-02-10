Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2D4B18B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiBJWog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:44:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbiBJWoe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:34 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523E5F73
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:30 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id j12so7131866qtr.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ygv23XEVMUsAFHEd/+7sR/Mq+HBoeNldTq/7u+bwTyo=;
        b=fWB4qSqa3zo+3wuYpsj4d1MKRkZ2LckFaO/TMEnKUuNBaF3Tpq2ssPeull9ogA9DYm
         FLW7FFl7EJt2WSBOCdGjsm/iSjYwjGFm98e2jyd6BSGcKDzwVhrzrPcjb4hHcm6GoUDw
         gKwfB6pzQk5IopZqXW6BevOof0CjcjUC9nbuK+BW80I6MXmx7eMubun2YNnC09aG9Fje
         hySuVpktSXd2MudQiG+hPye5WDjo0NolipB5uzBgVAyUqzNaMm1vizh4rvZ2cihSDLa6
         frT3BsVpdmPTX+Y+cLfO0CkQgethUfUCeyjXT1MN5y7cFVr6+Rft/j7qXEuH8ihS9F2f
         Ebuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ygv23XEVMUsAFHEd/+7sR/Mq+HBoeNldTq/7u+bwTyo=;
        b=whRBe9uwM3FXn5u1idjrOqAyLxXZhwzMz901axsyTEdElT+/e/iwcwFVnGxUk2Heh5
         BP7EXMmYHwFs8UdCU9uJ/ZKMfIuzIxsBIf8Gl1kJ889yJSPiypcSAqvmoSho4HH6Y16T
         +cd0/EmhlszA7gDQW+8Bn0FEqywrx1SUD0ANiA0uV2OmqkdHik378LTeIgB77FxOBe0r
         9gPVgmg2A2grf6B9nGNxmTE+9n9O1wA89Ps373VMZcddbZkKsc+t22dP38vtFWnZDcqq
         /oPlslRgYt2Zu4AQA9Xe1U7LfSaYEul7RRPSY+BzbZr/rf9EXVggIlCaRwMKZGvnFaVc
         K46A==
X-Gm-Message-State: AOAM533o4DTNDOmgItfh/Wy5EVCPksb7r3HSqVk6RWQSWmL025dfoB8u
        cFJzg60yyYWxQxRPfSRd2VET/bhmyUzuV0WD
X-Google-Smtp-Source: ABdhPJzeOS7q5mVPd8XTEVRnhaCctLPL1BaxDeRwE/0uabg/xt/oU38UznBHVQr7tagXSPSnfS8UyA==
X-Received: by 2002:a05:622a:494:: with SMTP id p20mr6615991qtx.652.1644533069238;
        Thu, 10 Feb 2022 14:44:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j15sm11824317qta.83.2022.02.10.14.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:44:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: make search_csum_tree return 0 if we get -EFBIG
Date:   Thu, 10 Feb 2022 17:44:19 -0500
Message-Id: <772083c44ddbae8edb2d52ce2292f8a2dfc08ccb.1644532798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1644532798.git.josef@toxicpanda.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can either fail to find a csum entry at all and return -ENOENT, or we
can find a range that is close, but return -EFBIG.  In essence these
both mean the same thing when we are doing a lookup for a csum in an
existing range, we didn't find a csum.  We want to treat both of these
errors the same way, complain loudly that there wasn't a csum.  This
currently happens anyway because we do

	count = search_csum_tree();
	if (count <= 0) {
		// reloc and error handling
	}

however it forces us to incorrectly treat EIO or ENOMEM errors as on
disk corruption.  Fix this by returning 0 if we get either -ENOENT or
-EFBIG from btrfs_lookup_csum() so we can do proper error handling.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file-item.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 9a3de652ada8..efb24cc0b083 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -305,7 +305,7 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 	read_extent_buffer(path->nodes[0], dst, (unsigned long)item,
 			ret * csum_size);
 out:
-	if (ret == -ENOENT)
+	if (ret == -ENOENT || ret == -EFBIG)
 		ret = 0;
 	return ret;
 }
-- 
2.26.3

