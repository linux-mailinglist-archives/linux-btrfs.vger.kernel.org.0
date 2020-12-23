Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621A62E21ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 22:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgLWVLC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Dec 2020 16:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgLWVLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Dec 2020 16:11:02 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B8C06179C
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 13:10:07 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id r17so310085ilo.11
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 13:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZMUDMR4pTmJNoSoaiKNNtdLIWf0D/EJ1+mQ+sQxsp0=;
        b=AIfRmzyF8QVV2XoZBrgPqiMkwP+d/waxNG88EufLseXO59pig6prjSxM5Rpwf6Ebh9
         pTFTtkNe4goWFtYC0BwTtYNnWNHoRg6BxQFLWEbgCm1BueHIDjQCC3SFzx9UhHp2qIch
         V9nUbIXvc1KTR31ET1RM17G2CxMqXvVkH0ccw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZMUDMR4pTmJNoSoaiKNNtdLIWf0D/EJ1+mQ+sQxsp0=;
        b=jHzY9AZtabCOwcDnW9nMWJ5LMkJVhZ922wk4BfrGUYbWQRLWt7pUaubYJD+KoV7V/M
         aZQvVPDzAQnkI0JaCfwoeNIokw9VQPm124N/7GMNSyi2b00E2noSbnUp5XlK3RCZUvqW
         47puY3xWMHvBQ6qJOaSyVOGRiX7aZC0FvvT2JG+L5y3Cvcp9vWv5oYRtecejaOZ6ouoC
         eERYLzk6IcsmNjm2IqiVD6r1kyiTtlkZJDNjfKPG16C8SLoATua+H6NgwkGUV13kHYr0
         WYDH9JOVIvuXgMrrg7C9EIaCfpeigcOTNjj8A0siMv9HJdiKenSXakh7f9AS/JitEPBG
         mUrw==
X-Gm-Message-State: AOAM532tD9yA9u7MEPPFNQFHOwOdymMrgzb1Bpz+LDR7SAGMYTgmjqIF
        idJgzHFncIqUEc8SAUI96lGcm22LTVDMMsSD17Mteg==
X-Google-Smtp-Source: ABdhPJzNMVq9HFYERLK48OHfmHGpl1yXYcBtCKLKrJO6mwP08aLtzgcpsEJd5GjYz8k/7Jf8usy1WJOz+pl5KzRZLA4=
X-Received: by 2002:a05:6e02:5c2:: with SMTP id l2mr26473575ils.231.1608757806552;
 Wed, 23 Dec 2020 13:10:06 -0800 (PST)
MIME-Version: 1.0
References: <16ffadab-42ba-f9c7-8203-87fda3dc9b44@maciej.szmigiero.name> <74c7129b-a437-ebc4-1466-7fb9f034e006@maciej.szmigiero.name>
In-Reply-To: <74c7129b-a437-ebc4-1466-7fb9f034e006@maciej.szmigiero.name>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 23 Dec 2020 21:09:55 +0000
Message-ID: <CALrw=nHiSPxVxxuA1fekwDOqBZX0BGe8_3DTN7TNkrVD2q8rxg@mail.gmail.com>
Subject: Re: dm-crypt with no_read_workqueue and no_write_workqueue + btrfs
 scrub = BUG()
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        dm-crypt@saout.de, linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kernel-team <kernel-team@cloudflare.com>,
        Nobuto Murata <nobuto.murata@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-crypto <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 23, 2020 at 3:37 PM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 14.12.2020 19:11, Maciej S. Szmigiero wrote:
> > Hi,
> >
> > I hit a reproducible BUG() when scrubbing a btrfs fs on top of
> > a dm-crypt device with no_read_workqueue and no_write_workqueue
> > flags enabled.
>
> Still happens on the current torvalds/master.
>
> Due to this bug it is not possible to use btrfs on top of
> a dm-crypt device with no_read_workqueue and no_write_workqueue
> flags enabled.
>
> @Ignat:
> Can you have a look at this as the person who added these flags?

I've been looking into this for the last couple of days because of
other reports [1].
Just finished testing a possible solution. Will submit soon.

> It looks like to me that the skcipher API might not be safe to
> call from a softirq context, after all.

It is less about skcipher API and more about how dm-crypt uses it as
well as some assumptions that it is always running in context which
can sleep.

> Maciej

Ignat

[1]: https://github.com/cloudflare/linux/issues/1
