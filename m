Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB941CA2AD
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 07:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgEHFdK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 01:33:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:46156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgEHFdK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 01:33:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7A4A0ADD7
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 05:33:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Doc: Add extra warning for -i option of snapshot creation
Date:   Fri,  8 May 2020 13:33:04 +0800
Message-Id: <20200508053304.27723-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

That -i option of snapshot creation can easily make qgroup inconsistent.
And unlike 'btrfs qgroup assign', the ioctl involved doesn't have way to
inform user space that qgroup is inconsistent.

So add extra warning in the man page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-subvolume.asciidoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/btrfs-subvolume.asciidoc b/Documentation/btrfs-subvolume.asciidoc
index 1de6a6febbee..70ecc641e85e 100644
--- a/Documentation/btrfs-subvolume.asciidoc
+++ b/Documentation/btrfs-subvolume.asciidoc
@@ -222,6 +222,12 @@ Make the new snapshot read only.
 -i <qgroupid>::::
 Add the newly created subvolume to a qgroup. This option can be given multiple
 times.
++
+WARNING: This parameter can make qgroup inconsistent, and due to the 
+limitation of snapshot creation ioctl, there is no way to inform user space
+that qgroup is inconsistent due to this operation.
+Please use 'btrfs qgroup assign' instead.
+
 
 *sync* <path> [subvolid...]::
 Wait until given subvolume(s) are completely removed from the filesystem after
-- 
2.26.2

