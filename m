Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599383074BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 12:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhA1L0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 06:26:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:45008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhA1L0A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 06:26:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611833115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=eQGlSRyaEMRdtBVY1c3K5gcwNslBozaOdnYycrhpS2I=;
        b=pY18G+7q91Z3epYgM9cwNm18EZVkzv0RgCtQIEWswlUXD0PV2lP7lORlacAztrmRyeKNcY
        kJ8fHSqBeh5d1WRabuFJeQOVqtN0ql5zB4Q3mGEp7vN2nsvXs9q+jrld0NGwN+Ua+vnEDm
        Uv6QXZYX5Kqg1poJNtQW5i36jypXfDA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08DF8B080;
        Thu, 28 Jan 2021 11:25:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] btrfs: add comment on why we can return 0 if we failed to atomically lock the page in read_extent_buffer_pages()
Date:   Thu, 28 Jan 2021 19:25:08 +0800
Message-Id: <20210128112508.123614-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In read_extent_buffer_pages(), if we failed to lock the page atomically,
we just exit with return value 0.

This is pretty counter-intuitive, as normally if we can't lock what we
need, we would return something like -EAGAIN.

But the that return hides under (wait == WAIT_NONE) branch, which only
get triggered for readahead.

And for readahead, if we failed to lock the page, it means the extent
buffer is either being read by other thread, or has been read and is
under modification.
Either way the eb will or has been cached, thus readahead has no need to
wait for it.

This patch will add extra comment on this counter-intuitive behavior.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7f689ad7709c..038adc423454 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5577,6 +5577,13 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 		if (wait == WAIT_NONE) {
+			/*
+			 * WAIT_NONE is only utilized by readahead. If we can't
+			 * acquire the lock atomically it means either the eb
+			 * is being read out or under modification.
+			 * Either way the eb will be or has been cached,
+			 * readahead can exit safely.
+			 */
 			if (!trylock_page(page))
 				goto unlock_exit;
 		} else {
-- 
2.30.0

