Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4037271F178
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 20:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFASOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 14:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjFASO2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 14:14:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FFB1AD
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 11:14:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1b0236ee816so9879175ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jun 2023 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685643266; x=1688235266;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2QjYJBbpdaNIR88F6Zdute/I4LnMv0OvSgm8fjcmD60=;
        b=iADI7GLE09vBEQenGs1imtF1PLD2CWGIp6CL2CVBP/li0P9fzJ6RgFvGRr/ktYz3VE
         U/MlMwadxGRs96QJQVCyVKs5l9sReWxD9ccqsfbAVc0mL+md6rQbNbbDamCrarwmM5Xd
         3u3dLBJn9PEaMydeMjmBu9tNfLyqHMzXtlQ1r62f+GuuPYA+5lGGPV5io0Ol4JMWV1e9
         5r9BuPfStXBsKAYoOc5P1btqGnnpSnMUvBcjcJ1q9p3Q4I3n0GegAm8Q6ZnWgt/RGMpi
         myKdAq1dK3NhLt0QXI44dZ7lsvjOmuayu6PQHUaUlYr1X2dDVQbeJGzPPiJntxSkIrWb
         bUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685643266; x=1688235266;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QjYJBbpdaNIR88F6Zdute/I4LnMv0OvSgm8fjcmD60=;
        b=R4aU+DenuRZepL8EM2YFQAEVUDx8Rh/VcezQuen5xSFBZ4QDDFJ2HGZ3iOjYeGStWi
         B8AxGB2s2RZ04kjeeHIxedZmq6MD1q4SYIMLow9hKhT6A5Le/Tvzdg7ersmw4318hpaL
         p+4K5u9wUfKzv86ZckO8QfuJJJPukECweOrb0arCinmPLmN5hO3SODbPMelodMHGPzg6
         fjBfbCp7M3yWLA2/XCisUXRRtxKh+vLxCX1wLb85fvJWf/xtnNjW3Ui4bDB3ysovi9/O
         f2z9YOkH6fHqnYgot6+qUyM+tLQnbSi6xevhKPZiL3cRgYRRp02oZEdHL4763LPVi+ru
         Ry5Q==
X-Gm-Message-State: AC+VfDyyFloRpvnt0U4LUnK6MzIM3NxD2ZkOaRAt/V/MH+WgjJVca2Uu
        c+Qw5nT4CNPBZbTGmbZ2HDUMxEWx+sfdSuxS340=
X-Google-Smtp-Source: ACHHUZ5mjwPIPhMiudJgS+fV0itPp75ly/XDe8vrYqVODArMvlLDxOt6lhRzGaIihvvpb+1S7CrkG3JV8CGJJfAoeRE=
X-Received: by 2002:a17:902:e845:b0:1ac:820e:c34a with SMTP id
 t5-20020a170902e84500b001ac820ec34amr160448plg.0.1685643266169; Thu, 01 Jun
 2023 11:14:26 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrselizabethedward46@gmail.com
Sender: mrselizabethe629@gmail.com
Received: by 2002:a05:6a20:258f:b0:ee:c44a:9f89 with HTTP; Thu, 1 Jun 2023
 11:14:24 -0700 (PDT)
From:   "Mrs. Elizabeth" <mrselizabethedward46@gmail.com>
Date:   Thu, 1 Jun 2023 11:14:24 -0700
X-Google-Sender-Auth: -oncRyidV3zqYIoIp7Ds8TrxPZc
Message-ID: <CACK4wn-9nuNORoPER1imTzfYdaCyTts7o-xRyOjDry_pm+18UQ@mail.gmail.com>
Subject: Am Expecting Your Response
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FRAUD_8,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrselizabethedward46[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrselizabethedward46[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrselizabethe629[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  1.6 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 RISK_FREE No risk!
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My Dear Friend,

I am Mrs. Elizabeth Edward, 63 years, from USA, I am childless and I
am suffering from a pro-long critical cancer, my doctors confirmed I
may not live beyond two months from now as my ill health has defile
all forms of medical treatment.

Please forgive me for stressing you with my predicaments and am sorry
to approach you through this media, it is because it serves the
fastest means of communication. I came across your E-mail from my
personal search and I decided to contact you believing you will be
honest to fulfill my final wish before I die.


Since my days are numbered, I=E2=80=99ve decided, willingly to fulfill my l=
ong
time promise to donate you the sum(=E2=82=AC9.5 Million Euros) I nherited f=
rom
my late husband Mr. Edward Herbart, foreign bank account over years. I
need a very honest person who can assist in transfer of this money to
his or her account and use the funds for charities work of God while
you use 50% for yourself. I want you to know there are no risks
involved; it is 100% hitch free & safe. If you will be interesting to
assist in getting this fund into your account for charity project to
fulfill my promise before I die please let me know immediately. I will
appreciate your utmost confidentiality as I wait for your reply.

Best Regards

Mrs. Elizabeth Edward.
