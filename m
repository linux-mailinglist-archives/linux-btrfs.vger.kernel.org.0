Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB67C115F53
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 23:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLGW3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 17:29:47 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:44567 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbfLGW3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 17:29:47 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 47VkXG1WXkz20L3;
        Sat,  7 Dec 2019 23:24:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1575757470; bh=VI58KzQg7/uaxVWnMYT34RvGjunNE+yuD2zouZyTEVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=nWpexwO7v+seVeoQN5wNa9VAGfbixB/Zm9MKnB8pon1sXBr5WiPRTF3vBfFZdBqzH
         6xOiiqPm1Qvxn8czg+sl6qnVIHgSVHuLZr848YgwrwS1fI2jSEed+Um0zmM04r2plh
         /7k5xdAvxTmOLcrl5v3oNkV3RAlkjnYMEhL8SpqlG5OMNr1bWI7mkUsZpYZEX5kOXV
         S/QkEFV1xRabUdbEm8eI9qDoIZSFfXJBT1HgOXrNF3+CSNv4KIsNsLz4en+RtWCNe/
         e4yrZv23msK5d+YgWYbf78w8i/s1MM0AbnjqRPZjz6SjCRhA6XRPdadXEN/aHzbQVR
         fJTPINhOiT1lw==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.22.146
Received: from localhost.localdomain (firewall.henke.stw.uni-erlangen.de [131.188.22.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19q/UFmHZGkFP0tDe1YIZBwNCOpnb1IPqE=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 47VkXC66njz20Y7;
        Sat,  7 Dec 2019 23:24:27 +0100 (CET)
From:   Sebastian <sebastian.scherbel@fau.de>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Sebastian Scherbel <sebastian.scherbel@fau.de>,
        Ole Wiedemann <ole.wiedemann@fau.de>
Subject: [PATCH 1/2] btrfs: Move dereference behind null check in check integrity
Date:   Sat,  7 Dec 2019 23:18:17 +0100
Message-Id: <20191207221818.3641-2-sebastian.scherbel@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191207221818.3641-1-sebastian.scherbel@fau.de>
References: <20191207221818.3641-1-sebastian.scherbel@fau.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sebastian Scherbel <sebastian.scherbel@fau.de>

Regarding Bug 205003, point 1
The struct "state" is currently dereferenced before being checked
for null later on. This patch moves the dereference after the null check
to avoid a possible null pointer dereference.

Signed-off-by: Sebastian Scherbel <sebastian.scherbel@fau.de>
Co-developed-by: Ole Wiedemann <ole.wiedemann@fau.de>
Signed-off-by: Ole Wiedemann <ole.wiedemann@fau.de>
---
 fs/btrfs/check-integrity.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 0b52ab4cb964..fc429436765c 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -629,7 +629,7 @@ static struct btrfsic_dev_state *btrfsic_dev_state_hashtable_lookup(dev_t dev,
 static int btrfsic_process_superblock(struct btrfsic_state *state,
 				      struct btrfs_fs_devices *fs_devices)
 {
-	struct btrfs_fs_info *fs_info = state->fs_info;
+	struct btrfs_fs_info *fs_info;
 	struct btrfs_super_block *selected_super;
 	struct list_head *dev_head = &fs_devices->devices;
 	struct btrfs_device *device;
@@ -638,6 +638,8 @@ static int btrfsic_process_superblock(struct btrfsic_state *state,
 	int pass;
 
 	BUG_ON(NULL == state);
+	fs_info = state->fs_info;
+
 	selected_super = kzalloc(sizeof(*selected_super), GFP_NOFS);
 	if (NULL == selected_super) {
 		pr_info("btrfsic: error, kmalloc failed!\n");
-- 
2.20.1

