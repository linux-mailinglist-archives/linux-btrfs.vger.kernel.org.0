Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52920494E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 07:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgFWFsN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 01:48:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:59992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgFWFsN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 01:48:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB547AD39
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 05:48:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: Fix seemly wrong format overflow warning
Date:   Tue, 23 Jun 2020 13:48:04 +0800
Message-Id: <20200623054804.67175-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623054804.67175-1-wqu@suse.com>
References: <20200623054804.67175-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[WARNING]
When compiling btrfs-progs, the following warning pops up:
  In file included from /usr/include/stdio.h:867,
                   from ./kerncompat.h:22,
                   from common/fsfeatures.c:17:
  In function 'printf',
      inlined from 'process_features' at common/fsfeatures.c:192:4,
      inlined from 'btrfs_process_runtime_features' at common/fsfeatures.c:205:2:
  /usr/include/bits/stdio2.h:107:10: warning: '%s' directive argument is null [-Wformat-overflow=]
    107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This only occur with default make parameters. If compiling with D=1, the
warning just disappears.

The involved tool chain is:
- GCC 10.1.0

[CAUSE]
The offending code is:
  static void process_features(u64 flags, enum feature_source source)
  {
  ...
		if (flags & feat->flag) {
			printf("Turning ON incompat feature '%s': %s\n",
				feat->name, feat->desc);
		}
  ...
  }

Currently, there is no runtime/fs feature without a name nor
description.
So we shouldn't hit a feature with NULL as name nor description.

This looks like a bug in GCC though.

[WORKAROUND]
However can workaround it by doing an explicit check on feat->name and
feat->desc to teach GCC not to do a wrong warning.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index ae075daf..195a77c3 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -188,7 +188,7 @@ static void process_features(u64 flags, enum feature_source source)
 	for (i = 0; i < array_size; i++) {
 		const struct btrfs_feature *feat = get_feature(i, source);
 
-		if (flags & feat->flag) {
+		if (flags & feat->flag && feat->name && feat->desc) {
 			printf("Turning ON incompat feature '%s': %s\n",
 				feat->name, feat->desc);
 		}
-- 
2.27.0

