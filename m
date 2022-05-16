Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19636527AF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 02:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiEPABT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 20:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiEPABQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 20:01:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A5BF76
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 17:01:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e194so14311803iof.11
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bt45YKDC0FexQrYcRY37TlhyP79bZfleE0TchfYjYOo=;
        b=HGpUxa4WrJKA1IV5wFfo0cfl5uei6oceVroLz5zh+bb+XOUX+1EVQfAtseQFuwka48
         kniaoU++josRVQp5dxzEg0EZdCEk+I7BqqQvTk5SvtCMZvQa7OhDFSwCocmqW3tOS+2Y
         TxwMNRSijfuWvk+BWP8EWdHTmVAejbAdqLbY7t6gWYTv5HOzBN/5Yo0kyfPoC9ruioVA
         +lfAlgrdjB/me2DA0x6TsMdzjWWBkuTmMJEoQ8NsGU4xb3Y+EKUPgg/JxEjaWDsqaWTR
         4h4Qgka89QMVhfolReNqf1XZLJuLzh5MROrXi1jyMu3C4HfAV+w+eqeMqBmBI4uqkVpj
         jaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bt45YKDC0FexQrYcRY37TlhyP79bZfleE0TchfYjYOo=;
        b=h8uvE75FGW0aP/pMlyAbKjzwIWi7hB16bE8+vQZCU5bMgZR55I7fu5nOUFNlakGfOq
         iaQ3OQ5WVCoQqLIRe9k2I7PxeLnh9F9POK6mcb+3GGTOth6nzUS3oOkIr4yHCnWtCZiP
         DwzxT77tKkFG3C2MV8dtbBAaT90eGUQWe9SsUyOCxEjY4bfDsAO3QMZI4e6dLoh0cinr
         dFMkrx4QsjWfuJEAWzwBwx1pR1ZBNG1Y5Th1HWjSWcUxsF2nHdYqQLiOaQBVNCrM+XFg
         T2JOAWrGuOZ2tRHpQDjs2zSvWvHxQwlOXYVhfctFIbCGcFhPtHVtPy6B4xxbg6DSfeVm
         FXMw==
X-Gm-Message-State: AOAM530xC97iQ5PhtBS5tuyCQGCbkYEZJZ6oy1iXqmOshpHjhYKAaXy8
        ci99gEaunL8rocRhaK9On1oszF8MjV9lbl0IRP5jWfIg2oOW3Q==
X-Google-Smtp-Source: ABdhPJxa8CXCljauMbzg1xuZrX0mBO4dwEm4zuyFvkVDXged1fz8pAiAE4xfGKWAztO9zXe+025WLno0+pSGCcQVW50=
X-Received: by 2002:a05:6602:1545:b0:65a:c88e:4dfc with SMTP id
 h5-20020a056602154500b0065ac88e4dfcmr6811577iow.134.1652659273579; Sun, 15
 May 2022 17:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
 <20220515025703.GA13006@merlins.org> <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
 <20220515144145.GB13006@merlins.org> <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
 <20220515153347.GA8056@merlins.org> <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
 <20220515154122.GB8056@merlins.org> <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
 <20220515212951.GC13006@merlins.org> <20220515230147.GD13006@merlins.org>
In-Reply-To: <20220515230147.GD13006@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 15 May 2022 20:01:02 -0400
Message-ID: <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
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

On Sun, May 15, 2022 at 7:01 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 15, 2022 at 02:29:51PM -0700, Marc MERLIN wrote:
> > Now check --repair will be running for while, will report back...
>
> It wasn't as bad as I thought.
> It fixed a bunch of things (long output, I have it saved if needed),
> mostly orphanned stuff.
> and finished with
> root 165299 inode 95698 errors 1000, some csum missing
> root 165299 inode 95699 errors 1000, some csum missing
> root 165299 inode 95700 errors 1000, some csum missing
> root 165299 inode 95701 errors 1000, some csum missing
> root 165299 inode 95702 errors 1000, some csum missing
> root 165299 inode 95703 errors 1000, some csum missing
> root 165299 inode 95704 errors 1000, some csum missing
> root 165299 inode 95705 errors 1000, some csum missing
> ERROR: errors found in fs roots
> found 56720129146880 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 8334311424
> total fs tree bytes: 7565082624
> total extent tree bytes: 752779264
> btree space waste bytes: 1336306596
> file data blocks allocated: 59257396740096
>  referenced 59313065607168
>
> But I still can't mount the FS:
> [1802750.985454] BTRFS info (device dm-1): disk space caching is enabled
> [1802751.039629] BTRFS info (device dm-1): has skinny extents
> [1802751.401992] BTRFS error (device dm-1): dev extent physical offset 941709328384 on devid 1 doesn't have corresponding chunk
> [1802751.437568] BTRFS error (device dm-1): failed to verify dev extents against chunks: -117
> [1802751.482104] BTRFS error (device dm-1): open_ctree failed
>

Huh, did this pop during the btrfs check?  We can just delete that guy

btrfs-corrupt-block -d "1,204,941709328384" -r 3 <device>

and then you should be good, unless there are other dangling dev
extents that need to be removed.  Thanks,

Josef
