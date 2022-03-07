Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4084D0ABC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbiCGWOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243629AbiCGWOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:38 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44F856772
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:43 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id jr3so13210673qvb.11
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ucF0OT8tpfSiFZ1LRn7x/MKXXHlvt8iCNXZGWA47wtc=;
        b=NqnvwlJR05ivYBKKVNNhAfFmYwNSyXcu3X9J3+tKHr5zbFhf8jhDH3utWaL/7K9QK3
         W5lVz6mGHqBVE/q+UMiTIVmZFzBr5CIbC9fWY4I01wEaD1JlbD5wqDGc94/11HzDstOy
         2FKhym2TB9EVywINcJhhs1TBPXvFSrn9gq9en3dYaFm6/TBlOA6892k2XnTtIE3xA7hQ
         TxzKS465idZrHkD3bkYbYFbrhlO+9CXRWyDIiq0abSUzmLLTyj5bU98HlRyRw1OXpN7w
         7bpmVzl7C7YYXHHvuDBxTziZuav9zdeRFDvNZ+kF/cNByQQs8Zml7hHp5JvQqIviMyr4
         Lpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucF0OT8tpfSiFZ1LRn7x/MKXXHlvt8iCNXZGWA47wtc=;
        b=GCh2s2b7lzRFL+XlGQZIzAFZr+804vdrIX7d/XlaU/L4yWUvFiEQaky+GGmZLQogkl
         mSvz3ARcTHAUrmcHdpjYaKEWGdFZS5Ns7gozyfQpPl2WWWBo8ePrg+vfSkzpJCWWQRoe
         9dg7tKi4/zdpnMCoKBOneRyEfLWuY8Cg7D8gq5znaXsQlL9405gznskywtQxUN1VyBPo
         AixuHBYeyi6BFxCGmbtm0lXftmQ0OMIxHcyOb6eohUJEelQoSG3ILQq0zdMVFnF8geeh
         QRDf+Tb2BfmwVVi61a7qxZQyBW8DnZCT1HuVNOuW93DNRcgXc5dcySbs7akkY/J3cNTS
         sy7Q==
X-Gm-Message-State: AOAM530MUVNBwzRYu9IY585CWeg7oivtct7JJ9TlFZiXvaxXUY0G6Yn5
        9c726aaBmj1sBwYxxgN/1DDeqGFTh/cfwHMY
X-Google-Smtp-Source: ABdhPJwP+zEVEk3pE9+xe9t+CKfsbGm4qLRd6V9e7qnQxVErzcEtdiclNN00rzUdMMYSVGmCihjAog==
X-Received: by 2002:a05:6214:260a:b0:435:31b9:82d3 with SMTP id gu10-20020a056214260a00b0043531b982d3mr9892060qvb.99.1646691222598;
        Mon, 07 Mar 2022 14:13:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v26-20020a05622a189a00b002ddd1f76c2fsm9298869qtc.17.2022.03.07.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 14/15] btrfs-progs: mkfs: create the gc tree at mkfs time
Date:   Mon,  7 Mar 2022 17:13:19 -0500
Message-Id: <38d63203a3ce1b68336191609eaf600a37817f5a.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
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

Now that progs has the support to read this tree, create it at global
root creation time.  We don't need this root to bootstrap the file
system so just create it at this later point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index a603ec58..17b3efc1 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -839,7 +839,18 @@ static int create_global_roots(struct btrfs_trans_handle *trans,
 {
 	int ret, i;
 
-	for (i = 1; i < nr_global_roots; i++) {
+	for (i = 0; i < nr_global_roots; i++) {
+		ret = create_global_root(trans, BTRFS_GC_TREE_OBJECTID, i);
+		if (ret)
+			return ret;
+
+		/*
+		 * The rest of these are created initially so we want to skip
+		 * root id == 0 for them.
+		 */
+		if (i == 0)
+			continue;
+
 		ret = create_global_root(trans, BTRFS_EXTENT_TREE_OBJECTID, i);
 		if (ret)
 			return ret;
-- 
2.26.3

