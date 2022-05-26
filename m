Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E854553539A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 20:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347912AbiEZSzH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348567AbiEZSzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 14:55:04 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE78BC9EC9
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 11:54:59 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f4so2489836iov.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdo4lGmYVUqZ0X8WNn/NJMxkaD1HjfBsoUBhogWM63w=;
        b=v3mQ1RbfhuxlyR6VNtgmoNol0M/ld51Zab1z3pKUxX74/bHNUr85rfWLEF/r9yUWdb
         oH8J3dIy7Du55QpyU+d/DN+hWBk2wq7yaLJEOeueNbpuJeAyr0z31m7WrYb3q4872RYC
         xFu2t/cRCrhVhlV0Px5XphLoIxWa34ysW9kLdVpVITpo0I1V8JBKKsW6HY5tSvu/RVNy
         5Hk8NAvcb0OA3X9j1WQkG4gZDllEKBYJx6H9ZWCylqZ6cZjHcBhaifVXx4QxdZOwqhMG
         7C0o6fVc5Z4+DoNg+bYDUDGG56qcdmc/mxEcCUAyqO69nRwGvgRoTRwu3NjX5oOns/Ht
         NuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdo4lGmYVUqZ0X8WNn/NJMxkaD1HjfBsoUBhogWM63w=;
        b=iBRUnKTkYTO/sLzYnz1qFy0gEzk4bYwcZFoC/u7y2ZO+J1q4m2nfAFOoQYeetjTwlo
         1gqdSzRyJlDHbC1Ke292Y4B9h6UQ+fRZsgbLLxqGZC70GjK62LGNVvYoDqhDUOm6EaH5
         ibH86yep/9QBcrJjjuPVnxo7gIWnf9kJuKvGUPL2WisOnOQ5VLBhdezqo9IVjRJlWwUs
         E4WDzsv1CQ0DgCPHvmDZahxdKFx+eBWUm2cRj/L70dyGP55ey1oEmRJ8X0vm+U81bEEb
         sxntEqY9iKqQz4sFN8ZV6MtqblLZ44l3jjvY2pT2xX/BVIWeKK7v+BzvxuPTeCX2OLX7
         BXsQ==
X-Gm-Message-State: AOAM5324pawqJdTTjVuq1w4ZlVzCO7qgMmOx8KNcw3HRfX4HCLsNF82I
        PxPufU4G6mxStQkKngLuIGC6YRUxpBfc9K5DmVymTxKf+G0=
X-Google-Smtp-Source: ABdhPJz37TBa4pR5Wt6/Sn4vCT4H1cvNBQEfUDlHQmAIBTPVk7j0AiQzsVOQ6Cz/t8TKQfERVHvUewGx6zZBgEgQZdw=
X-Received: by 2002:a02:93e7:0:b0:32e:d8c4:95f2 with SMTP id
 z94-20020a0293e7000000b0032ed8c495f2mr9735195jah.218.1653591299019; Thu, 26
 May 2022 11:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
 <20220519222855.GL13006@merlins.org> <20220524011348.GR13006@merlins.org>
 <CAEzrpqd=G50pWKYJRD57ePVpfGNPu947zJXuZFdj0tF4yGzkbQ@mail.gmail.com>
 <20220524191345.GA1751747@merlins.org> <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
 <20220526171046.GB1751747@merlins.org> <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org> <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
 <20220526181246.GA28329@merlins.org>
In-Reply-To: <20220526181246.GA28329@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 26 May 2022 14:54:47 -0400
Message-ID: <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
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

On Thu, May 26, 2022 at 2:12 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, May 26, 2022 at 01:44:00PM -0400, Josef Bacik wrote:
> > > I still have this that ran almost a week:
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# jobs
> > > [1]+  Stopped                 ./btrfs rescue init-extent-tree /dev/mapper/dshelf1 2>&1 | tee /mnt/btrfs_space/ri1
> > >
> > > I assume it's invalidated and I should kill it?
> > > If so, do I start the same thing again?
> > >
> >
> > Kill it and start it again, hopefully this time we have all the chunks
> > and the init should be quick like it was before.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1 2>&1 | tee /mnt/btrfs_space/ri1
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> Csum didn't match
> ERROR: cannot read chunk root
> WTF???
> ERROR: open ctree failed, try btrfs rescue tree-recover
> Init extent tree failed
>
> Do I do
> ./btrfs rescue tree-recover --init-extent-tree /dev/mapper/dshelf1
> or
> ./btrfs rescue tree-recover /dev/mapper/dshelf1

Tree-recover first, lord I'm tired of our tools randomly not updating
root pointers.  Thanks,

Josef
