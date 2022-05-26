Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5653565F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 01:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiEZXXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 19:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiEZXXn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 19:23:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFFAE52A2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 16:23:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b4so3103614iog.11
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBW/yhKEo2X0CGqWgvmaoFcixhgXk+I6jbH/MUkjidE=;
        b=qSRhgQMQjKUd0IvDiS4//i/KYwy3azSTHpXIAosjKBrbOsSN8gDfnD0lEHc613ztuU
         9T/B20zW9Ge6f6+S6ykkbIxdkOcZBVro/P1PbK+JH2CKvpTLK+nWUyBC8aa0MxlgEgd2
         n6U5brqvfByVu34lK+UKjNpffchUmuFBxtXZfHuBQtuhIGtfIwDfJUQY7tiLYc4kU0d7
         fjEwGMSKH+ys32ooddYgHuHD45Vrg8BWh73jF+rTek1A3vx0iajlVdFSzNwZLN5V9xcw
         ljePuyzMtADwbMwi6Qse0VBoFtc2YVhwtfTC2CrOtJmAyTezxRprg0YIFQtfxdJknROA
         AHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBW/yhKEo2X0CGqWgvmaoFcixhgXk+I6jbH/MUkjidE=;
        b=KnCYowwLYQoW+PbBh59s/zYaiAmMFOjPv1cyjgvA8T0LpsHXp6/4MPb5qV3yLJP5hJ
         rzd+m7NGnAOmajgB72VQpYLDOntY+QgA0Hf0biW5IySwl256LQ0poSLRM/SKBrY5IbBf
         Y5TITxZvtAafktdY8URVdfE8RdquQcV79B2x0krurXi9IXKmiYmebF0byv7N5fgwV7Ww
         GpyuOagUFc2WdbaZO1JSF4BOnStJtJ/Gsuj0Wp62XJPuPM3zoUwT5fWdVwXeQpaUGDN7
         8UUthSGlPnIEp94CrlEiHrpisTBEXJARvJyTjp0XQaaZ6xKLAJ9NY6cPTMTJaW5MVN5v
         EKlQ==
X-Gm-Message-State: AOAM532nFPdjrhb0H3yLKDOi+ixCD0w8FqG898wcSRchmJ+p3G3cmkCt
        EhwuihDiI4fghKQQQG28HudPwxOJrXScKtRYd0RhI22y6n8=
X-Google-Smtp-Source: ABdhPJwlb++o2hIvUwzz61HNKZKP/JfyGZHK4DvWJuErm7xGRdjjGiQJ+Cp6+vSk6pn1nYBNFQLdH+junfTFFCwWIzw=
X-Received: by 2002:a5d:9ed7:0:b0:65b:3312:9946 with SMTP id
 a23-20020a5d9ed7000000b0065b33129946mr18340416ioe.10.1653607420421; Thu, 26
 May 2022 16:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220524191345.GA1751747@merlins.org> <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
 <20220526171046.GB1751747@merlins.org> <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org> <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
 <20220526181246.GA28329@merlins.org> <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
 <20220526191512.GE28329@merlins.org> <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
 <20220526213924.GB2414966@merlins.org>
In-Reply-To: <20220526213924.GB2414966@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 26 May 2022 19:23:29 -0400
Message-ID: <CAEzrpqcvXkjex9S-dEAJ0X7PH41UsuhS8gxz748ykBNHZucspg@mail.gmail.com>
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

On Thu, May 26, 2022 at 5:39 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, May 26, 2022 at 03:55:29PM -0400, Josef Bacik wrote:
> > On Thu, May 26, 2022 at 3:15 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Thu, May 26, 2022 at 02:54:47PM -0400, Josef Bacik wrote:
> > > > > Do I do
> > > > > ./btrfs rescue tree-recover --init-extent-tree /dev/mapper/dshelf1
> > > > > or
> > > > > ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > >
> > > > Tree-recover first, lord I'm tired of our tools randomly not updating
> > > > root pointers.  Thanks,
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > ERROR: cannot read chunk root
> > > WTF???
> > > ERROR: open ctree failed
> > > Tree recover failed
> >
> > Sigh, I've pushed new code, build and run
> >
> > ./btrfs-find-root -o 3 <device>
> >
> > and let me know what it says.  Thanks,
>
> I thought we were getting so close, but it seems we'e made a few steps
> back :-/
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 3 /dev/mapper/dshelf1
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> Csum didn't match
> ERROR: cannot read chunk root
> WTF???
> ERROR: open ctree failed
>
> At some point, if the FS is starting to look like it was trashed to
> start with, or kind of trashed now after some of the recovery attempts,
> let me know and I'll wipe and restore.
> That said, if there is still data useful to improving your tools, I'm
> game for a bit more, although if we hit the 2 months mark since it went
> down, I'll have to eventuallly recover :)
>

This is approaching insanity a little bit, but we're relatively close.
I fixed the flags, hopefully it'll work this time.  Thanks,

Josef
