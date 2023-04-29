Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17D6F265B
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjD2UUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjD2UUT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:19 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92032691
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54fe08015c1so18007657b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799613; x=1685391613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0Km+kdo4/+kYbh2Lff56rojPceL5zhqMqbab36ZINQ=;
        b=ymtbujn37gxudYBa96WJ1afmSS7JJOrLIts11NwT7zbIVj5SIQinR3naELFWGocPRK
         xRFXZ5/Wbj9gX9VqRR1jbKOURWqjswX5g9cArFdgY7dW3B45h8WPwCdZn5lEzgcfDcnH
         DlWjZQvvRY7DlFalTPLe7QHwcIi8iOMFnSP6TucJQWLyOzDPpdt8hOCxaJBscyOx72Kc
         qQM2A4uL6bwpWLLAQ4BbQCsP+Kc+dfUwgd82JjIMmVEjETOj0+GNsFR0HlRa5O3kZ968
         0S79KCTbCQ7qwRucz+KBNVSyxIZWLfg+Sspx2PgYA/rmC2hLuSSjm9T0Onkf8vT+z/tp
         lU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799613; x=1685391613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0Km+kdo4/+kYbh2Lff56rojPceL5zhqMqbab36ZINQ=;
        b=M9VinxlCcnII4NYxLjepRfXrUAS22twvcgJjB38Vbtqbz8tG7jrDDra7St5ECJxxWC
         1jBehaauWtOwji9fcE0oisj0byBh5OqqIt0iPjiaJmOlYEAXeCU5AOV1LfOJj6G2j3kj
         eqGmpxr2oLA+CCbJQD7Et9KNa0XPbGzzekeaTrvm1gCf05pzfGv6WTtIhKn+8yl8DigZ
         aDqnXlfU2hj6f4oC2JTWlmhhU6Eze6DeXAYBq/EbyzpA7scJMDsdqy0XRn2gewQv+2AS
         eWx8xT6VDhoyEtuqoyD1r5xPN/wE6Z4YxmNY4xdOZn9M+G0PcajDY62YM3mTnRausoee
         7U9g==
X-Gm-Message-State: AC+VfDwr8yUrYCIHIwHBYiLEs5xnqrbd0xqxkzTW294YZLPKpMdwuZZr
        AQ8xx7zwG4GGNzCbkIHhjbmGIdin0TnnXgYEGU2h9g==
X-Google-Smtp-Source: ACHHUZ4Ju5FOhI7Fte9UG+osTCl32EHIG3vxWwTKBPAqYfQiB4whlREg4D2VzMMDwgMZmGvRVx0QuA==
X-Received: by 2002:a81:9e0e:0:b0:559:f7d4:661b with SMTP id m14-20020a819e0e000000b00559f7d4661bmr1717186ywj.14.1682799612574;
        Sat, 29 Apr 2023 13:20:12 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r127-20020a0dcf85000000b0054f0baa196asm6231104ywd.107.2023.04.29.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/26] btrfs-progs: update btrfs_bin_search to match the kernel definition
Date:   Sat, 29 Apr 2023 16:19:38 -0400
Message-Id: <1fa6d5af71efdf44f11efe5f0d1631e46f9e3d41.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

This was updated to include a first_slot argument, update it to match
the kernel definition to make it easier to sync ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          | 2 +-
 kernel-shared/ctree.c | 6 +++---
 kernel-shared/ctree.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/check/main.c b/check/main.c
index d9c54deb..a6485db5 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6524,7 +6524,7 @@ static int run_next_block(struct btrfs_root *root,
 		 * technically unreferenced and don't need to be worried about.
 		 */
 		if (ri != NULL && ri->drop_level && level > ri->drop_level) {
-			ret = btrfs_bin_search(buf, &ri->drop_key, &i);
+			ret = btrfs_bin_search(buf, 0, &ri->drop_key, &i);
 			if (ret && i > 0)
 				i--;
 		}
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index cbf735de..2e7b6c9a 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -664,8 +664,8 @@ static int generic_bin_search(struct extent_buffer *eb, unsigned long p,
  * simple bin_search frontend that does the right thing for
  * leaves vs nodes
  */
-int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int *slot)
+int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
+		     const struct btrfs_key *key, int *slot)
 {
 	if (btrfs_header_level(eb) == 0)
 		return generic_bin_search(eb,
@@ -1196,7 +1196,7 @@ again:
 		ret = check_block(fs_info, p, level);
 		if (ret)
 			return -1;
-		ret = btrfs_bin_search(b, key, &slot);
+		ret = btrfs_bin_search(b, 0, key, &slot);
 		if (level != 0) {
 			if (ret && slot > 0)
 				slot -= 1;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index edf74fcc..d5797d09 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -982,8 +982,8 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
                                const struct btrfs_key *key,
                                struct btrfs_path *p, int find_higher,
                                int return_any);
-int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int *slot);
+int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
+		     const struct btrfs_key *key, int *slot);
 int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
 		u64 iobjectid, u64 ioff, u8 key_type,
 		struct btrfs_key *found_key);
-- 
2.40.0

