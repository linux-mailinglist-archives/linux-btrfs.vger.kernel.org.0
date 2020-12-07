Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1742D12E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgLGOAG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgLGOAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:04 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A55AC061A4F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:14 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id g19so6507925qvy.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGsHCr9+jjzby7vaZe+QNyu0SX+RrI2Eyp5IdEhxAGw=;
        b=Mg8oqRc5cZhKTWiPr4lIKkt/qmXKtTVekD0eEAp8OISmwMjbAsHAqur1oUoa9uuE2Q
         5J2+FAhkQ+RZCQIGxTDPxrJQJpcf47AjP0YlJcfaSuem1eN2kBi4LfY7elaJUkb4KTy8
         fwAlbrUQfUQMIRrlLHRx7o6oryonEJgTYGwKCz/lrJI8bLmubsiHTFI2KiF5doPwfHxS
         sIBBiXd5ij32yW14pg7oUrSrHtoiZsKazRWh3vzRDNiF8fPUpgDk3KWR35Rq810XmUUp
         KNs0GdX44IZI00+7ws1xDCnUFOsJXsLVLHfPV1R72hFLRxYz8PKMwVbpWmu/KFsVeL1W
         a+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGsHCr9+jjzby7vaZe+QNyu0SX+RrI2Eyp5IdEhxAGw=;
        b=Q7UCx8/RiwJCZoiIb2lQk6NWJnAJFXqiMN3j7WMI99xttFqE1RVOH52L8QlrLtzl3m
         22tOes2eNNHRT+W5DX8ECrYbTs6IuV7p1LqTmyXCYR+jnykZxqwBckZSIN23yCZS2x6u
         0X9Nzmbmgor/AOhKZh0gx/JJhSPBgGA/HanXWx0dDA00HdpC9zKcth0jLfirJtj+vymf
         KR8sf6wOVWv7v7yHS22k+rE0DDCTsflYTHcUlO1Pu35HVmM96vLe6/GL2lidTETlsRJa
         Ebkq82e00YcCOd2zUdz3NT7lgIAAYc2uRLkUUF37mE+v1mjGWTYeWsO2t1sDwQgJJ85z
         yWDA==
X-Gm-Message-State: AOAM530J0lc9CFDIZbRY3Zb9rquvPRwcH68NXv8ZpQ/u0bcJGmC21VOp
        Z/OEufIHRRfino58/H24Fj/NFJjzEZOAeNo2
X-Google-Smtp-Source: ABdhPJxKuaq0vSmsZciYOiuSYKD3eRpmlUs9G3Uxo5lB1TJMX7vUbBvlHec/TUeLEXmN1ucKEIlaUQ==
X-Received: by 2002:a0c:f185:: with SMTP id m5mr9377076qvl.19.1607349553327;
        Mon, 07 Dec 2020 05:59:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h1sm10469188qtr.1.2020.12.07.05.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 45/52] btrfs: cleanup error handling in prepare_to_merge
Date:   Mon,  7 Dec 2020 08:57:37 -0500
Message-Id: <988202f8add9ac33eb9e3662856400972f9a946c.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This probably can't happen even with a corrupt file system, because we
would have failed much earlier on than here.  However there's no reason
we can't just check and bail out as appropriate, so do that and convert
the correctness BUG_ON() to an ASSERT().

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a2900dc71c72..02760544cba1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1870,8 +1870,14 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 				false);
-		BUG_ON(IS_ERR(root));
-		BUG_ON(root->reloc_root != reloc_root);
+		if (IS_ERR(root)) {
+			list_add(&reloc_root->root_list, &reloc_roots);
+			btrfs_abort_transaction(trans, (int)PTR_ERR(root));
+			if (!err)
+				err = PTR_ERR(root);
+			break;
+		}
+		ASSERT(root->reloc_root == reloc_root);
 
 		/*
 		 * set reference count to 1, so btrfs_recover_relocation
-- 
2.26.2

