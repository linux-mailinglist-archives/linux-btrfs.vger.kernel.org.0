Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAE77A286
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Aug 2023 22:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjHLUgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Aug 2023 16:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHLUgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Aug 2023 16:36:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4027100
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Aug 2023 13:36:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bcf2de59cso407309666b.0
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Aug 2023 13:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691872599; x=1692477399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mof/hffZLA4KI3hKPptzkGvwOjVO9DAGejVCTyTJPQ=;
        b=TwSNg/pt00lgCC3g3V82CeM8l16mFh4SbmdIz+e2rlF90cPhNAiMFpsLPtJ1Rhh2Wc
         egJfYZdolKKK4nWpElFpeIupolJRA8MHPTDYkuQV5ekCguMDVW0E5YR+YXxPTb1NXUDw
         SHjY0rre/0p0fTi0wjcM4Graed7sV7o0orGgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691872599; x=1692477399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Mof/hffZLA4KI3hKPptzkGvwOjVO9DAGejVCTyTJPQ=;
        b=EGEIGpq5c5Ki4B/M8GRnLQtYTFrHaddNmQXnBEreyyYKVnW46sbkxw5Fz4sJoERj3T
         8XWn4YUdsfnv1abkzswfadR8lzlmvCxeMe0VI42053Ybo9lGy8YKkIt0CabFoEGbdXIv
         QmSdFm0dlhd8tM0J/E/5BOP1fimrStsGfAtgGxP0XFu9xPCqOQICHvdzGxRY0syzuMjK
         T2WQzJG68xipvoLW5NZgAUkspr6sxIfqeiBJWsPu2wWJf7GrMmE7tX+RsK4AZdqfVHBg
         B4UjktL9MLJ0HiB8R/X5NIXhjDeOI9rrXYZHZSWPpgWb9rYZf9HC5dsYmwt2lgup1zRy
         JXUQ==
X-Gm-Message-State: AOJu0YwCnOCh4gK9ZCcxZV70dcrqizyGGC3ALLz/CfNqz5HQi/LLOYdR
        oB8y0BEm0YrvQ/V3RgGzt0ryJ1VVNcJcaZeSFM80DcLX
X-Google-Smtp-Source: AGHT+IEHnm22Tw7AcHSWGBvvB8WZSbK7OKOjeEKb7uZezYOO/Jatukff3SsPVi0xNyfnMfPgSEeAgA==
X-Received: by 2002:a17:906:3f14:b0:99b:4ed4:5527 with SMTP id c20-20020a1709063f1400b0099b4ed45527mr3885159ejj.25.1691872599165;
        Sat, 12 Aug 2023 13:36:39 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id kb15-20020a1709070f8f00b0099364d9f0e2sm3813229ejc.98.2023.08.12.13.36.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 13:36:38 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso2736400f8f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Aug 2023 13:36:38 -0700 (PDT)
X-Received: by 2002:adf:f488:0:b0:319:664a:aff5 with SMTP id
 l8-20020adff488000000b00319664aaff5mr2050063wro.37.1691872598235; Sat, 12 Aug
 2023 13:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691865526.git.dsterba@suse.com>
In-Reply-To: <cover.1691865526.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Aug 2023 13:36:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBQ2dEE2Dsq6XOxsxnSPEiV8jjx7HxaTHKP59dd+9JHA@mail.gmail.com>
Message-ID: <CAHk-=whBQ2dEE2Dsq6XOxsxnSPEiV8jjx7HxaTHKP59dd+9JHA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.5-rc6
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 12 Aug 2023 at 12:20, David Sterba <dsterba@suse.com> wrote:
>
> - space caching hangs fixes to progress stracking, found by test
>   generic/475

I can not parse that sentence. Part of it seems to be just a typo
"stracking", but even with that fixed it just doesn't parse to me.

I tried to make sense of the commit and edited the message to be at
least a bit more legible. Maybe.

              Linus
