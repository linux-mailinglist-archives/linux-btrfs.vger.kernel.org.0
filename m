Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21CC54D38A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 23:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349999AbiFOVTI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 17:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349978AbiFOVTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 17:19:07 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CDF55490
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 14:19:05 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z11so9667894ilq.6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuhlzdQOX4wZkoN22Th5dWjFj1pmKHIaVAFD+a7+5+8=;
        b=RM7KAyghS13RzSzyc6OaRHo4nXZGMJGEQoKulDgCtDHT/Ec8jv1EQr7v9d4crmbz75
         Zed3Jn87UQilSjTxliVwW1M709e71dO7S3xy+GSr2p3M17G4Oj1onisF81lLc99EEl3S
         B/VkDd05N4Htt3bPoO4s9E09J1YmGIbqJirliRye+0k273CEPERy11IaOaN75VTbn/+/
         yh5pjzIsAQj4zwNU407+3uFpG9jzGkUIWQtaIdeQo/hYFN6DvbJay7tGKOFhPSk+nlKF
         2EOXh6u0raHxONqGvb+D4LGFDa/uicHdBUqIqAJx7yeE2afmjCl0XRep7PcgUdkn3ds/
         km3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuhlzdQOX4wZkoN22Th5dWjFj1pmKHIaVAFD+a7+5+8=;
        b=orzqckzC5L8cda9Y1L/R5UFGUQ/0nbWi5o93h2LM2fp7c4ZTotjwb9vCF1RjW8UZnH
         OPCAtEIkhuHIaY81uTIK4uBZJuXnt8TmHGV/iHv3LEEQYlyPjYTlhXOWUwc+wi8rduje
         0JCvjiwaEv0WCLBVN+T1WFMofpeEz7znrI1+Hd4TcOSvMEAJR6G1J87QzuQp8eqFtucl
         p/Q9VPIjgWobFQ4aYkEEU1fGfeKjJ1aUBrXf8RocRPgsiyMfh6lRjOp5JC3WmtaMaoon
         FmTC7hyiZlJcPnGy4TRAUfcQHq4S5dKnXUHE0KlicUmSIT33VCJLIN8T7mg4AuHNybDg
         ERNQ==
X-Gm-Message-State: AJIora9GJRNRmCYKosnknCU/m9Ym36Hq+La5tib87txwDGGSN8vKQJVO
        QfRcTwVQMwY+16zQOlEekw6KnVkSWfLbsAEi5l0aHOreLFo=
X-Google-Smtp-Source: AGRyM1txOLjTFWJZwnjuTQk1cSy07t418bxbHbVfDuQdBg63mgvhY4TQOyqtZ1lAZFnzUyMquEqbXD7QwRedqkEnGd8=
X-Received: by 2002:a05:6e02:156e:b0:2d1:c265:964f with SMTP id
 k14-20020a056e02156e00b002d1c265964fmr1034483ilu.153.1655327945117; Wed, 15
 Jun 2022 14:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org> <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220615142929.GP22722@merlins.org> <20220615145547.GQ22722@merlins.org>
In-Reply-To: <20220615145547.GQ22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 15 Jun 2022 17:18:54 -0400
Message-ID: <CAEzrpqdRn9mO0pDOogf37qWH07GryACqidHDbZcpoe7t73GDeQ@mail.gmail.com>
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

On Wed, Jun 15, 2022 at 10:55 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 15, 2022 at 07:29:29AM -0700, Marc MERLIN wrote:
> > gargamel:/mnt/mnt# btrfs scrub start -B .
> > running that now, I expect it will take a while.
>
> Never mind, it was fast:
> gargamel:/mnt/mnt# btrfs scrub start -B .
> scrub done for 96539b8c-ccc9-47bf-9e6c-29305890941e
> Scrub started:    Wed Jun 15 07:28:02 2022
> Status:           finished
> Duration:         0:03:33
> Total to scrub:   111.00GiB

Hrm shit, this isn't good, don't you have a lot more data than 111gib?

