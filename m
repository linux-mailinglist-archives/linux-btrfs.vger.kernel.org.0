Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA52727280
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 00:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjFGW4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 18:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjFGW4S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 18:56:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58EA2703
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 15:56:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5169f614977so2014514a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686178573; x=1688770573;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lwmqmz3SLTAm/5XHn54kA2Qkz1KiGdBlOiEDAaxIk1A=;
        b=Vs2O3FJiGjOSsYkVdVVwQ8usUW0Na2c1JkRxzODLflg+DQkLHMSvDUTON1eOgoDd5p
         icZX7jz85gtt675JIQoCg2qYDeGvdgrlIlnYsBqJCXY6A+wwUH4Pzx63GHJ70nVIOHpq
         q8q4NwQWw9O7Ka1WcBWhtc95lIatv8n89RH1nSmTaJwpto6eirRVCg2zeJDk+R5CA+KG
         ThXmo+FVEx7rMo/R9HxHw2025VcLT8t8EGl5ZKxML6giyeJpWVWuCmdmhwVTBmwvl+lO
         4Pyzwb5XpDz845p07KZNMlaubUmeRc4L02Q7u93h4SKEXfacqvhkSvKzrJS0PjXfy7pG
         yWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178573; x=1688770573;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwmqmz3SLTAm/5XHn54kA2Qkz1KiGdBlOiEDAaxIk1A=;
        b=eqoKGnXFqkcjrd8Vt958ttmXZg58xTQNYj4bK3OLVjc3D9bHN9ewu7abQ2SzpCBU7p
         OussYoZgFQ97EGJPOCL6rKO97T7OPk/o3hm9w8CXMy1SNKEewKAPGWNQlse3bHUx9SAh
         tHJ4j65zCD5w/fqvUQgtRlGRlH2ETrdkI6t9dNY3KZPKe/tQl5hlpa8b6E1ouxvVkeQ7
         2guzEifj5+Fh+W/j+HRv4QPMdPKWJKDalmcnDCSXMoO6TmSNR5itKz29HdbRxdsRRk/o
         2fICe3yutPlYyTn54nAplOwFnbPcudP3D8Ke9LA8BYWpza+9Jk+t3FvdDz5uE+aKOSsp
         qO0A==
X-Gm-Message-State: AC+VfDzMspbilDZ8TUqKf3Q+N9FtauFsCXxRgjpCkhkFMilR54IxfLyJ
        6oWcHaV2EDBA9UyIn4aXB8+A8uJ/4irU00lRYuQm+LY5PnfmvA==
X-Google-Smtp-Source: ACHHUZ5lc5uNG0II8N/7owu97MNYayebO2FU5BOHITGRdvZTCXANx0Yi1fv5Th/dfzvi0zTuZAaSCLE67mXxoPl8ud4=
X-Received: by 2002:a17:907:8a08:b0:973:ad8f:ef9b with SMTP id
 sc8-20020a1709078a0800b00973ad8fef9bmr8009971ejc.5.1686178552696; Wed, 07 Jun
 2023 15:55:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2409:0:b0:217:72a9:f646 with HTTP; Wed, 7 Jun 2023
 15:55:52 -0700 (PDT)
Reply-To: unitednationcompensationcoordinatortreasury@hotmail.com
From:   "UNITED NATION DEPUTY SECRETARY-GENERAL (U.N)" 
        <successikolo@gmail.com>
Date:   Wed, 7 Jun 2023 15:55:52 -0700
Message-ID: <CADFNGJ8EwbrtVXBod+yuxOPvcNStu1uNZVywED0Ra-jpG92ATw@mail.gmail.com>
Subject: CONTACT DHL OFFICE IMMEDIATELY FOR YOUR ATM MASTER CARD 1.5 MILLION,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_3_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FORM_FRAUD_5,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FORM,MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_FILL_THIS_FORM_LOAN,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:534 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [successikolo[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_3_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  0.2 MONEY_FRAUD_5 Lots of money and many fraud phrases
        *  0.0 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

UNITED NATION DEPUTY SECRETARY-GENERAL.

This is to official inform you that we have been having meetings for
the past three (3) weeks which ended two days ago with MR. JIM YONG
KIM the world bank president and other seven continent presidents on
the congress we treated on solution to scam victim problems.

 Note: we have decided to contact you following the reports we
received from anti-fraud international monitoring group your
name/email has been submitted to us therefore the united nations have
agreed to compensate you with the sum of (USD$ 1.5 Million) this
compensation is also including international business that failed you
in the past due to government problems etc.

 We have arranged your payment through our ATM Master Card and
deposited it in DHL Office to deliver it to you which is the latest
instruction from the World Bank president MR. JIM YONG KIM, For your
information=E2=80=99s, the delivery charges already paid by U.N treasury, t=
he
only money you will send to DHL office south Korea is
($500). for security keeping fee, U.N coordinator already paid for
others charges fees for delivery except the security keeping fee, the
director of DHL refused to collect the security keeping fee from U.N
coordinator, the Director of DHL office said that they don=E2=80=99t know
exactly time you will contact them to reconfirm your details to avoid
counting demur-rage that is why they refused collecting the ($500) .
for security keeping fee.

 Therefore be advice to contact DHL Office agent south Korea. Rev:John
Lee Tae-seok
who is in position to deliver your ATM
Master Card to your location address, contact DHL Office immediately
with the bellow email & phone number as listed below.

 Contact name: John Lee Tae-seok

 Email:( dhlgeneralheadquartersrepublic@gmail.com )

 Do not hesitate to Contact Rev: John Lee Tae-seok, as soon as you

 read this message. Email:( dhlgeneralheadquartersrepublic@gmail.com )

 Make sure you reconfirmed DHL Office your details ASAP as stated
below to avoid wrong delivery.

 Your full name..........

 Home address:.........

 Your country...........

 Your city..............

 Telephone......

 Occupation:.......

 Age:=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6..

 Let us know as soon as possible you receive your ATM MasterCard
for proper verification.

 Regards,

 Mrs Vivian kakadu.

 DEPUTY SECRETARY-GENERAL (U.N)
