Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E43E24CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 10:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbhHFING (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 04:13:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49866 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhHFINF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 04:13:05 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 238822239B
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628237569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CoK0UqTbE5rl5bhj+aHXQ0VVv+W44NBcNIeAirBHsCg=;
        b=NWAz1BRefESRrB+ntP0q73gFmW2fj4GZGDmeCYYcFpdOAd7oV77pQNsBZJF7xTdaULIssu
        ZpCpDiskGQ3XuNiS6S3GXKv/2VSsGPBj7UA2Gm4iedw/gKmH9D0aIdp5OyWZUshhJ6jh9T
        lc0nsN6UobmoSrOME+vUSkjixWAMrh4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5D28C1399D
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UGxdJ//uDGF6IQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 08:12:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 02/11] btrfs: defrag: also check PagePrivate for subpage cases in cluster_pages_for_defrag()
Date:   Fri,  6 Aug 2021 16:12:33 +0800
Message-Id: <20210806081242.257996-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806081242.257996-1-wqu@suse.com>
References: <20210806081242.257996-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function cluster_pages_for_defrag() we have a window where we unlock
page, either start the ordered range or read the content from disk.

When we re-lock the page, we need to make sure it still has the correct
page->private for subpage.

Thus add the extra PagePrivate check here to handle subpage cases
properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e63961192581..7c1ea4eed490 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1272,7 +1272,8 @@ static int cluster_pages_for_defrag(struct inode *inode,
 			 * we unlocked the page above, so we need check if
 			 * it was released or not.
 			 */
-			if (page->mapping != inode->i_mapping) {
+			if (page->mapping != inode->i_mapping ||
+			    !PagePrivate(page)) {
 				unlock_page(page);
 				put_page(page);
 				goto again;
@@ -1290,7 +1291,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 			}
 		}
 
-		if (page->mapping != inode->i_mapping) {
+		if (page->mapping != inode->i_mapping || !PagePrivate(page)) {
 			unlock_page(page);
 			put_page(page);
 			goto again;
-- 
2.32.0

