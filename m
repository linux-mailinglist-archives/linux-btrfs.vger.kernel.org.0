Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A46113AD2
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfLEE3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38804 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE3o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so1389461lfm.5
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plN9bZ8l10NAXFz0goFOvDFv7yREYJtRK02ru4ZZBS8=;
        b=QyngdsTeEmlxPpLufe4z51Gakq9AJprmd/wnFjiI8JcxtpkRxbGd7UzWbXHNW4HDng
         fhK+FaCIhxy1eL17ziC5qzrO92dIjKcydI28Sy/8hL+Zx6yj/M+cEBuqZjDoKizRLjZ/
         fB+k50KPAN4HI/83Ppf+BQFv/DF+eD9xvRen2MBEZ7Ys+0HRORR0hNhq8LjkCfUcq5BT
         F8tkXS3tcegL5f5kCdcaAdYp4xaNkYQh38UB2OLhrNd+k5JjcnIFwS9FMXLiTjZn4I8F
         2ZD+WSZZHdlp5sfd7jpAk3Wwb6HiBo14f536Am7btNV7PzTiX/6Pk0120DfxzviLR1kh
         l1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plN9bZ8l10NAXFz0goFOvDFv7yREYJtRK02ru4ZZBS8=;
        b=cheQxJdgIye5FPWp/k0gJY+9kWZqAiwJ4Fd1vI+u7xi0+F32sxKOog74zA8XtVPNwQ
         ec2hFpvlNPBmMI9PQavQwG4fSUMFhl5K6SO4oIogihDGCtUqXyV27xqSkAw2QosAaFK8
         zxaXrrIVXro/f+bp3lVJHEOvtBKez9d6fNThycY/EP5yYql/8QKX5OrqJoRJyPlnty5x
         oMN1dle7fFWGxV18UWqE/mGLoUkZ94/qx+lhT39i1U4FTcr9vfYRo861/zVUGj3oWdFQ
         8bX2rp2VNRLC9ALjEiVwYGBdyjtYFJdKg9EtL/BZr+RMFQSk9uxOENQMREVevB6h5pwG
         04oA==
X-Gm-Message-State: APjAAAVTjQNHl0DDMKHJQ/NcsmUXFETE7Gq50IU+Q4QPybFi08SzJ23R
        w1Bg1RNqK83P8pQQXifU0tUQG1qNFbs=
X-Google-Smtp-Source: APXvYqw/QKPQyVyvVK5OXwmmgKonlhlYPsdq/QUPH8HZsiXhPsIjWRstlW6dKtAAlJfOJ+5z5ZVCtw==
X-Received: by 2002:a19:6e43:: with SMTP id q3mr3742661lfk.152.1575520181865;
        Wed, 04 Dec 2019 20:29:41 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:41 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 05/10] btrfs-progs: adjust function btrfs_lookup_first_block_group_kernel
Date:   Thu,  5 Dec 2019 12:29:16 +0800
Message-Id: <20191205042921.25316-6-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191205042921.25316-1-Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The are different behavior of btrfs_lookup_first_block_group() and
btrfs_lookup_first_block_group_kernel(). Unify the latter' behavior.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 extent-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 1d8535049eaf..274dfe540b1f 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -243,12 +243,13 @@ static struct btrfs_block_group_cache *block_group_cache_tree_search(
 }
 
 /*
- * Return the block group that starts at or after bytenr
+ * Return the block group that contains @bytenr, otherwise return the next one
+ * that starts after @bytenr
  */
 struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
 		struct btrfs_fs_info *info, u64 bytenr)
 {
-	return block_group_cache_tree_search(info, bytenr, 0);
+	return block_group_cache_tree_search(info, bytenr, 2);
 }
 
 /*
-- 
2.21.0 (Apple Git-122)

