Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9693B67E8F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 16:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjA0PJ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 10:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjA0PJ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 10:09:29 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF806834AE
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 07:09:22 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id x5so4208264qti.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=YaUQe0DV+30hju6bhyepyo+PaYIMNIj0uLH2CWgxxlYTLqTXwAZ2Q0Vuu2HXihQF2x
         I54Jp2s30/IcKHtkWy8qKUstaos9T4CzVkLF6bQChZ9/Wuk0D3CTo+u3qRd4S08notId
         1xK+xm1lAlI8Yf+/heRS6stGHsn9E1N3bgw14NiccHeYwlG5KIlOaM7L2gk9yVM86yuI
         jkbSJN7NJYfsBywHWJbnBMaqi4bhpU1fH9f5ONMROSUlN42w4DLnMIVR5kdzGTCQAMf3
         UE1h3sbPBhhQ8D0TQGWHOS0NArLf0JUb/yfkSi+Dc9MZQZxB0gIiz3u2mQRpO+EG+9Vt
         xJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=BCXFXL5C1RwQ5EtwQ7R78YwWIDCGhqLFqmSB6+7Lng5fzThAl6WzHq5/NLnx0JkBS6
         gtMwymv0K8fVjWzwut2n6VJvJKpepvtEVDWWrcGuodK+0PCrW5jbM3JLU1t1UyUqyNRU
         ySfv2V4hU+67EEqX5oaHRi63hNpJ7Y5omwsSTt3iz67s6RXeTUUFrSb3Buy4dTkPfWMX
         OV+mawNkf9maoIf3Dr68Rogua6hs/ASd2seGzSq30KuV2/E123orhrG4OOgWR8asYejK
         Dr8mUabymTX4ABblLEfdjvaMwg4oKm2MUa9lIGAOsY+ZJmM4okj9obWKIcvtacdZN+PG
         tg7w==
X-Gm-Message-State: AFqh2kr7dneSaY7K1hrJ1CXZLbEb1On2mZiZvKl2ZHui4GU4P2JqQq8B
        NfDIkag6Iz2LTa609iV0zUHzFpEaY4as13d3llA=
X-Google-Smtp-Source: AMrXdXt4//0lj+BuiFqXNXaOQaxp9vQhVLEzXD0p6Xo5A4W9iirIaSIBlrL196Ejs1tOVtuSrl6PEHohqiYkfDH+yH8=
X-Received: by 2002:ac8:6684:0:b0:3af:f8ad:a4c8 with SMTP id
 d4-20020ac86684000000b003aff8ada4c8mr1918032qtp.483.1674832161947; Fri, 27
 Jan 2023 07:09:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:bc8:b0:537:7ab8:8068 with HTTP; Fri, 27 Jan 2023
 07:09:21 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   Mr Abraham <mr.abraham2021@gmail.com>
Date:   Fri, 27 Jan 2023 16:09:21 +0100
Message-ID: <CAJ2UK+akVZcoi8FMVnRdACF0p9QKnEQpErFS8KP8n3EvkKO50g@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
