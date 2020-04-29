Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BBD1BDD93
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 15:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD2N2T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 09:28:19 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgD2N2S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 09:28:18 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MMoKq-1jmYab34Dc-00IkSx; Wed, 29 Apr 2020 15:27:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        ethanwu <ethanwu@synology.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: fix gcc-4.8 build warning
Date:   Wed, 29 Apr 2020 15:27:32 +0200
Message-Id: <20200429132743.1295615-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KH1m7wBDezZNoN+FjxVuy94lMQJ9bWrd/tO1oFR2mLGheRV1NVc
 BJFLD4jjHJttqw25Pbr6KvDFQgd+GDO0hjqqZsv3Ums0GzpA3Szvlo1GfP50veB+KZdMNll
 bAYX6m8iobNXIDggtkmTBtnByz/sjOc+X4n2k/XIjKYtR2Hez3j+qdcKvKOqnGXgGHJ/vYL
 H/L47ifLbl9lRNW1SE/1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nkDSVy9ys80=:4nBoS9wW55c2TCkt9ivTYp
 XA3SRxSNTrxRdBOY5kkvKz1DvN/cCHwzEMcHlBb+cp1/bmi69RrKu9eGcZJJ/tC2ZB9gvK/JK
 hpud/f4XHLm/dIDlozxIJPdNM86N/7zBKfk0S+Mi/EUuwrQVby54x9o4lLI+nuG8ufpnCOTiR
 Xn5Efsp4bIhekUuekt/etw8vuGevbo/9mIHRQPMFmjF/V73OVF191VE7+B3xQQnnarFK2afY3
 PLGhGop3ZwiipSUiZsPep63oLpAH3Mgi8VwSZKkRbPjncUnRO7O4juAQNQNhqaPOaM9CTa0ZM
 y79PIaoICXfXYTc99bf7FCOaT/k8c3vfegg66PeF2mU0OGqPydOVm0ntYEZ/sq277RSljGIgX
 o9e25j6TZF/yyXPF1w6K4Y39wSrXTWjcLAl/pcRVVYwHimmDgwZOCdciquY8QPAcwY2ZjMwFX
 6c2mLX+3IbJU+FfI/mBR/8PZWtsX9EWN5E8enUAFJBuLD2t8mUKP+1e5uz67prehSTaR4H5+r
 AkBh6ys6UeyORzw2ktZ+aw9n6uJIUum3h3eZmUP5Uktq8b5v+YjeNaCMk6ACrVmWSIiYozdKU
 Bx8V+tjD6Hh5iMUwweqUXyauvIMQgpBQxkBfcHJZUAVTnYoI7JfBypwTNNKECzpw7ON2KZ8Z9
 I2zYerxJRtpm5SGo4u5TbcPcEFmmbV/158NO4e3xGANIxfi/nYHxjtyTI9Ujvc46XNYffBL8x
 O8ABkz2m94AfU2YKjenHku7yvRxVvfF4KK4rBIjeOfVPNKcxVvBaE9unXsjhM998jNslEuBeV
 KLGBjBPlAZxysoCtpX4r5cG3nZMzYT0oLbVpygdRizoSGCWCDM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some older compilers like gcc-4.8 warn about mismatched curly
braces in a initializer:

fs/btrfs/backref.c: In function 'is_shared_data_backref':
fs/btrfs/backref.c:394:9: error: missing braces around
initializer [-Werror=missing-braces]
  struct prelim_ref target = {0};
         ^
fs/btrfs/backref.c:394:9: error: (near initialization for
'target.rbnode') [-Werror=missing-braces]

Use the GNU empty initializer extension to avoid this.

Fixes: ed58f2e66e84 ("btrfs: backref, don't add refs from shared block when resolving normal backref")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 60a69f7c0b36..ac3c34f47b56 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -392,7 +392,7 @@ static int is_shared_data_backref(struct preftrees *preftrees, u64 bytenr)
 	struct rb_node **p = &preftrees->direct.root.rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	struct prelim_ref *ref = NULL;
-	struct prelim_ref target = {0};
+	struct prelim_ref target = {};
 	int result;
 
 	target.parent = bytenr;
-- 
2.26.0

