Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089D05EACF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Sep 2022 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiIZQqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Sep 2022 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIZQq1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Sep 2022 12:46:27 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFCDF57
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 08:36:21 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id j17-20020a9d7f11000000b0065a20212349so4654837otq.12
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=/f2KGqnce+ehOpuWptGasR1Ml6A7Z28qbD6FMqCQgRU=;
        b=nVEtKlZSN2ZaBwSEVAH6PHch5ulUKvabSiBUYsmPN4iDUzIWpVfZCQ7MBvNm7sjpYN
         oeLj/ewcr8dyZ4quvDSNrJpWibzoIgHuUqwiGUzj5i7MOj76Am+otNoIM9l4ZxLVjBQD
         xlEjGnJNp0Y9KKjHGptDA7Xr9TqaKPPXTrT20rGSFEAfehZgJiAr1a/ecDN3THz+6u10
         VM6tWl2Cruhna9rBR8JfPvlXkUPHUNParEWCcVgu+o7eWQqJ4KD8LfkPwqp1A5hXT9fy
         3mIW6ZBa7rcBCXJj4ZJOqd2RHWLwyuLQBrmOd4VD6v38owiBNibd07XDPlRa6wxmujym
         asNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/f2KGqnce+ehOpuWptGasR1Ml6A7Z28qbD6FMqCQgRU=;
        b=mZKGqre6Xo6yExXXHryiKrbFtHJVd184JZVGcYbns3mPtuQNnQNxNfVzjAoOWJw47/
         zQNLQ2eEUAutQQpmzmLVYxvRH05Cn7F4OTjd5WAfKMeWHBfRxoQIhzRyYE8JDPzyTvoj
         ZHtvuKHC5Cgzygxdf2zeyqIu/urrLe+a69/aculvUgSuYxB/9gAT6Yxv2DSUEA7kdyNp
         JVaqlO4cuSuRnwB9Ne3w7DoWrbwtkMm4ivtP77IKKAeaXYLTMbdt03trTCFkhbB/2JO6
         7zcbQKwmoSnWsco938ypBKuATnaDFcfKsvgvFpYhdp0w1RmMJNBjQUmnuo2kiZtHhBAY
         +PLQ==
X-Gm-Message-State: ACrzQf1ig+t73bpA+IwWGn8OwqhHWO5/XiOzRxNalnhELLy1cw258adD
        Wubou26rdNCnerycUUhlCgQ8SzNS+DFBI3VtTBg=
X-Google-Smtp-Source: AMsMyM5kOvNiHoEBYOwEBf6wx49rijRk06osLufyjk6n0BYfHzf23QkptSS0GzGoh/FoHqlR0d6tPsQEx/e++KQeyT0=
X-Received: by 2002:a05:6830:2805:b0:659:aab:f8e4 with SMTP id
 w5-20020a056830280500b006590aabf8e4mr10712086otu.84.1664206580534; Mon, 26
 Sep 2022 08:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGzuT_3UVJuXeDjQ4CtM77TO2C6WoBAiWyyBi59_wcv3p7znzA@mail.gmail.com>
 <20220914142738.GN32411@twin.jikos.cz> <CAEg-Je-vB+UgU2uDspdN8P+aG+JQP1h-7hx34siy6FasgJ=e3w@mail.gmail.com>
In-Reply-To: <CAEg-Je-vB+UgU2uDspdN8P+aG+JQP1h-7hx34siy6FasgJ=e3w@mail.gmail.com>
From:   Mariusz Mazur <mariusz.g.mazur@gmail.com>
Date:   Mon, 26 Sep 2022 17:36:04 +0200
Message-ID: <CAGzuT_1_NWtqtZhC83xsW9L3NXwz02v_PdaABpuJ-OheqZ6drQ@mail.gmail.com>
Subject: Re: Is scrubbing md-aware in any way?
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

niedz., 25 wrz 2022 o 20:46 Neal Gompa <ngompa13@gmail.com> napisa=C5=82(a)=
:
>
> On Wed, Sep 14, 2022 at 10:37 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Sep 13, 2022 at 04:15:26PM +0200, Mariusz Mazur wrote:
> > > Hi, it's my understanding that when running a scrub on a btrfs raid,
> > > if data corruption is detected, the process will check copies on othe=
r
> > > devices and heal the data if possible.
> > >
> > > Is any of that functionality available when running on top of an md
> > > raid?
> >
> > No, the type of block device under btrfs is considered the same in all
> > cases, except zoned devices, so any advanced information exchange or
> > control like devices reporting bad sectors or btrfs asking to repair th=
e
> > underlying device by its own means.
> >
> > > When a scrub notices an issue, does it have any mechanism of
> > > telling md "hey, there's a problem with these sectors" and working
> > > with it to do something about that or is it all up to the admin to
> > > deal with the "file corrupted" message?
> >
> > It's up to the admin. I've looked if there's some API outside of the
> > md-raid implementation, but there's none so it would have to be created
> > first in for the btrfs <-> md cooperation.
>
> IIRC, the Synology folks created such an API for their own use-case.
> Does anyone on-list know the folks at Synology to see if they'd be
> interested in working with us and the md folks to make this fully
> supported upstream?
>
>
> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!

Yes, wondering how synology uses btrfs on top of md raid effectively
is what prompted my question. I'd like to be able to use btrfs (and
other filesystems) in such a fashion as well.
