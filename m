Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2E23D7017
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 09:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhG0HNv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 03:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhG0HNu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 03:13:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F5FC061757;
        Tue, 27 Jul 2021 00:13:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso3608264pjf.4;
        Tue, 27 Jul 2021 00:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrrJwiLbM3Ga7nei1tG5qM9T+06r1hAsagdwYPL060k=;
        b=jvQXoar1Xahk3e8uQeeVl7OK02Fswvs4y1JvdgZ93YspKNaORNAnz+zgOWG2cB27/l
         XUovgz8r6G61X12/X1fT4lvlSGwN0BUagN8S1DtK9Q76X8Py/TNvP1MEdsjFKCUZXJln
         TKaHMdW6/76wQTTf/PJ3AGhd0b6WKbdZ/wmggHvm9j05Yq+EWJK7eeQFDX/W/19teX81
         fq960S63dOv6FG0h1l9Sb29/EJcwVug7EU5bcnXqxyTHn5cvgbnEh3l3/4c4gF6s390p
         xq/HSpn0UI55a+VShKD77A8bBvJwJ0dTTgHap//Kj3mRE/ToQGWOrB2hX9zv3Gqi1Pc7
         X/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrrJwiLbM3Ga7nei1tG5qM9T+06r1hAsagdwYPL060k=;
        b=SPxvloUEMfLXvst4hKmNpyUNTrTGHS3hEcXD0MUuRXSz162FKhi/aC3cJpb4rMaE5z
         oJZKDTJa9uoObAjcJpBKifqWdyniDq2ulA2tr55Wc8nL5CI0KUBTyOPl2urd1cpUoOcw
         DBHYkGVn0HnWdsVIQMMyUx6lspwE7HqVGqgkE6MoYovdIg3mXGLSkBVHn/S7llSnks+r
         sXs4/YeL/UjzC1kClXOjaBrEkDEfvmavS9KnPlzwC0i4RIxxydONVyG16cDcAQlFpnWp
         +MriNHSo8bm/BBHPxz38b3lLA1sWYw1Hgxp1uz7kKX2wHIx3zWgSOFs/bUbx1YS7PFKN
         14WA==
X-Gm-Message-State: AOAM531q7fpz5weNZVJvaFbFX51VOA58nMkYCxhjFOd4ErgUeTtKQL9e
        e/9UCQJTX8P9U7zayx9Gjf4=
X-Google-Smtp-Source: ABdhPJxl/oFTVpBPLS9lHnjiYkPouAfBbgeyg9umctBTQA7m/uCelnOcXkz6H/S0DedIwEb3jc3HJw==
X-Received: by 2002:a05:6a00:a8a:b029:30c:a10b:3e3f with SMTP id b10-20020a056a000a8ab029030ca10b3e3fmr21536386pfl.40.1627370030492;
        Tue, 27 Jul 2021 00:13:50 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id v9sm2361542pfn.22.2021.07.27.00.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:13:49 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        anand.jain@oracle.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Subject: [PATCH v2] btrfs: fix rw device counting in __btrfs_free_extra_devids
Date:   Tue, 27 Jul 2021 15:13:03 +0800
Message-Id: <20210727071303.113876-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When removing a writeable device in __btrfs_free_extra_devids, the rw
device count should be decremented.

This error was caught by Syzbot which reported a warning in
close_fs_devices because fs_devices->rw_devices was not 0 after
closing all devices. Here is the call trace that was observed:

  btrfs_mount_root():
    btrfs_scan_one_device():
      device_list_add();   <---------------- device added
    btrfs_open_devices():
      open_fs_devices():
        btrfs_open_one_device();   <-------- writable device opened,
	                                     rw device count ++
    btrfs_fill_super():
      open_ctree():
        btrfs_free_extra_devids():
	  __btrfs_free_extra_devids();  <--- writable device removed,
	                              rw device count not decremented
	  fail_tree_roots:
	    btrfs_close_devices():
	      close_fs_devices();   <------- rw device count off by 1

As a note, prior to commit cf89af146b7e ("btrfs: dev-replace: fail
mount if we don't have replace item with target device"), rw_devices
was decremented on removing a writable device in
__btrfs_free_extra_devids only if the BTRFS_DEV_STATE_REPLACE_TGT bit
was not set for the device. However, this check does not need to be
reinstated as it is now redundant and incorrect.

In __btrfs_free_extra_devids, we skip removing the device if it is the
target for replacement. This is done by checking whether device->devid
== BTRFS_DEV_REPLACE_DEVID. Since BTRFS_DEV_STATE_REPLACE_TGT is set
only on the device with devid BTRFS_DEV_REPLACE_DEVID, no devices
should have the BTRFS_DEV_STATE_REPLACE_TGT bit set after the check,
and so it's redundant to test for that bit.

Additionally, following commit 82372bc816d7 ("Btrfs: make
the logic of source device removing more clear"), rw_devices is
incremented whenever a writeable device is added to the alloc
list (including the target device in btrfs_dev_replace_finishing), so
all removals of writable devices from the alloc list should also be
accompanied by a decrement to rw_devices.

Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Tested-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 807502cd6510..916c25371658 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 			list_del_init(&device->dev_alloc_list);
 			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
+			fs_devices->rw_devices--;
 		}
 		list_del_init(&device->dev_list);
 		fs_devices->num_devices--;
-- 
2.25.1

