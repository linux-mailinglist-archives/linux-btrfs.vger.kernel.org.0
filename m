Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4072954C670
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbiFOKp6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbiFOKp6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 06:45:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6608451585
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 03:45:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v8so1738563ljj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=hoeZ7fDl/Iq2UR3cNrsgWNoBCuOBLPWJ6iuDHqEtQmT2lq7n8IaVs4DzxZgIUN4Jmo
         r6wcyA2d1IV0nG1rZm1hg0DUFlHyoRu4FpFtxgOgAv5KJgAVyVbVlw6e8lk0jf5FDL6b
         eoZklJrf+DJP8jp/QsW0WUQGG3N3lk6p7T3K+7VL2I4DKaOAoDxRceN4SSVWqGzWWYW0
         bjedqttAkdmZo8bF9vfbLH4B/V6ezsAnWKgBd/e6LXGep6wIOQ5c5Tg3DDGddwUvuLSp
         pgx4oEQs0xCkHDhTkzBX0smZ/toI85zehAAuq9S0r3USzqJzVq0K/GqC0Oi0s4latFS+
         k3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=7/EPwLU/hDdvGOzw8T34ihStR4UPG17uCBlrpavXxGNZRY9VwiQNbMiYWAhX9B90ZR
         TiL/zmgFWGqPktuUJ0eSWLURNyK5EtWh3Y8agAtxV4z/vSBeXYwYGMJVAweC3ZHPqPVy
         qIFl67Va/PyUa6hv329+BMwP7XpyAfz0jMh2hMtbC/mku/CLrRuOY+2JSS9/IQbG4Pzj
         uCQeYXb+lqy9gCkoNXgixe7yFR/CjEcpmsCqM4WF7pyTu0ALgPCSt1yBbXCKiYfvl2vG
         4yeS9ebiauh1DsJ5CIbHtwvenraxmNU8wRZO0vZpjWFoiftBkHidod87K6ZWd5A4bVlO
         qgcQ==
X-Gm-Message-State: AJIora8yJcD8/ZGxf3QNmf5pEhXdYFt6FVDP+Hi8TqWUTbLKH6cBSBLV
        DI5rNZnx/J2sCtmklK8bmm4KAAmgnPPul9ihGtE=
X-Google-Smtp-Source: AGRyM1voEDzNOR0MfMBjCmGrcDJyCA83bbVCOXwzWxX3ptg6JpEyrbBX+b5NBVN3aV9Dii4jUal9jE4gCtMv9FsWgik=
X-Received: by 2002:a2e:9ad2:0:b0:255:99c0:3f62 with SMTP id
 p18-20020a2e9ad2000000b0025599c03f62mr5008341ljj.110.1655289955777; Wed, 15
 Jun 2022 03:45:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:25d5:b0:1ed:f113:a631 with HTTP; Wed, 15 Jun 2022
 03:45:55 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikarm <ellaali6f02@gmail.com>
Date:   Wed, 15 Jun 2022 03:45:55 -0700
Message-ID: <CAM81pMBzp4L16Qy-nzuEkCYk8eus4Ev8+0eCuqXCibcooMYQJg@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
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
