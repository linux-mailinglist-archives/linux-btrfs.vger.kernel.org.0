Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE44589280
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiHCS44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiHCS4z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 14:56:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9B6561
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 11:56:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id tk8so33044533ejc.7
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Aug 2022 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=LNDqYV3hUcCA8uHXuiDF1qGOy8I9WBj76bkVdtI5kxQ=;
        b=cGt1MoFVx1LOwMe7MB5XEEN8ZhuFkMXxv47KSZAxN9pfDHrHeZcH+IueW6xhIyLwfS
         jInkAK9sUiPbeqno/uSzQJRYJkINEP3IE1mTKEgnHJSBPi9lzAcs3681jY40pzaQwSCh
         B7AUwvwLkx0kqPIkP7NkryJekN8YX/UICA5LXZhzI7fAkOkTQistQtj5Iyayda9JceF7
         QtbevKtusjPeLaogXxYeHYDJ9jKRIKQ9kPGc5P/rfUBN4bWIRkTAVgMObjRV9ckIX+tI
         wcBHSF6JyWcBwB7XA+lyr0jwtE7JySZhbyG3aU4cfFogu9gu8L73FkZqCaqHCYVxUJE8
         eC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LNDqYV3hUcCA8uHXuiDF1qGOy8I9WBj76bkVdtI5kxQ=;
        b=qFKdnKkvWDvBoMhmHaHOKtTUCl7MhL96vzKjrVKWMUxSNMxn6aLDIeLIPMrCZZHqc1
         I3DXUtTXnju0ibyEeOCHgWqpsxiBpWcRrRPiXyMYox0IvcAF34lpgN/wRi+DZrsSrP0L
         mkpkfLqhUUd1DCdSxhHFE75HcUsU+GkNv7tkhp2TxIeJcV4qF/kbgUTjD0s8u/HEbcwM
         GhIUN/sanS24yFAZTxnbNzWg1VyHlHD/PHHTO88jZiQepogHe7XX2afAF/Pb/UELTghe
         s9JNaObwrf9mkgnF6Z7xQLh4aouAgH374/6pjW/Q/S560NakXe5sscCZdYrbs1XjNxj9
         PNXw==
X-Gm-Message-State: AJIora8ssiRAPiuaR9mwFtWGU2+nCxs4Duzhu7grYVe9RwBu0k3Rzkw9
        SSDfx0paBAcUEoYzzkvMU3R6hJLpB6oT7x4eJJbUlue2cSk=
X-Google-Smtp-Source: AGRyM1tD3qqZMHZa3A37U3vb8udufqnyKjbfGJh4nMBNuYsi6Td3nOaw00dRG6eLyQIJEm1MH3ci3t5bI2SICnV8wwk=
X-Received: by 2002:a17:906:7955:b0:72f:5c1f:1816 with SMTP id
 l21-20020a170906795500b0072f5c1f1816mr21788078ejo.396.1659553011501; Wed, 03
 Aug 2022 11:56:51 -0700 (PDT)
MIME-Version: 1.0
From:   Martin <mbakiev@gmail.com>
Date:   Wed, 3 Aug 2022 12:56:15 -0600
Message-ID: <CAHs_hg1NTbSsoev93y0Sx6NguVKndR+d410yZzbMhii2ipaBcQ@mail.gmail.com>
Subject: Balance fails with csum errors, but scrub passes without errors
To:     linux-btrfs@vger.kernel.org
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

Hi,

I've recently had a hard drive that started showing csum errors in a
raid6 configuration with 13 drives, but smartctl wasn't reporting any
issues with the hard drive.
- I ran a scrub on the whole FS, it showed a bunch of errors that (I
think) it repaired.
- Then I tried adding a new drive and running a balance, this failed
with csum errors pretty quickly - pointing at that same drive that had
the scrub errors.
- I ran scrub just on that drive with the errors again, and the scrub
passed without reporting any issues!
- Balance still fails with errors on that drive.
- I replaced the drive (btrfs replace), which finished just fine, but
balance still fails with errors.
I'm not sure what to do from here, can someone advise on how I can
either repair these issues or delete the affected files and continue?


Initial scrub showing 260k errors:
    BTRFS warning (device sdf): checksum error at logical
63224657018880 on dev /dev/sde, physical 3870029381632, root 258,
inode 7735, offset 22675456, length 4096, links 1 (path: ...)
    BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
corrupt 268348, gen 4074
    BTRFS error (device sdf): fixed up error at logical 63224657018880
on dev /dev/sde
    BTRFS warning (device sdf): checksum error at logical
63224666390528 on dev /dev/sde, physical 3870030233600, root 258,
inode 7735, offset 32047104, length 4096, links 1 (path: ...)
    BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
corrupt 268349, gen 4074
    BTRFS warning (device sdf): checksum error at logical
