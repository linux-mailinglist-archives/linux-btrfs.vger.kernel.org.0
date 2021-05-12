Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9BF37B826
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhELIht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 04:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230253AbhELIhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 04:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620808600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cH1mWDW+mRnwUiYky9bRjxkEGsB5IdUECk0W6mrBba8=;
        b=QEPvxQ02zidzuKDkeM8/HbcL/qzooDfLE1W1DEpg58vZCvqUU965F6+yvpsU+E/Dhl/QPH
        aclkGlBGzGjs1K2WbCHc3RwRsSC46Nh+oWrFcpg6gHz2l8G8V5cNQEVxIL29fE+F5+cISj
        t4/EiXXoV/U1Z17T85HdFe2kOeAnMWo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-ZRYviorIOQ2e7kZA6xaBnw-1; Wed, 12 May 2021 04:36:37 -0400
X-MC-Unique: ZRYviorIOQ2e7kZA6xaBnw-1
Received: by mail-wr1-f70.google.com with SMTP id 91-20020adf94640000b029010b019075afso9807742wrq.17
        for <linux-btrfs@vger.kernel.org>; Wed, 12 May 2021 01:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cH1mWDW+mRnwUiYky9bRjxkEGsB5IdUECk0W6mrBba8=;
        b=srJT2Fe/oJFg1bIvPShttz62XGrHjbrk/yano4caLewkOYJf+8AMoalofqs2MdB13m
         xyJr1ayJtzfLwpvr662mFNDcQvPzgY4QLUQaJirvX6+1J+GKQ62+6xTjZyJh9wHQIgpx
         Mp+7YPCpJ8KSgl31nTMrpewo7yyGO9lNmFmrTxpN186KuBSIQjJAdQdVHvcjpOFQxJEd
         FcXR4UM0+unauKBu5yz4ehmrt92lgkssb/YWF1SPFNKRtD+ZkUTQaBFTWqG4e9xcxZ9E
         ppHoV9B28o0ZqzP99/qvKTcJq/lCGc3VkdXtWeMyWd8dvwDoCtzotFQYCURVvBV52zRt
         xVzQ==
X-Gm-Message-State: AOAM533y14sBqh4x9FB2aymu4cmwT6CqIUXNGaF56J8vz6JGOOKwzt8f
        Dhgzh06/YfpOpfe/nEtj05Y5k7siZF+lkxELfWYqa+q+5gvZCEtaGC4054w3beUygFXpWfH9MaT
        j+H6mGl/KsgBE3Z+09yvX5LICjmxzKsTEicBZa8o=
X-Received: by 2002:a1c:3183:: with SMTP id x125mr10244032wmx.80.1620808596757;
        Wed, 12 May 2021 01:36:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF5iBiEVxH+UKYpaPLaLvjtSX/Ckw9aBwV9TuA3QogNvkqzTIiQHo0kvHmqmLXmlBHEGcr/gyp1zv4qcvaIAU=
X-Received: by 2002:a1c:3183:: with SMTP id x125mr10244013wmx.80.1620808596569;
 Wed, 12 May 2021 01:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je-s+9qZYFgqheW991EgUjA7OAUBM3+LvJB6px4hc15J+w@mail.gmail.com>
 <CAJ2r3Z3wKvomfW8N32KEPFuH=VTf7LCjuPVTE87=ROkZjj4fkQ@mail.gmail.com>
In-Reply-To: <CAJ2r3Z3wKvomfW8N32KEPFuH=VTf7LCjuPVTE87=ROkZjj4fkQ@mail.gmail.com>
From:   Tomas Tomecek <ttomecek@redhat.com>
Date:   Wed, 12 May 2021 10:36:25 +0200
Message-ID: <CALJ-GUC-1Qd248eD8KGmNsrwk_OrV3-tWGuLGk1LQ3twkPBz9Q@mail.gmail.com>
Subject: Re: Fedora CI for btrfs-progs? (was Btrfs progs release 5.12)
To:     Aleksandra Fedorova <alpha@bookwar.info>
Cc:     Neal Gompa <ngompa13@gmail.com>, David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Davide Cavalca <dcavalca@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Continuous Integration and Continuous Delivery for
         Fedora <ci@lists.fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi! Aleksandra, thanks for the ping.

This is correct, packit project provides capabilities similar to
Fedora CI directly in your upstream repository - via tight GitHub
integration. The builds are happening in Fedora COPR and tests are
running in fresh VMs on AWS: you can have fedora stable, rawhide,
epel, centos-stream.

Here is a guide how to start: https://packit.dev/docs/packit-as-a-service/

We hang out in #packit freenode channel and are happy to help you to
set things up.


Cheers,

Tomas

On Tue, May 11, 2021 at 4:09 PM Aleksandra Fedorova <alpha@bookwar.info> wrote:
>
> Hi, Neal,
>
> On Mon, May 10, 2021 at 8:50 PM Neal Gompa <ngompa13@gmail.com> wrote:
> >
> > On Mon, May 10, 2021 at 11:04 AM David Sterba <dsterba@suse.com> wrote:
> > >
> > > Hi,
> > >
> > > btrfs-progs version 5.12 have been released.
> > >
> > > Notable things:
> > >
> > [...]
> > >
> > > * travis-ci integration has been disabled, I'd like to find another hosted CI
> > >   but so far none provides a recent kernel so more tests won't pass, last option
> > >   is to self-host some VMs and monitor git, getting just build tests works but
> > >   we need to run the testsuite
> > >
> >
> > This is unfortunate. However, I've been noodling around the idea of
> > asking the Fedora CI folks if we could add upstream CI using Fedora on
> > VMs. I guess now is as good of a time as any...
> >
> > Aleksandra, are there any resources we could use to wire up
> > btrfs-progs against Fedora latest stable and Rawhide across
> > architectures so the code could be continually tested as changes are
> > landed? There's that fancy Zuul instance[1] that might be useful here.
>
> I suggest that you talk with the Packit team.
>
> Packit provides Packit As a Service [1] approach to test upstream
> changes packaged on top of the latest Fedora or CentOS Stream
> environment.
> For example you can use it on GitHub by enabling the Packit GitHub App
> for you repository and adding the rpm spec file in the repo.
>
> Afaik Packit can run tests not only on containers but also on virtual
> machines. So it is technically possible to run more complex scenarios
> which require latest Fedora kernel.
>
> CC'ed Tomas Tomecheck from Packit.
>
> [1]  https://packit.dev/docs/packit-as-a-service/
>
>
> --
> Aleksandra Fedorova
> bookwar
>

