Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87D6C51F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 18:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCVRLp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 22 Mar 2023 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCVRLo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 13:11:44 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3DD902C
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:11:40 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id eh3so75804366edb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7O5naL/QC03iyN3hnxTSunyzGFl7TA2WgnZix5oaF0=;
        b=LuVVlnjCys7VuToa+g2pdh+QaB60VGIsBeBx77Z//XfXANKXe4OqF/BbTgnYa0uahU
         nvOI8aI5RXU851tthfHUiXpsa8ZhI7Opqx05SWy3H+4J5t541ulEjDrGb8xOhpMfEhRI
         qvDT9dyu2r6vYeEVM1hTl2t1WOEmFjlbs8niIuYG6LEcmP9jDVjZyfn94+IamR5DgK/q
         GYqgNulJrd8BeyYsKc5i4mK3QkqoeHoyb2JxBrvTDar/4eZ0o3B5XqtF9mr2mwvQgwXd
         fDTqhOjwgZ8rLS1wEsIcx6W+XRXWKgz+owpyLUsCgtCH6GoGjeeM04PMqxyMebgBf3Pl
         Kh2A==
X-Gm-Message-State: AO0yUKX2JC1hnz1D/pv1QCtvUtvvJmE5L2/l+8pSi6eWkA6ZHnVe3ZlG
        X2M8JS9IzeCg/6RBF+9/RTiEa3h7y6VTmTr+
X-Google-Smtp-Source: AK7set/nTuotOqSNii64R+oekOwFDFEBu7wNHckVThy3qJ10WRtVPE0xZLnU4tzYpQj0Y6VWJRBakA==
X-Received: by 2002:a17:906:2505:b0:932:9502:4fd1 with SMTP id i5-20020a170906250500b0093295024fd1mr7659823ejb.43.1679505098842;
        Wed, 22 Mar 2023 10:11:38 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id fi9-20020a170906da0900b00931faf03db0sm7186265ejb.27.2023.03.22.10.11.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:11:38 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id eg48so75716650edb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:11:38 -0700 (PDT)
X-Received: by 2002:a50:9995:0:b0:4fa:3c0b:74b with SMTP id
 m21-20020a509995000000b004fa3c0b074bmr3925387edb.3.1679505098079; Wed, 22 Mar
 2023 10:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230321180610.2620012-1-neal@gompa.dev> <20230322143338.GB2169647@perftesting>
In-Reply-To: <20230322143338.GB2169647@perftesting>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 22 Mar 2023 13:11:01 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_YvwLSgx-WNmMQTh2EzOn+HYFbBYzhcBygM1UPSrSwew@mail.gmail.com>
Message-ID: <CAEg-Je_YvwLSgx-WNmMQTh2EzOn+HYFbBYzhcBygM1UPSrSwew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] Enforce 4k sectorize by default for mkfs
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.cz>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Davide Cavalca <davide@cavalca.name>,
        Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
        Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 22, 2023 at 10:33 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Mar 21, 2023 at 02:06:09PM -0400, Neal Gompa wrote:
> > The Fedora Asahi SIG[0] is working on bringing up support for
> > Apple Silicon Macintosh computers through the Asahi Fedora Remix[1].
> >
> > Apple Silicon Macs are unusual in that they currently require 16k
> > page sizes, which means that the current default for mkfs.btrfs(8)
> > makes a filesystem that is unreadable on x86 PCs and most other ARM
> > PCs.
> >
> > Soon, this will be even more of a problem within Apple Silicon Macs
> > as Asahi Lina is working on 4k support to enable x86 emulation[2]
> > and since Linux does not support dynamically switching page sizes at
> > runtime, users will likely regularly switch back and forth depending
> > on their needs.
> >
> > Thus, I'd like to see us finally make the switchover to 4k sectorsize
> > for new filesystems by default, regardless of page size.
> >
> > The initial test run by Hector Martin[3] at request of Qu Wenruo
> > looks promising[4], and I hope we can get this to land upstream soon.
> >
> > This is an update on the initial RFC patch[5], which addresses the
> > documentation feedback from Anand Jain.
> >
> > [0]: https://fedoraproject.org/wiki/SIGs/Asahi
> > [1]: https://asahi-fedora-remix.org/
> > [2]: https://vt.social/@lina/110060963422545117
> > [3]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#m11d7939de96c43b3a7cdabc7c568d8bcafc7ca83
> > [4]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#mf382b78a8122b0cb82147a536c85b6a9098a2895
> > [5]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#t
> >
>
> This all looks good to me, you can add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> I've got a mac studio on the way, I'll add this to our CI testing to make sure
> we've got good coverage of this code going forward.  Thanks,
>

Since we've got three Reviewed-by tags (you, Qu, and Anand), do I need
to send another version of this to land or can this land as-is?

-- 
真実はいつも一つ！/ Always, there's only one truth!
