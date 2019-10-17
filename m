Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59964DA4DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 06:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392474AbfJQE4l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 00:56:41 -0400
Received: from smtp1.rz.tu-harburg.de ([134.28.205.38]:34622 "EHLO
        smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfJQE4l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 00:56:41 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Oct 2019 00:56:39 EDT
Received: from mail.tu-harburg.de (mail4.rz.tu-harburg.de [134.28.202.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tuhh.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 46txYD27LRzxbM
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2019 06:50:08 +0200 (CEST)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cmz7792@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 46txYD0McFzJrC3;
        Thu, 17 Oct 2019 06:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2019-42;
        t=1571287808; bh=KLj1FOyDc3LsdZBuFNcP6b1nB0cWVuiKFZ9NfEAOfHA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=b+VP0/7ePT4Ln+tCptweAZTxMuiMktPTfkbJwcxkJsfTXQM6Gm6l/YIY6Q8fedpuU
         Y7CiWKj0SRggWT+f8CUC508UaGxXuNZ1yUq+xHtSuu+1mwJKmlzMvfKLfOXFcf7L0/
         PvqIhpH6bozTNvSyTdYt1dktsCXYODExtJGq+9ro=
From:   =?UTF-8?q?Merlin=20B=C3=BCge?= <merlin.buege@tuhh.de>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?Merlin=20B=C3=BCge?= <merlin.buege@tuhh.de>
Subject: [PATCH] btrfs-progs: small fixes/cleanup in Documentation
Date:   Thu, 17 Oct 2019 06:50:06 +0200
Message-Id: <20191017045006.130378-1-merlin.buege@tuhh.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The removed paragraph in btrfs-man5.asciidoc says the same as the
previous one.
---
 Documentation/btrfs-man5.asciidoc |  6 ------
 Documentation/mkfs.btrfs.asciidoc | 10 +++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index 6a1a04b7..87ed5496 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -224,12 +224,6 @@ during a period of low system activity will prevent latent interference with
 the performance of other operations. Also, a device may ignore the TRIM command
 if the range is too small, so running a batch discard has a greater probability
 of actually discarding the blocks.
-+
-If discarding is not necessary to be done at the block freeing time, there's
-`fstrim`(8) tool that lets the filesystem discard all free blocks in a batch,
-possibly not much interfering with other operations. Also, the device may
-ignore the TRIM command if the range is too small, so running the batch discard
-can actually discard the blocks.
 
 *enospc_debug*::
 *noenospc_debug*::
diff --git a/Documentation/mkfs.btrfs.asciidoc b/Documentation/mkfs.btrfs.asciidoc
index 2a1c3592..ef3eb13f 100644
--- a/Documentation/mkfs.btrfs.asciidoc
+++ b/Documentation/mkfs.btrfs.asciidoc
@@ -27,17 +27,17 @@ mkfs.btrfs uses the entire device space for the filesystem.
 
 *-d|--data <profile>*::
 Specify the profile for the data block groups.  Valid values are 'raid0',
-'raid1', 'raid5', 'raid6', 'raid10' or 'single' or dup (case does not matter).
+'raid1', 'raid5', 'raid6', 'raid10' or 'single' or 'dup' (case does not matter).
 +
-See 'DUP PROFILES ON A SINGLE DEVICE' for more.
+See 'DUP PROFILES ON A SINGLE DEVICE' for more details.
 
 *-m|--metadata <profile>*::
 Specify the profile for the metadata block groups.
 Valid values are 'raid0', 'raid1', 'raid5', 'raid6', 'raid10', 'single' or
-'dup', (case does not matter).
+'dup' (case does not matter).
 +
-A single device filesystem will default to 'DUP', unless a SSD is detected. Then
-it will default to 'single'. The detection is based on the value of
+A single device filesystem will default to 'DUP', unless an SSD is detected, in which
+case it will default to 'single'. The detection is based on the value of
 `/sys/block/DEV/queue/rotational`, where 'DEV' is the short name of the device.
 +
 Note that the rotational status can be arbitrarily set by the underlying block
-- 
2.23.0

