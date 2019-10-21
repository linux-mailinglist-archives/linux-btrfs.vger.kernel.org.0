Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2DE4DE843
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfJUJiF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 05:38:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:37920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfJUJiE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 05:38:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 008A9B777
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 09:38:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: utils-lib: Use error() to replace fprintf(stderr, "ERROR: ")
Date:   Mon, 21 Oct 2019 17:37:53 +0800
Message-Id: <20191021093755.56835-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021093755.56835-1-wqu@suse.com>
References: <20191021093755.56835-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This saves several lines of code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 utils-lib.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/utils-lib.c b/utils-lib.c
index c2b6097f5df9..0202dd7677f0 100644
--- a/utils-lib.c
+++ b/utils-lib.c
@@ -23,8 +23,7 @@ u64 arg_strtou64(const char *str)
 
 	value = strtoull(str, &ptr_parse_end, 0);
 	if (ptr_parse_end && *ptr_parse_end != '\0') {
-		fprintf(stderr, "ERROR: %s is not a valid numeric value.\n",
-			str);
+		error("%s is not a valid numeric value.", str);
 		exit(1);
 	}
 
@@ -33,12 +32,11 @@ u64 arg_strtou64(const char *str)
 	 * unexpected number to us, so let's do the check ourselves.
 	 */
 	if (str[0] == '-') {
-		fprintf(stderr, "ERROR: %s: negative value is invalid.\n",
-			str);
+		error("%s: negative value is invalid.", str);
 		exit(1);
 	}
 	if (value == ULLONG_MAX) {
-		fprintf(stderr, "ERROR: %s is too large.\n", str);
+		error("%s is too large.", str);
 		exit(1);
 	}
 	return value;
-- 
2.23.0

