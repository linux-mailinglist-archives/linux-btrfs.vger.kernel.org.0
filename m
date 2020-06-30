Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776CA20F683
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbgF3N7h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgF3N7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:36 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6555FC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e13so18621490qkg.5
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvZIkows8auYehqDoOck2uZN7Jfa9bG4yskXCxHR+6g=;
        b=NbLysFfJxHCSs455ruFLSiVY6PdzFmGgpzVRZSyspWLxVfIrLwQorkdcy9P97tl8/M
         d2gOrI0+lSjMTL30+G5vtu3E0TJ8BUz6h/l9YQGzErTf0PnpCrDZI8yYdCVd0cxM1wuH
         CTsQ5eIvOAJWUmjGQITjLKsalsXCMbdr6/ltszaOzxatGzQssHShMr56Wq7TDH7psM0M
         eFVSw+GXYAjAe8hLmySLfSYvrXbMsvi2ki/V3uNgP41ttCkkCukq1EjZBwT4RsVFmUdM
         BtR85a8IgTXVBUqxX32nhRTNsLkQshMa9ZCHh3OqHqV+xEumA87Qb4aa6cgVZ4Ik8NhN
         TwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvZIkows8auYehqDoOck2uZN7Jfa9bG4yskXCxHR+6g=;
        b=eZI0kcSevPknek4or+E9ZZ/jIzBfngoDEKWCRadsru3IJkfOZOighCH9CMVzYDhnDC
         sU7AjsxFNUY57kANffQy/IYmZXh7FhQUzBcZZVHWdMS/OOKmrW7d3OezzXlu8c3siwnK
         WePF2jDOjKl8Pi6fP7Q9boupXCfqV1NQmEIK6evAcyzIqOeZIERUhBQPoHRPQlFH11Co
         92we6JmhY1zcEEALaWqbCiRUQO4l7EElfisCdE4UJvoYjo17KTYkuVbs9lCYUwqrQR7r
         dqtX3vRRmzIXQKL4/F2d9C87TmbroSO7eTd5kGXPINg1DJctlCvZEkIsKB/M3iQwPoKX
         LbrQ==
X-Gm-Message-State: AOAM531LN0YZ5yod/VUgjQQ5CJdCEQ2EQuyyNWEWx24n3OJEvgoNkxBz
        qE85kkA6HaRBCkkp/Li45r2OnNd+Ybj9MA==
X-Google-Smtp-Source: ABdhPJwVXaEfdW0/0vzwYm5UwKEsTB3hN96tYZ8IPOKC2a6/XavYupnfbSqKBwv886xaPOzSFyeJng==
X-Received: by 2002:a05:620a:2f4:: with SMTP id a20mr20230371qko.227.1593525575211;
        Tue, 30 Jun 2020 06:59:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j16sm2920233qtp.92.2020.06.30.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/23] btrfs: make ALLOC_CHUNK use the space info flags
Date:   Tue, 30 Jun 2020 09:59:03 -0400
Message-Id: <20200630135921.745612-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have traditionally used flush_space() to flush metadata space, so
we've been unconditionally using btrfs_metadata_alloc_profile() for our
profile to allocate a chunk.  However if we're going to use this for
data we need to use btrfs_get_alloc_profile() on the space_info we pass
in.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index dda0e9ec68e3..3f0e6fa31937 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -777,7 +777,8 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		ret = btrfs_chunk_alloc(trans,
-				btrfs_metadata_alloc_profile(fs_info),
+				btrfs_get_alloc_profile(fs_info,
+							space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
-- 
2.24.1

