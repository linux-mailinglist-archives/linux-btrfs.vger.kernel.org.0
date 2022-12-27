Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D9D65676D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Dec 2022 06:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiL0Fzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Dec 2022 00:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiL0Fz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Dec 2022 00:55:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7E721BD
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 21:55:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45C6921A5C
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 05:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672120527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+yG1hLkX0HTroE6JXqPksnhlQIJ9YKQGLBuZJfgc30=;
        b=Kg/GuSk+LeFw8BPNKp+N4MKZJ68a/I2jA0xTGBldQpjMFUgu25Pv9+JhZ0vv+OL1eGJBPP
        ZaB0/Pgl8pTvg3crpX2+ey7F1GYSJuzpF1kGNBjhrsTUT+ZMjgMZyFYR3E3nIWg6fL/Wwn
        gzYuY194OxIuVaQoQgclh3Cd+B3fwuQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 979EB133F5
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 05:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mB1aGM6IqmMBRgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 05:55:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: fix the wrong timestamp and UUID check for root items
Date:   Tue, 27 Dec 2022 13:55:07 +0800
Message-Id: <fd138f8678808717635a145832c1b13320ce6cd2.1672120480.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672120480.git.wqu@suse.com>
References: <cover.1672120480.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Since commit d729048be6ef ("btrfs-progs: stop using
btrfs_root_item_v0"), "btrfs subvolume list" not longer correctly report
UUID nor timestamp, while older (btrfs-progs v6.0.2) still works
correct:

 v6.0.2:
 # btrfs subv list -u  /mnt/btrfs/
 ID 256 gen 12 top level 5 uuid ed4af580-d512-2644-b392-2a71aaeeb99e path subv1
 ID 257 gen 13 top level 5 uuid a22ccba7-0a0a-a94f-af4b-5116ab58bb61 path subv2

 v6.1:
 # ./btrfs subv list -u /mnt/btrfs/
 ID 256 gen 12 top level 5 uuid -                                    path subv1
 ID 257 gen 13 top level 5 uuid -                                    path subv2

[CAUSE]
Commit d729048be6ef ("btrfs-progs: stop using btrfs_root_item_v0")
removed old btrfs_root_item_v0, but incorrectly changed the check for
v0 root item.

Now we will treat v0 root items as latest root items, causing possible
out-of-bound access. while treat current root items as older v0 root
items, ignoring the UUID nor timestamp.

[FIX]
Fix the bug by using correct checks, and add extra comments on the
branches.

Issue: #562
Fixes: d729048be6ef ("btrfs-progs: stop using btrfs_root_item_v0")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/subvolume-list.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 6d5ef509ae67..7cdb0402b8e5 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -870,14 +870,21 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
 				ri = (struct btrfs_root_item *)(args.buf + off);
 				gen = btrfs_root_generation(ri);
 				flags = btrfs_root_flags(ri);
-				if(sh.len <
-				   sizeof(struct btrfs_root_item)) {
+				if(sh.len >= sizeof(struct btrfs_root_item)) {
+					/*
+					 * The new full btrfs_root_item with
+					 * timestamp and UUID.
+					 */
 					otime = btrfs_stack_timespec_sec(&ri->otime);
 					ogen = btrfs_root_otransid(ri);
 					memcpy(uuid, ri->uuid, BTRFS_UUID_SIZE);
 					memcpy(puuid, ri->parent_uuid, BTRFS_UUID_SIZE);
 					memcpy(ruuid, ri->received_uuid, BTRFS_UUID_SIZE);
 				} else {
+					/*
+					 * The old v0 root item, which doesn't
+					 * has timestamp nor UUID.
+					 */
 					otime = 0;
 					ogen = 0;
 					memset(uuid, 0, BTRFS_UUID_SIZE);
-- 
2.39.0

