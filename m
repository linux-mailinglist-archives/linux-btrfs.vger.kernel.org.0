Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED43B70D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhF2KnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 06:43:22 -0400
Received: from m12-12.163.com ([220.181.12.12]:53876 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233111AbhF2KnV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 06:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=sfTj/Onwm/8mctLs4j
        l3YD3zYZRkJI6Vg1SHgkrYB8U=; b=UG737XaK60KiQ2V3p4dPj4cBfclV4nUSkZ
        Nj78uIBYckQZWCMWY6DCquqYTpiNmS0F4ieXkNAobRsIoXR8D4qxsKS+QNy1yJSe
        uBftqqDm0teMP9IM49ginsmtp4k1bfLBoM4K34lglRvkU+4D0Wc2byNv1nyPDtPP
        fiNqG2ggA=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowAC3fVqw7dpgLLt8MQ--.18080S2;
        Tue, 29 Jun 2021 17:53:53 +0800 (CST)
From:   lijian_8010a29@163.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: ntfs: super: added return error value while map failed
Date:   Tue, 29 Jun 2021 09:53:33 +0000
Message-Id: <20210629095333.115111-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowAC3fVqw7dpgLLt8MQ--.18080S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3Zw4rtF1fWryxGryUJrb_yoWxCwb_Ga
        1xZry8Grs8t3Wa9ryqkwnrZr4kta1rCF13K3WDtwnxZF1UJr4UX3yDXr1Dta1rWrZrZF9r
        WFWv93W0k3WS9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5lYLPUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/xtbBLBHAUF++MX9d-AAAsj
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: lijian <lijian@yulong.com>

When lookup_extent_mapping failed, should return '-ENOENT'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/btrfs/extent_map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 4a8e02f7b6c7..e9d9f2bfc11d 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -305,8 +305,10 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 
 	WARN_ON(!em || em->start != start);
 
-	if (!em)
+	if (!em) {
+		ret = -ENOENT;
 		goto out;
+	}
 
 	em->generation = gen;
 	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
-- 
2.17.1


