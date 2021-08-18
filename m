Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04CF3F0D6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhHRVe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhHRVeU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:20 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32DBC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:44 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t68so4761625qkf.8
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DswvzFcPEbl9P5cSIRr8UzGdk0zmvN47Ia4PEe/avis=;
        b=eRmvZLoR/y/4AfCU2FodssdZYMbeeq/Xtq/MjluJ351oP4/EGSc9Ftr4+k61ULN++o
         Refq+hgmFGzlnzC3I2N2bO3LLiV4066KqS//w7UUkgAfwn2AahsdTRxDvdGgzz8F56qV
         bSSTXcQRN+wbMJ1i+swZJn6sXlBOhzZ7ELpl0CzUQjVT7wTCaM8fTRNeEMbmiIvFB11X
         lsMiKEoaNe429lijbC6iZS3JUGnAZaZulsWTFNYiR8gpGxD9vIIzniYGu+9HNrfZNH0/
         c/btlsE2IGWUkG+f68yF3frJuyfOjuJoKCsxlhnufwIwfPwMSZZHrL9d4fMYiZHcq3A1
         qFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DswvzFcPEbl9P5cSIRr8UzGdk0zmvN47Ia4PEe/avis=;
        b=YrBbLO+mWe9XSIl5SVuJpb+xdH0cMWrK+SJxIOSQp00R3Log8iFFweW56cmqPFXtSt
         AN/wTC+t267P452+ju4wgcQbL8beTWD20Whp7Pf3OQLOwVCXFZvjwsj9N6le2NlsVwVw
         MyRBlWn2jlRg9nQfkf3o0EVRpblbyWwcDHzqGIftGkfwfA2ylBWK/7xDh7KnPuepY6Bq
         Q8ogXH2ZIvpumJNvW8arVoNeIuzf1xT5Hp7RBWWWfyQMtZn+WYpE33qnjj7ml7bH4esZ
         /MmswZX3AwFBTcvAm7aU3jgCOdZGzNvenxyCZRftwPQQbYH/mxcepbwwXSNCv1J23BdW
         rMFw==
X-Gm-Message-State: AOAM5319YJpsJBtTjOv+S6phRZgkAQoPPXFYTXNre0b9hjGZ/vTzWKli
        KtDFe6SvpiiaZG2l8uUsCWSE7zIkHN2pEw==
X-Google-Smtp-Source: ABdhPJxCyfSG0PWoW3VoAQj63n0XfJCj/7ICWSzOkFDRgzTJ8Ioza7UnoupJJAkNQ0nG0kR0EbIPdA==
X-Received: by 2002:a05:620a:2298:: with SMTP id o24mr352650qkh.235.1629322423889;
        Wed, 18 Aug 2021 14:33:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h140sm566655qke.112.2021.08.18.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/12] btrfs-progs: add a test image with a corrupt block group item
Date:   Wed, 18 Aug 2021 17:33:23 -0400
Message-Id: <5f2e5e13597f2f96503657abdf4ff25fcf74a8c2.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This image has a broken used field of a block group item to validate
fsck does the correct thing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../.lowmem_repairable                           |   0
 .../050-invalid-block-group-used/default.img.xz  | Bin 0 -> 1036 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/050-invalid-block-group-used/.lowmem_repairable
 create mode 100644 tests/fsck-tests/050-invalid-block-group-used/default.img.xz

diff --git a/tests/fsck-tests/050-invalid-block-group-used/.lowmem_repairable b/tests/fsck-tests/050-invalid-block-group-used/.lowmem_repairable
new file mode 100644
index 00000000..e69de29b
diff --git a/tests/fsck-tests/050-invalid-block-group-used/default.img.xz b/tests/fsck-tests/050-invalid-block-group-used/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..6425ba16349395416fc1918ce4c386059d618409
GIT binary patch
literal 1036
zcmV+n1oQj-H+ooF000E$*0e?f03iVu0001VFXf}+6aNFrT>wRyj;C3^v%$$4d1rE0
zjjaF1$8Jv*pMMbE@{&83eAipquzP5y*Z^dMFaaah{5${uN^u50JUj3Gv&TKFetZNb
zeGi-h_Sc-xdQ?TDr}!X-75pO<Qv3dfP)udQ#2BMlhKV!<)h0wx#0gBFB3oujWhIL&
zL%Q_)XZGuT<s*G=df*h(28)|6jezRgn^fw3f_X9cr>3s7;Q#Cs@eB}(-tDiTrOkuL
zr-`Q{!4@d7$vYR${O40b$KD!sxV##0^*`8ePjSki5__Mw0>a{sam+nk%_Taf1QUIl
zCPC+p!>ol%J~2Y3anuU4qT<_;R2!C0z*;OS_X<C(1PY_piT;4cC;rb`fiOWnUh;Y5
z+VpHb7TtwJG9h(H?eIvX{dw_9_d^y!4q2*1)lacoD~cQb2zYFYf$yU6F73JuP-a_~
z^nRPN>lH|4cwp*YYCcEjpgm>gLEL94KJ)NIDw(fAxBE)HBeuH?SFG)P2n*qCcX@dj
zl6!cB_HK~tM6u@FF~?28<QXd$N2j((D}P0X*4u&8MljFY;=CO4qv}A|Yfk0*J1L<0
zvtlIvVt#RxD#E>(XL*Vme;}!4%~G!$l6uxm(%@F-`~K9;P=VVx6iDWsw2&F)MC!ne
z{yU2uSdn?OJQ<Lt*^Y0*dZ}@9Mbh>k99D$H$r|?eQ%u-&&dW^Q%ogbbG<!ht<u}AO
zPK!nm?T;rPEW*}JR&_-PG_1)0l`D=?gQ%=PFA7tIi*Hc#g_0U1=2f8&+0+M2vL0@Y
zRepZ8%3sj#@uRLS03@G+a$5t}CT2~i>`T74qDMIaXhLRLP+<sRw5KZtAG@&9m`Ls0
zS5b66v3%FLAinwOLU5f}@`Y!nIlBhSV}9k)|B|7ydoH$5f8x-VX7s|n=;9N;KXH?H
z@kBA19X?ijYFlm44FX3(6!04T9(Yd!8hL5JWd}`cJ{=UOnZVNi<^S&%@5!isxf&15
z3`Qf*v}A6h?C9<3y1jv7oiCsGu3lhGk{+-4VN_WAkphoN6}JCC>j+OmK|vlc6+Q+8
z>i9;tP|5yL$Hg>IZhAK@v(3YzO&IxH_W<yblu5-O+ic3l3LzTL=eJ!H;1FmLNMh9z
zP}b#vH2+}dMT<T6wQ}~GA0mWw5XZl*-GXoYp{R!3<B4{}7<uJK<0J_L%nX=dW8jjl
zJo6(aM0F6xZK|Og`Pbn0U-IJOVOIUa)MDdsCv%q+fGEK_y4SF$G)B_i)~Dk);s!z~
zd&otC2e}ecZOkpbFV;}uV=M0f0000E#S;ff2MZnm0p$mPs0aWTvKPg%#Ao{g00000
G1X)_aZ2)fo

literal 0
HcmV?d00001

-- 
2.26.3

