Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DEB29481F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440708AbgJUG0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:42516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440706AbgJUG0J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkscHhzEETPJWamFzUduOECkO2dzdk7UoVoARX8lg0Q=;
        b=PFMECzF/FJT3UL0KCYpdkwC7X2vM0vhgGlYkUDcZ/voCKstIpK2js1Pp+KgFUPrT/22oFw
        hE48j2XMiLgeASs8HOAah5kHy0WRy6uLyGWKZQjF9q7lA4I/GiCzwdHWbaa4BcgERhLUJa
        Fs/EJRFZMzdiN5bLKTD+QVaiMkK2xzw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61CFAAC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 03/68] btrfs: extent_io: fix the comment on lock_extent_buffer_for_io().
Date:   Wed, 21 Oct 2020 14:24:49 +0800
Message-Id: <20201021062554.68132-4-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The return value of that function is completely wrong.

That function only return 0 if the the extent buffer doesn't need to be
submitted.
The "ret = 1" and "ret = 0" are determined by the return value of
"test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)".

And if we get ret == 1, it's because the extent buffer is dirty, and we
set its status to EXTENT_BUFFER_WRITE_BACK, and continue to page
locking.

While if we get ret == 0, it means the extent is not dirty from the
beginning, so we don't need to write it back.

The caller also follows this, in btree_write_cache_pages(), if
lock_extent_buffer_for_io() return 0, we just skip the extent buffer
completely.

So the comment is completely wrong.

Since we're here, also change the description a little.
The write bio flushing won't be visible to the caller, thus it's not an
major feature.
In the main decription, only describe the locking part to make the point
more clear.

Fixes: 2e3c25136adf ("btrfs: extent_io: add proper error handling to lock_extent_buffer_for_io()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 64f7f61ce718..a64d88163f3b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3688,11 +3688,14 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
 }
 
 /*
- * Lock eb pages and flush the bio if we can't the locks
+ * Lock extent buffer status and pages for write back.
  *
- * Return  0 if nothing went wrong
- * Return >0 is same as 0, except bio is not submitted
- * Return <0 if something went wrong, no page is locked
+ * May try to flush write bio if we can't get the lock.
+ *
+ * Return  0 if the extent buffer doesn't need to be submitted.
+ * (E.g. the extent buffer is not dirty)
+ * Return >0 is the extent buffer is submitted to bio.
+ * Return <0 if something went wrong, no page is locked.
  */
 static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb,
 			  struct extent_page_data *epd)
-- 
2.28.0

