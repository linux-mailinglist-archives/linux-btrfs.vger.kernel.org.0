Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E5785AB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjHWOdr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbjHWOdq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36AEE67
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:44 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d743f58050bso4963254276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801224; x=1693406024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Otnudf0yJk+9JqRUuetbj+rdG8mdGfYos/arTvq87o0=;
        b=02Dr0YiCuLRQpcaAkpT6MKsnulK0IpVlPApE3YjPr850zzMFtPqGYT690xnruxocUF
         SZCfV+91xNMeGBrXYybWy+Kx623MqTlnwGEPjvMPYTlbxZ/jgwEW/F1kbANTTOmz7JEM
         EdC5aYUMrcIG/spH6NLhLa+EAip6BMzypvnXJ4TVxIqcwUo8Kfz1hEVCBkXGhS9NS/hv
         sXtBG6RxVnHGzF9iwA2RdnbbZVURVA/ppSHdjxKYNclC+fCZ8MyttdQH1C92ek2Zxo9v
         YLsTe7ctWNaTdpaMngfHQA6koPBLpP0Lg/TJ0xaFjsPI0PO7qMFJrgbyBgUVkuFkDoEu
         +FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801224; x=1693406024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Otnudf0yJk+9JqRUuetbj+rdG8mdGfYos/arTvq87o0=;
        b=D3SDZlfmE0l/ZztLBwRiGsy0skTrBcTL98XS9N4ny7dHEUfHL6bjKcuIBlweJdVVnF
         +oGI7skWGseWz1oBBHYzXj2hVH5iBpUHvzZmuiCU//NbgxLrIunzhvw4LfYzTw5fwKqL
         0HqyP8NZZJAw8MuBeiBh7KZe9n1eenI05DUOh22uZkDX97AWDqm0mRLvWbTPfvsqB6gb
         KDVrKWznt4JDkSYCSIai2sBu8YjiM7qj0JZiiDvZ6MBIo78+TXiMAj9c4BWPThYsEIvm
         uiGCW7/kXpUIfx2G2L/DPKqvS8SCsqp9iKeG1XW5mSjjF5z3lOyOsETrUv8N3WbLhhzs
         WMHw==
X-Gm-Message-State: AOJu0YyENFWNX5wNpYGYFycWEo4a6SYQd1qtQK9ceHTcO5ocebzD/wiU
        NI3IwA/GodcP+ksDSXJvp4Codu83I9+tY1JB54U=
X-Google-Smtp-Source: AGHT+IGG17XTvxVDnDNW2RnMu5NiTEVU0iQXzMaktnWndiez69akhpPU2F64vLn8ACSubpjzkoJ2Ww==
X-Received: by 2002:a25:cb92:0:b0:d4c:f456:d55b with SMTP id b140-20020a25cb92000000b00d4cf456d55bmr13903369ybg.31.1692801224087;
        Wed, 23 Aug 2023 07:33:44 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 64-20020a251443000000b00d74c9618c6fsm1463381ybu.1.2023.08.23.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 30/38] btrfs-progs: update btrfs_insert_empty_item to match the kernel
Date:   Wed, 23 Aug 2023 10:32:56 -0400
Message-ID: <7e405edf2190e6d6cb4af35ca19d734a0fe79123.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the kernel the key for btrfs_insert_empty_item is a const, update the
helper to match the in-kernel version.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d2b1b421..ce2122d7 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1031,7 +1031,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 static inline int btrfs_insert_empty_item(struct btrfs_trans_handle *trans,
 					  struct btrfs_root *root,
 					  struct btrfs_path *path,
-					  struct btrfs_key *key,
+					  const struct btrfs_key *key,
 					  u32 data_size)
 {
 	struct btrfs_item_batch batch;
-- 
2.41.0

