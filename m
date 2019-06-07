Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77735399D1
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2019 02:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfFHAC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 20:02:56 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:50066 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbfFHAC4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jun 2019 20:02:56 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 20:02:54 EDT
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 254AC142BC3; Sat,  8 Jun 2019 00:55:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1559951708;
        bh=JNhzxjGa8dRyya8eZ43uL4tqHZtAMYvNCLTySye40m8=;
        h=From:To:Cc:Subject:Date:From;
        b=s2AXQ5l31d15pPI661AumeEVeVH8ErN6Qvdt1c2yjCynpfXo6Q5xQJePiLzim+fLy
         jhhyh00jB8pf2OAAwFRpfcLusxkKoZ+KzeqHfqlC/MW1uMjQbzbHn3UIJPLmAUJONM
         0PXSwoymUMRWSjxS9pIscwEgYGTPLCSpixy5PgWt2UvhK5i3wW0Hhy3Hd0F6Aa2i80
         aqacc2alJz5R+ZovFbhvtg7xsGrcouYs4MuEhXbDoPMXUqXTCqof3nGChq+av3Vj0c
         4/QLNz/iGU8KclI8x/y29G4/x1IecBIYdh9kpA/JjAT99FdFZCumW11UGbvOdt3xQp
         UouyGB3J7zT/Q==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id C6801142BC2
        for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2019 00:55:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1559951707;
        bh=JNhzxjGa8dRyya8eZ43uL4tqHZtAMYvNCLTySye40m8=;
        h=From:To:Cc:Subject:Date:From;
        b=EjKr24BWiv0a9tA3dyag3YF6QTcWIKRbHvVrP+pi/cOwjQf/Lenw7LixlqvhXm6wr
         oI9L3cb8nbnsf5jCg1i3NgsSjYt617VQtBQdb/BUKutsQWCBw9+14e/Tg1514ASmK8
         SA3NhAz8MwaNra8zzRBAqJztPVsmRT+wj1JxV0anEj55pmAGoLRz9s33yIa/7aX+5E
         dumqhEhnVECW+bcp97U/5HBoTcnTUHKYBeKX7e+5/AAbfoXkHrs5+ybALV0yTaXNpt
         fockQwR3PqZSMSUL4S8blJdWb0Uus0di/TBFJeaeP19OTIYSTs4UyAlvqrxFnDcb5f
         V+fnwuh6BUtTQ==
Received: by black.home.cobb.me.uk (Postfix, from userid 500)
        id ABD626B288; Sat,  8 Jun 2019 00:55:07 +0100 (BST)
From:   "Graham R. Cobb" <g.btrfs@cobb.uk.net>
To:     linux-btrfs@vger.kernel.org
Cc:     "Graham R. Cobb" <g.btrfs@cobb.uk.net>
Subject: [PATCH RFC] btrfs-progs: scrub: Correct tracking of last_physical across scrub cancel/resume
Date:   Sat,  8 Jun 2019 00:55:01 +0100
Message-Id: <20190607235501.26637-1-g.btrfs@cobb.uk.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a scrub completes or is cancelled, statistics are updated for reporting
in a later btrfs scrub status command. Most statistics (such as bytes scrubbed)
are additive so scrub adds the statistics from the current run to the
saved statistics.

However, the last_physical statistic is not additive. The value from the
current run should replace the saved value. The current code incorrectly
adds the last_physical from the current run to the saved value.

This bug not only affects user status reporting but also has the effect that
subsequent resumes start from the wrong place and large amounts of the
filesystem are not scrubbed.

This patch changes the saved last_physical to track the last reported value
from the kernel.

Signed-off-by: Graham R. Cobb <g.btrfs@cobb.uk.net>
---
 cmds-scrub.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/cmds-scrub.c b/cmds-scrub.c
index f21d2d89..2800e796 100644
--- a/cmds-scrub.c
+++ b/cmds-scrub.c
@@ -171,6 +171,10 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p)
 	fs_stat->p.name += p->name;		\
 } while (0)
 
+#define _SCRUB_FS_STAT_COPY(p, name, fs_stat) do {	\
+	fs_stat->p.name = p->name;		\
+} while (0)
+
 #define _SCRUB_FS_STAT_MIN(ss, name, fs_stat)	\
 do {						\
 	if (fs_stat->s.name > ss->name) {	\
@@ -209,7 +213,7 @@ static void add_to_fs_stat(struct btrfs_scrub_progress *p,
 	_SCRUB_FS_STAT(p, malloc_errors, fs_stat);
 	_SCRUB_FS_STAT(p, uncorrectable_errors, fs_stat);
 	_SCRUB_FS_STAT(p, corrected_errors, fs_stat);
-	_SCRUB_FS_STAT(p, last_physical, fs_stat);
+	_SCRUB_FS_STAT_COPY(p, last_physical, fs_stat);
 	_SCRUB_FS_STAT_ZMIN(ss, t_start, fs_stat);
 	_SCRUB_FS_STAT_ZMIN(ss, t_resumed, fs_stat);
 	_SCRUB_FS_STAT_ZMAX(ss, duration, fs_stat);
@@ -683,6 +687,8 @@ static int scrub_writev(int fd, char *buf, int max, const char *fmt, ...)
 
 #define _SCRUB_SUM(dest, data, name) dest->scrub_args.progress.name =	\
 			data->resumed->p.name + data->scrub_args.progress.name
+#define _SCRUB_COPY(dest, data, name) dest->scrub_args.progress.name =	\
+			data->scrub_args.progress.name
 
 static struct scrub_progress *scrub_resumed_stats(struct scrub_progress *data,
 						  struct scrub_progress *dest)
@@ -703,7 +709,7 @@ static struct scrub_progress *scrub_resumed_stats(struct scrub_progress *data,
 	_SCRUB_SUM(dest, data, malloc_errors);
 	_SCRUB_SUM(dest, data, uncorrectable_errors);
 	_SCRUB_SUM(dest, data, corrected_errors);
-	_SCRUB_SUM(dest, data, last_physical);
+	_SCRUB_COPY(dest, data, last_physical);
 	dest->stats.canceled = data->stats.canceled;
 	dest->stats.finished = data->stats.finished;
 	dest->stats.t_resumed = data->stats.t_start;
-- 
2.20.1

