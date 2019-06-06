Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C58137270
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfFFLGf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:06:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727669AbfFFLGf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:06:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BC3CAE54
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 11:06:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs-progs: image: Fix a access-beyond-boundary bug when there are 32 online CPUs
Date:   Thu,  6 Jun 2019 19:06:05 +0800
Message-Id: <20190606110611.27176-4-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110611.27176-1-wqu@suse.com>
References: <20190606110611.27176-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When there are over 32 (in my example, 35) online CPUs, btrfs-image -c9
will just hang.

[CAUSE]
Btrfs-image has a hard coded limit (32) on how many threads we can use.
For the "-t" option we do the up limit check.

But when we don't specify "-t" option and speicified "-c" option, then
btrfs-image will try to auto detect the number of online CPUs, and use
it without checking if it's over the up limit.

And for num_threads larger than the up limit, we will over write the
adjust members of metadump_struct/mdrestore_struct, corrupting
pthread_mutex_t and pthread_cond_t, causing synchronising problem.

Nowadays, with SMT/HT and higher cpu core counts, it's not hard to go
beyond 32 threads, and hit the bug.

[FIX]
Just do extra num_threads check before using the number from sysconf().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/image/main.c b/image/main.c
index fb9fc48c..80f09c21 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2758,6 +2758,7 @@ int main(int argc, char *argv[])
 
 			if (tmp <= 0)
 				tmp = 1;
+			tmp = min_t(long, tmp, MAX_WORKER_THREADS);
 			num_threads = tmp;
 		}
 	} else {
-- 
2.21.0

