Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8543E3725CE
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhEDG0e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 02:26:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:50068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhEDG0d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 May 2021 02:26:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620109538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/km70Gu/+WROpnpmij18qjn1lsvDrSpdAepUGZ5If4=;
        b=EuiYKbcUxBu7a1xbH76+eH1QoBgrSqZTwShsi0cWtykK/W0UomJtGxB3TaKKL6WsBGzAZi
        ywA07Gi6yUdWI3GkSc8FveYL/kdlHXz/LAE2pCw+av0Qkp06oRUgpzIjNx7CHVhYJBzVsm
        aQksSQlemjmVmMoWCq1JMncef98H2/g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17ADDAE95
        for <linux-btrfs@vger.kernel.org>; Tue,  4 May 2021 06:25:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: fsck-tests: add test image for mixed inline and regular data extents
Date:   Tue,  4 May 2021 14:25:25 +0800
Message-Id: <20210504062525.152540-5-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504062525.152540-1-wqu@suse.com>
References: <20210504062525.152540-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To make sure btrfs check can detect such problem.

The image is dumped by using subpage data rw branch, with inline extent
disable patch reverted, running with 4K sectorsize on 64K page size ARM board,
with the following command on an empty btrfs filesystem:

  fsx -q -l 262144 -o 65536 -S 191110531 -N 9057 -R -W $mnt/file

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../047-mixed-extent-types/default.img.xz     | Bin 0 -> 2112 bytes
 .../fsck-tests/047-mixed-extent-types/test.sh |  19 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/fsck-tests/047-mixed-extent-types/default.img.xz
 create mode 100755 tests/fsck-tests/047-mixed-extent-types/test.sh

