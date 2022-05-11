Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B02A523815
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbiEKQFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 12:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344365AbiEKQF1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 12:05:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AFB1EEE2A
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 09:05:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h85so2510301iof.12
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10fVZ0Z9gBjC8xsB2k6wgM8GMdt9j/pZAYarJURUgR8=;
        b=ZqQaOEDRQzxyZ6G1dVIamACXAOyS1OCPMsZ5jdZhw2ndBj8Y+AAjDl497CUVEu76/H
         oYkUuzAtcAd+C/OGfMe6p8d2AzPaJy6SCpPAqqJ6GlPuRjNLopsxROPpN2TG/rgjRLB/
         bczBKX6+8FPRm7Cc9IA/c/F+7obhNE8nIteASk23P+3pEBcQxXZ3CrVeoK8tvBTXFLLU
         7hKPz5wk/yVmr1xHOjZTZyg9mSuxU4QfgGNw9pBqQOjlsXF2swh6eY/3RfrPAY9LO6FS
         Q1dt6Kv/KkjFq8Lc+7WOPZih6S6+tTHfxs30J4QUv3MIvV0ibKUNrAYMSWMv7WLBU7ly
         rlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10fVZ0Z9gBjC8xsB2k6wgM8GMdt9j/pZAYarJURUgR8=;
        b=4R0D8Spb3lCqZNFK9Fjj0yIY0WbzXM4zVqTAN9qkZK9i0X+NkmUoBvmrkR22kN5yuF
         v8ttcT+okHlMbztpoIRNz/RPWGYVPm47RhV4VrN3yWgi/XqEfFMjkabUGvHzSUf/QZ+r
         ovqCK85rDibk9xBrmBBcyx5ax7aVGqwJZR4OvIEiqBeTc2tyRbszNYs5xq3VD/k3Gvq+
         upAMOk5/4BtTZ7Dw1uEg2PWjZA18F1N2eH4mE9/c79wW2jjey0+0uBrbXJyayQq/Oiy9
         4mQTpegcyAPe884wGpE33YywgrMd0cT2gd8WS6V0Imda7rZWDLR+D+ckP+JypLPA5UHg
         WPRQ==
X-Gm-Message-State: AOAM530l1Voynd3Ygbb+HoZYYHh7kxt/a8S+lTDJNREeradmQXJSInaG
        gFxcDJ2zkJeN/V8OL0uQuW0kAz062uAqUSTWYodiPb5KV+Y=
X-Google-Smtp-Source: ABdhPJzFEopAQYvhDiuqQCQAXCuWSYuhVb1R5H5yiJNbE/USnaCKFlDmgM5CmPLtwH0VtAmktptXjYH3orGtrJU435w=
X-Received: by 2002:a05:6602:3429:b0:65a:a4a6:13b9 with SMTP id
 n41-20020a056602342900b0065aa4a613b9mr11613504ioz.166.1652285119411; Wed, 11
 May 2022 09:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org> <20220510211507.GJ12542@merlins.org>
 <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
 <20220511000815.GK12542@merlins.org> <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
 <20220511014827.GL12542@merlins.org> <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
 <20220511150319.GM29107@merlins.org> <CAEzrpqcT0fObDa8XFWtvzeqCKom42t5o+xE9atmFjWyHCHmb=g@mail.gmail.com>
 <20220511160009.GN12542@merlins.org>
In-Reply-To: <20220511160009.GN12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 11 May 2022 12:05:08 -0400
Message-ID: <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 11, 2022 at 12:00 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, May 11, 2022 at 11:21:37AM -0400, Josef Bacik wrote:
> > Hmm of course IDK where it's falling over, I pushed some debugging but
> > there's another method we can try if I can't figure this out.  Thanks,
>
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x564b2ca91fd0
> Checking filesystem on /dev/mapper/dshelf1
> UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
> Reinitialize checksum tree
> checksum verify failed on 42565632 wanted 0x53c18aa1 found 0xcd4368c2
> checksum verify failed on 42582016 wanted 0xc42fc10c found 0xd63d1182
> checksum verify failed on 42647552 wanted 0x10aefde4 found 0x5c5bedba
> checksum verify failed on 42680320 wanted 0x9cfe6b48 found 0xed48fcc5
> checksum verify failed on 42696704 wanted 0x005c4793 found 0x0d9de33c
> checksum verify failed on 42811392 wanted 0x2b08fbc0 found 0xf25092bb
> checksum verify failed on 42827776 wanted 0x6277c597 found 0x70d260d3
> checksum verify failed on 42844160 wanted 0xceecf694 found 0x15ab7b7c
> checksum verify failed on 42860544 wanted 0xbc48b372 found 0x99719113
> checksum verify failed on 60915712 wanted 0xb9ea7152 found 0x75dbb3c0
> checksum verify failed on 63438848 wanted 0x4cfafe67 found 0xf97194d0
> checksum verify failed on 63422464 wanted 0xcae61e1f found 0xafc5d21c
> checksum verify failed on 63946752 wanted 0xe545e347 found 0x5c2ca453
> checksum verify failed on 63881216 wanted 0x4dbaba12 found 0x843eeecc
> checksum verify failed on 63930368 wanted 0x03a5dd54 found 0x049161ac
> checksum verify failed on 76709888 wanted 0x52911556 found 0x1fbf8f99
> checksum verify failed on 76660736 wanted 0xcf5d93fa found 0x08ef5ce9
> checksum verify failed on 76677120 wanted 0xf56b664d found 0x9d0df1da
> checksum verify failed on 76726272 wanted 0x759a69db found 0xc4d2e554
> checksum verify failed on 76742656 wanted 0xe5a5401d found 0xd40609cc
> checksum verify failed on 100302848 wanted 0xb1829326 found 0xbd08c95e
> checksum verify failed on 105742336 wanted 0x26ef0666 found 0x2fa5587b
> checksum verify failed on 129449984 wanted 0x915d087e found 0x26b36e0f
> ERROR: iterate extent inodes failed
> ERROR: checksum tree refilling failed: -2
>

Ok that's what I figured, switched to the other method, lets see how
that goes.  Thanks,

Josef
