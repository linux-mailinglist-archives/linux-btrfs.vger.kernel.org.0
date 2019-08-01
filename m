Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2D7DBE9
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 14:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfHAMuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 08:50:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfHAMuA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 08:50:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 205F6AF1D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2019 12:49:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 63EA7DA7D9; Thu,  1 Aug 2019 14:50:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrsf: async-thread: convert defines to enums
Date:   Thu,  1 Aug 2019 14:50:33 +0200
Message-Id: <c08ca39051113680ea5801bc137cb1fa634246e3.1564663765.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564663765.git.dsterba@suse.com>
References: <cover.1564663765.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/async-thread.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 122cb97c7909..2e9e13ffbd08 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -12,9 +12,11 @@
 #include "async-thread.h"
 #include "ctree.h"
 
-#define WORK_DONE_BIT 0
-#define WORK_ORDER_DONE_BIT 1
-#define WORK_HIGH_PRIO_BIT 2
+enum {
+	WORK_DONE_BIT,
+	WORK_ORDER_DONE_BIT,
+	WORK_HIGH_PRIO_BIT,
+};
 
 #define NO_THRESHOLD (-1)
 #define DFT_THRESHOLD (32)
-- 
2.22.0

