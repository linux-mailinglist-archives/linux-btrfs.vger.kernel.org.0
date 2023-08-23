Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20077859CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjHWNv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjHWNv5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:57 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8FCDF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:51 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d678b44d1f3so7609519276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798711; x=1693403511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMcUOKqHe+PHMcuwbh3TXRzBI0wToWNfG4w5HBgGNA8=;
        b=dCOtaFh5Fz2u+rr8A7gsPSQc5mI1wFkniQb21t2qWgg1ekmxRI1cdJN3RgjM0LoYxa
         2Wjcnt8szxkuOTf+7252IGqlhtGx9982WJPlaVPST9weQhzmOBqNdp5pHb2iz28WIdiG
         m8TYvELorB1p453FyJEhgjrJNVyjyoEBSpctUhZlMmwLgHDdCoQg1d8SYN18uwl4gvv5
         6zgn3ashz1zskOm02nKn11rQxSIXIvqz45NZBLpatBWzVrYIhQzCt/LMWwlHgqvBB6iv
         B7xZO0LuNEC6n/IjetsJgSOV4J2fnBLJX4AJPVjAxsU68Ta+wlplcl9Y4kRWg3faKGun
         UX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798711; x=1693403511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMcUOKqHe+PHMcuwbh3TXRzBI0wToWNfG4w5HBgGNA8=;
        b=IB+GiNyLckMYyfE7DeZSNKq4Vwl4wulVqVbJ1FjBg//oyS2k43zX9Q2QqPTQAvXIQ9
         0AJ11nZShCXSAHKl8QREhJWyznRQ988CxGZrdc2C3C10B95Sqbdi7YD8fAY+vKkX1IA6
         RiDfJyvgxn14x7EgddyA+Ee3Dnby+5x6X+l5li7Gg5Nb0tiZecQNBxQe4ODMXPAhOexQ
         liI3AjyMhY2+mS6mC906ggRCduS33/FnJVlUf1Vh65btr/GX9/5tezv1WOur6+4M3Ig+
         QSCFbc6hX44mbNBxI1/mICK1eYL5p/IlQqxpAoMaIeR8IbPnYS0iu5GJ7S9VgxnyJ1ez
         DuJA==
X-Gm-Message-State: AOJu0YyzXNHq2+j9wFOIjAVPhoQLf73BCMJlCTsOxs257OtU/nRA1Yga
        jtSxY3r6H9iijBndVrhJLQAYiZnSlhoVo2n83d4=
X-Google-Smtp-Source: AGHT+IGaJgDlkKBs4mJ+Vl4xf1tgAI/+v7e5AaDvAK5/XDXn9rgGTcMcGBWgF0QcOYVPp+btoiLhwA==
X-Received: by 2002:a25:f81b:0:b0:d4b:f497:c869 with SMTP id u27-20020a25f81b000000b00d4bf497c869mr11175150ybd.8.1692798711017;
        Wed, 23 Aug 2023 06:51:51 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v22-20020a814816000000b005922c29c025sm1348879ywa.108.2023.08.23.06.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/11] btrfs: include asm/unaligned.h in accessors.h
Date:   Wed, 23 Aug 2023 09:51:31 -0400
Message-ID: <d579bc35b31a0be928af6c358057c8aaa814ea79.1692798556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692798556.git.josef@toxicpanda.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
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

We use the unaligned helpers directly in accessors.h, add the include
here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 8cfc8214109c..f958eccff477 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -4,6 +4,7 @@
 #define BTRFS_ACCESSORS_H
 
 #include <linux/stddef.h>
+#include <asm/unaligned.h>
 
 struct btrfs_map_token {
 	struct extent_buffer *eb;
-- 
2.41.0

