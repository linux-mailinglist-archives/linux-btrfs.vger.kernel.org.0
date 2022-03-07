Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4478B4D0B28
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbiCGWej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343779AbiCGWei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:38 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BC46B12
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:43 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c4so14655775qtx.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lrknkNGY0uw2ceDk1TZuhdMhbQPxQRGHkBZ+muMoEJ0=;
        b=w32tcYCX1AgP//uqdPnXQAahFGKLP0l9i3X0OT6LUUyN1yjNYQ5eM3bGSBgyGyBl2h
         WFm2e4IogK8yC7xfjRD5sKd5QrV6VVBCaoujKhpDYQakebM0+Kf2TlPU0p1xGuCItDDZ
         UhYjg9HOixEym+hlK4ryiL8tOPA6Li6gQR6US1rZmhT3zqUrAVWzo7kHFocfX8V/RAv3
         gG8D5ubUDJ2agFlndhXEaN9nCSA7G56gT9uFHcxxBFMeRIWi3h1VeX0Ct8ZurrgqqaFO
         q3Hp34g7RP4MYU4PRaMKhtnRdoc3n9YG2xXrFlwkT8YdTnC2vCdWiC07QHC9QZnbPohM
         W/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lrknkNGY0uw2ceDk1TZuhdMhbQPxQRGHkBZ+muMoEJ0=;
        b=xD6Q/nOpz2C1AJ0nFWRBgctTisJ6Wamlg2kpieC2oRrUjZscr9e26opE0KYaSbF3JU
         sOVojcLcMaFoBd5bFk2aQyXiOq1na3wBTAi0+3OIiHDNQ+d8zrAWCEPwZbcMnMlxBYD+
         EyJcuB/PxnpJcAYmBv1NABNa1B2P9m3I1LCskocTzwTiCmM9ivuuIXSy9otufnpynT1o
         7/FnOM/ks5QThWmmvGnfZMVfKbI12HV8lzJBT50sZ7OD+H9E0LsZ9KVQNLJgHcZdAns7
         5z/SGFEHSj7U35Ti2iLriLnBfF74blBbJByXT5FKNmhpYZXzud2IO8ATaBwY4gh65i8W
         cu5g==
X-Gm-Message-State: AOAM532tbsB/mcIogI1jbDxTPp5k8FTWF1+oIkgTEWfJ1UJFaXSTBCaq
        3BCF82DZEl/mudMQUC9DBZQoDwZrF8qtqC2e
X-Google-Smtp-Source: ABdhPJxL6+4Q4Nb/w7VopJ0ve6u1kqJiID6AVwp2k8yi9hFQpPcyM42kr2LY8PLz6M71R+4rrKxnbg==
X-Received: by 2002:ac8:7c54:0:b0:2de:746c:bd99 with SMTP id o20-20020ac87c54000000b002de746cbd99mr11229119qtv.150.1646692422494;
        Mon, 07 Mar 2022 14:33:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h3-20020a05622a170300b002e008a93f8fsm9508609qtk.91.2022.03.07.14.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/12] btrfs: add snapshot_id to the btrfs_header and related defs
Date:   Mon,  7 Mar 2022 17:33:26 -0500
Message-Id: <bd2657da9c3dc802902b0aa3a5546f3c2166f9ce.1646692306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692306.git.josef@toxicpanda.com>
References: <cover.1646692306.git.josef@toxicpanda.com>
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

This adds the snapshot_id field to the btrfs_header, the HEADER_FLAG
that we're going to use to indicate that we have the larger header, as
well as the set/get helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h                | 19 +++++++++++++++++++
 include/uapi/linux/btrfs_tree.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0551bd500ce0..7261c5c8f672 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -179,6 +179,11 @@ struct btrfs_header {
 	u8 level;
 } __attribute__ ((__packed__));
 
+struct btrfs_header_v2 {
+	struct btrfs_header header_v1;
+	__le64 snapshot_id;
+} __attribute__ ((__packed__));
+
 /*
  * this is a very generous portion of the super block, giving us
  * room to translate 14 chunks with 3 stripes each.
@@ -373,6 +378,11 @@ struct btrfs_leaf {
 	struct btrfs_item items[];
 } __attribute__ ((__packed__));
 
+struct btrfs_leaf_v2 {
+	struct btrfs_header_v2 header;
+	struct btrfs_item items[];
+} __attribute__ ((__packed__));
+
 /*
  * all non-leaf blocks are nodes, they hold only keys and pointers to
  * other blocks
@@ -388,6 +398,11 @@ struct btrfs_node {
 	struct btrfs_key_ptr ptrs[];
 } __attribute__ ((__packed__));
 
+struct btrfs_node_v2 {
+	struct btrfs_header_v2 header;
+	struct btrfs_key_ptr ptrs[];
+} __attribute__ ((__packed__));
+
 /* Read ahead values for struct btrfs_path.reada */
 enum {
 	READA_NONE,
@@ -2235,12 +2250,16 @@ BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
 BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
 BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
 BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
+BTRFS_SETGET_HEADER_FUNCS(header_snapshot_id, struct btrfs_header_v2,
+			  snapshot_id, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
 			 generation, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header,
 			 nritems, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_snapshot_id, struct btrfs_header_v2,
+			 snapshot_id, 64);
 
 static inline int btrfs_header_flag(const struct extent_buffer *eb, u64 flag)
 {
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 4a363289c90e..92760ea4b448 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -496,6 +496,7 @@ struct btrfs_free_space_header {
 
 #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
 #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
+#define BTRFS_HEADER_FLAG_V2		(1ULL << 2)
 
 /* Super block flags */
 /* Errors detected */
-- 
2.26.3

