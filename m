Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA85E3651AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 06:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhDTE7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 00:59:11 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:54276 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhDTE7L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 00:59:11 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id AA5F8471D54;
        Tue, 20 Apr 2021 07:58:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1618894718; bh=Zztl01tReI0XCvZgAFF1lESc19Tfa0DkZfzxZ+KCRsk=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=BjPIm4F+JtgGABQRTwQrhh4UVCd6/x3qLLAdUXBgchLFsC5WpMqNwXhGtXP9MS2pZ
         lGTFF+sq/j0IpKG+EsAHA74z3ZNUKy8Nwh/HS3sT5yfgPmSuK53MaT086FLIcKjY7o
         qVbVsWsz4ghlxQUlZbeILFFbPVk4j1KhkoKTr6Vs=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 99251471D52;
        Tue, 20 Apr 2021 07:58:38 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id mKEWnUjhULD7; Tue, 20 Apr 2021 07:58:38 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 3CF7C471D57;
        Tue, 20 Apr 2021 07:58:38 +0300 (EEST)
Received: from localhost.localdomain (unknown [45.87.95.33])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id D422B1BE00BD;
        Tue, 20 Apr 2021 07:58:35 +0300 (EEST)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su, boris@bur.io, Chris Murphy <lists@colorremedies.com>
Subject: [PATCH v3] btrfs-progs: fi resize: fix false 0.00B sized output
Date:   Tue, 20 Apr 2021 12:58:27 +0800
Message-Id: <20210420045827.150881-1-l@damenly.su>
X-Mailer: git-send-email 2.30.1
Reply-To: 20210419124541.148269-1-l@damenly.su
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetdgtNzzYrL+Dh55TE3V0G3GeDUSOAe1YFVw6+mHJ1TmA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Resize to nums without sign prefix makes false output:
 btrfs fi resize 1:150g /srv/extra
Resize device id 1 (/dev/sdb1) from 298.09GiB to 0.00B

The resize operation would take effect though.

check_resize_args() does not handle the mod 0 case and new_size is 0.
Simply assigning @diff to @new_size to fix this.

Issue: #307
Reported-by: Chris Murphy <lists@colorremedies.com>
Signed-off-by: Su Yue <l@damenly.su>
---
Changelog:
v3:
  Just assign @diff to @new_size. (Boris Burkov)
v2:
  Calculate u64 diff using max() and min().
  Calculate mod by comparing new and old size.
---
 cmds/filesystem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 9e3cce687d6e..b4c09768235c 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1158,7 +1158,10 @@ static int check_resize_args(const char *amount, const char *path) {
 		}
 		old_size = di_args[dev_idx].total_bytes;
 
-		if (mod < 0) {
+		/* For target sizes without '+'/'-' sign prefix(e.g. 1:150g) */
+		if (mod == 0) {
+			new_size = diff;
+		} else if (mod < 0) {
 			if (diff > old_size) {
 				error("current size is %s which is smaller than %s",
 				      pretty_size_mode(old_size, UNITS_DEFAULT),
-- 
2.30.1

