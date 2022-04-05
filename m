Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA64F2155
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiDECgM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiDECgL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:36:11 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C6E34DDC3
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 18:32:23 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id g21so13449479iom.13
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xtmtbvh9qalgFX9Ul1KWGQOCFu9u7rGnZdiRhvCluy4=;
        b=TIgdynqk7J1s3f/tQR1MBxSSmDuqjzYXftXhAaZAr1S+3P7zebeAGV5pHtsUPWR7ZE
         RX8lJ6Gtc044Z4JzP3HiJbwwkAldVo9o79N/bzi5AwXacyEFdQCLP+35cyTyXb94OGsy
         JE/ArwOXyH4dgVdlMatyfx87sXmcLPc/4QAxN4P0IinkkIwWgqY3M9OMeMiQzCAmoBh0
         eJ6d8v0aIFeGwWYob22yAMNzTaPB1aB7mAyuXaVyuLXyp+R9AGBxEbdiS/aDh4EMZPjO
         mLtZFNRUsNgoLtk1vVqfXEsYqa8dzgpQw2cib4ScYDfzS60tYsxJ+NmUx483qyKz89/a
         F2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xtmtbvh9qalgFX9Ul1KWGQOCFu9u7rGnZdiRhvCluy4=;
        b=YoSN/jw37i6Dp3hC9hUkHhIYQvAzWyJHZf0plvbfvcG3dvmWYh0LD5zvVtkkpj8UPx
         FD4VHaTPL1o5+75EZigw1yIIyHrJRaXpnmcS2ICbaMYHLvSFIU7qt4x1MahxU1Ja4Khl
         6UiZB9Grj+IZ1znS4VQOOgc+gQ0pGqh5fune8nxmJZmlbjBCWf0l9Ebp0QuWPDmKud56
         x5wy3q3O+EB+3A1OGEMZbljPk1xdJB5JY1EO3DOKOwF6PzoECslIV3/EgFSZchrvMa40
         Am1jeei2zoIkD+D2RGJVUxUqbiTVi5EAMNHTV53qpsM+8sBw2PHCYAdPK4CBhHWYzJB7
         VYgw==
X-Gm-Message-State: AOAM530pQefbbIJLmdKow+DJuDIdzkJCZiuT5Fx6+pvPIde4zPOYmcQr
        P7x21ofA9UhP+an/CrTcM35lku/7EzbLnl+DEZ37F6CYfG0=
X-Google-Smtp-Source: ABdhPJwGS3VdvgzEuxDVm84+vK12w4W1hFciOIQ/BL1Ry49Tt4a8v1kyAMf4Xx/kfk+1z3z2BE82i8MCTVkQxGBgGRc=
X-Received: by 2002:a02:c89a:0:b0:321:25b2:4b52 with SMTP id
 m26-20020a02c89a000000b0032125b24b52mr519161jao.218.1649118306465; Mon, 04
 Apr 2022 17:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220404220935.GH14158@merlins.org> <CAEzrpqefSVVYOf7oj4gqdvBou7vo58x7u4+G=vwCrnky9t3BZQ@mail.gmail.com>
 <20220404224503.GA11442@merlins.org> <CAEzrpqfJ7-GQHZicxpn2x3D=aOY=tnKkt9XiPJ8O+_VZAgK7wg@mail.gmail.com>
 <20220404231838.GA1314726@merlins.org> <CAEzrpqd2kVY=mpttaP3+YJJ_1t1Z3crfXAdF-69pMU10aVe5OA@mail.gmail.com>
 <20220404234213.GA5566@merlins.org> <CAEzrpqft7WzRB+6+=_tTXYU4geBB_38navF1opr6cd9PXiWUGg@mail.gmail.com>
 <20220405001325.GB5566@merlins.org> <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
 <20220405001808.GC5566@merlins.org>
In-Reply-To: <20220405001808.GC5566@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 20:24:55 -0400
Message-ID: <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 4, 2022 at 8:18 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 08:15:45PM -0400, Josef Bacik wrote:
> > Hmm I wonder if the dependencies aren't done right, can you
> >
> > make clean
> > make
> >
> sauron [mc]# mv btrfs btrfs.orig
> sauron [mc]# make clean; make
> (...)
> sauron [mc]# diff btrfs btrfs.orig
> sauron [mc]# l btrfs btrfs.orig
> -rwxr-xr-x 1 root staff 6216888 Apr  4 17:17 btrfs*
> -rwxr-xr-x 1 root staff 6216888 Apr  4 17:11 btrfs.orig*
>
> Binary identical after rebuild.

Sigh time for printf sanity checks, thanks,

Josef
