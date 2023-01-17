Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE88466DD37
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 13:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjAQMKZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 07:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbjAQMKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 07:10:24 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B2632E62
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 04:10:23 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h184so5369223iof.9
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 04:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1FS23f9lMOyJIiIZuP0A4Qiyf73vPOUb05pwu8u1Yk=;
        b=SexUCdmJ0t7uBwEs+JFHvkuqn7dCgaX7ayo4wlyexi5FUds08nsa5BciZCnYPrmjXl
         IQm/BlLFyrBeN73I0xwsU0tQ4rvjxpu74N6c4WASKibYnksfE6RP93uiceNUK6YuAzZe
         BPBfO/Y57FT7AkUZj2b1e2ayRZOP49wfUdkTODtXCOT/ejXemgRThJ0GWSbVjhbMrP+t
         k58MF9Zws15gyIHczCsJ7OC4p8cKFBGE0Uk123fDnESy+Y3jsv5/1IhgJyY3s/VnI72q
         jhf107GR+rO9BCF2vL/I1xQyqOo1cegbOiALgh7LDFg+RK6689yKHrEKTWzUIMCTZ9Ca
         xeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1FS23f9lMOyJIiIZuP0A4Qiyf73vPOUb05pwu8u1Yk=;
        b=JyIoqVAhFRdY6JBCel8ZR1MoLHFhj4JKINbDJggW7z7WAeHbOL7J8Vuo5V+ILxMkHc
         VUL4HEbLs2D8AlOlGvHD02d4Kh0ux6wLbm3+lKox6NEo5MXF/IrUsZ06J2r4hcfAEnLW
         ATpVqXomZNGR6dz5fyJqaNbbEswqvEAhNbdouu7znXcfSRdMD0VSlV2qlyqlNq1J4udC
         +yn2CJ1QTmhgPudXQBSIvSkcktlqAp7Lzc0Xh/mAESeEVbQpEEVZ7S3ALtyy0E7kzheD
         1RsFOBKjhCZu6kahufGGyMFQq13za2z5j2m4NK4bWf2eKncN7hepma5HBa1Jz6qF31aD
         J1tw==
X-Gm-Message-State: AFqh2krxpy2vzvlqaWRnCSsWuJU+FTcmDqf69rR9JLsOjN2/7c4vzXTA
        R3NpckXnJBLvfA7wKqf6IvqwOUvEM7HhB5mIMp0=
X-Google-Smtp-Source: AMrXdXvNfFK2PCgOLql/7x2hmL+nyRrTVRRmms3+tTSbNi0CkS3vYHY3XbDi2MOsulRT1AS7/Wrn1YnDJ7VPhoXNXZg=
X-Received: by 2002:a5d:8f99:0:b0:6db:6628:d30b with SMTP id
 l25-20020a5d8f99000000b006db6628d30bmr161452iol.178.1673957423171; Tue, 17
 Jan 2023 04:10:23 -0800 (PST)
MIME-Version: 1.0
Sender: abubakarbell20001@gmail.com
Received: by 2002:a05:6638:38a5:b0:38a:bd02:2926 with HTTP; Tue, 17 Jan 2023
 04:10:22 -0800 (PST)
From:   ABUBAKAR BELLO <belloabubaka94@gmail.com>
Date:   Tue, 17 Jan 2023 04:10:22 -0800
X-Google-Sender-Auth: QE5HQc-ekBLwAsPlNPE1ov4J2tA
Message-ID: <CA+ZCu9t=nkUw6MuSJzig67qyjMgbvB==xzL5xvCK6m9vy+d6hg@mail.gmail.com>
Subject: URGENT REPLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5008]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abubakarbell20001[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [belloabubaka94[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=20
Hello,

I am a relative of a politically exposed person (PEP) that is in
financial regulation. Due to my present health condition, I'd decided
to write through this email for the security reason.

Therefore, kindly treat this as top secret for the security reason.
I'd after fasting and prayer choose to write not you particularly but
I believing in probability of you being a confidant chosen by chance;
luck to help and share in this noble cause.

I need your assistant to conduct secret transfers of family's funds
worth =E2=82=AC90.5 millions Euros. It was deposited in bank clandestinely.

I am in grave condition and I expect my death any moment now and I
want to donate the fund to less privilege and you will be rewarded
with reasonable percentage of the fund if you can assist.

Please contact me back for more details,

Yours truly,
Bello Abubakar
