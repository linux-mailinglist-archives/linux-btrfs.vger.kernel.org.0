Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26E43FC505
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbhHaJbq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 05:31:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55942 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbhHaJbo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 05:31:44 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFFFF20133;
        Tue, 31 Aug 2021 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630402248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tuIfisjP0QPcwwXA3zHgV+cN0/1F3vi4ayss9IFiRB8=;
        b=J1ioywJjOvD0by4orYDiAenlbLfzB5XLIw1VS1wVmjw9Cags8k2mq4KFD3M+U+RBQweZPZ
        vlJ+usWZ2OyVPApYRg4I7vAdrWaFNKFbXR+oLxHKG+DgqjsHUXBkbQLGWbQuDmmNym/wNI
        9tOnBOeVGctRyNjV8xJ90Xhwdl3hmOc=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6CC1E137C7;
        Tue, 31 Aug 2021 09:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0bWXC8f2LWHtbQAAGKfGzw
        (envelope-from <wqu@suse.com>); Tue, 31 Aug 2021 09:30:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] kobject: unexport kobject_create() in kobject.h
Date:   Tue, 31 Aug 2021 17:30:44 +0800
Message-Id: <20210831093044.110729-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function kobject_create() is only used by one caller,
kobject_create_and_add(), no other driver uses it, nor is exported to
other modules.

However it's still exported in kobject.h, and can sometimes confuse
users of kobject.h.

Since all users should call kobject_create_and_add(), or if extra
attributes are needed, should alloc the memory manually then call
kobject_init_and_add().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/linux/kobject.h | 1 -
 lib/kobject.c           | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index ea30529fba08..efd56f990a46 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -101,7 +101,6 @@ int kobject_init_and_add(struct kobject *kobj,
 
 extern void kobject_del(struct kobject *kobj);
 
-extern struct kobject * __must_check kobject_create(void);
 extern struct kobject * __must_check kobject_create_and_add(const char *name,
 						struct kobject *parent);
 
diff --git a/lib/kobject.c b/lib/kobject.c
index ea53b30cf483..4a56f519139d 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -777,7 +777,7 @@ static struct kobj_type dynamic_kobj_ktype = {
  * call to kobject_put() and not kfree(), as kobject_init() has
  * already been called on this structure.
  */
-struct kobject *kobject_create(void)
+static struct kobject *kobject_create(void)
 {
 	struct kobject *kobj;
 
-- 
2.33.0

