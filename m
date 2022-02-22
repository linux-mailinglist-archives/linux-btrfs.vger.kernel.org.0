Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A844BF4DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 10:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiBVJhV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 04:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBVJhU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 04:37:20 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158F5A41A9
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 01:36:56 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r7so13930796iot.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 01:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=I5lihjInKNMhRTuhCC3K0XfJp1xWTFPAVc+s9TYEluw=;
        b=CMkIb/1xRDhCZ3b4bmBfX6tIzApFBbsaUWr2mE4rJtCHaLydXMXlMs3SgYYDc1EgW4
         NbXlP0QAnB6bPOgNo6MVh29eiQ8Z6JzS/7do0xrM4RMzkfJ/FWQ3ArWNf7rRUyoAlvQB
         Ex/tHKu9w3acLeafwSkTGjmAsY87h/MQySkW6wOIZjmPj0fjOt1Le5671kxJdn/KfZEP
         SXSQXRTN3HHs1IpohxqQtmiRNV4u7gsGQ0a4Gj5WV5DaxPfo8YaRnogrDtqSpChFIUek
         iFhbVmzCxuXHvw4ETPb6ha72kYyrKzRukN+CsFH/mCC/6n18BZRVzWxlom7TBGQfwFNy
         h+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=I5lihjInKNMhRTuhCC3K0XfJp1xWTFPAVc+s9TYEluw=;
        b=eZ9D1onwRaSviNFF+cyCQ1iG1DcwhARKWHfjk948dCshon6aM3/HN46LbyR8wz10x1
         XooK8qU6e8njRjKXiUlgRYuD5FtD9Vl5gqj3QdeJ94wsV+QvYoX3x4Z28dO/tU4xlJBq
         C/Ub2l3EdsbUeCPSj/R2pXuouL9VWAMkSmMdbUF4Ql2mD8MZtbaPLgY7HtP5qr0+SXbI
         /NXSYXwh2V426kDhI1XkxHaZzaWyyrpoWWnhCsZxp3wAGuabimpEUaGDkmxwZyNQjE1K
         qApohlcy5FHIkYNnpze4lbBqn2061JHXyWBIOXj+AnZlCyxxroBWxet47kI3u4PQoQeW
         tRag==
X-Gm-Message-State: AOAM532/ZGOdO2A/cGENx7X5SaWPEbv0SEZkr1Y5MkzNTd9vRUiiz5bz
        GHrjY1oUTI9JF8L5mLIcEYqtN5CapEuu10bH3Xw=
X-Google-Smtp-Source: ABdhPJyuL9teDp7Cgeqe8o82246Be5LPLD+QDR45bRlaalqfH/I2hoLUBaPWX6xjCCLDE2fqyNE3COFJK0DSelroc6I=
X-Received: by 2002:a6b:b503:0:b0:641:808b:4046 with SMTP id
 e3-20020a6bb503000000b00641808b4046mr374908iof.100.1645522615585; Tue, 22 Feb
 2022 01:36:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a92:c84d:0:0:0:0:0 with HTTP; Tue, 22 Feb 2022 01:36:55
 -0800 (PST)
Reply-To: claytousey22@gmail.com
From:   Clay Donation <umaribrahim3250@gmail.com>
Date:   Tue, 22 Feb 2022 10:36:55 +0100
Message-ID: <CACKuxc9wuqmb-oCBsJ_LUEZpkDqsjumiNacLDOVws6e532_gdg@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0267]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2b listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [umaribrahim3250[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [claytousey22[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [umaribrahim3250[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Am Clay Tousey, You have been nominated to receive $5,000,000.00 sent
in your name.reply for more details
