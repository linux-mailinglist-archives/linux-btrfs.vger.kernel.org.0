Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAFBB2171
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbfIMNyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 09:54:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38790 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388532AbfIMNyM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 09:54:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id o184so2902770wme.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 06:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kgdVMw5h460EQ6/gfZ/ZpJPXz2ZXK/fT2YP6yksApSE=;
        b=oeInUeAzcv4cxon8ojtV4FMn7w6CNjq2wCJjMOZ0k9LF9l4y9ismCZ/bGkGvhxlnKa
         29rypAPz8MvMxtDAI6NpOdeZ6u4Qd77OfUbKyNJjI3XtzGPm+CqWklXYNWKE8j2JWyE0
         1KxTkXjagZScO/bjh+qdkpPVhjXXWT43zFtwFD3kHr/pRzEYTIylsg537E9xtgjAnsaC
         bnl6cpZrbmQjAaqAKOs5XY5BBwXVA/GHfmN3ofJGs8LbVmJdoMZgeYiNNUiPmNiPLflc
         WazUwgTNSnrv672HnqLLaxU/0N17i+2SJgotezExIlJ3RhIgLOakNJdttUafKrD3WH4h
         7teg==
X-Gm-Message-State: APjAAAU0Kmo4u7rRX8T7rWFsWGWLi4phEUvoEyG70mF1wLw6zJjSRaYo
        vTt0IYll2s9IgqQwBl8COzw=
X-Google-Smtp-Source: APXvYqxl1rgik/6XrMmaqVkrwE5Gu5YKWxX1NC4Di60/Fq8lOZSOWt6wsdCjEbGpLVA4tbGBJV5m2g==
X-Received: by 2002:a1c:9d15:: with SMTP id g21mr3708991wme.96.1568382850432;
        Fri, 13 Sep 2019 06:54:10 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.66.0])
        by smtp.gmail.com with ESMTPSA id o12sm5398149wrm.23.2019.09.13.06.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Sep 2019 06:54:09 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] btrfs: extent_io read eb to dirty_metadata_bytes on ioerr
Date:   Fri, 13 Sep 2019 14:54:07 +0100
Message-Id: <20190913135407.99353-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before, if a eb failed to write out, we would end up triggering a
BUG_ON(). As of f4340622e0226 ("btrfs: extent_io: Move the BUG_ON() in
flush_write_bio() one level up"), we no longer BUG_ON(), so we should
make life consistent and add back the unwritten bytes to
dirty_metadata_bytes.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Filipe Manana <fdmanana@kernel.org>
---
 fs/btrfs/extent_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1ff438fd5bc2..b67133a23652 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3728,11 +3728,21 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
 static void set_btree_ioerr(struct page *page)
 {
 	struct extent_buffer *eb = (struct extent_buffer *)page->private;
+	struct btrfs_fs_info *fs_info;
 
 	SetPageError(page);
 	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
 		return;
 
+	/*
+	 * If we error out, we should add back the dirty_metadata_bytes
+	 * to make it consistent.
+	 */
+	fs_info = eb->fs_info;
+	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
+				 eb->len,
+				 fs_info->dirty_metadata_batch);
+
 	/*
 	 * If writeback for a btree extent that doesn't belong to a log tree
 	 * failed, increment the counter transaction->eb_write_errors.
-- 
2.17.1

