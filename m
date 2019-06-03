Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D53261C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 03:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFCB2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jun 2019 21:28:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43738 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfFCB2G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jun 2019 21:28:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so9603287pfa.10
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Jun 2019 18:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrxomJZEVtseTBrkWa75DS1EWRVrWaKsUK4snKzxs68=;
        b=DWhS8hS81gtsA95J5RK0Q/YcYYoO1vXemGFDojdsONcUp0bIhFAyEX/BZ60rBduP2x
         7bkzC2H+QfoUtBD+LHDfEkNY40vOETROQJTROIDG+7v9uzSvtuxfM9+9jIrSJdilLYg6
         O/RRlFcv5SWa+uJnFXZuwVY2V8FITeP1MZD1c9z6QehkYoQRhXyAYU7qjt3VNY/xft/Z
         ZFtQrx8/cg80MyzlGk1dabyVhshE5YrsCB0M4SwwleKx5FUgSdl6+xs6ROXOCQO3VHFo
         wdawzwwQFbswfgnnMfEpal/L2aoG0Tv6vhJROyg9BPL3nCx9f0AQmZLG376jm9/ZrIXZ
         XPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrxomJZEVtseTBrkWa75DS1EWRVrWaKsUK4snKzxs68=;
        b=PPnxuEzMkqE7IwoGNM3tzQrQB3lJwlWuqTEXzjp0oN83ft8XUq94mJizUXdgHcbX1J
         1xL6J/b4EpTP5iXrBtzuGXS3WjohF3uiKE4leMpRFhPpfwr3l/pfWXjPxQ8THPs4gbcP
         bJDKdGXC2sWv8OL+8nVgyy+vgzVOy3jBWKR/t+U9mszLHMqFjryqSDMXn+M0fGjddcUb
         5Xr0AEVReabaS3M4V/VRLtKxLK8inMEK0frugcqsD2zubbj89cPkcTkzeGQ9ldprev8s
         0ATUepEnIKNy3H1wQmlVQYxMYVQftQ/B0+RDkkfSPCWz9gfgDh1s3IlRNAnRcrk6WHWK
         247A==
X-Gm-Message-State: APjAAAWPOaqlvT4q4MukaovHEsCHvMcMatvI+zTWwqj5Vbo+WwK7Pz8t
        5b4m1/XzKKO88JSMcJFx7MXwxJ639C0=
X-Google-Smtp-Source: APXvYqxpcKWUGcVb3z3Rj0K8xLbVI6v6JlTlthuu/UAUDcmp9jOOtBuUdzASaCq+TACwq9U7VNOyRg==
X-Received: by 2002:a62:2e47:: with SMTP id u68mr28193648pfu.24.1559525285534;
        Sun, 02 Jun 2019 18:28:05 -0700 (PDT)
Received: from cat-arch.lan (241.239.92.34.bc.googleusercontent.com. [34.92.239.241])
        by smtp.gmail.com with ESMTPSA id x25sm4525950pfm.48.2019.06.02.18.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 18:28:04 -0700 (PDT)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>,
        Peter Hjalmarsson <kanelxake@gmail.com>
Subject: [PATCH] btrfs-progs: fix invalid memory write in get_fs_info()
Date:   Mon,  3 Jun 2019 09:27:54 +0800
Message-Id: <20190603012754.2527-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

As the link reported, btrfs fi sh may crash while a device is removing.

valgrind reported:
======================================================================
...
==883== Invalid write of size 8
==883==    at 0x13C99A: get_device_info (in /usr/bin/btrfs)
==883==    by 0x13D715: get_fs_info (in /usr/bin/btrfs)
==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
==883==  Address 0x4d8c7a0 is 0 bytes after a block of size 12,288 alloc'd
==883==    at 0x483877F: malloc (vg_replace_malloc.c:299)
==883==    by 0x13D861: get_fs_info (in /usr/bin/btrfs)
==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
==883==
==883== Invalid write of size 8
==883==    at 0x13C99D: get_device_info (in /usr/bin/btrfs)
==883==    by 0x13D715: get_fs_info (in /usr/bin/btrfs)
==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
==883==  Address 0x4d8c7a8 is 8 bytes after a block of size 12,288 alloc'd
==883==    at 0x483877F: malloc (vg_replace_malloc.c:299)
==883==    by 0x13D861: get_fs_info (in /usr/bin/btrfs)
==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
==883==
==883== Syscall param ioctl(generic) points to unaddressable byte(s)
==883==    at 0x4CA9CBB: ioctl (in /usr/lib/libc-2.29.so)
==883==    by 0x13C9AB: get_device_info (in /usr/bin/btrfs)
==883==    by 0x13D715: get_fs_info (in /usr/bin/btrfs)
==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
==883==  Address 0x4d8c7a0 is 0 bytes after a block of size 12,288 alloc'd
==883==    at 0x483877F: malloc (vg_replace_malloc.c:299)
==883==    by 0x13D861: get_fs_info (in /usr/bin/btrfs)
==883==    by 0x153B5F: ??? (in /usr/bin/btrfs)
==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
==883==
--883-- VALGRIND INTERNAL ERROR: Valgrind received a signal 11 (SIGSEGV) - exiting
--883-- si_code=1;  Faulting address: 0x284D8C7B8;  sp: 0x1002eb5e50

