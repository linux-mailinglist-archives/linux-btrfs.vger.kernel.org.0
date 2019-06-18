Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C50E449BBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 10:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfFRIJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 04:09:17 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:60630 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfFRIJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 04:09:17 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 3ED58142BC3; Tue, 18 Jun 2019 09:09:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1560845355;
        bh=k4ssHs1D68Qvv4GmcGNTf1E1Pt+GKU6QeG/HiyX4g1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXoyjmRREEfGyiTuzP6BIs2FUcj8yOWLZkk97vxN9mR7Dnq245QXNAl/S/i559orH
         TsWFEi1YHB/ELesxD2xmEDjsESFPGO8E6hZkmxA1kK2wOJlUJ+xMp1DxKsQ8bTNKa+
         1VexroQxtSV+YsXd0h1LeJOaxWtFedrF1l34EeIlpLo8pxWQTVyWAyDs4Ged9/ICij
         f1VBL4oQns4NMxq8HVrPk2RH0eY1b2tzn1fA3MXqH4SLi07Sbnzy5MpAVsROHDS8+h
         2QRq2f0Zt1naU2PMeoCArzghznHjQ81rxyLR/AfdNO+O2mVgVhPWB66Y1u/SGb1mzR
         9p2jhh5VNNhgQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id D14C2142BC1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 09:09:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1560845354;
        bh=k4ssHs1D68Qvv4GmcGNTf1E1Pt+GKU6QeG/HiyX4g1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xqUiThBFF9MOUnH2sKbQIDkm8bfeLOTgYTi8uYg8ITY2AVdxewJsgGEh3WaKIa2hI
         dvNUqsQxB4ge2rae8L5mi5+dHNZ0ym8ujtJ8a7eMShTSh/MjLycbAN4loYM2w0ynMR
         POE03Q3c6EIliyAjseJzpZ4b5qoI7YkfIf7j9Sck4F7IQHjnR6iBkzUFkddPkiaLwz
         k2FWM1mAPIeQdCTdxAqajylN0tRmf3Rdf5B7M3PomwNoKOrSh35RnK+T5UIobQsPSX
         QRxwW8d6SPMqGXb6YplorB4ZXlcYEHXJNRVr8mFGT3C5uJH1J17hRO0uzvb4bMlBaq
         FLOdFTJkeEsrw==
Received: by black.home.cobb.me.uk (Postfix, from userid 500)
        id AA2692B6339; Tue, 18 Jun 2019 09:09:14 +0100 (BST)
From:   "Graham R. Cobb" <g.btrfs@cobb.uk.net>
To:     linux-btrfs@vger.kernel.org
Cc:     "Graham R. Cobb" <g.btrfs@cobb.uk.net>
Subject: [PATCH] btrfs-progs: scrub: Fix scrub cancel/resume not to skip most of the disk
Date:   Tue, 18 Jun 2019 09:08:25 +0100
Message-Id: <20190618080825.15336-1-g.btrfs@cobb.uk.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2c415510-8d46-065d-6b38-b8514a8ffcc1@cobb.uk.net>
References: <2c415510-8d46-065d-6b38-b8514a8ffcc1@cobb.uk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a scrub completes or is cancelled, statistics are updated for reporting
in a later btrfs scrub status command and for resuming the scrub. Most
statistics (such as bytes scrubbed) are additive so scrub adds the statistics
from the current run to the saved statistics.

However, the last_physical statistic is not additive. The value from the
current run should replace the saved value. The current code incorrectly
adds the last_physical from the current run to the previous saved value.

This bug causes the resume point to be incorrectly recorded, so large areas
of the disk are skipped when the scrub resumes. As an example, assume a disk
had 1000000 bytes and scrub was cancelled and resumed each time 10% (100000
bytes) had been scrubbed.

Run | Start byte | bytes scrubbed | kernel last_physical | saved last_physical
  1 |          0 |         100000 |               100000 |              100000
  2 |     100000 |         100000 |               200000 |              300000
  3 |     300000 |         100000 |               400000 |              700000
  4 |     700000 |         100000 |               800000 |             1500000
  5 |    1500000 |              0 | immediately completes| completed

In this example, only 40% of the disk is actually scrubbed.

This patch changes the saved/displayed last_physical to track the last
reported value from the kernel.

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

