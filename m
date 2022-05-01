Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EA3516143
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 04:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiEACvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Apr 2022 22:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEACvp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Apr 2022 22:51:45 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2D27157
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 19:48:20 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e3so9590929ios.6
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 19:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65iMfKN9HlZPd8yasTWkzPoKLGrWYEG9HIKu63R9N/I=;
        b=aKxMTY4wkz+Sf9ys+rFQFZvaZHFeVmaZcsI2/vb7LAWlyzN7+bCbJLMtYoJdEiEArw
         19FAUBaco8tZI/0Q8r8tNRjA1wG41ojx8IJIQ0fAUZMBC1f3AAczKQlFfCbi07BqZjC9
         66AEj0rGcDksi910cFa/T9k8Lem2SrSd5vU29SgTrdIT5JBNLEkW8Q84hp3OsJEJucEx
         rvGY09KL/DERDxZM2u9KWJQ2Hi+G4951KDXEbjMf1N8sb8yGODu7J7GbJf4RhV18rlfa
         WdTEEExuhC2vIhdaLWhBA+v9QSL1mdr33PSe7RyVTD5ipKsXBULj/TLdelYRiICOUeJU
         qo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65iMfKN9HlZPd8yasTWkzPoKLGrWYEG9HIKu63R9N/I=;
        b=NyQ+3noWSmmTORkdwptReEhk40+Fstov4CVLZdNvGOkCESAarKcBG5o4NGh+Qx6mjq
         NnreD0DvVz8Fwuw4uOzldam6YIoArZ1wX6dIyKz4oZjD9gvQu7HrnRZDCo9B2qMh/Ur1
         t57XcbuCL5txqZax9xBg0QTsMlQFrZyCQGDuGQXWckizMvJPqLwkYVpUuBvPaLq0y+61
         8yAknAEnN0OwmnRTdNxeQE1UmwBZYwkCAUjyU9wcFH4DHSMcRLdmMvTVCzE01n8tglwi
         Y2Ig/gSWJqRStFWNeeIl6yccTR/0fSciclflLdD2PvMGq8He2d43FxoXy93vVbIzqcsE
         7e7g==
X-Gm-Message-State: AOAM530bW16Ldw0xgcRewnsd/urKLRHJ+e45gJOpHZqeNM7r/0ZO7sYt
        7bmQYW7yGedvXP2ntYbvD3QVZjqiPr95DaWjV5O8ok8D9Rs=
X-Google-Smtp-Source: ABdhPJwe40J1JhFmTQ3BPrwkpjMQpje/I6MCaaR+8HSGv5A+WGHe40eJU/lx5zyJoxDhRVGQW/OyFhZbw5BE7KrwrQE=
X-Received: by 2002:a02:6010:0:b0:31a:6d4f:d9ca with SMTP id
 i16-20020a026010000000b0031a6d4fd9camr2692028jac.46.1651373299404; Sat, 30
 Apr 2022 19:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220429151653.GF12542@merlins.org> <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
 <20220429171619.GG12542@merlins.org> <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
 <20220429185839.GZ29107@merlins.org> <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
 <20220430022406.GH12542@merlins.org> <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
 <20220430130752.GI12542@merlins.org> <CAEzrpqc3jBA4gRiLuYWFgs8zu_XrNDZ_JS+d2J_TN2a-sivO=w@mail.gmail.com>
 <20220430231115.GJ12542@merlins.org>
In-Reply-To: <20220430231115.GJ12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 30 Apr 2022 22:48:08 -0400
Message-ID: <CAEzrpqe9Kh7k6n_ohyjgeMm4Pvy6tNCoKBXBPKhtcC5CrVfexw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 30, 2022 at 7:11 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sat, Apr 30, 2022 at 12:40:46PM -0400, Josef Bacik wrote:
> > On Sat, Apr 30, 2022 at 9:07 AM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Fri, Apr 29, 2022 at 11:13:08PM -0400, Josef Bacik wrote:
> > > > Hooray we're at the data reloc root.  It should have been cleared tho,
> > > > so I've fixed it up to see if it's doing the right thing, it should
> > > > clear it this time, if it doesn't let me know.  Thanks,
> > >
> > > Great
> > >
> >
> > Ok this is easier, the transaction commit stuff doesn't work quite
> > right in progs, I've fixed the code and it should succeed this time.
> > Thanks,
>
>
> ainserting block group 15837217947648
> inserting block group 15838291689472
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1474560 of 0 possible bytes
> Recording extents for root 4
> processed 1032192 of 1064960 possible bytes
> Recording extents for root 5
> processed 10960896 of 10977280 possible bytes
> Recording extents for root 7
> processed 16384 of 16545742848 possible bytes
> Recording extents for root 9
> processed 16384 of 16384 possible bytes
> Recording extents for root 11221
> processed 16384 of 255983616 possible bytes
> Recording extents for root 11222
> processed 49479680 of 49479680 possible bytes
> Recording extents for root 11223
> processed 1635319808 of 1635549184 possible bytes
> Recording extents for root 11224
> processed 75792384 of 75792384 possible bytes
> Recording extents for root 159785
> processed 108855296 of 108855296 possible bytes
> Recording extents for root 159787
> processed 49152 of 49479680 possible bytes
> Recording extents for root 160494
> processed 1179648 of 109035520 possible bytes
> Recording extents for root 160496
> processed 49152 of 49479680 possible bytes
> Recording extents for root 161197
> processed 147456 of 109019136 possible bytes
> Recording extents for root 161199
> processed 49152 of 49479680 possible bytes
> Recording extents for root 162628
> processed 49152 of 49479680 possible bytes
> Recording extents for root 162632
> processed 2129920 of 109314048 possible bytes
> Recording extents for root 162645
> processed 49152 of 75792384 possible bytes
> Recording extents for root 163298
> processed 49152 of 49479680 possible bytes
> Recording extents for root 163302
> processed 147456 of 109314048 possible bytes
> Recording extents for root 163303
> processed 81920 of 75792384 possible bytes
> Recording extents for root 163316
> processed 49152 of 109314048 possible bytes
> Recording extents for root 163318
> processed 16384 of 49479680 possible bytes
> Recording extents for root 163916
> processed 49152 of 49479680 possible bytes
> Recording extents for root 163920
> processed 81920 of 109314048 possible bytes
> Recording extents for root 163921
> processed 49152 of 75792384 possible bytes
> Recording extents for root 164620
> processed 49152 of 49479680 possible bytes
> Recording extents for root 164624
> processed 491520 of 109445120 possible bytes
> Recording extents for root 164633
> processed 49152 of 75792384 possible bytes
> Recording extents for root 165098
> processed 212992 of 109445120 possible bytes
> Recording extents for root 165100
> processed 16384 of 49479680 possible bytes
> Recording extents for root 165198
> processed 49152 of 109445120 possible bytes
> Recording extents for root 165200
> processed 16384 of 49479680 possible bytes
> Recording extents for root 165294
> processed 16384 of 49479680 possible bytes
> Recording extents for root 165298
> processed 81920 of 109445120 possible bytes
> Recording extents for root 165299
> processed 16384 of 75792384 possible bytes
> Recording extents for root 18446744073709551607
> processed 16384 of 16384 possible bytes
> ERROR: commit_root already set when starting transaction

Well it looks like it finished, but I don't see my "start transaction
failed" messages which should be printing, I've added some extra
debugging to figure out wherever this is failing.  We're literally
done and of course it's failing somewhere at the end, hopefully
this'll be quicker to nail down.  Thanks,

Josef
