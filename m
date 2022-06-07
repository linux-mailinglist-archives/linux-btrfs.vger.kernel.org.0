Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE7542727
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiFHA2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 20:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388766AbiFGWwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 18:52:21 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D990C6543A
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 12:46:24 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s23so16623449iog.13
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z57SlMVmPCmI7/9pVbdhny/yoaenRUXoaGMRVNbWfzs=;
        b=g7TtgRg0EY3iK40wY/1yfq4/rmlYjkkZ7VACIqVozOfp36CstBJtvscPV48xQbi3v2
         3wzWREHjH1M/lyiuLMkR2NJ7F+hIPThoOYdsufOl0m9QKsG+peKsnZE1WuxulHiGmNIu
         +UB1H39Sffy1g498v/EVhG1pt8DH+FWOBKZ8RKic6AIE30whs63xCVV1Pk4wLLEtBVzB
         zuLGz9x6rpuQRNYA+Ylq7MRu9HhErc7lxiNDQWT5vG7Xft1wBtrUrkOk3o3bhhVuMw72
         3ohSr34IxinbjoB8ee46VIGQHCDBVJ3WWUaVFCPRl3kH/zo/Zp3EgUCQzbWgSlAt+8Wy
         5T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z57SlMVmPCmI7/9pVbdhny/yoaenRUXoaGMRVNbWfzs=;
        b=s/XDOI4TLwBQe4qZauaO+9X+yIlGcwYy8UC1ij2DfCnqzPenHnIgO9C3tP/yNYz5kb
         0taKe9RR7JwKSyWVHrJEkFB4//jfnAk+Kl5hDLgqIt32F8Vc4HddZBFtumph/TAyWlpT
         nZ6+NrYX3rD+UHmwJMFqmSdf+1Fiq8QSEf5Jwu579SnAyWcUK2tMFZgGRN9fk3ULNCpw
         OmXZyieeFQRzOll4rLsHPzO5LZy2t4yqYi/RvZ/1E7fLyuhOmfPojClWyxBidaZ7SpIY
         8Ip8fQCUv66flCcc7T3MoLCcpFOT8mL/u3Ap+l3Jt3gZKc4A18V2laoyiLjwKQ8Gx54Z
         aZBw==
X-Gm-Message-State: AOAM533MX2+76Ud+W6bFlNeJqr8BmaZdcqGqYkW6VXHoj6a1VF8QbSLl
        c9iYVpkaYdPJr76oNWA2CWeRDBiRqxiw1yAH26K2tIPPqI0=
X-Google-Smtp-Source: ABdhPJyNmuVavJBusB/a2z7PlXv+6R41OHiL7OtAl6YKKwCa4Vjm5MStIAoP+OVd3KCUy8w4eiyL8hKqgYuKxmbPHHk=
X-Received: by 2002:a05:6638:22cf:b0:331:a5b9:22f2 with SMTP id
 j15-20020a05663822cf00b00331a5b922f2mr7377481jat.218.1654631183554; Tue, 07
 Jun 2022 12:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220606221755.GO22722@merlins.org> <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
 <20220607023740.GQ22722@merlins.org> <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
 <20220607032240.GS22722@merlins.org> <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
 <20220607151829.GQ1745079@merlins.org> <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
 <20220607153257.GR1745079@merlins.org> <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
 <20220607182737.GU1745079@merlins.org>
In-Reply-To: <20220607182737.GU1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 15:46:12 -0400
Message-ID: <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
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

On Tue, Jun 7, 2022 at 2:27 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 01:56:38PM -0400, Josef Bacik wrote:
> > On Tue, Jun 7, 2022 at 11:32 AM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Tue, Jun 07, 2022 at 11:21:57AM -0400, Josef Bacik wrote:
> > > > Can you capture all of these lines and paste them?  We found a bunch
> > > > of old block groups but we may not have found everything.  I might
> > > > want to try manually going and looking for those chunks just so we can
> > > > avoid mass deleting things.  Thanks,
> > >
> > > https://pastebin.com/dPzJgVU9
> >
> > Ok re-run it, it'll crash right as it tries to delete something, I
> > need the bytenr it's complaining about.  Thanks,
>
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
> processed 49152 of 109264896 possible bytes, 0%
> Found an extent we don't have a block group for in the file 1258276585472
> cmds/rescue-init-extent-tree.c:246: process_leaf_item: BUG_ON `bytenr` triggered, value 1258276585472

Perfect, this isn't in our list, so we definitely don't have it.  I've
added some debugging to recover-chunks, can you run btrfs rescue
recover-chunks and capture it's output?  We may not find this chunk
and in that case it needs to just delete stuff, but I'd like to try a
little harder before we give up.  Thanks,

Josef
