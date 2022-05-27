Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37345366F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbiE0SfT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 14:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiE0SfS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 14:35:18 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4257CDE9
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 11:35:17 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id p4so3069306ilj.8
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijFELm6Fqm3FQw+hn4RDUxf89Yl61mfmgubE99nFVsE=;
        b=ZyA9X2vMA4Pej6ZiE7ODsDVXIDslAqQgeY41Mpt3eth2cvu90dLO2P+MCfDltliAbp
         a03raEmBKg203+9EUXXUzlTcOySTCngcmfPBksRdtOeuskkZPr+O4fb8DXRMi2UpvWwh
         EAimRNoNtg10JhpMjtD0SGP62KdDar8dhLGgEyg3PKvJoBsj6rOTkB6RzzHcpFLtGtnA
         ZFEPRUMRTxYP6GRDzHyYmNd0NNWWa6jYCadvSsqtAgC5oESaDT/ctxb81r7tdtNwOyk8
         PKQ8I4mO5iua/34/9s5I3BmHQpDqHLqV7691it54hIwXzBtrlCG2vS37PJE7f6V7nlLj
         2t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijFELm6Fqm3FQw+hn4RDUxf89Yl61mfmgubE99nFVsE=;
        b=4COV0/6M1hK2uV642ESX8Z4Y111aw6VvDfPRgN8aZfQprmsAG52C0sFyzV+mPIwdTD
         QczvkLgcuJ9O8Sd3MXSSDnvDEWxOiitY1B66wQskY5xROTdriOFWmib4jraxvKH2Y/2N
         z3uJW9NISebSsfVQCGETfOE8jMKzxtHNS6yB6IgThDRkEJuoxKU0y4TiipF5JmYdeSpW
         9M/yqYlKNYsP3MGA4ebw8VqF+P1kjWmlXWL6sUfmUtE5t0Il7S0wYZiwwf5OpC8MqoJV
         lc/sdb445Sjpm2RGix22vBPMrDYrVTqKTmor2RjxfVAoJRkFo/360YDFa3b3DHaWyL0o
         7mhA==
X-Gm-Message-State: AOAM531FHvho5w+3krZldD78fpqRBC97s2I4qFUcA6jZZ8mo8wGlVC86
        iwUlPln6EDVVqSWTSkKjr2iY53tCoh/BGYmjZXhPXCbWx2g=
X-Google-Smtp-Source: ABdhPJyONKXDGpgQxnyISC+WyXiLl75BNXDyqTiFbA3OObIrM4/Q3LO/C6u+NzZFFq8q33ZyrwRvVNpzpey+GORnnzM=
X-Received: by 2002:a92:c641:0:b0:2d3:1865:12f5 with SMTP id
 1-20020a92c641000000b002d3186512f5mr3066427ill.127.1653676516750; Fri, 27 May
 2022 11:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
 <20220526171046.GB1751747@merlins.org> <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org> <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
 <20220526181246.GA28329@merlins.org> <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
 <20220526191512.GE28329@merlins.org> <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
 <20220526213924.GB2414966@merlins.org> <20220527011622.GA24951@merlins.org>
In-Reply-To: <20220527011622.GA24951@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 27 May 2022 14:35:05 -0400
Message-ID: <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com>
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

On Thu, May 26, 2022 at 9:16 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, May 26, 2022 at 02:39:24PM -0700, Marc MERLIN wrote:
> > I thought we were getting so close, but it seems we'e made a few steps
> > back :-/
> >
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 3 /dev/mapper/dshelf1
> > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > Csum didn't match
> > ERROR: cannot read chunk root
> > WTF???
> > ERROR: open ctree failed
> >
> > At some point, if the FS is starting to look like it was trashed to
> > start with, or kind of trashed now after some of the recovery attempts,
> > let me know and I'll wipe and restore.
> > That said, if there is still data useful to improving your tools, I'm
> > game for a bit more, although if we hit the 2 months mark since it went
> > down, I'll have to eventuallly recover :)
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 3 /dev/mapper/dshelf1
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> Csum didn't match
> WARNING: cannot read chunk root, continue anyway
> Superblock thinks the generation is 1739781
> Superblock thinks the level is 1
> Well block 22593536(gen: 1590219 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22560768(gen: 1590217 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22577152(gen: 1586277 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22495232(gen: 1572124 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22528000(gen: 1572115 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22446080(gen: 1571791 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22478848(gen: 1561557 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22544384(gen: 1556078 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22511616(gen: 1555799 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22609920(gen: 1551635 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> Well block 22462464(gen: 1479229 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
> gargamel:/var/local/src/btrfs-progs-josefbacik#
>
> Is that good?

I'm augmenting my tree-recover tool to go and find any missing chunks
and add them in, which is what the chunk recover thing was supposed to
do.  This is going to take a bit, but should be the last piece.
Thanks,

Josef
