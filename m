Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB7591846
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 04:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiHMCA6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 22:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiHMCA5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 22:00:57 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1B91837F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 19:00:56 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id m67so2431427vsc.12
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 19:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=LoedegDK+k2nwaRsWDZwWY9HJ1IdAdwIMTKIstwkBfKP5rsWZlBy2loxOgT1waUfbz
         0xVF5GmTfXl4jPAchXaABldl78KXKfRC7ap1771LXSt3gPgpGGLVS1eJprvW/Yxt7LhD
         d0uEupLi2krD4xYq8hK1pjg1qgsrF7MQt280ABJ1iT6MrcE8ZLSYsXDW0JCUWfUz8k9W
         dMMqgp2RTU6+FX1cjHZkWCvNwgQ1RZbf09YZQlbWPn0S1uM8r49U/yiD5mR+CvM9ubUw
         o8bkmFIyvdGytX6rYNkV4hFuvnMCLb5aWUR3ZJ89GxMHyNkx201Rt4ard8xBewi/otht
         biBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=cVw3wFQ77O8rA0sVuu9YK7JfjxmxNkznWFp5pjwQs7jkPhZ95lVov8Fzfx1Blufrqj
         yj0VT90bEOSEsHcX5CEBxRhXRa62q421Uu4J5tFgsf/A2+R/QbXVS+7c7yfUBnTNhZa2
         2Bgy9hWaoCUiCey90cgvRLfJTbvM/2RSFDp0h0Jow2huYdq1hrOcgcckcU7mZF+SIyMm
         2ehsqJz3J1ly+KFsM0V46Rj+2+NSRM/tVuLcVvHDnK2PzyE06NHqBVqabJyIBYwhrZkU
         Y65IMFd6s0EMlIsQUIsSB3qB9U4mvYS8v/IyZ7VIJRq9FL1+bpM2HqyaPQZS9uEuSAUC
         gIlw==
X-Gm-Message-State: ACgBeo0i/MLUShDopEYmVUxmA7yqxE4e2wz3fJ8sHaUKyMW3Ac6pN9Y8
        FcszrAyMkpJQ3BfefwOrUQjAR0LUUoM6L7iUzsQ=
X-Google-Smtp-Source: AA6agR7XKJ4XKZd6hVh5vfd2bXX9J8Hd75xJk2rQIp5KZLWaUkUtyqHmM4xjoHHKkOkDNxp73EFHMdkBvEDZpkRnoLU=
X-Received: by 2002:a67:cc0e:0:b0:388:9471:6d06 with SMTP id
 q14-20020a67cc0e000000b0038894716d06mr3033956vsl.16.1660356055483; Fri, 12
 Aug 2022 19:00:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:1b0b:0:b0:2de:2b7:c0a0 with HTTP; Fri, 12 Aug 2022
 19:00:55 -0700 (PDT)
Reply-To: drlisa575@gmail.com
From:   Dr lisawilliams <arsenavakov09@gmail.com>
Date:   Sat, 13 Aug 2022 04:00:55 +0200
Message-ID: <CABCg1q4vcsFzz46KBoc1nQgKMzQghqo7TMJyWGPtd-W3Sx1BwA@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [arsenavakov09[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [arsenavakov09[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [drlisa575[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks
With love
Lisa
