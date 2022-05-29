Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E1B537244
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 May 2022 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiE2S62 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiE2S61 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 14:58:27 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF340340E0
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 11:58:22 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z20so9452983iof.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5LwNlyhWbwD+zCERSO4ztMJWYfOnhHcRMc5JN9eiqc=;
        b=S9nU7YgPYuUet9RJhUahYz6GV0J9GvWX0PYDApq4EdFvmcue3TT0GvSFAxYbXxOE9t
         0JVBBFnmV2ZrpnVZzqnr5fS0Y4gMjkUmBpiWZYQ0VFOBQ2zK+iv8ynbw98kXo72w9S7z
         wXtB9pbN8kLAzhn8Zt/CDQn5cMKznaGLiuupyYTCWTC2vfgeRfEB655HtdHakD93GjKi
         1SP4ALvctw0etsQ/BwELMBLSktbPyqjUfUPpok8fsy/zS9zxOYfiUg02BPNOFavNbr+A
         ZCTPahrK4RvK+S8fuSjdCwoFY20L/wmp5oa0Ai+pC8/hoc9tze53K5h/QPwE7Tu9JeEg
         9PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5LwNlyhWbwD+zCERSO4ztMJWYfOnhHcRMc5JN9eiqc=;
        b=LvY5iW+XtIluGlVdMAM18DHwYFRe82KXPHSaSBhhF7M6EY/sHWUVjrZ36EwKMXt4iv
         QBkZL0olnyNqzx2DHchEjVIJaPMD0ZxlTIz8sDz9gvhdqxJoJ/ewqYHcmFOMnopRTQJ0
         TOvnWtyzVhWFFlr5187DMnBWtvC6xNKN8lei93v9wDNdRsiFPI9pMF/yDihBkON3NVT9
         lsT8Rl6Sil4aqULvTAga72DTG7MAZJhCwqe+DYzyeqWo1KUZ/cNkR5UJvBko9bIGORpQ
         tprTzUgJzyvZhpE9velJeOdUxdHbZi5HDRW85DzO0uCgqYnKCu8idynxTuioW+bkqGK5
         UV1A==
X-Gm-Message-State: AOAM532QkxISzMvjevhiGQHQzjbd7pLdKnyTpIvd6jXTiWHoa0kiPutY
        DSF6DgIa7pVvNQzLONv12H8JIPqRk2OMEyBz+9W/MUZUpHc=
X-Google-Smtp-Source: ABdhPJwjxkNnBHXXadEXzHG/vgIeCBavOGc0aglBpF6Gowf5iUVSkEGzI9m4ezC9tUElCGdjrskSSr66mZ1vwbpVFrY=
X-Received: by 2002:a05:6602:1695:b0:665:8390:fcf with SMTP id
 s21-20020a056602169500b0066583900fcfmr10970021iow.83.1653850702250; Sun, 29
 May 2022 11:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com>
 <20220527232604.GA22722@merlins.org> <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
 <CAEzrpqfAYRUYttOAMmdth4mfi4e7MTM++s5WOQ+KAzg2Kv0Nsw@mail.gmail.com>
 <20220528225601.GD24951@merlins.org> <CAEzrpqcG+9evRPKixVwGnAS_k2tb7o16jQgORtm1cw7hW_KsAw@mail.gmail.com>
 <20220529035139.GE24951@merlins.org> <CAEzrpqcKeVNkXa3txx0nyDnKUCp06msmd97d1fBedTzbmR5KcA@mail.gmail.com>
 <20220529153312.GF24951@merlins.org> <CAEzrpqdEk-j2bMfBLEdkhHcq1hWLmHv_Nx-0mj1vh0yJgZuCZQ@mail.gmail.com>
 <20220529180510.GG24951@merlins.org>
In-Reply-To: <20220529180510.GG24951@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 29 May 2022 14:58:11 -0400
Message-ID: <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
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

On Sun, May 29, 2022 at 2:05 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 29, 2022 at 01:32:48PM -0400, Josef Bacik wrote:
> > On Sun, May 29, 2022 at 11:33 AM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, May 29, 2022 at 11:00:35AM -0400, Josef Bacik wrote:
> > > > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > > > ERROR: cannot read chunk root
> > > > > WTF???
> > > > > ERROR: open ctree failed
> > > > > Tree recover failed
> > > >
> > > > Sorry, thought I fixed this before pushing yesterday, try again please.  Thanks,
> > >
> > > Resynced but it's the same:
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > WARNING: cannot read chunk root, continue anyway
> > > ERROR: Failed to read root block
> > > Tree recover failed
> >
> > Oh huh, apparently I only scan for a root if we didn't find a good fit
> > in the beginning, not if I couldn't read any roots.  Fixed that up,
> > please try again.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> WARNING: cannot read chunk root, continue anyway
> none of our backups was sufficient, scanning for a root
> ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
> Tree recover failed
>

Well if anything tree-recover will be rock solid by the end of this.
Try again please.  Thanks,

Josef
