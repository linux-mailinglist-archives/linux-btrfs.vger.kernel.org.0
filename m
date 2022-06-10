Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5E546CB3
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350213AbiFJSsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 14:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350143AbiFJSsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 14:48:08 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB571A3BC
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 11:48:06 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e80so4709116iof.3
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EApXjp9aDDxCGaJc/H+nrOCARk7w2E0L5f8sPqlGofQ=;
        b=4kp8W1WTXo/lRJMzObgswObF2oX0MJ/HT/B9qniVmjjKbCH0DyJUtqwWzUiYm/fzgf
         oaVc8pazAR5M+UOWCzCBLFE/rcRRI9cFlWzFivfAYf3HG25PiM2vD8Zbli3PY0QXOQ69
         G5T0ybe+W5B0DLecJKurTHvgCYInMjrfS4LZHQ+0WU6rTza3NvziiQBqfDgqgrO0uJ6g
         vhdwQKSYnUtCG3ZOR3zqOnxRT3U1Cg64dq1mXH+LkUCtrTZbARRjEdLUgHEiCY3Fdcns
         AuYDNJl4jUpDPjiuzj6M05mcbumlh6BDiqxUzcsk2FYCqgFGeHkWwWiv+VtkhCyhX37S
         41nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EApXjp9aDDxCGaJc/H+nrOCARk7w2E0L5f8sPqlGofQ=;
        b=s2ZT+7UiJBNohXzzv0C2NpUcvnRGb45sY+dElEeJYC5y1yI8A1el8Sqa9kuP/N2B6G
         7jlp7NncxA4KMRxeLF0UJFJ6mWWzV70dniIbrWf4bEttAuiGUjoBraxfnU3kI6Edan4k
         w04A09uz0wONi3wrB5hqNOIdbbviqceiF+6FwGyKRR2ZvmVr1AyBndV5oNdrlB4nHz6C
         U367x7K7bgEY36FnUsM7FjW2D/UIg+b2Ajj6RzFKZC1H/Ei8Vy+lXuCcOextbnEYmU0R
         CBIrXjQiTZRVEMZraTMQvTYOUz0VmSOP5+sSaVR1efA0wh1J00VH6dz6/s9Uw127uMjN
         ctgg==
X-Gm-Message-State: AOAM5305LgsZbOqEswY30FmX5NGXsUWJZdHD0wiFuFUDr+3HxmRr4Rc9
        y5+f8PHuWVZvhueQJX1gSAhBahFiHermuPxXjF6JT8J9gEA=
X-Google-Smtp-Source: ABdhPJxQDr8vD6BgtC5h+SYFdGlgc0GiuRqrNyTDDx1OfNeGCZOeGh8zKxW/VAgLVTba5fldBSbcMo/VhT64XIuI0v4=
X-Received: by 2002:a02:9984:0:b0:32d:aeff:c592 with SMTP id
 a4-20020a029984000000b0032daeffc592mr24641465jal.46.1654886885373; Fri, 10
 Jun 2022 11:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220608004241.GC22722@merlins.org> <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
 <20220608021245.GD22722@merlins.org> <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
 <20220608213030.GG22722@merlins.org> <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org> <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
In-Reply-To: <20220609211511.GW1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 10 Jun 2022 14:47:54 -0400
Message-ID: <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
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

