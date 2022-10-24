Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F248B60BA97
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiJXUi4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiJXUi0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:38:26 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9AA9AFD5
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:49:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f8so6651965qkg.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdGTGs+sKRCYmfjrv71UScjSGR+btWeaxat4NXAXloU=;
        b=7bbMctU2LwMmL2PpjDJVD6FORs2K08El8eZ2NkgScgemwqk1d6kBSyOiz5i3zG86sV
         T1p0vZz44NyQlK/2vF0J/AL7jXoPLceDOmmN2Nss+xoWWrLk2IqoyB98dOcFQKwGt1m8
         IKexggFKqhBA1Nsr41T3yub36/GC9EoJYChRgU8kEoZcZUHruzEsMVDs86LhcV2AXNLb
         LP9AZrJ4n4A92JrKAI7+aLehNsEcm7mQP/BMJk00xeZaANRZvqrTxLZD88PPmV7YE1yH
         Hj9m/GjcOmUM9xcUhwXuvpsu0hmyzIpfYmR5ZNyRrM1B6S/NPMZnB9mSRFFHAme9WadP
         msiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdGTGs+sKRCYmfjrv71UScjSGR+btWeaxat4NXAXloU=;
        b=DuNW2N6K85pdIGT/5n9nut0U5GIm8HpzNBLJUkB0v+wOBhQVCr/zioYTc1E57zNqqd
         Ovfv2S+vfjRzCn0UttUkWzTE6hoGcPXcEdQXc0BCqIqOy3l6tmufIKHCGfqeu4ZenB4v
         U9hLLb6KHeZ9uYqzoE5dKT86m7++y44zkhHKdjxq4SoBUv8pkNL51lNRjEabhBcSm81k
         4mwV4JPf9GMMsPEAIBj9j8ukujYk4Lu0Bo2DbtNZwM3tTiES9jAUS4D0x35cQLjBkU92
         yUKv8GpEqwAd/M2owa62luiieRnWcbPOdvRTt5HKRZWzX9kvE2zWlK6N3p4bYXhqrTQ8
         Ts+A==
X-Gm-Message-State: ACrzQf3fPpATMtJbzF0tj3lV6CPw8tEmCbM2QdHLV8uiv5Wd6r57x9jd
        ONorS7AcyrcRl27pIK2vWx6LJbp3++lJiw==
X-Google-Smtp-Source: AMsMyM6nZVUuGdIWeVs3e5OS1AIF00qyg+d3Q8sT+Eg6wSRJig15idOtTqFhd2eR08VXE50cMo5h8A==
X-Received: by 2002:a05:620a:4720:b0:6ee:dc2d:4729 with SMTP id bs32-20020a05620a472000b006eedc2d4729mr23092286qkb.36.1666637233577;
        Mon, 24 Oct 2022 11:47:13 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a25d300b006ec62032d3dsm478645qko.30.2022.10.24.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/9] btrfs: move delalloc space related prototypes to delalloc-space.h
Date:   Mon, 24 Oct 2022 14:46:58 -0400
Message-Id: <2b339d60ec8ab8ca7c60dea04991d7591717abfa.1666637013.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666637013.git.josef@toxicpanda.com>
References: <cover.1666637013.git.josef@toxicpanda.com>
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

These exist in delalloc-space.c, move them from ctree.h into
delalloc-space.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h          | 3 ---
 fs/btrfs/delalloc-space.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a2cc9dda9ca2..04d1568b4bd4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -491,10 +491,7 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     int nitems, bool use_global_rsv);
 void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 				      struct btrfs_block_rsv *rsv);
-void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
-				    u64 disk_num_bytes, bool noflush);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index e07d46043455..c5d573f2366e 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -20,5 +20,8 @@ void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				     bool qgroup_free);
 int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes, bool noflush);
+void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
 #endif /* BTRFS_DELALLOC_SPACE_H */
-- 
2.26.3

