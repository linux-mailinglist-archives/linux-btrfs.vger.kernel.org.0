Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C0C792FD8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjIEUWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243372AbjIEUWI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 16:22:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB5712C
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 13:22:00 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76ef6d98d7eso146862985a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1693945319; x=1694550119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4Lg3uk8pJwHv6OajIfeyZNGvy+zggrEHV/Gxzfguro=;
        b=WXBLE0/LGLtHdwJWxBT6OPD8Qwu264ylwRNfiND5U1hccHjse3C7OgnjBeWDh9I+66
         MKUIgFKXwceQt8NiaoXJmSpOtw3/a+RYu6I2MlkOyFHvtP5zn5+8NmXLYwDOmgSG/66q
         Lg7Ul9cDQkoFZls0bAuE+Oh5ZqKD6E90LugqdaqZqlSNFl3+4FfjTJes1xbkyiviMLxE
         HM3cnzRQGZZyWpsHCW7Y7JjrdVsZbVlGhx/+9dsNlS+GfWV9skiGolqecR5HMkj9GnUy
         e3zu2COfnhs9YbHijFa4YGgg3Hd92gJycC/JfheoHXGoMq82ukNooRvrCujwN2/RZGeH
         niCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945319; x=1694550119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4Lg3uk8pJwHv6OajIfeyZNGvy+zggrEHV/Gxzfguro=;
        b=F6v6ze2qY3JyvhljrV5Rr6bemtVIC4v/I408j3QWT/BuCRy0ik50/wIF3tNyAomC3P
         JS8SeP98vx+YJbFcZ3JoJTThxApxsKpuOR+pZNzcQ2P++CIRM6hV0BKast06bWlh5TkZ
         Zd92Pqj9KYXyVxtJ4ZZu+jLFt0N9qDLFQQO/UjBVUTOPDIKWB4fxc081tA/J5e9DMl0B
         Qj82P0hUipdL9E5U26Im9wjxxXdFyEvWYYybWke/MO5P+JCeXgd6w281PT77Ve/vQHeI
         KoPTw+tiM16nT0ti26r5nWj478/pXWVMDgPtKZ9Spv4+7djlHo++wRbE5aBMQKR9HCEz
         BlcQ==
X-Gm-Message-State: AOJu0Yz3rTQbptfBIlk0Kguhe61mqvKS/Hkd2IOjQNCAHI8DiwOABfdm
        5hzouhLHTnLeLFGNwGvTIUNdHDqXwG3cFVwD0B8=
X-Google-Smtp-Source: AGHT+IHtJQxHuC+X/vKuvUTRvugVyGSUeEKes9CpprM6iPcBOMoCzhJm9UTaQzZk6NjeSeIEmbz6Ew==
X-Received: by 2002:a05:620a:4d0:b0:766:f9b8:55f3 with SMTP id 16-20020a05620a04d000b00766f9b855f3mr11863147qks.70.1693945319346;
        Tue, 05 Sep 2023 13:21:59 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m12-20020ae9e00c000000b007684220a08csm4349015qkk.70.2023.09.05.13.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:21:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs-progs: properly cleanup aborted transactions in check
Date:   Tue,  5 Sep 2023 16:21:52 -0400
Message-ID: <d24c0b846b150fa9e5638fc90258bf2728f88351.1693945163.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693945163.git.josef@toxicpanda.com>
References: <cover.1693945163.git.josef@toxicpanda.com>
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

There are several places that we call btrfs_abort_transaction() in a
failure case, but never call btrfs_commit_transaction().  This leaks the
trans handle and the associated extent buffers and such.  Fix all these
sites by making sure we call btrfs_commit_transaction() after we call
btrfs_abort_transaction() to make sure all the appropriate cleanup is
done.  This gets rid of the leaked extent buffer errors.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index c99092a2..1d5f570a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3114,6 +3114,7 @@ static int check_inode_recs(struct btrfs_root *root,
 			ret = btrfs_make_root_dir(trans, root, root_dirid);
 			if (ret < 0) {
 				btrfs_abort_transaction(trans, ret);
+				btrfs_commit_transaction(trans, root);
 				return ret;
 			}
 
@@ -8011,8 +8012,10 @@ static int repair_extent_item_generation(struct extent_record *rec)
 	rec->generation = new_gen;
 out:
 	btrfs_release_path(&path);
-	if (ret < 0)
+	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
+		btrfs_commit_transaction(trans, extent_root);
+	}
 	return ret;
 }
 
@@ -8223,8 +8226,11 @@ repair_abort:
 			}
 
 			ret = btrfs_fix_block_accounting(trans);
-			if (ret)
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				btrfs_commit_transaction(trans, root);
 				goto repair_abort;
+			}
 			ret = btrfs_commit_transaction(trans, root);
 			if (ret)
 				goto repair_abort;
-- 
2.41.0

