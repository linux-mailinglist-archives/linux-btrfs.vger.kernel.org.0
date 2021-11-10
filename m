Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B954C44C03E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 12:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhKJLny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 06:43:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42294 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhKJLnx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 06:43:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 71B521FD33;
        Wed, 10 Nov 2021 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636544465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uCtWtYm2qkAEL5yS6eGLbS+r9ikQH3R5cKrx3/ij1dw=;
        b=HfDghs+yClsX436gEmh4RbOSU9Zx6MN6pN8veooFg4qTwrXsC+ukoIhwxYX0/esxWxiMRo
        MTa5JiiQlv/db6hCl2oIH2KDCcw3ycHH44Gb0+mBMIvS8qvnmEMONK+SFnFtYA/QbGxOKV
        bp5KsQgh9DK2me6hdytjMRVfDg3HRs8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35EB313BAC;
        Wed, 10 Nov 2021 11:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hPl3CtGvi2FeYAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 10 Nov 2021 11:41:05 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Deprecate BTRFS_IOC_BALANCE ioctl
Date:   Wed, 10 Nov 2021 13:41:04 +0200
Message-Id: <20211110114104.1140727-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The v2 balance ioctl has been introduced more than 9 years ago. Users of
the old v1 ioctl should have long been migrated to it. It's time we
deprecate it and eventually remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 238308f14474..dcf0772880b6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4013,6 +4013,9 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	bool need_unlock; /* for mut. excl. ops lock */
 	int ret;
 
+	if (!arg)
+		btrfs_warn(fs_info, "BTRFS_IOC_BALANCE ioctl is deprecated and will be removed in kernel 5.18");
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.25.1

