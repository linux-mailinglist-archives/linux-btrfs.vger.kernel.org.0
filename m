Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171BF21B7CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgGJOGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJOGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:06:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0279DC08C5CE
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:06:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so5247671qke.13
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bToUZggK6ZXQShBTkJRsiBP038e9JoOeD6QxhceCRu8=;
        b=fd2ANepRMCCtXPeBfrdNOX6z+8GqFUVJ7rzEsKVsJrUTZJ7s0/UmV7IiVOua5WptDf
         TJO5pEWrq8XFPUREnLEFrcj6JIaF7/8C/c95blta1YGgAgqMd4ZJr94ZUgdBN3WyxKX3
         IouQ0W4RElhnfGHVdrJK/Nv3vmF0hcm+3T6nqJOaZWO2XnRoimRG1mSCpVLBi+cbI712
         sNiVBfLGGWqZfCuCadNxm/+Sd0MM9Zph7/XGYI1iEk9nkw7FaS7EkYyK+JtYFb6YXW+p
         sMs3nc6tBSPZqfsHe9u2IlruTr3oiz1jepMAl4MsyipPNboQtwNIEMIb1jIISGCTYPve
         tWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bToUZggK6ZXQShBTkJRsiBP038e9JoOeD6QxhceCRu8=;
        b=b712d7gGq9QX4gmpWRwo9T2DzljYVyNXlLAD5jmCNNfj8f+4/IY9tfkhLJ9mPAp9SG
         XYeR6WeHDJB3fupnw28t1PMJTX7l5XIxEHY5D+aOxiqsYB8VVz6qKdtRfcBgbDdahfyJ
         w0atpC5/RE7UNGIykOZh8AUEE+YdskSoHwjTvpHzbIx0VV9HJWwN/P+f8qxE2thW2kpe
         bC6x/F7mtWTdVl0+GV21L5s9DncngYGWHjKh7N37bTFyCltFTRr/leLNHahVXYiutGS8
         OCCKJIEl7zcRcdRdf/ahpAfe7v4LjW2AyR4RR8kIckAJZU+gDNQxMHZhXjUJJIMALZP4
         RptQ==
X-Gm-Message-State: AOAM533LElGNVozs2kM5OAx4K/CoqAktUEQwb2AcKcXdkxeRSIpxXPIc
        6fb7wnBElJSedU0d9QPWJ1dImvP5d3aOBA==
X-Google-Smtp-Source: ABdhPJzK4MN1JJQK+mlv6jJ12w9E+CNvUIIPZnOxrGYcXbs032wKHDNixOzep2UsS0j9OfZS1iJNbg==
X-Received: by 2002:ae9:ea13:: with SMTP id f19mr62240488qkg.331.1594389981847;
        Fri, 10 Jul 2020 07:06:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z68sm7482475qke.113.2020.07.10.07.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 07:06:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Eric Sandeen <esandeen@redhat.com>
Subject: [PATCH] btrfs: return -EIO on error in btree_write_cache_pages
Date:   Fri, 10 Jul 2020 10:06:19 -0400
Message-Id: <20200710140619.2366724-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Eric reported seeing this message while running generic/475

BTRFS: error (device dm-3) in btrfs_sync_log:3084: errno=-117 Filesystem corrupted

This ret came from btrfs_write_marked_extents().  If we get an aborted
transaction via an -EIO somewhere, we'll see it in
btree_write_cache_pages() and return -EUCLEAN, which we spit out as
"Filesystem corrupted".  Except we shouldn't be returning -EUCLEAN here,
we need to be returning -EIO.  -EUCLEAN is reserved for actual
corruption, not IO errors.

Reported-by: Eric Sandeen <esandeen@redhat.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a76b7da91aa6..6f0dd15729cc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4122,7 +4122,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
 		ret = flush_write_bio(&epd);
 	} else {
-		ret = -EUCLEAN;
+		ret = -EIO;
 		end_write_bio(&epd, ret);
 	}
 	return ret;
-- 
2.24.1

