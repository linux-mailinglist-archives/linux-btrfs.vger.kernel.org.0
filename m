Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A66D486920
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbiAFRtX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 12:49:23 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:56282 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242392AbiAFRtR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 12:49:17 -0500
Received: from venice.bhome ([84.220.25.125])
        by santino.mail.tiscali.it with 
        id fVpB260072hwt0401VpDJf; Thu, 06 Jan 2022 17:49:14 +0000
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
Date:   Thu,  6 Jan 2022 18:49:03 +0100
Message-Id: <c4934d94d5a70cc30871e5599a29c690cc08eb81.1641491043.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641491043.git.kreijack@inwind.it>
References: <cover.1641491043.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1641491354; bh=asotvVmm9NKLTEMVpHnR79w3ucYdvVxl6spURN3HzNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=kz3w09NXGVzF/VViAYegYwNONURF/lE9OTATFgTo/nAi+1YrRjGUHjq/beatMNbdO
         1edIbUoCSx3B83Z9aW33sWbiMsFJlZXND3cnT//856N+W6cAPDlCqCkQicEWstMRNI
         eCT7WJoxltlxtD+LtJEbx1yjyIuIl+t9pZFrRJkg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Update the man page of the btrfs property subcommand to show the use
of the device property "allocation_hint".

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 Documentation/btrfs-property.asciidoc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/btrfs-property.asciidoc b/Documentation/btrfs-property.asciidoc
index b32d000e..70b01f68 100644
--- a/Documentation/btrfs-property.asciidoc
+++ b/Documentation/btrfs-property.asciidoc
@@ -49,6 +49,23 @@ device as object. For a mounted filesystem, specify a mount point.
 compression::::
 compression algorithm set for an inode, possible values: 'lzo', 'zlib', 'zstd'.
 To disable compression use "" (empty string), 'no' or 'none'.
+allocation_hint::::
+a device property that instructs how and when the allocator should use a
+block device.
+Possible values are:
+- 'METADATA_PREFERRED': the device has an higher priority when a new metadata
+chunk is allocated. Data chunk is allowed only if there is no other possibility.
+- 'METADATA_ONLY': the device is used only for metadata chunk.
+Data chunk is never allowed.
+- 'DATA_PREFERRED' (default): the device has an higher priority when a new data
+chunk is allocated. Metadata chunk is allowed only if there is no other
+possibility.
+- 'DATA_ONLY': the device is used only for data chunk.
+Metadata chunk is never allowed.
+ ::::
+The default is 'DATA_PREFERRED'; if all the disks have this setting the
+allocator uses all of them with the same priority.
+
 
 *list* [-t <type>] <object>::
 Lists available properties with their descriptions for the given object.
-- 
2.34.1

