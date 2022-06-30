Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31DC561F07
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 17:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiF3PRh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 11:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiF3PRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 11:17:34 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9EE2D1D2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 08:17:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id l24so19397650ion.13
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=eMKZayKvkcJE1NsJECMuqkGen+W+VhOA8980ZdLwenY=;
        b=eI8XXhbOK4I2UvL1gOLCTuY8bebtuBm8Y+m3dsfPMHB+YnGdC+kVbHCU/noYwp54hn
         cdM62BgYCyyBkURHSRMKJF0kJCp5FPeNvX5Mvvv5Rkz4BCBxy9HQb++LaIbocPqjmYRR
         alQfZIKaDO/aYs0pJ0yOgiWDRMN6PboSmmStAcKZ/k7N27bYKg2c5uPUJZIUDJzEe4yf
         v9jjdPO5jEjs61QQ/4jcSoA0Geu6uYIeL+Xaeez7FnHW3KhPIuzRh94s+L4eAAM84RZ7
         OZ167xPlR/Hd2ijZCt4EIYUWBnT9/LfKNrTzx9BdABhAM2pxkK3tuvHHVmcdtfbN9m9Y
         3qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=eMKZayKvkcJE1NsJECMuqkGen+W+VhOA8980ZdLwenY=;
        b=36n+1Rp7botpOY5g3rko+ploAz9U87/7YUGiPIeazqbaXKibms7iK9fbEkDjuGnlmu
         /w/scriumzDKQiGzvvLaI42JMcrCmCDK+/EmI9nNEv+87lHIqOvkNxuK+5r914wlc1p5
         2PdOFZMvGX0RDtIQxW+9nbkzCc7fcAG5ngizgLwyD8gEPUIXniCN27jABKU55TweMv93
         kh2xJwT6xkGV86qQZqId947ZKexh2NMqjUkuQvBy12ed4QzuIMcWMCB+TXKpn4l6eLab
         WuEoQQRCGp+7N9rtHOcTdzmNYiKpIkj6HHQZb9qjIcIj1WvZdz4ec4lI/TrD0/38CN/9
         NXNA==
X-Gm-Message-State: AJIora8NwaerOBe3PamNFCFVVhqh8gXct104OqjQuhdoC0Xa4jxbzkkD
        RJh2jLAfd4yqN9qegIf00c8WC+qCede/TvJw7R8=
X-Google-Smtp-Source: AGRyM1vgrPXWpQ+Tga8v8Ewd9CNRCRgRrvACqhaVII5vwTQ6KBlsyKgBStn9POLx9Va64rHfuWATLHumqhb9U8Mmg6M=
X-Received: by 2002:a6b:c941:0:b0:672:734f:d05f with SMTP id
 z62-20020a6bc941000000b00672734fd05fmr4606285iof.87.1656602253100; Thu, 30
 Jun 2022 08:17:33 -0700 (PDT)
MIME-Version: 1.0
Sender: adamuyunusamalqwi@gmail.com
Received: by 2002:a05:6638:32a0:0:0:0:0 with HTTP; Thu, 30 Jun 2022 08:17:32
 -0700 (PDT)
From:   "mydesk.ceoinfo@barclaysbank.co.uk" <nigelhiggins.md5@gmail.com>
Date:   Thu, 30 Jun 2022 16:17:32 +0100
X-Google-Sender-Auth: UShB53Pcqv2kPFYw466H2RRIC5M
Message-ID: <CALKLisAj1L_KMt2tjvwvgQjJe1OeYuqB8nRbcWDq9iaAZEBxXg@mail.gmail.com>
Subject: RE PAYMENT NOTIFICATION UPDATE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_2_EMAILS_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Congratulation!

This email is a good news regarding your unpaid inheritance with the
hope that you are alive. Detailed information awaits you when you
answer if you are alive.

Yours sincerely,

Nigel Higgins, (Group Chairman),
Barclays Bank Plc,
Registered number: 1026167,
1 Churchill Place, London, ENG E14 5HP,
SWIFT Code: BARCGB21,
Direct Telephone: +44 770 000 8965,
WhatsApp, SMS Number: + 44 787 229 9022
www.barclays.co.uk
