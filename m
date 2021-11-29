Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDFE462800
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 00:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhK2XRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 18:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhK2XRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 18:17:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32F7C06175A;
        Mon, 29 Nov 2021 15:02:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1BDA6CE167C;
        Mon, 29 Nov 2021 23:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C408C53FC7;
        Mon, 29 Nov 2021 23:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638226940;
        bh=1i2gZ5NGBOA7KsIRxdWJ7aD3gL4YbJYucMh+Om0IHO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmgvC2cJiYl9hg0+DWzrUeegL1v3t/0Ldjou6S6SPHApfqANoPUv82DGNm2PvdjxC
         FOMooKapEe85SHUpBBmfjVnOLqNRyUOb7yVD/jzS9pQgChawpzSYzuR2QWOCHbYpls
         dSkfzbUqp6Ue8NZReOpR6ks/s/+j4KbJ6PSJTxpEKygYa2272ixlWyeRNFlRtGwEOL
         LTpOsd6dIzH+Fpw+8LdQHGQWdQBD0mtJXOJa/+copBW9sMcrNbUwMM7ivbIOPHBI5l
         GGzASoGXWhfibOgzK25omCP/MHXOw+HrdIiB8gBA4/BTSlrxZ0qhDgN08RhTRhfd4a
         XRTe7QQwuyDAA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] lib/Kconfig.debug: Make TEST_KMOD depend on PAGE_SIZE_LESS_THAN_256KB
Date:   Mon, 29 Nov 2021 16:01:41 -0700
Message-Id: <20211129230141.228085-4-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129230141.228085-1-nathan@kernel.org>
References: <20211129230141.228085-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit b05fbcc36be1 ("btrfs: disable build on platforms having page size
256K") disabled btrfs for configurations that used a 256kB page size.
However, it did not fully solve the problem because CONFIG_TEST_KMOD
selects CONFIG_BTRFS, which does not account for the dependency. This
results in a Kconfig warning and the failed BUILD_BUG_ON error
returning.

WARNING: unmet direct dependencies detected for BTRFS_FS
  Depends on [n]: BLOCK [=y] && !PPC_256K_PAGES && !PAGE_SIZE_256KB [=y]
  Selected by [m]:
  - TEST_KMOD [=m] && RUNTIME_TESTING_MENU [=y] && m && MODULES [=y] && NETDEVICES [=y] && NET_CORE [=y] && INET [=y] && BLOCK [=y]

To resolve this, add CONFIG_PAGE_SIZE_LESS_THAN_256KB as a dependency of
CONFIG_TEST_KMOD so there is no more invalid configuration or build
errors.

Fixes: b05fbcc36be1 ("btrfs: disable build on platforms having page size 256K")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5c12bde10996..a32f6bb4642c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2486,6 +2486,7 @@ config TEST_KMOD
 	depends on m
 	depends on NETDEVICES && NET_CORE && INET # for TUN
 	depends on BLOCK
+	depends on PAGE_SIZE_LESS_THAN_256KB # for BTRFS
 	select TEST_LKM
 	select XFS_FS
 	select TUN
-- 
2.34.1

