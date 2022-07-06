Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27F4568333
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiGFJN3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiGFJMY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 05:12:24 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31C26130
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 02:09:23 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31c89111f23so83166437b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Jul 2022 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7hVcaC+MRvkcFo3ZUAR8p07gKObiOutR9wHDxg/W1U=;
        b=Ce3mLF4HG/v4vF7D1N6wKhReT+A8J30UypayQ7+KUZ0zfxNesgaAgtgNFXRda/HtW+
         CLsh0nQruXwG4z4TuftjoiQepHlSiC4WWgqA9sy01wn+Ih3PDAtrZFiN0Z2k1ky6Eeru
         linJmStkHrRCBguhA3cWHCOcytrdihrPIpN8uL2R1ReG88FQd/SQXIuDTr5Mj1/Yz5Om
         EH5HN+Qqc8HZN9iWSZhKbRY4FLz6SWKE21vGS3aHkGdGSBrxZGBceHaTkrZf0KUj6d/7
         PYdRmNFf0CYaadpa/9WT3SeF0O4ewE5fFy0qJsSG5OdlaUQ7Dtk7ulfClid34yCWmPvX
         jkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7hVcaC+MRvkcFo3ZUAR8p07gKObiOutR9wHDxg/W1U=;
        b=oef6FIXZYcAMBuAZVoBtQCh8Tv9askFLsSMbXgu6jIXFJXpgZLGr8YOZfpTYFhYLVy
         GRKAtBA8PKz2baiBAZ3RUoKu5QTneomWlqtQ1C+zEuhhH3IAfas845NbRuh8jKSi0KiH
         LkmXpOEahh5PzF3jpyAJu+ze7imeyX87crbUIr+/uYq0YR37mv1ONzOK3uv2iWWLPJsX
         E5RaLcidxwwizoRlAzbvVaUM7mJCBGT0hCcU8TS78eBx5O5mZs3XZllB+Vj+lVPn9aTG
         fKOI1xnEqIHjGJOOgexR+V4gcR8ba9KF5Pf/PmLs7DzokWyMdDSbIPRc4Ato+/uz3S3F
         TRSg==
X-Gm-Message-State: AJIora/D/8flu2TsWYr1Wk2QdKRK2A1bi20Mslq7ERtswVMrePY/LCwY
        GJkxiQ9zq4Cjl5yAgDPtz3lnHAkuTtpu8C8MfV4=
X-Google-Smtp-Source: AGRyM1uAUv1YXSoAp1BHbGAaHenMblC5Jm+72YY46+Np1LlXJUxagagOvxDgIjZvP2Zz+VXOd1VkarScjN5vCCkpYPI=
X-Received: by 2002:a81:6384:0:b0:317:e066:caf4 with SMTP id
 x126-20020a816384000000b00317e066caf4mr44079100ywb.180.1657098562869; Wed, 06
 Jul 2022 02:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220611143033.56ffa6af@nvm> <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
 <20220611145259.GF1664812@merlins.org> <CAK-xaQa0n8q9Fc5-t-pJfu4yrwO28A7dzEOgytzedbhL3N3v-A@mail.gmail.com>
 <YrFWb52k5wu1L0cg@hungrycats.org>
In-Reply-To: <YrFWb52k5wu1L0cg@hungrycats.org>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Wed, 6 Jul 2022 11:09:06 +0200
Message-ID: <CAK-xaQbO_k=sN=XC=cQCLj_+ERBpg8Tt2EFipeTgd1iBJt+5Fg@mail.gmail.com>
Subject: Re: Suggestions for building new 44TB Raid5 array
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Marc MERLIN <marc@merlins.org>, Roman Mamedov <rm@romanrm.net>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
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

Il giorno mar 21 giu 2022 alle ore 07:26 Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> ha scritto:
> How many years ago was this?  There's no such limit today.  Here is a
> 500TB LV with 4TB of cache:
Good to know, thanks!

> There is a limit on metadata size, but you can override it in lvm.conf.
> Presumably if you have a 100TB+ filesystem, you also have enough RAM lying
> around to make the metadata size larger (it's 2.8GB at chunk size 128,
> but that's not unreasonable for 4096GB of cache).

Yeap. We have at least 48GB of RAM on each server.
Well, I use them all to run beesd on night (tweaked the sources)
Fun part, I found this project:
https://github.com/pkolaczk/fclones

It's a recent(!) file-based deduplicator in Rust, with parallelism on
every stages, hard/soft liks and range clones.
Perfect for my needs and blazing fast.

Ciao,
Gelma
