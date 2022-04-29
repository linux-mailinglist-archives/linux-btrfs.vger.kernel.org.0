Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE14514F6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 17:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378397AbiD2PcG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378400AbiD2Pb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 11:31:59 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2F6D893E
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 08:28:06 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e15so10146905iob.3
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrYxznt3GFfff/6p0w67N2nUdFqV3NsEbT32ibPuDD4=;
        b=IjrwWjLEowYtZgJdxrNTC0zWs93RTagMARTENTDYdPLBfrSMHQbSkJCGeOpZeHTyPh
         xeBbo+Tg0Hby+y7Gk03IHXFJczwp7oQYwT5FuOC7U/YSHsyMybti9nXw/9PCifVkLQgo
         tmJiLDW/2/fb1Rhs8MHLIQbCHMQ9J68BL8vCSmQyn1LgJ42oT3dvgUsRdYqNNNBw8x2u
         iyAZN0yi8dA9oRf3xtdpdPxGI9Q6hkvpPtoEsjcw5ulLOGi/4KkExM+X72LevQMbuie7
         dlMpApFl7geyf+WNdJ4vSN3uAbK8mihNrqg4mSZkNJ6etMJwA17M8QizZ09NqyeMlyvA
         6MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrYxznt3GFfff/6p0w67N2nUdFqV3NsEbT32ibPuDD4=;
        b=zbuQq4xkQNBrs8uWKi/IRf4eop8VRevSicxPWAMD8kHTBN8qRJF/SvI14fxUC7ldnn
         4lTM3RRy2UR5y6v1pTAciPDYiGnTAHMVMjwqoWgHfgNeOze2xxVbH6rP8hR5z83X43RS
         aUivNSgnj+zYx3+bNoMlNOcy66lVsVkACnJt4lxoYHeWNOUVDIrLsp3aRJdIT8GRLZSo
         Yk82W/REmhzwZrgCC708GlBG1Ol7SKjOOAusRTFZDGQEXyX9WriQ53f9e+dfYehdLQaL
         GeKthy2Vqbt+AqVfh5b1INmHXT7onrSTEEK2ZKC2iLWufJLx08H4HlcqYkJFS2KSjEW+
         fdQA==
X-Gm-Message-State: AOAM533tgZArYtO5WH7nPK3aOYNnss1ogvW+xIS5NIbs2C3U3+/fxPKH
        FrPgAVTC4qgTJZK+U5qV/wuZUWLro7QUUjNKiWAjlNVATQ4=
X-Google-Smtp-Source: ABdhPJx4RDH0Xg6qlA0rEJZfQsHH0IjCbCA8CIxFxN4guSgEFVJZEEzy84a45nUksIJFywkHFy46lVNPt2uxZ+6QkoM=
X-Received: by 2002:a02:6010:0:b0:31a:6d4f:d9ca with SMTP id
 i16-20020a026010000000b0031a6d4fd9camr16431632jac.46.1651246085191; Fri, 29
 Apr 2022 08:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220428214241.GW29107@merlins.org> <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
 <20220428222705.GX29107@merlins.org> <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
 <20220429005624.GY29107@merlins.org> <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
 <20220429013409.GD12542@merlins.org> <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
 <20220429040335.GE12542@merlins.org> <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
 <20220429151653.GF12542@merlins.org>
In-Reply-To: <20220429151653.GF12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 29 Apr 2022 11:27:54 -0400
Message-ID: <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 11:16 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Apr 29, 2022 at 08:41:00AM -0400, Josef Bacik wrote:
> > Yayyyy progress, I just updated the debugging for the new problem
> > bytenr so we can figure out who to delete, run init-extent-tree again
> > please.  Thanks,
>
> sure:
> inserting block group 15837217947648
> inserting block group 15838291689472
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1474560 of 0 possible bytes
> Recording extents for root 4
> processed 1032192 of 1064960 possible bytes
> Recording extents for root 5
> processed 10960896 of 10977280 possible bytes
> Recording extents for root 7
> processed 16384 of 16545742848 possible bytes
> Recording extents for root 9
> processed 16384 of 16384 possible bytes
> Recording extents for root 11221
> processed 16384 of 255983616 possible bytes
> Recording extents for root 11222
> processed 49479680 of 49479680 possible bytes
> Recording extents for root 11223
> processed 1635319808 of 1635549184 possible bytes
> Recording extents for root 11224
> processed 75792384 of 75792384 possible bytes
> Recording extents for root 159785
> processed 108855296 of 108855296 possible bytes
> Recording extents for root 159787
> processed 49152 of 49479680 possible bytes
> Recording extents for root 160494
> processed 999424 of 109035520 possible bytesWTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths
> inode ref info failed???
> elem_cnt 1 elem_missed 0 ret 0
> misc/add0/new/tv1/ST/testfile.avi
> Failed to find [10467695652864, 168, 8675328]
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x555565529a60, parent_transid=parent_transid@entry=1619139)
>     at kernel-shared/disk-io.c:2235
> 2235            ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
>
> We're making progress, thanks. Is there a way to add a BUG_ON instead of
> the subsequent SEGV?

Yup done.  Also it's because I'm looking for the key in "dumping
paths" higher up.  This one is weird because we only got one output,
so for this one you want

-d "76300,108,0" -r 160494

Thanks,

Josef
