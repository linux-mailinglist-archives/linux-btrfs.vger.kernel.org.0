Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FBE11CBC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfLLLCf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42473 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so965982pgb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYGYU8TVlH7JLHVdrEUiUgTO+QULmqjGrDAacT6ITX8=;
        b=PtyvT6DKKMyf6Zp9fFPkVWDGkwQHEqLekNTLWdrXbBg7axhk8XTBgu25/0+wo+Q1c6
         ftoCMjChf5Kguk6x3XfBb9x6MEHl1Qa68IBUi/B0ZlsG4c/kMGilD0Mp0xoicXaJwW3A
         /1vmO6mpE/uT5dkUwfTXk11TKcfQc00XhOEkhQh6FEYin+V6L8GkoOqEAx/Oeb7ghKVY
         +j1dIq+U5JRIVqR0Dfgq02WQtoKCdpaVv4g85MvgylLhgRJ3JNJqkCJLyEs5qPnPZmrW
         k/5orLGA0BgOLQpwRGjgui8zKF+V5kdsq/nWpCzFnr00e5Eo45cdcCMLfMh1ZXl2hwS0
         Inig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYGYU8TVlH7JLHVdrEUiUgTO+QULmqjGrDAacT6ITX8=;
        b=hivKTmXyI+624/tu7lmvU1Mc5bvycJBtRYMlhV4F2yNJNdNpP41ft18wOIo2x+eFRX
         Fi22BMM7Nx8FHh5cocdYBqUC9Y25etKP7a6dMI2cSXAKUcQXx3ffvqQO3slXsqefprbO
         3i40MrYWr8jld2ETWiuwBrtfp2oC4+tjp9xMJ4T94lG5rIqLFi5yS7X2HJ1jmG/8a3qe
         zaOYMVVosze+NGuFgxhuDK5DKp1l/GiNy6ZAvYwlz0t3ZsWfyp5AYAwtP30UW5n3AEse
         S2Ac1n9ouHu+G4dEUUos4JB7eIhTV/gDaEBXbdAukU3qAg1qajCa3/gNZ/Lb3CM/u9YS
         68aA==
X-Gm-Message-State: APjAAAXsUCJWxQxnvMQEyCwz91/SpIDiSZNzs50JpZxLV3oYgMIbf6TZ
        K4ZZpEBnk1Uyde8vPpKCIiF3ztGMGGs=
X-Google-Smtp-Source: APXvYqxQiENNwKzfUAeLGfd1GvuLW/k3wI4cFjTf4u95qcj1BDNneAeMozlbqThkBOgyqCkQj3dqHQ==
X-Received: by 2002:a63:4b48:: with SMTP id k8mr9722226pgl.362.1576148553180;
        Thu, 12 Dec 2019 03:02:33 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:32 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 11/11] btrfs-progs: misc-tests/034: add new test images and modify the script
Date:   Thu, 12 Dec 2019 19:02:04 +0800
Message-Id: <20191212110204.11128-12-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191212110204.11128-1-Damenly_Su@gmx.com>
References: <20191212110204.11128-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Disk7 contains an image which has undergone a successful fsid change
more than once with FSID_CHANGING_v2 flag. disk8 on the other hand is
member of the same filesystem but has completed its last change without
METADATA_UUID flag set.

The expected recovery result is both image don't have FSID_CHANGING_v2
and INCOMPAT_METADATA_UUID. Change the test script to test it.

NOTE: It needs kernel fixes for metadata_uuid feature, otherwise
will fail.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 .../misc-tests/034-metadata-uuid/disk7.raw.xz | Bin 0 -> 48388 bytes
 .../misc-tests/034-metadata-uuid/disk8.raw.xz | Bin 0 -> 47084 bytes
 tests/misc-tests/034-metadata-uuid/test.sh    |  38 +++++++++++++++---
 3 files changed, 32 insertions(+), 6 deletions(-)
 create mode 100644 tests/misc-tests/034-metadata-uuid/disk7.raw.xz
 create mode 100644 tests/misc-tests/034-metadata-uuid/disk8.raw.xz

