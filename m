Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B0D119260
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 21:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLJUom (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 15:44:42 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:35431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 15:44:42 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M5fQq-1id9Xg41sY-007E8Y; Tue, 10 Dec 2019 21:44:31 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: fix format string warning
Date:   Tue, 10 Dec 2019 21:44:16 +0100
Message-Id: <20191210204429.3383471-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fkWU2dqOu7RW9WJgIGMm6dYvGG94Cinc06kMtHqOqNk38iTxfmg
 k5h9IqQvu5n3E5gEjn2ilcUrVt93b5dMbPlbqjic9mt5UivT5iS6LlhARBRv3M6mUh2SEHx
 FDEdnLS2YOpxM94nghEDd7AAJ1sTg+mMGmLxA5WvewuxEiCVD7Wz3o2sM4zIId29q2llC50
 XGfZi2mAR9gfvAPYv/isg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tSW74QnZ+WA=:86kHDUdr9lu5Hyau6Eigur
 /LIAAzY68Nt59XSEtNSVGAqm3w/ECsvQtcWhoOkf/sJ/ek8X4OyXrn5nhr5EUWM5DgfO7wMVm
 NDkI3eiWSH5QT0ywy00s2v80DVGePzi3vSw2OPPDD9Iw8NADylRjSSM6h9cLAfK7/two115RX
 jIeTHC9ZZiJWcvPjfxBydYy3IrZU8TkL3nPKYLgmnRQKXYU5w6GTWp2dnazGDNbhW2Dwb+O0l
 UuwMnZgWRZqSlGDcic5clXiSwXX6c838y0p+mKoGM4ixNn2cqUyshLZlWoTDXErF565aIvSBB
 jPxPL38OwkF08Zjsyjj2FnkuuEh6E0wsuegp2c4gXdl3Gd+Srp8TDK/3XrnT9K+cgJbZyjy8f
 RqPWfx4yc/s3jb/CbS9VMxR5tqP4PRrDNGBnuobvIOQZ1ELY8PLQ1SzRZwQq/E1w5CeUy6IPB
 f5gLL+7tOTSK8OIsCdLvGC0nqh1+TYv/5ciEXRFAlocGqKjhqgdBBEvwrnElXpM8SzJi9bye4
 3nvxe4xm5fER5DTJcbp9D7FGDX03unqJaSfp3Jl0vc2H0kjXvoAjODIrNlASGa/COIq2/8/m1
 rB4ZjpxqqqVJnZ3EpBl5puakwOcqizaSXuOd94gow99knEkj5Aqtw2A4U6mA3mO2t4eu8CwwR
 DfQFZsvjX2doTGMdwEinT8qylA3wYS4nqsCqGWfkyEpQLFZfytIV+Wed4LGzJisJw+0shcMX5
 477gpw+FG4Wgn33+LT9nxmAjFwsc7m9RsLsztI4t2tvJscwyKyyNFi9v0PKVGi8yeQWW6YUtY
 i8v85XPmt3G8LHEua30p9ohkpIya5EPAh4adkFGsoNatLbdhLurfliilBnWhJYK/YQNToL1M9
 oDSgwx3aaR/Qk9eznaoQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To print a size_t, the format string modifier %z should be used instead
of %l:

fs/btrfs/tree-checker.c: In function 'check_extent_data_item':
fs/btrfs/tree-checker.c:230:43: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Werror=format=]
     "invalid item size, have %u expect [%lu, %u)",
                                         ~~^
                                         %u

Fixes: 153a6d299956 ("btrfs: tree-checker: Check item size before reading file extent type")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 493d4d9e0f79..092b8ece36d7 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -227,7 +227,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	 */
 	if (item_size < BTRFS_FILE_EXTENT_INLINE_DATA_START) {
 		file_extent_err(leaf, slot,
-				"invalid item size, have %u expect [%lu, %u)",
+				"invalid item size, have %u expect [%zu, %u)",
 				item_size, BTRFS_FILE_EXTENT_INLINE_DATA_START,
 				SZ_4K);
 		return -EUCLEAN;
-- 
2.20.0

