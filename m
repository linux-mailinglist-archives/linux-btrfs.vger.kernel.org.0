Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAEC4F1E73
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 00:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbiDDWE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 18:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376862AbiDDV5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 17:57:53 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757A3EF27
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 14:40:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z6so13062640iot.0
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ngk6ZGm3bba64uAcSwOnWS9CaRUUMj2oD2NBg/8uTWI=;
        b=Av1EF+PMYgFiWoPosi1Vmg44lIm8od/cy6vhnrA4UbSsFBnAxqan2RnVY4/9LNS6NP
         3906s4nD4x4/97ADfrfr55jXedwKquf+xVqzhrluwuMt1AkqpQtL1Ez+CpEz1G5gcjW/
         Jd6wOqF0GbEGnmK1qCVYCTfqUbs4vpaWhR93fKOsAHmdViPramlSJIKKTFZWFVxFeHfv
         4YiJt3LLAJJjcnqDzzUCvJB0APqXX9rqvvHdf4A3nQk/rda05lHjA2iFpuSODbTM0JIH
         akiJfC4PUTf5EreSwiOb+BCqQgKRExpYJmVrm0WIW0XDzCP7xOtzijx1Az0OCe2Szm8K
         y2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ngk6ZGm3bba64uAcSwOnWS9CaRUUMj2oD2NBg/8uTWI=;
        b=KZxeAzulSe7LFg3VhQ8j9oswLHmoUeUZ7FMaKcoY2lhR7udInom9FPu8MK93gtGTQm
         fi5YL+wqElVhxKUpNax2lYT8iXGPzW4zN9nxOOV0UabTBXfyP1Z5f/v5yRw1KmCXl8pE
         vI69rjXNMEblx/J738rtozUYX45WqRDdl5PFnR1YnhgO0HBtWntm0orSRu1Lg0W6wLIL
         aoTj3vZM9TsJ2r04qGh897TfG3qr/sgf1F5GXTvrZMjcRnDWFuKWoyWlh4bDaLYo67t3
         5DCtetenpJLmLOCIfP/NKqj8k78HLJRB4HWQnWWK9dcpTs4stcxh4luVrLchBFWKPY4U
         sFPQ==
X-Gm-Message-State: AOAM530P4VBrX5f1482hEF0iJ1DHO/GYT43RkmjsCX4wO2QpAv9l1+Ol
        nM8ypiVpEtNrPUmJpCG2H4azOzWkj87iQTEKgLT33Q==
X-Google-Smtp-Source: ABdhPJykOsJPoAB1M4oPf93eBsZJsubmuu6F2x0m5i3cqh7/tlh3Qf37iqauG70HVY8e9lcVDkKVD3Dy/hRoPC8cUdk=
X-Received: by 2002:a05:6602:168b:b0:646:3bbb:7db4 with SMTP id
 s11-20020a056602168b00b006463bbb7db4mr158345iow.134.1649108425014; Mon, 04
 Apr 2022 14:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220404150858.GS1314726@merlins.org> <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
 <20220404174357.GT1314726@merlins.org> <CAEzrpqc7P7pxkdSw8eS-nCkn1h5ztQC7C=MewJdmT6Mr5OJX-A@mail.gmail.com>
 <20220404181055.GW1314726@merlins.org> <CAEzrpqfA94nYjV=o_4+XRitopVT-3j7iQMaXAr3FE3Rfm32gkA@mail.gmail.com>
 <20220404190403.GY1314726@merlins.org> <CAEzrpqeMPQvtoov=7Lv5Kx8-cgOmRFFYLbuh0QxZ6psQN3RDeA@mail.gmail.com>
 <20220404203333.GZ1314726@merlins.org> <CAEzrpqdmKwdZxzu7EBhp-PgZW+vqNaUm51SRrKAe64N3pN2rnw@mail.gmail.com>
 <20220404212951.GG14158@merlins.org>
In-Reply-To: <20220404212951.GG14158@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 17:40:14 -0400
Message-ID: <CAEzrpqemPHLN4gp5TdLQDGkUZSOkRFHHFiHEraZDNSTDjCh4=Q@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 4, 2022 at 5:29 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 05:04:52PM -0400, Josef Bacik wrote:
> > On Mon, Apr 4, 2022 at 4:33 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, Apr 04, 2022 at 03:52:15PM -0400, Josef Bacik wrote:
> > > > Can you build a recent btrfs-progs from git?  We chucked that error
> > > > apparently and I can't figure out where it's complaining.  Thanks,
> > >
> > > Sure, here's git master
> > >
> >
> > Alright we've entered the "Josef throws code at the problem" portion
> > of the event.
>
> thanks :)
>
> > git clone https://github.com/josefbacik/btrfs-progs.git
> > git checkout for-marc
> > <build>
> > re-run fsck
> >
> > I wonder if the tree root is fucked and that's why it's not finding
> > the device tree.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# git remote -v
> origin  https://github.com/josefbacik/btrfs-progs.git (fetch)
> origin  https://github.com/josefbacik/btrfs-progs.git (push)
> gargamel:/var/local/src/btrfs-progs-josefbacik# git branch
> * for-marc
>   master
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs --version
> btrfs-progs v5.16.2

Ok cool, lets do

./btrfs check -r 13577779511296 /dev/mapper/dshelf1a
./btrfs check -r 13577821667328 /dev/mapper/dshelf1a
./btrfs check -r 13577775284224 /dev/mapper/dshelf1a

and see what those say, it looks like the tree root is stale and can't
find the root pointers for anything.  Thanks,

Josef
