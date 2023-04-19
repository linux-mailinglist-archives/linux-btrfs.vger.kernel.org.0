Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35596E797F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjDSMTA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 08:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjDSMS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 08:18:59 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D249E5FCB
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 05:18:57 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id v18so11344861uak.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681906737; x=1684498737;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=orCeLkQb3/qxxBL1D/9tMXR6ve7bG06/9t/tjAUZtvs=;
        b=YqOLc85D4DPTScMuvEPA5jdKW/AOHSZmF2TNkPllRUU3GHwjrP0Q3LDZBKSFhDPbwl
         e1Lq+5ehVIC8jh8BC9vrvTi4U9dVbwKbNggYs5xx1ZNXPMU/fytN4tX4031EdDUG41Vb
         jiu1eQNWvDPR7Iv5JCfK/zEyMlkno7wcQZHRVMa4nNFYb/odAfxw8BGj+VKaCK2Lk7jp
         7yOLMV1uicJTCTOjLvFNs8thqli2aQkkXgwiiZPR63zBG1VQllsnlFIxImbnDdacF2o/
         qLcLldr7VW2L1BgalywxFc2fq2ja/nRGUQxmRwFPwjwgQxUka8GeBznCs9WveSe6eHpQ
         a9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681906737; x=1684498737;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orCeLkQb3/qxxBL1D/9tMXR6ve7bG06/9t/tjAUZtvs=;
        b=Gg8xDgLNqjvWDXNJBCNNQXccl+s0lJfymWSEhampd2pUnD+Ik4peLMWvccoi3fpf02
         vaYD3oWkOjYYcusQdGZ4mNfs5HOBabCSCG7gzi33FEnlU+m+k4/dVfw9B3rem4qlmteU
         H4lQ5wjSBIiop8uYmH5gmBX/bTUILfH2R1OvdbXEWb90nZncVV7r/EHGIVWy4Y1kLM4e
         5rWGmtb5fSkiMM3zXv5jPfxjiP2LSNlU6X7VapX8YWBRQaW7/2LHAW1K6Ovk8emOmG7d
         paXqdRJxAnGuZ7jHft2uNvo1PY9w6a7Wkegt3x/fdXCE+L+gRctrpAcWe5Y2N672sIcN
         MfqQ==
X-Gm-Message-State: AAQBX9e34XISdpGQ3gT5v/GRDYaJ+lbBOH27509CfHf1FGfbh+pf0wzQ
        w7PXm/nolYiB4DXKiOtbM9OB2TzjdbeygIXsSi0=
X-Google-Smtp-Source: AKy350apk8kku1tqECoUZP1q01+vwLYVFTlR3M0+SG+YIk7oC2+2dfDg+MRnvvrY+Ogdz2QZ9FNjrSR2AqfqShMYLQo=
X-Received: by 2002:a1f:de84:0:b0:43f:ff62:f8ca with SMTP id
 v126-20020a1fde84000000b0043fff62f8camr6429346vkg.15.1681906736517; Wed, 19
 Apr 2023 05:18:56 -0700 (PDT)
MIME-Version: 1.0
Sender: www.simpol@gmail.com
Received: by 2002:a59:9e46:0:b0:385:8ffc:4b1e with HTTP; Wed, 19 Apr 2023
 05:18:55 -0700 (PDT)
From:   Maya olivier <mrsmayaoliver31@gmail.com>
Date:   Wed, 19 Apr 2023 05:18:55 -0700
X-Google-Sender-Auth: bVafvBBnWmwzPJktx3Xft66NaLk
Message-ID: <CANZL-vEJnBA=KicRqkJtDNWddPfEX6r_XLBrU89fhw8KuO9iOA@mail.gmail.com>
Subject: CAN YOU HANDLE THIS PROJECT FOR THE POOR?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:932 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsmayaoliver31[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

CAN YOU HANDLE THIS PROJECT FOR THE POOR?
I am Mrs. Maya Oliver, from the United Kingdom. Firstly, I am married
to Mr. Patrick Oliver, A diamond and gold merchant who owns a small
gold Mine in Thailand Bangkok; He died of Cardiovascular Disease in
mid-March 2011. During his lifetime he deposited the sum of =E2=82=AC 12.7
Million Euro) Twelve million, Seven hundred thousand Euros in a bank
in Bangkok the capital city of Thailand. The deposited money was from
the sale of the shares, death benefits payment and entitlements of my
deceased husband by his company. Since his death I decided not to
remarry, when my late husband was Alive he deposited the sum of =E2=82=AC 1=
2.7
Million Euro) Twelve million, Seven hundred
Thousand Euro) in a bank in Thailand, Presently this money is Still in
the bank. And My Doctor told me that I don't have much time to
Leave because of the cancer problem, Having known my condition I
decided to hand you over this fund to take Care of the less-privileged
people, you will utilize this money while I am going to instruct
herein. I want you to take 20% Percent of The total money for your
personal use While 80% of the money will go To charity" people and
helping the orphanage.

I don't want my husband's efforts to be used by the Government. I grew
up as an Orphan and I don't have anybody as my family member,
Meanwhile i have concluded with the bank to transfer the funds to you,
once you are in contact with them by any of the transfer method as
listed below The total funds is currently with the money gram transfer
company under the guiding of my bank director in Siam commercial bank
Plc in Thailand and they have been instructed to transfer the funds to
you through the listed options below

1, Moneygram
2, ATM card,
3 RIA
4, Online Transfer
note that the mention above method of transfer is 100% guarantee for
you to received the funds without much delaying, once you are in
contact with them, base on the urgency required for you to handle the
project, as my doctors has confirmed that I don=E2=80=99t have much time to
live, bellow is the contact of the RIA and MoneyGram transfer office
manager who will proceed the transfer to you once you are in contact
with them.

BELOW HERE IS THEIR CONTACT INFORMATION
OFFICE NAME: RIA MONEY TRANSFER SERVICE Thailand Bangkok
CONTACT PERSON: MR. ARTHID NANTHAWITHAYA Directeur g=C3=A9n=C3=A9ral
CONTACT EMAIL: transferriamoney0@gmail.com
Let me know once you start receiving the funds bit by bit
Regards,
Mrs. Maya Oliver
