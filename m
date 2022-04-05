Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C117B4F4789
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbiDEVMr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442826AbiDEPiX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 11:38:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F017AB8A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 06:53:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so7121982wrg.4
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=SCb5E0xCFLL6PaOtFT2S7Y/dDJ6cROSN8SttJoMPpIHN+mI3xbeAcFyFrHQbG5JAL2
         ajPydY/adZVYEz4eKAE6mlYfSUMNCf0jI0w/esP6weIIvlgMLaXNU1H0Fay0btE4aHJ2
         pJZSkTXel79vNu+rNBZoiKEjKOcxQDK+ep1goxKU2QtaX2xNboAbcf0OYjayDCDujbQG
         2OM3W56zklkjMOsosSXh4jejSfhsJb0hVVAN8DsxuGksidWub68oTdztFjEhi9KQEgi1
         tTr9D4LYhkQaND+e+44msHyeRLCnFYJ9UxSLpykQizRzbhdYJHlZ2LI6ir99ygpEa+/W
         152Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=TZn06VB6MtikpdLwdUjQjc4nmgPwRi3/uC+LhJn/QwjCCoRBVQt8Ny+ZUE4drEh10c
         mMbELdcKRT+UjhwNeGbqUDZauvyHPMcWCmoqZl4i7brVsNjYBQzrTaiZ8yZ1Nk+vdNaf
         ed5tBh5QAdUQEe8dHfVAjvKa/eDsiN3NbIaaXymVbkIwfAE0jGvnr2RtxClAUuuP0wGI
         tfrfwgpFuPfLtQxxb34MMkt9WxKTO9DZ+rOBIl3prQ3mLyeRQ/FCGfx0yUBpemNKbTVO
         aNNWf//tC2BiT6wOyPq1K8tKHCfD0ksK+XWUrY9eLjac+DgvhUT2X5Iz+Gn/smwsoGf6
         eAnQ==
X-Gm-Message-State: AOAM533N5gLAnw/Miw7VJ+14S1PkTsBE6jJ/i2eItp6W1D7hDtFtX6CT
        sw9Y3GhQf5Lij689RQxpXtb1wnr19BR2e6Hs8Og=
X-Google-Smtp-Source: ABdhPJy93EN104gqtrY+Uz+DDdP1zqx6H6mqZtXrscGy3FqpTjjM5zxWfU9OkoaPD/r0wqnJVa1usIbVcUxjU5jo9eA=
X-Received: by 2002:adf:e7c4:0:b0:206:634:4cd6 with SMTP id
 e4-20020adfe7c4000000b0020606344cd6mr2852195wrn.118.1649166808394; Tue, 05
 Apr 2022 06:53:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7317:0:0:0:0:0 with HTTP; Tue, 5 Apr 2022 06:53:27 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikram <naissifou@gmail.com>
Date:   Tue, 5 Apr 2022 13:53:27 +0000
Message-ID: <CANSd+uUKGMM9DWw0srHeJRtLKv7wW+RLLNjsnXQZpt0Srf_Rzg@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
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
