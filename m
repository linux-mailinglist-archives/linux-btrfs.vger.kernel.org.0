Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C423F345B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhHTTMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbhHTTMp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCDFC061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c10so9386822qko.11
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Wyrcd+RoTX9s4P6vwIurGowvZSCtgplS2sMf4RZFhj0=;
        b=hcr25uZzuMXnoVAZ3CPUP/CuQzo+dEHS3NhPh3j2zfLhcTTABWGs9XbfXnhqLCllu6
         rtOf41LB1/EMwcqBpLqB+TmaueZP8AW4lCMKRS0eZAkMJRktBi/gGg/KD+5UiEiz7t96
         tFJw/Ca7+8ceVtWoUISiFOxVcbt0wSMWTXbGddppSNhYNaYvJSpEjoq2aveDEE/qMS8W
         2mVT4UNP7H3SehaeBH5ZBVBZ6GPX/uJG5zS4RsZEEq1BZW9YjtgcrrjZRmVcEbPXUQVu
         GVnu/T52VW/KOnBONdEvSBiN8vfq1J415mpZikotAdbxkw7vfrkBY59RNaLZUpDcH0wF
         FCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wyrcd+RoTX9s4P6vwIurGowvZSCtgplS2sMf4RZFhj0=;
        b=Z0N7rrTKj7B/Ji5Y/WMP2zuJgp06T5sz/CNtHwQZ7WNk2KUszMdJcN3jaltf4O9iXM
         +CtS4koQdsEUqfaCLWcs9qdhtvblBTc3PLwrDiqsQuxGHdS4ICHXWDqmYxnftqr/Txb2
         7jC4VX0Ts0zXChx/1+rfCZzqnez+qezDhACLv3gRRTu/tPrnuZdt0FYSM+BRVQCN0IWE
         JVFDXct6fUEWbJ6HZoRTYrJfurFZIybgh00x+tq7NIKnKdBO8qStR0wsFUIh1mgJ4PcO
         XpG/vytrxKNmWuoAp/W4xWaY+tZLACpV3GsJ5oQsHhzetqtYzhXqmf8CPIWYB4GYh2bL
         RVaQ==
X-Gm-Message-State: AOAM532y5rwSgHps8UuxvFJVEY13UQnv6K0U7zadd3DQQQIMtk/znLb8
        sj0yTUt91mZlBbE1w1zPRYwOLeOylJ7UIA==
X-Google-Smtp-Source: ABdhPJwBhNSoD9Eq499ymEjviXEsGrYUi1ieLjWb0vhnLA5t4yJjapxggy4FL55DYlTOCBA9Jik7jA==
X-Received: by 2002:a05:620a:1307:: with SMTP id o7mr10164940qkj.437.1629486726081;
        Fri, 20 Aug 2021 12:12:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e5sm2096809qts.0.2021.08.20.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/9] btrfs-progs: add helper for writing empty tree nodes
Date:   Fri, 20 Aug 2021 15:11:53 -0400
Message-Id: <6692ad0e7a65488ba64f42dce542982d4b7e2047.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With extent tree v2 we're going to be writing some more empty trees for
the initial mkfs step, so take this common code and make it a helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 29fc8f12..9263965e 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -39,6 +39,25 @@ static u64 reference_root_table[] = {
 	[MKFS_CSUM_TREE]	=	BTRFS_CSUM_TREE_OBJECTID,
 };
 
+static int btrfs_write_empty_tree(int fd, struct btrfs_mkfs_config *cfg,
+				  struct extent_buffer *buf, u64 objectid,
+				  u64 block)
+{
+	int ret;
+
+	memset(buf->data + sizeof(struct btrfs_header), 0,
+		cfg->nodesize - sizeof(struct btrfs_header));
+	btrfs_set_header_bytenr(buf, block);
+	btrfs_set_header_owner(buf, objectid);
+	btrfs_set_header_nritems(buf, 0);
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
+			     cfg->csum_type);
+	ret = pwrite(fd, buf->data, cfg->nodesize, block);
+	if (ret != cfg->nodesize)
+		return ret < 0 ? -errno : -EIO;
+	return 0;
+}
+
 static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 				  struct extent_buffer *buf,
 				  const enum btrfs_mkfs_block *blocks,
@@ -460,31 +479,15 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	}
 
 	/* create the FS root */
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FS_TREE]);
-	btrfs_set_header_owner(buf, BTRFS_FS_TREE_OBJECTID);
-	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
-			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_FS_TREE]);
-	if (ret != cfg->nodesize) {
-		ret = (ret < 0 ? -errno : -EIO);
+	ret = btrfs_write_empty_tree(fd, cfg, buf, BTRFS_FS_TREE_OBJECTID,
+				     cfg->blocks[MKFS_FS_TREE]);
+	if (ret)
 		goto out;
-	}
 	/* finally create the csum root */
-	memset(buf->data + sizeof(struct btrfs_header), 0,
-		cfg->nodesize - sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CSUM_TREE]);
-	btrfs_set_header_owner(buf, BTRFS_CSUM_TREE_OBJECTID);
-	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
-			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CSUM_TREE]);
-	if (ret != cfg->nodesize) {
-		ret = (ret < 0 ? -errno : -EIO);
+	ret = btrfs_write_empty_tree(fd, cfg, buf, BTRFS_CSUM_TREE_OBJECTID,
+				     cfg->blocks[MKFS_CSUM_TREE]);
+	if (ret)
 		goto out;
-	}
 
 	/* and write out the super block */
 	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
-- 
2.26.3