> Rate:             98.39MiB/s
> Error summary:    verify=14
>   Corrected:      14
>   Uncorrectable:  0
>   Unverified:     0
> WARNING: errors detected during scrubbing, corrected
>
> > > The next thing is to fix the fs errors, which I imagine will cause
> > > other problems like not being able to find directories and files and
> > > such.  Once we've gotten the csum tree and the scrub done we can
> > > tackle the remaining fs error problems which should be less terrifying
> > > to mess with.  Thanks,
> >
> > would that be check --repair ?
>
> here's check without repair:
>
> [1/7] checking root items
> [2/7] checking extents
> ref mismatch on [11160501911552 16384] extent item 1, found 0
> backref 11160501911552 root 7 not referenced back 0x56389bce5cd0
> incorrect global backref count on 11160501911552 found 1 wanted 0
> backpointer mismatch on [11160501911552 16384]
> owner ref check failed [11160501911552 16384]
> ref mismatch on [11160502042624 16384] extent item 1, found 0
> backref 11160502042624 root 7 not referenced back 0x56389bce44d0
> incorrect global backref count on 11160502042624 found 1 wanted 0
> backpointer mismatch on [11160502042624 16384]
> owner ref check failed [11160502042624 16384]
> ref mismatch on [11160502845440 16384] extent item 1, found 0
> backref 11160502845440 root 7 not referenced back 0x56389be42060
> incorrect global backref count on 11160502845440 found 1 wanted 0
> backpointer mismatch on [11160502845440 16384]
> owner ref check failed [11160502845440 16384]
> ref mismatch on [11160502927360 16384] extent item 1, found 0
> backref 11160502927360 root 7 not referenced back 0x56389be42560
> incorrect global backref count on 11160502927360 found 1 wanted 0
> backpointer mismatch on [11160502927360 16384]
> owner ref check failed [11160502927360 16384]
> ref mismatch on [15645021241344 16384] extent item 1, found 0
> backref 15645021241344 root 7 not referenced back 0x56389bdc98a0
> incorrect global backref count on 15645021241344 found 1 wanted 0
> backpointer mismatch on [15645021241344 16384]
> owner ref check failed [15645021241344 16384]

Oh oops, I must have missed this in the init-extent-tree.  Let me look
into this and I'll let you know when you can run the code again.

> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> Couldn't find free space inode 1
> Couldn't find free space inode 1
> (...)
> Couldn't find free space inode 1
> Couldn't find free space inode 1
> [4/7] checking fs roots
> root 161199 inode 54988 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 1572864
> root 161199 inode 54989 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 16252928, len: 91824128
>         unresolved ref dir 54974 index 16 name foo filetype 0 errors 3, no dir item, no dir index
> root 161199 inode 55003 errors 500, file extent discount, nbytes wrong
> Found file extent holes:
>         start: 0, len: 1048576
> root 161199 inode 55004 errors 500, file extent discount, nbytes wrong
> Found file extent holes:
>         start: 0, len: 1048576
>         unresolved ref dir 56235 index 12 name foo filetype mismatch
> root 161199 inode 55409 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 55399 index 11 name foo filetype 0 errors 3, no dir item, no dir index
> root 161199 inode 55410 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 1572864
> root 161199 inode 55411 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 55399 index 13 name foo filetype 0 errors 3, no dir item, no dir index
> root 161199 inode 55412 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 1048576
>         unresolved ref dir 55399 index 14 name foo filetype 0 errors 3, no dir item, no dir index
> root 161199 inode 55413 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 24117248, len: 34611200
>         unresolved ref dir 55399 index 15 name foo filetype 0 errors 3, no dir item, no dir index
> root 161199 inode 55459 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 56098816, len: 265449472
>         unresolved ref dir 55437 index 23 name foo filetype 0 errors 3, no dir item, no dir index
> root 161199 inode 55468 errors 100, file extent discount
> Found file extent holes:
>         start: 27787264, len: 302174208
> root 161199 inode 55475 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 1048576
> root 161199 inode 55476 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 28803072, len: 459870208
>         unresolved ref dir 55437 index 40 name foo filetype 0 errors 3, no dir item, no dir index
> root 161199 inode 55526 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 524288
> root 161199 inode 55527 errors 100, file extent discount
> Found file extent holes:
>         start: 26738688, len: 462848
> root 161199 inode 55528 errors 100, file extent discount
> Found file extent holes:
>         start: 16252928, len: 184320
> root 161199 inode 55530 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 524288
> root 161199 inode 55531 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 4194304, len: 11001856
>         unresolved ref dir 55511 index 21 name foo filetype 0 errors 3, no dir item, no dir index
> root 161889 inode 54988 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 1572864
> root 161889 inode 54989 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 16252928, len: 91824128
>         unresolved ref dir 54974 index 16 name foo filetype 0 errors 3, no dir item, no dir index
> root 161889 inode 55003 errors 500, file extent discount, nbytes wrong
> Found file extent holes:
>         start: 0, len: 1048576
> root 161889 inode 55004 errors 500, file extent discount, nbytes wrong
> Found file extent holes:
>         start: 0, len: 1048576
>         unresolved ref dir 56235 index 48 name foo filetype mismatch
> root 161889 inode 55409 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 55399 index 11 name foo filetype 0 errors 3, no dir item, no dir index
> root 161889 inode 55410 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 1572864
> root 161889 inode 55411 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 55399 index 13 name foo filetype 0 errors 3, no dir item, no dir index
> root 161889 inode 55412 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 1048576
>         unresolved ref dir 55399 index 14 name foo filetype 0 errors 3, no dir item, no dir index
> root 161889 inode 55413 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 24117248, len: 34611200
>         unresolved ref dir 55399 index 15 name foo filetype 0 errors 3, no dir item, no dir index
> root 161889 inode 55459 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 56098816, len: 265449472
>         unresolved ref dir 55437 index 23 name foo filetype 0 errors 3, no dir item, no dir index
> root 161889 inode 55468 errors 100, file extent discount
> Found file extent holes:
>         start: 27787264, len: 302174208
> root 161889 inode 55475 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 1048576
> root 161889 inode 55476 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 28803072, len: 459870208
>         unresolved ref dir 55437 index 40 name foo filetype 0 errors 3, no dir item, no dir index
> root 161889 inode 55526 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 524288
> root 161889 inode 55527 errors 100, file extent discount
> Found file extent holes:
>         start: 26738688, len: 462848
> root 161889 inode 55528 errors 100, file extent discount
> Found file extent holes:
>         start: 16252928, len: 184320
> root 161889 inode 55530 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 524288
> root 161889 inode 55531 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 4194304, len: 11001856
>         unresolved ref dir 55511 index 21 name foo filetype 0 errors 3, no dir item, no dir index
> root 163920 inode 76551 errors 100, file extent discount
> Found file extent holes:
>         start: 1037262848, len: 184238080
> root 163920 inode 76556 errors 100, file extent discount
> Found file extent holes:
>         start: 1639038976, len: 213225472
>         unresolved ref dir 791 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 3676 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 72785 index 720 name foo filetype mismatch
>         unresolved ref dir 791 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 3676 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 73103 index 544 name foo filetype mismatch
>         unresolved ref dir 73103 index 672 name foo filetype mismatch
>         unresolved ref dir 4179 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 4698 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 5506 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 5546 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
> root 164624 inode 25918 errors 500, file extent discount, nbytes wrong
> Found file extent holes:
>         start: 0, len: 1262850048
> root 164624 inode 72429 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 1333788672, len: 3217154048
>         unresolved ref dir 72438 index 4 name foo filetype 0 errors 3, no dir item, no dir index
> root 164624 inode 72433 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 892338176, len: 14957748224
>         unresolved ref dir 34951 index 13 name foo filetype 0 errors 3, no dir item, no dir index
> root 164624 inode 72593 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 42074112, len: 413642752
>         unresolved ref dir 75036 index 19 name foo filetype 0 errors 3, no dir item, no dir index
>         unresolved ref dir 73103 index 1524 name foo filetype mismatch
> root 164624 inode 73009 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 13869056, len: 53100544
>         unresolved ref dir 72672 index 134 name foo filetype 1 errors 1, no dir item
> root 164624 inode 73083 errors 500, file extent discount, nbytes wrong
> Found file extent holes:
>         start: 197263360, len: 399777792
> root 164624 inode 73094 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 74963 index 32 name foo filetype 0 errors 3, no dir item, no dir index
> root 164624 inode 73097 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 74963 index 36 name foo filetype 0 errors 3, no dir item, no dir index
>         unresolved ref dir 791 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 3676 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 73103 index 540 name foo filetype mismatch
>         unresolved ref dir 4179 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 4698 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 5506 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 5546 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
> root 164629 inode 39921 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 759824384, len: 2143326208
>         unresolved ref dir 10205 index 356 name foo filetype 0 errors 3, no dir item, no dir index
> root 164629 inode 72429 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 1333788672, len: 3217154048
>         unresolved ref dir 72438 index 4 name foo filetype 0 errors 3, no dir item, no dir index
> root 164629 inode 72433 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 892338176, len: 14957748224
>         unresolved ref dir 34951 index 13 name foo filetype 0 errors 3, no dir item, no dir index
> root 164629 inode 72593 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 42074112, len: 413642752
>         unresolved ref dir 75036 index 19 name foo filetype 0 errors 3, no dir item, no dir index
>         unresolved ref dir 73103 index 1386 name foo filetype mismatch
> root 164629 inode 73009 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 13869056, len: 53100544
>         unresolved ref dir 72672 index 134 name foo filetype 1 errors 1, no dir item
> root 164629 inode 73083 errors 500, file extent discount, nbytes wrong
> Found file extent holes:
>         start: 197263360, len: 399777792
> root 164629 inode 73094 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 74963 index 32 name foo filetype 0 errors 3, no dir item, no dir index
> root 164629 inode 73097 errors 2500, file extent discount, nbytes wrong, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 74963 index 36 name foo filetype 0 errors 3, no dir item, no dir index
>         unresolved ref dir 791 index 0 name foo filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 3676 index 0 name foo filetype 1 errors 6, no dir index, no inode ref

Ok the rest of these are going to take some work to fix up.  I'll work
on that as well.  Thanks,

Josef
