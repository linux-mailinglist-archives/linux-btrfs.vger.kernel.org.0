Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6823495A6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 08:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378876AbiAUHNt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 02:13:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55984 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378863AbiAUHNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 02:13:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67A7821634
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 07:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642749226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kUzqa7ywf+IIWq0DoenX9wWxzU9B41znFXznEoA6g/0=;
        b=KFmLUCJUVT2F1PtuvaELkruTe+CzhDusHuJDz0r12wL+dcsTqdnRMP45wzbZy3zByOoDyP
        0lVjPsstmWCv6ojT2BwH4FOfAn2u2R02iBLEsfcKxWXN3xZBrKn9HvJuxgPJk01LGdtsZo
        PmmszEp3KmtzsK/32wCY8CuVswdSLhE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B83AD13345
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 07:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Low4ICld6mGzGAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 07:13:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: sysfs: introduce <uuid>/debug/cleaner_trigger
Date:   Fri, 21 Jan 2022 15:13:28 +0800
Message-Id: <20220121071328.47060-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since there is no existing quick way to trigger cleaner to do
cleanup/autodefrag, here we introduce a new sysfs file at:

  /sys/fs/btrfs/<uuid>/debug/cleaner_trigger

Any write into that file will wake up cleaner_kthread.

This allows us to have a fast and relieable way to trigger cleaner to
test autodefrag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
There seems to be no way to initiate the cleaner thread to run.

With this patch and previous io_accounting patch, I can now trigger an
autodefrag run and compare io_accounting to get how many bytes are
re-written (aka, defragged).

Although so far I still can't craft a minimal script to trigger more IO
than expected.
---
 fs/btrfs/sysfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index dfdef93bdeab..a20e6bd82d8d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -577,6 +577,17 @@ static ssize_t btrfs_discard_max_discard_size_store(struct kobject *kobj,
 BTRFS_ATTR_RW(discard, max_discard_size, btrfs_discard_max_discard_size_show,
 	      btrfs_discard_max_discard_size_store);
 
+static ssize_t wake_up_cleaner(struct kobject *kobj, struct kobj_attribute *a,
+			       const char *buf, size_t count)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+
+	wake_up_process(fs_info->cleaner_kthread);
+	return count;
+}
+
+BTRFS_ATTR_RW(debug_mount, cleaner_trigger, NULL, wake_up_cleaner);
+
 /*
  * Per-filesystem debugging of discard (when mounted with discard=async).
  *
@@ -600,6 +611,7 @@ static const struct attribute *discard_debug_attrs[] = {
  * Path: /sys/fs/btrfs/UUID/debug/
  */
 static const struct attribute *btrfs_debug_mount_attrs[] = {
+	BTRFS_ATTR_PTR(debug_mount, cleaner_trigger),
 	NULL,
 };
 
-- 
2.34.1

