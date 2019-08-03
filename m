Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8B180870
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfHCVoF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 17:44:05 -0400
Received: from smtp.dpl.mendix.net ([83.96.177.10]:50072 "EHLO
        smtp.dpl.mendix.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfHCVoF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Aug 2019 17:44:05 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Aug 2019 17:44:04 EDT
Received: from mekker.bofh.dpl.mendix.net (mekker.bofh.dpl.mendix.net [IPv6:2001:828:13c8:10b::21])
        by smtp.dpl.mendix.net (Postfix) with ESMTP id CBF4D202A9;
        Sat,  3 Aug 2019 23:44:03 +0200 (CEST)
From:   Hans van Kranenburg <hans@knorrie.org>
To:     linux-btrfs@vger.kernel.org
Cc:     Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Subject: [PATCH] btrfs-progs: docs: fix label property description
Date:   Sat,  3 Aug 2019 23:44:03 +0200
Message-Id: <20190803214403.1040-1-hans@knorrie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Hans van Kranenburg <hans.van.kranenburg@mendix.com>

Recently, commit c9da5695b2 improved the description for the label
property, to clarify it's a filesystem property, and not a device
property. Follow this change in the man page for btrfs-property.

Also add a little hint about what to specify as object.

Signed-off-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
---
 Documentation/btrfs-property.asciidoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/btrfs-property.asciidoc b/Documentation/btrfs-property.asciidoc
index b562717b..47960833 100644
--- a/Documentation/btrfs-property.asciidoc
+++ b/Documentation/btrfs-property.asciidoc
@@ -43,7 +43,8 @@ the following:
 ro::::
 read-only flag of subvolume: true or false
 label::::
-label of device
+label of the filesystem. For an unmounted filesystem, provide a path to a block
+device as object. For a mounted filesystem, specify a mount point.
 compression::::
 compression algorithm set for an inode, possible values: 'lzo', 'zlib', 'zstd'.
 To disable compression use "" (empty string), 'no' or 'none'.
-- 
2.20.1

