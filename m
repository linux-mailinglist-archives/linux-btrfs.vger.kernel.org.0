Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E8D7859CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjHWNwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjHWNv6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:58 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFCDCEF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:55 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58df8cab1f2so59967347b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798714; x=1693403514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=359EXyjrgYnw0qy+pnTckUd50Ihk3THkdm2GNkP0MAk=;
        b=Lh9t+4oX7XobQVBr6rIMKJKIBcFPvPRyBg4YN3qVUSU6gAQkwl/jYCyxtWDPB3aVfZ
         9e75SZXxebIXjzL5Xaa89DNWmfJxByL1DVtcTW2VOXxp3o974Af/fZuM0v1XIsmg9gPG
         WcKAsPZwDHTriGxEwWxF9CP92ltWtHMjUhaCrtoRlkXk2Lex+MBTVA2R1uIZkt/2czX8
         9ImVFlnybOModT0znrCPat6kyTTa2iqTpEwPlVLq8g68nqN8WpVyuHx5E8u9MPINU/+W
         VMmGRLxr0eHtIMUsL9auDlGgx6F9YywiY3AbvmHqD7rwFZwTuEgvqHZaJF0kTzHTl+tl
         sg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798714; x=1693403514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=359EXyjrgYnw0qy+pnTckUd50Ihk3THkdm2GNkP0MAk=;
        b=Ugi8f44VKU5cZdyfX9wzYHZ1knv2Is/0mNu2kd4uvq8tZPH+z8baPyaLEi6m+x0E8T
         sAXExZenlW8zIaYKpRiJLZP+yyzIGitti1+yc8xBaLsdnrS2PXv4wrgVf0ldlPZYuR1o
         asAtntbah05A05M93bF5ZjHR+gDswGqul2zJgSqKGwHBYg4du3eS4w/wNr1PR+aGCjE6
         wLvM5a8Ed13dmIQhEoJ9ZM0fK8tbncOF3yuBl529XG5i6m/qi6bS9T3/GxyJ5t4BvFGa
         wsrxfevV/E48JRMa9f4q26CaL8oZMlCvx0FtuPLl7JVK5LToPvwB9ei5GLC3n/Hq7lv7
         KGAQ==
X-Gm-Message-State: AOJu0Yzo/IxtPDXTpQmEKgHLs9CeN+SRuanVqBI3yF+qZZjEctg7gwdn
        eHhkm78QkC/Nh3caqTR0ZRSi9lM3OrOrWUhSdeo=
X-Google-Smtp-Source: AGHT+IF4W2RVplZ2HIOC9OqkdNcx+bNUXa2dwAJoIZbfAaW5U6wS0BaPlcSzdfA6+Vg70Mmm/WDg8Q==
X-Received: by 2002:a0d:cec7:0:b0:573:d3cd:3d2a with SMTP id q190-20020a0dcec7000000b00573d3cd3d2amr12096743ywd.28.1692798714545;
        Wed, 23 Aug 2023 06:51:54 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h185-20020a0dc5c2000000b0058427045833sm3389431ywd.133.2023.08.23.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/11] btrfs: add fscrypt related dependencies to respective headers
Date:   Wed, 23 Aug 2023 09:51:34 -0400
Message-ID: <51e817ceddd3f694740c7fcc6f9dbe7f2d720fbe.1692798556.git.josef@toxicpanda.com>
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

These headers have struct fscrypt_str as function arguments, so add
struct fscrypt_str to the theader, and include linux/fscrypt.h in
btrfs_inode.h as it also needs the definition of struct fscrypt_name for
the new inode args.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h | 1 +
 fs/btrfs/dir-item.h    | 2 ++
 fs/btrfs/inode-item.h  | 1 +
 fs/btrfs/root-tree.h   | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index bda1fdbba666..bca97a6bb246 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -8,6 +8,7 @@
 
 #include <linux/hash.h>
 #include <linux/refcount.h>
+#include <linux/fscrypt.h>
 #include "extent_map.h"
 #include "extent_io.h"
 #include "ordered-data.h"
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index 5db2ea0dfd76..e40a226373d7 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -5,6 +5,8 @@
 
 #include <linux/crc32c.h>
 
+struct fscrypt_str;
+
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 			  const struct fscrypt_str *name);
 int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 63dfd227e7ce..a4a142f1b5e3 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -13,6 +13,7 @@ struct btrfs_key;
 struct btrfs_inode_extref;
 struct btrfs_inode;
 struct extent_buffer;
+struct fscrypt_str;
 
 /*
  * Return this if we need to call truncate_block for the last bit of the
diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
index cbbaca32126e..eb15768b9170 100644
--- a/fs/btrfs/root-tree.h
+++ b/fs/btrfs/root-tree.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_ROOT_TREE_H
 #define BTRFS_ROOT_TREE_H
 
+struct fscrypt_str;
+
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
-- 
2.41.0

