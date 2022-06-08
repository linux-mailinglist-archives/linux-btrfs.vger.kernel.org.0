Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF95542658
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347074AbiFHDHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 23:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383452AbiFHDF7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 23:05:59 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E18198C13
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 17:32:44 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id p1so15462205ilj.9
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 17:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZ4stZBxRQkPyOP75TMwPS5j/80dXqGKN2JnULoObhM=;
        b=hN0ysbGBb/LD93DAkmtEyhydy1WQqyNw0sO6MFIg9N8JXRk3mfcNoOlb2LYGDc34V6
         NSwDCbz4ytRxI25HnV3L0TMW6tfrhXdlN78GuJa61BfXVl1zrZ9LcNV1Zt2n7DJhp23k
         oNJrPgITR6fLsYJrUvsNAP8mx9kWr1yRc4q2hTbSVRtdOHCqra3qkO3xTe/HbabCR926
         nxHsdQbVqGg+3R/yfd/aWzk9v//CZ4tuFmQhMmWw50nhCpg1sEUIcEwyJanin9wTGTwT
         rocMLmxgxm3luNo3KLMyzH1PPedPpH1M5diARS0T3axzz3WUlIOXaU3yvrYWfi70GLsm
         LZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZ4stZBxRQkPyOP75TMwPS5j/80dXqGKN2JnULoObhM=;
        b=k7Qj4pofJOo0WFMll3X2kjnmADjja+JjF+366dzjf2/AKz7svX1QuMPQF1d5LuHVwk
         1ny+QlvaNpL7kmxn7P0yumYgaWLPo08M8ZBQ5RWhV97LOJH3OmakOe8RL3AICU7Y7czw
         HPlKUyNmHlIb4nfiXdIek6ihJhtsfMj20dQ1BARI+to89Fmfw3j6aPlBxdQWQYNcgGOj
         bOGEt/ArAO7FZyE1eYGX8prJ3OWbSaXrYu2/7DrAnbRlTYF0Aiwz3BzumxixKQCgm0K3
         SIFgnWFFYyumCDBhHZpBU1JLXMeVVQKkFiqJEHsdDaxOsDAkIukIQUuIsi2PaqzVB77K
         1gEA==
X-Gm-Message-State: AOAM5303DCe+XRqoqFJu4AWorjkfSMVEuHM35t8QXQPSBfUATRWzFGkj
        PeYKGMpzKTyfU55K3dRls1pP1OI7tS585mfCh7kbf7V8+mA=
X-Google-Smtp-Source: ABdhPJyyMB1WeRRHVxhH00OZ8jA4VK3QJktszkwfJ8bNe0PfwXrp/rwvq5SUHh6UO7JuyzVRtYQAShvROpZEZl0Dud4=
X-Received: by 2002:a05:6e02:216a:b0:2d1:71a0:c2b8 with SMTP id
 s10-20020a056e02216a00b002d171a0c2b8mr18724996ilv.6.1654648363951; Tue, 07
 Jun 2022 17:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220607182737.GU1745079@merlins.org> <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
 <20220607195744.GV22722@merlins.org> <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
 <20220607204406.GX22722@merlins.org> <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
 <20220607212523.GZ22722@merlins.org> <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
 <20220607233734.GA22722@merlins.org> <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
 <20220608000700.GB22722@merlins.org>
In-Reply-To: <20220608000700.GB22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 20:32:33 -0400
Message-ID: <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
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

On Tue, Jun 7, 2022 at 8:07 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 07:41:32PM -0400, Josef Bacik wrote:
> > > > Ugh come on, this must get triggered because we clean up some stuff
> > > > and then the corrupt blocks are suddenly right next to eachother.  Can
> > > > you re-run tree-recover and see if it deletes those keys?  Thanks,
> > >
> > > Sorry :(
> > >
> > Ok I think it's just the check is wrong, I removed the check, maybe
> > I'll get lucky for once?  Thanks,
>
> that helped.
>
> (...)
> Found an extent we don't have a block group for in the file 652682866688
>
> Found an extent we don't have a block group for in the file 652682862592
>
> Found an extent we don't have a block group for in the file 652723212288
>
> Found an extent we don't have a block group for in the file 390870233088
> ref to path failed
> Couldn't find any paths for this inode
> Deleting [69105, 108, 0] root 15645018226688 path top 15645018226688 top slot 11 leaf 15645020864512 slot 1 nr 118
>
> searching 164823 for bad extents
> processed 163840 of 63193088 possible bytes, 0%
> Found an extent we don't have a block group for in the file 390870233088
> Couldn't find any paths for this inode
> Deleting [69134, 108, 36012032] root 15645018587136 path top 15645018587136 top slot 10 leaf 15645019553792 slot 45 nr 1
>
> searching 164823 for bad extents
> processed 196608 of 63193088 possible bytes, 0%
> Recording extents for root 3
> processed 180224 of 0 possible bytes, 0%
> Recording extents for root 1
> processed 999424 of 0 possible bytes, 0%
> doing roots
> Recording extents for root 4
> processed 163840 of 1064960 possible bytes, 15%
> Recording extents for root 5
> processed 65536 of 10960896 possible bytes, 0%
> Recording extents for root 7
> processed 16384 of 16570974208 possible bytes, 0%
> Recording extents for root 9
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 161197
> processed 131072 of 108986368 possible bytes, 0%
> Recording extents for root 161199
> processed 196608 of 49479680 possible bytes, 0%
> Recording extents for root 161200
> processed 180224 of 254214144 possible bytes, 0%
> Recording extents for root 161889
> processed 196608 of 49446912 possible bytes, 0%
> Recording extents for root 162628
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 162632
> processed 114688 of 94633984 possible bytes, 0%
> Recording extents for root 163298
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 163302
> processed 98304 of 94633984 possible bytes, 0%
> Recording extents for root 163303
> processed 131072 of 76333056 possible bytes, 0%
> Recording extents for root 163316
> processed 98304 of 108544000 possible bytes, 0%
> Recording extents for root 163920
> processed 16384 of 108691456 possible bytes, 0%
> Recording extents for root 164620
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 164623
> processed 311296 of 63193088 possible bytes, 0%
> Recording extents for root 164624
> processed 933888 of 108822528 possible bytes, 0%
> Recording extents for root 164629
> processed 622592 of 108838912 possible bytes, 0%
> Recording extents for root 164631
> ERROR: failed to insert the ref for the root block -17
> wtf
> it failed?? -17

That shouldn't happen.  I reworked the code a bit and added some
debugging, re-run init-extent-tree please.  Thanks,

Josef
