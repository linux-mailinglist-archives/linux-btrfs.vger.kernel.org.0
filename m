Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430F6495CE1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 10:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379756AbiAUJel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 04:34:41 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:34450 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379755AbiAUJei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 04:34:38 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id BEDE56C00730;
        Fri, 21 Jan 2022 11:34:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1642757677; bh=VypXQJgTZaJ0zm7DZcIqaOAe0qXLyVUWtII0Ml1j6Wk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-ESPOL:from:date:to:cc;
        b=D2ki1w1oqIK+kWmIjrkz8tXenAJxLe8n2DduogtSeV3h6slojNWqMzeebynure/U3
         BDDdnDuXBiIMhbVuETQONstvTWCK5XTtj6ZlXZpXHroHqkgOYR04AX4iWV+XOVAccP
         P1PiSvEIWuEDGHp8Y1KHN2yBF4xZB+48Kpia8UDQ=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id B4CB56C00700;
        Fri, 21 Jan 2022 11:34:37 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 3ziN10oDNEEC; Fri, 21 Jan 2022 11:34:37 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 8675F6C0069A;
        Fri, 21 Jan 2022 11:34:37 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs-progs: make generic_err print physical address of extent buffer
Date:   Fri, 21 Jan 2022 17:34:29 +0800
Message-Id: <20220121093429.1840437-1-l@damenly.su>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: +d1m7upSY16pi16iXXraBxg2qytXXu3h54XO3RxfnHr4OS2Fek4RMmO6n3AFM3H44X8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike kernel, we have cached physical address of extent_buffer in
dev_bytenr. Print it for better debug experience.

Signed-off-by: Su Yue <l@damenly.su>
---
 kernel-shared/ctree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 21e5414965e7..950923d03165 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -590,9 +590,10 @@ static void generic_err(const struct extent_buffer *buf, int slot,
 {
 	va_list args;
 
-	fprintf(stderr, "corrupt %s: root=%lld block=%llu slot=%d, ",
+	fprintf(stderr, "corrupt %s: root=%lld block=%llu physical=%llu slot=%d, ",
 		btrfs_header_level(buf) == 0 ? "leaf": "node",
-		btrfs_header_owner(buf), btrfs_header_bytenr(buf), slot);
+		btrfs_header_owner(buf), btrfs_header_bytenr(buf),
+		buf->dev_bytenr, slot);
 	va_start(args, fmt);
 	vfprintf(stderr, fmt, args);
 	va_end(args);
-- 
2.34.1

