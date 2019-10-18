Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7EADCAA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 18:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbfJRQOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 12:14:39 -0400
Received: from smtp1.rz.tu-harburg.de ([134.28.205.38]:37094 "EHLO
        smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfJRQOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 12:14:39 -0400
Received: from mail.tu-harburg.de (mail4.rz.tu-harburg.de [134.28.202.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tuhh.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 46vrhX0ZPjzxW4;
        Fri, 18 Oct 2019 18:14:36 +0200 (CEST)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cmz7792@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 46vrhW5GMxzJrC3;
        Fri, 18 Oct 2019 18:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2019-42;
        t=1571415276; bh=8GW0juNqG9p93pmHgKk4SaNnD5EWI5XrRDuUWsj6xcU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=mOFoHuRJHAe2ew4DFWGtDmKqZPjk2EeMsAorvexkFPdY/KQovFq11djby0fETBthS
         ipBzbEVdd3BWRZp0QtxdRrwABabK1QfkXjAHsZ/GS27YK418xSnAvjNYEx/Eu4M5a5
         z6zlEZebDeaGshdo8M/66xS51B0pUHnGAadZyoV4=
From:   =?UTF-8?q?Merlin=20B=C3=BCge?= <merlin.buege@tuhh.de>
To:     merlin.buege@tuhh.de
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.cz>
Subject: [PATCH v2] btrfs-progs: small fixes/cleanup in Documentation
Date:   Fri, 18 Oct 2019 18:14:33 +0200
Message-Id: <20191018161433.148176-1-merlin.buege@tuhh.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017045006.130378-1-merlin.buege@tuhh.de>
References: <20191017045006.130378-1-merlin.buege@tuhh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The removed paragraph in btrfs-man5.asciidoc says the same as the
previous one.

Signed-off-by: Merlin Büge <merlin.buege@tuhh.de>
---
v2:
 - added SOB line
 - one more typo fix in Documentation/btrfs-man5.asciidoc

 Documentation/btrfs-man5.asciidoc |  8 +-------
 Documentation/mkfs.btrfs.asciidoc | 10 +++++-----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index 6a1a04b7..ee6010fe 100644
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
@@ -659,7 +653,7 @@ swapfile extents or may fail:
 * resize shrink - works as long as the extents are outside of the shrunk range
 * device add - a new device does not interfere with existing swapfile and this operation will work, though no new swapfile can be activated afterwards
 * device delete - if the device has been added as above, it can be also deleted
-* device replace - dtto
+* device replace - ditto
  
 When there are no active swapfiles and a whole-filesystem exclusive operation
 is running (ie. balance, device delete, shrink), the swapfiles cannot be
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

