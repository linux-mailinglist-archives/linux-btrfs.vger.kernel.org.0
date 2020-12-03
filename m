Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35AF2CDD82
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502038AbgLCSZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgLCSZK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:10 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FD7C094259
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:13 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id es6so1429804qvb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BQnifcFL/WPLj7otSCT+NzpZ09jzZaVeOVpCVlLc5Lw=;
        b=U1a30Vu6H5XWzOKuYyqBSTvqSVvKuifMsn6qjQd7fP3LaXzTWNL3sjLgjGsd8YXf3C
         wGE5C5m5EjULIN0ObFrFRE1N53Kcl8c94i+hXCUFBSw6Y20JImC+K7eV4uxuKoRNfVEA
         k9ohTcOiz1W6V7qRrmunob6BgIo3VAlfVaCc+nIsV2+lEwUBE6BmuOav7Hhao5TMCEBI
         Z9QKnBnsjD+4TKqZ4lfwfeOGZuH99PRtqpqQdWXa73U0PP7SU9EdTWaFVS9NGk/j+go8
         WcTQZV5WSalEUT0pUCk4IIb3Co6GdzpURYMda/08bhnPPSLae0tSLdldEsmhLMm9lD6w
         LlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQnifcFL/WPLj7otSCT+NzpZ09jzZaVeOVpCVlLc5Lw=;
        b=eXraMwpweyeiFkpEJitVa5WQ6si/duE0ucxvbDTN/57ZjB501dKRtYdSurM0S8lMGC
         mE7Y7e+7moCmTkTAzH2hFG5egOzZKQfPoActIPJJUu6Gm5RS7SGyOftILazZL430b4fK
         pszQxhjuZSdwnUEgg1/LS54tSiPGtaOOFInu4VAVdiJG5CmGCzBn+0s/dQUk93hexcMl
         rYBhEXlyG51kmZKZW7c6ycA4Ozpd90zhwfEVmG30zpJYW48x30PmjBOaLEjGW46YuknZ
         I32TmfN8eFfsE4LFeOPfs4PwaGBUWixMVS0cl20pCYNAaVmh3aWJwU3hwEbuYy42X/Do
         b7eA==
X-Gm-Message-State: AOAM533ibuQb6DwKI6g2Xv+eqr6dg5NmWv12fRw9aUg4O3vGWoTLXgle
        b2TOauLkfPmlWahPFOJF62WD7pDTue0K8ohw
X-Google-Smtp-Source: ABdhPJzwre8AMWgVjzksZXht7OYsDiquia8teMhN8wVrjA+wPmyBL/9+ZGbjHXwTu7HJRLRGwHX7dA==
X-Received: by 2002:ad4:42c8:: with SMTP id f8mr154450qvr.29.1607019852883;
        Thu, 03 Dec 2020 10:24:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g11sm2207667qkk.72.2020.12.03.10.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 41/53] btrfs: handle extent reference errors in do_relocation
Date:   Thu,  3 Dec 2020 13:22:47 -0500
Message-Id: <8fb9245c24a498f97b161ad1113cd1f830f205a6.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already deal with errors appropriately from do_relocation, simply
handle any errors that come from changing the refs at this point
cleanly.  We have to abort the transaction if we fail here as we've
modified metadata at this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e025cb052d77..bff7e99f3654 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2426,10 +2426,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb));
 			ret = btrfs_inc_extent_ref(trans, &ref);
-			BUG_ON(ret);
-
-			ret = btrfs_drop_subtree(trans, root, eb, upper->eb);
-			BUG_ON(ret);
+			if (!ret)
+				ret = btrfs_drop_subtree(trans, root, eb,
+							 upper->eb);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 next:
 		if (!upper->pending)
-- 
2.26.2

