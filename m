Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC725063CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 07:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiDSFSI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 01:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348536AbiDSFSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 01:18:06 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E58220FD
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 22:15:23 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e5bdd14b59so6842834fac.11
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 22:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ZQ+Chfr41Ap1rnBqjRyg9YSdPtFNo1mvhN33hifHLWI=;
        b=SgYB1IeyZzeluQKAhNlXoUvDdLKB9j73p/SJpqG1ghc6xhT1sjHPNkvvWk5dRRvXJ6
         DyYnnuVkTHBCiLS1Z85mzCXBleMrUks6k3S3EJORfwP3nuq5rGj4tzu5Z7ocJTp3lILq
         G5JqAVtYLNhE9jdUVbLDGAGkw4yxRVE1GcXnSzirGT/YjQf8DKi1zdErSIu0lX3y1kUU
         3/AtEVkLvoM2WFULUoZwUe2cwtM0jUvAtWXuM3VV4pkcdxht3Y1uMvrwThMXVYv034yL
         E8lRvhGDx18PB2R28NqvV2eN/uzeCM76THYJtQNJPnArgA02FpBczPGrsgndOVK+cztV
         uPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ZQ+Chfr41Ap1rnBqjRyg9YSdPtFNo1mvhN33hifHLWI=;
        b=nXb1nGFsLd7PXADDwoqoJHYpOb8WKzLQz9D27dGO7OYpsPuIxtgsf24kP2H8po5Xzx
         D9oO+vnETNwo32ewQAD9gOT18DNMypzixo0YVwx5ruTlj0sWeL24mywbHCK5UDHN0xpR
         ju9mUTOSaIsIYwfue2logLzI6/Uc0WZBYeNrP2QnrJjWa0M73kfhSUu8QKrHTuHN7Jnj
         GBPs4uqd53z58YDyvLiDeFd1Xrk5gBIbG/nGzye3f4GxDMyXqSjLpckZYcmoQymzM3cW
         otqPP99QxOmJSRPu3ktPGfkquEoHuTPDvAHPelI6iVszgLyqd8Ou7w2ioytUBONe4w//
         bvDg==
X-Gm-Message-State: AOAM533xAxGkkXHvRrGTw20B6bhL1yhBscJP2+XUp7DV+w2DPyHmvbCl
        5YLF/lFIYa5+Uq3JNtxNb1W4pQiZkzS0t5w/zSs=
X-Google-Smtp-Source: ABdhPJz2uzcpUpHik1ep7TmFi2HqW9KO6ld7aJNTpDJ5WP/l2DTJPKPewetwXDfLsvnw2mX57wfAxV1k6WhxmtTRCp8=
X-Received: by 2002:a05:6870:5829:b0:de:ab74:44c1 with SMTP id
 r41-20020a056870582900b000deab7444c1mr7573139oap.167.1650345322978; Mon, 18
 Apr 2022 22:15:22 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.azzizsalim@gmail.com
Received: by 2002:ac9:5c8:0:0:0:0:0 with HTTP; Mon, 18 Apr 2022 22:15:22 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Tue, 19 Apr 2022 06:15:22 +0100
X-Google-Sender-Auth: Ozf3iddArM0AgEr7o7Lh8s0LqvI
Message-ID: <CADCzDA2oafToaFUrYuXa6hUfR6Qh=Wm7e3fACqZ=h5GXoy0KYg@mail.gmail.com>
Subject: YOUR OVERDUE COMPENSATION.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        LOTS_OF_MONEY,LOTTO_DEPT,MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.azzizsalim[at]gmail.com]
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.4 LOTTO_DEPT Claims Department
        *  2.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT:$10.5 MILLION USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation funds.

You are receiving this correspondence because we have finally reached
a consensus with UN, IRS and IMF that your total fund worth $10.5
Million Dollars of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$12,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $12,000 levy after you
have receive your Covid-19 Compensation total sum of $10.5 Million. We
shall proceed with the payment of your bailout grant only if you agree
to the terms and conditions stated.

Contact Dr. Mustafa Ali for more information by email on:(
mustafa.ali@rahroco.com ) Your consent in this regard would be highly
appreciated.

Best Regards,
Mr. Jimmy Moore.
Undersecretary General United Nations
Office of Internal Oversight-UNIOS
UN making the world a better place
http://www.un.org/sg/
