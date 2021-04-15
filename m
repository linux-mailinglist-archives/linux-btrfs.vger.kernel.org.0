Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13F336016B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhDOFGK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhDOFGJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKovzE/xL65ScMiWjdS3QtGzrHlspugPr+Bblv33Lgs=;
        b=oAmlhp1s42+NcZr47t9Ulp51v0+6iWgDOShMLuzdSUekZX2v2ev1N73qeikeirjAnyUb1d
        6XaXeN51zl0uqoQMg1zo1Z+RgD/qIa3teqTfrxgyxzVClQiW6MseKuP3r2O00AEni753Zc
        /TkZ5GLqhBZPXY1UdI0e5WjzUjg7Bvk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF30CAF03
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 28/42] btrfs: add extra assert for submit_extent_page()
Date:   Thu, 15 Apr 2021 13:04:34 +0800
Message-Id: <20210415050448.267306-29-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are already bugs exposed in __extent_writepage_io() where due to
wrong alignment and lack of support for subpage, we can pass insane
pg_offset into submit_extent_page().

Add basic size check to ensure the combination of @size and @pg_offset
is sane.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index be825b73ee43..ae6357a6749e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3261,6 +3261,8 @@ static int submit_extent_page(unsigned int opf,
 
 	ASSERT(bio_ret);
 
+	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
+	       pg_offset + size <= PAGE_SIZE);
 	if (*bio_ret) {
 		bio = *bio_ret;
 		if (force_bio_submit ||
-- 
2.31.1

