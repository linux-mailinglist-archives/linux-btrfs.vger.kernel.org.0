Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B52436AFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhJUTBG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 15:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhJUTBE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 15:01:04 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0453C0613B9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:47 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id v2so1025445qve.11
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OYmuUAN+yLxBiyM75wc50xb7wvoH/zDo+Z53bXJXd8s=;
        b=K8x+xFtJLT5Bije4NbhZgI+0qh4xAFH9YcCkq4EgIDn68oPL3Us1/DwVitzmxPZbPU
         esc+efWzfyZtFD0fQjWfpRpVwdXzAyCHeIFOe5iOosjHxLjOBbpQe3cuM2ycFIGe8/Ww
         3hFRGLmidXTksdXDNFBOSfE2l4+eoBFft9YDfANe3lfXgbJ9qhX5yi4nG4hSiv2X3695
         QvYRJPRpxtXNtRI39QlfARc4E1np1ZsFk0IghBacAkUoVmsmvuVhMcyGAtdOG5zIXt6j
         uFxe3xoCAsdA1gwOsuRUxilDp/yHMgEAcxixekJpOP7EJ7WoNkiJjMwfUy0UKa1rKa2S
         rN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYmuUAN+yLxBiyM75wc50xb7wvoH/zDo+Z53bXJXd8s=;
        b=1WkiaFAP1SR6mLuT/kQK+idY2p7U/RlESstXLyLNm1bQguRi1/xRT7Mmmv3eEQZHug
         xK7C290bSRDJcEpcDqrRgpbpF6WAI7ucpSCsQkl9XbYUGOVre0Luhi10sMZYtUT16q9c
         sHAtvChgVQuVWg8PW9+XVVJR107B/AcdRO2QUPpUh6NNmxtsgmIn6lPruSpyImyTgKoT
         DicrwWL1qEghTkGtNVJ4OwF7+topGf0Ntix+364OpBWporbyJcOurLRNFHCkFmRUxpA3
         weK4GfTm0wZF0DvLLtrp1af+Zd0VuEC1Z0hSPfKnh/ZwYAqZMi+NQRZ+ApdOKuB3Vfd+
         qQOQ==
X-Gm-Message-State: AOAM5333NIhvY8WqVd15G9CbLVKcVWOggfKLn0XLw5SF0boHkVs5w/6A
        lXyLkJTCAPclYCeKGOAccA093DulGScnwQ==
X-Google-Smtp-Source: ABdhPJyUrENuQ5IvfFrciOrFe17u9OB5X1w3sC9uNJldB8ENwzxlqLa1Yob50kKEC8z/F72aeJbU2w==
X-Received: by 2002:a05:6214:16d0:: with SMTP id d16mr6663001qvz.28.1634842726895;
        Thu, 21 Oct 2021 11:58:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o14sm3362057qtv.91.2021.10.21.11.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:58:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/7] btrfs: remove the btrfs_item_end() helper
Date:   Thu, 21 Oct 2021 14:58:36 -0400
Message-Id: <f5e73b6e361933496b7bd331eeb4c22b0ec65b96.1634842475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1634842475.git.josef@toxicpanda.com>
References: <cover.1634842475.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're only using btrfs_item_end() from btrfs_item_end_nr(), so this can
be collapsed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dee251a92ae4..8c75224df83b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1969,17 +1969,6 @@ static inline struct btrfs_item *btrfs_item_nr(int nr)
 	return (struct btrfs_item *)btrfs_item_nr_offset(nr);
 }
 
-static inline u32 btrfs_item_end(const struct extent_buffer *eb,
-				 struct btrfs_item *item)
-{
-	return btrfs_raw_item_offset(eb, item) + btrfs_raw_item_size(eb, item);
-}
-
-static inline u32 btrfs_item_end_nr(const struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_end(eb, btrfs_item_nr(nr));
-}
-
 #define BTRFS_ITEM_SETGET_FUNCS(member)						\
 static inline u32 btrfs_item_##member(const struct extent_buffer *eb,		\
 				      int slot)					\
@@ -2007,6 +1996,11 @@ static inline void btrfs_set_token_item_##member(struct btrfs_map_token *token,
 BTRFS_ITEM_SETGET_FUNCS(offset)
 BTRFS_ITEM_SETGET_FUNCS(size);
 
+static inline u32 btrfs_item_end_nr(const struct extent_buffer *eb, int nr)
+{
+	return btrfs_item_offset(eb, nr) + btrfs_item_size(eb, nr);
+}
+
 static inline void btrfs_item_key(const struct extent_buffer *eb,
 			   struct btrfs_disk_key *disk_key, int nr)
 {
-- 
2.26.3

