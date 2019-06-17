Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843B647BC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFQH7o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 03:59:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbfFQH7n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 03:59:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9CC4AE89
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2019 07:59:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: constify extent buffer reader
Date:   Mon, 17 Jun 2019 15:59:33 +0800
Message-Id: <20190617075936.12113-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617075936.12113-1-wqu@suse.com>
References: <20190617075936.12113-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add const prefix for the following parameters:
- @eb of memcmp_extent_buffer()
- @eb of read_extent_buffer()

This backports kernel commit 1cbb1f454e53 ("btrfs: struct-funcs,
constify readers") to btrfs-progs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent_io.c | 4 ++--
 extent_io.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/extent_io.c b/extent_io.c
index c57f62829bf7..a9ceff5111fb 100644
--- a/extent_io.c
+++ b/extent_io.c
@@ -963,13 +963,13 @@ int clear_extent_buffer_dirty(struct extent_buffer *eb)
 	return 0;
 }
 
-int memcmp_extent_buffer(struct extent_buffer *eb, const void *ptrv,
+int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len)
 {
 	return memcmp(eb->data + start, ptrv, len);
 }
 
-void read_extent_buffer(struct extent_buffer *eb, void *dst,
+void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start, unsigned long len)
 {
 	memcpy(dst, eb->data + start, len);
diff --git a/extent_io.h b/extent_io.h
index 9587528bbefb..874cbca1d436 100644
--- a/extent_io.h
+++ b/extent_io.h
@@ -154,9 +154,9 @@ void free_extent_buffer_nocache(struct extent_buffer *eb);
 int read_extent_from_disk(struct extent_buffer *eb,
 			  unsigned long offset, unsigned long len);
 int write_extent_to_disk(struct extent_buffer *eb);
-int memcmp_extent_buffer(struct extent_buffer *eb, const void *ptrv,
+int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len);
-void read_extent_buffer(struct extent_buffer *eb, void *dst,
+void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start, unsigned long len);
 void write_extent_buffer(struct extent_buffer *eb, const void *src,
 			 unsigned long start, unsigned long len);
-- 
2.22.0

