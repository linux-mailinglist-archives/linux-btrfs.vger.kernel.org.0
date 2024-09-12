Return-Path: <linux-btrfs+bounces-7963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAC9764BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 10:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176C91C21D8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19968191F7C;
	Thu, 12 Sep 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tWxgcl+l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tWxgcl+l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4518EFF4
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130386; cv=none; b=kTXGiBZteB0eiHp38pzDm/41+2wPULHBIf93BF1fCYogyY8MF+cDZSWv7YYNWlJVeJXBSWzFXe8IEXzqPzPlgy7pmimD7OjURGrGttu8bUE60xFO1zRhfqyeQ39Njmm2RB8+L3wU3Tdsl+YJojK0Ws07Ge0U/p7RMU9U17kEBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130386; c=relaxed/simple;
	bh=55IRogAALSzxeCJiQeolGZDg75NzfGYrf3OleA7UyTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/o3Y/LarDnEf9+utXLsMqC3VFtI+LpCe6yjLmKbEWvJGHb2Cn7gO1XUpVVkreYxlErqouOI1WLenohvX7fKCbF3mjgwFh9ZxIUD5qgWUyGwtZlptfP5viZoFcV6V0l3U1cptumVNTTEBMjsrFhMhHwvqvjD4au3of/ei1LSHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tWxgcl+l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tWxgcl+l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55DB0219F5
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726130381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHfvjGBvus1bqJargXmwaGLNNJZ17/HdJL0AY5Ybt+M=;
	b=tWxgcl+lnNrSm+Nt/ntMDMqGxbWpm1RwhA0fFsBBP0qs87jB0QfZzCU8USqztzIyljEW1H
	VqPbKERKksgyYwKSHctXx5FaNC5en0MZlcXAXQPf01cUbKZggABKop0Xo1twAw1C4Dhx88
	f53cURo20UXm9bPfwkC8Zn5nZHjOhxg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726130381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHfvjGBvus1bqJargXmwaGLNNJZ17/HdJL0AY5Ybt+M=;
	b=tWxgcl+lnNrSm+Nt/ntMDMqGxbWpm1RwhA0fFsBBP0qs87jB0QfZzCU8USqztzIyljEW1H
	VqPbKERKksgyYwKSHctXx5FaNC5en0MZlcXAXQPf01cUbKZggABKop0Xo1twAw1C4Dhx88
	f53cURo20UXm9bPfwkC8Zn5nZHjOhxg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95C8113AD8
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GD5rFsyo4ma5EQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fsck-tests: add a test case with deprecated inode cache
Date: Thu, 12 Sep 2024 18:09:20 +0930
Message-ID: <2c133e9bfa5bf244eb72904360505e2a12d05313.1726130115.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726130115.git.wqu@suse.com>
References: <cover.1726130115.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.76
X-Spamd-Result: default: False [-2.76 / 50.00];
	BAYES_HAM(-2.96)[99.82%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,0.0.0.0:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The inode_cache and involved on-disk formats are deprecated and will
have no effect since v5.11 kernel.

And in v6.11 kernel, new tree-checker will even reject data extents
belonging to those deprecated inode cache.
Lowmem check can detect such deprecated inode cache from the beginning.

This images are generated by 5.10 LTS kernels with inode cache.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../4k_nodesize.img.xz                          | Bin 0 -> 17320 bytes
 .../064-deprecated-inode-cache/test.sh          |  14 ++++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 tests/fsck-tests/064-deprecated-inode-cache/4k_nodesize.img.xz
 create mode 100755 tests/fsck-tests/064-deprecated-inode-cache/test.sh

diff --git a/tests/fsck-tests/064-deprecated-inode-cache/4k_nodesize.img.xz b/tests/fsck-tests/064-deprecated-inode-cache/4k_nodesize.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..da8314bbe3ee4c44b40f8d6cf3efd79b98c30e5a
GIT binary patch
literal 17320
zcmV(wK<U5zH+ooF000E$*0e?hz~_bmfPexa0UQ7T0000!PZAa2fB!>YT>wRyj;C3^
zv%$$4d3{0=g{ecFT~_e!5y%|9Y5@6UcO(1xeS&Pu3{QfKu~}*~CgS~F>TZC%pTlu*
zrv#c(vNXxsncQV^&#Z$VUkZz>B1^`r;oSBwE3OZD`pwV&@#ba5O?7v%^@O;*uNH-P
z&r5+_c_fFOeP5aD!dS38mMt`_;uZ$8+7#lO-vE-SJ^ky_gW)WP<__SZr^GXU7i;0o
z+0m~OtAd|Y+L(=1%mpmernvZ%ICvU4^uh;To9-oy1L;HzUBwtoLwWNo4i+!<paOlP
z4(_qRuP^h$^7eXc+-lV};?nsk`r{T672J<TIDx_DI}SAb__k?&e}(zD?Rl?_wGf}R
zIsXNGZ@qO2-A~F&G2IF9&uk<|3_erN4qyizXkt2@>w^TlL@H!IN9-O9^--%u`wG{W
zd8Lpd;xeJ3nF3mdTCw^<=90D?RWekn2<G23x0N#Zn66h6tU)jY2f+-m#L-!+<>e6)
zB9=WUy##z%Z?p@D`zL3J@^nfy8njuUYr0vJgusXgPDy?KN+KtxrX+GwDDvQ$eXV9e
zS^<Y_Y3)F5nB1v*)VeovIgVUO=XB%S@)J2kLGPt|@_vxVX)lla-)9FB#3?RPIxo84
z_m-TazdLI#lnCb5)5CI+y?HP#P?XDn^)=Qcp!VJ86+{}acSr@ijZ^1Gx9S+(KJ@yk
z8zKYa4u!cQs=}$JLo1*?NXptRfc-KoB^DyyyY+j!OC=K~`#wdlRNGh)h}WbkQU%{C
z#^dy6as`>XaHXY|i~2no@YChb`Usz|Jy07~KN3yN@;Y8LOsj__l-Qq_h`v0{0$0pc
z@9U%(JYB@C_R<*87D>`|JAFVa-G^_q{ITr@s1{@N)@CXz5pv>bSoUE3e0}?^62r?-
zJ<iIj0G}<#SrwA+&c#w8M&Kr;d`#)c$tx>%n0r@MMJ(Eug3s%;_vPZoTo<5`H|UVM
z?20rCo&lN^C?1)=N%)*SS;=f8X3EA*b2RB;D=BLm@@iRL)AWD%N*g^OIo)m=6(#!X
z-F}qdFnOJ4icx2XJ{rzh$}m=V?)Iu;HGc;9Hj88~Z~>6w;;aCEt@Ge6nMMg#-l>-Y
zOb~S$T&KgAoevEcaEFa~Eapcv)Du;9x`4pprDhmp9Yd$#6K#5da^0gQ(mJld`*SCV
zfwDCh&D1#9WI&Elh~X`5gi=DNKRiGBDo3f&i+Z5X4@PSg$R7nb_X0e*3(5^Q(*!jB
zM5jr{ulrg*G^${um&VW|`e6YzR^I2pqC1l#k+EZ3Wrk`}^?HPO)>b@Oyy+*27ObC|
zN0z93sS~LYHiM>$-pO%>AxC!$nfZCAUuF*K6BT;}x8`pEi^m)PG^PBo-pi>Qd?i+b
zG)<n*=fLmTjYEx@0>CKnAv2S>)rq(3y+gn3nai)WxChKKI+OIx5PH&1Ul=-jhPvdo
z$?$SXbjFR?m9iQYjr6mjc!#)W>XC=p?jmL2oKc26T%6mPKO1L|90>c8Q|}>bv60C8
z>Tc}BjUnsp2O4o_8xOvfNQ@`#lb|m9n}yG-8D>Vf+NLdUA#lS_+cneo<}B_m-YlPy
zN0T~;LaR|G=FTSr0^u4;fwirJE*I4Llw>H^6_i|12`q1N>2ELq**L6^#1>wR@CnRQ
z{jM^KvW-HUw91eoi{>v~LjFoY>#t0XgvSJMH$~6+%Z$K>dI8zesF7J;im=L`V^-$Z
zB3pmrviw7yWfo#c@%&N&nNNM0<r?ir$+0?T?T9oYgw~o)UK_HG7;{tCUs$KAkFuZk
z@a`kcYIgkyg#<7-VbhD{Q#8U#!opD0BjGlwdwH8>8Z9Zb91z=I^+&{_P?VPj@?5B)
ztT_?Ad{{B_ppjsSOY&zR@&|jpNCpxo9JR5QtSndvP+wPAoy6-GT!)6%n{FR8E?Ys?
zoW0x@soXu7$>xrLY(+E;pyJmxQ`(HfQ(y}F{bT)-fXG|2nJL-pzgmiG5tvp7!@&P;
zoH=1}JV|{4Pkj74kNiUdR7c?JG!#)oQ^>a{<z$>7>znEbcr|C?+ELmZ9x|&=#Fa7T
zYxnBu=#hPc;XbbGuvqS`>;8J%==jtf6=Oi}0u<!;fKxj4BO4TLm2lfq*yZNFOxyHK
z+FCZE3Kg#v7}WEgUqJ{-8h%iUaaiyI%)bPTZd^|cFVy$j^_R-{<Ap5ve1g%)dohA|
zG0O0OKg#g{J9Aj)<i7Rq&aq;kU(+~nv}+YVXSC2>Aq{j(t<tUgR=Q4Ewc;Qg?iSlY
zxjia=xfc+}q5l<zSRExjhJv3}noiEQ0avff>fSvBAs%5n?DXIxN5@i)K(8*wsv6T%
zTe^O%Qgh)ZTZ6U)HvEtQ16!aBI9_B*%h3V><Dr6rEtS_?iebr+W{c(WU)u-=kbZ>}
z7y-9REA<;Dp3!f~1Z|%;!3h1QHa#%)57x;#lHC!SMramEU3NEzOyRr(0dchNk&BJb
z^%=s-M-WLk5@R_KGphm)GKKC)XiAuHt!4i&F8-<*hV_Y)%<Etah(2^}S3$9+Y%V62
zHLbT2U!c*fY$?z3@7Vkcg7{Zl<PaN<MycDM=pF+V%^Nv~14db4CRyIfM%s9`SNO3`
zabu2<{Hf|Kzd{YcgKjvTiaL(2Q<n%Rs3r<bRn%yYv%?Bu^Mwq71jruVx(&4Cep{EG
zhW`nVNrmt`qfQ|GdnMopq5`);{c3sY1?9i*m!^N-^IMhLbE<hy#(fAp@gB_>;%*^K
zIjdsOADZf*Two0sz0hD;CN#^0lwzcqk2-XAf8pqE<gHg93+HebbuDZw1}f2AjPP;Z
zc>#(oiTMZGtX35d(LC2zvf2dLxhGx}wLQ|d*@EPrkk`064725D4-VC22R>|awZR?D
z1syAM0OKnuH3M)XYxJ4P3)udl<&BmDXAZm{x$T|*kEV+YPVinLzxmhivD$kyGcecD
zJ9eUzJKt%Z==oXQYVHt$rM6{qZ^KTZufB%TDCvRkInPi0(SkhYXt-PtG5`=P{aKu3
z(SJ9NROYq~yL4BD$L?xZNjE>xI~(%vl@*rlqWH!AaJWt8k4a9MK@}Usl#PlZG@yHB
zwKeyb^eYV=uXj(gSYh`!KfPB^WB(ivb>RBgGY@?LECg~mcXRvLtn&#9(P?nj)7Zsr
zSs7-GOyoQeom~EnF>E8HB)+QQ`}mV5-A||?K{Ud>R$3JyoI*_!d$_b2Xn-?NkHfcW
za7D&h0Jp7VpGi(}nFk`rC)@{jgX9Wo->Xv7xZq{Y<OrjoSl#%LcxgIuo~bMV>?)tV
zQ`w6vE#Zi4RgOp@<NzXeGpdj2$;4EnJ2CvG@C25xdl&vfkqf}V?D<hI1EzxM-GabH
z2)UP;Z9n1YXrtvSYIyDgH^=zWIiu~zZ(dz1YfK4!$}E%iQJ2)}hD=)x@z2Y)PK<pd
z8#c`Q<5&e8*J_#>-BK;&JY@CLXGCe_e8G{CwL%nm-Ru{ST}14Now*DQRrRC_XW_F+
z<WD>aKZ#tsuPWCK87Os$O`0opsjas&-Hh27|CO6|l!<kXJ(IYvD~6cfSi&<Fz)+kK
z&f3OArdg@jWX8%+6XgE$IlKo1I%`(Ds7jmmr^GFVj1*g?ztYh>EWlzaiIa0adRJjv
zNHjNZ3qpp_S?&0*ktx&}w1)kod)SkP{eQE&wbW>rMky<HzjGckZ~ZPZCe{5uUfG1H
z*Ss9{_Dgv>z|Hu~g1WUhp3!K2Yc>iYGRs99NLmE}*3$$Yt|jvLD)SJu?8yd5H^3Gb
zvsMssiBch5d*N9RlFVLYa7s3s#Qgcm)HaRH@U-*0=Z2B7-@&g30K&4(O#ckc#~}~q
zYCd^s8-1_)d*(VbLAcmseI;SHbVP(*Ows^iVS@O(B-sYLT}jZP!rPQnF#GSh!a@A;
z_2c?a#N10Sk}LD4sZmaX^OZNT<!**SKz~mtD<tTbyRL~c4XB_AZ8HY26zJqOWbzK&
zfw%*LO#4OTs+X)^(BtEcEEN{_Q79bh8Q7Jf72i`}Ofw~C^dcLFy;n4ygF}yFoJ%L#
zhq4pDs8evst!(-TND9yS3=xB!Z2YD<t7s|h&?qUZ$z1yb@>{jSSeO!fp`@SUZp6}R
zyi*CdoiIL?=eut<YI8Rc(@>6;I1da0A|2EySW#_WI%rp1WjY^e$;$KG+XSmCI$qGL
zP4nJj9|W5De5ul8%Ba~YEYaeL-Ww<7*(!Gr{zl%DN?gMxUAR!UfgfZ~%~u0J<A3Z|
zJu$nT54`OP#f@$-ph08s!dQ&__#5}{>Z0b%4PtY(YU96_jAq}LcHQhKea2cDS3XPD
zpYuk^TYV7=&!KIHp-ERGz;!Psx&*cN?@tdedZ)0QV?vfk-Onc&%oB&WnFN~SuY5&A
zXXrVVz%;2dj;~HjLe08ZQN_dltWJF@sp@^{v}c}G6G6bW5jy73-GC}yG^>~jv1XWz
z4-e}N6kQ=y;NkFVz(%v#Ys|1efNotjjXQbc@B>S0npj^lfTdxd7Pr<oIFYPZwI9rb
z4sZ{ozXv?K{9tXv;vdND0dDU<!eD};@oKMrY!q97%2BQbnNE4?&a>kU$@TF71UieW
z`x^CHG<}c(tV`vF%COYbFMX8^@vO{$>Z)8RlAk1%oo?nZy_&0R+JIG!;Nc`!l6zsX
zOEx@V9BWBnLym8MBCZblD@!)_OPDnP`l5Whb%^eRL!+1$WEdsn#$!L&ZiNp4SjAMF
zVKcG~Vg$L2dh?Z-24ffc2D$}LF)5DJp!|v9@8;3cyahyv4RCLJ9&G6%qB63RWcEL0
z16?|3TVO^e13j4GWI=lyy@8`LuH@pqrFYQzSW`XJQ?VQLMJHFbdj(ztA9Z1TEX8Oo
z#u$dzP7Hqajd4I1+iAZD2V7Xrlc>HNfRyLMmk9*w6qs-jx>Q|}X9|;`HUK_9WVLKY
zq3fVuojcTE(g)dB36y5@rW;WpS(hgjv|kdr;y3W4oag$|GKI<2y|BMh-GyE)1;#W)
z5oLn&qH*KL8jK18hI322{Q*G;C4n*_(ZQ5wpqjof;QrTllSa71YA<7<b`02FbWV^=
za`KSEl*G9?-_O#)j5vyNH7RijULiCJGL{%5$XEVh)6}IkujUSSxR`T7biRz{=8c1F
zz?QoB$BW|G>~P=k-%#3kkd@DzxvBkth7j4tD5CL>zigN`CJH~KE<vQIngTua*tO^F
zO$u$T>&}pJ);#R8s`2WF+fxbopSZNAF>6RcWIS4AH{l+)qr^lyre%_716_l$P!Mex
zw06V^3^V8@Y1T>pHtVEY7~77<Vt6>}09hj|1?azvQ~?(M4~NaYdgYu@GIUy90yiP8
z56M(U;C$rJyYaXIY`_g^=eGmo?H=RChTLX|F66~<P-I6yCAf|~oGrnE#gItUg5t+Z
z{2XoX`Q$C)h%IUg!20udO@#X758~GLFm*aVZGV5BV6*j5dH*6ZOl&r%sb7l(^Ii~j
zp;&PS?o}ua<;ISx5=vFz3u)ZySq<~wV005m{}F^T@3P$Kd!e9;XEkO91jVr}=%74>
zhd}C^lik+yoD{!4HaBw6hBn;#&GPx8Sw|$KRNa}UhUV{{OxtZLDa)5s)*pEy)^Aqx
z8y*6K42H1{6MQMdZ4K(GuolWx<dlvOQ`^JfdSvQ+qU=+I$%e72nd^hj?Ha%B9=q*L
zEBiR?E(Atc;C`>~pTJxhY%;KLr$rtFk)HS|as^e?-g7-Hn+`K>^B+T)@1Khq<9vbW
zU<MF1xc7z(h1Zg6e>L?Fz1?<F^|`BaKd;<`C_i6SZU$bx8~zJK)if(V@JPnl?y^1o
zOfI|443x7=Z@+NYn&9RY#L6@v6BD??{(0~3VUnF?J;oA=$x~&!KyRAhd-Mx3hTzPw
z63Ntz#SH;2e>ibr%uiv9uPB;tAN&`}85By2LXMp!#2Ba*Tn<(BPXd~&9-h^v!+qP!
zv%0wDD5qQoQuK3NpO?^V1?+5YoSet{;(_dI@=S&Ugv@;K0yz@M1x1goe>i`^L4}LB
z-m36uaS+UZrPuJYjVKni(I#b>+K>z`8K8{jrJ{|eaG7&Cl-9o!MKrRr=5t?jdSiKc
zcE%`snhkHq;}7P*pCqEfbge23tu|BK-T;n%r5m_qM($Fw2moK-L)?HRbexv17tt2W
zsssTX^!Y}k@oH6D{A+~`KYMz<NC7#&$ha>UWWm<Zez~><mz(W}s94foN282jqUbI1
zkqw3M1n>Ri3;yC3jxW)P15SYq9w5mM!LgV(KI7s(Q>`21S6{es2P=SCF9UFJ`>kpC
zhZ2L~4wa*}x=#Cy{?B5a_n+1-65LLYR4nhAG0aq>8!}kh@Zu3yCWY9+Zh$QSVmaU(
zIgV-USGtZeFCGClP0H!0Rq8BfxAsmw?$GaU^ld_qM(Adfm#F{J=w(Z!DWQDE?%?n`
z^8}X#&#_-lLeXTX4iFayJ+aM89=fvR$!4H4hY!oCNKXj$8^D#HI!*^Rx=F_D@0@2Z
zp$)Bd?sOd4N|&RFE`bG&_Hh`y45%qdkg#{!w*G`-8@xbno1D1X=6d|SIYdohnjCV^
zkV|-wUnORvu6t)24GIx*4#uuOv|xmgCJ36R+2a2~z(oU1eJhtY6ZOe_R3X1tKx7|o
zW6<89i7%cCh|5#VA~aqe|DdQJ?^WjS-73o_nJM9@9%An;$5t)GOD%=RRb+G|2&HSq
z(BCZWjT@~ncD53h)$Z58N<u8==g>#WYdop7s^WRnct=IAQjknU)K*fMR!_}AtuwV`
zkc=Qa9^gP5g5F!050L?Q;_#pfkiTN;Z|RXzW8aC!hq6TnPqoiG$>j0u9NJ0JOQ2>f
zM_?c-!J9}U2u1B8ulj4EUPxFvTz_E!&Gh(6o&~K>&<`6=C<K~kmOXrMv1Bo|7zg}<
zM5kKa83wvP8Z`?ZX;ru47hWq4P*IDt;tG%Ou$rXooSAh6WbC+cLj(b10T;*`)*o^}
zQMsCQ;v0En&}{v+ZdW9d@AkkB+Mc#ZYzgbmkTQ!1*C};@YxX5sWVjbszqzrM{`SK8
zcYENG`^tOh6x>xw4REGPwc1zOSrj?_nGA@^z6v*lP{wW1c$n)JcWc1LSxnnw^6!bG
ziCU0RT|1=qLeEepi&=VsWMDkwDnARr;goNVp0kIPpg}!w+NXQS7>rjfy*dJ*sC71c
zY<$44-&m@`4DEe2x_BLJ58)ces1NB^Yir^0>ZLlG8H}$V^P7(T`k17eXdA3TJC!Br
z`qS-TAI~IG@fA7f>jYLb37e4*+eYHoJZ6h5=$}>Y(tlwSu+D1wfY(5u%$dZC=s}Fd
zsGZW`IbQ$QGp2*Av&a}Ekz{?o2z`7mKsoq;0EC!~yJu>^n*vM#h7mBN(ohj%_gjM}
z4nGQ}KsuyN=k3=wFK%?NrrsE3N~f`iuw&=bz9C}oK+{aonlhYM0hn6}`&XCI0D`!4
zyX&V9EPrHX{RsZ1zT03csQF@SnPIt=0^dB&W$SbrFG5=3VJ%)oXto)iD;mP~x|<kZ
z*vKCgc)ZRGoARFvRFM%3Dn`=rJuiLH&KwB$TYUO~quoI8Avu!`Lit#aR=+@DH7>z~
z@lTDdXXx$;G!!82k`AgXal6OfMoYF{K0advH0LU=goXQm*B@OkZl0{!Wca*>?E<76
z9Hy;3U6xY5zVGaa4V>&qz}Ci^8Gggq6rYWB6$=;KmYcjmiiEb(hK!8%9J}DCn%80D
z+vqC9;B%dfBctfM@9=`BwE{+gyfe}8<fC-$sZc4-F|A?s|Jl(QRr9d6CA@afnI*oB
z`fsT<O?DDvAhJuL({~K)D?IveYC`mH-PV$MJnOn+8cxTi58j<Aa$tfBhBS3l)D4*4
z;e0Y>!N1ZoA6j0fEg{Z;O}8{M+@1#AP|ClJe%W&xW0x!TZB3V#WARwOUu`;1VrnTS
z{JCW_$y|DKAD`xy>*B81(L(5hiEGT9#cm=N)hq4kK?UW?Xw=HT9>ZG}wnbii7jL%;
zG9Fm|=kOQ~kW)R#9c_|v%!HJd4(7n|e0zQ-VGzpk9gQ&~DH=`P_nmK+bn3Ws?p3T4
zo$^12>ytX+Hd;T-o%0S~Hnpw}^r~f@vN&boKNI#8UP0&^jfvHZ^D~68@cPryxym9_
z`sBO#xGr0)9bR$>c8i$i;>NCRwm_I>1X#H9oF!`a0^mtEokONrS%uM#tCiOdX_Q_a
zOcwu}T^<F;3*9MAl~kyC*XllR?P&C43<#y3b9)RNwGl!D>FR*o6U=40<JmP;%qOy;
znuxODqBAa^!s-#t$qMl}X!<F>14<%cyOB=rfjpR?Ps8z)M=!l45U8uzaQQ|wZy%DL
z<Hv~*hU@I>)S!JRjYHy>1ROGNH=4r}pw!B-np&Uz%9(q$;Uw7gbP_;U*chE16q7xE
zw@^vFUvS~`m^&eRvHO*_ML<ZaemVws&Qmr3QWjLTci(2?#i*jft@liG1<`MxQ9O;L
zBa@NY6)X4!p}VHIp@8V|575D+2#M7I{A|mvefgEmk|I+8ETlR0{o}fSRkg+w<PX88
zUAc!5n9(t*?(<=0^3p1qN+w@FrMfAs@5QG!c+N-6U(@CeImLzwC_{W-S?iSt-%qAo
zAk_!;u`lkefdq8Mn+|7XsHT`E=Bk_@h4JL-k0!lr$q1b1l|~vMcZ#Li!gJzUZ96Yp
z@4}e_^Y?tEgyunMNu`TZzT#J_Nb6)RCze+%AzoVIFxt0UWnI!Yr1`yoZyUW&)8MzU
zj7WE|Hz}Hx)CiH~^SZYlF5yiTx`b|<$lw!Jl6wS(kA!7m?LF&N1v2(Y3O{2Y7{ovk
zF~zC;39uPo1~<6GWwW%9hHL<w=0`OrMx@#JdUEq@R6;eUQmkN~3ANK(>S8&<La|k(
zl-gmjmZ{g0);{Tu3Z14OTELuK+g=~B7Zoe4<K3-GfL47Y(6vV2$x-OMTM{x~6aY*E
zSRkr?pbtNY%>+XrSZ9@aIUfA`0f?rT3tV}Vp1@Mug;fy>V8T<{lxS{tD3u0-GSztU
z3?Ek(v@lj`v8u_OaKpLqLKBUom1P>xr9Uc{<;EbmdW%mS38!oc6Ea_$g$=i@X_aJ0
zw7bxlD1ng+5g`Cqd@t)m!(x!#J6C4x$e<OMd+}IIs?!7E646htZLO{hy3ugN1`l=M
zo!K@6fU_jhS#CD-3t;a*Sbw&Vcm^sF%3!QsTgwDsJKoe)Xe?ICG2&?=&nWGK@C_<P
zbG|Ov%e_{}tfjb+;v?+!K~Sta$8b&d<JIfWDDnsefhKo7i*?n~x|H$R_aruJWVz6U
zKNB?TB;=aR2e1SVjs-dqjQobtW25}ZdkESb#4{to67?SvwA<sPZpEHs=qKoI57Mxx
zxn}QB9wS^LX5QhjN*~8WYXus7cVG3+q3hon0_@$BT(F0aFi1=(BhCKG8BNnzBiTR^
zxTKb2SY!76<DH$HhFHjm^;!|f3=^QZ#0+*+@aLy(z<k5Sv7~#?MN*dlgwWuh*PuCE
z1GtZJ7Rrgr!MA<U4*d8|W;Se-k$RyQsmf^d<BW1yxJu{w89DO+;Ns)M4buC2CS#0l
z$`%ElAm&)4mK_{mCueq^=z`Dky2wnpejmvOK-JBsvH>F{m$&2PM#*INYREv>a=O|$
zDD*Tu#nYaw@--w7c0uP9EL*u}@JfKO&RykAY}fFo5$P#y?GAwWlM7so%fV6Vf*=*I
zHL2W3pkvxU0=G`F))}#Ys7&TxpH}=}^I9>^lqrO74f_LqxK87ZHazl}Usf@>Z&mXE
z7892{FSgH!2o$nDNyiv*DJXOf`o?0oS2fI;aI*B+C|I)FYe_8;DE|~*@urmV(oi&E
zis2Kss|Gk)FI)wZvo@#iLWBxH9>#0P&m;g1xRJsjsa}@h;5gqY*xDhF4zc#_Thxq}
z{#_MOheB}UPg|@t7>PxU)Sf6`HzcOwJxaXf1H}P)+Ze6k)&A8JQ>&g$8+yAX!Ub?E
z^?<x|%{|p`T|Z3+wqPn&DR@09(K?b-W-vHzTWJgZoPbrpCy^FFBSAQhvE}d)J4we%
zEC3XK+~VSdGCg|}A5}f7O9K$#zuabs<6d1}dX9NSY1zy}O%zUr(&w=v4=Qr}-ANl<
zKj4~9I;P;NQ{8cR_eBVz44>Hf`JZO*f7Q9R$P=bk-#t4pe*s}d_0a=u*%5MZ+@g=Y
z_ZoqO4oTh;^KwFv`)Y!G?knHTj3GNx^Qy!|fN<_DNV0FmS2gRgqBZZL!|8-x8`h<Q
z>-_pXuxn=7ZTHgt;>8h%;a%Lq<ul-S{XD4+N=u6;$)o`cj@$f2|6QT)y`13XDa|xX
z$SY=Oc60a+jA38us8^~VjIt*ac`$TRCj^5mVd!e#=WyC1*S~+`qHpT-oX+Du+~E;{
zzk2q2Sz=c&#xar9AJH!ri|=ieTzdw6QG$9AguXvU@{3bJglzJq(f7I>ry7_82C9vo
zQ*z^>BBTiGKW0=1_bqMq%oQnE6rDsJXKO13(aiw$z1wyxuJtvews%5Z<4BCM$JE3Y
zlu?Ly64tNQylmr3I*|jQ@9-|6NR@dgjedXsL`;{(HU>1^6y*zq$7X<Yj5tv@K3!bx
z=N7coAYFgtIc*9eosoXc6*Dyv_F2?DJtUC(%7<`Hx2422D<dkZ+hr;=ukKCB3D8no
zSpA_2mfX#1M`+;%oHYuH)+Zi!<T^t5O-G9rBWF4PvuWhW;#ae7M;$1MZlpwCX{lT9
z`;fC1uV&$e1GWzIJ{T5KL*cd0A3fS|XmifhCd;6hpu8V)brlfg0Vd@RLXm<6a)3^q
zs-SUjS*3lhM_bTB7IgYnbu%r$+3jhHcQSI<Ni}BsvoB63Y8-%>Cy@L|&Z_67(CtW(
zu{Va7gPId2t`+A?nlWdYACux}eD4J0Od#~B=)5uTx8EK7M}o9+qVANd1aX-fOo*sl
z83r=Ru`M~@F>v?IUhI_PO4#`mSyQ_SVgr-5VV`__Pm*_*>3@dim1WpyaD=)}k16RF
zqk&}@XFkUjQ_^2vDd>pEi}*o!4XN$?it5$B4>IZgzZ%@!D%bFG5E5{#X~nnf{{MCP
zqbS_E&yjhsD4~Jn74U-byZacJJ(=Unv`DRt+Lo2NK8V6&ZUQJhn{3tj(C9&1-nJ0D
z5wYj^)CPs`o5Z|1iXMXX=C)G_wH7RQfPB}~7*+kT90S7z8Wd;6#zxFbsU~AG-QiCS
z8U?&Yw!r}tO=B*fx8O>>hq)fHxai$FIZ!DvE-r&-h52R3^TDqzB_8nFt_U%UUWYrv
z5k!fk(Ubr8QrYV35yGryw;0BYYn1QsZ+!tPi88!x`$K%bY4OC8mE-4Bi1NB?R(0xt
z6~tZ4A!U5M(1HYWvT4d1Z4x8~#$2tx)AWJlc1-R|8Eb5VE3|M?2fCqej3~)!4uh@h
zGkE<tEq8q-BpQV;oi$1Mj1SY%{7VbEyf<w@yT7P9`2&eh1!q|n#nTALUdD+ay?R4W
zD2Gf&Fv{>gesnf6yJkd0u0+*b<}3KZ(34Dv07C1ng#;PSa;?_OxDPhvlgRWic}l1<
z)A9o!fT*DLaqL1nv8eCpzPsMpXb_33FX;(H@v%k~^;SWY(KBAeS0T$zL#B99EI8G|
zyhga#l;v9yPL`V_RV2z)Po|b?+(WJhGj+S5Mh6vVYpx_8@bJL=sf8Q#pWH{^3LVX>
zB`N!U!FwkKAUsE!qRux3b4oidrWJzbSZDg}QJOu6)pjsevi+e5G}eU7bMUXg9$J+G
z@@*MeE3W~@YhW|k>uaB0CJ@mFcSj-@s_|FXt^GU*<n&jEpEKyO`&sOhbah}ic^L;x
zBp`Z8{fg~~xEB@{9=CK-|9>PQ2WjZUOEd5GW$xPWQklIDR_^ELwS_O}W~=Yn4$OB@
zke$duH`c<#FFD$miqrf11W-y#eSp4{l#|2T@0>Uj7-$IXE;JI`fB}bka7}<tns=3=
zJRDqcW$uC*IUM|+{i71_AF<FHqlY@x^_`WN9xogk@KHy(Rp!PrY?Hvjy3|U0o9(&0
zVns?GllUnLuv=^>c=Mzr73+-XiuKCzHI+?cZ$!&b+I+Q^6|`K*aDR>!3_<KP)#n52
zrWhZy-3RN1S#kEe2>eq94HnK{*F>e>!tbd0N&IOkw}6LUhMxYI&XM}b$qN-<@DUYX
zNr>fDdWbw%&y`H#qB5d4V;XRx4D+~g%Ah#-3GW4z4c5>w?BV@6^3C%L7EaAsn*Zzl
z^@Dmoz=9p_N`YCMHSo9c5Tt^-Iow<wr>d*R(}r9*dRBv3<z7W9!BxrkGsRx*$CE{=
zaHaFyR;^AI-K~K4H^r6kUULMo0(qo<9O~3_7u$_8*)$h&VQle^I$9d39E5pEA**YY
z-}WYQvGH%q!d)h>DyitvKu(eb5~+y8K2Xgl$l@VH&}Q*3%6mKd!EWcvoC0-~(&HS1
z%37QNkFgX#Xhjf9%Yvb-x<e#WR<UFJogl<WL_9Zxlr#0|sMw>RT%M;;+f#OdWS7t;
z8-jXP$W5g=RpZ&cU6fR#8+YTY1zUxwh7Q0I`goH3s-~Uv=$ylq)sJa8YM?^uWt<q+
z4PxjYBfxI+XI)~w%5XJls70`hnTsaJENW=E-trNz5QM<_<Afy1&gLORm9hvkcPQ8I
zCUal6Uwt%ibUjebR7Z41q(&&tI#oFSJC3!s1UuZ(o48mZ&cjQ09YUf<Z_HwD$zSXM
zp`UdW$i0kwR&-)1wwXNnfF@L0$h)XLA^CbWsT60qV7x$+PonnUTiQ_X&$1~>npI(5
za|)e58jDIlLu@*fY~5=eI&Cit6J?iSChgOXYX@Mw;N&>6nk&_r=UlQtDYQ?(-V)l9
zP;_ju{e@nen+5dk;@mZG>HNOXSZ`CZV#QC;v8h~sT~lHQY1D6Gy_nxA1!+%};0=zl
zZH&6&XoBM|7viL*j)^Q`Im;S#%kgG8`Z&ed8;gN-=j%&zi4@EnJA`y14?rQFh!poF
zcV}0+t(?qqY8F8Sk^BEC&XBLE?f#QW>=_(|TC+VG_ohcAuPN@n8Ojo$;xQ|tJ3|6%
zrc~BV<4?EtQTH*-@P=i?oVBzg`M=;pSdDtveO8^QgCtPw0Z(ilKp{GyUU-l~iX=(p
zqm1Z{Zi>WbwxHXM)PivgF~CR*a5JZFkE9GK#ty#>`!om-jnZdv#j+yA%^q==j_H~0
z*`nuuVMr`!iEuCiIEc&j4%Ok$%gvu9r-j*#B8C|;n}Wqyxydoy<Kx=B+-jzjWsD})
zo*nBbFHXCZaTiE0>1$%sXKtZ7XhjawM-}hEU(vH|X`MsxENJ&R_uv<{yZ=->RJTR$
zJ9Z_!XkJlA)_6M5EVTW=Xi#e|8{E<vLVX~Z-erA`-ts}eWSNt`jRq3r1qLVP8GPG%
z&6rpUI=Xo=i4LA?g%wA#Qau)yG&@n1@&kUGs2jA#eUy6lD@P(|Xy9q*D-8ettXH&(
zKpTtvZ4R7pF7iDKVC&5JTX&WyUVhLg-_E{915M~4D~I5S>=d)sN&sCNnMqhdUNQf$
zcs>;slP~L|VWj;G5g*oB4PFj16Ew?ij|DfkTrwNc%$x%Nk}d<VM$b|8nBqAMLa}+~
z37n&NpE3apGWlr+Fv|cIO*bNM9cJ0BMPRand-cP%!q>AB7jj6?4+3um!Lw@ow=1z3
zAsDf*(Az+OwN;1;1(NSZ_c-^<8t!X}m=JFDyLUFTS{>ufTKyqlfQ1L~x_bCbLG}H)
zM~7l3oCB;qA>JKj$6KLW9UE0bTgR0A{{oAN<J!I))U8*O+*USNvW9?pl8}EbQVC$g
z&V)Lb2qgr$b<}l?cj7+1FQi|PTJvjT>|X$By?@^IRe#o=3!J1>_uXt38>5$S=yW}(
zspU`3N|etmk2Sm-Fle!aL^b*xX3iAm0|V87vGASQ{Q`|yXo@W8ZOuT*+)bUAUR2~^
z>uHRmp6;!YD9VAh-c031;J&o*kcJT3b9MW5Zda^^NW0~&zZM{buY{M%xlGx61{6zX
z7eZ4k0C(%|%dbP2Nl=2^`m^i44zEPk>2@2p(#k7vd8OvxsJeIGs+~#Hi@6{q^{RQw
zO|ZPzgL;y<bSLgGjG2F@tNtU9MA+nO%=Qt6(4Qm5ZN_p_g?g8@fS@FaOi1Ox*7KcC
zndFar;AUw)YLAcKewN3%rG}ngb3<&;d34OZs@p33C&zNReOio}EsI)!?bm!F_`R^5
zn5)3Q$Ohb|$3(p(L0Yymjlnry{)|t<e_}DHd8KhhNTmV1Wn+9#Y9Kq;uq!qc@#gI9
zFlC1w=1Q_g?P(TN!IqLX>(55UFwNZU*w~6M*MT`@^3rzc*mBB=Th91n(ZKdg040^H
z@kNhefV2kh#0Fd%dT>D-Ef_xSug@VETquxwmJM>Qb;%C(St+cDOHNnkmPI~U2BurB
zlz!&=V9#IYl34VyBgd1(NQSJDJW=L0mPB5g`j`kLnuXaRLrd+#OT#pgbUv>&=B$9w
zHby(5JON^F>MquYLH_pSJLRV#g$NZg)*d{Og@cPPj?+@iS|6Btka+9SHP~y>v>k>J
zm*2I03c9>2>@3=?bxK`0Pc)95R=;s1%-{ViuSG0wYq+F$+E-%J#sk4f5~GM+<QTNM
zVeA*8wWPb>TMxi?ZCSpY)_qaLIQ)+*=dLU8C~e*<vD(wdfQts~7QI_u=ajG^g3spe
zh1%-21yi)Oq@bVZb#4eJkv@IPdIx!#5;Lclg4X(vyB7!m)7p*6!_W2S8}sK}Vlsu=
zg|p}A2y1T?!f4H?KpQXVu6xTlbTXpx$4YF6SKl<_d{8fjjZX0ID^q4Eil90S-NM-R
z8gQeThz%Eqk9!v7sSW!4IP+TW9&pn!Kh)z>fJf4g1ry@^aav4lz~VN2N9y(@Vmrz2
zzJqPFM;>5$%<-0A<04hJIR$1tY%p@^v5w)k$S%ubD|lf}?;#MX)|-*kmn5TgID28b
zZm8KR@js(*C}WMWn&g*D?@*UBmwJ1(>b)^XQ96C~d`WD&B|L-y1Zi;I134flmY8gO
zvg=*WiDgs2#U4fLJkifQ1N@Ic7va=bP@%v+UI?xMSkzG{r1xCTZPr&6h5D=*n{+>l
z#zQ0F3Ti<3p|~Do(S}=!O$W2=hnmKzoC8^?_f_J5H_x8a-*yBT;t<{OM96X7YW6k(
z%a#lt{*DfEI)f&7Do{X83o`i62kis}#~sn3SlJy?*jXe9J~Uqvi=l)X{o}~KJh9>n
zN0|vtZQW4BHCG*Lk3SOg8KL_V&uaTxMqDtf%*Qk~YUNj`!g#OR$EpVcXNVxU(|*tX
zrm~A;Hbov-6t}R)%;Xb0V|Y1)q+zZo-v2J7K1~bHR}{mi(IU;x9V#K0$8o2-q7N$r
z5BcWHnLhvdm88+R;kGRxF&f<fC|<XUjKExD=5H(BCw;K799~A%1Q1Un+m1Yc+``;R
zfC4Q^<B?LOn(Sa$2oHKx=4K>@6upr-5)QJc*PCiccy`}%XARe;Ilpk6XAZ876s(HL
z!HCO2*(#DZcg|!IHU6!t`<HBznh5$lu3Uot7aN}ZSVM947()ayWL$BwnP4*{NSJ~+
zbN~!TnFl?V9F+jY6t1zqohUm4(WCvm5W|CC=KcBFGIiV^s@-mh=jCp~8k5b#+>-Ws
z3WV+rmeXn|wZ^>sPkYxLBt0CTStjp2Hy<Y2=Ef^|b$g@X6Absk^hhuZMMKe@%%Cj-
zEcQ{you*snZczoxHYvb3Zf-oM0(d}UlGaz)m~12ZP5+M;EB9qN0+4-QX7&8?ZrN~d
z-bg4}ek+@eLLFchOTAt%n-BfJ!MG^&6_lXVCs*X>e)rUw5%?b<s$DXj@y&jk9F`eV
zd6|1?Tfb?+A~ItM1l9b1DE8+?+I3FkZ$}W#_okg8dbcKgB>^|)q2~1I%I96<Lu727
znLsk`*4UpUxY>L2`7);M&)sl$Vql!Gp#>rV*+otOjtl{;-W!_ObZo%STY}K`P?Laq
zDFEo)ZbJ_pH+3Tn7vl<Y=96g)s64vfWgyB!ju@BQ?jl5T<Sg!|U~H(EaQ;NFrF4qs
z3f`4flNztddUh#|XRM2G2W0XF`R0K7HE93V&%jH1D^-#EW*M{KVAWWKx}*JVi^xcn
zC@<2nNNi@Ktbwk8dVAp9n3`UIGPz@&#jzKW0(0Ze;I-@#r&LzkEFhJ+F>YV>dbC8j
z>jTa%=+`_ZUI*)*zvybP$;=oG8?x9g(*Rz|ur_{Q@49w>5uZ8}*4RPvhs<p<+6Ftr
zEJNaJkdccXuq!;T3Shsv&wi6-l=Xzqw#ppcDQ0VETQ+APBIrM))QDjj00X-L5DMuY
zSYt!5V)ns{j-E#dZy<WF9XeUhjM9&DBo65Iv$ry`u~-4|vm_=y9IE%K_?~%SBndAH
z+Q@WS2n#?Jf&M7>UkCI^6So?P{hC$zvL<|RFc6al8ztt31zYjS3uzYm_O-1`s4@S5
zPJBwb@u`NxJU(3JB}n8&?@>f&pz07h9Nz$ZpNF>CJrZuc;%$<J_^cXO7r}TMhTd>w
zi01Y-^&~_Le(-|<Jqu-D_H3I}Wur5ml^Suzfwg$u0jxB`Wg`}PH`nzV55k}^v#(Ov
zzr!KYW#yCF$Oc}8tq8be|H_(W7vEIzVK;AqF2Pv&{bIc@ve?4mrVE9UJbQS53+k##
zf2shTNU{r)8O+Re#ck^o8)~uN2c<T3Il^eux|J>qQD=9@0n?-?m`5u1eYbGegr#4`
zt#rU;bX|pF;s~|9o(Zxh;oJ#WGIN;QahbL+Dk{2?aRlfsLeyuae~sp^19x6cKx#Dn
zT3c{CZn&n$`4#)N<X$}&C--fBG;;mO8bG_P*t|5n$>c)e6(AeiXRv~53fl<evW!ph
zpkY#LdHg%HYsC3?PlNH-*_=Q#l-k8E@@<xe&j+^`R2zx|v-Z(q_R-7c-1>N`-bJHa
z?chSddd;LZPN%~wdBb9|2L-xCN%Iz8!Mj?({z4i_Qj+;sHPNe9f_|*g85nd{Jxa>a
zm=*|4yO|6!c256-3-sg2seLEhk?nqDpc2OHuyTT<EIK|0CDCOn<l7MSO6A*>7ubfB
zo);?AB-iNICzdg7#3?8>E&aSVCzD#0)sv5@D6bScYES<_k!Y)94`We)$(c{PRD6c*
z#@$nJ#EDIgZm-xi$ft3(Dt18eRDs{TPB?d8%LCZ-mR1aX`9!#Pq|6Ds&9_M_s6y6&
z6E3dUTvgjvz{6l;=fU%ZOh?*>_W0yuyUE*+Ux##T^@N~5p%Jlu`4Z@imP?%!T8#H^
z37SOL^_Rhzz#y0tT!vS(WWdw3Mpv<u9F_;7>qQAmW(fa16)W;#e{uf_%=b9QCk32l
z>d-Z7`8EhO-lm&kDm>V1^F^LHQOZBu3Hoj;CUt)>G;-lLSQuXRh!wvTN=^|9(~7}j
znrG2|mL!1nmRA#;0?c6xrw8WjF8TPn%?+57)3?wndWsa%KJk@0;-9y1``Qe5@qAX;
zN(PQ}jfv~hA=zOw^wypEO~Vw-$@6?bpW<?>=o{Kb*c0c~3H2^pFoe-VR@9pb84p@9
z0_2seL2$Zn-%qUDhXKZctKZRfE=2^`DH_6Aiwy6XQeW^ChKMMp-(fC#&wdB<JON{!
zZO<pb+OH;?QqNYDf-i-Ji*|O#Jf*d+gc|`X81qp6ggsP#Ov;3tJRg`C<0=t;wTf@~
z;D~HgYchf!ZwZ>d*nDz8SA+3ebmk6N?D9MHX>z@dDyDKp0A__QXSWZ7N~|`(R+0a{
zQ=*OqBl_@@DDp@Hfr9>`#i;5VG4u{h(P`vcS1Es@=Ir)l`coG|edIPv64%xoECF}2
zzfEK;FpYNEh1Gy>YMNCZ$!&~kx9)4mz2<L+6q({<$l?x)B$9!6`;Ru|(@|jFq#<D~
z?LEK6eJE;;bbxu~77qTD5a$_vBt&B*nN0K(=q&X@1o8X$+S3nrzAyE5jHZ7yy;a0X
z%4ZNMU@yrchNNlb3naMahaS$R*^&FfoFb4v%yISjtTvkueZ{5+z$Ym&tmKKW;C+3C
zU7rBVEP4cS*<bG3vN&3+;2eQsH|CYiBn$jVN+2@X03CBzb%Im;rC8A+&xb3Mpq7U3
zE=^M1O-dx~iXA#URxG(P7xp#e6qEJXcwugd`I!ZaN+G#<h}aD$Qo}ws?@s(h4ahrS
zZt3E*o)r=92%T9oYga;WVuEZ%e(D>Xy*h30Ap>zqwNlsB(=Tir1JMzKmszS15Hxmv
zSP}7IH1Zfk!T`=s|M~EC_8a!|OIp>nOlp@}T4IAIY=)dnl^6k~gQ3{dDHj*n@D?Y1
zeAuJ^a+V>zK=k*TFOLjuW)Kq8Jy%jaY@>IR^{X8szVqmNUYs6=W7H5`)*TEHM!r1~
zsIlcg^U^d*p&wgWy^DXlCL1B0I#`{r%<=|Z+x8W&Z3ZkC!lWq&0p@qVibZRQlng*=
zeF@^P3#|@ajhsQ5LhS>xMq7k6`GiZab1Z;Mp2&NC)=$|`zLAlN)G&Q9UI`Vg7jy$y
za~#9~fIF;}Wpy0NyUM)*n-+>gp|6pv!Ak}Exd1roqFxm+EFsv%M@H&Gw5!EJ>w2_u
za|W-+nUK|X6Pqn0n)$=AS5Lc5IDZQMS6ugj>fVv<LDB=`6!y}0AB~Sw#ZB!)3N;Ai
z-L%G!%<)Rv#Lb!54)s<qvY!Bt|DUuq`Cf)K#o|HU1vaTo-7v=zZA;OAcHSJ^XC7Vc
z`S8RFOY-{Wb)vXWZ3AyJ^*B5ZRJP+APw(boKDa`LfQUPMBtmheO6FeuW!N)!uOefB
zITwoqc=UcEve}9+HCi(Md1u+dHUMy;!8B9Gmb)1GwTX%G3qVVPEty^hP^X~)<n?fU
zRJlqIClF_#M+5pt(&mxMEB_HGL^;n?)sJDZAKA<t?~kGNL`skj_6f^{ZXTabUBN(m
zGZBe_1kR@?rwc~c57xGy&Xtmv1I4Fu#ld7f{>r%gg(sBtS?jO;G~(P0mJZn^{-X})
zY9v%@pa7&F_lQc;aT@>;!<P@mxX4#Zzx@a1p?rE(MtCRQx>K6}=jEE-0|{WR&JIn<
z@b-eEA+=M-#p>|RFX>$E*tBh=M#-(*kW-ABz=!dlvn!MwA5puCDTgSGF7Q&4E%bJA
zpe%Sg-#Ju6%S!qlK%pZFpbau19Z|J(`acOW^waSSF)kun-TZn+SntN5C-oJy8XfdN
zCB7CeZOdKOEfm_3!?Nj?Ribu;4n!z7fHo!DLB%D33uh9C(S^C9Bd;@Rv_V3nYpsBR
zLcWM0kM2XL6@t43_=x%KEE)`$9{{}WepI=2owii(I904}g3wyd0Dw&ZMn7ekb4IK$
zG89ON7)lYZ^Hhu4>M*KRO1Xm?2eov|W``__zd0%cfm$_B_Fh9s3Shj`?pwHc-QiIV
z37&%Brf$wP8yRh{hQo^Se2S<x04e113=KufL*K~QAEd-!GnM4Fu?K&z#_d)nPTyrQ
zd0kVE>Blm4!W1r`<>PzMS#4La_9<aEf(Tbgu)`JQ{3?X+g5GR?bZ|$65c*+bJ4Im7
z15JXo+JpVGNQw_$Sfloxkom8ZTrjG+NP*_jdqAhqYRg$LS(TWM2Vxrf6=|hr1VV<B
z0^t%d^2w{Jy}z#55L8kzE}K`+(#s&5qB1;#Gs4gWqR-T}kPuo}!%!wHYU1}iolHlW
z#gsYFeKGS!l_&Hn#1X<G<&rFycq#pijy;B2|83Itnu3%R2a$x7PHT24TaJb?nI?{f
z=yA`g?3-J=64?FRq*llje%zI;Dm^T}h7kxVc4ZZs3<OrL95>uyqYovCr(n5WokYX8
z*u~Ao4AKx;ekg6W!mx<JBmY7WXY5Se8;$dZf10e?v~H}w<zMGl-3}uf>!T{iMZCf?
zhK4@)?QoC+J&u9!efKO5;015A!IAUrUOL*8RgwgK?7FpM<ReM83b0PYK_9#3&ztrD
z5B#`z6@ysTOkgzS&VUr-##vn$1^y+RWh_td0aXRh%QlMcXhM$BhJYx8YL2fTv6@Mj
z(!rQ1y6=&q8D^blKYaIFg1(bZ@Je>$mzIs0=T8wC?Rin3Hithm$<;&7BH#a#$LNb1
zW-*9H_ZF*R#h7F$0r*<<h5CiE7#XXt*UN_X=Fo}#_qtRl7`Z)~vX>*Vt~ARx8>55i
zO6x)1K5=HQI_l2!<g^x4&;H|y09X_4WVz`r2ruBUgPtf%)pjI<!FIcy><TO$P}$O$
zi?-=*pOMUNrSkOqcVIHM>?e#M%((MCtxA>JHbTN?gHqoW{_1RA|MX70FDUxi*itw8
z)(EIT&RMvseM8gIlr4#C?*tu#Z5@Oo7>`Gxpq2ti@3CZY{^V6x5zwp`A8r!~WZRnJ
z70AAbed4rwv(~`r_stQ8@s`W@SsJ0Rbh+#NPVO|&72@xu*)(dR-MMu;Ajtaff2^hP
zazaFx$Ffey2+z7N1Vy@Z%4FI*R%ZuIBM$loedZ<bS|R31a>;l|<P~e_S1r3tA7aLv
zaC#(2G?g=qe*8M(T6<??{Ay*j`6_?dZ8bHUn=cC+L^3cDf2uUEn}8FOr&|iSx4{}|
zw~fXkP#Z>d-tszLIySAHx4?XfiJPUa79yu-8C%?Dfv|Rj#L(Y!GN`^MP0zkoEdcMc
zyy;S=IV&<e^KOc~x1>KTv3Mq9Du0kjV^MjrT_)W=@s+g@!yj#OnKy$wtViY^UTc;P
zQ7723qdD0Bvzd>ESXCMY9VM%V23X(D>BlN`rARD^;RC>SD0QdNtSY&jrd^Hbx_XYv
zpLQ5NSw^S-=q>gt43Ln+kVE>!1r5kVr-G`*3i$0_2P7Iahk1sN8+YDz7pkn%^>wb)
z?h2#SxGH9Jq#jAXR>xCi2}#)2|DvQAYgWuEt)BoQsbpv;e;Erb@wk&V|5fm$T=gCN
zapv_il=t}?pnt6DYEsme{v@iaHhfJ~|2lXs(Fm!15mBeyx8K_d3yCC(ONKX<B<~t4
zf-kUik_1EN!5#em%ffg5TT)q7LY=~0*IfUl&aiV-`%UPTlg{@x>{#ykf!CV8U>G_q
zsTZoapsK~WS;}6wY8&=wIWzBf3hJq%eZRXrl#QmSprb&js&#tft$>lwebR{5L3V~(
z1D&V)mf6Ff>#*A&ozPgBRTai!uo3!n!uq|!CHv@T1|aNk0h3fUgrhunbdIH+A18n(
ziCdR#J*Uec_GiO!9n@W7mjH%#9r$Jhh`IKzv%bn;=fT)C8!<!G6~`xP5;4HSq;oS3
zzRXwL5>v<Bv?h^%gVscm(wG42NwkKWbN$GuT%twJ2)vdwSjO;sodEr`A+z-z64)ZJ
z7$bXIN*?mU%zrvc3yprxF(ZNWJVD=ZZ!Z-Acn$Px8@>a2BUSH&$ENCzLYs+?7{rQg
zo~+c;?Sev^v<GYcPU|)165-9WyzK;N?Ib>U?6<CZY>TX%GmpM&R{Y0=wGGKVq{J$F
z0L{(9Sq;2s1c-6EmH>vcOT~Ou1hV&*gj#Ax6odP0gaMKRZTwos9{PCMuxVo8)6^|3
zEu{~F;Vy%eUUQ^?Xq|D75^bh%&R6FeaG-EE{`Y&MKSQ#ZhOl%gWk$jkWJsF;>fh_R
zQOfX@r_0wtCu%sz9ktmMFEH@f_f0<4-cx!%#sedW%Pb*e3t{M}Z&k6FuKLtK^YOZ^
z0g+2L3@M=@wr^M?QNO^AByzBIL=h%F2w*03N3GV@e!QI-<WkVc+?>Y2@8vMSIn9HD
zh!|8ZqxdBWP<-EWpKz<xVzS$KAbd#&#u)`c;|}hi43~_TT#!UE?KbjWyg-gEMgv{E
zRQb4M>dFgf{&$aUBK66|qX_^u0(k~;ZB|F18~wRFwsK+JMtH=wjU<>0*8vUoyYh~6
z$5ZqxXzJI1e{OJK)sExMutI<WOsCFToj`OFrP}ly($o9Ow~Z)S1mzgOeYt_9T|F1c
z4QYH46Y9w1iC@#0m@XLCG6$07@3QJeHBY$FDPQH04tz@(2<{lPcZOv(#e1cHMv-bg
z@7xvbyZDYS_1>Lf)veKem?q(BY@4S&cfsY)36f_4^1G07xqpsq2l$7Fk*|ssF_qj2
zlV3YxR5_rg=$tlzm5ypX(!au+_5VZ9DX&ugqnHlYv?Z*-)Z+xBwUag$SQ#^3`h%?Q
zTZDbYu<0OMBu|c0)+RpVHqFo({7A)nepzBTY$qmi|0M3byLYeIUdF`pDS?H1*8<A$
zWDKb;BKV6^c&rgJg!LHkvJ30v_67+R#Wlcv6LiII!XK>0t3<+y_GoQq*%GfuOC|If
zpgKVk<Pe$OANEf-fcfv;z=uK)TR2?~mbk>2I{kqTL6#ZZT!VZaRw|la5vSA7Y!H{)
zUn**J*jke_0kTCCL&&Z+6akxk0s;(CAV6`_!vb1#&{bMa^&QCl`M5R0yKEyDo1~Ea
z?}NHRb^YN|yh0EztAf{691g64;;FAwgX1Hul9ra%T6n1L_v0OWxceub0XGP!r=Zas
zP*md;1UX<~Lq@G^(matYx?MxP2Ep#&EVU#Jz<Nt;oXAHy;pE2*Se|wPjmI801i8Lw
zh3|Wlt-QCRmHyL!UO-%&26iJcw9ecScPtDRy<D)7j+CRd{6AW>WuSSLOiX&U^lfx>
zfcACMcp&0|oWmx2fgfT-oL8+wkGAYk1sutob4Hq$H2?qrq#KVwbPkUU00D!C0f2x4
Tt6Q_wvBYQl0ssI200dcDWKGqt

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/064-deprecated-inode-cache/test.sh b/tests/fsck-tests/064-deprecated-inode-cache/test.sh
new file mode 100755
index 000000000000..ca3bfa7182a2
--- /dev/null
+++ b/tests/fsck-tests/064-deprecated-inode-cache/test.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+#
+# Verify that check can report deprecated inode cache as an error
+
+source "$TEST_TOP/common" || exit
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail "deprecated inode cache not reported as an error" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.46.0


