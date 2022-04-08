Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2254B4F9562
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiDHMKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiDHMKm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 08:10:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B9C6EC0
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 05:08:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r7so5340131wmq.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Apr 2022 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=o+bZT/ScG1UZyfYof9++JaSyZCLMu8Z+BEI10tFpE2kf94T2PMiiSY3x9o6VESaywd
         dTWvdIlJ4Uwb0fg5m/Du3ZhHPugghPV9fRdkUS0+ywc6bOB/Ta9SqeAENjar1qcBQ4un
         QrvcjckJQcPOeakGeFzH6h1IDinCZGrPpoKUEbbc6lFEkq5RbnE9fMm5Wv9j3y/9STrv
         cTzCfkB19dqtof3vEbVetUSWdj++zKwhR/qkq8pIy5WyX7R57yeYmg1FAM/toOBPpnZu
         rVhL+NvAql2YGCmzwyMOeuiHl0SbsYQO85kRV/P9uBuc34dZ9k64VFAW9bg9Dr4jSTII
         sJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=qrYOhw6U7Z9qLHHUwl5T6mlb0DmfQOOSGwfJVz6CyLTNTeYU1mQpQHIzBge29a4jPR
         6mo5QFzm2+FA6eZRdnotVMbUgqMeLYrFsrMGaVLqcsbX8PEpWkDltDmHQmgQVXK3FMgK
         7JrU62HOURCzlJeuv8Ys02mGMTQbwkjCjJDS718lbqZNqVqt9eqlR6qkgFv3CndMyvrN
         8TYPSZEbWOIHnbOBwSeg6Lo5D0j1z8n/Yq9jBQYq4tc7e3eBDLKmn04b3f2PjI0+KxCd
         TDgklOtYeNefA8mafbroBXy1TJjspOkZ81SZjMUMdpwSIalplhAp+dwWMvWUgFSs4DK1
         g9yw==
X-Gm-Message-State: AOAM531OpQTB9TIFKsNh5f+vJWqHk623afhOvSkV6xpEd5SSbAiJpsOD
        hTyT6CBoL2EYXWqXd/nRXIXMNRs60Rg2quQs50TAny78jF25rg==
X-Google-Smtp-Source: ABdhPJzBOGg/m3QONVnIoxWvBftBrUYGtmNdeYUFEI9T2X3GgPI4j+eKgI5QQQwYCokwCZXPzKGxdZDrgK0FuHzKlAc=
X-Received: by 2002:a7b:c013:0:b0:38e:9edd:a44c with SMTP id
 c19-20020a7bc013000000b0038e9edda44cmr3171922wmb.122.1649419712566; Fri, 08
 Apr 2022 05:08:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7317:0:0:0:0:0 with HTTP; Fri, 8 Apr 2022 05:08:32 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikram <naissifou@gmail.com>
Date:   Fri, 8 Apr 2022 12:08:32 +0000
Message-ID: <CANSd+uUbiT+_Hs-3C5pdWdpM07-qbu5+oFxY9GYyVsn0b5ovXg@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
