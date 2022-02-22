Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1204C0487
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiBVWZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiBVWZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:25:02 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77724B10AA
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:24:36 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ba20so3595941qvb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HPWL2tmV+j/82fwrmbHL/o55oDNXP1BfYYdklwaVjY0=;
        b=siV1Twnyr3I8hnL0xsoYZ2dMwewX4U51d2MnidOhBrLAlsv7mBOW2gzUjQifUCmT1j
         p3x6+4ikVGpWzRhXkTE6RuKXa/ZeVvqeueAMXm6vwjI6Jyy8m8nm+20csZN2vP71OSCW
         mO7ePmY4Y/SMYPMGPxPsyj7xpAZa9OCUZlV73g9Xrm+8+xCZxM9TYpwUMIIFlVd7oN7Z
         S4mojbosd08TuEhYBy/TZ32mgPPXbVYk+YQFJqkiC++eGPThWfFwtEhsctARubZZdYGV
         fzDOyLlN4jpEJyqqRv4bBOVG+Ow03yqzbksVwZImNCqURQhdm/GeTQ/nLo26GHwlOGu5
         TPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPWL2tmV+j/82fwrmbHL/o55oDNXP1BfYYdklwaVjY0=;
        b=L9MYZaN7xz/VGatirilMEVS7Yz5GjGXFHFOW0fqppmDHKdgkO4LT69bWSwHvS/9x+f
         6SvpsvviUineoonf4oQISYnYZG3Z3GPOqC8iRG47aXuhY6gwVdm+5uDNADn20Ly0A/jD
         4atsffZW9l+kMwlJ7N5pjyYyN76iOIDal2VO3rAxOY6YNA8LH1iH8T75rKUZ+WavimJe
         V6NU/I6ZZVbKfYT0b6gb2LLX4ca5nQTJDTKc0eb5q9vtIBs6WHbDvSOURXOJqTLESMWE
         DNRGrHIvrT/3E3fc2BK+0SOfzv9k9JdZfmlw3ZiqwLzsJBuMmQdBoy6Qiq0tYQIPiWyX
         pKZQ==
X-Gm-Message-State: AOAM531ypTMlp8g8gwIk/RxmpvXUFaYT093ZBzuMbrAOQcP4kE+73JGk
        z6bwnv0vGudEOLrbGcsaN9ba4e0KySQgKqPx
X-Google-Smtp-Source: ABdhPJyb3BRj2RoCS76m2d3KGSV8u+OeGdN8+G74Y5V4uCr8v/fW0qhJfHg4JWaNitpyDK0A4JseHA==
X-Received: by 2002:ad4:470a:0:b0:42d:b04:4d99 with SMTP id k10-20020ad4470a000000b0042d0b044d99mr20457111qvz.41.1645568675350;
        Tue, 22 Feb 2022 14:24:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bp18sm783447qtb.72.2022.02.22.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:24:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs-progs: add a test to check orphaned directories
Date:   Tue, 22 Feb 2022 17:24:31 -0500
Message-Id: <88c8c4d2d66a8367a1a66648aa6d6135fae674ac.1645568638.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568638.git.josef@toxicpanda.com>
References: <cover.1645568638.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When adding the GC support I noticed we were failing fsck when we had a
directory that hadn't been cleaned up yet because of rm -rf.  However
this isn't limited to extent-tree-v2, we'll actually fail in the same
way if we were unable to do the evict portion of the deletion and left
the orphan items around for everybody.

This is a valid file system, it'll be cleaned up properly at mount time,
so fsck shouldn't fail in this case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../052-orphan-directory/default.img.xz       | Bin 0 -> 1432 bytes
 tests/fsck-tests/052-orphan-directory/test.sh |  20 ++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 tests/fsck-tests/052-orphan-directory/default.img.xz
 create mode 100755 tests/fsck-tests/052-orphan-directory/test.sh

