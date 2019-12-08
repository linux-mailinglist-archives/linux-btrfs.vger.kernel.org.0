Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1D116396
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2019 20:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLHTTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 14:19:23 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:45121 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfLHTTW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 14:19:22 -0500
Received: by mail-io1-f54.google.com with SMTP id i11so12410071ioi.12
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2019 11:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wjpSojOK4HfuzobnAkULlQdB1jlA0cYzVyacvRfuNV4=;
        b=qn3b8PcbRqrfTOzyM6ghtmaRv34FZLWHJ++/xPHkB1/U686Sh1W4iIflREoVeIMVfE
         OU4ZSUlE2S7J0z3dWlAWtjrPwzIEVcYUJuf6VXzXNzi2KkpvZ2SxQDT2lT9GLHtIPz0T
         WcRCkOSZ0nBB8tYNpUns5ncU/IJhkpoPiqGdWkAQBtsV++a4Vm2IIAqmFjFAEVnF4bLt
         VCbJwXu2P+CqZ+wRdvptPLluqYLZTWQie2Wf96yoShVOuxqOsXb2T24sACFEoGngy/dp
         isW1DMup82znknp7v5RzOxuiLEflWifjl54oLGm1B90Bzy2fW6uwz7tHWuchaTcMXZaU
         kA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wjpSojOK4HfuzobnAkULlQdB1jlA0cYzVyacvRfuNV4=;
        b=MU2cJD2uQDjs1O8msGYFjX5LZJOV62OLLasnHPXYDK/jBAe9GWpfQoXgIDqZSOl2rZ
         JFa3ZgX5DaNvDQ9TwTfk18qYVfrtu7VnMt1YgJlKvGZfa59lFQe0oO/AhmvDJb4zDTBn
         gc46d0d7l0otxNIM3xALF6ZqUjkN7bazErRxni05OwaApgH0mr9Ko6U3MRMjvTr9/JM6
         00TBQgYjVt2Bpp5RqkRi2qhDscpuAId6FZOTOVqZLCtOjUgtGK4LS6/aEiL9F7ItmR68
         4i3ww2YrWGPrz9+UeSiuBhz9ow4HTvSn5doyyRjzbYvtexe0F5YIp0m6tGr6nJKWZLNB
         TBhw==
X-Gm-Message-State: APjAAAWIV3Lv2bzpejBmEjzTJson2JCedPMayneA3uVnlhzUTtpaUL6Y
        oQICqfdujFwoixzsSHlcyCp7vyprEsg4TmHDKdojy3/pYIc=
X-Google-Smtp-Source: APXvYqz2kkN6YwHrxhEUM7esY3nC0t+2r2z4sFg72UayIJ1h+VPth5PCVobcfIInsHfQDzO3qHNiQR30gFalUZT8LTI=
X-Received: by 2002:a02:630a:: with SMTP id j10mr17111976jac.102.1575832761643;
 Sun, 08 Dec 2019 11:19:21 -0800 (PST)
MIME-Version: 1.0
From:   Mike Gilbert <floppymaster@gmail.com>
Date:   Sun, 8 Dec 2019 14:19:10 -0500
Message-ID: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
Subject: Unable to remove directory entry
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a directory entry that cannot be stat-ed or unlinked. This
issue persists across reboots, so it seems there is something wrong on
disk.

% ls -l /var/cache/ccache.bad/2/c
ls: cannot access
'/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest':
No such
file or directory
total 0
-????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.manifest

% uname -a
Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
Phenom(tm) II X6 1055T Processor
AuthenticAMD GNU/Linux

% btrfs --version
btrfs-progs v5.4

I have tried running btrfs check, and I get differing results based on
the --mode switch:

# btrfs check --readonly /dev/sda3
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
found 284337733632 bytes used, no error found
total csum bytes: 267182280
total tree bytes: 4498915328
total fs tree bytes: 3972464640
total extent tree bytes: 199819264
btree space waste bytes: 776711635
file data blocks allocated: 313928671232
 referenced 279141621760

# btrfs check --readonly --mode=lowmem /dev/sda3
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
ERROR: root 5 INODE_ITEM[4065004] index 18446744073709551615 name
0390cb341d248c589c419007da68b2-7351.manifest filetype 1 missing
ERROR: root 5 DIR ITEM[486836 13905] name
0390cb341d248c589c419007da68b2-7351.manifest filetype 1 mismath
ERROR: root 5 DIR ITEM[486836 2543451757] mismatch name
0390cb341d248c589c419007da68b2-7351.manifest filetype 1
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
found 284337733632 bytes used, error(s) found
total csum bytes: 267182280
total tree bytes: 4498915328
total fs tree bytes: 3972464640
total extent tree bytes: 199819264
btree space waste bytes: 776711635
file data blocks allocated: 313928671232
 referenced 279141621760

Please advise on possible next steps to diagnose and fix this.
