Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84E57859C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjHWNvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbjHWNvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:51 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533FCDF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:49 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-591ba8bd094so40129887b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798708; x=1693403508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDWUkrG4DZaGLhaxDYtKpgkyNYU+vRB0+Q/6VSj1VwU=;
        b=Td8E9NW5ij9mfzp9Jmxp23fkuy1lD/ZkpO3K2l7soH9yLrOoM4xoUVeqLcJVZX4w2T
         TDUPwfT6NQJKPCiTbegz9XBaU6CmoK4HM9fY2slb6Cn2mgbh/W3zQbamd61ciJa0i+mU
         NpwysaNuhXoQcPaGCO9/ga42xXyCt34T5Mx4PpsGQnHoFgWALziMUrKKj1nzO+zp6rkI
         +pPjIkAug1DIcZJrpZ+4obKx0Ehw6/cIk+3Ixi+YwVjOw69zx7uqiVUdgUQWeB5ddSNu
         79ltJYxqlg4yJWePnQR84V+g7o0Hep27fy7Fv11O+9HTwilla66j748MrfFeYm9EWC4f
         bixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798708; x=1693403508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDWUkrG4DZaGLhaxDYtKpgkyNYU+vRB0+Q/6VSj1VwU=;
        b=APVSj7NGziG1QJK1MtvRgCWco4HGCNjbabgHqbZ/xSO+naWZmSVhhIZ1EAcFo+K/LQ
         4PyWJZx4kzLJFDNekV7EJiOAOckXr7JyJ7hJ16aEIo8q0vRk0nkiQB3YeYPAHVw76xOG
         2DlPoMsmFX2eMLvA4CZy+CtZ/tn8dGICYiH+II9nH/VicDjLelcQHX3Tai3Q7EkzwPjd
         Xs8JTKraS4UIcOeS5Oi70iZ1gDwMpQQRqttieyhd5WgIsb2sv0I12g7Hq/wUmr83OD8O
         biXbB1UrDl51Y43ggAcjW5bayr/rMHjrHlswjaMMauzLBARo2rgmTWC10P4BGCZiFBrw
         0qCQ==
X-Gm-Message-State: AOJu0Ywvz2WUnuXr4NKfquqG/MnRSuBj3D0B68Nolv2hqma62htciPaL
        UJJmy1iJpZgDCqhTYEBX5NGPIWP7dS8ohGljnxI=
X-Google-Smtp-Source: AGHT+IGvDCY09fr0ofCXY3N3S/myQz3C79ytZU4OipEr7Gkf4ZkO5EPdGAIViwpZOJAanEDf3tD9HQ==
X-Received: by 2002:a81:5cd4:0:b0:586:a141:3b3e with SMTP id q203-20020a815cd4000000b00586a1413b3emr13063149ywb.13.1692798708541;
        Wed, 23 Aug 2023 06:51:48 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r6-20020a0de806000000b00586ba973bddsm3368066ywe.110.2023.08.23.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/11] btrfs: move btrfs_extref_hash into inode-item.h
Date:   Wed, 23 Aug 2023 09:51:29 -0400
Message-ID: <cbc6dcc234fc794de58b8786351b24f1bc5f4f9e.1692798556.git.josef@toxicpanda.com>
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

Ideally this would be un-inlined, but that is a cleanup for later.  For
now move this into inode-item.h, which is where the extref code lives.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      | 9 ---------
 fs/btrfs/inode-item.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bffee2ab5783..7b8e52fd6d99 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -475,15 +475,6 @@ static inline u64 btrfs_name_hash(const char *name, int len)
        return crc32c((u32)~1, name, len);
 }
 
-/*
- * Figure the key offset of an extended inode ref
- */
-static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
-                                   int len)
-{
-       return (u64) crc32c(parent_objectid, name, len);
-}
-
 static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 {
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index ede43b6c6559..2ee425a08e63 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -107,4 +107,13 @@ struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		struct extent_buffer *leaf, int slot, u64 ref_objectid,
 		const struct fscrypt_str *name);
 
+/*
+ * Figure the key offset of an extended inode ref
+ */
+static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
+                                   int len)
+{
+       return (u64) crc32c(parent_objectid, name, len);
+}
+
 #endif
-- 
2.41.0

