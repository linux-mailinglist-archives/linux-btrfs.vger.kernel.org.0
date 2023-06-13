Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553CF72D733
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 03:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjFMByj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 21:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjFMByh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 21:54:37 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85ABE78
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 18:54:35 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-558b70c715cso2633881eaf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686621275; x=1689213275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMTKRNdq3QUMDtR8o1M2LhEkTROu/jkd2i5oCX4Yq+o=;
        b=Fc7H259vIOC9+VAjTCjR/aZPKpwVKMoP89WIXFGL1QPsTpvSJ5OgBiwivIMX/2Oqig
         mxwCStiEcZbnTFt/W4Iu2B1MAFvamkEiWQ5KgPTM4FfcgaxFoOTpMkXHqqvgZvUP4wG6
         PqUnSa/ptySYzSGXTs+//4nnR6jKqhu5xGX0JC77UV4IHI1CcQ2CzCE9KJpsw+4Orehs
         KYz7sJPkpRsEOyVSVuM/uyzpiiMeXtCWD0rud+4ex8GHSZN+CYsPzI+MadhE2ntSSmoe
         8qcGa9pPVQzjAG5rexhcWUDijAONJKSjAcGDThiFEH84sWXq+NLSojOSma6MXDXU3eoI
         pU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686621275; x=1689213275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMTKRNdq3QUMDtR8o1M2LhEkTROu/jkd2i5oCX4Yq+o=;
        b=hT9XWgK9Ql8turJXB7OecnxTwzau9TNzRu7aw5c7A4kq0qEmn79uTa07Kj9ac5/TK0
         K/XsOxkD62Ek5htZQCXe+dUC/7WeMUQdqj+3YrmcNFSh3VjT0/C/4mA5YN+DKgDaVOKk
         7vwBk7lAGvK73dRjmmmwvLW1FQwzDo2wq8Xtqs/aW3tbuyC8K8VKHsDNcm89J+/X9Kh2
         knVZjshOaAg9Rh9EVsGGhLfJLNwS6uykQ8adovOJkZ1U4xmp4td0LIjagoih8zfTngWS
         qtjAGHU2ys2Uaqd4sMkFlLqERGwFdr2kVAlkafLQlMyU2b+x1PKXJla0V2w3NVBElag7
         2hLw==
X-Gm-Message-State: AC+VfDzhMPFD+d5V2yjjlZTH6XA3eR1SKAF62Zd/TaK6aLKeDDT9HHLT
        GHJ7De0KXy19YGrLCxf4qhnnUUSbe7GNmS//YCg=
X-Google-Smtp-Source: ACHHUZ5sSpxN7PRmMaH53h9geILupz3/Jin59OUWf1Hbvues65wchTdNtOU+xr0ZpcZIOJ0yBoQW6Qd/nGY/OyNsy6Y=
X-Received: by 2002:a4a:bb16:0:b0:558:a32c:41f6 with SMTP id
 f22-20020a4abb16000000b00558a32c41f6mr6139001oop.4.1686621274712; Mon, 12 Jun
 2023 18:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com> <CA+W5K0ow+95pWnzam8N6=c5Ff61ZeHyv7_yDK0LG6ujU48=yBA@mail.gmail.com>
 <40ecba88-9de2-7315-4ac5-e3eb892aac39@gmx.com> <CA+W5K0qLN3SaqQ242Jerp_fiyBw407e2h_BEA9rQ45HU-TfaZA@mail.gmail.com>
 <SYCPR01MB46856D101B81641A6CE21FB99E55A@SYCPR01MB4685.ausprd01.prod.outlook.com>
In-Reply-To: <SYCPR01MB46856D101B81641A6CE21FB99E55A@SYCPR01MB4685.ausprd01.prod.outlook.com>
From:   Stefan N <stefannnau@gmail.com>
Date:   Tue, 13 Jun 2023 11:24:23 +0930
Message-ID: <CA+W5K0oKO2Vxu3D2jOLET1RrM=wOxTEH2a_uH1w44H2x9kT2tQ@mail.gmail.com>
Subject: Re: Out of space loop: skip_balance not working
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Paul,

Thanks for the suggestion, I've had similar success in the past, but
unfortunately not this time.

I'm guessing this is because the metadata is full rather than the data.

If I do `mount && btrfs dev add` as a single command on a small loop
device it still doesn't perform in time before it turns to read only.
The same goes if I try to rm, truncate, btrfs fi sync or btrfs
balance.

- Stefan

On Tue, 13 Jun 2023 at 10:59, Paul Jones <paul@pauljones.id.au> wrote:
>
>
> > -----Original Message-----
> > From: Stefan N <stefannnau@gmail.com>
> > Sent: Monday, June 12, 2023 11:03 PM
> > To: Qu Wenruo <quwenruo.btrfs@gmx.com>
> > Cc: linux-btrfs@vger.kernel.org
> > Subject: Re: Out of space loop: skip_balance not working
> >
> > On Mon, 12 Jun 2023 at 20:16, Qu Wenruo <quwenruo.btrfs@gmx.com>
> > wrote:
> > > > I've tried using the latest ubuntu livecd which has btrfs-progs v6.=
2
> > > > on kernel 6.20.0-20
> > >
> > > I guess you mean 6.2?
> >
> > Sorry yes kernel 6.2.0-20 (Ubuntu)
> >
> > > In v6.2 kernel Josef introduced a new mechanism called
> > FLUSH_EMERGENCY
> > > to try our best to squish out any extra metadata space.
> > >
> > > If that doesn't work, I'm running out of ideas.
> >
> > How do I go about forcing this to engage? Currently the array never sta=
ys in
> > write mode long enough to do anything, so I'd need to trigger something
> > immediately after mount to have a chance that it syncs before it goes i=
nto
> > read only mode.
> >
> > > > BTRFS info (device sdi: state A): space_info total=3D83530612736,
> > > > used=3D82789154816, pinned=3D245710848, reserved=3D495747072,
> > > > may_use=3D130809856, readonly=3D0 zone_unusable=3D0
> > >
> > > The big concern here is, we have hundreds of MiBs for
> > > pinned/reserved/may_use.
> > >
> > > Which looks too large.
> > >
> > > My concern is either free space tree or extent tree updates are takin=
g
> > > too much space.
> > >
> > > Have you tried to cancel the balance and sync? That doesn't work eith=
er?
> >
> > The balance cancels ok, and there's no sync running except the auto UUI=
D
> > tree check on mount.
> >
> > > Considering you have quite some data space left, you may want to
> > > migrate to space cache v1.
> > > Unlike v2 cache, v1 cache only takes data space, thus may squish out
> > > some precious metadata space.
> >
> > From the 'disk space caching is enabled' in the log it must still be us=
ing space
> > cache v1, and forcing it as a flag doesn't appear to change anything.
> >
> > With many remount cycles, the best I've been able to achieve has been t=
o rm
> > some small files, but they never synced and were back in btrfs on remou=
nt.
> >
> > I'm running out of ideas, and given the size I really don't want to hav=
e to
> > replace/rebuild if I can help it!
> >
> > Any other ideas would be greatly appreciated
>
>
> When I've had similar issues in the past I've managed to create some spac=
e by adding a usb drive (or two) to the filesystem, which then gives enough=
 of a buffer to remove some files, and when btrfs will let you remove the e=
xtra drive you know everything is back under control.
>
> Paul.
