Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DCD4D0AA7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiCGWMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343598AbiCGWMZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:25 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142538BF55
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:31 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id x3so13197159qvd.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6tkisjQSd9cBB2yqz+QjM1ROR4R+YVYAhRxb13q643U=;
        b=JQ2zz/ane6x05sl910zTv2gg6drpPMWHMXn4L0kgXLAavxDmUAzlOrPXUPQh1/Uh5i
         Wm3dglWsYCdbCy5mVn9VscGM8mCmEiz7KL7FGo30EJsqBS63ftJfaASfyOxdVNwF22tk
         3POKHJoXjRmWu2pGSgp34sejPiFtrwMiJ0+Eh1yd7+sAKG9vvkvX+8fq7nVG5j4ImJLp
         o5aRLaW5/rHmtuxUBM00nC5I/qhcedZkidfP5GgZK+DauPUYPZKoHVnYi5z8T9na2+tj
         /nP5HsAiW3mO01+97wvwu8P87tqtN6BE3idfB4BkkvzcMc1dgWkhomhcgA9932nV0Tnc
         +1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tkisjQSd9cBB2yqz+QjM1ROR4R+YVYAhRxb13q643U=;
        b=tYwCGC5v0xU09w5/xg8rejvuMy7IfsbZm0pVd5h0GtUkbRE7FG2vr/WWGqJbNdPVkb
         AcK1lf86M9iyziZUqUtyQo3j/z4SitiH37Eg0EEBS3B+mhBTTiKEJkqJ67bP1BgV3Ny4
         5LnApt4YQgj1ihU1U2j2EA6ycgOf9tLTleekRaYXdC1i4bEc6zL/5UWKwMGLIlIUKqB1
         jODm80E7wvBGhx/J2hvO4nHLEAJJN98WXKjWFXbIFJeWLWnWC5c70iYsYj6Vx4bFiqS1
         bNnw47zd0+rYujoH1ciiPIF027kqfiR9o7tX1/ffstO48OR6cvq/kx0CxEsHHZmpmTHQ
         vONA==
X-Gm-Message-State: AOAM531+NWiaWFqxOfEmxWqTOfH2hvunPsS0UCnSEbrc+Ce6Qk+bLR7b
        pqxoY8KqtzCx9mJLFEqfOQ126rWFyRepQPT/
X-Google-Smtp-Source: ABdhPJySMgHYz/HbWOwAMCb15aVaBPeeAUOO6y6Y7CidpnaTErcNe3/3DjW5zDZjuYOXKXATQLIQLA==
X-Received: by 2002:a05:6214:27ee:b0:435:9eac:e340 with SMTP id jt14-20020a05621427ee00b004359eace340mr3008472qvb.48.1646691089987;
        Mon, 07 Mar 2022 14:11:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b0067afe7dd3ffsm3480014qki.49.2022.03.07.14.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 17/19] btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
Date:   Mon,  7 Mar 2022 17:11:02 -0500
Message-Id: <f6ecbb317df0299cbf42a619d1b8c22514269e05.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Our initial block group will use global root id 0 with extent tree v2,
so adjust the helper to take the chunk_objectid as an argument, as we'll
set this to 0 for extent tree v2 and then
BTRFS_FIRST_CHUNK_TREE_OBJECTID for extent tree v1.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index eac8c46c..75680d03 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -191,7 +191,7 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 
 static void write_block_group_item(struct extent_buffer *buf, u32 nr,
 				   u64 objectid, u64 offset, u64 used,
-				   u32 itemoff)
+				   u64 chunk_objectid, u32 itemoff)
 {
 	struct btrfs_block_group_item *bg_item;
 	struct btrfs_disk_key disk_key;
@@ -206,8 +206,7 @@ static void write_block_group_item(struct extent_buffer *buf, u32 nr,
 	bg_item = btrfs_item_ptr(buf, nr, struct btrfs_block_group_item);
 	btrfs_set_block_group_used(buf, bg_item, used);
 	btrfs_set_block_group_flags(buf, bg_item, BTRFS_BLOCK_GROUP_SYSTEM);
-	btrfs_set_block_group_chunk_objectid(buf, bg_item,
-					     BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	btrfs_set_block_group_chunk_objectid(buf, bg_item, chunk_objectid);
 }
 
 static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
@@ -218,7 +217,7 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
 
 	memset(buf->data + sizeof(struct btrfs_header), 0,
 		cfg->nodesize - sizeof(struct btrfs_header));
-	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used,
+	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used, 0,
 			       cfg->leaf_data_size -
 			       sizeof(struct btrfs_block_group_item));
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
@@ -396,6 +395,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			write_block_group_item(buf, nritems,
 					       system_group_offset,
 					       system_group_size, total_used,
+					       BTRFS_FIRST_CHUNK_TREE_OBJECTID,
 					       itemoff);
 			add_block_group = false;
 			nritems++;
-- 
2.26.3

