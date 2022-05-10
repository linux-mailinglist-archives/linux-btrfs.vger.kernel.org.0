Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2434D5227B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 01:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiEJXiu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 19:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiEJXit (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 19:38:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2C4A3F1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 16:38:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f4so435220iov.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pd+YoubSOrj6M4anYtA+hJWs7Xf6ingOofjFOBRQmB4=;
        b=qiPRjeAPEy7Esa7llVMbJGLsa+jpD+fAckmfN4v35Bt69KKU0vCUhZ8Y9MBesutpdy
         VFabV7/PhuMJ2+jBq2FkTUdRcGmH3t3T4jIdvpfpnLhvQgZD7U+rg9mgBd8WnVDkVb4k
         FZb7L5WKq42C4yn8jkpg5g8rsriWatpo/dtm2EOUQvVYxkYwOAImTalrEU5rvaboFhJq
         XzF8xBDtKxMaB/5OwRbCmIXrF01/ySsuB7bkqPSvusMMZNuwUsb3VMR5SBWiudB6Cr+o
         xYRWGHjx/M1P2lfAOBjZ/zUAUMVDDg85gogzGZkTW72tNXG6WohGL1Bm3RzxHs0tPC3a
         tgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pd+YoubSOrj6M4anYtA+hJWs7Xf6ingOofjFOBRQmB4=;
        b=gYq1jP2a2GDFFGAFhj8lb/xtGbEUy6nKaEtmDRONxBPLoSXf74+7TrGjyhzGRo4bLY
         en56oyg9G3mBMrMZtYssNCY/9UeiVj4r1gt+tTxkGfquHFWb5w1/Tmm7EpNIQQrcO8WY
         au0U0nYh2HQsdRr0s0reO457TC+PWG6ZQvXbxRbYkDvS+/0fuBw4z5ZU69O3kx4SmqBZ
         89R/B03aIbjTAofMGGzyOhT3XTJNoQyj9WqbhQCHSCVAgzlBStn0Rpp6iJfRIAabD3we
         pXhEpJvELup70m5U/16El0tRN1SYHbg17lp8YSMWl+Bt9BkcP2FAqIw6ekIuvF8yiryw
         haaw==
X-Gm-Message-State: AOAM531zScmFwiwrPdDyOSvS2W3B9TUb4F0UohuL1g13hALGiqcxX8Z0
        gVlmsCB+8wyfI/elZ2PIle53vpNH2fvYo6u4cbEpImXhQog=
X-Google-Smtp-Source: ABdhPJwGTd7dA/UyJhT+cS0WJ5CLqr6YG6i+7JlqNlrEMOkyM9JMs9ZWlG60bkqYxgEoUOxNQeB3iAG1znCFcrXH8x0=
X-Received: by 2002:a05:6638:30e:b0:32a:f864:e4d4 with SMTP id
 w14-20020a056638030e00b0032af864e4d4mr10587483jap.218.1652225927883; Tue, 10
 May 2022 16:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
 <20220510013201.GH29107@merlins.org> <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
 <20220510021916.GB12542@merlins.org> <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
 <20220510143739.GC12542@merlins.org> <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
 <20220510160600.GG12542@merlins.org> <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org> <20220510211507.GJ12542@merlins.org>
In-Reply-To: <20220510211507.GJ12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 10 May 2022 19:38:37 -0400
Message-ID: <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
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

On Tue, May 10, 2022 at 5:15 PM Marc MERLIN <marc@merlins.org> wrote:
>
> I have
> ./btrfs check --repair /dev/mapper/dshelf1
> on hold (^Z), waiting for your ok to proceed.
>
> All good to continue?

Hold on I'm looking at the code, I'm very confused, we shouldn't be
finding any extent tree errors at this point.  Let me work out what's
going on.  Thanks,

Josef
