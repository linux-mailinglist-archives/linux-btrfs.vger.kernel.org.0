Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4C2B79EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 10:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgKRJDu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 04:03:50 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46274 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRJDt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 04:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605691180; x=1637227180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=blaYJQIGsPxOVYgRDbcOKQwialy8Ao97ROaEQ2ZX7W8=;
  b=ZJwOTTsfJmgkygc+WQjF9xArWus1YLcQhjI+AbM2JCM0U8a1Pn22gtGK
   fpEMe1JaEUV3HZMog9e1Oq+zW2qq9ylVUvB0EUgskjr9P71TwIxtZpmA+
   wghtG+q9p+YSTWGCKCtR3zx675yUpUl2Hxma5TFcOQjkZubxJB0e95NI2
   O14X5D1XZoJfz9ZSq2Pbd3kOeMKI+VaKQegvxotK77M/pcrEhsTOeTlcu
   A9/9DnsMojsDdz4cPhOi69aHgZHICUJUXH8daam+WVEs7YxNUpXwJYVPa
   uTNnxX8EASamdZ69JwRtwViCZNbzOHeTmoHLe3sorvPeCGBQxIsFTDB4P
   A==;
IronPort-SDR: 3qQK3m7xMVjkzOTV9J2xj46XYJEC4tt1hy5AEdX5NsoXsjlr9+zQABPdZvgnlEXIsxgZ8IPYcq
 E0TlQC7KTQyCuXxrah3DMe1QGVU3dTQ6nugq1183DLg2i8T7lPCMLlD1KtdxcNCHxwWqiJSTTe
 aQblQOTyMoeKvlVrKYm89ExXiOLAN1cqpGgaHZARMdyvF9XnGOQb+lBpc9YnDch5n03LMOMem7
 5yrWgLTjZqjKbTDFcDwTUwVRtJ7+HZzJYaX7/NJ380ldapTzQ/z5YuOjcFSldwcpIbNI7YOgyl
 3qQ=
X-IronPort-AV: E=Sophos;i="5.77,486,1596470400"; 
   d="scan'208";a="256459788"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2020 17:19:40 +0800
IronPort-SDR: df1XUnBFZop1hc56jnTF1jrhfJCUYNkz7tEXr3sYQn39Fv1Jh0Dq2vOTYWCfcFaufmUOUOrDBs
 Tju6Ykm4kMsu97xuBE0eqWwNcremtuleu64zF1fCI+3K9A/tIM4q2kgV3B5rkr/yeNBofj7ECx
 jPPS1H6L0D17Vy0TmW08qo/L/0HI/eSNsrYYkCio4kVexP5zYTv5+t7ghXxPYBCWSmEjYwxGWE
 5ZqZj4hfIrI7Ks5DoVNBc4yuAjF0tFNDwSETdStYcve327BPfpLRNMQ1Z8CoF4F334Ia6FyAQy
 sjqEYuPXSXDeohjUbVs8Fdt4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 00:48:19 -0800
IronPort-SDR: O/bRqBL2YiqX8218r5dI1r8intBtx7EJ/eC0PzfSpvFQPMRNk9Cqz2gEfFiHfp04xZErCxVI1N
 fUQ+rT/hvCfwxrtNXaAQlpl0mjoN9jqub5gK9k1Ecykzm832dEHBF3jHEXoGfBYCuGK7jS/M8P
 8dIvMqWoxjF3CRANV3iOMp4RsDRsnbasqeaUlqkyRYV0ADxuaV+hD7q0AtEup8YgZmbFryF6n7
 gPxFsJSzt+kUpz8n8ClOPBlWtJbkH656hIkzgIh1Ok0814o3YROz3TwmCbNMCAKXM9MpZ7N390
 ukQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Nov 2020 01:03:47 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
Subject: [PATCH v3] btrfs: don't access possibly stale fs_info data for printing duplicate device
Date:   Wed, 18 Nov 2020 18:03:26 +0900
Message-Id: <e639c7a057653c1947b3a4acf2fba6c7798000b5.1605690144.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Syzbot reported a possible use-after-free when printing a duplicate device
warning device_list_add().

At this point it can happen that a btrfs_device::fs_info is not correctly
setup yet, so we're accessing stale data, when printing the warning
message using the btrfs_printk() wrappers.

The syzkaller reproducer for this use-after-free crafts a filesystem image
and loop mounts it twice in a loop. The mount will fail as the crafted
image has an invalid chunk tree. When this happens btrfs_mount_root() will
call deactivate_locked_super(), which then cleans up fs_info and
fs_info::sb. If a second thread now adds the same block-device to the
file-system, it will get detected as a duplicate device and
device_list_add() will reject the duplicate and print a warning. But as
the fs_info pointer passed in is non-NULL this will result in a
use-after-free.

Instead of printing possibly uninitialized or already freed memory in
btrfs_printk(), explicitly pass in a NULL fs_info so the printing of the
device name will be skipped altogether.

Link: https://lore.kernel.org/linux-btrfs/000000000000c9e14b05afcc41ba@google.com
Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v2:
- Add comment why we're passing NULL to btrfs_warn_in_rcu()
- Clarify commit message

Changes to v1:
- Use btrfs_warn_in_rcu(NULL,) instead of pr_warn()
---
 fs/btrfs/volumes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bb1aa96e1233..3f2af8106d5b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -940,7 +940,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			if (device->bdev != path_bdev) {
 				bdput(path_bdev);
 				mutex_unlock(&fs_devices->device_list_mutex);
-				btrfs_warn_in_rcu(device->fs_info,
+				/*
+				 * device->fs_info may not be reliable here, so
+				 * pass in a NULL fs_info. This avoids a
+				 * possible use-after-free when the fs_info and
+				 * fs_info->sb are already torn down.
+				 */
+				btrfs_warn_in_rcu(NULL,
 	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
 						  path, devid, found_transid,
 						  current->comm,
-- 
2.26.2