diff --git a/tests/fsck-tests/047-mixed-extent-types/default.img.xz b/tests/fsck-tests/047-mixed-extent-types/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..cf240501f08f38dbaaf9116330fdae438f14a6d7
GIT binary patch
literal 2112
zcmV-G2*3CJH+ooF000E$*0e?f03iVu0001VFXf})5B~@LT>wRyj;C3^v%$$4d1t#p
zhA1?_LT>WU6(o{g^wy`#%^URoE0#nM%oKGSkItgLPyY-!1}Su+9>j|f-76RLVnK$o
zzYOv_3rdd_fZKMM{YA%Du4uLOnx-~%Oui=VxQ*`~=s`}KFZ`e_;=z*FCl3k5%VkrY
zw1vd^{`LF%Axxn_@4sN;ThyD#+Rkop)Moxa(9EZBg0s&NJNaU}f;Q}7(?0tmpY!??
zo8p4C+}LykeUZMt*e5F@@dPkKJ;8g&e}uJuj#@S0v98{!TOZF)FQR3a;Q-*Ec{oEf
zg{fY;sW1U9V?cH@DFUUuOE=5+=-Z_7U2ubDF#ab*sQWK^YEu)I4PQv46+~#s)56lY
z1)p#P{$S63tcP+Dz%Iuj@MKEmhJ;CtUK8W*CndS{H7#-}#yu8lcBBKhf+E86y@n)A
zvnVX!)6XztuPEpZd4%D^#2E~Tq`2#r?z7rhV07<yAE=40yTfU0Ey?1Y@NWr3sU_N+
zEH>l$>mX=Qf{Aq3_Jk2G;_<Asgw&EnBKsGtyj}h0Xr)lqi?tiVfHVt4%+T_l74G@o
zUb`S048xP=V6vQ%@_5Mv#I7O5O=yZCf=jU3OHBfVwydfpAYqJMyl2*8N?@gLzXpIG
z;d_LvV!-dkK8;VQfZ>5v8{hjpRP6M(<^&$p#N~uJ-7o?A&g`pJ&1lR2jYL;(#|G1#
zkejXx^o#~T=E+^n{iC>)`bI@2!{F&y!nSKVq{>L?|ASA2UDLWiVEyYL4eQ}x2_v{4
z^8(W)B(hJaJI#F_AfigWvBR9q>_p*5zAm$xo4>CoFDl*a97qO9XOz$eE(W2}Mb)0I
z#cf|1PEDJw7yAk01~V&lv$ZS-y5lcFDHOUK*3PLi0Z&{l5A6Ic^efOKqt@N-&si0X
zLyc#2;2*Q9rhjzmLu16XEekLrYomAgzig<zh-et8awaxmCY+Xpn>@ZUD3*A{B!GIR
zBJV`N9crp;pc!=hSrYO@4Gruzl|KtmFL`EOOWNXDd1NUEdQm-yqi!USL8YMtR{SoC
z&CEBfzYR#Ob&$2RJVQbcEN6j(B$r+^sfhE-uE4|e`ddQ#E|Xj?OX-5caOLfKS1JHj
zwEk>zdx@d|ZRJCz!Y2@BTHRQoY2N<-JMOq}apB%oy@22Fn*^LRXWK7EwqcC1RwpmA
zRh9NBkanX7iqoZ)agWEh#*SR%Bg7TEeAoZckW9+uZQ3VwJbcTNqvqctu`D4o(OyXJ
z);Z`XWYUWw)n|+ijL8$SLr}?N&0n<K@$^!UtZ;CdHc~cO_qYL}?oiMns8r!EV>Qoy
zyr3+8=e20w%P#s<*n)q7>e3QVZ<pYeuXS=|wX8G9Ya1%5Xp>J>oVjx5_Jp4jY@de~
zSJftrDb4$VXbwx~b9Ti2&ACxSMiWg^Zzx(v!z-AG@CTdouyA6Gre4h5vfU53Z*%4L
z**4%ogY(-ZAE6qPxDAidL27LH)o7`OS?^^$<bgcKQ#zi%(JU6lda@x~WF@ee>i-{_
z5=VPJ#m*m%B`6;NLM}mMzOm&rwq@t&O8g8X`9FHH>xA1A<b*@})lI^r@LL$!P_^{H
z(+i&X40>LQdDqU03<@8P)T9`a=b8Kaa(C3Gt?4T#+Cs!FIMf(Da?ai`2R8qor`q79
zZ1aE|Al%^xyc7+LH^7U>x~+NT<y1Rkg+h^TE<I5t!^pC$(T_Fk+P<l`g_w@+tfM}$
z{DKsuf1mA1PGN3ad#mH(E_iwZ@I&?(0(q3g(nfN6ZvYt1KF4ZmtOgimGxR-t{tpJz
zF32TcW){+w(sy#5mLs7fQ=0(QL&XJvFSVbt9fz#6CTH0z<8?dLar_DMRFX{#VbvdI
zN(?M3GeH*YOBl7p%(z)a`o~b<UjyAI=^FzfL+ct7RD}#mCx@jIkoAH%RdP+t-tEd{
zaQ47Fl7Kq&o+%I%^b={P?bDJs-A=kJ#Ep6|6(kfBqrn4I(4|?$*ZW(UO!5wfr%oc}
z#a~`D5^ZTFa(X_UW5j<L9fy@h@c1q6^L4t*X3rU6$~U4gYwpe-cD>e=9V!29KfN{F
z0w!#%Hw(MMiV<#6Ti5kTco#sGq?TVAuwKs~qZpsrqtW&^+-cy#1KeHgg>JMc<^6{T
z74`DUohLA*qq>@JmULBNn%BPbHG11qMPZo`Ner*ICa8J=){d4>V|+ND#f>86w|q0n
z)qCd3$`BeDfYjPB<hH$y@^`ub>nNfVLlJ^gyud;r|4k3F>67JN#edHPU>NG=A$VaJ
z96TrYWX9iMy~0iM3Hwa{6sUsF<eOma%zXBQWY#K_M)nD1|4yrDd$5cYU+Ux7@;}(G
zwM&v})uo85rika%lO>}gA7cny=`B2XGv?ys{?xXG2})&r|3uY_y5i_l2e&3lCje59
z>SJ<jXe`KTFcSr3$v*nNugH$jQ%?t-1P;piQfO+{Oxl^yzw?c^u7>5xoh~5M2{<ac
zetE!Ya%-ms5-%|mQb?qCcuU9|_%FI!zIby|H|J9%3PSw%Zl2qKX>&?wz)+LIR9U*<
zp?0*Z@ga3rmVg!F8h0;VwculDi_UQkO)ouWRO!dPltFgVGtKkYLJ`IrRPF+GAd(Ut
z*yHITSaW%>c%?gVGv&(=HCp>rG4$9=3^nV!Aj3rC!GLAcoC{rQBrcCWf>`*}S>kL!
q%)y2L0001*U%@Gyl;P$80h$niAOHZNhFr?A#Ao{g000001X)`88z)2n

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/047-mixed-extent-types/test.sh b/tests/fsck-tests/047-mixed-extent-types/test.sh
new file mode 100755
index 000000000000..9c7f5690c552
--- /dev/null
+++ b/tests/fsck-tests/047-mixed-extent-types/test.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+#
+# Verify that check can detect inline and regular extents inside the same inode
+#
+# This problem takes us quite much effort in the past, and subpage data write
+# can cause such problem more easily.
+#
+# Make sure btrfs check can at least detect such error
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail "mixed extent types not detected" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.31.1

