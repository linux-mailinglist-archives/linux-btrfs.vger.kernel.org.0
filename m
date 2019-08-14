Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6298C564
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfHNBEP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:04:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:41220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfHNBEP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:04:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BA03AF94
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2019 01:04:14 +0000 (UTC)
Received: from starscream.home.jeffm.io (starscream-1.home.jeffm.io [192.168.1.254])
        by mail.home.jeffm.io (Postfix) with ESMTPS id 037AA82D1622;
        Tue, 13 Aug 2019 22:05:08 -0400 (EDT)
Received: by starscream.home.jeffm.io (Postfix, from userid 1000)
        id 982166093CB; Tue, 13 Aug 2019 21:04:11 -0400 (EDT)
From:   Jeff Mahoney <jeffm@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 3/5] btrfs-progs: qgroups: use parse_size instead of open coding it
Date:   Tue, 13 Aug 2019 21:04:00 -0400
Message-Id: <20190814010402.22546-3-jeffm@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190814010402.22546-1-jeffm@suse.com>
References: <20190814010402.22546-1-jeffm@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The only difference between parse_limit and parse_size is that
parse_limit accepts "none" as a valid input.  That's easy enough
to handle as a special case and lets us drop the duplicate code.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 cmds/qgroup.c | 58 ++++------------------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 59b43c98..ba81052a 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -159,56 +159,6 @@ static int _cmd_qgroup_create(int create, int argc, char **argv)
 	return 0;
 }
 
-static int parse_limit(const char *p, unsigned long long *s)
-{
-	char *endptr;
-	unsigned long long size;
-	unsigned long long CLEAR_VALUE = -1;
-
-	if (strcasecmp(p, "none") == 0) {
-		*s = CLEAR_VALUE;
-		return 1;
-	}
-
-	if (p[0] == '-')
-		return 0;
-
-	size = strtoull(p, &endptr, 10);
-	if (p == endptr)
-		return 0;
-
-	switch (*endptr) {
-	case 'T':
-	case 't':
-		size *= 1024;
-		/* fallthrough */
-	case 'G':
-	case 'g':
-		size *= 1024;
-		/* fallthrough */
-	case 'M':
-	case 'm':
-		size *= 1024;
-		/* fallthrough */
-	case 'K':
-	case 'k':
-		size *= 1024;
-		++endptr;
-		break;
-	case 0:
-		break;
-	default:
-		return 0;
-	}
-
-	if (*endptr)
-		return 0;
-
-	*s = size;
-
-	return 1;
-}
-
 static const char * const cmd_qgroup_assign_usage[] = {
 	"btrfs qgroup assign [options] <src> <dst> <path>",
 	"Assign SRC as the child qgroup of DST",
@@ -455,10 +405,10 @@ static int cmd_qgroup_limit(const struct cmd_struct *cmd, int argc, char **argv)
 	if (check_argc_min(argc - optind, 2))
 		return 1;
 
-	if (!parse_limit(argv[optind], &size)) {
-		error("invalid size argument: %s", argv[optind]);
-		return 1;
-	}
+	if (!strcasecmp(argv[optind], "none"))
+		size = -1ULL;
+	else
+		size = parse_size(argv[optind]);
 
 	memset(&args, 0, sizeof(args));
 	if (compressed)
-- 
2.16.4

