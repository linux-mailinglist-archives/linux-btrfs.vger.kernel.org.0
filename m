Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A16B3B05CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFVN34 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 09:29:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32934 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVN34 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 09:29:56 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A89482196C;
        Tue, 22 Jun 2021 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624368459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v9lrokITYWEy9jx838KCVgQzwV4RfVJ/qGT5QE8vtxY=;
        b=R8t5T9SaphdN8uuWr15vb4TkR61VyBdTYaygezFYurWMTWtwTjAJjY2eh3dNy6a6zjqOW2
        e7bFv0n1DZkEeJQEQ35sKAj36u7gsICOH91H8AN9h5mTT+A9aSStRX8er/plJsJSdO09m+
        KI4E9tAtn0kgKFEiziDtK4GIcCtPlWU=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7254E118DD;
        Tue, 22 Jun 2021 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624368459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v9lrokITYWEy9jx838KCVgQzwV4RfVJ/qGT5QE8vtxY=;
        b=R8t5T9SaphdN8uuWr15vb4TkR61VyBdTYaygezFYurWMTWtwTjAJjY2eh3dNy6a6zjqOW2
        e7bFv0n1DZkEeJQEQ35sKAj36u7gsICOH91H8AN9h5mTT+A9aSStRX8er/plJsJSdO09m+
        KI4E9tAtn0kgKFEiziDtK4GIcCtPlWU=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id J1pxGUvl0WBoNgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Tue, 22 Jun 2021 13:27:39 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove btrfs_fs_info::total_pinned
Date:   Tue, 22 Jun 2021 16:27:38 +0300
Message-Id: <20210622132738.2357003-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This got added 14 years ago in 324ae4df00fd ("Btrfs: Add block group pinned accounting back")
but it was not ever used. Subsequently its usage got gradually removed
in  8790d502e440 ("Btrfs: Add support for mirroring across drives") and
11833d66be94 ("Btrfs: improve async block group caching"). Let's remove
it for good!

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d7ef4d7d2c1a..e5e53e592d4f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -823,8 +823,6 @@ struct btrfs_fs_info {
 	struct kobject *space_info_kobj;
 	struct kobject *qgroups_kobj;
 
-	u64 total_pinned;
-
 	/* used to keep from writing metadata until there is a nice batch */
 	struct percpu_counter dirty_metadata_bytes;
 	struct percpu_counter delalloc_bytes;
-- 
2.25.1

