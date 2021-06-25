Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B43C3B3D10
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 09:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFYHPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 03:15:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59694 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFYHPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 03:15:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 764FF21BF4;
        Fri, 25 Jun 2021 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624605212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/D3swQNQVHUai4qMbe31fm+cksDh7ZRJoLzIKqpihk=;
        b=rwLpaz0zdFvb9xuorUcuODn4dSIYklat1OcnDsKBP8p7S61b9ci1pIJLphx5DrMw6pScWo
        A2w2inlOUQlSW2aLq5ZGu+/1xoBa6PVO5FGikqDtlNjPoc8N7wvZbpHP/pnmF2ep+aW5Fh
        acgeAUZXQ5nj1RdKNeu+itY8Ra3F8bE=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 2E71CA3BF8;
        Fri, 25 Jun 2021 07:13:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
Subject: [PATCH 3/3] btrfs-progs: fsck-tests: add test image for orphan roots without an orphan item
Date:   Fri, 25 Jun 2021 15:13:22 +0800
Message-Id: <20210625071322.221780-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625071322.221780-1-wqu@suse.com>
References: <20210625071322.221780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The image is manually crafted so that:

- Root 257/258 has no ROOT_BACKREF/ROOT_REF
- Root 257/258 has root refs 0
- No DIR_INDEX/DIR_ITEM points to root 257/258

Reported-by: Zhenyu Wu <wuzy001@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../048-orphan-roots/.lowmem_repairable          |   0
 tests/fsck-tests/048-orphan-roots/default.img.xz | Bin 0 -> 2584 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/048-orphan-roots/.lowmem_repairable
 create mode 100644 tests/fsck-tests/048-orphan-roots/default.img.xz

