Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A2479368
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhLQSAX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhLQSAW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:00:22 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B2C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Dec 2021 10:00:22 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso3876096otr.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Dec 2021 10:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2CEsfg3hVH8SRNyKvDWGCRH1bbRjFCQSiBFuCWWCLY=;
        b=HLO4dmvEgYKXM5ilD3lWlxZ8MHz1st0cOtS4AjdHeDPuKupQV5ELzpTMHAGvtLtW5w
         q2ogzDl8G/BcncWwl/HXp7AbQo95dSkQEd/aZZvVvcM4IFB5r+GTQICA4uecjD22o+m3
         O/qbbIB1gfhId19CJJEmMW8EHo06YnCWkUOFYry6XZzCwQK8P6dxH8UrwJaweC67RQOJ
         sSiBeLtA2uqSb3NsnxEeOgq7BJJCCb57j31PnzVcNSc1ozLyADDF7Mzx4M0bf9LJEZ9p
         stKyZyjS55NDYj0jbH8qx47uF+z3CWeaDJs8VvXyteLXbuHehMCQoi/tQDhtaSaDGnve
         84iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2CEsfg3hVH8SRNyKvDWGCRH1bbRjFCQSiBFuCWWCLY=;
        b=1KgW27Cu+7lNA1rL3Y8xLGSYFtxizDXzfPxjRGM8PgtziEfPOA1jorWez0qcQdLJbC
         aB5QLKOOapAUUBUTaDyfnu/YfVFdheHprY4X3ZOPF5xth+SMXiS0DquNxlW7o3Sp85BO
         sQqb5pk8CHFxadjyHVDfTmkck6I7lCsri+JZW9j1FdHZXvrZSM0GsggAZAKFfmyxAfO+
         KTvo8tro7EQgQHPEo8OT/55Yjy13Bi0I7Nu/bDLPI6uTBusW1Ga3nuKGKMBLCNH82K8K
         EdbP56L5nhQ0efHCPlQ5pJqcn9TDUJKJB/KxWdEfdUssL8/OunrlYLd11EAthYooVIqw
         AOTA==
X-Gm-Message-State: AOAM532EeA7/pywP9IQ+rEqSe8pW7ph7z+WtdpGNii7CmvFQ+anOoxFu
        S7dsWiPcAtcpGIUV686S5gtiqocGMqopjHXM3w4=
X-Google-Smtp-Source: ABdhPJy87v8HyzxZrMN8EqgZIAZSh8DmEQ92Dc/ymbPMarErceONZuukP/h8ZHtvv0+Ba7T6No3sD5CTY04YYjl27LM=
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr3039938otl.318.1639764021932;
 Fri, 17 Dec 2021 10:00:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
 <20211215155059.GB28560@twin.jikos.cz> <PH0PR04MB741678D21AA0328B07AD69689B789@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAHQ7scWwFxXCexCx-Sm4J6uujzv24gWXuMzvq-0qC2dgC_HZQg@mail.gmail.com>
In-Reply-To: <CAHQ7scWwFxXCexCx-Sm4J6uujzv24gWXuMzvq-0qC2dgC_HZQg@mail.gmail.com>
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Sat, 18 Dec 2021 02:00:11 +0800
Message-ID: <CAHQ7scUXLmgPNmy1h8mJYaTCfGLU8cX5qAEixo-78ysHkLSVRA@mail.gmail.com>
Subject: Re: unable to use all spaces
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry, my mistake, this device is not HM-SMR device.
But still I can not fill up the device.

If I mount it with the nodatacow option, will it save some space?

Thank you.

On Sat, Dec 18, 2021 at 1:57 AM Jingyun He <jingyun.ho@gmail.com> wrote:
>
> Hello,
> Here is output of fi usage:
>
> Overall:
>     Device size:   14.55TiB
>     Device allocated:   14.55TiB
>     Device unallocated:   1.75GiB
>     Device missing:     0.00B
>     Device zone unusable:     0.00B
>     Device zone size:     0.00B
>     Used:   14.42TiB
>     Free (estimated): 129.49GiB (min: 129.49GiB)
>     Free (statfs, df): 129.49GiB
>     Data ratio:       1.00
>     Metadata ratio:       1.00
>     Global reserve: 512.00MiB (used: 112.00KiB)
>     Multiple profiles:         no
> Data,single: Size:14.53TiB, Used:14.41TiB (99.14%)
>    /dev/sds   14.53TiB
> Metadata,single: Size:18.00GiB, Used:14.75GiB (81.95%)
>    /dev/sds   18.00GiB
> System,single: Size:256.00MiB, Used:6.05MiB (2.36%)
>    /dev/sds 256.00MiB
> Unallocated:
>    /dev/sds   1.75GiB
>
> And I'm unable to add another file at 30GiB.
> Do you have any advice?
>
> BTW,
> blkzone report /dev/sds
> returns:
> "blkzone: /dev/sds: unable to determine zone size"
>
> Thank you.
>
> On Fri, Dec 17, 2021 at 3:51 PM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
> >
> > On 15/12/2021 16:51, David Sterba wrote:
> > > On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:
> > >> Hello,
> > >> I have a 14TB WDC HM-SMR disk formatted with BTRFS,
> > >> It looks like I'm unable to fill the disk full.
> > >> E.g. btrfs fi usage /disk1/
> > >> Free (estimated): 128.95GiB (min: 128.95GiB)
> > >>
> > >> It still has 100+GB available
> > >> But I'm unable to put more files.
> > >
> > > We'd need more information to diagnose that, eg. output of 'btrfs fi df'
> > > to see if eg. the metadata space is not exhausted or if the remaining
> > > 128G account for the unusable space in the zones (this is also in the
> > > 'fi df' output).
> >
> > Can you also share the output of 'blkzone report /dev/sdX'?
> >
> >
> > Thanks a lot,
> >         Johannes
