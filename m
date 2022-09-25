Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06265E9578
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Sep 2022 20:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIYSq7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Sep 2022 14:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIYSq6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Sep 2022 14:46:58 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967022BB36
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Sep 2022 11:46:55 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3454b0b1b6dso48958707b3.4
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Sep 2022 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=U8AEOwIZMshWexvLvI+LNmcjHx5SoRYb6Rc2IsnNYSI=;
        b=kdJN8NIrsBgVttotEUWujO70vt6oqzpcUwlxEj6tNkVzuRAkB5BrU/iqE4G1m8aNjN
         fH4r2A3o4EHxGqjepgjSTBPnChb5noy/PgCC9Dr/glktHZVCBKgB16HfZYDYV3rCuSnz
         1bym67zVZvZ4SYBiQ8qAWUCN6EjE/ZvC93sEBtyz9fKO725n9C3AyJLZhL+wKV9SzvJA
         NjX5DXBRJ08poic4EZyTTiqM4v6OzkVuOmIzdJSAbJMgsjTKasdGw4vHaGsF2RAjDJRg
         rozuRDCgLi/KXkhJ+u1HkYTkp0RbGEjUJiD83UaIKOuCqhsAe7jtcCrI1J6eTysvlGCz
         94Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=U8AEOwIZMshWexvLvI+LNmcjHx5SoRYb6Rc2IsnNYSI=;
        b=Z3LxqiOmu3IMKvWybMGYKlSFhjXJfcANg7a/M6wtvogt7wEnLqs2+LdYsqJSQBQcyy
         w0flXRGBWxwQ82wwTDQf4wkk36axWeReOXv3ebtguSWQqAPYRjc5RsM1MZA0PinLCTQB
         iUDPfUKAqJCeddIrTfUIp62YUYMGlbB+YXNtZK2iRrgEkTLhIXs8ch91e8nR6ZyQfJ52
         h/GK5sncPgUtCPUFFWYG3szx5a7+YRQ1BpDKgHgnHmqufEswy6HLFpQtrn8EX33fJ4Zw
         K9FxES2ouIdtFc+ui407i9AzPQSaj/llr6uMbzd4GRnS6XCwla19g1ACjMsj1a8gArv7
         JXrw==
X-Gm-Message-State: ACrzQf18q4SJ3MlYoi4j/f1Abb5LSzrf7fymi9UPL9ho4YEMcQYo4HFw
        J1OMVssDjIu9Q28mxaj0GU/f3BCrDr5m2/EQFsQ=
X-Google-Smtp-Source: AMsMyM51pFe8Ik686MwdUpWR2yuEy1xPqW4PZ66BadKF805LIytsljvRhDiU9ANRUErKzumVBAygepIKhXC0vyJ92Ps=
X-Received: by 2002:a81:6756:0:b0:345:525e:38 with SMTP id b83-20020a816756000000b00345525e0038mr17677309ywc.47.1664131614654;
 Sun, 25 Sep 2022 11:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAGzuT_3UVJuXeDjQ4CtM77TO2C6WoBAiWyyBi59_wcv3p7znzA@mail.gmail.com>
 <20220914142738.GN32411@twin.jikos.cz>
In-Reply-To: <20220914142738.GN32411@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sun, 25 Sep 2022 14:46:18 -0400
Message-ID: <CAEg-Je-vB+UgU2uDspdN8P+aG+JQP1h-7hx34siy6FasgJ=e3w@mail.gmail.com>
Subject: Re: Is scrubbing md-aware in any way?
To:     dsterba@suse.cz
Cc:     Mariusz Mazur <mariusz.g.mazur@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 10:37 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Sep 13, 2022 at 04:15:26PM +0200, Mariusz Mazur wrote:
> > Hi, it's my understanding that when running a scrub on a btrfs raid,
> > if data corruption is detected, the process will check copies on other
> > devices and heal the data if possible.
> >
> > Is any of that functionality available when running on top of an md
> > raid?
>
> No, the type of block device under btrfs is considered the same in all
> cases, except zoned devices, so any advanced information exchange or
> control like devices reporting bad sectors or btrfs asking to repair the
> underlying device by its own means.
>
> > When a scrub notices an issue, does it have any mechanism of
> > telling md "hey, there's a problem with these sectors" and working
> > with it to do something about that or is it all up to the admin to
> > deal with the "file corrupted" message?
>
> It's up to the admin. I've looked if there's some API outside of the
> md-raid implementation, but there's none so it would have to be created
> first in for the btrfs <-> md cooperation.

IIRC, the Synology folks created such an API for their own use-case.
Does anyone on-list know the folks at Synology to see if they'd be
interested in working with us and the md folks to make this fully
supported upstream?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
