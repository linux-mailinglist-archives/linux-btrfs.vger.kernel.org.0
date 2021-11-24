Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBBE45CD09
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 20:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbhKXTTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 14:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbhKXTSd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 14:18:33 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96646C061756
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 11:14:33 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f20so3753495qtb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 11:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XrmlgMYx9RqElUbssPucIFCPw3hERWs53HV8oJ9nzOw=;
        b=M9ReCxMSs5cMkPtKKkE0hX478zYEMCxc25+FwKWu8f8EB/LX1xlEz9jgWh1b4YApAP
         40YyYiHolF9HEFJ6TQ6XyCK9FVlZ8aaa+TpRNinQyKlF7FHA9fI9eG3AOQ25O/tJj9w5
         P3eI3xmYOTtQXoOarYVhweUS5RSYGcLTy41WecZtVKz3kOLdiPFmi1j+l0RIel+h3Y+q
         n5dYDDK8v8/uw1c6NabZnLBq2pIOTaMELpoyBFiTk1HUfuLJ0r1f9oMzosTlVR57mFbG
         7O+Yi+YdEDeN8im49nxBRHkXRegngHbQZ0L2dWeDq5dYJwBSR1zvjvR9RFWuWq9wnkfh
         HqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrmlgMYx9RqElUbssPucIFCPw3hERWs53HV8oJ9nzOw=;
        b=Yrbagw5l5HWJZArNS9ZVb/C3FsyPPZfX7B7H+t5ON/+wtjgYSNyAuITvaGjZm6UNsB
         kkhxR9siNB2c1zKfyrhIrrv9GJYdpwwMjaM2ZN/U1ZB2EG+7EYrC0abuXF15DC2fbJa/
         jMxeQajoOkV5IcRTbbe6iNlQISaGXoDQFBpRjCGZegRYc8fgPA6hYJTEyKaVVEn5gqvt
         g+Dc8Gu/ySIVvDxLEGr9Gcd5pU//KEiCfI08ZbX+U8CUSP7jd7AZpMxPWoUn7jiVDGJ6
         vDQ9A/nHbncUIT2XFmMZJSZDdPaJubeGbQwYfPRP5cNC+qMx1sKggXVUkyb6zxHpXAOr
         tb8Q==
X-Gm-Message-State: AOAM532edEwCloKOq6ur6Vokfs0scRRn7zI5nCS0HgFbSDLoiqn7KJ+5
        wG2jH9RUimi7GdMZXrhWmeUSN5/jW5gawg==
X-Google-Smtp-Source: ABdhPJyRY6dqEKp17v14Y8EcvaF8Y4y2W99C9wPVEgo9gzu27IFQZ/zxoXctGrkszllo+O6dq4o3jg==
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr1429846qtx.445.1637781271163;
        Wed, 24 Nov 2021 11:14:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y18sm299614qkp.120.2021.11.24.11.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:14:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/3] btrfs: call mapping_set_error() on btree inode with a write error
Date:   Wed, 24 Nov 2021 14:14:25 -0500
Message-Id: <f6f2469932a07a706149353618a1f77e88706fc2.1637781110.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1637781110.git.josef@toxicpanda.com>
References: <cover.1637781110.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

generic/484 fails sometimes with compression on because the write ends
up small enough that it goes into the btree.  This means that we never
call mapping_set_error() on the inode itself, because the page gets
marked as fine when we inline it into the metadata.  When the metadata
writeback happens we see it and abort the transaction properly and mark
the fs as readonly, however we don't do the mapping_set_error() on
anything.  In syncfs() we will simply return 0 if the sb is marked
read-only, so we can't check for this in our syncfs callback.  The only
way the error gets returned if we called mapping_set_error() on
something.  Fix this by calling mapping_set_error() on the btree inode
mapping.  This allows us to properly return an error on syncfs and pass
generic/484 with compression on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3454cac28389..1a67f4b3986b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4314,6 +4314,14 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	 */
 	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 
+	/*
+	 * We need to set the mapping with the io error as well because a write
+	 * error will flip the file system readonly, and then syncfs() will
+	 * return a 0 because we are readonly if we don't modify the err seq for
+	 * the superblock.
+	 */
+	mapping_set_error(page->mapping, -EIO);
+
 	/*
 	 * If we error out, we should add back the dirty_metadata_bytes
 	 * to make it consistent.
-- 
2.26.3

