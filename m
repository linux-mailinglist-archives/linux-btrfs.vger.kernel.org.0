Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657A5892EC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiHCTyj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 15:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCTyh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 15:54:37 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD53206C
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 12:54:34 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-324ec5a9e97so97631727b3.7
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Aug 2022 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kycrpqXBd1Ybdrz7znmu7Hat/nD0zerKgkOKTJcSjRI=;
        b=nJB37pTg8NlMm1IKDbPXV1+s1AxcoCp0N8qvneHrxLjxQW9QElvORrvoCsHTlpxI2O
         Y6WejptoVmrfJg8LKcJEuUKTCxSU3q6bQrHt4fmIKRnRp3BfzSOe5CfMbmJWnK8fk47E
         GjFma0xbOW7pjpCOfopqOxsBRj05v5eqlBYEMDQPB7j7UwEr4H0o4rmfai5jnHmCNWLE
         DI++bYEKbx40FvDIW6Wa1MnLAnzhO+m3lzZQ4z9y+W2hz9t9nGCrzwfpyPVYDYW+2Zx6
         P4/8jrgYkYmfyqThFR5IRqXyxUXYycAkFj7ef+4Fxn094GN4eM0BJ2mQBA+DYPLZIbhK
         lorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kycrpqXBd1Ybdrz7znmu7Hat/nD0zerKgkOKTJcSjRI=;
        b=MObxVK1myB5eJ14bYdRuAc069BDarrkMlk0wyMMcbR2tAw6xJ/J5VOrH0NZ2R/7/yx
         Xct34zVm7lxSodPbXYKol3+pBLQYK1H2jhS9IPdK1YCrpnJH8kH2fa9XXS2cqalaUgtI
         JEnw8hf7nBzQQN4krS6aRLTwKzjc8RfXMWk2EACI2Uqq75Yc4+eXeZY3bRQiovLc9ycf
         2f98ZriYEd/aD28Xz1GDHswOcNGMBnHx2gj4nqjwsHuLAMFsbNt1wCnY8WMczBKoR0jW
         5ShDzJxaq4jWC+gKVnwvuLlZDlAu64ib1c78OV1gYlD5pceWfKpSu8Uqk7s5wLzIUx8G
         tLtA==
X-Gm-Message-State: ACgBeo13qFZJ5vd3EskM/n70ftSoS93MzmWVMGtr06Hv4K0hMbiXkRIm
        AIR2I4cROEbyv4yVtxdbpa6emhhsi7O/byPH3ro=
X-Google-Smtp-Source: AA6agR742xXbeO4ay+K6dcLeh/hvqyH0A05BqwLV1PpT6fvaN+PTu5REQPs/ghZ8VO52gb//PXDHQH8LOfZEimgbKDs=
X-Received: by 2002:a0d:ca41:0:b0:324:b593:d631 with SMTP id
 m62-20020a0dca41000000b00324b593d631mr17584019ywd.396.1659556473313; Wed, 03
 Aug 2022 12:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHs_hg1NTbSsoev93y0Sx6NguVKndR+d410yZzbMhii2ipaBcQ@mail.gmail.com>
In-Reply-To: <CAHs_hg1NTbSsoev93y0Sx6NguVKndR+d410yZzbMhii2ipaBcQ@mail.gmail.com>
From:   Thiago Ramon <thiagoramon@gmail.com>
Date:   Wed, 3 Aug 2022 16:54:22 -0300
Message-ID: <CAO1Y9wo_HcouRuOa8b7+2bXwZJOHNiy9PsxcYxsQAZ8ggvTxzw@mail.gmail.com>
Subject: Re: Balance fails with csum errors, but scrub passes without errors
To:     Martin <mbakiev@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've had similar issues. There's 2 general cases which you need to
find and correct: actual csum errors on file data, and csum errors
outside the file data (AFAIK only on compressed files).
The first one is easier to spot by reading all files in the FS and
logging anything that throws an IO error. Just running a find and
cat'ing the files to /dev/null should do and list all errors, though
you might prefer to use something more sophisticated to log and resume
if you encounter any problems while doing it (might stumble on some
kernel BUG while doing it).
After you found all the actually damaged files and dealt with them
(ddrescue or just deleting them), you are left with pretty much trying
to balance, getting an error, finding the responsible file from the
offset on the error message (it's the offset inside the block group
being currently relocated) and then just defragging the file should be
enough to clear the error. Then just resume the balance and continue
on to the next one...

Just going to use this new case as another notice that there's
something horribly wrong with scrub on large raid6 arrays, as I'm
running yet another 30M files, 60TB scan on my 12x8TB array to find
everything scrub missed after my last replace...

