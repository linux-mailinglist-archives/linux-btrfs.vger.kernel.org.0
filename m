Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED512B1011
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgKLVUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgKLVUX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:23 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E27C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:10 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id t191so6912905qka.4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gci6UbAGoxM2b9SCHOfO2VAOjA7ebv4bmJ9r/hJFe7o=;
        b=u4Q6CrM93YmFPpaxn/26Qq249DcSNNhWwTnO4R58JLqow3U+Kee+DCC/3c1GbiK3zb
         XPhsNZKvmRw9J8TSkGln3fjV7dZ8iC2wz3XgZc51MJWq9Wpj+a/0bHdQ429gHd8NHj4v
         euL4dmh601Oa1FPRBO7oDKFVbGPKckehappc9WYYzh3+itI9OK1y8y/LreUPQwfdY8bA
         35xJKLfbPOUKZT7YPzRL15+p1viIQZRDPJjawyzJ3FQMQRSlTDAe5jy5nogWVrTFyHt5
         cMze7e1BVk+4uUPcDNBZzb6BYe1af+i4VIVBAioVLP6Svt73jRENQtn1a1mulVbyNx+O
         Ciyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gci6UbAGoxM2b9SCHOfO2VAOjA7ebv4bmJ9r/hJFe7o=;
        b=K3dYL5YnNfKDgkqqvQlhoTNCe7qlaQtRSUrF6cmwdd7CAX9fSkggcAQqZqJgkaFDLI
         GvvLEKI3xtKDf7FELUumiPp6viERxO8DMCV04Azt3jn1NKyfSmK+SBLsXR+LDbsDoHWQ
         HTk5WHf5mnPBI26U4AGi1FqFuPrVRP5mJWWYkOoqm3VrV0tpCe4ComgxCdpIOeXRsJjr
         n9Ilxb1aQcAKUOyQJO2GJdov2Hw9Ra1J16a/hMTdvXGBgwF0SSQ/bcp+CHnzt3PROtIV
         B3INNXRCqIT7eW7Xz8U97wgKClD+DKcCPY7I6uPAi8fJT35415RxwHO2UT59gnPK/qv/
         ArJA==
X-Gm-Message-State: AOAM5319gSKtEN6tcYB5LQ6aQrLF3eFo4hYQllb7wi76xm2TPqM+JwxL
        66UbZX+xwzVzfpM07QhUs96PXbr8xRlezQ==
X-Google-Smtp-Source: ABdhPJwPAiM04HU+61PSRvMx9Be5lBTHFfeMSrSsTRGUCrQH4nxKOGV4gl1N75HxFC+j/GOLj2EWAQ==
X-Received: by 2002:a37:a344:: with SMTP id m65mr1820042qke.241.1605216009912;
        Thu, 12 Nov 2020 13:20:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n93sm5532063qtd.7.2020.11.12.13.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 29/42] btrfs: handle initial btrfs_cow_block error in replace_path
Date:   Thu, 12 Nov 2020 16:18:56 -0500
Message-Id: <43ce1615429c6b3aeb25e9a78e650faef8ea8852.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we error out cow'ing the root node when doing a replace_path then we
simply unlock and free the buffer and return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2d1aab778fb6..07092d7a4d0e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1222,7 +1222,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	if (cow) {
 		ret = btrfs_cow_block(trans, dest, eb, NULL, 0, &eb,
 				      BTRFS_NESTING_COW);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_tree_unlock(eb);
+			free_extent_buffer(eb);
+			return ret;
+		}
 	}
 
 	if (next_key) {
-- 
2.26.2

