Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C153E24D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbhHFINR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 04:13:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41130 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243383AbhHFINQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 04:13:16 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C11520263
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628237580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXz2nqRUqjuBuQjH3RE0RLS4DNUa2Dxw1XN4yfdUBuw=;
        b=Eym6ZuwQx4sIPBgoUSvf5bbmaf2Xnuq7Is6ht+k3r1QqOkySbrM82OFFCPyinuGRdPKprR
        cYiUSMxrHgVgCRmpyJKciL6kcn4SKaQFFQh9/bBpi/bBEhpcXS3btbJLc5Hm9ttf1oGvzj
        0ww0LbEJByZL/nb9w+bwZ7uYUseylts=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9B10B1399D
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id eBHYFgvvDGF6IQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 08:12:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 11/11] btrfs: defrag: enable defrag for subpage case
Date:   Fri,  6 Aug 2021 16:12:42 +0800
Message-Id: <20210806081242.257996-12-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806081242.257996-1-wqu@suse.com>
References: <20210806081242.257996-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the new infrasturture which has taken subpage into consideration,
now we should be safe to allow defrag to work for subpage case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fe56183f0872..f00a3957a090 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3071,12 +3071,6 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 		goto out;
 	}
 
-	/* Subpage defrag will be supported in later commits */
-	if (root->fs_info->sectorsize < PAGE_SIZE) {
-		ret = -ENOTTY;
-		goto out;
-	}
-
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFDIR:
 		if (!capable(CAP_SYS_ADMIN)) {
-- 
2.32.0

