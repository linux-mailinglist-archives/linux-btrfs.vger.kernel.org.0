Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338CB2CDD78
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgLCSZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbgLCSZI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:08 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453BC094256
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:08 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id x13so1429144qvk.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jG7U8zsWmSJCtYF5+aifWD66vMo/hyIuMyb0u2b695s=;
        b=O1owu5xc/tzDcRC4YliiDjCnE9LAC/XontRtTU6PuZ5druPhFwnmB+P+JbsGWBK2iJ
         1A8AexwNfNM7OjMuTGuWeoTifvCuArF+w7mwPsD93DSoXHchQXlCdrokOT/D7m+m8nkv
         SMrjEVBnagRAq0Jk1zUQzI5lp8ZZQVM8rHf0UC3yIbgxXLnL9ai/Q1lbGsrcky3DGdH/
         k/S+0MdR+YPXaPO3j5bR+uHnML8EKp3N5ZQBEN5BOP1A0gE1zXy79DI5KDAd45i9el2s
         v0zbwSegDGQw8Yva74Y7YJ/9+zqWcylMMwMXRZrsbzl1UfqMevCfgmBT11UW51qGQ9oy
         aE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jG7U8zsWmSJCtYF5+aifWD66vMo/hyIuMyb0u2b695s=;
        b=AQdiEw2/JQCTdoZKSxh0mnOQXe1do/CL516bnBoJpgnW3wKYwx2Fpuq9jOJuRJH4Ez
         SZ8KO76CYXJaFD/Vb3RrpTlOEkMfhgG2VaBMvoBsm2lfFUX/j7ORt/fPGB1Hy5SEM8Fc
         4H+ibxszyeaKYv9cArGn2E8Q8BD8jtfCvlpunFA3WKTwIhAdzJ1A7ESAOC94R6uMHrPm
         +AslmkERUvpNZZBk6a6lYuGJrGXXucJmgDRuy7fng111SwITIFttMeRZhFeyXNylWV/S
         hmKkefSgonISSuRLIebJ4PZKouF5C2igQUU4+E1BHzOSZJ4n0cHYUjSmPwgLI4SIntWl
         cgew==
X-Gm-Message-State: AOAM530kbREJEASv75Dp/hm4pVFbpn7GTquudO8jy/GW9T32viflupyB
        BX32nK3HapUmYbUQ2PvkWDNSTp6efHfi80Z1
X-Google-Smtp-Source: ABdhPJxWbO/nMaCkmskUUcsVnzVbpR9nssiMyGPWtFUUkmKTipLTUjNTmedsROe1mk7vWnCCiY9rUw==
X-Received: by 2002:a0c:8d47:: with SMTP id s7mr307813qvb.17.1607019847606;
        Thu, 03 Dec 2020 10:24:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 76sm2139887qkg.134.2020.12.03.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 38/53] btrfs: handle btrfs_cow_block errors in replace_path
Date:   Thu,  3 Dec 2020 13:22:44 -0500
Message-Id: <b3909fda612c0cf497bbe6ef4eb957c9bf7ea04f.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we error out cow'ing the root node when doing a replace_path then we
simply unlock and free the buffer and return the error.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 30a022f26cb8..5a654037795b 100644
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
@@ -1282,7 +1286,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				ret = btrfs_cow_block(trans, dest, eb, parent,
 						      slot, &eb,
 						      BTRFS_NESTING_COW);
-				BUG_ON(ret);
+				if (ret) {
+					btrfs_tree_unlock(eb);
+					free_extent_buffer(eb);
+					break;
+				}
 			}
 
 			btrfs_tree_unlock(parent);
-- 
2.26.2