diff --git a/tests/misc-tests/034-metadata-uuid/disk7.raw.xz b/tests/misc-tests/034-metadata-uuid/disk7.raw.xz
new file mode 100644
index 0000000000000000000000000000000000000000..157815fd1f87039f81d0f7fbfe6888b8bac96b85
GIT binary patch
literal 48388
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
Ke|~_*%K9H3vMksD

literal 0
HcmV?d00001

diff --git a/tests/misc-tests/034-metadata-uuid/disk8.raw.xz b/tests/misc-tests/034-metadata-uuid/disk8.raw.xz
new file mode 100644
index 0000000000000000000000000000000000000000..ec1fa6709348b713368d3afb6ba8b741e3eec582
GIT binary patch
literal 47084
zcmeI5_g7PE7KTqKSE`{Z(o|5Xp@<D5h^P^`SO7($RB7TMAVn@xEvN($P?4qq<;GA2
zMWiSY1VIG?iXgoxz3U}P3z=DWX05qvO_&h}gdcYPfvmO9{@(qZcki=5`qpzM#}I_A
zyY2~&1zC#{M-YUs%A|t9;9$j>A&4`b!AQtv?9<c{c2&1B$hjfgop5>C#BitNg&O6T
z+jpRTedPC=K-jOGz}w*e;L|l}exr80$V(5xN6+!6xBPidQCi(~ZA|0+uVj6SJE$kZ
z=!tzQN%e_;m#~-SF;;AFh@YfEq*|j(mNhsO#$t4}Q(DaLrD`{BcJg-DciSDNXe>dn
z`81fXB;$u^9gtFJU?=w}ObcQ41qJs$ptAAiXt(IgB_)XxEKaPq;^61&Pio^@`^6^Y
za&Lm&l@KC!O4rQm6vNnub@Zxnfl$D2wK1af)v9ZnJC;`}p1f9Dl_bU{cqt+<d#pnK
zKyuLtH@VUO+xAOmJ1z{2d>d_jjJb5fT&#ARA@-Cq%O@$4JS}?v7gfGe-JF_%AUW3^
z4td^Pg(vUSIXj!8L<WK!NO5Y7hAPSh)-jK~Q-hwwd4}_<YhSp9s#@_9uZ4tWtvYr@
zy(9m=rm?M`&RDg(@x?oAP8InLy@a$#3`1!kMk0^;NJhjIf4R@j(4?U6Y%0F9>o_~d
zL|J3n^pv53d!^*@HQEy`MjGRCHk{aia(TzLEbM4WzLG^UTJu*s?J&XR48EJ=XMV$v
zb5}AVWO3+3MzfihveL)*UZ%Zo(>0Pz1}_a|`Z!b>h7F}k*6D5cBI?^}CYp)WS3X#s
z@yh6UKyPuKWd_ZYW#)JGGn}P@V%@{}JRDQGvi4=x{6^aLrwsbtS><+{92xS~QlsgW
z6xe@09o?2?zk!w#Q=BJ<%T!Vy3K1|g%aCqL8jA96{%j-?m$9xqIm@ItQlGKE>~)ux
zql3%@{}nZw6m2R#U%v9y>eZwJVP`JrN(}3T7R*fT_#5@y#YvvX`e%X_gAW3$ZzYlF
z+%vf~wu3n<&XYgrMjzC&c289nKt>Bnt}64V#J20uiHgzNh;g^ECs*a@-shBPI^=RI
zGdAo)k2G(HDb6*z5z$QBKv|pzkdT(@702L1DIkMxMr3-yLmySqxa<&BCl?}F+G0?)
zJn(Hq6v0nE{ELjow^fv1qV`A8>(gt)&?W1Q#%bYORM|-x!_Gx6`}gs@4d+izvz-4N
zNt*U)or+OWGNyzE{&Dd<#dcBu+5o-tF$8S3^UUN~LBRf-0L~h)9M<+Fc_j514~8pu
zmfcU!#J=yFjz@gk-g<jJ@7<)mllU69clQatXRT<<_-<@^cE7|(!Uk-s(xW7|+I6D6
z9OsNS?-a<|Tpe08dYiqeczJNHe{7RKemqdGrdQ2HLm~T@+INMW4VM`^wq;J#8*1w%
zIbkqGC;hFiVO}LG3g*r@@f>n*nQA^NvG1_c`Nq_jvgY^1gGe5J^{!*F=JL9lcapH0
zEpGB^;g?s6nNozC`PQ4CYq0ev^q<t?(#ghaQ9N7+kEGd+&lKh!y(_gM%1hc(Ijwx1
zjRCILV_ZT}qN*J=O#6dE$*eo*<|6P^c6id6<ass0No>fgCm7Fgh>e*^5%9jghGwov
zzLGDj*W!=ouAUs}$f>fJTzd~EaQyeN3QB48knpa2XSq^`UHum&r(}FFYdNQOwU`}d
z&nT%^x1~Ds6>hz+LXAy)zu`r$s*m<NZjoN6eY<E)IeMQyij&(m4mgcZ6El-1pGfZE
zk7W}$CgXf<;<Kf}%WZa6Xb;!ZE#gLo;X2%pdnS`bsdUxyL_3@G^v&h@is6-dqgEN;
zT+gC2&|RWC?%q9;{fut1y{UHGEY;6*V{yXn^}$=H2vrVaxAi8<S6nXHdu8{vH^GrA
z8aHigzc_Y{m(XVpIegod=u3+ckIQ>|Z_GSy<RNdFw*YI^!x21z+~wGWZ}RSPYkYO?
z#Ke=w1F>h-B88IM$)reoa>PV>pHkteBFE3BGLKc7UtE&qJs}&s$L4_ML*vlG0I59j
zS6{CWE&u4aR@f-GVT-(LeRbbalQN=e*sZ{z<$aD)yqUPYM7bN!-S=Gg;Ji;SuL@ER
z{8HGdZ~0ZlsIIh%??q>+g08Hy<}&ugiKzYxl#X=|!E+zKV6VK5b@p>4P$ih>%@dP1
zhUv??IL2^DRFMU@$R>0Tm+I=Ycw2)A%HhG+#qD)9xoDQ?4~?5n3pVZ9;+w0Lg}%=D
zlpz$sCD7$HRD+qZiu{Gu;<XD_h_Z2O6iFCG>P_I3A53N(+mPzYv*HH1Ks|I_$Gnur
z?KQbjM`q>1S!EGOg*iw=z~=bo0Re-6{q*-1VBsHPVGw-~{duvQK=eWMLG=IAhGlXt
z7SY{<DhX9`9(xQ-k{dD%G7K^d`YLm4Rx%M1sFHIO5(pRsY+;obG7K^dG7QEw{y8ZE
zq(4VBfPg{37FIqX!+t2ka#32yK-tDl+v^R8c}+@<wC{N>sw$zajjF*O)6#K4vQqb=
z(p`Gp`hQPX{_GbPx2Ky}s;HcvaVs-_(iFuUx&q?F9wivugTcLdnp|dbwm{f^NZ6pe
z3*Fs0==kg(6Tp##?k;q9p}YHkf0e{UNWfK`V{M0kLBJN)M}Q2241){<qaTd^|NWgc
z6QTjPVvh0&0fT@oY`uXDgA9WVgRw*yON50Yuz}^z1wjC=^XKU+E`^06S~+1D?yuXv
zYdaK^hyQa-AMK2;NSGCXSpk?8SaN%}mV}6Xcf<bY$Q2I#SEU@|k;X0Ko>9o^7BK`7
z0}%reTXG@>+ZLHE1O2Or{cF)9IAY+4fg=Wv7&v0!h=C&pj@Xav7zeDFKMN7S6~J{K
z*8anhgd+))`Y@>vllpL(23XW!QG-Pd7WMaE8pVVj7o*Px7WH>r@Wtd=fu|3iK6v`z
z>4T>ao<4Z`;OT>>zc`m@0*3*I0fzyH0fzyH0fzyH0fzyHp_lZR4dA$f<0_FyeIz4d
z3g8Oh3g8Oh3g8Oh3g8Oh3gBw8P&>3?wqlMxF$4?(wy^IfkYSKvkYTX;7FOTF>Ra%`
zW_tsMDhX8*sw7lNsFF}6p-MuPoF|_cumZ3GumZ3GumZ3GumZ3GuwrrA&%j~8VZdR)
zVZdR)VZdR)VZdR)VLqy&aoHg-6g-<6z&GD>WM&B14+JcLKtZ_vyliZG$f=4niXdD;
l5h)Ck{U!ueJi-zX5O5oXAo>2)Dncu<Dy+yqer)(-e+NJhvxxuz

literal 0
HcmV?d00001

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 5fe553705fcf..9c6fe101cf7a 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -145,19 +145,34 @@ check_inprogress_flag() {
 }
 
 check_completed() {
+	local metadata_uuid="$3"
+
 	# check that metadata uuid is indeed completed
 	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super \
 		"$1" | grep -q METADATA_UUID
-	[ $? -eq 0 ] || _fail "metadata_uuid not set on $1"
+	if [ $? -ne 0 -a "$metadata_uuid" = 'true' ] ; then
+		_fail "metadata_uuid not set on $1"
+	elif [  $? -eq 0 -a "$metadata_uuid" = 'false' ] ; then
+		_fail "metadata_uuid set on $1"
+	fi
 
 	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super \
-		"$2" | grep -q METADATA_UUID
-	[ $? -eq 0 ] || _fail "metadata_uuid not set on $2"
+		 "$2" | grep -q METADATA_UUID
+	if [ $? -ne 0 -a "$metadata_uuid" = 'true' ] ; then
+		_fail "metadata_uuid not set on $2"
+	elif [  $? -eq 0 -a "$metadata_uuid" = 'false' ] ; then
+		_fail "metadata_uuid set on $2"
+	fi
 }
 
 check_multi_fsid_change() {
 	check_inprogress_flag "$1" "$2"
-	check_completed "$1" "$2"
+	check_completed "$1" "$2" true
+}
+
+check_multi_fsid_change_without_metadata_uuid() {
+	check_inprogress_flag "$1" "$2"
+	check_completed "$1" "$2" false
 }
 
 failure_recovery() {
@@ -217,9 +232,9 @@ failure_recovery "./disk2.raw.xz" "./disk1.raw.xz" check_inprogress_flag
 # of the same filesystem but has both METADATA_UUID incompat and a new
 # metadata uuid set. So disk 3 must always take precedence
 reload_btrfs
-failure_recovery "./disk3.raw.xz" "./disk4.raw.xz" check_completed
+failure_recovery "./disk3.raw.xz" "./disk4.raw.xz" check_completed true
 reload_btrfs
-failure_recovery "./disk4.raw.xz" "./disk3.raw.xz" check_completed
+failure_recovery "./disk4.raw.xz" "./disk3.raw.xz" check_completed true
 
 # disk5 contains an image which has undergone a successful fsid change more
 # than once, disk6 on the other hand is member of the same filesystem but
@@ -229,3 +244,14 @@ reload_btrfs
 failure_recovery "./disk5.raw.xz" "./disk6.raw.xz" check_multi_fsid_change
 reload_btrfs
 failure_recovery "./disk6.raw.xz" "./disk5.raw.xz" check_multi_fsid_change
+
+# disk7 contains an image which has undergone a successful fsid change more
+# than once with FSID_CHANGING flag. disk8 on the other hand is member
+# of the same filesystem but has completed its last change without
+# METADATA_UUID flag set.
+reload_btrfs
+failure_recovery "./disk7.raw.xz" "./disk8.raw.xz" \
+		 check_multi_fsid_change_without_metadata_uuid
+reload_btrfs
+failure_recovery "./disk8.raw.xz" "./disk7.raw.xz" \
+		 check_multi_fsid_change_without_metadata_uuid
-- 
2.21.0 (Apple Git-122.2)

