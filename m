Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900014DB7E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiCPSa2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 14:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiCPSa1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 14:30:27 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F63A5F27D
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:29:13 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so3694096oos.9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyxsrxXDXtL/lfGzZc8dfZbRJwYI3Iy3riFGZM/M4u4=;
        b=fshYIntl50aCobmE/bYakf03oIgSw7kQYd16Z99f+ovZckb3IeQU57f0oFrehQmn3G
         ll5kjFEKEMsyE88cRABQypuIeNL1NPT2oXEqGOd3IKhENh8UfWmZw+Oo57NZlz8AX2U8
         K1gM0g+eZ0lpImy7VxkrYQ0+rcR2oCFt/HxitcBTzuYKn2+nz5gH9A8higptwh7Qu980
         D0htjNpAi7huPZQZv98vjYbfImddD4ttY2a1aWD3P34mV0gmfaW3oHfVbFbnekMvQqda
         uPCsRwR96Hws7ZAn2QCwd5uc6oSIUW/shHhQTw3m6QXan94/ZKfIVLdKrE3a07A9fG61
         pWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyxsrxXDXtL/lfGzZc8dfZbRJwYI3Iy3riFGZM/M4u4=;
        b=SArK+EOr95WBPIuZ07h13qsbvS/lnKkI5IR00IwQZmyfBm4dSxk1pmkZ7278Xv5785
         409nnhWtU7ES05Xu5MUV5yqB/k8IAxAAp3XXKB3oLnFq2u6DqO44Meqzht3HdNo5YUDK
         xhK/1tEh7UZ+afghPXeCMigH0vHCuSSkTwb7u/9GD1hM7IxLe8oo+hbEzwG9NLuBzvzO
         7PhUBjK2otNn0rGCwy6/GC1D0S20PUPoKtvgPjohlzvaYa2VwkRPTaXhn+kC3X3kFq/N
         f4FdtedulWv79MxvzBoqvE5Z5QmxLr4Eyv+eJn01AraC536OLcsC0XDoJBJAARLJ/Lfg
         5IIQ==
X-Gm-Message-State: AOAM5325n01uV4tzBz5bS5kniwaJWntuupj7TBRVDVxcI9w0GU/8Epd6
        Kj/Vv9+UJjGP1FrtteUNZ8nmHrW5WLAmM0HcKqdaw2m9HPp6Tg==
X-Google-Smtp-Source: ABdhPJzVIl103bm6e3wsbai0fnT83rH6KGnVcJxQQLqKN9iC4MTEBrkRERSffO0w5W0vt2arU79T/DIKTyoioSc7TRk=
X-Received: by 2002:a4a:4f4f:0:b0:320:eccb:7309 with SMTP id
 c76-20020a4a4f4f000000b00320eccb7309mr297804oob.44.1647455352927; Wed, 16 Mar
 2022 11:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net> <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net> <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net> <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
In-Reply-To: <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Wed, 16 Mar 2022 19:28:36 +0100
Message-ID: <CAODFU0qJnrcF_yVHYR30uLdwOmKvsin4KJXgdQiZ_zAdH0G5UA@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>, linux-btrfs@vger.kernel.org
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

On Wed, Mar 16, 2022 at 5:52 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> On 14.03.2022 23:02, Phillip Susi wrote:
> >
> > Jan Ziak <0xe2.0x9a.0x9b@gmail.com> writes:
> >
> >> The actual disk usage of a file in a copy-on-write filesystem can be
> >> much larger than sb.st_size obtained via fstat(fd, &sb) if, for
> >> example, a program performs many (millions) single-byte file changes
> >> using write(fd, buf, 1) to distinct/random offsets in the file.
> >
> > How?  I mean if you write to part of the file a new block is written
> > somewhere else but the original one is then freed, so the overall size
> > should not change.  Just because all of the blocks of the file are not
> > contiguous does not mean that the file has more of them, and making them
> > contiguous does not reduce the number of them.
> >
>
> btrfs does not manage space in fixed size blocks. You describe behavior
> of WAFL.

The "single-byte file changes using write(fd, buf, 1)" was just an
example for the purpose of the discussion. The example isn't related
to the 40GB sqlite file.

-Jan
