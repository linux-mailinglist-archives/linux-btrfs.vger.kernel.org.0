Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463D34AA78E
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 09:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiBEIP0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 03:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiBEIP0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 03:15:26 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8368CC061346
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Feb 2022 00:15:25 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso1264698pjt.4
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Feb 2022 00:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=z+e/nd+MXvvQtR241hngZOgNYHtWM5LpYTkQwNamgbQ=;
        b=JSiRF0i7IMs+HepyVpQM7ocTjorA1LyslK5W1ea9UeRdRTEWnISkisWKb5aXPcHDD/
         8yyUHgDUnIoXNiJ1g2dUNuS5lj3hi0iWbS8rkedqNaMtJoGXVPmqgBLKJSHMZOlb4/fM
         oUHY+lWtxvY0fy6m570gry9QhHNDsrfeT2wimz7y5XalG2ZKxMLoFscCuxaqwsO2ZJfy
         yFE1JD6An66iaw4wSIrszH2FJRK8/OGapcqiee0d7R5DQtp1ue86xXgocjn+aWievJmS
         /T4x0Mksc6XauCiji13DluWTVi8WZq6BX7sQA2hnBg9Z1djHMzCJHqYw8GejHiep49P3
         UjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=z+e/nd+MXvvQtR241hngZOgNYHtWM5LpYTkQwNamgbQ=;
        b=aFqltGN/uibhJ3MqHH6Ghb+w077tmLJ1rHY28pIsb2EUUyteiCwnvlyfvFb/NARBZQ
         T1+pEmkXEcHbfFRjOfcipoCrnIwIPSG2rbCOO2IgfINTu56riWCm8m/M9ZpQ3fqHxfvo
         6haUEEyBmuehFOIJDObMzgDPdUEkKtky2Dg2AvBG2ST4rYHzCOf1k8oVeCqRZPJiKZF7
         NrBzzIhqN3qQgdnezOIb5YFGNIROkrBgGtYy+0M8rMjoEfax7IoXUc56HefKnBPQ3oDZ
         2ETB9nGmTs/qpDtSnbNVyGlK8RSBYepS5mt+DSLK5wlkYZKOiBZsZVdTmlDQ3LX06s+X
         9VWg==
X-Gm-Message-State: AOAM5318OW7hAciGQe3otH3RbtIYZLbzKWWoIrNeMuobDBSjMeBjs2Z7
        nXygRxxeU9mmHi2pYxASV/z4VNgVJCMTQwlr4Iw=
X-Google-Smtp-Source: ABdhPJxQB+B2q+Sp8uRamsz4K++oRcQ013vngZqUT1ySPOAk10SSZZLritjoaXfdAd+IOlD+A7hHSsPFRUZbTzywINE=
X-Received: by 2002:a17:90b:1c8c:: with SMTP id oo12mr3139716pjb.216.1644048925015;
 Sat, 05 Feb 2022 00:15:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:3d95:b0:70:6a76:eb46 with HTTP; Sat, 5 Feb 2022
 00:15:24 -0800 (PST)
Reply-To: info@ubaatmoffice.com
From:   richard mike <rmike3876@gmail.com>
Date:   Sat, 5 Feb 2022 16:15:24 +0800
Message-ID: <CAMODwNyYe2sVsBT0Vad6ZwjQbCBwEECSdLLfr-48CR5K8EanFg@mail.gmail.com>
Subject: =?UTF-8?B?zrPOtc65zrEgz4POsc+C?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

