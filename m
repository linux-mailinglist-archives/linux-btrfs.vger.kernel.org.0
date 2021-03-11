Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2C337939
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 17:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhCKQXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 11:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhCKQXW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 11:23:22 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E53C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 08:23:21 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id n79so21179633qke.3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 08:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=er+wsfS6qV0Zg3iJwacHNWjig65MH3Ew83k/QSi9X0w=;
        b=OHyPWWDZ5Vn7prNUBTH4mdqP8eUrnc0q1XAFdGdH1Gde0lscqkBVxtWZCyl26+eWMN
         wSBtekoRTRAwQn3jgeLY1fb3sz8UiVpYRH7J2Dvy325dlm56bzDaXK/dF7L4dBjEjLeQ
         ZqdUGdpqf0r/tMEFKgXxBvgg3CVelByOAlgLY+vwPg+llTKhwmBix0ShJ1WFEUDIsuFK
         8kMWjPQpceTAKiCwrDgz/5NCEhtMVpNBWL/XMKXBZ4chGIKtoe2ogVowtT2ODFVE7fzJ
         5mAc5IRNPMm5E2Vd33i3Qv0Av9RYOBcfOrUq0yyWM/VLxXbWPZ3KsWnwYAf5YicEVXFk
         Th5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=er+wsfS6qV0Zg3iJwacHNWjig65MH3Ew83k/QSi9X0w=;
        b=qDUsaYSfewgWkQKPEt9GX0TRLOz0NAkMbaTiBnbClqNRahDtNMcsYKPnS8gt+oiDdT
         qHL8hsWw2iix51RMHRUQvcPU/VV3R8eZwVhPMNBGwPa0I4W9LgCXhdM6O+44y2Oz5tsJ
         mzLRrH7HYZ8w6UzUaOppEriUZaO60hPAxDMv3GtjZPw6ZCgewsKue9Kwxmbr5wn7NrWu
         1PiHm0tgzRWuVsPvAZjbgNS7zOBLTcAzaGLm457g1RfMnUV3VACs6FNjrAS5CPNPxQVq
         FByo0ujmlS6ZfIw9O9DUrqOwOpkQOoXkILG6ZgaXRt2VwBDx/QbeKg4/Gnlom6dItimP
         8RjA==
X-Gm-Message-State: AOAM531O1UYTXU1giRdI0CebdmUVG8eJlCSwXWjVzeK9eEiePDAnDoqx
        VtlWY2na3gsk7oxV1BpTCVwhFD6C1b9tMoiF
X-Google-Smtp-Source: ABdhPJy95RdWrG/3z5Q7ejEl4lgwDGlznZmEQsrES8C4nXrMZeCrMS7pM/sJEepcezbPSFNge7zD/A==
X-Received: by 2002:a05:620a:5b3:: with SMTP id q19mr8518616qkq.98.1615479800730;
        Thu, 11 Mar 2021 08:23:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j24sm2210189qka.67.2021.03.11.08.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:23:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Neal Gompa <ngompa13@gmail.com>
Subject: [PATCH 1/3] btrfs: init devices always
Date:   Thu, 11 Mar 2021 11:23:14 -0500
Message-Id: <e5abaf864da01a3ee1cb8ef341ef1024c9e886f6.1615479658.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615479658.git.josef@toxicpanda.com>
References: <cover.1615479658.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Neal reported a panic trying to use -o rescue=all

BUG: kernel NULL pointer dereference, address: 0000000000000030
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 696 Comm: mount Tainted: G        W         5.12.0-rc2+ #296
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
RIP: 0010:btrfs_device_init_dev_stats+0x1d/0x200
RSP: 0018:ffffafaec1483bb8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff9a5715bcb298 RCX: 0000000000000070
RDX: ffff9a5703248000 RSI: ffff9a57052ea150 RDI: ffff9a5715bca400
RBP: ffff9a57052ea150 R08: 0000000000000070 R09: ffff9a57052ea150
R10: 000130faf0741c10 R11: 0000000000000000 R12: ffff9a5703700000
R13: 0000000000000000 R14: ffff9a5715bcb278 R15: ffff9a57052ea150
FS:  00007f600d122c40(0000) GS:ffff9a577bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000030 CR3: 0000000112a46005 CR4: 0000000000370ef0
Call Trace:
 ? btrfs_init_dev_stats+0x1f/0xf0
 ? kmem_cache_alloc+0xef/0x1f0
 btrfs_init_dev_stats+0x5f/0xf0
 open_ctree+0x10cb/0x1720
 btrfs_mount_root.cold+0x12/0xea
 legacy_get_tree+0x27/0x40
 vfs_get_tree+0x25/0xb0
 vfs_kern_mount.part.0+0x71/0xb0
 btrfs_mount+0x10d/0x380
 legacy_get_tree+0x27/0x40
 vfs_get_tree+0x25/0xb0
 path_mount+0x433/0xa00
 __x64_sys_mount+0xe3/0x120
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xae

This happens because when we call btrfs_init_dev_stats we do
device->fs_info->dev_root.  However device->fs_info isn't init'ed
because we were only calling btrfs_init_devices_late() if we properly
read the device root.  However we don't actually need the device root to
init the devices, this function simply assigns the devices their
->fs_info pointer properly, so this needs to be done unconditionally
always so that we can properly deref device->fs_info in rescue cases.

Reported-by: Neal Gompa <ngompa13@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 41b718cfea40..63656bf23ff2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2387,8 +2387,8 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	} else {
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 		fs_info->dev_root = root;
-		btrfs_init_devices_late(fs_info);
 	}
+	btrfs_init_devices_late(fs_info);
 
 	/* If IGNOREDATACSUMS is set don't bother reading the csum root. */
 	if (!btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
-- 
2.26.2