diff --git a/tests/fsck-tests/048-orphan-roots/.lowmem_repairable b/tests/fsck-tests/048-orphan-roots/.lowmem_repairable
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/fsck-tests/048-orphan-roots/default.img.xz b/tests/fsck-tests/048-orphan-roots/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..80da92c6c0edbf194d2f6fc8c1c0c149983b605e
GIT binary patch
literal 2584
zcmV+z3g`9xH+ooF000E$*0e?f03iVu0001VFXf})5B~|+T>wRyj;C3^v%$$4d1zEs
zh6euaev|Jls6|E?YAIeZep}MC;>QI7ji|$M!RSVBT>d%0JyqUTS^z;wmfuXdMRJwy
zL(+flKLC1VnM891mowG0)H}nqq1ZX|6xB=~H{PmdBRqgV7<xJcCYDfo`ajm;DR4D=
zz;!7+it3Vl8u3|k_F*SHg>AC&YaW?{GmsCQn7vmeGgY$URB+~=HLeq(N1s>sQr_{r
zwTCey#_(q$C)w;%?0(YNZ_RApYqC@>Q&=nVO}W<3dA>m>8-CZsnO*Mg&zXlimqo4j
zC>Lq$I+q3O5KUtJ3U7Oo7rXRCF;r&opm^dL{3Q^V1z-a3_;@P{5cd`-a~}pk?Cp41
zW7-hZu(?BCRA+|ljIj|u@dSjEJOX4ky697+K|1#1<PLv#+eL2~!_u?XlzNG_Q*u^-
zJR@dlwfROb@$DZmES{#`-+`+!#CMM{7}J&#04IDjLpL~r0ie`nVIKB!sVrsqj7EMz
zd<{9X#ZAr|s!;)ky!&HKapn(chMf_~0LAR3n0N}E9;}DYr?63SC{c4h7hN14rL6vW
zXCY7ajK2|yk{2`>xOgt)Ku{L@{cR>`ZG5o!SRt5W829-ayco8Xa8$!#*=?OurVbtT
zcZLZUVBvWS0Ib+C)4=?k^zLoKi-Iy*Cx)YUx8eMlz%YsuiS9GGZcHrm+Au6Qxz>kH
zO96M*{D$cy!Ot9HOy?1SuTVzxm3DfY{SE+FX;ZcoXn1A6$&X?_kg8U{&0-r^VtWcZ
z8C_<-48B&`-fH0D+TCJ7>-^~|#Pj{if+sY;DpLI^p?E(UuU_gb&x7tX+38^^JUj}z
z*-Y6Yo+I?;p32b1YL|6Oj3!H)R?_1Os0XB|ShblP2LUr=qxox88g%T@T6Kx^paJD{
z!Sxbt<xzk9O-bLfRRW**eOiDXtKte*djnCqd1c}tar|rvhOT7jf=m3^z}})df0T7e
z1~*o40-wo*egc&|qhk9hpaGh;JBbdtSlp^nBcgG0eTG`z9y-`{u_V>5$CSK?e1~pJ
zBkE5#wXU3sz5<6g=GfW$NWN2MNgW??(yA*=yLhgR#Y-*>ei}-r_$76zw;}7s0OqsX
z>~tdcpQ>rugx2Kq_+KkqY<hsvWa?l^I%iKr9abztuPXX2ct)guFJnh)vq)fc$sU8h
zPI0zJ(xA^SweC0SaD!!R*g?G1XVAEc8ttB!KE2k+233ny;Bx@uPAoa_Mi(!){QhvS
zeyI{^4?mjJy;iVW%i8a2##i4pes1tQeSfBcPGdtHP%>rQ=DxltEidgg{9|Q_7^Y!&
z<VL7<@)^co+XcDBcS+>j=h8ET_YX@b;0pcy&r4}p69E!|7tpZu-?8Oj)^1KUs@P}>
zcrqq90Bsq`MOOZv&>IV`##x6;CrnM59aOyO=^()-L#5Zl!HtNFjI|mcS+kA=XfVV(
zqZcP8o<|<#_pHm3>*ZFTLo3G|$A#A6sY4<u)$58DgIu^+*4KnkcbSf4GN3d<lQm1g
znr>+K;@MaP(qxbdMS!zX+J&1>Zxp&T=Y%slp?DoS-e6o}g~}ZMCz@njS#%8ZoY;$R
z@&x__2ReblogMzb<EYJ|arP|x*~Geg1uOZ^ksD1{aVH}^s9Imb%+sN_>H?VnNhCi^
zmRnpgYQ)i4M*`}9P_@d<KVi{E{`+c`dri4dM<vlgZv*+mcw16Uy0R%P>(M0-41ZNN
zzS9w8$zmgjnxQ+)z7cSjjY#BVkVuPumF6p3QP`vHTkD9{DN+cXjiW*iEl^BinAcK2
zN1cs7!8Mlky2?Qc#Z`SM)0hlqaYV*bIuP9w)GRAW(mX^l@P_(&Q;R^QT0%=|(TcBs
z@9p%__LK^*A;4~uq3QiQ^o{`6G!obzI%JUW?)=zGWU13P2m!i?#;#iYbn-kE*tk$(
zKuAs5PUAWFWWXk);UlAp;$;^7ir7|7HE|=nvK1PaoaJan0&>OsZ76lEWuZQ;D1ec(
zR<>{VfC_z;Dq@J`mr_W&>WnzY?PaodIE#ZG{GDZ`Emh>{S?<eRzP(yiCL&v#ES&S?
zSQms|gkOFfqz4FpNL9LhD&s~CJbo}6CwYA2aut>W)89a|4B>;WT@qXUk0q1sS5w)r
zI;?;qGG|~xxzGm`b147zTpq}EPb<<#_k@<l7mSZ8k&!qJ2G^sbpQ4dJGX$NqGtwq$
zLIeogdtI$y3E!DG*`M{W>jPK^8GXZxJSV;Egg!ugT0CdpsA!HV@hy*4kBezJx0K3t
zE_s@GA2DF=VCusE(IC!*RvAGp_5Bf65S}W#C_kY+HBE>k>gCP*Zi~B{?WN$ADbw9#
zOB8zcR7vv2CYtB#Yybe$C&Dw(j`m<Vz0BtefUq^44x6~=`gSxYGw7=VSj&cKnf0Rg
zz2dh{D~1_%D(z>4;R`}#or~8O)Kj*Pf?r2l5naid@<Quh^FWR*Y#JoT7i=i!1h4d8
zdOlT7izs)u;v<Gu$#w5S$>FY>M@z3Wb45V%7s4&O!SGInq|d7wgpxZ3$1DnXi&39b
zpHSR0fnP@rfj&t|O>PXOF5Zw26mxdr$!(6YKWQQBu!VvOUpP)slTW!p2q7}cJRQC5
zz{!G=gl*W~+uP_D@V4Xvd64G6#>LJ|z7OZy&4TKb)Ht&~27my9ODaA<z9^&RJ<vfd
zNpz7!gyqGsEN|fp#zxwMP^3_$p?(pJb@y>c!gl^-Ww}bmxT80Z78iC;L@S;KVdTl8
zYgj(vu>FHcfF02Ol@)^)adOllP&g3M%uJ-qJO0LmiqqBGViH;fq66>^cn9S3G<8wx
z;z|<Ak;q@c#D@ac4&MeBet>vv&=>99AEb6Z#8QTT!GOMpt3LY$R^~6+&(qH_kJr>c
zgN-$k=>CM~>qi1F6}b0Y=?F4zb{(MS)(YwFd`5P)3M!WIu^Ud%6x`EAgcJ22VP+W5
z#D%yjca+Y|is6}Uz~jgbwFtQ8J7%$Xv|o5X%2{ZC*Y_4F${{4cK+DeZyMN=zEy_~U
z6~D<7qCmbkDP)*=z>o6t%bAEpI<4kRG%1|dZwbjvofqSeOeoE_0`0)z6m2H&QmFN~
z?;1p2aFp=1(BYVM8*w4b|7x?S4^+ROq~|jn9i0~b@y%#sbsV_;ZzSJj*LfeEqgp7p
zpG$gtzxcRvd0DMGNz*Sb8aB=KppREd_;N%yH31_X^|y-!PT@k%(}J&5{9*(6T1-39
zWi{w_-I21vY?VYP`B&~SIJfwCp;fyEm_be!rKaxNDX+b_`%p2a)RHGUX?<(gV!{!2
uC3yG_GPy@Ij{pGr@dylV-a6_40rV4qAOHYck^;Z6#Ao{g000001X)_&H}_Tm

literal 0
HcmV?d00001

-- 
2.32.0

