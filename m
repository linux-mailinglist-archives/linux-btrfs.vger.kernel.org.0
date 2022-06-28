Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C170855DC84
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbiF1MdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 08:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbiF1MdL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 08:33:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085F825D7
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 05:33:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e40so17376241eda.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OoSOKaetkfo5h155JtfRaN6t4WIhEs3Lb4EdSU7z4pc=;
        b=HpWmoOejnTLXoVWDxOm5NrGK85rFWDruuOdz/2ckXlToEXn5LmQoQDp0fLakvZ71AB
         Zlnk52vvkro6RE8fdN2hsD+y7PWnDYPY1I5jLLI4IqiN2ID/+5eCXUxIS0Zg3yT1wYe9
         zXajAHoELXEJ9YzRA9kR4femwV3paamlZV/AlzLEjXOSQk8xVgt2ancKW9ahVM5VmVgX
         ZbVgxSY0ZhXDum2islgcj8WRCiP008bBMZNqXDI1qgnFHgyCZiX0Bxqta0+B5jAFFffK
         OJl3xS2AdUNu27y4WNbxKz311oC5jOYIoo233McL1XTSifp9sS+d5OJenAaz+vf/e0Ay
         hZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OoSOKaetkfo5h155JtfRaN6t4WIhEs3Lb4EdSU7z4pc=;
        b=sqBcfanwv/kGWctwB8AfpmniihnFolJsYTGT51Jy09noyT7rjaBI3P2hq0izrCg0s4
         qXr2Xfaqv4WBr759BV+grMw4CAtxoqHc9jdmLPca1vZNbvOa5RIM1q1CUkqWW4vWkK83
         UCH4MalRCpYqXHIGAziO2ovgFB6v3+h+SKCsbNDisWuOroxaRtqqDa740YfYtvEsZKdn
         N1dZKxZ2UYRGEXub1RD/x+mqISxSUVzeh8p+7s2DTk0T5JmsZ/4BrVoheBRIbad2f1pM
         djyFzmDvu3brTJZIuCPVro2FEn5K1pnNBE1G4B7A5YKga1damyekgRREUuh6Azf//quR
         Eg8g==
X-Gm-Message-State: AJIora+51W0AvzhEoMA50ZSLwYnt1Bj/oij3b0vNVY+s7lrQg/bcED/Z
        HIybgvuhmW91Ytf6eYd8ye30ffQen6LD3SvYehA=
X-Google-Smtp-Source: AGRyM1uYzsDaNb4gf87qrmdWBXO1vuqVJAWelWE4jBdeeEtjFLKPiSODHtYOLyuRV2amj7XaNlAZpzK4j5s9LcpHlY4=
X-Received: by 2002:a05:6402:34d2:b0:435:9d8f:3328 with SMTP id
 w18-20020a05640234d200b004359d8f3328mr22532440edc.88.1656419588627; Tue, 28
 Jun 2022 05:33:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6408:16cd:b0:198:8336:cbb0 with HTTP; Tue, 28 Jun 2022
 05:33:08 -0700 (PDT)
Reply-To: howardnewell406@gmail.com
From:   "Howard F. Nwell" <intercooltg@gmail.com>
Date:   Tue, 28 Jun 2022 14:33:08 +0200
Message-ID: <CAE2sA_Wud4qFCoLNF-E7YFz7TZHcr+42YsO0SUvCapa+FWKttg@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hoi,
Ik heb u eerder een e-mail gestuurd, maar heb nog geen antwoord van u ontvangen.
Bedankt,
Howard Newell