valgrind: the 'impossible' happened:
   Killed by fatal signal

host stacktrace:
==883==    at 0x5805261C: get_bszB_as_is (m_mallocfree.c:303)
==883==    by 0x5805261C: get_bszB (m_mallocfree.c:315)
==883==    by 0x5805261C: vgPlain_arena_malloc (m_mallocfree.c:1799)
==883==    by 0x58005AD2: vgMemCheck_new_block (mc_malloc_wrappers.c:372)
==883==    by 0x58005AD2: vgMemCheck_malloc (mc_malloc_wrappers.c:407)
==883==    by 0x580A7373: do_client_request (scheduler.c:1925)
==883==    by 0x580A7373: vgPlain_scheduler (scheduler.c:1488)
==883==    by 0x580F57A0: thread_wrapper (syswrap-linux.c:103)
==883==    by 0x580F57A0: run_a_thread_NORETURN (syswrap-linux.c:156)

sched status:
  running_tid=1

Thread 1: status = VgTs_Runnable (lwpid 883)
==883==    at 0x483877F: malloc (vg_replace_malloc.c:299)
==883==    by 0x1534AA: ??? (in /usr/bin/btrfs)
==883==    by 0x153C49: ??? (in /usr/bin/btrfs)
==883==    by 0x11B0C1: main (in /usr/bin/btrfs)
client stack range: [0x1FFEFFA000 0x1FFF000FFF] client SP: 0x1FFEFFDCE0
valgrind stack range: [0x1002DB6000 0x1002EB5FFF] top usage: 7520 of 1048576

======================================================================

The above log says that invalid write to allocated @di_args happened
in get_device_info() called in get_fs_info().

The size of @di_args is allocated according by fi_args->num_devices.
And fi_args->num_devices is *the number of dev_items in chunk_tree*.
However, in the loop to get devices info, btrfs-progs calls ioctl
BTRFS_IOC_DEV_INFO which just finds device in
fs_info->fs_devices->devices.

Let's look at kernel side.
In btrfs_rm_device(), btrfs_rm_dev_item() causes removal of
related dev_items in chunk_tree. *Do something*.
Then delete the device from device->fs_devices.

So the case is:
Userspace					kernel

get_fs_info()					btrfs_rm_device()
						...
						  btrfs_rm_dev_item()

  determine fi_args->num_devices and
    fi_args->max_id by seraching chunk_tree.
  malloc()					  ...
  Loop(Crashed): call get_device_info() by devid
    from 1 to fi_args->max_id.
    	   					  mutex_lock(&fs_devices->device_list_mutex);
						  list_del_rcu(&device->dev_list);
					          ...

In the loop of get_device_info(), get_device_info() still can get info
of the removing device since it's still in fs_info->fs_devices->devices.
Then the iterator value @ndev increaments causes invalid access out of
bounds.

Solved it by adding the check of @ndev while looping.

Reported-by: Peter Hjalmarsson <kanelxake@gmail.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1711787
Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils.c b/utils.c
index c6cdc8f01dc1..0b271517551b 100644
--- a/utils.c
+++ b/utils.c
@@ -1763,7 +1763,8 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 
 	if (replacing)
 		memcpy(di_args, &tmp, sizeof(tmp));
-	for (; last_devid <= fi_args->max_id; last_devid++) {
+	for (; last_devid <= fi_args->max_id && ndevs < fi_args->num_devices;
+	     last_devid++) {
 		ret = get_device_info(fd, last_devid, &di_args[ndevs]);
 		if (ret == -ENODEV)
 			continue;
-- 
2.21.0

