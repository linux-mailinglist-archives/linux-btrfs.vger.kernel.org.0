Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61482174AE8
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 04:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCADbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Feb 2020 22:31:00 -0500
Received: from gateway34.websitewelcome.com ([192.185.147.201]:34428 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727242AbgCADbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Feb 2020 22:31:00 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id D8CFC19782B
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Feb 2020 21:30:57 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 8FJhj3HhcAGTX8FJhjBx1T; Sat, 29 Feb 2020 21:30:57 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7yjwzpwQ7WlL/tY/iZN1OoFqu0M1nW0pOX6drwC/UM0=; b=GQz2Du2bIh0BXQ/mhpk4R1qk53
        Yp5bl0ETHGySAQeKr5ZjVvg3MEDVItxH4OInwV1KY4yEPCGHeJb5ID/ys0umFP35NzuY6bHCHIcyc
        gTWN+WKRC6eGmmllML4trCekXTAqgu9i36fYdVccOk/4W3HPGKnLJmINAVOPjfAIWHVbq3WcO4xMS
        8+bwFRQ5DlVpwniFEU+wakm08iB4jQqblmyEPjsvATBylPL8M01+zD7GJAo3n/elIKnKohfHFYBEF
        5XX9c3mWDJvPOWxtcHE+Dp+NrsqiMjYfw8p8DnwRxIb149ariN2/lq2SuQXWPtK9NN9tpwso6SgMY
        xYVURSAA==;
Received: from 179.187.200.220.dynamic.adsl.gvt.net.br ([179.187.200.220]:36120 helo=hephaestus.suse.cz)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j8FJh-0003yt-6N; Sun, 01 Mar 2020 00:30:57 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] progs: Remove manpages of not packaged binaries
Date:   Sun,  1 Mar 2020 00:33:42 -0300
Message-Id: <20200301033344.808-2-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200301033344.808-1-marcos@mpdesouza.com>
References: <20200301033344.808-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.187.200.220
X-Source-L: No
X-Exim-ID: 1j8FJh-0003yt-6N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179.187.200.220.dynamic.adsl.gvt.net.br (hephaestus.suse.cz) [179.187.200.220]:36120
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

btrfs-find-root and btrfs-select-super stopped to be shipped in 2014, so
remove all references to these manpages as well.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 .gitignore                                |  2 -
 Documentation/Makefile.in                 |  2 -
 Documentation/btrfs-find-root.asciidoc    | 35 -----------------
 Documentation/btrfs-select-super.asciidoc | 46 -----------------------
 Documentation/btrfs.asciidoc              |  2 -
 5 files changed, 87 deletions(-)
 delete mode 100644 Documentation/btrfs-find-root.asciidoc
 delete mode 100644 Documentation/btrfs-select-super.asciidoc

diff --git a/.gitignore b/.gitignore
index aadf9ae7..2b1c1aef 100644
--- a/.gitignore
+++ b/.gitignore
@@ -73,7 +73,6 @@
 /Documentation/btrfs-convert.8
 /Documentation/btrfs-device.8
 /Documentation/btrfs-filesystem.8
-/Documentation/btrfs-find-root.8
 /Documentation/btrfs-image.8
 /Documentation/btrfs-inspect-internal.8
 /Documentation/btrfs-ioctl.3
@@ -87,7 +86,6 @@
 /Documentation/btrfs-rescue.8
 /Documentation/btrfs-restore.8
 /Documentation/btrfs-scrub.8
-/Documentation/btrfs-select-super.8
 /Documentation/btrfs-send.8
 /Documentation/btrfs-subvolume.8
 /Documentation/btrfs.8
diff --git a/Documentation/Makefile.in b/Documentation/Makefile.in
index d35cb858..ff0459c0 100644
--- a/Documentation/Makefile.in
+++ b/Documentation/Makefile.in
@@ -4,10 +4,8 @@ MAN8_TXT =
 # Top level commands
 MAN8_TXT += btrfs.asciidoc
 MAN8_TXT += btrfs-convert.asciidoc
