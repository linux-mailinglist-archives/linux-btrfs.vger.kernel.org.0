Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3AC2D12D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgLGN7v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgLGN7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:50 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F02C094250
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:00 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so12474885qkc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jG7U8zsWmSJCtYF5+aifWD66vMo/hyIuMyb0u2b695s=;
        b=WatAv2P+3sTwX43dl0k7S0MjuhnnXc/GUVHhQb8fapmWIuxwL4ugMjF59D3gQPaJGg
         7qnyK+Rneqgm7qYZZsv5BaOuhcQ83lQZ350DmGew245BOUhwmQbBjphqaEq5rKa4DN6O
         WCKDLTKyYRf+65YRSnDUYfao7SHTGhfNjlXRRKb/tX46eeFM5fH7NJJNKCT14oyng1DF
         WBZtKubyVWQRWOxQGYG61SWb7FUORGyTSqIh+ra2CkAx0fDV/PX8TE1Ehr9Z5/gy88mU
         y/Ykjyjo8gTLlXrVJsC4UoPA6ljqy7YisgJ+9EtlulKgY3GfQ1mHA81+k1IGuMKYp1GT
         WtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jG7U8zsWmSJCtYF5+aifWD66vMo/hyIuMyb0u2b695s=;
        b=tI1x00eYdt4mvIFO1fPmdVI4R53iLGHiRtXVPgcHgqu+hjf/W7aJmauh+BlEQ+igB9
         7REGGH6u8lnSiifXwHcLcRlDkEogd7cH5N27pn1Xjvwx1Z940NMhh3Ntl78um6DHY+FX
         fzqlFSOd9//JYLiZxbL2304KSt/gvnjRhKlMeRwtUta0KJQfk9V8ah44OKGzEMrGvaZU
         i05gFjTzCGV4zMsAarMfd+2ci/qwaAymjIzSyeepYd2U1ZEn12UsmkT6km1OWsw4VXOf
         9z7Rr5ILKdQsZ6QKn+P01fGymmrJDlIgAZUM9OOj7gEf+UAP838ST3xpp6yf0DTNOajz
         G3Kg==
X-Gm-Message-State: AOAM532auUHWuAm9m5NRFr5q5gLsd0/pXRiJs5c28wolluCvyPnZv6Q+
        nO32ytaCEu5+gu4q3FtbAljkghJSUXSDEq29
X-Google-Smtp-Source: ABdhPJxZsHHChf4i+W0Wgfh6nMAFxFlNoq2tq9EtIVSLAVnwQnqc8EgsQakH9saykP6yr1YoO721vg==
X-Received: by 2002:a37:b342:: with SMTP id c63mr24570918qkf.146.1607349538892;
        Mon, 07 Dec 2020 05:58:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a20sm10846977qta.6.2020.12.07.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 37/52] btrfs: handle btrfs_cow_block errors in replace_path
Date:   Mon,  7 Dec 2020 08:57:29 -0500
Message-Id: <2f291e8577e2b214458d7761c3af809db1db7817.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

