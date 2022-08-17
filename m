Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1959697E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 08:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiHQGWB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 02:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiHQGVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 02:21:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93141816A7
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 23:21:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-333b049f231so95145027b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 23:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XSW3a6/qCETHJDXL4AEHODGZYgOgIVpuEP1op1hs25g=;
        b=YNlDbS5OGrkQaUdyUyLytUlaNN+TTbF7VaVKKXZ8tN+7wpgV9mdphKb5YWqyoyTJiq
         3le+y1XOsIV3GDsOPGM+KO/ne6Dz1ouQ7yWoiPnDgqH9MwsMk93CR7z6fT0BKYM62d53
         IKC7r4bSmYTcCekP/qWlxuGXMxWJZ7ss8dAQ5YhQTYPaAKCef1TiqqjMWReidL8Pd3ID
         P6s1SLP/AIEQNIKbKWamclKs3KTKVTodugE6w/fSFUNyhIw0cmeXX5sFiyyQ7jE+z9yu
         cblH/rgPdShycY+rbGEIcwJ6VHBO61n8ebuOGbW+HjJc2B6w38PV/PNoqhmtX27eWPvr
         zsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XSW3a6/qCETHJDXL4AEHODGZYgOgIVpuEP1op1hs25g=;
        b=ZwwEuIUY513t2gCBekQHvK95aCWZpkfMZucMI/brzlagdPkMRwiQBjkSoWSjOqXx0c
         YssXZmLuGGMDPOS7bTqntiVqWghZBgdFwsTc5SL5+w8RpysprVSa3v53Z6fi888SdCrG
         7UlIPq5ZBwqJGlenSdlPSWTlr2khf/1TZS9jxnbYaVOdgC7IwClu4blgHt+DS0LLtgB1
         H7ChPT9OgV8J/7m3JzXnQsv7Q4eZAxdQhbYGu/NKXIASyAa6RqQ2zQGnF1iTLhLT/Oca
         ee6qMY2OWyDN6gjhQIgrS/rWh3Df02bcRj17EHEFO+gUO6BVT0F1asfKULxUzM5ZPYwR
         Z2Zw==
X-Gm-Message-State: ACgBeo2yVVAPPJnxLuu2rpQw/CtCS1eokASn6zzkusM6SpywTK5GWAvd
        e0Jy68eaIyaOoXq/0dZQ1mGe9MIEBvbdGDAJFHo=
X-Google-Smtp-Source: AA6agR7f1UxvOOQOFZxlX90rqXjZ4n4QlL2iX7Vhx4o6KU4xxUlTED5pOxPMmS45DToAibk9duU/bZoPt2SIz3M/P68=
X-Received: by 2002:a25:acd0:0:b0:683:e975:8b52 with SMTP id
 x16-20020a25acd0000000b00683e9758b52mr16475824ybd.201.1660717299881; Tue, 16
 Aug 2022 23:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660690698.git.osandov@fb.com> <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
In-Reply-To: <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Wed, 17 Aug 2022 08:21:23 +0200
Message-ID: <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno mer 17 ago 2022 alle ore 01:22 Omar Sandoval
<osandov@osandov.com> ha scritto:
> * If we don't catch this free space tree corruption, it will continue
>   to get worse as extents are deleted and reallocated.

Is it possible to detect this by scrub?
I have a few >100TB storage, and comparing file by file with backup
could take months.

Using compression and snapshots is worse/better, or  there are no difference?

Thanks a lot for your work,
Gelma