-MAN8_TXT += btrfs-find-root.asciidoc
 MAN8_TXT += btrfs-image.asciidoc
 MAN8_TXT += btrfs-map-logical.asciidoc
-MAN8_TXT += btrfs-select-super.asciidoc
 MAN8_TXT += btrfstune.asciidoc
 MAN8_TXT += fsck.btrfs.asciidoc
 MAN8_TXT += mkfs.btrfs.asciidoc
diff --git a/Documentation/btrfs-find-root.asciidoc b/Documentation/btrfs-find-root.asciidoc
deleted file mode 100644
index 652796c8..00000000
--- a/Documentation/btrfs-find-root.asciidoc
+++ /dev/null
@@ -1,35 +0,0 @@
-btrfs-find-root(8)
-==================
-
-NAME
-----
-btrfs-find-root - filter to find btrfs root
-
-SYNOPSIS
---------
-*btrfs-find-root* [options] <device>
-
-DESCRIPTION
------------
-*btrfs-find-root* is used to find the satisfied root, you can filter by
-root tree's objectid, generation, level.
-
-OPTIONS
--------
--a::
-Search through all metadata extents, even the root has been already found.
--g <generation>::
-Filter root tree by it's original transaction id, tree root's generation in default.
--o <objectid>::
-Filter root tree by it's objectid,tree root's objectid in default.
--l <level>::
-Filter root tree by B-+ tree's level, level 0 in default.
-
-EXIT STATUS
------------
-*btrfs-find-root* will return 0 if no error happened.
-If any problems happened, 1 will be returned.
-
-SEE ALSO
---------
-`mkfs.btrfs`(8)
diff --git a/Documentation/btrfs-select-super.asciidoc b/Documentation/btrfs-select-super.asciidoc
deleted file mode 100644
index e3bca98b..00000000
--- a/Documentation/btrfs-select-super.asciidoc
+++ /dev/null
@@ -1,46 +0,0 @@
-btrfs-select-super(8)
-=====================
-
-NAME
-----
-btrfs-select-super - overwrite primary superblock with a backup copy
-
-SYNOPSIS
---------
-*btrfs-select-super* -s number <device>
-
-DESCRIPTION
------------
-Destructively overwrite all copies of the superblock
-with a specified copy.  This helps in certain cases, for example when write
-barriers were disabled during a power failure and not all superblocks were
-written, or if the primary superblock is damaged, eg. accidentally overwritten.
-
-The filesystem specified by 'device' must not be mounted.
-
-NOTE: *Prior to overwriting the primary superblock, please make sure that the backup
-copies are valid!*
-
-To dump a superblock use the *btrfs inspect-internal dump-super* command.
-
-Then run the check (in the non-repair mode) using the command *btrfs check -s*
-where '-s' specifies the superblock copy to use.
-
-Superblock copies exist in the following offsets on the device:
-
-- primary: '64KiB' (65536)
-- 1st copy: '64MiB' (67108864)
-- 2nd copy: '256GiB' (274877906944)
-
-A superblock size is '4KiB' (4096).
-
-OPTIONS
--------
--s|--super <superblock>::
-use 'superblock'th superblock copy, valid values are 0 1 or 2 if the
-respective superblock offset is within the device size
-
-SEE ALSO
---------
-`btrfs-inspect-internal`(8),
-`btrfsck check`(8)
diff --git a/Documentation/btrfs.asciidoc b/Documentation/btrfs.asciidoc
index 1625f6d8..e3328942 100644
--- a/Documentation/btrfs.asciidoc
+++ b/Documentation/btrfs.asciidoc
@@ -115,8 +115,6 @@ Tools that are still in active use without an equivalent in *btrfs*:
 
 *btrfs-convert*:: in-place conversion from ext2/3/4 filesystems to btrfs
 *btrfstune*:: tweak some filesystem properties on a unmounted filesystem
-*btrfs-select-super*:: rescue tool to overwrite primary superblock from a spare copy
-*btrfs-find-root*:: rescue helper to find tree roots in a filesystem
 
 Deprecated and obsolete tools:
 
-- 
2.25.0

