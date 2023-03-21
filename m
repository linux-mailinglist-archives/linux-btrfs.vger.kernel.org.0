Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27A76C3081
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCULhK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCULhJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EB9D504
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F3B61ADE
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713CFC433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679398627;
        bh=3mmbkcxlRuBRdVjlaQrIuB1auM1pv0NotbSe/t3znes=;
        h=From:To:Subject:Date:From;
        b=tpaYbXKPZNsqxyDmfpIKEHG2SxSu7HDzVPZD2Ka/taW89pDhfpeDvyEKoNDTj4HRF
         rZgSbJoNBvPO2/ztKkv/iUJ5v3DrU1JWnUzHXm/ni/qhU4Ds8o5+9SgkTADpdKZ0yS
         DAzxmF41XFVRV+pGIQKauWB2WgrWsYn2jq3jOrNxDh8CIOtWdika/3WoQXRSGfS6zt
         zFeIQZv44tuKBbA9lKxhp3xOBClCvKxrhk5YMe8IU7rK2fWjVxwOS+J66g54PfsSyU
         2kaM3jk/C6HyDWDkfRRfelnzFm4P2Nw9ffPJJ05DhuAqtmZ+4fJ2Fv/zVYBef/ZmSr
         OU8kTKNOv+N4Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove btrfs_lru_cache_is_full() inline function
Date:   Tue, 21 Mar 2023 11:37:04 +0000
Message-Id: <aa7f733f40ef92199f6130e83e4d88ca861d92f7.1679398596.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

It's not used anywhere at the moment, but it was used in earlier version
of a patch that removed its use in the second version. So just remove
btrfs_lru_cache_is_full().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/lru_cache.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
index de3e18bce24a..00328c856be6 100644
--- a/fs/btrfs/lru_cache.h
+++ b/fs/btrfs/lru_cache.h
@@ -55,11 +55,6 @@ static inline unsigned int btrfs_lru_cache_size(const struct btrfs_lru_cache *ca
 	return cache->size;
 }
 
-static inline bool btrfs_lru_cache_is_full(const struct btrfs_lru_cache *cache)
-{
-	return cache->size >= cache->max_size;
-}
-
 static inline struct btrfs_lru_cache_entry *btrfs_lru_cache_lru_entry(
 					      struct btrfs_lru_cache *cache)
 {
-- 
2.34.1

