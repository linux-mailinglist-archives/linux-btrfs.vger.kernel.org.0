Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAE645BB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfFNLuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 07:50:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36808 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFNLuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 07:50:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id f21so1433768pgi.3;
        Fri, 14 Jun 2019 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h3a8MSgllR1VzyxCgXzslXCSIaES75ArkXEmitqW5jU=;
        b=E7ZP9j9YWgo8vSuFABpgNgE2+vhludF3mH8n5M6tO78o+s0p7B3iAj+j/R0jY63w1n
         qIpEMPj6OPQjKTSyzol3TEvGbco7cyOADqeWZh1Iaec6DMeaJLP5C8AyjIjPvlSjFsRG
         Ysw4b5XIU4WUbm1/onI39AHEqLFrsb2shYhe9jgfYBV2SpJe8D1/wSjD5BHOPqltyob1
         3hGQGZWyPZmCKKnnaSZ4JUXya08IQ/kdLH/qerOr8lOL0/ytZtUnOH24YouPKFC8oGX+
         FBOxARwmP1qy7VDbZDqWqR8lXP+gK0N3X3nkmNkWaZ0haF1uZb0tIajrCEG48d3SD7e+
         hlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h3a8MSgllR1VzyxCgXzslXCSIaES75ArkXEmitqW5jU=;
        b=Vck6FDiiofYqL6ODDucD+B/kjukPau4y5qtkJCkBlokbwPpMvFBClJoir3Ea+hPl/O
         v9+F/T9aSx735ZKlHyEPkc5+yLy7ZrGqYn9qhnt7b+nhJUQrNXWdEpZHeZwPAVdR1Ttr
         Juh/HDtCUHMynfImJnc7g5mGGfSkbA+X4zV7UWb315wvYyJNai5hw2djGLpWFJhYSa4o
         mAo1SkGFl2E9b2SZH6+D/c19xjnm+Z8LTBsx21TS6TgAo3rmMR5qUOgGXnSwUJ7ediA0
         ADOE24cojOOY20fCIPQ5R0ZmtGa/Cs375PKHmZ8zAsr0RTRqViuMsSqj6nPeEi3QrP+r
         WdlA==
X-Gm-Message-State: APjAAAWUrjHEyLwPIVQIu2+3cCUqFj+kqta1ZI1LGn5yaVmpebdosjyf
        ntm9Hl2EUerQZ4lHha726V30GsBe3t6adA==
X-Google-Smtp-Source: APXvYqxlEHvwEzPSNOgpEmqYxAwFljTQCNczS9YEeJvwU1v3jnZxJfJTHERdfqNnMhb0CS1KegTDlQ==
X-Received: by 2002:a63:6105:: with SMTP id v5mr35288809pgb.312.1560513038336;
        Fri, 14 Jun 2019 04:50:38 -0700 (PDT)
Received: from xy-data.openstacklocal ([159.138.22.150])
        by smtp.gmail.com with ESMTPSA id f10sm2275556pgq.73.2019.06.14.04.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 04:50:37 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] btrfs: fix out of bounds array access while reading extent buffer
Date:   Fri, 14 Jun 2019 19:51:49 +0800
Message-Id: <1560513109-2568-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a corner case that slips through the checkers in functions
reading extent buffer, ie.

if (start < eb->len) and (start + len > eb->len), then:
the checkers in read_extent_buffer_to_user(), and memcmp_extent_buffer()
WARN_ON(start > eb->len) and WARN_ON(start + len > eb->start + eb->len),
both are OK in this corner case, but it'd actually try to access the eb->pages
out of bounds because of (start + len > eb->len).

This is adding proper checks in order to avoid invalid memory access,
ie. 'general protection fault', before it's too late.

See commit f716abd55d1e ("Btrfs: fix out of bounds array access while
reading extent buffer") for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index db337e5..dcf3b2e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5476,8 +5476,12 @@ int read_extent_buffer_to_user(const struct extent_buffer *eb,
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 	int ret = 0;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	if (start + len > eb->len) {
+		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
+		     eb->start, eb->len, start, len);
+		memset(dst, 0, len);
+		return;
+	}
 
 	offset = offset_in_page(start_offset + start);
 
@@ -5554,8 +5558,12 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
 	int ret = 0;
 
-	WARN_ON(start > eb->len);
-	WARN_ON(start + len > eb->start + eb->len);
+	if (start + len > eb->len) {
+		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
+		     eb->start, eb->len, start, len);
+		memset(ptr, 0, len);
+		return;
+	}
 
 	offset = offset_in_page(start_offset + start);
 
-- 
2.7.4

