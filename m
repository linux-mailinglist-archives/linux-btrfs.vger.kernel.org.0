Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3894790B20
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Sep 2023 09:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjICHNl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Sep 2023 03:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjICHNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Sep 2023 03:13:40 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C51197
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Sep 2023 00:13:37 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-48d0e695fa1so298651e0c.1
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Sep 2023 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693725216; x=1694330016; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx3VWfKW3EtNyZed4FnlPCOsuD/vA9pv6x4aqpyK3AA=;
        b=HjCkpplco+ok+i85AgB7Z/mo/ehGV2yE8unX+pyMsX2vJ6tNmL3uCahuGHjg5kROLr
         Se/APQ715T6GLJTG59V1LN6Wgzt3uj0zUsUpyM2P9KJybt1cP7wjNY5PKAUTlFjsT1i8
         U0NITeaF06w0IxY1EBYzZN8jTHHZk5ooztoFvSVEwLN6tTNhllfpeC8SUdGkrj4CopR9
         Cd86JnspSYWD1dmDkJrVywklXKG6Z3wpCRGYQO/J05kI4Nb8TmZcm51GNz4pB4X72qZx
         O29Rg7GJSEsd9JHMyVymS5plF7g0HwoVDnz75k2XUHwkCSeGZOqpSLhdXq31IEuj4qWi
         3j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693725216; x=1694330016;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx3VWfKW3EtNyZed4FnlPCOsuD/vA9pv6x4aqpyK3AA=;
        b=gN9RwSGcW5ffn7EzYmEB/9OgukA7mkpG/Se5zVvoiIzQL7SdbpzgAFfB5q/7tZdVVT
         /w86vusJlpbZ9Hj1gVY6bjNZMqDBK8dM9LN2RRQA2JQOv5wW24ZhT0DhXLoOrSDr29Z3
         7OpFZmfedCv+bYWv5wHiHXtfvBXyhTxaP17XMeysc06fvmYq9krGf0L8jeluDYjf3WpW
         jsbkRaHVVQ6Vepb0CVqLybLvJ8zmmMT0XEJEHMWdowf/V3dMsRs1c9weWYeS9osFnu13
         eFOclqQK/4l+XoswStyS8vDEhg0A5Ziif5wzhapyTJH6PSEQDEx/UnxSNlnbD377BKRK
         xrcw==
X-Gm-Message-State: AOJu0YyG4l0bCOiX86ik+1kYsjrq9eG+w3JYIjD9DvLZRuUhjV6vcHR8
        d9dOFzhHPG71SqhoXEWhX1MndNjnEJ16Nee0tmY=
X-Google-Smtp-Source: AGHT+IGTABRGC9M38CP4hA4OVeQlL+sIN6Yv0GqayWLZaUe7h+ALmbf9Dyzwosv75yheeyjFT6ORIPvj3BkQjQi+Bs4=
X-Received: by 2002:a1f:eb04:0:b0:48d:11d1:9feb with SMTP id
 j4-20020a1feb04000000b0048d11d19febmr4872561vkh.8.1693725216412; Sun, 03 Sep
 2023 00:13:36 -0700 (PDT)
MIME-Version: 1.0
Sender: tomjamesonline2@gmail.com
Received: by 2002:a05:6124:585:b0:381:23d:ea16 with HTTP; Sun, 3 Sep 2023
 00:13:35 -0700 (PDT)
From:   Juliette Morgan <juliettemorgan21@gmail.com>
Date:   Sun, 3 Sep 2023 09:13:35 +0200
X-Google-Sender-Auth: 2EE2r3JL_onkWG8UgMRpJxakb_c
Message-ID: <CAKc6Prai2cmgf5QCsEmiA-rsrHqam402NJSWXW2JZsODsiTxAw@mail.gmail.com>
Subject: READ AND REPLY URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        MONEY_NOHTML,RCVD_IN_DNSWL_BLOCKED,RISK_FREE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:a2f listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [juliettemorgan21[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tomjamesonline2[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_NOHTML Lots of money in plain text
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 RISK_FREE No risk!
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Dear God,s Select Good Day,

I apologized, If this mail find's you disturbing, It might not be the
best way to approach you as we have not met before, but due to the
urgency of my present situation i decided  to communicate this way, I
came across your e-mail contact through a private search, so please
pardon my manna, I am writing this mail to you with heavy tears In my
eyes and great sorrow in my heart, My Name is Mrs.Juliette Morgan, and
I am contacting you from my country Norway, I want to tell you this
because I don't have any other option than to tell you as I was
touched to open up to you,

I married to Mr.sami Morgan. Who worked with Norway embassy in Burkina
Faso for nine years before he died in the year 2020.We were married
for eleven years without a child He died after a brief illness that
lasted for only five days. Since his death I decided not to remarry,
When my late husband was alive he deposited the sum of $12.645 Million
(Twelve million, six hundred and Forty five thousand Dollars) in a
bank in Ouagadougou the capital city of Burkina Faso in west Africa
Presently this money is still in bank, This is
not a stolen money and there are no dangers involved. It is 100% risk
free with full legal proof. He made this money available for
exportation of Gold from Burkina Faso mining.

Recently, My Doctor told me that I would not last for the period of
seven months due to cancer problem. The one that disturbs me most is
my stroke sickness.Having known my condition I decided to hand you
over this money to take care of the less-privileged people, you will
utilize this money the way I am going to instruct herein.

I want you to take 40 Percent of the total money for your personal use
While 60% of the money will go to charity, people in the street and
helping the orphanage. I grew up as an Orphan and I don't have any
body as my family member, just to endeavour that the house of God is
maintained. Am doing this so that God will forgive my sins and accept
my soul because these sicknesses have suffered me so much.

As soon as I receive your reply I shall give you the contact of the
bank in Burkina Faso and I will also instruct the Bank Manager to
issue you an authority letter that will prove you the present
beneficiary of the money in the bank that is if you assure me that you
will act accordingly as I Stated herein.

Always reply to my alternative for security purposes

Hoping to receive your reply:
From Mrs.Juliette Morgan,
