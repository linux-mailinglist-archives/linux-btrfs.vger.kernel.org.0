Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20B1441AE8
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 12:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhKAL4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 07:56:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhKAL4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Nov 2021 07:56:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7019B218DF;
        Mon,  1 Nov 2021 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635767607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXtz3Ttv47Bq3Xm7aFwIFxgeawLfWg++GtBDuJEUgBc=;
        b=r/Pfi35leTZggbu4YYSBiJhioGAEwmAua+UqF41teJdjY4iFFccYDCavrGGkxm3ooBtmDZ
        iSYZ6MGSnzijKAQKXRaMqxeXy4qtYPr//It3qDFnL1xUl9ABLxksU2oWbT3dKRMBMi2zpI
        fCvR0xqkorws4I930FuJK2Ij4J9xURw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38B15133FE;
        Mon,  1 Nov 2021 11:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iELLCjfVf2HabQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 01 Nov 2021 11:53:27 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: make device add compatible with paused balance in btrfs_exclop_start_try_lock
Date:   Mon,  1 Nov 2021 13:53:23 +0200
Message-Id: <20211101115324.374076-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101115324.374076-1-nborisov@suse.com>
References: <20211101115324.374076-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is needed to enable device add to work in cases when a file system
has been mounted with 'skip_balance' mount option.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4aa6191889a3..05969e2f4536 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -386,6 +386,7 @@ bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
  *
  * Compatibility:
  * - the same type is already running
+ * - when trying to add a device and balance has been paused
  * - not BTRFS_EXCLOP_NONE - this is intentionally incompatible and the caller
  *   must check the condition first that would allow none -> @type
  */
@@ -393,7 +394,9 @@ bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
 				 enum btrfs_exclusive_operation type)
 {
 	spin_lock(&fs_info->super_lock);
-	if (fs_info->exclusive_operation == type)
+	if (fs_info->exclusive_operation == type ||
+	    (fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED &&
+	     type == BTRFS_EXCLOP_DEV_ADD))
 		return true;
 
 	spin_unlock(&fs_info->super_lock);
-- 
2.25.1

