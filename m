Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490262B1B6E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKMMxF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:53:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:47738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgKMMxE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:53:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8k20t7tHN7KpKJipPdQeJRO5qYow1600AEUa9/iEiw=;
        b=FFpc0I1MpxrSwFdyQWsRAETfSSjVdebRzkZujljMRxB8bG61O4xESkZSakvkBcfSgEA03H
        60snY2le/1/43QaKH+7345+V8zB+iYLktj9hRGU4+2J8St/ZIvpN6C3GRke5srmAmei7Gn
        ncc4PK9rzLQSPdcPZvMNbKwVBbIbjLE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DD86AC54
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:53:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 19/24] btrfs: scrub: remove the anonymous structure from scrub_page
Date:   Fri, 13 Nov 2020 20:51:44 +0800
Message-Id: <20201113125149.140836-20-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

That anonymous structure serve no special purpose, just replace it with
regular members.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 57ee06d92150..06f6428b97d1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -71,11 +71,9 @@ struct scrub_page {
 	u64			physical;
 	u64			physical_for_dev_replace;
 	atomic_t		refs;
-	struct {
-		unsigned int	mirror_num:8;
-		unsigned int	have_csum:1;
-		unsigned int	io_error:1;
-	};
+	u8			mirror_num;
+	int			have_csum:1;
+	int			io_error:1;
 	u8			csum[BTRFS_CSUM_SIZE];
 
 	struct scrub_recover	*recover;
-- 
2.29.2

