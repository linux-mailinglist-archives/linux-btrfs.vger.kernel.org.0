Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F075203BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 19:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiEIRsF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbiEIRru (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 13:47:50 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827312725CE
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 10:43:54 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ef5380669cso153108617b3.9
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9c3QVnLpMQ/ArbpVJ9MZgC4u5LKPyo6e1lzTDi/wztk=;
        b=iWgjuLRDmCxL1hn04gwY614CG73q5OsMdVww0EpKZX7NdBv00pTJDmNH6jePayBMrO
         Ktk5oMaP7H3Zkn8k4de9fqUyhwn3+Fyks85u4hU2toEmnySrC6ptvQsU9Yb0IyssZ0GO
         t0z4pAFd528r2Jkg3nlV6sQ5axN5gGcszmlQCN70/H7dEatwKLCopuUa/hnbW0b5FXig
         5B1PY+Ln5KOf+RIafazm625vPA6ro1NVm5APvGF3UHrxzCylECERqw1Vb3WsDbcVDYvB
         5W5Irb7+yYZ86PPmqB2AR2pXqI5G/eFrmwht1ex9M8+BYYpxFPNBS3oOcGKHGXM8RkDS
         aaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9c3QVnLpMQ/ArbpVJ9MZgC4u5LKPyo6e1lzTDi/wztk=;
        b=ZQ+fn3MYkLK6TAKeR4Xkmq/CgUJwD0iFIgWFUVfOJuFzNdq0hHvLzBIizQ1EqVPVH4
         ggRKVtlNT0vpBytLwXt6oLPv+9Y81j6zQDO035Lt6T6S9wd0+kBru5jdAIu46puiZlef
         I7NNooeAj8NbPLEDUk09q0C5fJcDA62V9tl7YfUqbYsvebOXki6ZXKc/9tdYoPiDQYdw
         5lHsorwcRvMrcqbcRnJcTqHrLIY8epwrIXLhDTyGreJCML44posxIITZN6FY2ero798c
         u4oCxmR8TMQML/5ar2U1KWBIkRgZzYyU4r7nzTwp5ByorFOoQOkgrjJ1QTEp4jhTWH/S
         OxYw==
X-Gm-Message-State: AOAM531ayQV9VzBGEwdzzeOhmifePArE+RoAUzrDrth9lWqBbpSxjvqm
        soAWwp0mZeUp3V5AJ7EhyfATanpJgBqDaiRJOc8=
X-Google-Smtp-Source: ABdhPJzj+LL/QJBf1max14povFVopkYD9jyYDxTzzG1DZSf4HJ9hT0P3IfzrxNo0HBujETKmVNUgzuv2wUJHW4eFVFI=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr14599984ywd.118.1652118233748; Mon, 09
 May 2022 10:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAFd7XocnyH8d_U8A0Mjy9+fk=DOTyiHzTR9FX+QSFevMtHGs=Q@mail.gmail.com>
 <CA+H1V9xQc0mxHkDXZTYMXEQtfJg7--CSs2k-RPQe92=+b09tBA@mail.gmail.com>
In-Reply-To: <CA+H1V9xQc0mxHkDXZTYMXEQtfJg7--CSs2k-RPQe92=+b09tBA@mail.gmail.com>
From:   Jose Manuel Perez Bethencourt <jmperezbeth@gmail.com>
Date:   Mon, 9 May 2022 18:43:45 +0100
Message-ID: <CALBWd87ywtPaogM+fdpzg3dH-k4Y+Gm7Hq5R4U=s15N+yMWzsA@mail.gmail.com>
Subject: Re: How important is a full balance?
To:     Matthew Warren <matthewwarren101010@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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

You should use filters like limit and usage when doing (data) balance
after addings disks to minimize tear and wear on hard disks. Like so:

# btrfs balance start -dusage=3D50,limit=3D1000 /btrfs-mountpoint

The value for limit should be about 1/N where N is the new number of
disks, assuming they are equal sized... Should be sized about the
proportional size of the new disk. It limits the number of chunks
balanced.

The value for the usage filter depends on your filesystem use but 50%
is a good starting point (if you delete data often, and have many
non-full chunks), and you can go up if needed (if you don't process
enough chunks to have an even usage across disks). This way you move
less amount of data, and above that that data gets "compacted" into
whole chunks.

There's not much point to do a balance of metadata, unless you have at
least N metadata chunks for N disks.

Regards,

Jose


El lun, 9 may 2022 a las 17:34, Matthew Warren
(<matthewwarren101010@gmail.com>) escribi=C3=B3:
>
> It's good enough. As long as the metadata and data are more or less
> evenly distributed you aren't going to gain anything from letting the
> balance finish.
>
> Matthew Warren
>
> On Mon, May 9, 2022 at 4:45 AM Alexander Zapatka <alexzapatka@gmail.com> =
wrote:
> >
> > How important is completing a full balance after adding a device?  I
> > had a 16tb single array.  I then added a 4tb harddrive and started a
> > full balance.  It's been running for several days and I still have 81%
> > to go.  Despite that, if I look at the usage statistics the drive has
> > balanced out the free space among the 5 physical drives.  dmesg still
> > shows chunks being moved... is it worth completing the balance even if
> > it takes several weeks?  or is it "good enough" because the files are
> > distributed?
