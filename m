Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D05B49D37C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 21:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiAZUcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 15:32:31 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:59436 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230444AbiAZUcb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 15:32:31 -0500
Received: from venice.bhome ([78.14.151.50])
        by michael.mail.tiscali.it with 
        id nYYU2600t15VSme01YYVSM; Wed, 26 Jan 2022 20:32:30 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/2] Update man page for allocator_hint property.
Date:   Wed, 26 Jan 2022 21:32:27 +0100
Message-Id: <e045ca639a2af8ce5aedff68949f968370121a2e.1643228730.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643228730.git.kreijack@inwind.it>
References: <cover.1643228730.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643229150; bh=R/Etb+t4DvZ/zcqe6oL86h3y7J2uz9HUzMv7pqaZsP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=JgM/zguFpcaQEYJJw+sMoRENYgif11JIXmFLb/1aHfGFUQRmjnF3AlyjfkEkZtaLs
         q6GvMfTRp5kT+zUu52aVsYIknbcokJ2GyDmkSotE+xkt407dOb+nPfvFTW/lTgmzG4
         BKMfAjXEbf2CjFrHtoup+zuEgg22i2UAM/AOlgbM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Update the man page of the btrfs property subcommand to show the use
of the device property "allocation_hint".

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 Documentation/btrfs-property.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/btrfs-property.rst b/Documentation/btrfs-property.rst
index 5896faa2..155839fe 100644
--- a/Documentation/btrfs-property.rst
+++ b/Documentation/btrfs-property.rst
@@ -48,6 +48,27 @@ get [-t <type>] <object> [<name>]
         compression
                 compression algorithm set for an inode, possible values: *lzo*, *zlib*, *zstd*.
                 To disable compression use "" (empty string), *no* or *none*.
+        allocation_hint
+                a device property that instructs how and when the allocator should use a
+                block device.
+                Possible values are:
+
+                METADATA_PREFERRED
+                        the device has an higher priority when a new metadata
+                        chunk is allocated. Data chunk is allowed only if there is no other
+                        possibility.
+                METADATA_ONLY
+                        the device is used only for metadata chunk.
+                        Data chunk is never allowed.
+                DATA_PREFERRED (default)
+                        the device has an higher priority when a new data
+                        chunk is allocated. Metadata chunk is allowed only if there is no other
+                        possibility.
+                DATA_ONLY
+                        the device is used only for data chunk. Metadata chunk is never allowed.
+
+                The default is 'DATA_PREFERRED'; if all the disks have this setting the
+                allocator uses all of them with the same priority.
 
 list [-t <type>] <object>
         Lists available properties with their descriptions for the given object.
-- 
2.34.1

