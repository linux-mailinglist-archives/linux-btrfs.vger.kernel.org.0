Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF434F544B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiDFErJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573662AbiDEWwl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 18:52:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC04144B6C
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 14:35:14 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id 8so560373ilq.4
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWarZzqtzgjQk5QsygJ8qHyRtOB8YVYlIdehUgngh/s=;
        b=rXZmpvy+MzDGICjP1OzbwHkifn0JoBcSc+dzFxR2X6f6qyivGR8g2DKj1qUjmZWFyI
         YxgI8wNO34bnJY11PWjdWHeGs1j09VbQLygtWtD7tu6jayk+tW4mI68Oi+dmQSAad4Fq
         UReX8vTINeSjyqQizlHAjyNTHerGm98fZoW8AEXZlQKfb+Xi6ZzzykRycD5hLggVDK1S
         5ROeDH3TZHd5jyzWDoJaxabxV0asGyOqQULRiDhjtip4imej71taOJLHpVg93JsQnRn7
         LfYty+5synPyjGYhdOf2gbdCKSj0U7Hm7LDJ/Sk7+d8sz0muAZfSdDLVQzsiNXQqbbpM
         hUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWarZzqtzgjQk5QsygJ8qHyRtOB8YVYlIdehUgngh/s=;
        b=x/Led4l4OyGaDouMWacafBaO2HSui+9LgkTGbe6KxOpV2oYX00wZBuIxSk2MncRJO/
         9CoWuw1xHmsz7dNbZruekYmudegiVsDsMLu91aC+yPftYsUTHchmCDcCObqhKSkMoa/d
         wpLfuXiuUJJez/IxaK01zgSmcokUKdLZauWnS+oMHUrOTnRWeuOlcI5lf4vUmH9uvifa
         RgQe0kcUsAuDXnWPPDVfFUDnssFIr2awqEg/8sNPpfEHIaSbdwNyKo/8vcmei2iiniIN
         I4NgNI39yGEKd0SjU9GGIG25Y79au5YpqYMkT4TQFjKBRb6ua575Rh10DlX/fX+e0pTT
         stgA==
X-Gm-Message-State: AOAM5339b9k9Dg/SGE5g6klis5NzDrpqRKYyP7QUR/3zEjL5xAMetQ0K
        SY7m8PDYFxe/7fQLC8Z5x4rlbBy6yeQ+VyyDP2f5vy2RaRw=
X-Google-Smtp-Source: ABdhPJyy5Hxvy69iMUSVwNxVqtQE+g2FbhQlvzhRhtEpdYVUa4Rf8O+FlyCf6MJX8FbFoyOaadCK8K+mjAMa5VgAVMc=
X-Received: by 2002:a05:6e02:b4d:b0:2c8:45ac:66b1 with SMTP id
 f13-20020a056e020b4d00b002c845ac66b1mr2886940ilu.153.1649194513588; Tue, 05
 Apr 2022 14:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220405195157.GA3307770@merlins.org> <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org> <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org> <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <20220405203737.GE28707@merlins.org> <CAEzrpqemQ2Uzi+ZJHtQtbF62=hZMTmuPT3HxwkYedUvAsXhdvQ@mail.gmail.com>
 <20220405211412.GF28707@merlins.org> <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
 <20220405212655.GH28707@merlins.org>
In-Reply-To: <20220405212655.GH28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 17:35:02 -0400
Message-ID: <CAEzrpqc0Ss+J6oTqNPfTgWOwyhPAF2uHnRELmc6AO6je6Ht88w@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 5:26 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 05:19:57PM -0400, Josef Bacik wrote:
> > Otra vez por favor,
>
> (gdb) run -o 1 /dev/mapper/dshelf1a
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs-find-root -o 1 /dev/mapper/dshelf1a
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> FS_INFO IS 0x5555555cf2a0
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Couldn't find the last root for 4
> Couldn't setup device tree
> FS_INFO AFTER IS 0x5555555cf2a0
> Superblock thinks the generation is 1602089
> Superblock thinks the level is 1
>
> Program received signal SIGSEGV, Segmentation fault.

Ugh sorry, try again.  Thanks,

Josef
