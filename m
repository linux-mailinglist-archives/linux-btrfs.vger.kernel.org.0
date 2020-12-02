Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B812CC724
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389789AbgLBTxT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389770AbgLBTxT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:19 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103B5C094241
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:22 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f27so1980923qtv.6
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2Ycmgq7m/f14gdbOTd/vz5fekccrt/XmcdSLSn8cRv4=;
        b=PCXsEhuSzGvo0wjYMk/1OockXiLCxdPI5MD2eyR9zd0zU3D8h7H2rdPPCAvraaKb+v
         SFe5YQVHBxape0HT/cWBZQJK98Uq84eeyRwiPg5dEJq9hlnDxmxKl3OQdEJzCPtRyAu5
         HxXmazLnSZSDsBm7ViJQVfmybk1K4GqzKwP6BgSmPy5xE6C3BwGQtCow2bdpdP4HFAll
         Py52AkhHrIZ6WQ5UMxpYPAEXQLCTM/Iv64vs8c5cJ1ixO/Ygun8iHT3rP9PaS1EkScxs
         1e1bMYbjl0GeoTMIYsgY1uhh2ClZrj4TUF3JRg8tPU09h/1GFRaScq+nM3/R1R5JqZeB
         fOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Ycmgq7m/f14gdbOTd/vz5fekccrt/XmcdSLSn8cRv4=;
        b=uBRV1i5w+IYgIHqI3roo9ACMacsM3MALeB9hthijgvi/mbjA906Efq+G5fEdoltZMn
         2hwehQ5gZ6iQ2DzwoCf7wxu2VpR3CUT3oGNZoRgTWUND14Uem8WWVlGdsk5WD6fgo1P1
         WiKQ8BBOM8+5G6aeIRVWKUz1GWbxiyyQH1CUmooAQK/H823ib6zn2yibCkkIUG0nYo2u
         +4Fq9VIZ160qumD7jT+9KjhPgGdw4ncf/HRH16lcPKlIbL1aUTaAiFDsEx4/fZSM8OGh
         RiinHFsAO3e1AkFM/shMVsQKHgkxNG3gBUE3t/tIRT6qp9NHUuOU9BRyQlqYYrnLT7kB
         mleQ==
X-Gm-Message-State: AOAM530HNqdIWNO7j7R0c+fpvxZY1P2195J0ldV3uJ1gbTmawTBULAdL
        89nTx/SKwuqXaqPbGIblXpNXyLJJReUrFA==
X-Google-Smtp-Source: ABdhPJyIewjCU75W0V2sBCknozkWsR2chyjWcouSDw/TjSy1GXV7KKjt1IOqxb3KFEzXW7p83p38UA==
X-Received: by 2002:ac8:7b85:: with SMTP id p5mr2005956qtu.264.1606938740877;
        Wed, 02 Dec 2020 11:52:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h24sm2899434qkj.85.2020.12.02.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 37/54] btrfs: handle initial btrfs_cow_block error in replace_path
Date:   Wed,  2 Dec 2020 14:50:55 -0500
Message-Id: <6b80c4787250be970ff8bb1c1f261492cafba7df.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
index b872a64de8bb..52d6e7ab4265 100644
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

