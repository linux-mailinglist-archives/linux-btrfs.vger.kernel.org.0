Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB661ECF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 14:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfGHMwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 08:52:19 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfGHMwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jul 2019 08:52:19 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MJEpp-1i3VP02DD1-00KhBy; Mon, 08 Jul 2019 14:51:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: add back libcrc32c Kconfig dependency
Date:   Mon,  8 Jul 2019 14:51:29 +0200
Message-Id: <20190708125134.3741552-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AWoLOmaQqVkujvlZOGfqeO7XSmN82N7FdvLMZoC0P6AUFUFZx48
 WLw5ya4uxvD4RRH6XtfdIFn0CZClvtQ6PP9bIixsrEYcn9IuAq6md22ylxX6t4ZC4A4dnEc
 8SE9zATLkC30w5tVjHlsa8qBcXCbTRNlC19z22fsFdVr8UMMtbHqzeH95nZ5by2OhMmffGD
 HKJCWhtTExVikb3F7CM+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q0Mbfm6OUnM=:WepD4bGaXeT2jygN77K7/e
 JtZxBq72jVyz4n3NocspMdXbdCOiDyrnzOFrT45GBFacOHN7pOMMPbMW2z2V1KIYQGr+mlmUe
 bkUg0+rgPHCDZLpF9LY8FmmEofm4Tj4NkVtvpLGXNsjiBaX8gtChAL4LNdmShZR4J2nY2OVF2
 wHm/HD4K81gvd/Df5Zb8EkmpvqBXnxAXda66FFl/m6bXa1+St1QMyEdf2l1TBL2OYlmA4T8qe
 fTsX55LGvg/4UguDYH3ixkjiuwMtXrrp3QLcLSW1hcveo+/Lsaq9h4wUkI9dRkArWaN12t/X2
 Imvt7mL5BOD+OvVtp6HQa/CSxq++5h6b08dSBI9+/LYs9WIuB2hqSfvbZ++q+L5MQU8r3W/Od
 AGwgIj8FgfBMGD02uhYHCqQ2k/nGKkYAckIn1D3KQD1xJB0eLbLbxxP1JYQLOPjF4AGibyb7N
 N6/2W1icPIrIKn1GPl1Hm06wjTVWTLyCQonTUIlASJpvyzbUT+q80w5sglcFH0y8IweN3UbAI
 2jYleIMtFYxJvY3MoISNxEJZ2V/bYbYnh2s2PRNLKYZvloqKmU0/pm7ZNqz78SXkrPnkDtQ4F
 SM2zYC29uG4wb99GdrSU/nMZDt4UgXFO0pb4qcBLF86YX/1iUnJIXtCu8R3IiuXViPSv8Bv9K
 Ly4eiK5P1GMDn4hE5Gnu+0Y9LyIX078toPMPOq0/8fMzip/94bS+6ViIbON1maNfhn7CkmuZr
 Uk41zkVAUDjnpyv0Mzl3avcCHyR5gfpGmnf1Hw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While part of btrfs now uses the crypto shash interfaces
for crc32c, we still get a build time dependency in other
places:

fs/btrfs/super.o: In function `btrfs_mount_root':
super.c:(.text+0xc0d4): undefined reference to `crc32c_impl'
fs/btrfs/super.o: In function `btrfs_print_mod_info':
super.c:(.init.text+0x3e28): undefined reference to `crc32c_impl'
fs/btrfs/extent-tree.o: In function `lookup_inline_extent_backref':
extent-tree.c:(.text+0x17750): undefined reference to `crc32c'
fs/btrfs/extent-tree.o:extent-tree.c:(.text+0x177f4): more undefined references to `crc32c' follow

Change Kconfig to depend on both.

Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 2521a24f74be..aa7453d44e59 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -3,6 +3,7 @@
 config BTRFS_FS
 	tristate "Btrfs filesystem support"
 	select CRYPTO
+	select LIBCRC32C
 	select CRYPTO_CRC32C
 	select CRYPTO_SHA256
 	select ZLIB_INFLATE
-- 
2.20.0

