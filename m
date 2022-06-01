Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7872553A78D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354183AbiFAOCI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 10:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354547AbiFAOAl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 10:00:41 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607CF10FCF
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 06:57:00 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z20so1793991iof.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ld+i7oJ40SEWA4Mli6OSsqxa3RbbNFUpGDc/xfmigyU=;
        b=KOnZd1TzW56Cj7qgcEatoMe7FkisZm9LUOhPVFucbj0DL5+L5kbjY0M0ujPfreAOlu
         qCIytOBbK4GuchYvod/PQYbsLiAZiWoFSAuXt7Ce84kAYpxIoBzPWpBhES8Nc9R5z/Ri
         D7DXVOK6/O0cz4ksj9NIR1WPyjO3lOmzExpD5rw451yZ7kWqjt0L49LIBpmBI2uaMJKs
         lKh9GZ2Rct3rGGaDGgqaBuaIux1KqNEwsDR5/giofOhOu3oo2C5nuEXwI21s2NYTi4Mj
         JGm22oALqQD693fOMdYLZaFogxQdezuZIUwMwjwxvtybNoi0YrntizdI23bqSVdCp+fC
         pxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ld+i7oJ40SEWA4Mli6OSsqxa3RbbNFUpGDc/xfmigyU=;
        b=dKRm4veVsWnZvzYvuIAvym+hmSE3vkR66uH7AUIECh3vrNM6HYLjHqk10nAMZuBiom
         RIdd/Ul6mltKqI9oN86MZCr7jzn4jg7mrORBswXobFYifcWAhiQA+XfkorAhrkmOIGZq
         Khk0xh14fmjjbE6qiuG0dLLB+Rc6tL/nhkZdtz9ojQvHGCBHiHpnyvxuqleKXwqpITQP
         428xmyQbLTobxrej0MPJaTP0Kwr3hgllx8jVvMtdCv+9j7/2nCW1JCQJ1f4MYh6oi+Om
         kkig4Cfi1v2uiHZv2AxsWkrzyuGV9jP18PxeyUUE/Z7pGkA3shDZWkICjkemiBFHKLX9
         3frw==
X-Gm-Message-State: AOAM532DDY5YZaPwovbrsLw+1/wM7IjjWV32sTeDkJ93vYEINSqsgHRH
        U0bwUcamaa5H/D52+WrxVvBRzpTxC8vIKqXWd6mdL3tmJjY=
X-Google-Smtp-Source: ABdhPJwhM5HaR+MxhYKVAAvrs/E3HxVmAUKwd07mbCTV6uki8RgZhpugJy7BQimVDQ9sU1b5IyrnFMlGUmEeQcGnW3Q=
X-Received: by 2002:a02:ccc2:0:b0:331:4f1f:1e9 with SMTP id
 k2-20020a02ccc2000000b003314f1f01e9mr18794jaq.218.1654091785210; Wed, 01 Jun
 2022 06:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220530191834.GK24951@merlins.org> <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
 <20220531011224.GA1745079@merlins.org> <CAEzrpqco_RyUBK=dngrv54u8WE2uhSGrJaB9aRY5nUmKNzN32Q@mail.gmail.com>
 <20220531224951.GC22722@merlins.org> <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
 <20220601002552.GD22722@merlins.org> <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
 <20220601012919.GE22722@merlins.org> <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
 <20220601031536.GD1745079@merlins.org>
In-Reply-To: <20220601031536.GD1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 09:56:14 -0400
Message-ID: <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
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

On Tue, May 31, 2022 at 11:15 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 31, 2022 at 10:10:49PM -0400, Josef Bacik wrote:
> > On Tue, May 31, 2022 at 9:29 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Tue, May 31, 2022 at 09:26:03PM -0400, Josef Bacik wrote:
> > > > On Tue, May 31, 2022 at 8:25 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > >
> > > > > On Tue, May 31, 2022 at 08:14:27PM -0400, Josef Bacik wrote:
> > > > > > Wtf, we're clearly writing the chunk root properly because I have to
> > > > > > re-open it to recover the tree root, and that's where it fails, but
> > > > > > then the chunk restore can't open the root, despite it being correctly
> > > > > > read in the tree recover.  I've pushed new code, try tree-recover and
> > > > > > then recover-chunks again and capture the output please.  Thanks,
> > > > >
> > > > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> > > > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > >
> > > > Ah ok, I wasn't actually updating the pointer, fixed that, lets try
> > > > the same sequence again.  Thanks,
> > >
> >
> > Ok backup roots don't work if we didn't read them, try again please.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# git pull
> Already up-to-date.
> gargamel:/var/local/src/btrfs-progs-josefbacik# gdb ./btrfs rescue tree-recover /dev/mapper/dshelf1
> Excess command line arguments ignored. (tree-recover ...)
> GNU gdb (Debian 7.12-6+b2) 7.12.0.20161007-git
> Copyright (C) 2016 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
> <http://www.gnu.org/software/gdb/documentation/>.
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./btrfs...done.
> /var/local/src/btrfs-progs-josefbacik/rescue: No such file or directory.
> (gdb) run rescue tree-recover /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue tree-recover /dev/mapper/dshelf1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> WARNING: cannot read chunk root, continue anyway
> none of our backups was sufficient, scanning for a root
> scanning, best has 0 found 1 bad
> ret is 0 offset 20971520 len 8388608
> ret is -2 offset 20971520 len 8388608
> checking block 22495232 generation 1572124 fs info generation 2582703
> trying bytenr 22495232 got 1 blocks 0 bad
> checking block 22462464 generation 1479229 fs info generation 2582703
> trying bytenr 22462464 got 1 blocks 0 bad
> checking block 22528000 generation 1572115 fs info generation 2582703
> trying bytenr 22528000 got 1 blocks 0 bad
> checking block 22446080 generation 1571791 fs info generation 2582703
> trying bytenr 22446080 got 1 blocks 0 bad
> checking block 22544384 generation 1556078 fs info generation 2582703
> trying bytenr 22544384 got 1 blocks 0 bad
> checking block 22511616 generation 1555799 fs info generation 2582703
> trying bytenr 22511616 got 1 blocks 0 bad
> checking block 22577152 generation 1586277 fs info generation 2582703
> trying bytenr 22577152 got 1 blocks 0 bad
> checking block 22478848 generation 1561557 fs info generation 2582703
> trying bytenr 22478848 got 1 blocks 0 bad
> checking block 22593536 generation 1590219 fs info generation 2582703
> trying bytenr 22593536 got 1 blocks 0 bad
> checking block 22609920 generation 1551635 fs info generation 2582703
> trying bytenr 22609920 got 1 blocks 0 bad
> checking block 22560768 generation 1590217 fs info generation 2582703
> trying bytenr 22560768 got 1 blocks 0 bad
> ret is 0 offset 20971520 len 8388608
> ret is -2 offset 20971520 len 8388608
> setting chunk root to 22593536
>

Sigh, try again please.  Thanks,

Josef
