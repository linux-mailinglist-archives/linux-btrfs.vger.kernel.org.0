Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921FF267C44
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 22:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgILUnl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Sep 2020 16:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgILUnk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Sep 2020 16:43:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FFFC061573
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Sep 2020 13:43:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q63so12555783qkf.3
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Sep 2020 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=maYlfLvuqnNhxinc247oZLKKdq5zNhnalaoFXwwUW5Q=;
        b=IBy5TDh0dlM8hzjgyQnDbP7P26gArMXszwW7l73lW10vB2VFRC+H/EiyMbjYMe8Ktl
         gfWivAXUjTFXO9+zcTGvmiCMtcw9WZE5AexLxWZTG8CmHqQWqoPj6FjrQVf8uKU0z/h4
         EEA1geD6n4+s3DMUoYSXvuoyamBtmlbcP7kgfLaIhhVHwC2MFsaRePUd/SaoMw/6qNGK
         xeZJEknMz3qSbItWjOuXdBg3fmjS3zVu0EcceNUIBr1LRdp2BQub5OLJvs32yhdQ4a2x
         /FmrppYhEyEu6QMjpUtCz1SmMUT2y3WfualMQ54O2xs7uq1rxugIN5v2/4DxfvmcWWeY
         pvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=maYlfLvuqnNhxinc247oZLKKdq5zNhnalaoFXwwUW5Q=;
        b=NlRLQMXu0G1cOB2Ywgca+T5L6JWM272WCdmZZAGnB7ws9DMbC5dAM9OY7eduDuywyX
         b4eX3hSXyAddLX4Tso7UCUezPGN5fESmXC1r29TiCekRUorK892vn/JPZ4P7duImmuvw
         Cz7za7RSnQWCGfk0zZPWOFG/FxmbKhYXNvvinv0AiWybpXVbdBTdalJjuMJ6fAzpEXb2
         pRXWMcU4JQeZG5svePptrC7kw/WAgCoUNX/eQK2efnhMzMUVr8huO3E8pSJjrUSn77IO
         YaQBtjR1hzuJ09jAWkQn2SP2jkkXkJb+r0gg59IOhZZo8GUXBudNiXRI3p6ZkLD/IZRd
         Q3sw==
X-Gm-Message-State: AOAM532+mMpM1v+v5z6HwS4s4hoZ2EwQIFdDR9Aojop/ylQlkLDeU6D8
        OGcz5idDCFSmhDKDDdgn1U7XY67qOzYjhayqtN7EaeO1
X-Google-Smtp-Source: ABdhPJxxK50VeFhA/I8B3TL4CXtN2crHMbesM8zk6C9bkSFx/35ay40xIy2pazi1p1vGsi2ZdPZ8aO68Ej9FwzEq0Cw=
X-Received: by 2002:a05:620a:74c:: with SMTP id i12mr7215501qki.438.1599943417187;
 Sat, 12 Sep 2020 13:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
 <dccf4603-ee16-37e0-11b2-d72f8956a74b@googlemail.com> <CAL3q7H4s1W33DovgTJRAr3qTh+wjPZqbiHUjmvPMqQ=rce8YMQ@mail.gmail.com>
 <dd56f3c9-000f-52b3-b290-1db2ad9b7d3a@lechevalier.se>
In-Reply-To: <dd56f3c9-000f-52b3-b290-1db2ad9b7d3a@lechevalier.se>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 12 Sep 2020 21:43:26 +0100
Message-ID: <CAL3q7H4PuRynXc+AyqTmVQSQ6qs8UDsy+PhWpg__67tXDw2cmQ@mail.gmail.com>
Subject: Re: Changes in 5.8.x cause compsize/bees failure
To:     A L <mail@lechevalier.se>
Cc:     Oliver Freyermuth <o.freyermuth@googlemail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 12, 2020 at 9:36 PM A L <mail@lechevalier.se> wrote:
>
> On 2020-09-12 21:45, Filipe Manana wrote:
> > On Sat, Sep 12, 2020 at 6:27 PM Oliver Freyermuth
> > <o.freyermuth@googlemail.com> wrote:
> >> Am 12.09.20 um 19:13 schrieb A L:
> >>> I noticed that in (at least 5.8.6 and 5.8.8) there is some change in =
Btrfs kernel code that cause them to fail.
> >>> For example compsize now often/usually fails with: "Regular extent's =
header not 53 bytes (0) long?!?"
> >> I noticed the same after upgrade from 5.8.5 to 5.8.8 and reported it t=
o compsize:
> >>   https://github.com/kilobyte/compsize/issues/34
> >> However, since it's userspace breakage, indeed it's probably a good id=
ea to also report here.
> >>
> >> Since you see it with 5.8.6 already and I did not observe it in 5.8.5,=
 this should pin it down to the 5.8.6 patchset.
> >> Sadly, I don't have time at hand for a bisect at the moment, and at fi=
rst glance, none of the commits strikes me in regard to this issue (I don't=
 use qgroups on my end).
> >>
> >>> Bees is having plenty of errors too, and does not succeed to read any=
 files (hash db is always empty). Perhaps this is an unrelated problem?
> >>>
> > Can any of you try the following patch and see if it fixes the issue?
> >
> > https://pastebin.com/vTdxznbh
> >
> > Thanks.
>
> I applied the patch on kernel 5.8.8-gentoo and it fixed my problems with
> both bees and compsize.

Great, thanks for testing!
I'll send a proper patch on monday.

>
> Thanks Filipe!



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
