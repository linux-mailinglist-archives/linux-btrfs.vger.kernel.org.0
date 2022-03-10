Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F884D3EC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbiCJBdB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbiCJBdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131861275C9
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lj8-20020a17090b344800b001bfaa46bca3so3789731pjb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlU8PiGNC+3HWzzFMwOvGZ0FAEg0RRT/82Dht4cx72k=;
        b=u9tV+g8sSJqgKzATm1x+JXTP004BFVYHecS8TxmS1kwcSNL7yhKAjt+zJPGx6nNeEx
         Qd2i30AQO1kImW7xW9XC63DhFrIl+1Po2OxtXhzwXB0oOWJq0dOeS2U5Z8kca3Cz4B/9
         yrg06V4gxgDXxpHtcm0gTtaXzliTpMUKoKrTXn3FGsU+8C0+kNJzgGNmZ49k6kswys8Z
         hKFHpLG0zteIMP45B+Xxp38ugLLLABPfscKXVYbfRun20ydsylCDJmWJ7kgP1pnHUSAa
         DqrHblj9F1qAZqmLIXwyCmFv399C31LouLd1NfKW/1ESf30DD9ql2HgSttsp7EzU67ia
         euxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlU8PiGNC+3HWzzFMwOvGZ0FAEg0RRT/82Dht4cx72k=;
        b=KlzLYFACPbk0kNegsDVwtv7AwyaeGoFEb+2bN6m9ZUbvO900lJwjXAyWDj64b20gOf
         Kw6P7AYpPaYTYZ5xRrlmCOVmJ4UwFwP3hilu8w8ymx+Q/Owp8nnJm12tbUwQdB9EH7L9
         jL1Vv6XKVAwtm69jbz8l9wkcVHEZO6kLxTkLMSwsPRrD7dZPBEQcIfNQ5zStA06I/0Kt
         6xyitb4RXBrFiRZtBWs60HZmAemfd1dOfJlJvlF3cvdgmVVKCGJXAvnzw7giWidMWz7F
         EVAye9uF12vKXjrHqrwY56LxL3vzRvNFhnBL+BpgEXJTHlY4b1SkMaYeXLF9Hpi+W4FD
         Kemw==
X-Gm-Message-State: AOAM531hzuHTGwWdj/7idlBRfrfxPnPtV189yNf5b+pbLcBnLvdeJXM4
        TwEFXL90kv6+94Azd0O6DfMreHT79huXqw==
X-Google-Smtp-Source: ABdhPJyK7VekUXq6m6DY+RJMesw+B093EsJFOlqZ2VVkTSr+YyOUq/N0O6wKXCgZhCeIJs58u7ausg==
X-Received: by 2002:a17:90a:694d:b0:1bf:37e3:7000 with SMTP id j13-20020a17090a694d00b001bf37e37000mr2381595pjm.242.1646875920188;
        Wed, 09 Mar 2022 17:32:00 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:31:59 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 06/16] btrfs: remove unnecessary inode_set_bytes(0) call
Date:   Wed,  9 Mar 2022 17:31:36 -0800
Message-Id: <eae339731afcf87fab58778b3b6d26e1bf3531bd.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
References: <cover.1646875648.git.osandov@fb.com>
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

From: Omar Sandoval <osandov@fb.com>

new_inode() always returns an inode with i_blocks and i_bytes set to 0
(via inode_init_always()). Remove the unnecessary call to
inode_set_bytes() in btrfs_new_inode().

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 244e8d6ed5e4..b7d54b0b2fb5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6207,7 +6207,6 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 		goto fail_unlock;
 
 	inode_init_owner(mnt_userns, inode, dir, mode);
-	inode_set_bytes(inode, 0);
 
 	inode->i_mtime = current_time(inode);
 	inode->i_atime = inode->i_mtime;
-- 
2.35.1

