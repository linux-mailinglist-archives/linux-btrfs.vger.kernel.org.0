Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6031D5BFA03
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 11:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiIUJBY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIUJBU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 05:01:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE44E83F2B;
        Wed, 21 Sep 2022 02:01:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64A1BB8247B;
        Wed, 21 Sep 2022 09:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7FCC43142;
        Wed, 21 Sep 2022 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663750875;
        bh=jl2oV5i16ki6VCpkCVQxdBmt935eV2tFvF9P4yvpxqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n7BV9Dg64dkQRWnFiKOj+lbIHfdZlvuyNPPyloO7EymFhFJpPtXcVR4oOPevfLvYm
         PSVUtmCXrXA5mHMZiRKsUovbXHH9y0hSefKByG1Pg43BgXS5SCYnh/J68zBkjQSEBX
         MPKCR39OR1c+IKC3fug8qFh/safeuEixzy19J9r8PaAuknQJfnkIvxaqgsorBZR7En
         je3lOfCY3sffrX+kJ5UasC6+yexmNtgcwNMfsKSLSCvagNgmvveG4P2xlrQ5e3kXEv
         IGuE9FxqgrUIMX7b4q+WL3CT6IiVYVY+RPLbk/gz3ne4yfbGT+doeZjw1eP4Nm/CID
         MHdwpxZDQY9+A==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11eab59db71so8065447fac.11;
        Wed, 21 Sep 2022 02:01:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf19CJWZ+AX1RMDNF81IXEJQoAt8fKQ/3NBXXTTgo6KfTrFz+Kgz
        61CZOymNzBxySUcCg/zpi5rO6KcJFSiVgUPXu1c=
X-Google-Smtp-Source: AMsMyM6rm74CgJN8PL6/wEivAfR6BHAbm8xmQx2bG9QU1VuwgB38ZZcRjUaDPJBWif3Jh0lqXG6zbL87q3XtkfwkSzc=
X-Received: by 2002:a05:6870:63a6:b0:12b:85ee:59ff with SMTP id
 t38-20020a05687063a600b0012b85ee59ffmr4487685oap.98.1663750874161; Wed, 21
 Sep 2022 02:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <YuwUw2JLKtIa9X+S@localhost.localdomain> <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com>
 <YuzI7Tqi3n+d+V+P@atmark-techno.com> <20220805095407.GA1876904@falcondesktop>
 <20220901132512.GA3946576@falcondesktop> <Yyq9lfH3AP8I/pwd@atmark-techno.com>
In-Reply-To: <Yyq9lfH3AP8I/pwd@atmark-techno.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 21 Sep 2022 10:00:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5cL+4W6SQApq=ZhkzffvZAR2cEWK0bduNun+OkFevk=g@mail.gmail.com>
Message-ID: <CAL3q7H5cL+4W6SQApq=ZhkzffvZAR2cEWK0bduNun+OkFevk=g@mail.gmail.com>
Subject: Re: fiemap is slow on btrfs on files with multiple extents
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Chen Liang-Chun <featherclc@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        kernel@openvz.org, Yu Kuai <yukuai3@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 21, 2022 at 8:30 AM Dominique MARTINET
<dominique.martinet@atmark-techno.com> wrote:
>
> Filipe Manana wrote on Thu, Sep 01, 2022 at 02:25:12PM +0100:
> > It took me a bit more than I expected, but here is the patchset to make fiemap
> > (and lseek) much more efficient on btrfs:
> >
> > https://lore.kernel.org/linux-btrfs/cover.1662022922.git.fdmanana@suse.com/
> >
> > And also available in this git branch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=lseek_fiemap_scalability
>
> Thanks a lot!
> Sorry for the slow reply, it took me a while to find time to get back to
> my test setup.
>
> There's still this weird behaviour that later calls to cp are slower
> than the first, but the improvement is so good that it doesn't matter
> quite as much -- I haven't been able to reproduce the rcu stalls in qemu
> so I can't say for sure but they probably won't be a problem anymore.
>
> From a quick look with perf record/report the difference still seems to
> stem from fiemap (time spent there goes from 4.13 to 45.20%), so there
> is still more processing once the file is (at least partially) in cache,
> but it has gotten much better.
>
>
> (tests run on a laptop so assume some inconsistency with thermal
> throttling etc)
>
> /mnt/t/t # compsize bigfile
> Processed 1 file, 194955 regular extents (199583 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL       15%      3.7G          23G          23G
> none       100%      477M         477M         514M
> zstd        14%      3.2G          23G          23G
> /mnt/t/t # time cp bigfile /dev/null
> real    0m 44.52s
> user    0m 0.49s
> sys     0m 32.91s
> /mnt/t/t # time cp bigfile /dev/null
> real    0m 46.81s
> user    0m 0.55s
> sys     0m 35.63s
> /mnt/t/t # time cp bigfile /dev/null
> real    1m 13.63s
> user    0m 0.55s
> sys     1m 1.89s
> /mnt/t/t # time cp bigfile /dev/null
> real    1m 13.44s
> user    0m 0.53s
> sys     1m 2.08s
>
>
> For comparison here's how it was on 6.0-rc2 your branch is based on:
> /mnt/t/t # time cp atde-test /dev/null
> real    0m 46.17s
> user    0m 0.60s
> sys     0m 33.21s
> /mnt/t/t # time cp atde-test /dev/null
> real    5m 35.92s
> user    0m 0.57s
> sys     5m 24.20s
>
>
>
> If you're curious the report blames set_extent_bit and
> clear_state_bit as follow; get_extent_skip_holes is completely gone; but
> I wouldn't necessarily say this needs much more time spent on it.

get_extent_skip_holes() no longer exists, so 0% of time spent there :)