zrPOtc65zrEgz4POsc+CDQrOlc+AzrnOus6/zrnOvc+Jzr3Ov8+NzrzOtSDOvM6xzrbOryDPg86x
z4Igz4PPh861z4TOuc66zqwgzrzOtSDPhM6xIM66zrXPhs6szrvOsc65zqwgz4POsc+CIM6zzrnO
sSDOsc+Azr/Ots63zrzOr8+Jz4POtyDPjc+Izr/Phc+CDQooMS41MDAuMDAwLDAwIFVTRCkgzpXO
us6xz4TOv868zrzPjc+BzrnOvyDOoM61zr3PhM6xzrrPjM+DzrnOsSDOp865zrvOuc6szrTOtc+C
IM60zr/Ou86sz4HOuc6xIM6XzqDOkSwgz4TOsQ0Kzr/PgM6/zq/OsSDOus6xz4TOsc+Ezq3OuM63
zrrOsc69IM+Dz4TOvyDOs8+BzrHPhs61zq/OvyDOvM6xz4IgzrHPgM+MIM+EzrfOvSBFY293YXMs
IM61zr3Pg8+JzrzOsc+Ez4nOvM6tzr3OtyDPg8+Ezr8NCs6UzrnOtc64zr3Orc+CIM6dzr/OvM65
z4POvM6xz4TOuc66z4wgzqTOsc68zrXOr86/ICjOlM6dzqQpLiDPhM6xIM6yz4HOsc6yzrXOr86x
IM6xz4DOv862zrfOvM6vz4nPg863z4IsIM6pz4IgzrXOug0Kz4TOv8+Nz4TOv8+FLCDOtc6vzrzO
sc+Dz4TOtSDPg8+EzrfOvSDOtc+Fz4fOrM+BzrnPg8+EzrcgzrjOrc+Dzrcgzr3OsSDPg86xz4Ig
zrXOvc63zrzOtc+Bz47Pg86/z4XOvM61IM+Mz4TOuSDOrc+Hzr/Phc69DQrOs86vzr3Otc65IM+B
z4XOuM68zq/Pg861zrnPgiDOs865zrEgz4TOt869IM+Az4HOsc6zzrzOsc+Ezr/PgM6/zq/Ot8+D
zrcgz4TOt8+CIM+AzrvOt8+Bz4nOvM6uz4Igz4POsc+CIM+Ezr8gz4PPhc69z4TOv868z4zPhM61
z4HOvw0KzrTPhc69zrHPhM+MIM66zrHOuSDPg8+EzrfOvSDPgM+Bzr/Pg8+AzqzOuM61zrnOrCDO
vM6xz4IgzrPOuc6xIM60zrnOsc+GzqzOvc61zrnOsS4NCs6Vz4DOuc66zr/Ouc69z4nOvc6uz4PP
hM61IM68zrUgz4TOv869IM69zq3OvyDOtM65zrXPhc64z43Ovc6/zr3PhM6xIM+Dz43OvM6yzr/P
hc67zr8gz4TOt8+CIFVCQSDOui4gS2VubmVkeSBVem9rYQ0KzrPOuc6xIM69zrEgzrTOuc61zrrO
tM65zrrOrs+DzrXPhM61IM+Ezr8gzrrOtc+GzqzOu86xzrnPjCDPg86xz4IgzrzOtSDPhM65z4Ig
zrHOus+MzrvOv8+FzrjOtc+CIM+AzrvOt8+Bzr/Phs6/z4HOr861z4IuDQoNCiDOqc+Dz4TPjM+D
zr8sIM6zzrnOsSDOvc6xIM6xz4DOv8+Gz43Os861z4TOtSDPg8+GzqzOu868zrHPhM6xIM+AzrvO
t8+Bz4nOvM6uz4IsIM+Dz4XOvc65z4PPhM6/z43OvM61IM69zrEgz4XPgM6/zrLOrM67zrXPhM61
DQrPhM65z4IgzrHPgM6xz4HOsc6vz4TOt8+EzrXPgiDPgM67zrfPgc6/z4bOv8+Bzq/Otc+CIM+M
z4DPic+CIM+Fz4DOv860zrXOuc66zr3Pjc61z4TOsc65IM+AzrHPgc6xzrrOrM+Ez4kuDQoNCs6k
zr8gzr/Ovc6/zrzOsc+EzrXPgM+Ozr3Phc68zr8gz4POv8+FOiBfX19fX19fX19fX19fX18/DQrO
lyDPh8+Oz4HOsSDPg86/z4U6IF9fX19fX19fX19fXz8NCs6XIM60zrnOtc+NzrjPhc69z4POtyDP
g86/z4U6IF9fX19fX19fX19fX19fX18/DQrOlc+AzqzOs86zzrXOu868zrE6IF9fX19fX19fX19f
X187DQrOpM63zrvOtc+Gz4nOvc65zrrPjCDOvc6/z43OvM61z4HOvzogX19fX19fX19fX19fXz8N
Cs6kzr8gz4bPjc67zr8gz4POsc+COiBfX19fX19fX19fX19fOw0KDQrOo8+EzrXOr867z4TOtSDP
hM6xIM+Dz4TOv865z4fOtc6vzrEgz4POsc+CIM+Dz4TOv869IM+DzrrOt869zr/OuM6tz4TOtyDO
ui4gS2VubmVkeSBVem9rYQ0KzpTOuc61z43OuM+Fzr3Pg863IM63zrvOtc66z4TPgc6/zr3Ouc66
zr/PjSDPhM6xz4fPhc60z4HOv868zrXOr86/z4UgzrXPgM65zrrOv865zr3Pic69zq/Osc+COiAo
aW5mb0B1YmFhdG1vZmZpY2UuY29tKQ0KDQrOtc+AzrnOus6/zrnOvc+Jzr3Ors+Dz4TOtSDOvM61
IM+Ezr/OvSDOui4gS2VubmVkeSBVem9rYSDPhM6/IM+Dz4XOvc+Ezr/OvM+Mz4TOtc+Bzr8gzrTP
hc69zrHPhM+MIM6zzrnOsSDOvc6xDQrOsc+Azr/Phs+NzrPOtc+EzrUgz4DOtc+BzrnPhM+Ezq3P
giDOus6xzrjPhc+Dz4TOtc+Bzq7Pg861zrnPgi4NCg0Kz4DOuc+Dz4TOrCDPg86/z4UNCs6UzrnO
sc+HzrXOr8+BzrnPg863DQo=
