Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939AE5B0704
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 16:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIGOeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiIGOde (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 10:33:34 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B93C86FCB
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 07:33:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z21so9969326edi.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=SSGjyR2bmjYCrAlESugCufneGXl+LZC/mmyGfrjsk2GE1Kx1lZRkYY1EUdreWWyCSQ
         sqluCme0XsqujJoH+umsfKDs8UrC/9ZGnLj4b+GO0hYgYXhOc+nCt8MOQUxR8CwU83qh
         IGWw9qH0mLtGh4TXTWi4EI1eoq52zR4PT+F7cJR3CKXNjBfxw1C+s/9CkSbq4quVbWwH
         EF0HjUUHC7HLHDlCm+xMO8g90CDRQnoLTxG5JG8QRF4Je7sNcgpiBsXy6SB06Zlint9h
         0vn4j6hkMI2QtivfJh+FavwBs/6jN5+806aKyxNxXrR+uyoh2MnenECAeW2duoYS39/5
         mPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=FKwFch3HfjLDw723KbeoD8xO/U6JfAgmg1GM7fq1yQYArU0TDlLeQhScFlGhpjctpO
         ABfou7myS4XAr/qiIq5dTA8GvEJDr7KkqG2sSZFaJkRndxLgdnaWLPIjD/Mvn9l99Bpw
         A0VxDR9u9olcovCZqD805CCTGxaDoPF3MHGG/zIDfv9A+qLdV9cvm2oRe3wmg7Qrlfxy
         k2TLDHt8c18BsNmNhrI+ZGgCArhVX52te+2D79OQi0AyDySN/QxkzVA3iGoOWa0E2ddi
         qYlGQav5M/vK+mhISZsw30xshcsv3jCP7wpNbSk518a+ogg8hOF7PLrUVXAS9n/u11Qo
         d4Yg==
X-Gm-Message-State: ACgBeo3/binde4+V6zVByooDynIsx10rhH8zTqR47+yQGn4LjQeAwQuz
        HL3iHm4AcFp/os1zetB2jN67wkhf+H6cZbsM98s=
X-Google-Smtp-Source: AA6agR7Ln0Ysck8H4qd9CxVijX9Q4k17jVwzW1LjbugbwbdgNpmJiiXSIctkOqhdg+uqPMufZamcMYRcWGF9/uZM6PM=
X-Received: by 2002:a05:6402:51d1:b0:44b:ea34:6c0a with SMTP id
 r17-20020a05640251d100b0044bea346c0amr3317270edd.369.1662561182925; Wed, 07
 Sep 2022 07:33:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3fc4:0:0:0:0:0 with HTTP; Wed, 7 Sep 2022 07:33:02 -0700 (PDT)
Reply-To: lumar.casey@outlook.com
From:   LUMAR CASEY <miriankushrat@gmail.com>
Date:   Wed, 7 Sep 2022 16:33:02 +0200
Message-ID: <CAO4StN3SO1HAAuHp3muOTACpFXiZdXht6wTH0Y_DFYKUZH6aMg@mail.gmail.com>
Subject: ATTENTION/PROPOSAL
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [miriankushrat[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ATTENTION

BUSINESS PARTNER,

I AM LUMAR CASEY WORKING WITH AN INSURANCE FINANCIAL INSTITUTE, WITH
MY POSITION AND PRIVILEGES I WAS ABLE TO SOURCE OUT AN OVER DUE
PAYMENT OF 12.8 MILLION POUNDS THAT IS NOW SECURED WITH A SHIPPING
DIPLOMATIC OUTLET.

I AM SEEKING YOUR PARTNERSHIP TO RECEIVE THIS CONSIGNMENT AS AS MY
PARTNER TO INVEST THIS FUND INTO A PROSPEROUS INVESTMENT VENTURE IN
YOUR COUNTRY.

I AWAIT YOUR REPLY TO ENABLE US PROCEED WITH THIS BUSINESS PARTNERSHIP TOGETHER.

REGARDS,

LUMAR CASEY
