Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFB6ECF2C
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2019 15:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKBOgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Nov 2019 10:36:22 -0400
Received: from rin.romanrm.net ([91.121.75.85]:38204 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfKBOgV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 Nov 2019 10:36:21 -0400
Received: from natsu (natsu.2.romanrm.net [IPv6:fd39:aa:7359:7f90:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 0DFF020373;
        Sat,  2 Nov 2019 14:36:19 +0000 (UTC)
Date:   Sat, 2 Nov 2019 19:36:24 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Brian Hansen <dulanic@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: reflink copy now works with nocow?
Message-ID: <20191102193624.3411de0d@natsu>
In-Reply-To: <CAMiuOHXH1ic6Mcz+o1uWLNMCK+iCinhR+nnZ8N1wTHQoEms-7Q@mail.gmail.com>
References: <CAMiuOHXH1ic6Mcz+o1uWLNMCK+iCinhR+nnZ8N1wTHQoEms-7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 2 Nov 2019 08:49:37 -0500
Brian Hansen <dulanic@gmail.com> wrote:

> Hello,
> 
> First time i've sent to this group but I am trying to figure out the
> cause of this. Normal copy is working fine, but then if I use
> --reflink it says invalid argument. Not sure how to read some of this,
> but here is the strace.
> 
> I'm running kernel v4.15
> 
> Here is the full output of strace. I ran a strace on normal copy and
> most looks similar so I'm not able to figure out much here...
> 
> https://pastebin.com/raw/YmQ8FvCH

At first I was going to say, "oh it's because you are using 'chattr +C', or
mounted the filesystem as nocow, and reflink copying is prevented by those".
In fact this article from 2014 confirms that to be the case:
http://infotinks.com/btrfs-nodatacow-reflink-copies-snapshots/

But then I tested on my machine, and what used to fail, now works:

  # mkdir tmp
  # chattr +C tmp
  # echo abc > tmp/a
  # cp -a --reflink=always tmp/a tmp/b
  # lsattr tmp/
  ----------------C-- tmp/a
  ----------------C-- tmp/b

According to strace, the clone IOCTL succeeds:

...
  openat(AT_FDCWD, "tmp/b", O_WRONLY|O_CREAT|O_EXCL, 0600) = 4
  fstat(4, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
  ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = 0
...

Same on kernels 4.14.151, 4.14.113 and 4.9.189.

So I wonder, is setting nocow via 'chattr +C' getting ignored now, or is there
an improvement that it no longer prevents reflink copying?

-- 
With respect,
Roman
