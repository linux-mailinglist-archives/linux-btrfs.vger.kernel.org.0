Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA02B5B04C7
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIGNKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIGNKk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 09:10:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC82180E
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 06:10:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z21so9583257edi.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=qFMeBXcZtcp4UfmXxS33p2to/PiDlsXeS+J0AoWTKPw=;
        b=Dk3GesBtI4Y32gphCsr94184a+KFghJJp2jRblPtHS/eXufgRCxd7V+dRO5uTtG9AJ
         om0aeAxTTXokhOj/PdOO7fvR+UoLUL7QRFR4XOhYea4cvE9dx1Mj6HS2SKCXR3dRnM44
         pMr+4tIIn3X60UQzBJgl3pY3UAHcakebHSWgnXo9jbUjaytiCqJLgKORHiAedQxkc0yx
         cjd/6ljut0cKlowyc3OUz0VvpKrZRESvo8wM85vBumM0U+XfS2S7JtdB4DlYJn5brgTt
         zrVDd9x7D+eM3hUDpVgJ5Xq10JvZTaoVnThaMoR1YiVwK/6Ymv9k36kK1e6vDpOpN8p5
         yIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qFMeBXcZtcp4UfmXxS33p2to/PiDlsXeS+J0AoWTKPw=;
        b=coJbfYc9vDlbzWqmw2mxOS2GMO0g7hd5xCvEV4GXRnA2CLgIRY2Fm6xhc42yxhO3Wb
         3gXAajm+41I+Nii9coPdIiLe8V2kWu6b8Ds7VoVHULRJnf51aW6YhSIf8XL3jxCIfage
         2IpDH00+B+yYUewnbCOyYzEB4NOsUiBQY4R9Iw0tmRUMS2pW5gbq243YPF0iOsSCrx8D
         hcsbl2ZnYXHjfV5A/L3HG+qepTezZPgsJ/KQRuC5qjQpqj4fwpLxHjGIWm4ceBG+BYEK
         bBQExUQ5OPNYdmLbbAA9rH1zD4d+qHz5EW/IbkfC14pK9BFYAZoHyTw6kYqvaHEVZol8
         dmQQ==
X-Gm-Message-State: ACgBeo2+FK6J/MlNQfvyjzqZFMyNHo50au18a92S8nxMHGBTszjXwMSI
        f7yf1sW3xIYZHJfuyz8E380pqbDAS8BM04XR3jU=
X-Google-Smtp-Source: AA6agR5fMBZ/bAXeqcBu8cxBnJs42IxUj3zSIgpoAYf2MGxiP/FndrNzOj+H9kjZLJ0IdzUZHBs1rXYTHuOvb4nHVmo=
X-Received: by 2002:aa7:d3d3:0:b0:44e:baab:54d9 with SMTP id
 o19-20020aa7d3d3000000b0044ebaab54d9mr3016108edr.43.1662556237339; Wed, 07
 Sep 2022 06:10:37 -0700 (PDT)
MIME-Version: 1.0
Sender: oyebuchikalu29@gmail.com
Received: by 2002:a17:907:9627:0:0:0:0 with HTTP; Wed, 7 Sep 2022 06:10:36
 -0700 (PDT)
From:   Hannah Wilson <hannahdavidwilson393@gmail.com>
Date:   Wed, 7 Sep 2022 13:10:36 +0000
X-Google-Sender-Auth: g5vVVLAaDAG4qnzMBXestYj2RH4
Message-ID: <CAOkQLHX=D2L-8eZ_XVvjzB_hWgYe4zvPUusPp_OQM7FW45Cv+g@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings,
  I am glad to know you, but God knows you better and he knows why he
has directed me to you at this point in time so do not be surprised at
all. My name is Mrs.Hannah  Wilson David, a widow, i have been
suffering from ovarian cancer disease. At this moment i am about to
end the race like this because the illness has gotten to a very bad
stage, without any family members and no child. I hope that you will
not expose or betray this trust and confidence that I am about to
entrust to you for the mutual benefit of the orphans and the less
privileged ones. I have some funds I inherited from my late
husband,the sum of ($12,000.000, dollars.) deposited in the Bank.
Having known my present health status, I decided to entrust this fund
to you believing that you will utilize it the way i am going to
instruct herein.
Therefore I need you to assist me and reclaim this money and use it
for Charity works, for orphanages and giving justice and help to the
poor, needy and to promote the words of God and the effort that the
house of God will be maintained says The Lord." Jeremiah 22:15-16.=E2=80=9C
It will be my great pleasure to compensate you with 35 % percent of
the total money for your personal use, 5 % percent for any expenses
that may occur during the international transfer process while 60% of
the money will go to the charity project.
All I require from you is sincerity and the ability to complete God's
task without any failure. It will be my pleasure to see that the bank
has finally released and transferred the fund into your bank account
therein your country even before I die here in the hospital, because
of my present health status everything needs to be processed rapidly
as soon as possible. Please I am waiting for your immediate reply on
my email for further details of the transaction and execution of this
charitable project.
Best Regards.
Mrs.Hannah  Wilson David.
