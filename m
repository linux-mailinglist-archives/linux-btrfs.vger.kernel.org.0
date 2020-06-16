Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5281FB63C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgFPPcT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 11:32:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33526 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729311AbgFPPcT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 11:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592321538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Rapzz6MrSVpeRVwJm6x5SQPvv++uc4wAZZK6zSqqYMI=;
        b=S7B5R68ajDZ20aVoVRUgoDTuoLwFkMtOTrqA6vHi9oj2W4rD3DRtr0CRcpVNvq7GNF0bTZ
        DnMp69HN873XGajzhbo5Sg9Lw/L3mGh5fbMJDeWvDnp6aJpkoiZjpDTNw889i+qyG9GoXV
        Xg3rAAyxBPfvmujCuSJOGno7otcAE1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-zn6-aWQrP7aNGDm5Hrovow-1; Tue, 16 Jun 2020 11:32:16 -0400
X-MC-Unique: zn6-aWQrP7aNGDm5Hrovow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8682F87342B;
        Tue, 16 Jun 2020 15:32:15 +0000 (UTC)
Received: from llong.com (ovpn-114-156.rdu2.redhat.com [10.10.114.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA06B5D9D3;
        Tue, 16 Jun 2020 15:32:11 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] btrfs: Use kfree() in btrfs_ioctl_get_subvol_info()
Date:   Tue, 16 Jun 2020 11:31:59 -0400
Message-Id: <20200616153159.10691-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_ioctl_get_subvol_info(), there is a classic case where kzalloc()
was incorrectly paired with kzfree(). According to David Sterba, there
isn't any sensitive information in the subvol_info that needs to be
cleared before freeing. So kzfree() isn't really needed, use kfree()
instead.

Reported-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 168deb8ef68a..e8f7c5f00894 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2692,7 +2692,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	btrfs_put_root(root);
 out_free:
 	btrfs_free_path(path);
-	kzfree(subvol_info);
+	kfree(subvol_info);
 	return ret;
 }
 
-- 
2.18.1

