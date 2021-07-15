Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5023C9CC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbhGOKh1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 06:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhGOKh0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 06:37:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D07DC06175F;
        Thu, 15 Jul 2021 03:34:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso5918749pjc.0;
        Thu, 15 Jul 2021 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oSd5AIwHXyRxmbXI7YN1Do3jrBN/ZwcUGcPjvgZeFk=;
        b=AFHnbrvTfgXatGFDpeKuSk4yYxFCvxAArkKWMB2xhrzPriZ/ItDVwlf7rzN6cGdXKS
         aMvgfdXg19XYmqFFhWHPqLHctEIDlFvgNxMAItXD8hJQNgnZMOHUiIcbjEzMmp9/+7Fy
         xWD8qhbnLO+NFEyMxNiPj2PuX2wtqXQTTcmSx18tbeTcKkZBj8DJ9ZWe0DbhX/xavYan
         LeBhysNvsvj3U/jrYtUvwi0Zj2D/vMWyI7hdstrBLS5uTMeYaOGNOUDM1EMRAtASVbgP
         WvLSIXnwdZoHmrVNYWqAyk1bWRwcXU1XHdxAQO4Q8FhtLU52cdQL3c1z1Rt431Wg+a+L
         ux2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oSd5AIwHXyRxmbXI7YN1Do3jrBN/ZwcUGcPjvgZeFk=;
        b=Jlz9yRREoEOb9ZIA89kf/RtNhqvNZJNJNUxRVnT3aCgid0RfbgtpfS87rO2/D1yMxS
         STMTqawEvxyTK++XF1mm3WOfO3c1/aqYO3TiRio9TesH7jz9Ppdrad91FqYJrUN50thC
         6gM8HZOVykr/gpi/HW7VFaHXHC/MzMRQW6SNAaZ66Rf6c//qQxJmyClHufrgesY0eF1f
         ct9ZL6L2PU2vOcT0dUyFj8dxWxkisROU1YS2ZHjnYVjG2joffezOCOgpcfj4qFKZerud
         a5CgvWFWbCtnB5+XCLfteL+cnZYNnK49XHThfS8siTu4ZgL1dDj4T4xZFJ7Qs+2nBlZo
         DJVw==
X-Gm-Message-State: AOAM530IF0a5/NERFKwswMHYlxide7v0YBm4K2SbSTTIdjUrtNHFDwtl
        yclNNX/euC1be1cknhkpUUA=
X-Google-Smtp-Source: ABdhPJzsgVuM1EhE0Bt1tm9UkzYH3XoF5+771CCc0YfNyBorSFfKh1zma+esEJdf3zhFYWz2Y4Kgpw==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr9659205pjo.177.1626345272037;
        Thu, 15 Jul 2021 03:34:32 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id e18sm6059326pfc.85.2021.07.15.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 03:34:31 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        anand.jain@oracle.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: fix rw device counting in __btrfs_free_extra_devids
Date:   Thu, 15 Jul 2021 18:34:03 +0800
Message-Id: <20210715103403.176695-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Syzbot reports a warning in close_fs_devices that happens because
fs_devices->rw_devices is not 0 after calling btrfs_close_one_device
on each device.

This happens when a writeable device is removed in
__btrfs_free_extra_devids, but the rw device count is not decremented
accordingly. So when close_fs_devices is called, the removed device is
still counted and we get an off by 1 error.

Here is one call trace that was observed:
  btrfs_mount_root():
    btrfs_scan_one_device():
      device_list_add();   <---------------- device added
    btrfs_open_devices():
      open_fs_devices():
        btrfs_open_one_device();   <-------- rw device count ++
    btrfs_fill_super():
      open_ctree():
        btrfs_free_extra_devids():
	  __btrfs_free_extra_devids();  <--- device removed
	  fail_tree_roots:
	    btrfs_close_devices():
	      close_fs_devices();   <------- rw device count off by 1

Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Tested-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
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

