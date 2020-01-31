Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43D14E6F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 03:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgAaCId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 21:08:33 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45078 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgAaCId (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 21:08:33 -0500
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by james.kirk.hungrycats.org (Postfix) with ESMTP id 2D00A59C3BD;
        Thu, 30 Jan 2020 21:08:32 -0500 (EST)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.92)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1ixLjT-00008p-VZ; Thu, 30 Jan 2020 21:08:32 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] inspect: make sure LOGICAL_INO_V2 args are zero-initialized
Date:   Thu, 30 Jan 2020 21:08:23 -0500
Message-Id: <20200131020823.29824-1-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LOGICAL_INO v1 ignored the reserved fields, so they could be filled
with random stack garbage and have no effect.  LOGICAL_INO_V2 requires
all unused reserved bits to be set to zero, and returns EINVAL if they
are not, to guard against future kernel versions which may interpret
non-zero bit values.

Sometimes when 'btrfs ins log' runs, the stack garbage is zeros, so the
-o (ignore offsets) option for logical-resolve works.  Sometimes the
stack garbage is something else, and 'btrfs ins log -o' fails with
invalid argument.  This depends mostly on compiler version and build
environment details, so a binary typically either always works or never
works.

Fix by initializing logical-resolve's argument structure with a C99
compound literal zero.

Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
---
 cmds/inspect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 9ca78611..5b946da0 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -149,7 +149,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	int verbose = 0;
 	int getpath = 1;
 	int bytes_left;
-	struct btrfs_ioctl_logical_ino_args loi;
+	struct btrfs_ioctl_logical_ino_args loi = { 0 };
 	struct btrfs_data_container *inodes;
 	u64 size = SZ_64K;
 	char full_path[PATH_MAX];
-- 
2.20.1

