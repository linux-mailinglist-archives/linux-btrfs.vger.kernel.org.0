Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C8534421
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbiEYTQ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344598AbiEYTPE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 15:15:04 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065812AD4
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 12:13:36 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id bj35so5557131vkb.10
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=d3ClJ/u2CoIHw5+4kQ9KZ+xrXgd2DmJWYzKGUyj8RDWsQ+ns1HEHuKJDGfZ8s3pLk+
         WP4pny22UPXFPj73wvRy+CKnPhXlKkXClAcVTvlLqnSzH6N+6TJI8KUCZJz5jVixW7Tj
         FqWfZqgwwg0VYhhEHSMGbQceeQjgs0a2lGw1G9XyZ0Fp10lBdxZwuAEao1XPnqNfO9hO
         NdYOGp91u4l7I5MTcpCEJMIVkNTq56YEP3yk36uP0Ny/GVNcWTHwAzFlgId/YqnTKqNE
         hCUnWbeC931wKgxIUxe67nRixuHa4S1k6wU2YPvEMzsDFP3EqlCbXCPt08+UckBmDUmE
         6ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=LifUppnE50uR8RMCbOfskwByEQqkRmj84cbeO0ovglRqQvqynwTQoBpni+FhfZ1eWd
         B3/zYqqCfI3hBtBPhgOceF3FFSEMWCj26bPZ2rpnJAlpA4JHzX/qzjUUHA1lIC8/J8jc
         6psLQELt3a9nV9iofcRMtzm99F3xeV7eHZXBiyTvCqWLU65gjXpJvPFpMYpxE5lqlcGu
         L1Fs0CPUbrk8KQ1lZEFq0bv2SLyOBSM03Ef6JCrgmzE+3YVLQpASuYue+dk02iuXO/Qh
         EPEJra0j8XRdG1AuXV78YIHKMkH7MlalomxJf3O9md+fupnaREjTKHNDQlL42kkSs+v7
         hqwQ==
X-Gm-Message-State: AOAM530CC4dl0M63JqXcwFSHp3SV+4zAdVDV0Y+UMjP9+1wtnCZBZ61K
        DoQJmWVmgugrFk4lgRxiQALNpnYnwKRF+tE0/ic=
X-Google-Smtp-Source: ABdhPJyv0nYVXluxAdv23CeEFPbn1AwxAcSuUYAxZA5vu2FglbV7tZ1FTPHmIjSTA6EsBPWfKKe7hGnnQ86yX1OOgiU=
X-Received: by 2002:a1f:988e:0:b0:357:6a07:3ef8 with SMTP id
 a136-20020a1f988e000000b003576a073ef8mr9082621vke.29.1653506016133; Wed, 25
 May 2022 12:13:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d484:0:b0:2bc:cae4:6d22 with HTTP; Wed, 25 May 2022
 12:13:35 -0700 (PDT)
From:   Rolf Benra <olfbenra@gmail.com>
Date:   Wed, 25 May 2022 21:13:35 +0200
Message-ID: <CA+z==VthtWgu_g2TFzVizk-M8Xas8f3ttAb+kg9vB4WDkUmPZA@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Rolf Benra

olfbenra@gmail.com







----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Rolf Benra

olfbenra@gmail.com