Yes, I know. The reason you see so much time spent on
lock_extent_bits() is basically
because cp does too many fiemap calls with a very small extent buffer size.
I pointed that out here:

https://lore.kernel.org/linux-btrfs/CAL3q7H5NSVicm7nYBJ7x8fFkDpno8z3PYt5aPU43Bajc1H0h1Q@mail.gmail.com/

Making it use a larger buffer (say 500 or 1000 extents), would make it
a lot better.
But as I pointed out there, last year cp was changed to not use fiemap
to detect holes anymore,
now it uses lseek with SEEK_HOLE mode. So with time, everyone will get
a cp version that does
not use fiemap anymore.

Also, for the cp case, since it does many read and fiemap calls to the
source file, the following
patch probably helps too:

https://lore.kernel.org/linux-btrfs/20220819024408.9714-1-ethanlien@synology.com/

Because it will make the io tree smaller. That should land on 6.1 too.

Thanks for testing and the report.

>
> 45.20%--extent_fiemap
> |
> |--31.02%--lock_extent_bits
> |          |
> |           --30.78%--set_extent_bit
> |                     |
> |                     |--6.93%--insert_state
> |                     |          |
> |                     |           --0.70%--set_state_bits
> |                     |
> |                     |--4.25%--alloc_extent_state
> |                     |          |
> |                     |           --3.86%--kmem_cache_alloc
> |                     |
> |                     |--2.77%--_raw_spin_lock
> |                     |          |
> |                     |           --1.23%--preempt_count_add
> |                     |
> |                     |--2.48%--rb_next
> |                     |
> |                     |--1.13%--_raw_spin_unlock
> |                     |          |
> |                     |           --0.55%--preempt_count_sub
> |                     |
> |                      --0.92%--set_state_bits
> |
>  --13.80%--__clear_extent_bit
>            |
>             --13.30%--clear_state_bit
>                       |
>                       |           --3.48%--_raw_spin_unlock_irqrestore
>                       |
>                       |--2.45%--merge_state.part.0
>                       |          |
>                       |           --1.57%--rb_next
>                       |
>                       |--2.14%--__slab_free
>                       |          |
>                       |           --1.26%--cmpxchg_double_slab.constprop.0.isra.0
>                       |
>                       |--0.74%--free_extent_state
>                       |
>                       |--0.70%--kmem_cache_free
>                       |
>                       |--0.69%--btrfs_clear_delalloc_extent
>                       |
>                        --0.52%--rb_next
>
>
>
> Thanks!
> --
> Dominique