63224675762176 on dev /dev/sde, physical 3870031085568, root 258,
inode 7735, offset 41418752, length 4096, links 1 (path: ...)
    BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
corrupt 268350, gen 4074
    BTRFS warning (device sdf): checksum error at logical
63224685133824 on dev /dev/sde, physical 3870031937536, root 258,
inode 7735, offset 50790400, length 4096, links 1 (path: ...)
    BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
corrupt 268351, gen 4074
    BTRFS error (device sdf): fixed up error at logical 63224666390528
on dev /dev/sde
    BTRFS error (device sdf): fixed up error at logical 63224675762176
on dev /dev/sde
    BTRFS error (device sdf): fixed up error at logical 63224685133824
on dev /dev/sde
    BTRFS war   ning (device sdf): checksum error at logical
63224694505472 on dev /dev/sde, physical 3870032789504, root 258,
inode 7735, offset 59375616, length 4096, links 1 (path: ...)
    BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
corrupt 268352, gen 4074
    BTRFS error (device sdf): fixed up error at logical 63224694505472
on dev /dev/sde
    BTRFS warning (device sdf): checksum error at logical
63225491095552 on dev /dev/sde, physical 3870105206784, root 258,
inode 7735, offset 69664768, length 4096, links 1 (path: ...)
    BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
corrupt 268353, gen 4074
    BTRFS warning (device sdf): checksum error at logical
63225500467200 on dev /dev/sde, physical 3870106058752, root 258,
inode 7735, offset 78118912, length 4096, links 1 (path: ...)
    BTRFS error (device sdf): bdev /dev/sde errs: wr 0, rd 0, flush 0,
corrupt 268354, gen 4074
    BTRFS error (device sdf): fixed up error at logical 63225491095552
on dev /dev/sde
    BTRFS error (device sdf): fixed up error at logical 63225500467200
on dev /dev/sde

Balance fails with these errors:
    [Wed Aug  3 12:13:26 2022] BTRFS info (device sdn): balance: start
-dstripes=13..13
    [Wed Aug  3 12:13:26 2022] BTRFS info (device sdn): relocating
block group 103549454516224 flags data|raid6
    [Wed Aug  3 12:13:45 2022] btrfs_print_data_csum_error: 55
callbacks suppressed
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809305088 csum 0x26262de7 expected csum
0x0473ecb8 mirror 1
    [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809309184 csum 0x13e9e2a0 expected csum
0x723f00ca mirror 1
    [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809313280 csum 0x5c509a8f expected csum
0xfd89f318 mirror 1
    [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809317376 csum 0x42455521 expected csum
0x07cf450d mirror 1
    [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809305088 csum 0x26262de7 expected csum
0x0473ecb8 mirror 2
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809309184 csum 0x13e9e2a0 expected csum
0x723f00ca mirror 2
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809313280 csum 0x5c509a8f expected csum
0xfd89f318 mirror 2
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809317376 csum 0x42455521 expected csum
0x07cf450d mirror 2
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809305088 csum 0x26262de7 expected csum
0x0473ecb8 mirror 3
    [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
root -9 ino 257 off 6809309184 csum 0x13e9e2a0 expected csum
0x723f00ca mirror 3
    [Wed Aug  3 12:13:45 2022] BTRFS error (device sdn): bdev /dev/sdk
errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
    [Wed Aug  3 12:13:48 2022] BTRFS info (device sdn): balance: ended
with status: -5

uname -a:
    Linux magneto 5.18.11-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
Jul 12 22:52:35 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

btrfs --version
    btrfs-progs v5.18

btrfs fi show
    Label: 'raid6'  uuid: 4557fc3c-b70a-44cc-81b8-019658ea6cfd
    Total devices 14 FS bytes used 37.11TiB
    devid    1 size 9.10TiB used 3.44TiB path /dev/sdn
    devid    2 size 9.10TiB used 3.44TiB path /dev/sdk
    devid    3 size 7.28TiB used 3.41TiB path /dev/sdc
    devid    4 size 5.46TiB used 3.42TiB path /dev/sdh
    devid    5 size 3.64TiB used 3.41TiB path /dev/sdl
    devid    6 size 3.64TiB used 3.41TiB path /dev/sdb
    devid    7 size 5.46TiB used 3.41TiB path /dev/sdq
    devid    8 size 4.55TiB used 3.41TiB path /dev/sdf
    devid    9 size 4.55TiB used 3.41TiB path /dev/sdj
    devid   10 size 4.55TiB used 3.41TiB path /dev/sdm
    devid   11 size 4.55TiB used 3.41TiB path /dev/sdi
    devid   12 size 9.10TiB used 3.45TiB path /dev/sdg
    devid   13 size 9.10TiB used 3.45TiB path /dev/sde
    devid   14 size 9.10TiB used 61.09GiB path /dev/sdr


Thanks,
Martin
