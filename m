Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D741074859A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjGEOB2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 10:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjGEOB1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 10:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F0511B;
        Wed,  5 Jul 2023 07:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2529261568;
        Wed,  5 Jul 2023 14:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E37C433C8;
        Wed,  5 Jul 2023 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688565684;
        bh=FHi/Fy+Rz8l44deZjk2XDQviwjz4I8IKV7b4enS5SEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=d2SMSLOC31lu72n6cEq55pYUHZ71RewQ1uNdAFL0V6qKqUAFnZjVk7ZVpCMtE34dV
         3Q0PHhYLzvVklSe1xjMHMKqVd2ClWG2044YARAp7SVuO89L/wzO/sAchA9acLwbu9O
         TwXV0lk+LuIegaUnyo94LcxlIJqlPo3T3D4gq/6lHQzlN6N+qVcLe3iMQ7986xE8n7
         kj/q95yHPBrFJb12w+SUV3XhBhfTfMIAbjkl8Zw8SOpX800YI/wlShsZNUBDjjjgue
         /tDNqMyRt65UeIFdipeCPiJuiqkGCmlIq5+BrIjXyGPI7XwrML50Mf7iX8FLTNhfnF
         6JlWH9oQtSCHw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] btrfs: avoid Wmaybe-uninitialized warnings
Date:   Wed,  5 Jul 2023 16:01:08 +0200
Message-Id: <20230705140117.795478-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The -Wmaybe-uninitialized warning option in gcc produces tons of false
positive warnings when KASAN is enabled, as that turns off some required
optimizations.

Rework the makefile to only enable the warning in btrfs when KASAN is
disabled, as it was before commit 78a5255ffb6a1 ("Stop the ad-hoc games
with -Wno-maybe-initialized") turned it off globally.

Fixes: 1ec49744ba83f ("btrfs: turn on -Wmaybe-uninitialized")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 90d53209755bf..a4927bf2ce7ee 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -11,8 +11,12 @@ condflags := \
 	$(call cc-option, -Wunused-but-set-variable)		\
 	$(call cc-option, -Wunused-const-variable)		\
 	$(call cc-option, -Wpacked-not-aligned)			\
-	$(call cc-option, -Wstringop-truncation)		\
-	$(call cc-option, -Wmaybe-uninitialized)
+	$(call cc-option, -Wstringop-truncation)
+
+ifndef CONFIG_KASAN
+conflags += $(call cc-option, -Wmaybe-uninitialized)
+endif
+
 subdir-ccflags-y += $(condflags)
 # The following turn off the warnings enabled by -Wextra
 subdir-ccflags-y += -Wno-missing-field-initializers
-- 
2.39.2