diff --git a/tests/fsck-tests/052-orphan-directory/default.img.xz b/tests/fsck-tests/052-orphan-directory/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..4fac926c579034d29d51065f07ede7f1528f67f7
GIT binary patch
literal 1432
zcmV;J1!wyGH+ooF000E$*0e?f03iVu0001VFXf}+Q~w23T>wRyj;C3^v%$$4d1rE0
zjjaF1$3^@a-*CI>b`;<uyv9+%|Aw#cpU>Xhem%7aGMP*V_w!KDE5R0R%IUtZRb^s9
zi6n6B>Al(Z6(ck4q8BzTqu}wwoMuwumm_b;EKiEFys%e}Wy|!(G_fi_h+~MXJ*v!*
z@OLKOM3;uD5@h-)C*pAwm1MKZL8@)8Fx4fxHjW<>)`e6g5<m<CtSr!<2w8HLl<*5K
z`n!f&JLv?a$_ZLLC=nG|XcRibVhw7*BHnm6`G`3<_t%9}#MXW0@CnJOD&?lOm#^L%
zfd|(Y1b9?io(ZvCK~9-3uj_)}z(B?hL*f|EK-U>Zm!NQG2}Cra-*62)SQH>=$5N;D
zLM%3pZc}+`?rkRWv6>4}Fn$cATpC3hqVBR=9q-6#R0-)Cv(^T!T^t|EJMyV#*Lx0$
zf$^BY!nwl}m6w4}rp>Bh;*?$D`Z0yB_~Xov?rO4k_j5?t8Q&*8i?W?!?mAmKZCuI`
z%gJCR%)(WR?_bDW+`#$%Tt|AU_z6xe7R7ZS%%9Os&Lc?G$dNiKqoDnk;MffP4}V9N
zd=6Jgv3s~w8vCXvoJMalb-txXc$zKKONI6HCiC3{T0XyE?KUar>YVQnbBIDW@3mph
z+<M7xcXHT#Wxa*M5jUTC5Lyq&Q+6qm6YDn1q4vRi{nCRSg^H!Os==VMPLho9VK%?}
z>fJaSb-Bs2XRuNDn54yg<6>;z(;dbEEMA#YW?jQo?<7Z9tLF4#29`O%V)eC=fe{+@
zOTcDGQK~um*|~2NzP9juZ=P-Z4hvf^4+S(2(<DAl1GAsc%RK4vALtRb>_}HP90h+E
zUAt|w*rN(OiS2g_A_{WB!x!EI!)NN7AKz>y-4*7gusX@GuK)7rA^6nsyYhfmS=c2S
zmTvHr3dg>OxD-C-0OH&hil<fc?K;JY#nA!9C_L0-$X*x?u`{tTn-?>er`!mpohSrQ
zZ4_AJ-GO*{fJne0Aqn|}wma;<$xff>CSI8OA`{QC-tZAdFMafuQTWkEbU5qcPg@;n
zB=?3LtMx2@lD<V+5+P~PC1ghtoWlK(l7oTU2YppS=Wvg{jLk7HT?se15a=j>@fV?V
zp2$zK&{(*L`0ya5+$0hk<n}6W^A+7<uRFK@(EvI&?vM33llDliqM}SC-!f+<y(9XH
zQ?Y9p>=O~H)T}&J2bgEzK%`E=vRtkm2b_ZqBl9Hy3WWHN7ly#aWWD)V9wEY+vq6x*
zK{I25VZCb|ex+OQdZj+Oe8nQ22S6r}qgqZH@Q^pivE*;Tyug)0=#sr;J=xb6AXkNK
z4M-}MG^z0~YX(ExEW{9ZY`Vv%FW;{>7ZY?YmLY9Vb*ly4+t@btt*W$tHKqz2P(!(@
zLjby7n;<bZ#~!~oa1}}0?nft;9^JP*WCLMU*6=!JDY=jE9;>YV$$h}qS-=*#5>AjJ
zHZ+k~u~BE-A8o`$m>Aska*;l6_n{70@b{)EFyyUbN<*QPMB;FW4_|{Y)Nw+J5j?R+
z=H3KR<bu&~s$@8jsX+NbKQe?E*3=SSZhBxO0DfM`RHvAU6zDb{nXnXM(kDqj6N@4D
zxh71uWzgh4K>TkCRE@D>im$ZO;&`*U@4M@L<lt@yR5V!zyoLH_bBHAn(+W+V2sr?x
z(}Dpve0l#%gR&z-hL2rOrX*ocdrACf5D@FSf@>o)0mP1T447cNe(|C=OY>X-?7%+G
zrr;G*7ws0{$62R6#9X<aow&SY^pSs#_FB?{^0uIMe}IfUsqE8xK{1%d&7A`KH8>mq
m0001|VXy=UD-dA-0r3ies0jdS2iv@{#Ao{g000001X)_$1G{+u

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/052-orphan-directory/test.sh b/tests/fsck-tests/052-orphan-directory/test.sh
new file mode 100755
index 00000000..f3d380d9
--- /dev/null
+++ b/tests/fsck-tests/052-orphan-directory/test.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# We could potentially have a directory and it's children with ORPHAN items left
+# for them without having been cleaned up.
+#
+# fsck shouldn't complain about this or attempt to do anything about it, the
+# orphan cleanup will do the correct thing.
+#
+# To create this image I simply modified the kernel to skip doing the
+# btrfs_truncate_inode_items() and removing the orphan item at evict time, and
+# then rm -rf'ed a directory.
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+check_image() {
+	run_check "$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.26.3

