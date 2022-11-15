Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E3629EA5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbiKOQQk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiKOQQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:34 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490442B1B2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:31 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id x18so9794392qki.4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jk1TmuALmDFhVm6hxNz7p6eDjUvH/CZQhgm8flSOf/4=;
        b=hEFdVeK4zYfj+kpGNybYTXPGJ4a97zIq9HlPF+gVSTRf7d7nkLIESe/WQBZF1kQ2oZ
         7JXLhVMYbjm+HHQT5RPCHPFwLypsLRnk8ffOKGQv86lyP6chF0dI9Si9XKXNFlKBoDba
         BlVoV81wIOPnjdDMdmQItpFpEPYhlVTsoMpU6MWq8VMfPtrWNBXqekjyLS6j6PWiQbeL
         jMLcb4Gr2Otw51V/uazhnValpz9H9sy9B+UZpEYL2SrZtC9IqAq4H311H/m4HjDyE4th
         fP+sfvNA+Ra87+q5wTiaoJ/F4JUa4+eH8jW5egsNCqaNgOzKm+C/eAqI2bBXqHxP03Cg
         TngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jk1TmuALmDFhVm6hxNz7p6eDjUvH/CZQhgm8flSOf/4=;
        b=exM2XAWJOEffNhsErPIh+iigKI/cNw8JHVUAjxF/no4E/XZLBsQcaxaKbECcggB4n3
         U/pJmqW8XVnIl/WRMnWCdMvkb5LzbxwMj0J5t3CLpSf1q/Rxe0x7wN8WSVqFXc0A2yoN
         nRwhbeMe5CxjFHzQuBDhC8uWI8I9OlLBYbZQQW4y3JzeLckoe8j0MutEQX52y38xtkmv
         tfUuXyABSH0PExldg4HLacltOkpLKgmDhL7zNeKQvz6mOnmneiWieRDg2zy+jNO1WgJq
         lEdCxCLT1IJhBVVzMkZm3668jezVsJcCnbyfn5Y9sUMIwOKWOxjVgb3kk4ai80A0NUja
         6DpA==
X-Gm-Message-State: ANoB5pkuqWyJcSx6e1THV4iV8QAYTTrI6lA9yaGULqlzK4324srY7pg/
        OXKh2xDn6LSjv9uk2+QHh2p4PxIwMq5kMA==
X-Google-Smtp-Source: AA0mqf6tQ9YaCI1revxfoN5u0BZ5gu26BGGF8qKszRksB/M3RiD/r0xRqJhX67yTnqq4JDWrHV3M4A==
X-Received: by 2002:a37:e20e:0:b0:6fa:7e04:5f2c with SMTP id g14-20020a37e20e000000b006fa7e045f2cmr15607934qki.471.1668528990147;
        Tue, 15 Nov 2022 08:16:30 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id 206-20020a3707d7000000b006fa2dde9db8sm8200793qkh.95.2022.11.15.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/11] btrfs: move the csum helpers into ctree.h
Date:   Tue, 15 Nov 2022 11:16:14 -0500
Message-Id: <1f6574192208bd5d54bf5d42fa2b253c1134a020.1668526429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526429.git.josef@toxicpanda.com>
References: <cover.1668526429.git.josef@toxicpanda.com>
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

These got moved because of copy+paste, but this code exists in ctree.c,
so move the declarations back into ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h | 5 -----
 fs/btrfs/ctree.h     | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index f0d017f9407f..066a662f38c3 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -892,11 +892,6 @@ BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
 BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
 
-int btrfs_super_csum_size(const struct btrfs_super_block *s);
-const char *btrfs_super_csum_name(u16 csum_type);
-const char *btrfs_super_csum_driver(u16 csum_type);
-size_t __attribute_const__ btrfs_get_num_csums(void);
-
 /* struct btrfs_file_extent_item */
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
 			 type, 8);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c1e9da49ef9b..e7d5eba89e5c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -699,6 +699,11 @@ static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
 }
 
+int btrfs_super_csum_size(const struct btrfs_super_block *s);
+const char *btrfs_super_csum_name(u16 csum_type);
+const char *btrfs_super_csum_driver(u16 csum_type);
+size_t __attribute_const__ btrfs_get_num_csums(void);
+
 /*
  * We use page status Private2 to indicate there is an ordered extent with
  * unfinished IO.
-- 
2.26.3

