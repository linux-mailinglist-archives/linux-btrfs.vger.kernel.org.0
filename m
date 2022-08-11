Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD9C58F997
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 10:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiHKIy5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiHKIy4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 04:54:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CC91D17
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 01:54:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y13so32281671ejp.13
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=w57PyM5ymkkfGSszFNozBaZLMWQ4EZrgt+Fi+IcoLN0=;
        b=NhFAvistVCrVrJcnFy3nsGPpSJexnVk7LBW0ytEA41N4qOVWDmdjNupTyHh6vnH3oU
         jFt3uggPTPxdqVXSeOekI3oyWlVgLb4nEewK8HWlxKm+U+m+GY1bG9S6VwTp18mXMMtM
         bT2ICsPe+m5/0geZVyFl28eDkMomTZ6LavrNn4XV6rhwOmwhiL/cWFsDne/KVViTH1SN
         Yzj6J9vQAzLfU9O9FC0UUiqb3mUYGtP/Yerekc6PmplVpZedSuHUK9IMowYHoYX9TtdG
         GRmDi/OfZQeJcegJdKy4PCYzaHzUOCETZppwnQTwdURSb/ZT9+p/U5aDO4qnlRKHLTq/
         nO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=w57PyM5ymkkfGSszFNozBaZLMWQ4EZrgt+Fi+IcoLN0=;
        b=kvIbyMwjH0gV7cfcErfsnHTUmPvzS8XjGN7kjucZ/4Ye0JmqMu+ok5Oe/k5v/K1MA4
         jDCfUcxJfST4t3DKu9jBHVa6Uf14MLfy3eTt2yxp11VByVuGflXb6lAwOQ2bbsngjGGW
         ulA6X8j+nC44TcmIpAtAV4gzwR3D71q+xyIAchU1TR/fovLCwZU9wvR+SEW525c5pFXm
         Zt62A8ReMKyar4fTH0otJku7wPR8nbGoilqFWLaY1GerClXUVpNdRVlIEDl8j8dydD9o
         kvzyu5Iyn1uQYyihTNP2ZY9BGh4eFmV+9X5geXiegeoEM6bWFf4ZbVwvvQ3IEymoUxUH
         9Pyw==
X-Gm-Message-State: ACgBeo1CpBneauJgWuPfuLRnJw0rjNJeB2xrp75xk7brqveP4xqB3LgV
        epiAazMK1aYTqzH6C78+jvS4ZBhLiLEYH+KFncM=
X-Google-Smtp-Source: AA6agR4ByWiaVSb8fEXFTl0KfUGbaAvHCQe95dQKvaPmPuhj3lx/CJ8A2PCd76G6JHfJBlzcr0x14UAmupdfG1z7VJU=
X-Received: by 2002:a17:907:28d6:b0:731:100c:8999 with SMTP id
 en22-20020a17090728d600b00731100c8999mr18493746ejc.210.1660208093779; Thu, 11
 Aug 2022 01:54:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:e8a:0:0:0:0 with HTTP; Thu, 11 Aug 2022 01:54:53
 -0700 (PDT)
Reply-To: biksusan825@gmail.com
From:   Susan bikram <deborahdonatus60@gmail.com>
Date:   Thu, 11 Aug 2022 08:54:53 +0000
Message-ID: <CADwFS4MT+wjFh8f2Bu6pw3gG041Dyvk58=31VTc0=MsOYefCxQ@mail.gmail.com>
Subject: Nice to meet you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [deborahdonatus60[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [biksusan825[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [deborahdonatus60[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear ,

  Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
