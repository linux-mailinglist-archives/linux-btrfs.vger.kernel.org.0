Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238C92B0FF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgKLVTY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:24 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D374C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:14 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so6922415qkb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZCuIW678VzDH1QHLtXOwSfc28d8DL9CJedazi02ztxo=;
        b=aYLNX+wWXMBqqzwmFH2Rk99czCpuvkZGuIWF9FSbZvIbL4fZ3jX9yhhQdghS/yuqA4
         9RGGPqP+dN1Hqh0He9uVWltGQYlHMHMiXyWHbL5DDtrcYBqiAvKS12OHiw1x74jlYZxf
         5LnV3A3Vr1qvW4PQemOfzVmkFvnB3Q3H4ZMJd5I/fTNxFGF+ZG/+WMl8CcjIJsyv1Qss
         PdJCQp5vxe2xoRDmJPLSnFRfKy7bSdss5dATT4RHAq6L5D6D4JB+jBCriRMBymlQgK5j
         Q9kw9iip0vCrgEL4tti1oWsTSJ1ytitao6paSLT2KJQNtgohWscJ2YaPJn7KY+zORjhk
         I49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCuIW678VzDH1QHLtXOwSfc28d8DL9CJedazi02ztxo=;
        b=nn72DFno7ZyEmFcNxbhE/5MpbGOyWP6ipCGxsljam85AQpMjto9yBM1LqcSuPf/woQ
         U/5NDbofnNbXerOAmMbpEyzVEtGeaIBDnW1yh+YGFzLNvlknJPSsvmWZMtT856+qrnQj
         sxcWYPK4gL2/fCn/iQy7r/W4A+uSzlpRqz1gov0blNuUr+EPapwaVp7QuxrwE8btWET3
         +aPPT/0s6l9cWtCcFnLC56DS6wtapuftscB2SntjfruLSgeUz/5olSS0WKcB0FGuT7Bs
         yKKwx9YtWB0JvVYc//C5OEvxy/smKx19CN3idqNqtDRyW5Qcl+k5Sn/MOCdqZQT5mlmE
         hpsw==
X-Gm-Message-State: AOAM532Fg1XDnzEAujfT9D4aG57WoByMd9NVW57EfHxm2HDzdzGXNMs+
        Sk3Iikgbhh8CQ7rHaFJ5YvaWtoD+P8Ml7g==
X-Google-Smtp-Source: ABdhPJyITTOgl1vUqN6TSgr6/EpfD+ryLgqgOUgpUqAVz0gKmkIRMZph4rJFHleBSoUzIze7T001ww==
X-Received: by 2002:a37:9a8f:: with SMTP id c137mr1760032qke.404.1605215953375;
        Thu, 12 Nov 2020 13:19:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u16sm6108479qth.42.2020.11.12.13.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/42] btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
Date:   Thu, 12 Nov 2020 16:18:28 -0500
Message-Id: <d4d168d0a592fa8f828174b3f93fa463b922d492.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following patches are going to address error handling in relocation,
in order to test those patches I need to be able to inject errors in
btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
often in different cases during relocation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d2d5854d51a7..a51e761bf00f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1493,6 +1493,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
 /*
  * helper function for defrag to decide if two blocks pointed to by a
@@ -2870,6 +2871,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		btrfs_release_path(p);
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
 
 /*
  * Like btrfs_search_slot, this looks for a key in the given tree. It uses the
-- 
2.26.2

