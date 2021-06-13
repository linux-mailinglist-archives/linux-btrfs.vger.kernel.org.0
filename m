Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465BC3A58C8
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFMNmm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55410 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNmm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B43C1FD2D;
        Sun, 13 Jun 2021 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uw+CueK/k+SjCPoe3p3Dw3pqHof/UVQBmzfjw9hxgs0=;
        b=Je4Ob1RyOf04aUwG7P0DM6tB/XkB4HiXrB5ZYEP1xxdfnjbk8vHZ8PnJLnWeJox539jKzn
        MLbiAlo8Cbx6O5Tu/sZeLe39X8pcpZdRj2MKSdn16v0UoVw6jouYneoz77hML+xiinqOxV
        kF3v0GhP+aXglau6hAIBtbwcNB9k+bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uw+CueK/k+SjCPoe3p3Dw3pqHof/UVQBmzfjw9hxgs0=;
        b=zFFydXdMWoQmnVJxSVp1Nx6AA9SIxLEO5+DQkjTPspLuUP8r9U86kXL3JyVu48CLE5KvYw
        mSI+iVZTpBR72bBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E423B118DD;
        Sun, 13 Jun 2021 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uw+CueK/k+SjCPoe3p3Dw3pqHof/UVQBmzfjw9hxgs0=;
        b=Je4Ob1RyOf04aUwG7P0DM6tB/XkB4HiXrB5ZYEP1xxdfnjbk8vHZ8PnJLnWeJox539jKzn
        MLbiAlo8Cbx6O5Tu/sZeLe39X8pcpZdRj2MKSdn16v0UoVw6jouYneoz77hML+xiinqOxV
        kF3v0GhP+aXglau6hAIBtbwcNB9k+bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uw+CueK/k+SjCPoe3p3Dw3pqHof/UVQBmzfjw9hxgs0=;
        b=zFFydXdMWoQmnVJxSVp1Nx6AA9SIxLEO5+DQkjTPspLuUP8r9U86kXL3JyVu48CLE5KvYw
        mSI+iVZTpBR72bBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id VORKLNcKxmBrJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:39 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 13/31] btrfs: do not checksum for free space inode
Date:   Sun, 13 Jun 2021 08:39:41 -0500
Message-Id: <acd977c106057ee19f4c965b718460605add1cc0.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Free space inode writes should not be checksummed.

Q: Now sure why this is required now (as opposed to earlier), but it
would fail on writing free_space_inode. How is this avoided in the
existing code?

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/disk-io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d1d5091a8385..3af505ec22dc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -946,9 +946,12 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 			goto out_w_error;
 		ret = btrfs_map_bio(fs_info, bio, mirror_num);
 	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
-		ret = btree_csum_one_bio(bio);
-		if (ret)
-			goto out_w_error;
+		/* Do not checksum free space inode */
+		if (!btrfs_is_free_space_inode(BTRFS_I(inode))) {
+			ret = btree_csum_one_bio(bio);
+			if (ret)
+				goto out_w_error;
+		}
 		ret = btrfs_map_bio(fs_info, bio, mirror_num);
 	} else {
 		/*
-- 
2.31.1

