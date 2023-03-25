Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21E6C8D64
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 12:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjCYLUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCYLUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 07:20:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF38FE1AA
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 04:20:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3643454wmo.0
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679743200;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FZRXrrCyhC/asJwSLOsOxy0dUDn7uJ0nZ8VEzBDUmgw=;
        b=RvqlL4vXdmLZ3+GPCy8kCL42diInnqg9AUUQP6do0nrsiCPWaPmT0fMChz++P5h4cN
         IINxvVj+mJcJdhAyRvExqfoEyaiozCKDjVHywj28w2lnCO3OYJ3WJ9/DbEuX4f7RgdMM
         OZzckvtOpzyDgeErFfEgGeXqCBPiLVkckWugNsuxwnZyuZWkejiZ/cijSymExLqiBo/4
         NxLJOiqBQ6LEOOpIqo80ugAyiDoqJqgqlHsYLsv2jn1njWdc8/f7m2a9rfdiZpLE6aQa
         0TpMYMz0ajt1ulzLCxb0CsXjRZZh8k1hLSdFEYbSiTC4+wrorzMMV8AugBxHGiL4Hxll
         R2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679743200;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZRXrrCyhC/asJwSLOsOxy0dUDn7uJ0nZ8VEzBDUmgw=;
        b=hSDSFlW7fgrEvKDk9d/OXfXdiIpNaH8nOLYIhagRMKVN0pk9M/5/XentpkewRNK2KI
         rQ42pZKpo6RW6W4fYKw+E3WWX1UweQEnPMBuowwgvAucTjHpCBqxBM/miCJ4/iOll0NU
         hp6Dsa2kp329OxL7CzIC6XANAqGCiJudbQlPWq1dyFmiejqE4mcO8ozhyj9EJLUs96MF
         OQ8s53d+zZo1KBQVGUMOBKRYc0FCJ4JacXD8l33SK3J1ujjGsUa+iwi49Oh+nYUJghzh
         vKUt4x54Y7gq4HNOQe9Cx+BlQ8DlOq2tLhRQLkRv1LeV7nhwn8A68wkn148Ohuusi3PY
         19MA==
X-Gm-Message-State: AO0yUKVC2nZcrhTV20BfFQ/T63mjUnaQ6VHxIUCKykzy/X6943F227gY
        saU/wjG2LkKSWgf3WbBLuMpW0xOpGmZqDBrc5L8=
X-Google-Smtp-Source: AK7set8eWZRwYp+qmYJp8B02G2WuY74f3KR4uf3Of/INTmx5nhiWsfQjD+bD28PcSpUvCkvSp8WFEJRaqEoU4PH8QEg=
X-Received: by 2002:a7b:ca4a:0:b0:3ed:c669:8a15 with SMTP id
 m10-20020a7bca4a000000b003edc6698a15mr1392897wml.1.1679743200148; Sat, 25 Mar
 2023 04:20:00 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mkwesogo@gmail.com
Sender: simtondji@gmail.com
Received: by 2002:a5d:4a4c:0:b0:2d8:6f46:a535 with HTTP; Sat, 25 Mar 2023
 04:19:59 -0700 (PDT)
From:   "Mr. Muskwe Sanogo" <sanogokwe@gmail.com>
Date:   Sat, 25 Mar 2023 11:19:59 +0000
X-Google-Sender-Auth: ycbpY1NZYejUWu4cIxovoRDxGao
Message-ID: <CAGg0eJxqqdi-mBH8JMwpVMLX9ErzkZF6LCCM-=CH3nm2n4va5g@mail.gmail.com>
Subject: Greetings and articulate salutations.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=ADVANCE_FEE_5_NEW,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTTO_DEPT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:330 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [simtondji[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 LOTTO_DEPT Claims Department
        *  0.8 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I bestow upon you a serendipitous and euphoric afternoon, With due
respect to your personality and much sincerity of this purpose, I make
this contact with you believing that you can be of great assistance to
me. I'm Mr. Muskwe Sanogo,  I'm the Chairman of FOREIGN PAYMENTS
CONTRACT AWARD COMMITTEE and also I currently hold the post of
Internal Audit Manager of our bank, Please see this as a confidential
message and do not reveal it to another person because it=E2=80=99s a top
secret.

It may surprise you to receive this letter from me, since there has
been no previous correspondence between us.  I will also like to make
it clear here that l know that the internet has been grossly abused by
criminal minded people making it difficult for people with genuine
intention to correspond and exchange views without skepticism.

We are imposition to reclaim and inherit the sum of US $(28,850,000
Million ) without any trouble, from a dormant account which remains
unclaimed since 10 years the owner died. This is a U.S Dollars account
and the beneficiary died without trace of his family to claim the
fund.

Upon my personal audit investigation into the details of the account,
I find out that the deceased is a foreigner, which makes it possible
for you as a foreigner no matter your country to lay claim on the
balance as the Foreign Business Partner or Extended Relative to the
deceased, provided you are not from here.

Your integrity and trustworthiness will make us succeed without any
risk. Please if you think that the amount is too much to be
transferred into your account, you have the right to ask our bank to
transfer the fund into your account bit by bit after approval or you
double the account. Once this fund is transferred into your account,
we will share the fund accordingly. 45%, for you, 45%, for me, 5%, had
been mapped out for the expense made in this transaction, 5% as a free
will donation to charity and motherless babies homes in both our
countries as sign of breakthrough and more blessings.


If you are interested to help without disappointment or breach of
trust, reply me, so that I will guide you on the proper banking
guidelines to follow for the claim. After the transfer, I will fly to
your country for sharing of funds according to our agreement.

Assurance: Note that this transaction will never in any way harm or
foiled your good post or reputation in your country, because
everything will follow legal process.

I am looking forward to hear from you soonest.
Yours faithfully,
Mr. Muskwe Sanogo
