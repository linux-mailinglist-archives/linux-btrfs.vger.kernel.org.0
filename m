Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CB636A5BD
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhDYIf7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Apr 2021 04:35:59 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:38120 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDYIf4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Apr 2021 04:35:56 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 13A32471E60;
        Sun, 25 Apr 2021 11:35:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1619339716; bh=R2/ll3Ye5Z12B8jQdvakMbKQKFmST2kYpcrYvPw50F8=;
        h=From:To:Cc:Subject:Date;
        b=VIySccByrLNgVisnOZm1P7/vJ5DP7+J+E7U/QxhCEcJ2V0GGgR90aegu95/sXgcwm
         X8EaScXfDPllOryOlTDZTE+VUa225hFsvZ14euxCY3QYAjuoO61SI0Y8rSRGjN8hYA
         jMWYRg3ixBbvEdqLRNMAVccYVJP2B5W0SgoMUpuc=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 047B4471743;
        Sun, 25 Apr 2021 11:35:16 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id HRqoI057-yDn; Sun, 25 Apr 2021 11:35:15 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 856224716AA;
        Sun, 25 Apr 2021 11:35:15 +0300 (EEST)
Received: from localhost.localdomain (unknown [45.87.95.45])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 0A3131BE0DAF;
        Sun, 25 Apr 2021 11:35:13 +0300 (EEST)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs: remove comment for argument seed of btrfs_find_device
Date:   Sun, 25 Apr 2021 16:35:04 +0800
Message-Id: <20210425083504.5187-1-l@damenly.su>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBlzQh1+nQ3rcDQU2qyxVJY3o/+Kk2BpHlX7kNSuYHDsAUgzE7mEMLWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit b2598edf8b36 ("btrfs: remove unused argument seed from
btrfs_find_device") removed the argument seed from btrfs_find_device
but forgot the comment, so remove it.

Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/volumes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 77cdb75acc15..9ee17b2ff621 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6669,8 +6669,6 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
  *
  * If devid and uuid are both specified, the match must be exact, otherwise
  * only devid is used.
- *
- * If @seed is true, traverse through the seed devices.
  */
 struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
 				       u64 devid, u8 *uuid, u8 *fsid)
-- 
2.30.1

