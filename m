Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF94500FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 10:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhKOJSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 04:18:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40280 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhKOJSj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 04:18:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 627031FD65;
        Mon, 15 Nov 2021 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636967743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bYAYeY+8DKTh0heKFXylhEltP1rDPBpTovMYstLCwzM=;
        b=NoMPgTQgXGL4AyaRI6Gn0nlJY53jk2rYYDuonFj/8UQgN6JmeEmiZRIVQ08Zgk2i6Z5RyD
        KhBj/E8UvV+F7aq65FPM3R31isA78JFz5SxKLf1zvi/ZCXRa453TBR9ogpcoUuiwMWKvL3
        Sa8yZuA3oPw+7CLcVX53+An8U1Bp/nQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 327BC13C14;
        Mon, 15 Nov 2021 09:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /GW2CT8lkmExAgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 15 Nov 2021 09:15:43 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: Don't reset ratio to 1 if we don't have RAID56 profile
Date:   Mon, 15 Nov 2021 11:15:42 +0200
Message-Id: <20211115091542.200657-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 80714610f36e ("btrfs-progs: use raid table for ncopies")
slightly broke how raid ratio are being calculated since the resulting
code would always reset ratio to be 1 in case we didn't have RAID56
profile. The correct behavior is to simply set it to 0 if we have RAID56
as the calculation is different in this case and leave it intact
otherwise.

This bug manifests by doing all size-related calculation for
'btrfs filesystem usage' command as if all block groups are of type SINGLE. Fix
this by only reseting ratio 0 in case of RAID56.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 cmds/filesystem-usage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index e22efe3a441d..6195f633da44 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -500,7 +500,6 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 		u64 flags = sargs->spaces[i].flags;

 		ratio = btrfs_bg_type_to_ncopies(flags);
-
 		/*
 		 * The RAID5/6 ratio depends on the number of stripes and is
 		 * computed separately. Setting ratio to 0 will not account
@@ -508,8 +507,6 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 		 */
 		if (flags & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			ratio = 0;
-		else
-			ratio = 1;

 		if (ratio > max_data_ratio)
 			max_data_ratio = ratio;
--
2.17.1

