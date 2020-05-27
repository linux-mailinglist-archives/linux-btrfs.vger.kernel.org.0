Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372281E3EFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbgE0K2a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:28:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:44612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387972AbgE0K23 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:28:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 65AACAC51
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:28:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs-progs: fsck-tests: Update the image of test case 035
Date:   Wed, 27 May 2020 18:28:08 +0800
Message-Id: <20200527102810.147999-5-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527102810.147999-1-wqu@suse.com>
References: <20200527102810.147999-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The image used in test case 035 has one problem:
- Bad total_bytes of device item in chunk tree
        item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
                devid 1 total_bytes 72564736 bytes_used 92274688
  The total_bytes is even smaller than bytes_used.
  While the dev_item in super block contains the correct value:
    dev_item.total_bytes    134217728
    dev_item.bytes_used     92274688

This patch will update the image, using the correct value in super block
to replace the wrong one in chunk tree.

So that later btrfs-image restore without device/chunk fixup can still
pass fsck-tests.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../offset_by_one.img                         | Bin 3072 -> 3072 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/fsck-tests/035-inline-bad-ram-bytes/offset_by_one.img b/tests/fsck-tests/035-inline-bad-ram-bytes/offset_by_one.img
index 2f58208eed71d5e0ee053d825d2780fe6842a3db..b3cef56ec9d73a6ea397c2084c219999552b7145 100644
GIT binary patch
delta 1642
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
a@VZTqZ_yOltoy21eufUFR_g<)vi|{B@h0B@

delta 1601
zcmYk5dpOez7{_B_5jsuGEp^l)g&mdC$j}8Pv(j9eOL9wMEO+@WB?)6FA(iXa8Ah1U
z+9sDyBqWKpTp}i$>@?2|J8}N#eE;}7@AF=s_j%v<c?nPgG)osgx?xSuGHV2{vv-}<
zvTL5cb^G2r->vgQEt&=beuiR(-$h#GbrTc}aLZ<?eNhkUCcL>Gay_wunouZvd`Gt2
z?TI4Gr2eFdYfU~{TE^CDrW;MiO|wC^@aqnTC_AvV8@5<j!?QTxvS&DG?(Gne{w+D>
zN*w3{)WnB_`|-I??A0pl9;P*Rx*7PyUGoD)9f)g_3ECQ;WDkre+Z$>Y+ipsJ3wDZg
zG;mNW(L2K4`NhQNE;&W6)JH8n32mx)f^A?er(g{K-P~PM=W)Y6?5gZv37~?wTU|lR
zX+Bm;#0t266aOk<=q0hMNI7T$G}*IW#gg5?P;n}V8J-)db!xTN>HIErC<H@NjgG=Y
z5nGeeSmOYJon@MD3e{tol4{0|jhjJr9&AeATup>|ZqYcTA-|p75$9S!e{%5KXH*0O
z5CGB4J<n!S`cwRHDvXnYdU5?cpX`*lVBC*p&c3dHKRVe$zsB%DKD-+iYBEx1i!;{f
z#`x7G@b3tlUwM`ZcaQUY@nZ^Y+OV)`^QBbC#^!E;7748m5Ewc)_1;*1wMt!)lm>|?
zI7Vsakg$AF^a)Ym(n$@cO&wdpczFBmx)j?f{rcparR!V{`OJb#2*(nTn$h|i9N|xY
zxTL2${;i!O5Ca=pDd$>$&dosvLC`v^@1J+il&88kLlu%Sl?K7&63hWF4TZ}#?Z<hK
zeJ!@NPypd|PnSC?q3XZswAt)OP<FT}5q*Pga1`UDvuGR+OozoTdI`L`9~EHI6Ocy*
zoE5Hs)75e+Y{^s6`~@>l3o)V*kD8l)lt7PJwF%^jv`Np;BKVXV{0#psL&-#bipKwj
zh+XO(Exnqhp+uh@fO)T4>>tn5&QrY;V$gVmcu%33hKi;`rxoQKJ1*pqG6O=)HDim4
zow&tjmPQljjbF`IvCiveeGD2cR*Av*v~Kp7JMqRD-^U_sT3ev?WhGuuyE47GCt>e}
zNc)ev!<8zVT3%-EE)PyAJDB7-Yc)AgSoSd2(Sr2wJTIeCd;EBOXmuWx_LP7a8|?m$
zY8Y%OS^Z4)lnOk$^rRez@+?Rb1d-jBL2K$KzN&D|r1>}MYVO4X5&jEqQEk#Qo9pos
z(AsaUiR7*VX!Qonb(WF$cvaPDa3XEzl2?(BjxNST1?`?=w=#Y-bWkbM#mgV0<f^wh
z7^UL$Su|2_ODu06)0e$5YR*-Lk*m34bv>iq+Ab*LbjQ5a-LYXMaWjf>k=2kA$0c*&
zj~7wT3u6zXgFo$)Z%!L2yG9fr;prG!)I>HaPP@w6-DkPc6iH|ZP%{*1ULoH_<<jyC
zsCQ2eLFNNW&x*7pSP>3OKRAiO(i6<`-b_AS;e-{k8&BIN=i1DS_eU5Q*5Y642O1N-
zdhI-lvm>|hk0P5@s7C%MRv6D};N^_>>p^5LXCA2C8^O*_Tpsmn?P?j!-uel@UkEjw
zirKs@$-I8Godi@o<jzRHJYA86q1*D;-Vc6R%?2tzns3&Gb*|jH4<cvde8#ZthE84w
z46J^r<hT~d*Zz`j`)in3#zt0MeJ2>B9yMsVEVHxfbiH#;R@&67kU#jbc^Pi`UoQm&
zFpKgfqj#=wY0+F_vJ6Z+{(~O2$TPmNvHtMkr3j;&KxVDPa(nJXj%(2jXAwVQQtkQN
z9GDdq7T1UE`tM%9c<!L<_GtO{@e9(qV6jwyR2{HgjSA;wV!*Q>bMWn7PElKaC9hiq
zfTCVe(esZH9q{f5d0`=0jP^=Q99wmm(yLAgRYA~zJyNFSpHgIjNSPeIOTgbKme#+J
zT#593V)1d<1p8W1*l=~=#NM_A-N1LcwF!2Cu$w~n3$;VvXHI}8l%?nY-)|J@g1V?y
zB1?Ez1rAnCPPR)^oh?Tt_Znoh?>TnJJ8?KZxH3laCN~lg#gX0pxe$HiGOSpl+!m_P
q$qXM5qgR<;p>-VQBjlu%Dk=<=NPgUB3YDlg@Md+^iYytDkJ`V}ng4?T

-- 
2.26.2

