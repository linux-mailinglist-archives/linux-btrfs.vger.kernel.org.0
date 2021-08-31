Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ECE3FC300
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 08:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhHaGvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 02:51:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47148 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhHaGvJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 02:51:09 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 770D32216A;
        Tue, 31 Aug 2021 06:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630392613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GwobLX/7Z2XICbZYxXOxwZKNp6C3m7gIevrEEGwHUKo=;
        b=BmXlNWC6uNnAmA9rFvimHEuaVOgDPseXeqJXVwjgnUoXhMm6Qn9cfdX3WOBNTnQvJRgRv9
        cSV/0BKagaIH9mM9FoVj5orshMe0xpirh1iSULIMCV5/dM+x7Fb+O2hvnENubBNiRYvpNz
        7NbDCdqfmCSOsv7HTxmLiS/u9SFbvYI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 28E5512FC5;
        Tue, 31 Aug 2021 06:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id VOkrNiPRLWEpQgAAGKfGzw
        (envelope-from <wqu@suse.com>); Tue, 31 Aug 2021 06:50:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] kobject: add the missing export for kobject_create()
Date:   Tue, 31 Aug 2021 14:50:09 +0800
Message-Id: <20210831065009.29358-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For any module utilizing kobject_create(), it will lead to link error:

  $ make M=fs/btrfs -j12
    CC [M]  fs/btrfs/sysfs.o
    LD [M]  fs/btrfs/btrfs.o
    MODPOST fs/btrfs/Module.symvers
  ERROR: modpost: "kobject_create" [fs/btrfs/btrfs.ko] undefined!
  make[1]: *** [scripts/Makefile.modpost:150: fs/btrfs/Module.symvers] Error 1
  make[1]: *** Deleting file 'fs/btrfs/Module.symvers'
  make: *** [Makefile:1766: modules] Error 2

[CAUSE]
It's pretty straight forward, kobject_create() doesn't have
EXPORT_SYMBOL_GPL().

[FIX]
Fix it by adding the missing EXPORT_SYMBOL_GPL().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
A little surprised by the fact that no know even is calling
kobject_create() now.

Or should we just call kmalloc() manually then kobject_init_and_add()?
---
 lib/kobject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index ea53b30cf483..af308cf7dba2 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -788,6 +788,7 @@ struct kobject *kobject_create(void)
 	kobject_init(kobj, &dynamic_kobj_ktype);
 	return kobj;
 }
+EXPORT_SYMBOL_GPL(kobject_create);
 
 /**
  * kobject_create_and_add() - Create a struct kobject dynamically and
-- 
2.33.0

