Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D385422D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376630AbiFHA3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 20:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451893AbiFGXNQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 19:13:16 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD3C3A7BE7
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 13:59:10 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s1so15183291ilj.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXwm++VzZDMNEKUCIc30GiyP1KNsRx3tcoVZ4wOCZJA=;
        b=D3cgIXXj6d0IY39GInKI0ejqlpRDpaYqG+BJcjWbIHXGifKRiT/Ee/n6frXMxShuNX
         xOBeHFyVBAs3OuKeHrPZynLzSe7jjjMeq/ilKVuXNbH2KIUIqQ7l1+GiBlRxJHk02lqi
         8J0Y+whhev4V8ms1O6xvmDchT5JtQqvIp7wzQv42KwHArL2wQtKJmZV3AC5xRZrs7+w+
         Muyv9oZzDhXnu6kS7iNYVKh1KlX79mC7JSHiQzn3PNhQ6IqSBPrUdqgXOtSbPkUDDJ1R
         gsQKn3ywAQvJrYrfQpvq2j6LEgDQLakVgYyfNEOZpe7BZ8R9J/6sEjGRIZfJQ3WlRwKv
         JeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXwm++VzZDMNEKUCIc30GiyP1KNsRx3tcoVZ4wOCZJA=;
        b=n33RKMuOGoDKk4AyY4yL1AI2kXmE2jM6mQLrroA7S1JLavQvRCWzjvm2sIyKUpwNbg
         gJBmBuq7nyomVD0/c7Tqcgg/28QKHeFUHMnDZoGeNriEo7RVtQusaxj93MdxNPpFipvo
         uE0/+WnVced19SQw+ffqqzuLxBWcn5V5X5kuDshaS881HvYAz5MAQRYJM/Yed8gPNMvg
         yvNEw8xmBmnsrnmo1QFGk+JXlCdgCT4LsG1gslEq4zEc6cxC1PxzJaiji3Mu6ybRDXfs
         zK54uLrQRhmWZrFNNOlxK+dPijjMJn+iCxcpDW/O/2xutx8LlU7ENJ08KWASNoz6UCMn
         swaA==
X-Gm-Message-State: AOAM532VVGubm1YdmUHGWYyiF+ZjZZrMyLlchvHDwMUIXPWZNFiapjhV
        EHBbQHizAJnW/OoPaaj6whVz1JlpCvGSPp0G8NGAEnwS0Kc=
X-Google-Smtp-Source: ABdhPJztvid5O3sYTytpG1gAJx3SXNKQ75bjUG2s+o+32CyAaNFyb24qEYx+sruTSMVJG7L0HPqwHPWbMTSiTWV+OcQ=
X-Received: by 2002:a05:6e02:216a:b0:2d1:71a0:c2b8 with SMTP id
 s10-20020a056e02216a00b002d171a0c2b8mr18316543ilv.6.1654635549114; Tue, 07
 Jun 2022 13:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220607032240.GS22722@merlins.org> <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
 <20220607151829.GQ1745079@merlins.org> <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
 <20220607153257.GR1745079@merlins.org> <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
 <20220607182737.GU1745079@merlins.org> <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
 <20220607195744.GV22722@merlins.org> <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
 <20220607204406.GX22722@merlins.org>
In-Reply-To: <20220607204406.GX22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 16:58:57 -0400
Message-ID: <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
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

On Tue, Jun 7, 2022 at 4:44 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 04:10:02PM -0400, Josef Bacik wrote:
> > Alright it looks like we've gotten everything we're going to get, go
> > ahead and let init-extent-tree do its thing.  Thanks,
>
> Argh, it ran for a while and then it crashed, but I didn't have it run under gdb.
>
> searching 164624 for bad extents
> processed 655360 of 109084672 possible bytes, 0%
> Found an extent we don't have a block group for in the file 12283412910080
> ref to path failed
> Couldn't find any paths for this inode
> Deleting [26761, 108, 34557952] root 15645018243072 path top 15645018243072 top slot 40 leaf 15645020192768 slot 3
>
> searching 164624 for bad extents
> processed 655360 of 109084672 possible bytes, 0%
> Found an extent we don't have a block group for in the file 12283452309504
> ref to path failed
> Couldn't find any paths for this inode
> Deleting [26761, 108, 43954176] root 15645019504640 path top 15645019504640 top slot 40 leaf 15645020028928 slot 3
> Segmentation fault
>
> re-running it thankfully crashed in the same place
> processed 655360 of 109084672 possible bytes, 0%
> Found an extent we don't have a block group for in the file 12283452309504
> ref to path failed
> Couldn't find any paths for this inode
> Deleting [26761, 108, 43954176] root 15645019586560 path top 15645019586560 top slot 40 leaf 15645019602944 slot 3
>

Ok I think I fixed that, but I also updated the loop to bulk delete as
many bad items in a leaf at a time, hopefully this will make it go
much faster.  Expect more fireworks with the new code.  Thanks,

Josef