On Thu, Jun 9, 2022 at 5:15 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Jun 09, 2022 at 04:46:28PM -0400, Josef Bacik wrote:
> > Sorry this took me longer than normal to work out what happened and
> > how to fix it properly.
>
> It takes the time it takes, I'm sure nothing there is obvious
>
> > You can pull and re-run btrfs check --repair <device> and it should
> > fix the device thing that's missing.  We can tackle the other fs
> > errors next, but I want to see if we can at least get you mounting the
> > fs.  Thanks,
>
> Done:
> WARNING: reserved space leaked, transid=2606858 flag=0x2 bytes_reserved=49152
> root 164629 inode 73099 errors 1000, some csum missing
> WARNING: reserved space leaked, transid=2606859 flag=0x2 bytes_reserved=49152
> root 164629 inode 73100 errors 1000, some csum missing
>         unresolved ref dir 791 index 0 namelen 25 name Banlieue 13 Ultimatum.avi filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 3676 index 0 namelen 62 name foo filetype 1 errors 6, no dir index, no inode ref
> ERROR: errors found in fs roots
> WARNING: reserved space leaked, flag=0x2 bytes_reserved=49152
> extent buffer leak: start 15645018226688 len 16384
>
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/dshelf1
> UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
> cache and super generation don't match, space cache will be invalidated
> Fixed the nlink of inode 5644
> reset nbytes for ino 54987 root 161199
> reset nbytes for ino 54997 root 161199
> reset nbytes for ino 55002 root 161199
> reset isize for dir 55138 root 161199
> reset nbytes for ino 55458 root 161199
> reset nbytes for ino 55467 root 161199
> reset nbytes for ino 55474 root 161199
> reset nbytes for ino 55525 root 161199
> reset nbytes for ino 54987 root 161889
> reset nbytes for ino 54997 root 161889
> reset nbytes for ino 55002 root 161889
> reset isize for dir 55138 root 161889
> reset nbytes for ino 55458 root 161889
> reset nbytes for ino 55467 root 161889
> reset nbytes for ino 55474 root 161889
> reset nbytes for ino 55525 root 161889
> Fixed the nlink of inode 95666
> Fixed the nlink of inode 95666
> Fixed the nlink of inode 95666
> reset isize for dir 4549 root 164624
> reset isize for dir 25810 root 164624
> reset isize for dir 25812 root 164624
> reset nbytes for ino 26004 root 164624
> reset isize for dir 31346 root 164624
> reset nbytes for ino 72418 root 164624
> reset isize for dir 72587 root 164624
> reset isize for dir 72592 root 164624
> reset isize for dir 72639 root 164624
> reset isize for dir 72640 root 164624
> reset isize for dir 72672 root 164624
> reset nbytes for ino 73001 root 164624
> reset nbytes for ino 73006 root 164624
> reset nbytes for ino 73045 root 164624
> reset nbytes for ino 73066 root 164624
> reset nbytes for ino 73082 root 164624
> reset nbytes for ino 73086 root 164624
> reset nbytes for ino 73099 root 164624
> reset nbytes for ino 73100 root 164624
> reset isize for dir 3747 root 164629
> reset isize for dir 3752 root 164629
> reset isize for dir 3965 root 164629
> reset isize for dir 4549 root 164629
> reset nbytes for ino 40537 root 164629
> reset nbytes for ino 72418 root 164629
> reset isize for dir 72587 root 164629
> reset isize for dir 72592 root 164629
> reset isize for dir 72639 root 164629
> reset isize for dir 72640 root 164629
> reset isize for dir 72672 root 164629
> reset nbytes for ino 73001 root 164629
> reset nbytes for ino 73006 root 164629
> reset nbytes for ino 73045 root 164629
> reset nbytes for ino 73066 root 164629
> reset nbytes for ino 73082 root 164629
> reset nbytes for ino 73086 root 164629
> reset nbytes for ino 73099 root 164629
> reset nbytes for ino 73100 root 164629
> found 21916315648 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 8880128
> total fs tree bytes: 6799360
> total extent tree bytes: 606208
> btree space waste bytes: 2518033
> file data blocks allocated: 36729012224
>  referenced 36727418880
> gargamel:/var/local/src/btrfs-progs-josefbacik# mount -o ro,recovery /dev/mapper/dshelf1 /mnt/mnt
> mount: /mnt/mnt: wrong fs type, bad option, bad superblock on /dev/mapper/dshelf1, missing codepage or helper program, or other error
>
> [3956372.768821] BTRFS info (device dm-1): disk space caching is enabled
> [3956372.789085] BTRFS info (device dm-1): has skinny extents
> [3956372.863763] BTRFS error (device dm-1): dev extent physical offset 709781094400 on devid 1 doesn't have corresponding chunk
> [3956372.899452] BTRFS error (device dm-1): failed to verify dev extents against chunks: -117
> [3956372.926355] BTRFS error (device dm-1): open_ctree failed

Sorry I keep going back and forth on how to deal with this.  I've
pushed some code, you can run btrfs check --repair again and then try
again.  Thanks,

Josef
