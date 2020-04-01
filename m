Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5202D19A3F9
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgDAD0s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 23:26:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25751 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731592AbgDAD0r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 23:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585711606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PnKmZsecfPV+baV27QWBqw+5G9m6xrl4SA6APZwxQl0=;
        b=S/973Q/fHhs1Z/qbP7Q5olEioUY2Dp07DRTZY3DBRwJjLhtQ4nQyGK59ZrKAvzrbec+/8F
        zOiCD/voFWNqjscg/x1MqVReY34OmNYgAszZbEJLQKcrTldLWmdk/7UExs1H2bq5x9+drT
        R1eWAOJTUCJTi5Tfvkai9YbObicwWSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-FG66sx5nNjC05pwwMZPSoQ-1; Tue, 31 Mar 2020 23:26:43 -0400
X-MC-Unique: FG66sx5nNjC05pwwMZPSoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 798F318B9FC1;
        Wed,  1 Apr 2020 03:26:41 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E63715C1C5;
        Wed,  1 Apr 2020 03:26:38 +0000 (UTC)
Date:   Wed, 1 Apr 2020 05:26:50 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] btrfs: re-instantiate the removed BTRFS_SUBVOL_CREATE_ASYNC
 definition
Message-ID: <20200401032650.GA24378@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit 9c1036fdb1d1ff1b ("btrfs: Remove BTRFS_SUBVOL_CREATE_ASYNC
support") breaks strace build with the kernel headers from git:

    btrfs.c: In function "btrfs_test_subvol_ioctls":
    btrfs.c:531:23: error: "BTRFS_SUBVOL_CREATE_ASYNC" undeclared (first use
    in this function)
       vol_args_v2.flags = BTRFS_SUBVOL_CREATE_ASYNC;

Moreover, it is improper to break UAPI anyway.

Restore the macro definition and put it under "#ifndef __KERNEL__"
in order to prevent inadvertent in-kernel usage.

Fixes: 9c1036fdb1d1ff1b ("btrfs: Remove BTRFS_SUBVOL_CREATE_ASYNC support")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/btrfs.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 8134924..e6b6cb0f 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -36,12 +36,10 @@ struct btrfs_ioctl_vol_args {
 #define BTRFS_DEVICE_PATH_NAME_MAX	1024
 #define BTRFS_SUBVOL_NAME_MAX 		4039
 
-/*
- * Deprecated since 5.7:
- *
- * BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
- */
-
+#ifndef __KERNEL__
+/* Deprecated since 5.7 */
+# define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
+#endif
 #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
 #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
 
-- 
2.1.4

