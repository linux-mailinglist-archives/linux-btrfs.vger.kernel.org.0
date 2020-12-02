Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D082CC72B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbgLBTxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389812AbgLBTxX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:23 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C4C09424A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:27 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id z188so2459450qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jNGNXfmkBckieQ1CpLwdBI/IgYlgSuiJ+CZZGkppJcA=;
        b=0cBAC5MhVIy96BVZZHHIqMbolT+q0YAFuAcHM4SfHr6UjpyN4244DyiNAk6rgordkP
         Ryrxuj28dxg+x324c65TWfP7TUhKFR/V5d+QjRkb0azipvUkkzPIbgjRqkb3IUvAqqlG
         4cwCA9IKVR3B+CeWTITIf0l/2gKrJD+O5HtfgGZVXMX3s6gEoir36iGycc0F0u2a/maG
         yu19kDdN5Gyj2hPs6KUAOW2A7GfxNdIDiLRmObpBKhUu9IacKSwRrZRESHSZ998a7ATN
         vsi+HfIcFQhuEfJfz+bt4WEZOwYAoEoy/28+tFyRCooxa86VGKulO5L2oKWXvQ3Ghyl6
         r0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNGNXfmkBckieQ1CpLwdBI/IgYlgSuiJ+CZZGkppJcA=;
        b=Q5cQ8rCQ4CRPiOl1dzk4LFBuzprFm+2f5JUwY5K7+CvEXZEqv5nBryMgaM4ikDVmTK
         rpwdbXmhQiFXHDG6kvDuYbSocT2JnE144MUXWCEbEDGR6VdcK76al7MQT+Nah0/AZz0c
         Y3RpVzcpqocN1ZuHA/hsf+QldUakUtN+D6fUzQsOKi7GfJz1XjaBduX+I9j2DMEehdHo
         e0/V66hD0lndWJ5leiTROHEHeLl13aXgaxaCxDIOeJhRiWpjnUVNqUBf2v7oyQrZuLb7
         9KO9yaZtzcj+1Ai+A4hiuMxu+Dz0HCnk8BsAcn+VN9asOrhZsWpAZi9Xmg/8bNw9Kqd5
         mkZQ==
X-Gm-Message-State: AOAM533hAzaKuYAB8Umf6UKM3qQZbuakFtXtAY7oHVrBnEf0KkOaofvK
        hHsIxHlkSyFJdcTYKhSaBhjE4xd4AQwuSA==
X-Google-Smtp-Source: ABdhPJzpTcNOVwDYVQn1cQHjAhKCNb+eI1YnRRXedGu5AobP46fe957nfj77DvO9Z7NGQuHnlBQgpQ==
X-Received: by 2002:a37:4384:: with SMTP id q126mr4366320qka.30.1606938746310;
        Wed, 02 Dec 2020 11:52:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l79sm2965202qke.1.2020.12.02.11.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 40/54] btrfs: handle errors in reference count manipulation in replace_path
Date:   Wed,  2 Dec 2020 14:50:58 -0500
Message-Id: <25314fe734d56e1a4fc924e7a5f923ce01fed88d.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If any of the reference count manipulation stuff fails in replace_path
we need to abort the transaction, as we've modified the blocks already.
We can simply break at this point and everything will be cleaned up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8c407ebc5500..ef33b89e352e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1355,27 +1355,39 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
 				       blocksize, 0);
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
 				       blocksize, path->nodes[level]->start);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
 				       blocksize, 0);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_unlock_up_safe(path, 0);
 
-- 
2.26.2

