Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A711159B4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 22:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBKVkv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 16:40:51 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34655 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgBKVku (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 16:40:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so49782qkm.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JWq8njORNn2WUZBkJp63poF2IG9OfU22Rwjfm6Wt62k=;
        b=RG/fetWoNfBkK+pksapjdk/qa2o7iKCy4/8gE0QYZk9g9dt8/IdXm6SntRZo+zUP2m
         VaOSj+JGXCt6RjUuSaBZR9VFLdP+W9ZvbV7xQbDpJpe1Tgyz1O54Td+gqb5aL23qIhEB
         lAicaJF2/HBhGEUaHGvSLIrbey1mB9ekkzxAYYOsYODvIR1UxVi40Bs7mu6FdwxaVjM9
         QQOhwxCXkVZJE+u3gJlEq1NxN41s7Ge3O/qqAYPlRdenwwRZV/+jYUuHUZSzy8jjgR0n
         iPtbVcqjEzWvRDFMLAg9FIvjbcq5C95ttqoPK8x4OvrLdNFHqmceZwXUHdNt7Ew/5xmg
         NYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWq8njORNn2WUZBkJp63poF2IG9OfU22Rwjfm6Wt62k=;
        b=pfDUmKO2BSABu52OchsyPmZa5oYMyErrZxSTk3Pfqprgo7Ch51+G1qXDiJv8eUZSTP
         Zdwk2wDzmjNlQhw4JqSlO4gfWpybo3QVc9MBSEbE3NdYrrnjkyB00TiXA1EyZ04tJR8I
         j0YSNRakOuQBg95cWOI7Y7Oyiios2Jg1ejcVBuHwC4jlK5fIpHhYbJmgvc6kGC7itaUJ
         EJR1wz7wJu4f8hKXmOcgTbXlcTgTGRPFvtcbbhKoFTOboJVzWRn+wKYtuH2zHhm4amEy
         DrNC28XsUP7f2HSjqi1vzdRK6xKgx+SOcH9xZyAGIc8A5qHkKB70cQh+sos0XKt7ypfb
         9XGw==
X-Gm-Message-State: APjAAAUHAXg2I98cXsqUMENmQDtjP2pjtFfDUkcZ3ufexZ+LMQUxa4yM
        VpGJTZxFXEY/1Q4WB+VmR+h06VJMJ+I=
X-Google-Smtp-Source: APXvYqxPic08bBR9OEGubbWvqStrcoAQnyXQKClvTFw2VLybZkyovmZAkhvTuqQKOSPrjU5vsh9zHQ==
X-Received: by 2002:a05:620a:134d:: with SMTP id c13mr4611507qkl.322.1581457249080;
        Tue, 11 Feb 2020 13:40:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 126sm2257511qkd.110.2020.02.11.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 13:40:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] btrfs: do not check delayed items are empty for single trans cleanup
Date:   Tue, 11 Feb 2020 16:40:40 -0500
Message-Id: <20200211214042.4645-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211214042.4645-1-josef@toxicpanda.com>
References: <20200211214042.4645-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_assert_delayed_root_empty() will check if the delayed root is
completely empty, but this is a fs wide check.  On cleanup we may have
allowed other transactions to begin, for whatever reason, and thus the
delayed root is not empty.  So remove this check from
cleanup_one_transation().  This however can stay in
btrfs_cleanup_transaction(), because it checks only after all of the
transactions have been properly cleaned up, and thus is valid.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5b6140482cef..601ed3335cf6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4543,7 +4543,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 	wake_up(&fs_info->transaction_wait);
 
 	btrfs_destroy_delayed_inodes(fs_info);
-	btrfs_assert_delayed_root_empty(fs_info);
 
 	btrfs_destroy_marked_extents(fs_info, &cur_trans->dirty_pages,
 				     EXTENT_DIRTY);
-- 
2.24.1

