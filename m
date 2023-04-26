Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCEB6EF90D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjDZRNI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjDZRNH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 13:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E7E3A8C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 10:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0033619AC
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 17:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4478C433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682529185;
        bh=jhnh5a5O6TALrGMdHSlrjYMX+EKfyylCWdlIXnKv4/0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PEXaahowU0FTDb5llb0OLO8iREk95mvCmbXwcb36FyXBSTxbwLXUa4excLezydQCJ
         7VR3zFN3M/WWrfLuKduZpipuQw0da81fG8LpR2Sm77hduHeBuYh4ZORH1HTXjTuFVU
         Tws61m/Xbjg0rkOAEwwDoAbpjrirCOCNVIeH71HX8Ryy23dBhmMo5PfSzLaY5eXPpF
         6EkTm5joqcKTTBpl5XXeqNvwa7evg/81eM/8tpPgoedRl/LfhsOmgBjIkkcymIdC+z
         m121+CtM0giI1/mrngkL/WwWyf754Fu+vZktU+X2nxfqhCStlnWVdg/VnplW9KYMsW
         RLjVQrfvm4FnQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix leak of source device allocation state after device replace
Date:   Wed, 26 Apr 2023 18:13:00 +0100
Message-Id: <e695f292be17c831e6024a743365737372a7a7aa.1682528751.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1682528751.git.fdmanana@suse.com>
References: <cover.1682528751.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When a device replace finishes, the source device is freed by calling
btrfs_free_device() at btrfs_rm_dev_replace_free_srcdev(), but the
allocation state, tracked in the device's alloc_state io tree, is never
freed.

This is a regression recently introduced by commit f0bb5474cff0 ("btrfs:
remove redundant release of btrfs_device::alloc_state"), which removed a
call to extent_io_tree_release() from btrfs_free_device(), with the
rationale that btrfs_close_one_device() already releases the allocation
state from a device and btrfs_close_one_device() is always called before
a device is freed with btrfs_free_device(). However that is not true for
the device replace case, as btrfs_free_device() is called without any
previous call to btrfs_close_one_device().

The issue is trivial to reproduce, for example, by running test btrfs/027
from fstests:

  $ ./check btrfs/027
  $ rmmod btrfs
  $ dmesg
  (...)
  [84519.395485] BTRFS info (device sdc): dev_replace from <missing disk> (devid 2) to /dev/sdg started
  [84519.466224] BTRFS info (device sdc): dev_replace from <missing disk> (devid 2) to /dev/sdg finished
  [84519.552251] BTRFS info (device sdc): scrub: started on devid 1
  [84519.552277] BTRFS info (device sdc): scrub: started on devid 2
  [84519.552332] BTRFS info (device sdc): scrub: started on devid 3
  [84519.552705] BTRFS info (device sdc): scrub: started on devid 4
  [84519.604261] BTRFS info (device sdc): scrub: finished on devid 4 with status: 0
  [84519.609374] BTRFS info (device sdc): scrub: finished on devid 3 with status: 0
  [84519.610818] BTRFS info (device sdc): scrub: finished on devid 1 with status: 0
  [84519.610927] BTRFS info (device sdc): scrub: finished on devid 2 with status: 0
  [84559.503795] BTRFS: state leak: start 1048576 end 1351614463 state 1 in tree 1 refs 1
  [84559.506764] BTRFS: state leak: start 1048576 end 1347420159 state 1 in tree 1 refs 1
  [84559.510294] BTRFS: state leak: start 1048576 end 1351614463 state 1 in tree 1 refs 1

So fix this by adding back the call to extent_io_tree_release() at
btrfs_free_device().

Fixes: f0bb5474cff0 ("btrfs: remove redundant release of btrfs_device::alloc_state")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 03f52e4a20aa..841e799dece5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -395,6 +395,7 @@ void btrfs_free_device(struct btrfs_device *device)
 {
 	WARN_ON(!list_empty(&device->post_commit_list));
 	rcu_string_free(device->name);
+	extent_io_tree_release(&device->alloc_state);
 	btrfs_destroy_dev_zone_info(device);
 	kfree(device);
 }
-- 
2.35.1

