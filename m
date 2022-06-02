Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0A53C014
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 22:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiFBU40 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiFBU4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 16:56:16 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6334B80
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 13:56:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ec42eae76bso64018867b3.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=d+MLllrTnVLTVuNtzK3RkWrOuNSSWMmwIaiBnbLtjnI=;
        b=bP2Bg9kPaoZeUOZTwDrCf0TcA+yFfRTyMPXiyBc1hgaOcOhU/7J6HXpUJAtG0vGXe2
         HdiVuKHQ73+Sw6+AW2z0L7B1Zsq49m0EOs8HolvzyvIAHihXph0OX/EBNR9r+H2kwGg5
         t0Tv6/pTSym6LNcptuCtK0UtS6rHSK3/p0HDzjbM35P+QVVx1b9hFaP01w4lpi2w19ri
         CpgzaJ6JCIMU59184vXDSaP/UrOHUA/1xCZF0mJMj12N/l7Bbr0PLi7jJ04MvIc6tYCG
         tcjfS5PI7JJFlAWRY4yMBNBphwLp9KqnO6CQ1HYhKtGa7S81lqwsIX6SVwOghQ5lGL5L
         qKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=d+MLllrTnVLTVuNtzK3RkWrOuNSSWMmwIaiBnbLtjnI=;
        b=Rmha0vxK82jUY0DGGXCf2bYNXbNPUQdHr/vZ0MdV0lSAd9A7kvs325j/44F1AXBog2
         lNatCNhrHmoyRfZel9kufxiisz+eGh7Y+E1g+nzdqEiayrGJHELuS1UXyeqIuZHnYR0J
         pboFeFuYe+5+Fun6nRrHMfGRtc6BGrA9aK1PSKUeNP8WDpm4AAYZJocBaCFavR0PDKdg
         sa8la1m/yFwxkTvn++i4KW8kKesfBb1Ys3ANWxADN7r5NoszYF0X+FKTbCtJeRk2jrJ4
         W6pYUvvc6XHDkWgCzYoX9o7yYYGS8MlO216cWej9ldZzfr2Z33dQAwmhLdfJiecRi76b
         K58Q==
X-Gm-Message-State: AOAM533dhYxbbd3tW04amtjCJqH4vFNMZawAQffBz+o1HSQwfb5k6GHn
        keeUgaFLjkBaprOQcATHwTWlfzylCf1aP4rafJA=
X-Google-Smtp-Source: ABdhPJzz4CIFTzLwRd4bDwRghcuq8KmAMJuf1ZQNKj3c2Lo/OmAL2dCZKUleJ315pEcSs8xxcj3S1aQ8FnTEFw1HYHw=
X-Received: by 2002:a81:1358:0:b0:30c:2e28:4050 with SMTP id
 85-20020a811358000000b0030c2e284050mr7698599ywt.206.1654203372355; Thu, 02
 Jun 2022 13:56:12 -0700 (PDT)
MIME-Version: 1.0
Sender: bbchitex6@gmail.com
Received: by 2002:a81:d447:0:0:0:0:0 with HTTP; Thu, 2 Jun 2022 13:56:11 -0700 (PDT)
From:   "Mr.Patrick Joseph" <patrickjos09@gmail.com>
Date:   Thu, 2 Jun 2022 13:56:11 -0700
X-Google-Sender-Auth: 2x_0MgxYCCazRZg9th9WovhcOhY
Message-ID: <CADX4xg+gCaCydEs1Tz5F-66oRNkS3vNJUkBVhip+COD_if2nGA@mail.gmail.com>
Subject: I expect your urgent reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_95,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1132 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9755]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bbchitex6[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bbchitex6[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Friend,

I apologize for contacting you this way, I am writing you this mail to
solicit for your cooperation in a very confidential business
transaction of $16.5 million. However, it is not authorized by the
rules guiding our bank for a citizen of Burkina Faso to make the claim
of the fund unless you are a foreigner, I ask you can we work
together, I will be pleased to work with you I propose a 40% of the
total amount to you after receiving the funds successfully, and I
assure you that this transaction is 100% risks free. Reply me as soon
as possible so that I will let you know the next steps and procedures
to follow in order to finalize this transaction immediately.

I expect your urgent reply

Regards.
Mr. Patrick Joseph.
