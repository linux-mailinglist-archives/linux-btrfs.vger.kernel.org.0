Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF633EE92
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhCQKpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 06:45:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhCQKpZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 06:45:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615977924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OfuoPB2HCCrJ+7NjrXQ2EuYFt6e08MJVF+WOY98CY/Q=;
        b=cImapM3mQ5LtmA0VV3zQRb0HQhgkveKlecVE581D1+nOqQZb4NklBtNtzSX09/2RAkBcMY
        MuOHa035vNZERKwYL469whYCFNqAl+5Tmw6lkjwvRLqPwwCgnAjLa2Kswf2FWw5xXGgHgs
        DBYCASERt1DrM9+GxbOXnxjR0Z9c9kg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53159AE15;
        Wed, 17 Mar 2021 10:45:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 55245DA6E2; Wed, 17 Mar 2021 11:43:22 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: fix build when using M=fs/btrfs
Date:   Wed, 17 Mar 2021 11:43:13 +0100
Message-Id: <20210317104313.17028-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are people building the module with M= that's supposed to be used
for external modules. This got broken in e9aa7c285d20 ("btrfs: enable
W=1 checks for btrfs").

  $ make M=fs/btrfs
  scripts/Makefile.lib:10: *** Recursive variable 'KBUILD_CFLAGS' references itself (eventually).  Stop.
  make: *** [Makefile:1755: modules] Error 2

There's a difference compared to 'make fs/btrfs/btrfs.ko' which needs
to rebuild a few more things and also the dependency modules need to be
available. It could fail with eg.

  WARNING: Symbol version dump "Module.symvers" is missing.
	   Modules may not have dependencies or modversions.

In some environments it's more convenient to rebuild just the btrfs
module by M= so let's make it work.

The problem is with recursive variable evaluation in += so the
conditional C options are stored in a temporary variable to avoid the
recursion.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index b634c42115ea..b4fb997eda16 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -7,10 +7,12 @@ subdir-ccflags-y += -Wmissing-format-attribute
 subdir-ccflags-y += -Wmissing-prototypes
 subdir-ccflags-y += -Wold-style-definition
 subdir-ccflags-y += -Wmissing-include-dirs
-subdir-ccflags-y += $(call cc-option, -Wunused-but-set-variable)
-subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)
-subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
-subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
+condflags := \
+	$(call cc-option, -Wunused-but-set-variable)		\
+	$(call cc-option, -Wunused-const-variable)		\
+	$(call cc-option, -Wpacked-not-aligned)			\
+	$(call cc-option, -Wstringop-truncation)
+subdir-ccflags-y += $(condflags)
 # The following turn off the warnings enabled by -Wextra
 subdir-ccflags-y += -Wno-missing-field-initializers
 subdir-ccflags-y += -Wno-sign-compare
-- 
2.29.2