On Wed, Aug 3, 2022 at 4:01 PM Martin <mbakiev@gmail.com> wrote:
>
> Hi,
>
> I've recently had a hard drive that started showing csum errors in a
> raid6 configuration with 13 drives, but smartctl wasn't reporting any
> issues with the hard drive.
> - I ran a scrub on the whole FS, it showed a bunch of errors that (I
> think) it repaired.
> - Then I tried adding a new drive and running a balance, this failed
> with csum errors pretty quickly - pointing at that same drive that had
> the scrub errors.
> - I ran scrub just on that drive with the errors again, and the scrub
> passed without reporting any issues!
> - Balance still fails with errors on that drive.
> - I replaced the drive (btrfs replace), which finished just fine, but
> balance still fails with errors.
> I'm not sure what to do from here, can someone advise on how I can
> either repair these issues or delete the affected files and continue?
>
>
> Initial scrub showing 260k errors:
>     BTRFS warning (device sdf): checksum error at logical
> 63224657018880 on dev /dev/sde, physical 3870029381632, root 258,
> inode 7735, offset 22675456, length 4096, links 1 (path: ...)
>     BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
> corrupt 268348, gen 4074
>     BTRFS error (device sdf): fixed up error at logical 63224657018880
> on dev /dev/sde
>     BTRFS warning (device sdf): checksum error at logical
> 63224666390528 on dev /dev/sde, physical 3870030233600, root 258,
> inode 7735, offset 32047104, length 4096, links 1 (path: ...)
>     BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
> corrupt 268349, gen 4074
>     BTRFS warning (device sdf): checksum error at logical
> 63224675762176 on dev /dev/sde, physical 3870031085568, root 258,
> inode 7735, offset 41418752, length 4096, links 1 (path: ...)
>     BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
> corrupt 268350, gen 4074
>     BTRFS warning (device sdf): checksum error at logical
> 63224685133824 on dev /dev/sde, physical 3870031937536, root 258,
> inode 7735, offset 50790400, length 4096, links 1 (path: ...)
>     BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
> corrupt 268351, gen 4074
>     BTRFS error (device sdf): fixed up error at logical 63224666390528
> on dev /dev/sde
>     BTRFS error (device sdf): fixed up error at logical 63224675762176
> on dev /dev/sde
>     BTRFS error (device sdf): fixed up error at logical 63224685133824
> on dev /dev/sde
>     BTRFS war   ning (device sdf): checksum error at logical
> 63224694505472 on dev /dev/sde, physical 3870032789504, root 258,
> inode 7735, offset 59375616, length 4096, links 1 (path: ...)
>     BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
> corrupt 268352, gen 4074
>     BTRFS error (device sdf): fixed up error at logical 63224694505472
> on dev /dev/sde
>     BTRFS warning (device sdf): checksum error at logical
> 63225491095552 on dev /dev/sde, physical 3870105206784, root 258,
> inode 7735, offset 69664768, length 4096, links 1 (path: ...)
>     BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
> corrupt 268353, gen 4074
>     BTRFS warning (device sdf): checksum error at logical
> 63225500467200 on dev /dev/sde, physical 3870106058752, root 258,
> inode 7735, offset 78118912, length 4096, links 1 (path: ...)
>     BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
> corrupt 268354, gen 4074
>     BTRFS error (device sdf): fixed up error at logical 63225491095552
> on dev /dev/sde
>     BTRFS error (device sdf): fixed up error at logical 63225500467200
> on dev /dev/sde
>
> Balance fails with these errors:
>     [Wed Aug  3 12:13:26 2022] BTRFS info (device sdn): balance: start
> -dstripes=13..13
>     [Wed Aug  3 12:13:26 2022] BTRFS info (device sdn): relocating
> block group 103549454516224 flags data|raid6
>     [Wed Aug  3 12:13:45 2022] btrfs_print_data_csum_error: 55
> callbacks suppressed
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809305088 csum 0x26262de7 expected csum
> 0x0473ecb8 mirror 1
>     [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
> errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809309184 csum 0x13e9e2a0 expected csum
> 0x723f00ca mirror 1
>     [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
> errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809313280 csum 0x5c509a8f expected csum
> 0xfd89f318 mirror 1
>     [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
> errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809317376 csum 0x42455521 expected csum
> 0x07cf450d mirror 1
>     [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
> errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809305088 csum 0x26262de7 expected csum
> 0x0473ecb8 mirror 2
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809309184 csum 0x13e9e2a0 expected csum
> 0x723f00ca mirror 2
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809313280 csum 0x5c509a8f expected csum
> 0xfd89f318 mirror 2
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809317376 csum 0x42455521 expected csum
> 0x07cf450d mirror 2
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809305088 csum 0x26262de7 expected csum
> 0x0473ecb8 mirror 3
>     [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809309184 csum 0x13e9e2a0 expected csum
> 0x723f00ca mirror 3
>     [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
> errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
>     [Wed Aug  3 12:13:48 2022] BTRFS info (device sdn): balance: ended
> with status: -5
>
> uname -a:
>     Linux magneto 5.18.11-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
> Jul 12 22:52:35 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
>
> btrfs --version
>     btrfs-progs v5.18
>
> btrfs fi show
>     Label: 'raid6'  uuid: 4557fc3c-b70a-44cc-81b8-019658ea6cfd
>     Total devices 14 FS bytes used 37.11TiB
>     devid    1 size 9.10TiB used 3.44TiB path /dev/sdn
>     devid    2 size 9.10TiB used 3.44TiB path /dev/sdk
>     devid    3 size 7.28TiB used 3.41TiB path /dev/sdc
>     devid    4 size 5.46TiB used 3.42TiB path /dev/sdh
>     devid    5 size 3.64TiB used 3.41TiB path /dev/sdl
>     devid    6 size 3.64TiB used 3.41TiB path /dev/sdb
>     devid    7 size 5.46TiB used 3.41TiB path /dev/sdq
>     devid    8 size 4.55TiB used 3.41TiB path /dev/sdf
>     devid    9 size 4.55TiB used 3.41TiB path /dev/sdj
>     devid   10 size 4.55TiB used 3.41TiB path /dev/sdm
>     devid   11 size 4.55TiB used 3.41TiB path /dev/sdi
>     devid   12 size 9.10TiB used 3.45TiB path /dev/sdg
>     devid   13 size 9.10TiB used 3.45TiB path /dev/sde
>     devid   14 size 9.10TiB used 61.09GiB path /dev/sdr
>
>
> Thanks,
> Martin
