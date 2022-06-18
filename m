Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B03550798
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 01:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiFRX41 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 19:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFRX40 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 19:56:26 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865FEBC17
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 16:56:25 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x38so13095177ybd.9
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DktNzGr4hLAHLea/Akk85nuaRW7tmhBUHk0N3bJRtQQ=;
        b=iq9x9lClD1Lpd4sd0HrV1AWSlucBGYJGKMC8xIQ13Y1rrHiYGG84jvVuBGj8lCZLVY
         A/GB+oBt85XHJrr3AvFNkEhV9aitU6UL6Lvm4JPuhzTbO2NzBWiYZmpLESx0iqjp0znJ
         sHO/IYUv4+etaAmgLhszP8n5J8UuI2k7Kk8xZXDys0fwRsqC763hirGkdDIX1tvEVBS1
         ahdgXxVOFOyoeNquZ8JJUCx/NGtit9+Ua33+67pcDq0BQOn7XpDBLUTGa3VKa+ld2NS1
         TT66dvoYdbV1UbHVEMwW27M6ABx1S9WtxgeKHv92QopfRXzklow0qmcKl/ykE8VWErzS
         W6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=DktNzGr4hLAHLea/Akk85nuaRW7tmhBUHk0N3bJRtQQ=;
        b=TWEmV1418lNjfe3RRfp9gKaJE+Qlymu2+merq1WONcJ3hfvi3SlXWWkkeLxcTCkAfC
         THvDQEV2BorQ8rsMIZXPTn91lXHadsOfuiPes8xunUz1eHJQuyFEq5xxDilP9FdHk2eq
         LbPINTHYexIkdAS7l+5xkSKGYZ8es+5U3Rm+UgO3+hV/iDQRi6RbU4qXm1h+oeKAtNOc
         D4z5JtpJVlfbCn9YVfAl/aoggbuybQjpy2MZjgVJ7VnaszMHG49ysQrvCst1CD+VPOYo
         zk7UZ0mxS0nOD0/+rhsdpM9Bf5cSyFhTQ7n78WrT1/Ha77/mJiLPnnXIW/B0HckJYObI
         UQvg==
X-Gm-Message-State: AJIora8CxEyTBhSuj1lZu5xv6WUAWYr7NRFyFlozKZGGepYGfZDoY5WW
        gNG/w8Azlo61t9pPeBZ/y4tQGtnRAUG0cB6+aQEyda93Qyk=
X-Google-Smtp-Source: AGRyM1uuqVh1fVF51G7RSJ1/MKSqCiBszsnSi6r+pTP1TxrFFBs5y1uVVXIeIDU7BsAsCNH0vwyJU8CkcXEsS1jAVrk=
X-Received: by 2002:a81:415:0:b0:317:7938:e2b1 with SMTP id
 21-20020a810415000000b003177938e2b1mr15037304ywe.444.1655596229013; Sat, 18
 Jun 2022 16:50:29 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mcb_213@aol.com
Sender: robertlarrs@gmail.com
Received: by 2002:a05:7000:3f0b:0:0:0:0 with HTTP; Sat, 18 Jun 2022 16:50:28
 -0700 (PDT)
From:   Roman <rm2568590@gmail.com>
Date:   Sun, 19 Jun 2022 01:50:28 +0200
X-Google-Sender-Auth: bjA1_J2kIL_TiQ6yEtggHmx2IaM
Message-ID: <CAPvPBJF2T_6F4CiEDVi6FY6Q+oWU7FVu8534y8UjmWWK3w4r=Q@mail.gmail.com>
Subject: I Need Your Assistance
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FRAUD_8,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b35 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7754]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mcb_213[at]aol.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [robertlarrs[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.3 RISK_FREE No risk!
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 My Good Friend,

 Before I introduce myself, I wish to inform you that this mail is not
a hoax mail and I urge you to treat it seriously. This mail must come
to you as a big surprise, but I believe it is only a day that people
meet and become great friends and business partners. Please I want you
to read this mail very carefully and I must apologize for barging this
message into your mail box without any formal introduction due to the
urgency and confidentiality of this business and I know that this
message will come to you as a surprise. Please this is not a joke and
I will not like you to joke with it ok, with due respect to your
person and much sincerity of purpose, I make this contact with you as
I believe that you can be of great assistance to me. My name is Mr.
Roman Arkadyevich Abramovich (born 24 October 1966)I am  a billionaire
Russian oligarch and politician. I hold joint Israeli and Portuguese
citizenships. Please see this as a confidential message and do not
reveal it to another person and let me know whether you can be of
assistance regarding my proposal below because it is top secret.


 I am  one of seven oligarchs sanctioned by the UK government over the
2022 Russian invasion of Ukraine which i never supported, including
asset freezes and travel bans. But now as all my acounts and valuable
assets have been frozen and conphisicated. There is this very account
i opened without my identity and now i cannot claim it with my name
and identity because it  was opened in an escrow account  in a bank in
Africa when i was scouting for good african players to play for my
club Chelsea,the funds in the bank is (=C2=A3250,000,000 million British
Pounds)two hundred and fiffty million British pounds.This is where you
come in now as the beneficiary of the said fund because i left the
space of the beneficiary open for me to claim the funds back through a
trusted beneficiary like you.

 Please if you can stand and transfer this fund to your designated
account  as the beneficiary i will back you up with the neccessary
information that you will need. I want you to know that this is a
hundrd percent risk free transaction if you follow my instructions
there will be no mistakes.Once the fund is transferred into your
account please take only (=C2=A350,000,000 million Pounds) and keep the
rest (=C2=A3200,000,000 million Pounds) for me. i will inform you in my
next mail on how to invest the money in your own country.

 If you are willing to assist me on this i will feed you with more details.


regards,
Mr.R.Abramovich.
