Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2158C48037
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 13:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfFQLH7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 07:07:59 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58845 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfFQLH7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 07:07:59 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHXSD-1hphfV0scb-00DVxN; Mon, 17 Jun 2019 13:07:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: shut up bogus -Wmaybe-uninitialized warning
Date:   Mon, 17 Jun 2019 13:07:28 +0200
Message-Id: <20190617110738.2085060-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RwSP0+7X1t5QgfnR4q2ka6Ub+2Jpijl+t/7jQ+Cr6YedH8bQ/kk
 KlwYdwGAsCgOFZxO+/Tk5lUAJ6L4zcSnDfCLne0M9V4bgUiCLO7+ZJKGk3W0jqQR8t45u4E
 CTnWr2+Q54ccHMIZaPz3ZGIX1iiX4MuBGoYXBtIWRHRcs/7NPEfMpEssxcZWLv44nQR3HK+
 sN0qCUmYyVwcme/AmDovw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:74SFdUEmAU0=:nBS2O7j265199nWBNA5Nh9
 6MWecxFoNhTv7OmvGH3GUBiQCKuG/P3j04jZPev7JDSiGnM0zj9Nl0HAg20iGDopxa3Owhgk6
 dPLoUQ64VnojWCYjvGPKqBRmXsmL0hfoYO9MiRpmv1EgCCitTrZuZt/joI6I9S6peAXLticoC
 ZWFG0jO9ZlJmTceF2i2AGjU2fsB/AAfreqhN7t+RzFgEDMc/8jicyCIF4A/Gvc2r0wLu5FARc
 X8Am4PVte2ibalNo5MrFnmkz22QxUttBx26TVHpN8FsvunArGw1Cj/j2KmwYICdG2dCELMg7s
 KgiU8KYsTGdJIlf17L/txxlizwZE49Urh8GEdqi5fWh45/F7CLGSccMTr3aGdnWFxXZV7oIRy
 c9lrNoYY6UNk93kT9BTa/dndPhv3JLK/PLqw6SU9vuMPjCo/T04wQGANJ2L7F0krD1F+kwoci
 nfdOtgG9zw4MTFO/tqXMvNYYq+8nBbo97FxWhC12pQlqTc0ABZaPAHv3/h4RVKD3A4LUe0kAF
 YaX36zxm55/7/XPAzw2Bw3JsNOHVcc1fIb1WzMuwrc0+fvI9o9y8Kfb9Tkn6EhjH77TloJuTH
 8Seahx15DtyZHeLokPlMae6yUfQOLRILo1R65aCxYzftBZ99xXOmh5xiBvV1gMb0w2z1fefdW
 pQ/lC6BmyRdNB0uMguG+AGpuQ68Di5wnh9l7KN7yivg58Y+AnxWPrO+8zjWpFOuZBcxYVWqFf
 LN9NcaFv5GEXXBL4zeQ4pzPkT6mHU4HeiqJxkg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

gcc sometimes can't determine whether a variable has been initialized
when both the initialization and the use are conditional:

fs/btrfs/props.c: In function 'inherit_props':
fs/btrfs/props.c:389:4: error: 'num_bytes' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    btrfs_block_rsv_release(fs_info, trans->block_rsv,

This code is fine. Unfortunately, I cannot think of a good way to
rephrase it in a way that makes gcc understand this, so I add
a bogus initialization the way one should not.

Fixes: d7400ee1b476 ("btrfs: use the existing reserved items for our first prop for inheritance")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/props.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index a9e2e66152ee..9d47ae1cf5b2 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -341,7 +341,7 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 	for (i = 0; i < ARRAY_SIZE(prop_handlers); i++) {
 		const struct prop_handler *h = &prop_handlers[i];
 		const char *value;
-		u64 num_bytes;
+		u64 num_bytes = 0;
 
 		if (!h->inheritable)
 			continue;
-- 
2.20.0

