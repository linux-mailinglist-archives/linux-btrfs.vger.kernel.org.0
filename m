Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067F04B875A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 13:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiBPMJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 07:09:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiBPMJS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 07:09:18 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF0136EDE
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 04:09:06 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so2166615ooo.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 04:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DNlgyVaU8TjCWNLA871jCHNl9EtR9BXdeye9SGukbxg=;
        b=eGRtd3uvmkREXDZjnXqRDyIBYLniWrQjkiNjafxwdQsgoyuPolmhW2LLFg4ryrBjoV
         UrCfYOV53zNpuz8asAc5iR8iHDKUI0XoZg//bLBBuIs2qK3hrrFKIPDhjJBDFWM5+Y3D
         mxx2Hi0yRImibKBHEIYFfoVgNBT07bsA2CEIRgUXO3fTiB2ijngIw6SefDg54tTkeBsc
         H7pxXSLq4U6K3vTTU1TSRgqLEvcnHVn92QVvPTAYAJLbId8TmQXaFY7v2iNOXGdffPxq
         xUmIdpohyOBXrC3ULs9Hpzx2zYb5OaCvZkfJF+J8m/qcloZGJhd9GtCVniWNsNNJd6RE
         kkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=DNlgyVaU8TjCWNLA871jCHNl9EtR9BXdeye9SGukbxg=;
        b=lyzUw/ejgR5mX9OfWeAbUScfcE7HYjsbXjQw0oLB6Kc87hY7uf7iB2V5EfoL1bOt7c
         eKfutNJgpiJwpVNSDjd+b2gm+P0LD0n3q/7DTqAF/UJCV7psW8yushZvDtWWxNJf3iB6
         QXFyAf8I68mMjUtSG2ce04A1MB7PDdjoYQ2XRPCoJ2qLhdVZ1lxY9KuDOzBwpJpsB78a
         myIwSsPs7d/m1Rwl088sk1dGi/MBT+KHonLxLPITfwJFpbiOYDhgY18yXmtzchYOstB3
         EaZoivYAgEqP24hikcyZLlNaWyVbvIt4538mBjj+GMK9+h1Iy8WY4QeKLRsHCVICKG/h
         ydOg==
X-Gm-Message-State: AOAM533z6y4/YZ0HY1lNta24ZHSMuWsj7W0Rn0MYZaPv4EC3OAXDHbQQ
        3SPC8xDnp+hxfKtVHY8U+fYPbacx95Zaj0aRINc=
X-Google-Smtp-Source: ABdhPJyMyxS0gjF1Vfq6YVT/r95eH7xw9pjzg1ecAmgrtUbSMsESJtYUp7jsR+iiF3Z/F4FjpjjQAnOfgPN1Fg00p1E=
X-Received: by 2002:a05:6870:30e:b0:bf:9b7f:7c63 with SMTP id
 m14-20020a056870030e00b000bf9b7f7c63mr326053oaf.84.1645013345405; Wed, 16 Feb
 2022 04:09:05 -0800 (PST)
MIME-Version: 1.0
Sender: mrazaraibrahim2010@gmail.com
Received: by 2002:a4a:9621:0:0:0:0:0 with HTTP; Wed, 16 Feb 2022 04:09:04
 -0800 (PST)
From:   "Mr.Ibrahim" <ibrahimidewu4@gmail.com>
Date:   Wed, 16 Feb 2022 13:09:04 +0100
X-Google-Sender-Auth: bgMI-hpQsgoHN25lVd-BdcGUcS4
Message-ID: <CAFvumbSsSnf2wrb2ZHa9ni+QixnFbKwNQdMCSwC9VBMWwNhKuw@mail.gmail.com>
Subject: GREETINGS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_2_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrazaraibrahim2010[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrazaraibrahim2010[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.7 ADVANCE_FEE_2_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a business proposal in the tune of $19.3m USD for you to handle
with me. I have opportunity to transfer this abandon fund to your bank
account in your country which belongs to our client.

I am inviting you in this transaction where this money can be shared
between us at ratio of 50/50% and help the needy around us don=E2=80=99t be
afraid of anything I am with you I will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information's if you are interested
in this tranasction for more details(ibrahimidewu4@gmail.com)

1. Your Full Name.....................
2. Your Address......................
3. Your Country of Origin.............
4. Your Age..........................
5. Your ID card copy and telephone number for easy communication...........=
....

Best regards,
Mr.Ibrahim Idewu.
