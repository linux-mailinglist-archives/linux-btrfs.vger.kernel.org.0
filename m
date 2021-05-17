Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C20383A01
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbhEQQfY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243401AbhEQQfA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 12:35:00 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DBDC014CC4
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 08:26:42 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a2so6083070qkh.11
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6VOiEwqlqf1B2NotAwVhyyIDAI7o/4k/zIBjRu0gGg=;
        b=lTCk/1No/YFlSIH7i6DrDXPUht9VgkRIo2WLpvCv89ig38GDYtVxZPsOVySBCjBsWm
         Dpk/fEJ39I0eBakQ/DmuGninwp2QmKQ2a3qR9DH4AaLvQ1E6KVncHD8qwNuRwOETqDxu
         KaG/bk3IKho8j6XKV4PyV1lDHc/uMqX7dQm3i4jdCSduvlfrXf8JErjP88+fBxRzcRRu
         TPqxZlZyaeK8j5fvKQcgTGsPSIobRB5QHH4GRhlMc97BtbNsZ0wFDfmHg0PPoLJIITp8
         0Rnwg9rX3hBx9b3oyc5K1CxbDbMZNq9zzlDN0FgnlrWS9wHR1yOrpEmBAvTAp9qm04mn
         GLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6VOiEwqlqf1B2NotAwVhyyIDAI7o/4k/zIBjRu0gGg=;
        b=O5PPKL/d1njC+H09CosfgxMpjDS9mEE4L8aTZ4VbiPgD9IdpCh8PPn+S8qiPs38g+a
         kZDehI43FMjGb39CCPElMdrA+V6IYaoB74SD+K0Z5N0B1Tn5nWEaUkyhdJ+5urDtmFOq
         tSJFQlK7sQ44sFws0o4c5tjJAxzu99rqUMLofso2tF7/eUfatMlb0nyfYB35ejUpKLIS
         H52zjUunsuNAdocMZZY7cHYJe7W73sTz920tzrRJy0Lmn9lHaLZsaqo+mvPpzRQBUaLC
         Rsr3oWTMhtkivUt5GJnWAfXa0nnT9hM2HVpSoiuxzZx0D9oU8ZITd4sSXo2voB5320Lo
         I69w==
X-Gm-Message-State: AOAM533MWyYPqLBfLKz/3YnL8ih6vTmOVpIUSHepjG0XV+g0rKD8/+QM
        WsIzkyX4kX6oMVzEJsyzomAbc9i2VJ3yRg==
X-Google-Smtp-Source: ABdhPJwUeovXeLR83kH8UxV+VGkco33Ty7KDnIPMethsQl1Fi9EY9B8miT8q0YD4myseFJ083+ltfg==
X-Received: by 2002:a37:a8cb:: with SMTP id r194mr344031qke.349.1621265201141;
        Mon, 17 May 2021 08:26:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j30sm1180415qki.60.2021.05.17.08.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:26:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: mark ordered extent and inode with error if we fail to finish
Date:   Mon, 17 May 2021 11:26:39 -0400
Message-Id: <72c99ae5a88109487565b0ce156cb323e94aa371.1621265174.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While doing error injection testing I saw that sometimes we'd get an
abort that wouldn't stop the current transaction commit from completing.
This abort was coming from finish ordered IO, but at this point in the
transaction commit we should have gotten an error and stopped.

It turns out the abort came from finish ordered io while trying to write
out the free space cache.  It occurred to me that any failure inside of
finish_ordered_io isn't actually raised to the person doing the writing,
so we could have any number of failures in this path and think the
ordered extent completed successfully and the inode was fine.

Fix this by marking the ordered extent with BTRFS_ORDERED_IOERR, and
marking the mapping of the inode with mapping_set_error, so any callers
that simply call fdatawait will also get the error.

With this we're seeing the IO error on the free space inode when we fail
to do the finish_ordered_io.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 955d0f5849e3..b5459239ae81 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3000,6 +3000,17 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	if (ret || truncated) {
 		u64 unwritten_start = start;
 
+		/*
+		 * If we failed to finish this ordered extent for any reason we
+		 * need to make sure BTRFS_ORDERED_IOERR is set on the ordered
+		 * extent, and mark the inode with the error.
+		 */
+		if (ret) {
+			set_bit(BTRFS_ORDERED_IOERR, &ordered_extent->flags);
+			mapping_set_error(ordered_extent->inode->i_mapping,
+					  -EIO);
+		}
+
 		if (truncated)
 			unwritten_start += logical_len;
 		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
-- 
2.26.3

