Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA53174859C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjGEOBo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjGEOBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 10:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD4D10EA;
        Wed,  5 Jul 2023 07:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36B1D61584;
        Wed,  5 Jul 2023 14:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F2FC433C8;
        Wed,  5 Jul 2023 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688565700;
        bh=i4WuLKoN0IyluaFAelwAkFb9Rk1qHMBCuaUBAW8Ar9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvQXJaHkk4ukD90YKcHiOX5/PkUmuljkT4jVmkkhUK7Jl/wzvzJXfsQD29WErL8uD
         lOVgIGjHEeQMoopAsJRkpNPfWCea9oRPIOT/6DdQnyC3S6TSv8Pg/Ss7NKNS4vIf75
         25ntnvl3c/sa47hO689Y8FSb00FfbqPqgD9gi0yv8ZG1mf1cB6+ECuWeWg4hGDMTWx
         5JQZDU/1umQRfQrVkwp2tlaAkjP5pjUmAjeo5eFhjopZmcCnWbJC+rZbe8NB4efUSg
         uFikvcQdGolhU0H+AYW1uImXtMuvzmTa5k3J60qFVSiKmldY5asArIzXBro45/W8jq
         68dIvQ0aRfdww==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix 64-bit division link failure
Date:   Wed,  5 Jul 2023 16:01:09 +0200
Message-Id: <20230705140117.795478-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705140117.795478-1-arnd@kernel.org>
References: <20230705140117.795478-1-arnd@kernel.org>
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

Some of the recent refactoring of the statfs code apparently
brought back a link failure on older gcc versions that I had
fixed before:

arm-linux-gnueabi-ld: fs/btrfs/super.o: in function `btrfs_statfs':
super.c:(.text+0xec40): undefined reference to `__aeabi_uldivmod'

I think what happened is that gcc is free to not inline a function
despite the 'inline' annotation, and when this happens it can end
up partially inlining the div_u64() helper in a way that breaks the
__builtin_constant_p() based optimization.

I only see this behavior for gcc-9, but it's possible that the same
thing happens in later versions as well when the code changes again.

Change this to __always_inline to prevent it from happening again,
and add a comment about this.

Fixes: 7e17916b35797 ("btrfs: avoid link error with CONFIG_NO_AUTO_INLINE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f1dd172d8d5bd..7c8ee0da0f0d1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1902,9 +1902,9 @@ static inline void btrfs_descending_sort_devices(
 
 /*
  * The helper to calc the free space on the devices that can be used to store
- * file data.
+ * file data, always inline to avoid a link failure with gcc-9 and earlier.
  */
-static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
+static __always_inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 					      u64 *free_bytes)
 {
 	struct btrfs_device_info *devices_info;
-- 
2.39.2

