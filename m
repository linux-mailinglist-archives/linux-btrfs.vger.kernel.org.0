Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B54D0B2A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbiCGWen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343786AbiCGWek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:40 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B9046B12
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:45 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id v189so4339495qkd.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O0Q3+UCBnpNMfXFsbHsY5I8VHg1IvXg65VHpCcQ/n4I=;
        b=oSBCEkQWhgz4UALupjVuZlCl0kS3NzBtNTH6Oljmout9y0Tpyqdu0ThrjBK1q9bIRN
         wZ+WWSH2QTVOraPWSnq+zVkt3KLjo/Fxg2ARomAFpeTLsUh4jI93toc+yLj0jDbTe1jJ
         eJ7pfQ4OK7yjmssmJW8CSQmy9vnDGtSbGSoPVTWFUFAwVTwuaLjJaSaEz0Yh94HoIeBg
         f0SLGw6dWogXli+pGxSwDIFIfRywfTlXrHb3iNckSOsQGk8V+UE6eNs+OPOFLwAL/YTu
         hMwFp713P7zL5g3cGOrhHqH9Qof77/KGep7b1eRkQwrcju5h0m614xJIlQJSMkQvVajt
         zYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0Q3+UCBnpNMfXFsbHsY5I8VHg1IvXg65VHpCcQ/n4I=;
        b=yMWWxXg1+0hHyQS5IzphjsyJgEwOXIsdYw9P3oODMuRTdBOeibNXybjW1cOQc4h0rh
         69+rOHTgQ3NXxoDBs/NoUWMslkOfvlAFJgVxSV1gOv91Am65L0nhkcJ6MW9gDb7ry8gd
         qmNQH9Ogkt4AryNUp58RK74mHH5O8nbecpLA124qRzzf4hGwCoPSewwMYS+bwYD71YJx
         9/yYfTAbzYKIWuLgywOHqcrHAXcQLz/H0f2upqCR7/SVTKOGcW85EXywTvedJhF+kXGv
         55f31Q7VfiaZU80y9WdFc7+Ky/6rrOK8JLNYkscfYlhg+pHUJDR9BnjAIDstSvgucvR2
         EZdA==
X-Gm-Message-State: AOAM533d/rARzMVDLSxohpyMLvEjftarFXii9NbyQ2heZxuUGRP5aFZE
        W8kyMCO/SlNzGohctxToBWpfqcRWVjoCKBWv
X-Google-Smtp-Source: ABdhPJxAGrvKbSG7SnKN5b8SNV/dqvHlgEMsu7JBrSRdf/ovDwF4/kSeZcVdrPomfaKkmSXR8WCyJw==
X-Received: by 2002:a37:5ac5:0:b0:662:e588:2687 with SMTP id o188-20020a375ac5000000b00662e5882687mr8452183qkb.228.1646692423878;
        Mon, 07 Mar 2022 14:33:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j20-20020a37a014000000b0067b3a0c7d89sm1177860qke.38.2022.03.07.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/12] btrfs: move the header SETGET funcs
Date:   Mon,  7 Mar 2022 17:33:27 -0500
Message-Id: <a9ed943e9217f36073b2aeefcdedd444b61ab281.1646692306.git.josef@toxicpanda.com>
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

These need to be above the item/key_ptr functions so we can read the
header flags to determine which version of the header we have.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 103 +++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7261c5c8f672..57b68115fa1e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1718,6 +1718,57 @@ static inline void btrfs_set_##name(type *s, u##bits val)		\
 	put_unaligned_le##bits(val, &s->member);			\
 }
 
