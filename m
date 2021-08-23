Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925953F513E
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhHWTYQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhHWTYP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:15 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B81C06175F
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f22so10754135qkm.5
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3FBUpnqTbYqnGXZTMtSDgp9MOQ/S8lJ9K99Z0c/fGZM=;
        b=lMnxy7qTYM6dFHI/JluiIrnuWtlliM9aAgEh2ri/nTmlpQD+Zy9GuPyhaTjqBf4b0D
         s9d2BoG4lcaaV94wWahTJoRQ2IMgnJmO8d+4YE1ceA9NWe+bhz4VTsUrJD6M7zTnsdWh
         EzvhnhigHKtSevf0ObHpSYGH2BvRaowogo/DY9AQVp8Kq2RPiNEAoH0QhYbBtfAc2Ymx
         issrsk2YfZJXi3xrr2I9ZYdaNQH57ILtGAfAt35mLBwNphUOntY8ui+0lkj8V2DuTZ7b
         BFqVnAHjBH4ZseenfEJO6hALG1/lXkIrUFvv5ZPqNNhd33xxS6+V7KFr5j7bwdztq4Wf
         bUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FBUpnqTbYqnGXZTMtSDgp9MOQ/S8lJ9K99Z0c/fGZM=;
        b=KKHodGkDKq4B71rHOYQM9+HDmfflVVZq0vIMCM+zrbf/vVW32NdF4v5nyuoHrfJvMT
         XINhYWhXjN2zEEbOh+zjpsfS5oaYi7kiWpFjC8kk3XtJ19tzDJPSC35VCX6b7OHAfq4l
         uh/GqT6mS4US27ReJKjk2P1DfjpnTiKZ8gvN2DyVeTPRyP4itfeUdIvUc6YDFpSW6eaZ
         rWjYXo/4UvUyMyv8V7SSM2wb65R6e8GqjFhInk53b/84+oD55z+UIVuveN7scyu06aqu
         fhEb7IgoRF7DZRxDaI91NvgOoSrIKu5XnkZ8nmcDb1fCeFbbKiOjrwavhVvq89AicFK7
         zoxA==
X-Gm-Message-State: AOAM5320P1J01ic5P/RDL4dlH8PDFsMh+MTNYYXCqkAE66ttqqLnyB+1
        4SpgI/E1zfHzy18minyKTWve8ekW89rqXA==
X-Google-Smtp-Source: ABdhPJz/INQz3ZxxLDKHrqNBLNnOaUaCn3vi3lEl5isIPAnQnaEvYh7VArP16JC4+NbxRLHDx5Pprw==
X-Received: by 2002:a37:a481:: with SMTP id n123mr21901074qke.111.1629746611452;
        Mon, 23 Aug 2021 12:23:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t188sm6375161qkf.22.2021.08.23.12.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 9/9] btrfs-progs: tests: add a test image with an invalid super bytes_used
Date:   Mon, 23 Aug 2021 15:23:13 -0400
Message-Id: <6af4fea906d1ecba09d90168bcfb88d3450a4007.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629746415.git.josef@toxicpanda.com>
References: <cover.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is used to validate the detection and correction code in both fsck
modes for an invalid bytes_used value in the super block.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../.lowmem_repairable                           |   0
 .../051-invalid-super-bytes-used/default.img.xz  | Bin 0 -> 1060 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/051-invalid-super-bytes-used/.lowmem_repairable
 create mode 100644 tests/fsck-tests/051-invalid-super-bytes-used/default.img.xz

diff --git a/tests/fsck-tests/051-invalid-super-bytes-used/.lowmem_repairable b/tests/fsck-tests/051-invalid-super-bytes-used/.lowmem_repairable
new file mode 100644
index 00000000..e69de29b
diff --git a/tests/fsck-tests/051-invalid-super-bytes-used/default.img.xz b/tests/fsck-tests/051-invalid-super-bytes-used/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..20d6af898690038ba5e3f7f3852f699413a7f15a
GIT binary patch
literal 1060
zcmV+<1l#-lH+ooF000E$*0e?f03iVu0001VFXf}+6aNF`T>wRyj;C3^v%$$4d1ocf
zjjaF1$8Jv*pMMm%#9U8wBSY$t`hql!7fWN#!<KoG7QbgI5Zz59AG36Vz1Z(#I0~Ln
z3JKK~H5jCU<u;c6IpGR%0p(Y1WzO5tieFMrVv97@7Gm*yDDf8GPy!w=xShqKM$Hbm
zNcld}wm#`Gky6*aiFfO+#g4Pry^cWVoFmH0VBeS~uQB0-tE>9)m~LUu{3h{cCV}n!
zW)j69{DZ;^4fwk&(@SrTPYl1&-d)dlKfc5eTWtvaaT3+KYdkYPq^__%7Cr|^=lv8x
z%X#@fQz>K*kIy&~JE`|+LnwNXr>^@~gg`$X!^enj{MM+Qk;qkdaYSe0zikAnG$AyN
z%hIp4{EhUpHVZf~sgUl}ybGx$gBffDVBF7(%IweseM7z#2OYAV_+^+V+j+fA%W}fc
ztW$!wvbbD7mmZTXE=T>9l4%pam5o<OA~-y2ZDRM-QL~v6TDXKleUF?ALnGlA7~&lR
z0q!@;zV*Y$Qh)gnX(oJR*Iu0}O>Wqfy31;MWh?)Wit!p!yl!SKcNBMb`cc>fa<5G6
zCPLe%*Vw+j@@8j4Sn<j~apvG>hM2ja(Ycw(;E=od)VY^PtFDz(Y?dy_HfQ}3Y20gS
z-t+TT?)DNjw`uj9E#Xdmutgz=9)f=XJ){7(wKS`QI)KkMJGX^;Mw}5CVh3&e-|Nz8
z#xJ^>@ol)mT8Mg(u=fuV%zGVUY0JGnTk<f>2tUD57AmS(<o(nfm6zE)U|?D+{k~s}
z5`lUF<7(8yv^0iUH*Ps&US#EKgBpJ#)F~Np^2gMoB5@yIdz(nik(sj?*J7sWVnw1s
zorCvu>Cx%M<Y6H_Q~HoHzM208Z&CJ<3W!YP>D0RE-&Wlc){tTY21u}MNMj3C?bZOg
zYNo{!+@KC%>W3*ihg`;{_lWQvsRXSfgLOq#)6xKI6_u~N5hsk{o<;;yEi>!k>sTgc
z$BdTv^NvrZ$?Z8&jqFAaE4bR>22AD#3*mR8U$!asT12H?EQuLPCrIcH7el(xev3hL
zQAZ|(`U@M8)fHnVK^&S4EMN{O5{g9PF}@wqoi=P39rIae4i8Y~TSurLWEZ6Sxx~s~
zXWtlT7;2?3<S;PdEkVsK4-X>Z=0eg@s@X`Pb0)`FgKF=kq5e?)|3dK)AYPa%)=75r
zJ1rQgvK#p3?1^k+W2E1T-3mMF>o8h_=GipTN`KdfpZ&&w+3F%(bk;sr{ITgm@F<x-
z-=1Yn$&27By)uiajG+wuCz_6dz;K{fS0x7)SmmNq{N)3a2BtnE463(n5vKrsu3*jw
e*LMW~0e}dAs0aWryM7<B#Ao{g000001X)^oc?S^y

literal 0
HcmV?d00001

-- 
2.26.3

