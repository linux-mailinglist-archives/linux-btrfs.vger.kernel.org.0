Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FB753DEDF
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 01:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbiFEXDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 19:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiFEXDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 19:03:44 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5A37BCC
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 16:03:43 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s26so764231ioa.3
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jun 2022 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2E4JTp8OG12OkdmlGmAzUzmNr8H4MH4YhH6i5QT6tGM=;
        b=EhfaWUlvaQcXaSK/zvIMjrxY5ilW/tCVXSeG0g4V0TSOCcpRsih/KjbBUXPnRDkReU
         kvaGNOdAtUqDF1ZoFTyNF9qP9fYqD6+ColZxRtBsm//pfyYy3fZdDi2GtrAf91yNKc7J
         0EiONT5FmlJSvWhyPA4sjMZqbBPlUWe+ZvYTfhiyjxDwou3egAIQW9iHpBVcvaTsz0t6
         ba7w2PCEYJqQsGX3cO6mUdDULs8anXoiR5S3X+W2SNXKOWn8OBMxaVfS/C+3mmj88mZ/
         gS1qppXhgyC7Ti+S9eJPyuF+CIYxc4eYYuHAlu8pzo6mrAJwArr0UdgpXmdcH01Cry+J
         qxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2E4JTp8OG12OkdmlGmAzUzmNr8H4MH4YhH6i5QT6tGM=;
        b=cA+VqyaDou1UCB/4xIyit43JxfnIn9H1m3kZXXRRXXumvN3hH3bje/HPPmDH2Sxax/
         WEIGO0Al6SAOznsjZhUf5jLWOTDcPdxTXRWy4091WCSfrzf57R1asci6s0+1pudtUZCo
         zBPuRgZUoelxjIq3QgvC/lhADoJLEZ7t9YaFNum4cvf/PqYJ5X6sWil+zuABeeCgiEum
         t29p/ytuhtO3byuvHFjhSNZsMa9WmKuhxe0dWQA+AJUNooVdX/FZROm/5RzUAUwmtsGn
         YArGYTuGfKFjmIh3K42Z8zjYHTbQNtuymHQgFQ2ZHlVLiKkMGWrPjKhkAt8CJJdvoLFm
         kA0Q==
X-Gm-Message-State: AOAM530TD4i0BKiDb45c/1paM+AmPa/41yIPoTw+3HZmTPuC624c6LNC
        yQBFejEiYzqHJiapJiie791W9z24eebFzhEJbpvYR6KhV1U=
X-Google-Smtp-Source: ABdhPJwgFcuSyjjoaqeOeNpseyLpXhRZRs1fAc+cxmd6xgWm03s7VpucivfzQ06OHuMIEz8KOPfWMjIY36fV/YmvMXI=
X-Received: by 2002:a05:6638:238b:b0:32e:e939:fee6 with SMTP id
 q11-20020a056638238b00b0032ee939fee6mr12112082jat.281.1654470222407; Sun, 05
 Jun 2022 16:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220603183927.GZ22722@merlins.org> <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
 <20220604134823.GB22722@merlins.org> <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
 <20220605001349.GJ1745079@merlins.org> <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
 <20220605201112.GN1745079@merlins.org> <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
 <20220605212637.GO1745079@merlins.org> <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
 <20220605215036.GE22722@merlins.org>
In-Reply-To: <20220605215036.GE22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 5 Jun 2022 19:03:31 -0400
Message-ID: <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
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

On Sun, Jun 5, 2022 at 5:50 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Jun 05, 2022 at 05:43:41PM -0400, Josef Bacik wrote:
> > On Sun, Jun 5, 2022 at 5:26 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, Jun 05, 2022 at 04:58:15PM -0400, Josef Bacik wrote:
> > > >
> > > > Sigh try again please.  Thanks,
> > >
> > > Same
> >
> > Sorry, this one should work.  Thanks,
>
> FS_INFO IS 0x555555650bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x555555650bc0
> Walking all our trees and pinning down the currently accessible blocks
> corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15054972026880 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 root bytenr 1 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> Clearing the extent root and re-init'ing the block groups
> deleting space cache for 11106814787584
> deleting space cache for 11108962271232
> deleting space cache for 11110036013056
> deleting space cache for 11111109754880
> deleting space cache for 11112183496704
> (...)
> inserting block group 15929559744512
> inserting block group 15930633486336
> inserting block group 15931707228160
> inserting block group 15932780969984
> inserting block group 15933854711808
> ERROR: Error reading data reloc tree -2
>
> ERROR: failed to reinit the data reloc root
> searching 1 for bad extents
> processed 999424 of 0 possible bytes, 0%
> searching 4 for bad extents
> processed 163840 of 1064960 possible bytes, 15%
> searching 5 for bad extents
> processed 65536 of 10960896 possible bytes, 0%
> searching 7 for bad extents
> processed 16384 of 16570974208 possible bytes, 0%
> searching 9 for bad extents
> processed 16384 of 16384 possible bytes, 100%
> searching 161197 for bad extents
> processed 131072 of 108986368 possible bytes, 0%
> searching 161199 for bad extents
> processed 196608 of 49479680 possible bytes, 0%
> searching 161200 for bad extents
> processed 180224 of 254214144 possible bytes, 0%
> searching 161889 for bad extents
> processed 229376 of 49446912 possible bytes, 0%
> searching 162628 for bad extents
> processed 49152 of 49463296 possible bytes, 0%
> searching 162632 for bad extents
> processed 147456 of 94633984 possible bytes, 0%
> searching 163298 for bad extents
> processed 49152 of 49463296 possible bytes, 0%
> searching 163302 for bad extents
> processed 147456 of 94633984 possible bytes, 0%
> searching 163303 for bad extents
> processed 131072 of 76333056 possible bytes, 0%
> searching 163316 for bad extents
> processed 147456 of 108544000 possible bytes, 0%
> searching 163920 for bad extents
> processed 16384 of 108691456 possible bytes, 0%
> searching 164620 for bad extents
> processed 49152 of 49463296 possible bytes, 0%
> searching 164623 for bad extents
> processed 311296 of 63193088 possible bytes, 0%
> searching 164624 for bad extents
>
> Found an extent we don't have a block group for in the file
> corrupt node: root=164624 root bytenr 15645018226688 commit bytenr 0 block=15645018324992 physical=15053898285056 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> Couldn't find any paths for this inode
> corrupt node: root=164624 root bytenr 15645019652096 commit bytenr 15645018226688 block=15645019668480 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> ERROR: error searching for key?? -1 root 164624 node 15645019652096 commit 15645018226688
>

I wonder if our delete thing is corrupting stuff.  Can you re-run
tree-recover, and then once that's done run init-extent-tree?  I put
some stuff to check block all the time to see if we're introducing the
problem.  Thanks,

Josef
