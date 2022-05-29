Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5552453725F
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 May 2022 21:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiE2Ttk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 15:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE2Ttj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 15:49:39 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823443483
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 12:49:37 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j15so6386471ilo.5
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13ZqB5eCs0clhP+xSejy4x4CIqow3F4KSbUddw/Z/5s=;
        b=zIgE7ND0JnKc2c2zYZPOd9TCQk72QUbvJOTwhIeMPsqBVVs3nJ8oGK0NRG+iyIxRFl
         5apcupFMK3EocxZLd7vnXDZuwrzvEijEC/mJMDxC+BXrhd4wcpSNkWgh77XufszX2r2V
         djmVsqmC46Z8nZ2POXAxEnjOtR6/d5HCOW2MZOBkihHXSK13fcdqWG6SWQG20cyEgqjK
         Vp0yotxG2J/ObqNYzaFUUd/TYPd5yv1lMNiNQx9GJiMGpeoaDixNqv27F6rO5MGhFZPz
         V7GY62Ez1YTTPHHrSCqpGisUpLP2ueiW9nsi2RBguBOKk/aq1tIYtm14HrFgEYU+Zhdr
         WJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13ZqB5eCs0clhP+xSejy4x4CIqow3F4KSbUddw/Z/5s=;
        b=RYXrocFCnnpWGRjdmtfbYvX3xdzG1/6HVohrxPjvvt8rWp9KZR2+6YqCfJ9yBUybGb
         YOqiL3xEJOJOGZb6wooPAAAzoNs1I++cil7XM2xalsHa4zSHIA8HQ8qkYPbAsG1fEZiJ
         eImvmCbkgRNYtBGEAV4UeiKtEjCXsmvDzy5wzu3qSSeETv434x8ywVJQXEJgkbCBXBYA
         ZXLkS8guhpYY1TRYq5esRTtgGoAAw/1XS25JLqxy96UhBn3Rawh5PPIlb8hdRPYPobVD
         VDw55ItD0Fer5lmh9Pf2CdM1w0Yyn5qPeDkjGOvq4eOnB1/iowOS2kq2hZ4Qa+fsUwrq
         Ch6A==
X-Gm-Message-State: AOAM531MLSqGX4rx4AtPFc7WC4PCTUjN/E9KeBN/KTZLv1e4hn57CSJI
        O5Kahw0IztfyYH/cgFZQvSCYSfgwXYMHgIoRfxRjqhuCrmY=
X-Google-Smtp-Source: ABdhPJw+3TvEx6gEDwRQfDYzblmca6w0Rvh/si9S2D3DFTIblSKgpOeL/ibTfmwA1qTsOMxzooTJw+pndfFl8DSBNM0=
X-Received: by 2002:a05:6e02:216a:b0:2d1:71a0:c2b8 with SMTP id
 s10-20020a056e02216a00b002d171a0c2b8mr25466961ilv.6.1653853776930; Sun, 29
 May 2022 12:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
 <CAEzrpqfAYRUYttOAMmdth4mfi4e7MTM++s5WOQ+KAzg2Kv0Nsw@mail.gmail.com>
 <20220528225601.GD24951@merlins.org> <CAEzrpqcG+9evRPKixVwGnAS_k2tb7o16jQgORtm1cw7hW_KsAw@mail.gmail.com>
 <20220529035139.GE24951@merlins.org> <CAEzrpqcKeVNkXa3txx0nyDnKUCp06msmd97d1fBedTzbmR5KcA@mail.gmail.com>
 <20220529153312.GF24951@merlins.org> <CAEzrpqdEk-j2bMfBLEdkhHcq1hWLmHv_Nx-0mj1vh0yJgZuCZQ@mail.gmail.com>
 <20220529180510.GG24951@merlins.org> <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
 <20220529194235.GH24951@merlins.org>
In-Reply-To: <20220529194235.GH24951@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 29 May 2022 15:49:26 -0400
Message-ID: <CAEzrpqfd2jPWxUayfqyYRDN25-etc4_jgzcHmZ3LhGkb4e7Tsw@mail.gmail.com>
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

On Sun, May 29, 2022 at 3:42 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 29, 2022 at 02:58:11PM -0400, Josef Bacik wrote:
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > WARNING: cannot read chunk root, continue anyway
> > > none of our backups was sufficient, scanning for a root
> > > ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
> > > Tree recover failed
> >
> > Well if anything tree-recover will be rock solid by the end of this.
> > Try again please.  Thanks,
>
> Sorry :(
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> WARNING: cannot read chunk root, continue anyway
> none of our backups was sufficient, scanning for a root
> ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
> Tree recover failed

Lord alright, lets try some debugging.  Thanks,

Josef
