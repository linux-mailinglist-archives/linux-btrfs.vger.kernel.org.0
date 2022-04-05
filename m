Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19334F4783
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiDEVMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346514AbiDEUWF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 16:22:05 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE29E7C14B
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 13:05:16 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id x4so485624iop.7
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgNN3YVZ8Oniaj+/KOsH7iH3kbYM7DdNMcqnMVaYR+c=;
        b=Xe05nKEB6hpRvpI1JHnQJwOGXvTdEcR1u5Gw6iXGdN78P0RfzLNJE68JT1wtTnf4rk
         uWpL6Tgvz5LjsST5KMFWa+vgB2wCGWcICilLpW5iIBCgD76/9zwtP6XK+tJq3EGBsnp6
         qgU7TAz1sDOa7YBxGUgW1wXqgDc0yYcDR1IT4o/ykYPXduYPoPecSkMgMUt4Yy4df4pw
         SXJB5jjGf0T3xLUeeBuPP0hu5NpG3n+am1F2Lk0QF0xfZDjIguWmrSMrGO9le3Z8mEeW
         znrdoZeMy1bfhcVVqOFxyhIo6UN1sFddmErQFGIUnhuaP/jI8PNKU/94vdL5VVdbaSLJ
         OjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgNN3YVZ8Oniaj+/KOsH7iH3kbYM7DdNMcqnMVaYR+c=;
        b=dkIbOJZdHesAQ2ghxISGMQeDSqi/w7mlcwhlolDsPNFXNTgETFC5C06ay4ZIPJADUS
         r0yiyEsHsGxgJCgFAFHyuU+JOZ8n2s3NoMT4zs/QxU+oDF9mMQfL83Xa8Si8uHsIVLfg
         01R4y/CbqgbzoLAgAk1MfjWT7Xupk8peTVN75URu6ewdU4kG4wWDCRPZzY5ImnJZluiE
         WlMm66g+vgqqWRaTUkegkidXaWnEXwsDk35jx4GKxBjM9jcuZAbyb5wCiL1w1egrmAMi
         X1ylSqF4fVjKAwSPPfKcpf9purAW9fyOWrAj+ju7cqGigwRexVMTFrglVTuDxvue2amD
         E6/w==
X-Gm-Message-State: AOAM530CFSuYa+b+ZrrxgLvipIDQyDRUoUcApKIoAmZ9FTzPLg8KA0Gx
        yiGlZYBjki4OMQ9T77DpeEEvBRENYvHhnrL4DrNSF70WAgqkdQ==
X-Google-Smtp-Source: ABdhPJwiKpTQKjRWuI8lDGmPfAsxF1VQg3kk0sn4SpWTAnVGD2jXrT97fqplXHfbUjtf+mUYeDeguUtYSvi4W14yZhw=
X-Received: by 2002:a05:6602:2bc4:b0:645:eb96:6495 with SMTP id
 s4-20020a0566022bc400b00645eb966495mr2535424iov.166.1649189116073; Tue, 05
 Apr 2022 13:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
 <20220405020729.GH5566@merlins.org> <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
 <20220405155311.GJ5566@merlins.org> <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
 <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
 <20220405181108.GA28707@merlins.org> <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org> <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org>
In-Reply-To: <20220405195901.GC28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 16:05:05 -0400
Message-ID: <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 3:59 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 03:56:31PM -0400, Josef Bacik wrote:
> > On Tue, Apr 5, 2022 at 3:51 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Tue, Apr 05, 2022 at 02:36:29PM -0400, Josef Bacik wrote:
> > > > > Couldn't read chunk tree
> > > > > WTF???
> > > > > ERROR: open ctree failed
> > > >
> > > > That's new, the chunk tree wasn't failing before right?  Anyway I
> > > > pushed a change, it should work now, thanks,
> > >
> > > It failed for one commands we did before:
> > >  ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a
> > > btrfs-progs v5.16.2
> > > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > > Couldn't read chunk tree
> > >
> >
> > Ok I think this is from you redirecting into your device, can you do
>
> Sorry for being an idiot.
>
> > btrfs inspect-internal dump-super -s 0
> > btrfs inspect-internal dump-super -s 1
> >
> > and see if they're different?  We may have to put your old super back.  Thanks,
>

Well it's still the same, and this thing is 20mib into your fs so IDK
how it would be screwing up now.  Can you do

./btrfs inspect-internal dump-tree -b 21069824

and see what that spits out?  IDK why it would suddenly start
complaining about your chunk root.  Thanks,

Josef
