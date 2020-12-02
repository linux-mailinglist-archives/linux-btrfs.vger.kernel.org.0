Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49D82CC71B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389732AbgLBTxD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389691AbgLBTxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:02 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D9FC08E85E
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:57 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y18so2452028qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QaiW4FzyC+zOGOky4p4C47IusTqXWMYivyuT/22/y+8=;
        b=yOnCkhht9WlRah/wvbRND56oA5PkJEoLkiC6wPpsIT95HIo25LGgdDlzithr6HturZ
         Ryb5UqVdxeYP/JahcsZvnSxsYk9CXjCj9zwPlKbd9GULHKPN9qFazjqzM+N4xs/E2thB
         VuJxmZlLKQySeiaUDItHDm5nl/+UcHpgMetpBZdVtR+QHspGOHVvtSdEwmrrZ6hF7U4a
         UQTxBYPZVyfk0xd5ZjzJ+5NBh0N3+DVGGqZcf1fPr5cTjpvujfIYXpnp3638wTSMVvE8
         KqwKf08ybAbybBIA3Hq8LX8jXArCJ8/noLvpJJ9CgtZDv5gpZTBPhxE5vKNZ5EdTzylT
         Oq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaiW4FzyC+zOGOky4p4C47IusTqXWMYivyuT/22/y+8=;
        b=Hb1G1zo7nQGQ8Yldplglgi/oc84qDFR0SxsB5Pu8nNUDQ8Vt/QeUZHS52K6UlPptNM
         mOfETyIcVGWf4RewcJnCs5HzDP/oi+KGzr04P214wsNz89I4Esd1ttUlyJz8G9pA7KCO
         S1cqKQStvWkiJfKiJO10dDppWrx4EzUMEqsv5kEXSD7NOI3iJj5wqALRPRA7h3HkCWBo
         9G9/T2h1PVK2WZ0fpWFDUnnRs2EMMDdCN3i9KhbpXa7CdCwnu70L+m8u/pMWBfDlShl7
         xICsR5bTp+/FY/FWJrYQBed2LOUR9qtIpsurc1HAZ+eiLCs2Fss596apQBBlE66zfsfx
         NORg==
X-Gm-Message-State: AOAM531ysWMX8A74F/UTeHb9qbtKIyPFjkyHqrmyC552S2hfdyF4jFnL
        QR/z2HTpPVeFeACmhF/D+n74cvIm0ivMGw==
X-Google-Smtp-Source: ABdhPJyoRUknv4BNL3HGpQbfypGuVQKw9kKc0FzSjfJGYNuW1IzAIHR9hlD4Da58weDaf4KWr7P/eQ==
X-Received: by 2002:a05:620a:12e9:: with SMTP id f9mr4230872qkl.86.1606938716367;
        Wed, 02 Dec 2020 11:51:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 5sm2816745qtp.55.2020.12.02.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 23/54] btrfs: handle btrfs_record_root_in_trans failure in start_transaction
Date:   Wed,  2 Dec 2020 14:50:41 -0500
Message-Id: <9d94f28749b1f526dd79f562be6c61f51bfbb8c3.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in start_transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 28e7a7464b60..c17ab5194f5a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -734,7 +734,11 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * Thus it need to be called after current->journal_info initialized,
 	 * or we can deadlock.
 	 */
-	btrfs_record_root_in_trans(h, root);
+	ret = btrfs_record_root_in_trans(h, root);
+	if (ret) {
+		btrfs_end_transaction(h);
+		return ERR_PTR(ret);
+	}
 
 	return h;
 
-- 
2.26.2

