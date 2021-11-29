Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D073146277B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 00:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhK2XGN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 18:06:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35470 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbhK2XFd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 18:05:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 680AFB811FF;
        Mon, 29 Nov 2021 23:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168CFC53FCB;
        Mon, 29 Nov 2021 23:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638226933;
        bh=TsQO+VKLXXeDMXVewIYmjbp69FG3TjSq0I96OnyDosE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I44J4yyyLs/KOvb80gIL8xy4x3mlAW6o5+ZGNoOOS7qi1iE5tefOTRV2xwBysZ4Ab
         jCmP1NkJWdFqPP0xn8Q0fcqLQzmmztevCFpRRtsdngDAHtfgdnYNHWmice3kh2kyds
         OZ8AGhTT9nC4O+Y7xxcWve7N68aoj5oeN/N0EcJkQ3rOZCWTx/vMfCHUPUReu6N2fd
         FZOk7yVjR7uuJ3qMcU5BuIGD5bLFKS6JljmAL991pWjaHEBBdlFL9zqQcEr5aKtWl2
         3tDz5i6rCHiLOpempB3lxw6DrmvxWG20gtcEWY95pJkN5gXDQ5YVI6D2/H46EisOSd
         6Yv3RKzL1tVbw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/3] arch/Kconfig: Split PAGE_SIZE_LESS_THAN_256KB from PAGE_SIZE_LESS_THAN_64KB
Date:   Mon, 29 Nov 2021 16:01:39 -0700
Message-Id: <20211129230141.228085-2-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129230141.228085-1-nathan@kernel.org>
References: <20211129230141.228085-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs requires a page size smaller than 256kB. To use that dependency in
other places, introduce CONFIG_PAGE_SIZE_LESS_THAN_256KB and reuse that
dependency in CONFIG_PAGE_SIZE_LESS_THAN_64KB.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index d3c4ab249e9c..c1936e154e66 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -998,6 +998,10 @@ config PAGE_SIZE_LESS_THAN_64KB
 	depends on !PAGE_SIZE_64KB
 	depends on !PARISC_PAGE_SIZE_64KB
 	depends on !PPC_64K_PAGES
+	depends on PAGE_SIZE_LESS_THAN_256KB
+
+config PAGE_SIZE_LESS_THAN_256KB
+	def_bool y
 	depends on !PPC_256K_PAGES
 	depends on !PAGE_SIZE_256KB
 
-- 
2.34.1

