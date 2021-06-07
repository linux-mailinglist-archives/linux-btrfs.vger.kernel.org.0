Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838DB39D638
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFGHou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 03:44:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60612 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGHou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 03:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623051779; x=1654587779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q4b4Rnc45MZM8imwNALBSWNDEVUiNL0LjMNA52wznBA=;
  b=SdOEjbXSEwTblU8qz0/c2kTu2QOBQyFR4NPHFO4sX7xJ4VUTtfAbrP+b
   S23xkYsZ/22XoLigaSGLPSqT2iUB2SbswxTDxMwc/n6wCfcFRpYzJLuja
   vWxaEkmUtPNejrw4iukxqSt5wSKOKdIhtr7NznrtQuHvY2USjzUso9YjJ
   Rs2Q5oWIIbDzaCOhcfd/MrPcgUoW98OgItrPe9zUfobFBOY8ko/Mgv4NL
   iui4LMHj0hPAmFnrrayAXxpfJZfP6uHViZUW7kYVXWU5YJU8g2CYOS4XG
   MCaLDgoNlQ03uImdijUa6LKSZL/kMSQOIPMPQrGEPD370IzM+/7T4kxs9
   g==;
IronPort-SDR: /w5YroRa0OKdHZjJbnAQIwUD7jLyIW8kgX5QABgUAexx8MzYxqi9VAkNXugRhbNpjJ+SayUk5Q
 cy0aoYSSUVUTgHpXH0WXJA1xVTVZ2yImpz4LQlvN2/kG7uuC4eNDNKNnB/I/VN3kY2DSIRSWtk
 2I6kgAo8m4yLQn7JKIescpbQVrX2qD9DwA0VSQCGeE0Or4J/clur8ay3CkT8MVKRHYN17dkICC
 ax6sJj/GO/Ko2cQI2gxOvoKaZhAlBADeiiMvdIf0a8Xr46jGMn+xbrwtxbdC3MuMlOw05TcXO6
 3ZE=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; 
   d="scan'208";a="170284546"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 15:42:58 +0800
IronPort-SDR: z/dLd9jgni1ai00l+cyF+GHLciS7D4Z/FT3off+1mQ9HjuU2/UuzpS+aBQJ1esXvv4cNDDNH7u
 fo52g3XiF7Kh/3QmwRbuZxInV6xx4fxc7XbqozEgwgLaHl3gGTE1G7lKGf2COIl5BsM+0uDYJ/
 l0iPQVDKSczKFJoRtQoj3DO6hrnBPRGtz2BGxAe1xFKXn3ioUvqg8HvgLuIGPuk0fQNMu6xz/J
 K5Ca+qUja6pH+sN5JDIx7k5C+X7RyfogJtw6Iw9Fh6r5twXAE8hRvtrlA7utnrtpg3inXjZ/xw
 MxVBS3io90ZL8Ixi+womvfi2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 00:20:41 -0700
IronPort-SDR: 39JTfjNJNj7x3/eQqPy2Tb9Lhw1peHwS76j9ElBbpPk06L6/SN3QIl7U5WGMpcXgqDgyGTQPrI
 8UDXyqcwd2SrQmen9UZwzVWG3Z2LMs60X8a6DWs3jKNwE9fjJYIgaXezjP5GxvFA5YFO2jFHrP
 WOzuRllObUwfXauRT7rrN62SzuoJRTHdHY86vkdC945AMuKKyIUOUPXXdu+luPHqjhqZ+UksId
 0XDRhitNQrnIDJLFVXmbdHOmciYwBfMTYy97B/F7iKl6fd3xHzb23Cc6carLC7yxM/osCNqi7W
 sSk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2021 00:42:58 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove unused btrfs_{set,clear}_pending_and_info macros
Date:   Mon,  7 Jun 2021 16:42:49 +0900
Message-Id: <9a2e763258dd00074e682f3783ec2156afff8450.1623051748.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 5297199a8bca ("btrfs: remove inode number cache feature") removed
the last user, but forgot to remove the macros as well. Let's do that now.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c601f6733576..c3a275519f06 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1464,30 +1464,6 @@ do {									\
 #define btrfs_clear_pending(info, opt)	\
 	clear_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
 
-/*
- * Helpers for setting pending mount option changes.
- *
- * Expects corresponding macros
- * BTRFS_PENDING_SET_ and CLEAR_ + short mount option name
- */
-#define btrfs_set_pending_and_info(info, opt, fmt, args...)            \
-do {                                                                   \
-       if (!btrfs_raw_test_opt((info)->mount_opt, opt)) {              \
-               btrfs_info((info), fmt, ##args);                        \
-               btrfs_set_pending((info), SET_##opt);                   \
-               btrfs_clear_pending((info), CLEAR_##opt);               \
-       }                                                               \
-} while(0)
-
-#define btrfs_clear_pending_and_info(info, opt, fmt, args...)          \
-do {                                                                   \
-       if (btrfs_raw_test_opt((info)->mount_opt, opt)) {               \
-               btrfs_info((info), fmt, ##args);                        \
-               btrfs_set_pending((info), CLEAR_##opt);                 \
-               btrfs_clear_pending((info), SET_##opt);                 \
-       }                                                               \
-} while(0)
-
 /*
  * Inode flags
  */
-- 
2.31.1