+/* struct btrfs_header */
+BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
+			  generation, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
+BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
+BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
+BTRFS_SETGET_HEADER_FUNCS(header_snapshot_id, struct btrfs_header_v2,
+			  snapshot_id, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
+			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header,
+			 nritems, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_header_snapshot_id, struct btrfs_header_v2,
+			 snapshot_id, 64);
+
+static inline int btrfs_header_flag(const struct extent_buffer *eb, u64 flag)
+{
+	return (btrfs_header_flags(eb) & flag) == flag;
+}
+
+static inline void btrfs_set_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	u64 flags = btrfs_header_flags(eb);
+	btrfs_set_header_flags(eb, flags | flag);
+}
+
+static inline void btrfs_clear_header_flag(struct extent_buffer *eb, u64 flag)
+{
+	u64 flags = btrfs_header_flags(eb);
+	btrfs_set_header_flags(eb, flags & ~flag);
+}
+
+static inline int btrfs_header_backref_rev(const struct extent_buffer *eb)
+{
+	u64 flags = btrfs_header_flags(eb);
+	return flags >> BTRFS_BACKREF_REV_SHIFT;
+}
+
+static inline void btrfs_set_header_backref_rev(struct extent_buffer *eb,
+						int rev)
+{
+	u64 flags = btrfs_header_flags(eb);
+	flags &= ~BTRFS_BACKREF_REV_MASK;
+	flags |= (u64)rev << BTRFS_BACKREF_REV_SHIFT;
+	btrfs_set_header_flags(eb, flags);
+}
+
 static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
 					   struct btrfs_dev_item *s)
 {
@@ -1736,7 +1787,6 @@ static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
 }
 
-
 BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
 BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
 BTRFS_SETGET_FUNCS(device_io_align, struct btrfs_dev_item, io_align, 32);
@@ -2242,57 +2292,6 @@ static inline void btrfs_dir_item_key_to_cpu(const struct extent_buffer *eb,
 
 #endif
 
-/* struct btrfs_header */
-BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,
-			  generation, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_owner, struct btrfs_header, owner, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_nritems, struct btrfs_header, nritems, 32);
-BTRFS_SETGET_HEADER_FUNCS(header_flags, struct btrfs_header, flags, 64);
-BTRFS_SETGET_HEADER_FUNCS(header_level, struct btrfs_header, level, 8);
-BTRFS_SETGET_HEADER_FUNCS(header_snapshot_id, struct btrfs_header_v2,
-			  snapshot_id, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_generation, struct btrfs_header,
-			 generation, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_owner, struct btrfs_header, owner, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_nritems, struct btrfs_header,
-			 nritems, 32);
-BTRFS_SETGET_STACK_FUNCS(stack_header_bytenr, struct btrfs_header, bytenr, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_header_snapshot_id, struct btrfs_header_v2,
-			 snapshot_id, 64);
-
-static inline int btrfs_header_flag(const struct extent_buffer *eb, u64 flag)
-{
-	return (btrfs_header_flags(eb) & flag) == flag;
-}
-
-static inline void btrfs_set_header_flag(struct extent_buffer *eb, u64 flag)
-{
-	u64 flags = btrfs_header_flags(eb);
-	btrfs_set_header_flags(eb, flags | flag);
-}
-
-static inline void btrfs_clear_header_flag(struct extent_buffer *eb, u64 flag)
-{
-	u64 flags = btrfs_header_flags(eb);
-	btrfs_set_header_flags(eb, flags & ~flag);
-}
-
-static inline int btrfs_header_backref_rev(const struct extent_buffer *eb)
-{
-	u64 flags = btrfs_header_flags(eb);
-	return flags >> BTRFS_BACKREF_REV_SHIFT;
-}
-
-static inline void btrfs_set_header_backref_rev(struct extent_buffer *eb,
-						int rev)
-{
-	u64 flags = btrfs_header_flags(eb);
-	flags &= ~BTRFS_BACKREF_REV_MASK;
-	flags |= (u64)rev << BTRFS_BACKREF_REV_SHIFT;
-	btrfs_set_header_flags(eb, flags);
-}
-
 static inline int btrfs_is_leaf(const struct extent_buffer *eb)
 {
 	return btrfs_header_level(eb) == 0;
-- 
2.26.3

