Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467F83C8198
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 11:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbhGNJdx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 05:33:53 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:49788 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbhGNJdx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 05:33:53 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id F30B71E0051C;
        Wed, 14 Jul 2021 12:31:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1626255060; bh=OrHCNZxX90vrgyl+yyhQBt65j3Tt5Fz0vepwWkA1Ilg=;
        h=From:To:Cc:Subject:Date;
        b=UHAL6mRU9raLK3NHep3jHsHYwDecMTXFoqES853II1wjRwmBujkGc6zTuLCcZcq9V
         1N472N8AYCQCPnhYiD9Y/H8HEDDvUhIZ2M71jeMIxdgP21XfHGB9SUOwDk6PTm6HfN
         9cZKlAk5QaBiP0hSeuW8VlFdkjQpEMHXVujfU3Gc=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id EABC71E004B3;
        Wed, 14 Jul 2021 12:31:00 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 3DM9JJlFaMMq; Wed, 14 Jul 2021 12:31:00 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 899351E004F7;
        Wed, 14 Jul 2021 12:31:00 +0300 (EEST)
Received: from localhost.localdomain (unknown [211.106.132.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 29F451BE01CB;
        Wed, 14 Jul 2021 12:30:58 +0300 (EEST)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [RFC PATCH] btrfs: do not warn if fs_devices has no device when call btrfs_show_devname
Date:   Wed, 14 Jul 2021 17:30:49 +0800
Message-Id: <20210714093049.303978-1-l@damenly.su>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 885mlotPBD+kjECgQHnABwY1s0g9Uezj++a42B5YmH3mU12JfFR+Ix3M/3AFM3H44X8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

while running btrfs/238 in my test box, the following warning occurs
in high chance:

------------[ cut here  ]------------
WARNING: CPU: 3 PID: 481 at fs/btrfs/super.c:2509 btrfs_show_devname+0x104/0x1e8 [btrfs]
CPU: 2 PID: 1 Comm: systemd Tainted: G        W  O 5.14.0-rc1-custom #72
Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
Call trace:
  btrfs_show_devname+0x108/0x1b4 [btrfs]
  show_mountinfo+0x234/0x2c4
  m_show+0x28/0x34
  seq_read_iter+0x12c/0x3c4
  vfs_read+0x29c/0x2c8
  ksys_read+0x80/0xec
  __arm64_sys_read+0x28/0x34
  invoke_syscall+0x50/0xf8
  do_el0_svc+0x88/0x138
  el0_svc+0x2c/0x8c
  el0t_64_sync_handler+0x84/0xe4
  el0t_64_sync+0x198/0x19c
---[ end trace 3efd7e5950b8af05  ]---

It's also reproducible by creating a sprout filesystem and reading
/proc/self/mounts in parallel.

The warning is produced if btrfs_show_devname() can't find any available
device in fs_info->fs_devices->devices which is protected by RCU.
The warning is desirable to exercise there is at least one device in the
mounted filesystem. However, it's not always true for a sprouting fs.

While a new device is being added into fs to be sprouted, call stack is:
 btrfs_ioctl_add_dev
  btrfs_init_new_device
    btrfs_prepare_sprout
      list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
      synchronize_rcu);
    list_add_rcu(&device->dev_list, &fs_devices->devices);

Looking at btrfs_prepare_sprout(), every new RCU reader will read a
empty fs_devices->devices once synchronize_rcu() is called.
After commit 4faf55b03823 ("btrfs: don't traverse into the seed devices
in show_devname"), btrfs_show_devname() won't looking into
fs_devices->seed_list even there is no device in fs_devices->devices.

And Since commit 88c14590cdd6 ("btrfs: use RCU in btrfs_show_devname for
device list traversal"), btrfs_show_devname() only uses RCU no heavy
mutex lock for device list traversal. It read an empty
fs_devices->devices and found no device in the list then triggers the
warning. The commit just enlarged the window that the fs device list
could be empty. Even btrfs_show_devname() uses mutex_lock(), there is a
tiny chance of reading an empty devices list between mutex_unlock() in
btrfs_prepare_sprout() and next mutex_lock() in btrfs_init_new_device().

Just remove the WARN_ON(1) if there is no valid device since the least
one device check is not suitable for the one short period of sprouting
filesystem.

Signed-off-by: Su Yue <l@damenly.su>

---
Make it RFC since I wonder if there is any better solution not dropping
the sanity check for normal fs.
---
 fs/btrfs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d07b18b2b250..34f9b1c930f8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2503,8 +2503,6 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 
 	if (first_dev)
 		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
-	else
-		WARN_ON(1);
 	rcu_read_unlock();
 	return 0;
 }
-- 
2.30.1

