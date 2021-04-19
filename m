Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D23364253
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 15:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhDSNGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 09:06:33 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:48030 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhDSNGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 09:06:33 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 8B49E475C73;
        Mon, 19 Apr 2021 16:06:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1618837562; bh=cWMzAQ5Gplr4fORFiFUaA13/Kfla0oUFpcy46NS7B00=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=JKfzKi/4H6uEVgBsDTGyLy6DjP1b+pfWwTY5Dz9vqSYCzqMgC30IqUsq16qq2FNzz
         TTjG8h0y2onhOSzwldQEAjZOax4n0B6xoZnCVAJaLhCal78/3gqfSKjL3Szm7yoOIf
         9c1aw5YmdsG+RbhYko8RCZZgow0p9yXbfS/pxbfY=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 7C748475B9C;
        Mon, 19 Apr 2021 16:06:02 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id QdgCDWt0DO3f; Mon, 19 Apr 2021 16:06:02 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 14124475AC6;
        Mon, 19 Apr 2021 16:06:02 +0300 (EEST)
Received: from localhost.localdomain (unknown [45.87.95.33])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 246AF1BE00EF;
        Mon, 19 Apr 2021 16:05:59 +0300 (EEST)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su, Chris Murphy <lists@colorremedies.com>
Subject: [PATCH v2] btrfs-progs: fi resize: fix false 0.00B sized output
Date:   Mon, 19 Apr 2021 21:05:49 +0800
Message-Id: <20210419130549.148685-1-l@damenly.su>
X-Mailer: git-send-email 2.30.1
Reply-To: 20210419124541.148269-1-l@damenly.su
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: +d1m7upSeEqpi1ihQnnWBgczqTYrL+Dm557a3RlcgnP9LyeBYEsOTGPJkCwpDWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Resize to nums without sign prefix makes false output:
 btrfs fi resize 1:150g /srv/extra
Resize device id 1 (/dev/sdb1) from 298.09GiB to 0.00B

The resize operation would take effect though.

Fix it by handling the case if mod is 0 in check_resize_args().

Issue: #307
Reported-by: Chris Murphy <lists@colorremedies.com>
Signed-off-by: Su Yue <l@damenly.su>
---
 cmds/filesystem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

---
Changelog:
    v2:
        Calculate u64 diff using max() and min().
        Calculate mod by comparing new and old size.
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 9e3cce687d6e..54d46470c53f 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1158,6 +1158,16 @@ static int check_resize_args(const char *amount, const char *path) {
 		}
 		old_size = di_args[dev_idx].total_bytes;
 
+		/* For target sizes without '+'/'-' sign prefix(e.g. 1:150g) */
+		if (mod == 0) {
+			new_size = diff;
+			diff = max(old_size, new_size) - min(old_size, new_size);
+			if (new_size > old_size)
+				mod = 1;
+			else if (new_size < old_size)
+				mod = -1;
+		}
+
 		if (mod < 0) {
 			if (diff > old_size) {
 				error("current size is %s which is smaller than %s",
-- 
2.30.1

