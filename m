Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070953A58CA
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhFMNmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55426 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:47 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 365411FD2D;
        Sun, 13 Jun 2021 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvVASk6wKeg8uiU+9eR/xYZBw7gAnOw+H/nxmFlyzrU=;
        b=QL8CUyw0Ouk3fzA5dgi3XKcROPnr0Th9xlr95jn7wfHwTIj1vfOq1Dm5xPq9yDdcoLCjm+
        1KarhgnzOtr0oQ6sOe+np87Eml50GV9zT1rgKN/8YZ8+zl1sZTK+UkbgdXtu9v9fPuJHSM
        I//UtnJVJpw3YxyPOtykI3zgL17ky68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvVASk6wKeg8uiU+9eR/xYZBw7gAnOw+H/nxmFlyzrU=;
        b=ANj/FsJUkPpcPaGTvpzD2JAFxsq/Ouab/dIpVaDiS1iNmnI+/l58sQH3wxLgmmyttCHM/5
        lcw7uePnVihkqmCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id CEC63118DD;
        Sun, 13 Jun 2021 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvVASk6wKeg8uiU+9eR/xYZBw7gAnOw+H/nxmFlyzrU=;
        b=QL8CUyw0Ouk3fzA5dgi3XKcROPnr0Th9xlr95jn7wfHwTIj1vfOq1Dm5xPq9yDdcoLCjm+
        1KarhgnzOtr0oQ6sOe+np87Eml50GV9zT1rgKN/8YZ8+zl1sZTK+UkbgdXtu9v9fPuJHSM
        I//UtnJVJpw3YxyPOtykI3zgL17ky68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvVASk6wKeg8uiU+9eR/xYZBw7gAnOw+H/nxmFlyzrU=;
        b=ANj/FsJUkPpcPaGTvpzD2JAFxsq/Ouab/dIpVaDiS1iNmnI+/l58sQH3wxLgmmyttCHM/5
        lcw7uePnVihkqmCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id SuctKdwKxmB0JAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:44 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 15/31] btrfs: Switch to iomap_writepages()
Date:   Sun, 13 Jun 2021 08:39:43 -0500
Message-Id: <75b4c003edceca1866a5abfda2c1bb496ee048f1.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Switch to iomap_writepages()

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0601cf375b9c..be0caf3a11f9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8430,7 +8430,9 @@ static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
 static int btrfs_writepages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
-	return extent_writepages(mapping, wbc);
+	struct iomap_writepage_ctx wpc = {0};
+
+	return iomap_writepages(mapping, wbc, &wpc, &btrfs_writeback_ops);
 }
 
 static void btrfs_readahead(struct readahead_control *rac)
-- 
2.31.1

