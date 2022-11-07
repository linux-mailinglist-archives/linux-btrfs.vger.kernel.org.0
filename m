Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA35461ED02
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 09:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiKGIhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 03:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiKGIhC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 03:37:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2921119
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 00:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09616B80E35
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 08:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BBEC433D6
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667810217;
        bh=v8SaiqEDZ61XCp6UKXP8ZuHV0+drNNeIpW5bNERuqd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nzI9zd80ulCeWMrtFHX2nu3CmRj3rCC1Poct2fXd+Dv1I25cwvLXJLXo0PeTuFtZZ
         05EbQ7qs+KNDCZjgzhrgeiOG3QRdyoqmtNyTDf0dXBQ2rJAU4yLX3xoGOi9XN+O6BI
         vrhgk/tV3mlESdpb+ZfrHrERNi9Vy+SpnG1wI4GebLq24fWNkQw0zfgT/1VJD/AvC2
         GA43YwvVFklGDTTkuSo4VATrUm5s8sP9fAR+wteGlJf3+7ngnS76VnVI482UA5DLi5
         sr3X+0yGmwbtPIrgeT46d5ugY8hRm5lFbvs7Grruoy3O11K98ySTSfFzIVVnw2h6Bb
         DDGghwRtiDSGA==
Received: by mail-ot1-f41.google.com with SMTP id f4-20020a056830264400b0066c8e56828aso4413403otu.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 00:36:57 -0800 (PST)
X-Gm-Message-State: ACrzQf1VMeRDG59z91FC7lO+M0wskO6xhcgtXtBY0BPIDdSNV6GfKNJM
        ny2dYCw+y2e5y7Oi9XkEv12YS/xk17RCXhUYEVw=
X-Google-Smtp-Source: AMsMyM4t9eU8lnMTg/E1nMOPu3clvZGUmSC+gpJiKOqw9u8Ufzx4vzP8nlrD7UNcdmIukdcJVMlG09zlYJkrfd9mpxk=
X-Received: by 2002:a05:6830:18c9:b0:66c:5c0e:35e9 with SMTP id
 v9-20020a05683018c900b0066c5c0e35e9mr17994051ote.345.1667810216641; Mon, 07
 Nov 2022 00:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20221106073028.71F9.409509F4@e16-tech.com>
In-Reply-To: <20221106073028.71F9.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 7 Nov 2022 08:36:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5Yv9TFTxDHBaUtsPyTgC__gPrwHtn0PPjomUDnQ--GUA@mail.gmail.com>
Message-ID: <CAL3q7H5Yv9TFTxDHBaUtsPyTgC__gPrwHtn0PPjomUDnQ--GUA@mail.gmail.com>
Subject: Re: newer /bin/cp have worse btrfs fiemap performance.
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 6, 2022 at 12:18 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> newer /bin/cp have worse btrfs fiemap performance.

New versions of coreutils (9.0 and 9.1) have worse cp performance, but
it has nothing to do with fiemap.

This was pointed out in another thread ([1]) sometime ago, that
starting with coreutils 9.0, cp no longer uses fiemap.
That happened in coreutils' commit:

https://github.com/coreutils/coreutils/commit/26eccf6c98696c50f4416ba2967edc8676870716

You can also confirm that by checking that strace no longer shows any
lines with:

ioctl(3, FS_IOC_FIEMAP, (...)

>
> btrfs version: misc-next 750de989d367(the lastest of 2022/11/05)
> /bin/cp versions(run them on the same server)
>     8.22 copy from centos/7.9
>     8.30 rocklinux/9.0
>     9.1 local build, https://kojipkgs.fedoraproject.org/packages/coreutils/9.1/8.eln121/
>
> test case:
>     /bin/cp /mnt/test/file1 /dev/null
>     /mnt/test/file1 is created by https://lore.kernel.org/linux-btrfs/YuwUw2JLKtIa9X+S@localhost.localdomain/T/#T
>     and /mnt/test/file1 is 256M.
>
>     file is not cached: 'echo 3 >/proc/sys/vm/drop_caches'
>     file is cached: run '/bin/cp /mnt/test/file1 /dev/null' again.
>
> performance result(/bin/cp /mnt/test/file1 /dev/null):
> /bin/cp 9.1
>     file is not cached: 94.85(1:34.85)
>     file is cached: 1982.43(33:02.43)
> /bin/cp 8.30
>     file is not cached: 1.48(0:01.48)
>     file is cached:14.07(0:14.07)
> /bin/cp 8.22
>     file is not cached: 0.53(0:00.53)
>     file is cached: 0.10(0:00.10)
>
> as a compare, we test it on xfs too.
> 1) /bin/cp 8.22/8.30/9.1 have almost same performance.
> 2) the case(the file is cached) is faster than the case(the file is not
> cached).
>
> strace show that the logical of /bin/cp 8.30 and 9.1 are different.

Yes, as pointed out before.

Before coreutils 9.0, cp used fiemap to determine where holes and
extents are in a file.
However starting with 9.0 it uses SEEK_DATA/SEEK_HOLE from lseek to do
that, completely
dropping fiemap usage.

> /bin/cp 8.30
>     lseek(3, 198737920, SEEK_SET)           = 198737920
>     write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     lseek(3, 198746112, SEEK_SET)           = 198746112
>     write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>
> /bin/cp 9.1
>     lseek(3, 880640, SEEK_DATA)             = 884736
>     lseek(3, 884736, SEEK_HOLE)             = 888832
>     lseek(3, 884736, SEEK_SET)              = 884736
>     write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     lseek(3, 888832, SEEK_DATA)             = 892928
>     lseek(3, 892928, SEEK_HOLE)             = 897024
>     lseek(3, 892928, SEEK_SET)              = 892928
>     write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>     write(4, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
>
> Do we need some job in btrfs to support /bin/cp 9.1 well,
> or /bin/cp 9.1 is just wrong?

There's nothing wrong with cp using lseek's SEEK_DATA/HOLE features.
It's just that the data/hole seek calls are where cp is spending most
time, so the way to go is
to improve the efficiency of those calls in btrfs. I'll do some work
to make it better.

Keep in mind that the case being tested is pretty much the worst
possible scenario. It's an extremely
sparse file, where each extent has a hole before it and another hole
after it. More often than not,
there are significantly more extents than holes in a typical file.

Thanks.

[1] https://lore.kernel.org/linux-btrfs/CAL3q7H5NSVicm7nYBJ7x8fFkDpno8z3PYt5aPU43Bajc1H0h1Q@mail.gmail.com/


>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/11/06
>
>
