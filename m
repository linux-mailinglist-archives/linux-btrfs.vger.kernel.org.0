Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629FE14F4CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAaWg2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41612 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgAaWg1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:27 -0500
Received: by mail-qk1-f195.google.com with SMTP id u19so553233qku.8
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXAG1/yIQ4AmblYfBjycP6z9OteijNC9KxrI0HvaUWI=;
        b=z/sjmPf774cxEIXqqmqGhXu3dVo94L/rWkIPR6Lqyv3FHpcjbQpXxy6izENM721kxd
         yyfEelEMIpiQkxvF3GekNiHa/hmPjhI9hCHMysNLYBszN267BBKK7NW347Qd3IocBn9D
         ngCem6lAWjA2cMQ4WjM9N0W/htuTWcKRib6moyyk1D6QtQYhUfpc/XkBM2+CL7mMkHXo
         Z2uBCX2ziibCxjAxvESALmuX1aSYZ8SVvBOAhUjdWms0kxzrmND3StjvcEh7bQppSlz/
         PyvMl6vbFwfIMedk3BtS1Za8Yf+ap1YoHGn5hP0dN6Bsw2Lw8BhwhFhMm3kXGmy1yMeJ
         m4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXAG1/yIQ4AmblYfBjycP6z9OteijNC9KxrI0HvaUWI=;
        b=ro0bIMUY9GedbvgYtcA2b5ZBlLPTKuYWs4dfe4lW0Hw8uiVcYki/OlCnlK8sA6dpR9
         qKKlbMkVdSfKLcQhZ6GDcNqajH6E/8PuXIi0JkW/KOT1C+8s67Uo4u2QuFUYwHaDi9cE
         M4G2Nahw8Q3jhWhgE45XVnxoPFVYSsL80nw4qqEe37OhOe/vJpX2r8svyFVA0xQ67BFP
         BaFYwX63YsvNdAQ65TWSkuSGv6MKU8dJUWZ78QZnBsAyIPETXF+CJWk6XCvNqYJxfGe/
         odYpYIHkOcbVvWBoCO1/YEdRwecJrPTuRl++zh9hEI5cP7WktevjH+wTf8LkArVM0bXs
         LLqw==
X-Gm-Message-State: APjAAAUdk/+Ncojh2falNkVvhXlzIhridX2bWe8DIHIRPLDOYnlPqHf6
        /WYAsKmP6amil0AcuRLyKrN0iyI4YCn2kw==
X-Google-Smtp-Source: APXvYqxuI8dis0waLgWtsdACt4YUVJjagJ+2vcZSCkXUUMoSzvlxOu7qPKGA4TzxYzqE7w1Cy9SdVA==
X-Received: by 2002:a05:620a:62c:: with SMTP id 12mr13037985qkv.154.1580510185137;
        Fri, 31 Jan 2020 14:36:25 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k17sm5098153qkj.71.2020.01.31.14.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 05/23] btrfs: make ALLOC_CHUNK use the space info flags
Date:   Fri, 31 Jan 2020 17:35:55 -0500
Message-Id: <20200131223613.490779-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
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
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 17e2b5a53cb5..5a92851af2b3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -604,7 +604,8 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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

