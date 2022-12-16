Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C2D64F23C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 21:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiLPUQN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 15:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiLPUQJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 15:16:09 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977BB59179
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:07 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id f189so3339842vsc.11
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83z1jbNn1BgygXOpq0wKfWJrITE303JrObzgqLZM5IM=;
        b=4imRgUBQ6aGWu793jb7cr3YdNhL6pKvuNmxSmAEB1dyCjADBT2teiVWaBCHnnut1BI
         UmV0iRuF1C+dNI0Bkhyy2HSaEvUi8r1ERpZ0jNRwt8JaIF8JGIqTOJtMtWx6GDu38ag6
         xA6dx6UzKClXNIpVt+zD5lpKFCCP2cHZqFmIIA88tak7xSuiyvtEeluuggEB/m1ioVrm
         248YIlNwDOZ5LmqGiw1dDFjlro1qYuGhBXaWylF41RsQHKzCrdVpxTTHsT2yAbHb7ym5
         6BC0Qr2N3LhfDEY9LRnUKzsomdE37EGzvKHNGLMf9LD03QaFKD/XWDKWb33RxcHTz7v4
         IHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83z1jbNn1BgygXOpq0wKfWJrITE303JrObzgqLZM5IM=;
        b=utHmjInoCpUAlMi2kXmV/0QCGe+3NTvGfOboRMNlmhKyT7NhCU49acl4nEo9/SU3NA
         E20gjpK4+tRYEWJDmvOLwFZWDOjLtlWt4p+urMouBroCzd71vZn4rWotwEjyZ9GSTbzg
         ME8GffW0eXF4/8l6JqZo0ZGmCbL77hhbBuTqabLME+almaQcRrhjUBio+RJ3in4w5IsN
         UssNLGmoiv7un8ToqKETRjVEeBYp9yk0Bw+q/5UoeYj57qPrzxQofNdTxbw5pXI6fNoT
         QwS/WpfVaJ4mKvyVRg3QjTwlg/6JW6jTf0j1theneW5YyyVLCq7Dd3FCuvmM8yuJwes9
         Sz0w==
X-Gm-Message-State: ANoB5pk2OdHbjp1Nm58pHDRHUqqXMkzFGm6cULW/iKJvOSBUiirrhB4S
        4NQJhPzDWI9LIYGHHXNjqRWhJXnNQLrrJQ9nYOY=
X-Google-Smtp-Source: AA0mqf5AIUUb3TVI2V6BwRHmVuThiKszWFG62XkbKWruWumtGOhwjf7BgfHuy2TJiRGpkpisqXsc0g==
X-Received: by 2002:a67:f04a:0:b0:3b3:7657:43a1 with SMTP id q10-20020a67f04a000000b003b3765743a1mr13728205vsm.19.1671221766371;
        Fri, 16 Dec 2022 12:16:06 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id do25-20020a05620a2b1900b006ff8c632259sm2139202qkb.42.2022.12.16.12.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:16:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: fix uninit warning in btrfs_update_block_group
Date:   Fri, 16 Dec 2022 15:15:54 -0500
Message-Id: <87302b559838af285024d47b3b738ef36ad0ebe4.1671221596.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1671221596.git.josef@toxicpanda.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

reclaim isn't set in the alloc case, however we only care about reclaim
in the !alloc case.  This isn't an actual problem, however
-Wmaybe-uninitialized will complain, so initialize reclaim to quiet the
compiler.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 708d843daa72..e90800388a41 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3330,7 +3330,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	spin_unlock(&info->delalloc_root_lock);
 
 	while (total) {
-		bool reclaim;
+		bool reclaim = false;
 
 		cache = btrfs_lookup_block_group(info, bytenr);
 		if (!cache) {
-- 
2.26.3

