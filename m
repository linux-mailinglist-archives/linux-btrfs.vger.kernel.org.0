Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1429E50AC43
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Apr 2022 01:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346022AbiDUXrV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 19:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiDUXrU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 19:47:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E5C3EBB5
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 16:44:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d15so7105434pll.10
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=sZJL5nrfj4uWDSfp8pFqWp/BCZ9/TcW4ZIqyYuNNsrk=;
        b=M0hbT9VOZZM+OvHVppSxk0/UJYeDAxdDnSI3p2zeOKbIvt7/HaeBN99EMIYKDLpbAZ
         zhfpcs2mAYPF2c7K+G+uy2OZWasFc8fSIadqpIKtGV5AwztOG1hgjRYQGS+A26dK+n39
         6Q+U3E8oSJrzYrCvH95GQfeQ7gv/LbEZpmwhZdZCG/Znhdo+ryticXkfQpGzpkrh5eMO
         80LjboSuY7Sskx5d+nkOKggl/e4M90DsHB1JMNZLCghQdnX+d/LrMG5dDiqrHLJkzdzg
         Um3ns5F2+04sNp9nwTWNRk7vzBjfUJwP/CJzy1QE25Yf+j8INPQnDV9CNYcA43F9RmiE
         rHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=sZJL5nrfj4uWDSfp8pFqWp/BCZ9/TcW4ZIqyYuNNsrk=;
        b=rFGst4Gi8peLlC+C4u3B9NJ5h2W5oixwGwvlN15DR2YhZrfucX2KT4BqxmngsjcddJ
         fTrjEzsIKa4uZAFhrJ96TT6HW8/gTcyq4D3Q022VutB4OHMdvt1AzxV4XNwa4XnXHjdP
         xNW6Pvhz9tWPvRLuYotrcwJWC4s/VyfrZK6/BaURDlhL0PolXvBGIZrUnYtEzr+q4KpB
         G4tsYMemhJwuNQ7m9X2C+v5NEW9YmJQofmjA340dbXq9syNA4tTYkhrQvfLKdoWxl3xD
         8YGQpQUEy7gVdGjZbjTNv5D6k1dBcNuJvQyVB3jzvFvhec1IIHQVVn84CfpKjCtfkPd2
         b5LQ==
X-Gm-Message-State: AOAM533SpXMKX5Q/jxFlX5WdX9Qv+LAXp5MnZP1cAYy3Ouj0XlXs0wOa
        LajrxODOHao+bBi4GC67EDI5V283zux0Xp6qsi8=
X-Google-Smtp-Source: ABdhPJzokpk1ha8cijn/C8DinnKaTfyUpjKMNHfX/DJkYb8eCM8oD/ak8IZKCZckTCVNyaJFimiWeMdMqdEBAwhVHaE=
X-Received: by 2002:a17:903:240f:b0:158:b871:33ac with SMTP id
 e15-20020a170903240f00b00158b87133acmr1804129plo.135.1650584669312; Thu, 21
 Apr 2022 16:44:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:526:0:0:0:0 with HTTP; Thu, 21 Apr 2022 16:44:28
 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Mrs. Rose Godwin" <rosegodwin1999@gmail.com>
Date:   Thu, 21 Apr 2022 16:44:28 -0700
Message-ID: <CAL6LAtqGrou8Y=9LBT0v5-j2C41Rh1PGDz8Jt_sq-PHycOUH4Q@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rosegodwin1999[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rosegodwin1999[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
I'm Mrs. Rose Godwin, how are you doing hope you are in good health,
the Board director try to reach you on phone several times Meanwhile,
your number was not connecting. before he ask me to send you an email
to hear from you if you are fine. hoping to hear from you soonest.

Thanks,
Mrs. Rose Godwin.
