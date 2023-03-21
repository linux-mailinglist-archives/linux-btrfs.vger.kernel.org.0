Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C886C3058
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCUL00 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 21 Mar 2023 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCUL0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:26:25 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456E79B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:26:23 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id r11so58268060edd.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsKXet2zKypDSb8mXAuUA8n+0rji9UxLsCADONBDg/0=;
        b=dxz7snmBWqbNEOk3W0ILevtw09MEx/vWnt0d+t/Ops4sXZJKqxKlU8WIswlazpSttn
         3IEJOj3XkYhr9nkgNdPAN7gnF+tLKsmRKldBJFoGALMqgkwounTb35KNo5bF4e1ncljl
         tNulFcn0ZVGAYdVSM/JHJzXW+A38zp1VvOUTNUpQmGTKRI2iOEUPFTRnBbV9vjAEGlru
         zKzcQs0oSGsej0w2irpBvx/JklYsp3ezyR9o346Ei9MWFWSmiyfFLDi7l/os7WPcMnIZ
         tJUUVHt/8994+6iI+bngfRd9txbKDSlrhDab4vxveOETUwnU6LYtnHIjTTG5pdq4ee2X
         losw==
X-Gm-Message-State: AO0yUKUzXM8p3cI+wi4979e4yV81ZjSGpEdb0GSleNvRflO9TJtKPyEO
        BUW7lSDCuJwv636zT3DshgtaKwXiKxQGPQ==
X-Google-Smtp-Source: AK7set8jGgJum29W+UDbyhCgOid4phrzNf3/uVZgdf4Mi9NVKfLccJFHEQwYjbGvB6eQAUlIF3DxJQ==
X-Received: by 2002:a17:906:694b:b0:878:7cf3:a9e7 with SMTP id c11-20020a170906694b00b008787cf3a9e7mr2513781ejs.65.1679397981288;
        Tue, 21 Mar 2023 04:26:21 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906264b00b009255b14e91dsm5673984ejc.46.2023.03.21.04.26.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:26:21 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id y4so58331763edo.2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:26:20 -0700 (PDT)
X-Received: by 2002:a05:6402:5193:b0:4ad:739c:b38e with SMTP id
 q19-20020a056402519300b004ad739cb38emr10505881edd.1.1679397980570; Tue, 21
 Mar 2023 04:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230321020320.2555362-1-neal@gompa.dev> <a0073d57-1de7-3220-c706-b576e5cd407d@oracle.com>
In-Reply-To: <a0073d57-1de7-3220-c706-b576e5cd407d@oracle.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Tue, 21 Mar 2023 07:25:44 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_a9O2LR45fP73Ri+0jpezEGR6YiFZDLBDCt56-d+cLXg@mail.gmail.com>
Message-ID: <CAEg-Je_a9O2LR45fP73Ri+0jpezEGR6YiFZDLBDCt56-d+cLXg@mail.gmail.com>
Subject: Re: [RFC PATCH] btrfs-progs: mkfs: Enforce 4k sectorsize by default
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>,
        Hector Martin <marcan@marcan.st>,
        Davide Cavalca <davide@cavalca.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 11:03 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> On 21/03/2023 10:03, Neal Gompa wrote:
> > We have had working subpage support in Btrfs for many cycles now.
> > Generally, we do not want people creating filesystems by default
> > with non-4k sectorsizes since it creates portability problems.
> >
>
> I agree.
>
> > Signed-off-by: Neal Gompa <neal@gompa.dev>
> > ---
> >   Documentation/Subpage.rst    |  9 +++++----
> >   Documentation/mkfs.btrfs.rst | 11 +++++++----
> >   mkfs/main.c                  |  2 +-
> >   3 files changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
> > index 21a495d5..d7e9b241 100644
> > --- a/Documentation/Subpage.rst
> > +++ b/Documentation/Subpage.rst
> > @@ -9,10 +9,11 @@ to the exactly same size of the block and page. On x86_64 this is typically
> >   pages, like 64KiB on 64bit ARM or PowerPC. This means filesystems created
> >   with 64KiB sector size cannot be mounted on a system with 4KiB page size.
> >
> > -While with subpage support, systems with 64KiB page size can create (still needs
> > -"-s 4k" option for mkfs.btrfs) and mount filesystems with 4KiB sectorsize,
> > -allowing us to push 4KiB sectorsize as default sectorsize for all platforms in the
> > -near future.
> > +Since v6.3, filesystems are created with a 4KiB sectorsize by default,
> > +though it remains possible to create filesystems with other page sizes
> > +(such as 64KiB with the "-s 64k" option for mkfs.btrfs). This ensures that
> > +new filesystems are compatible across other architecture variants using
> > +larger page sizes.
> >
>
> This part is a little confusing.
>
> We can also include kernel versions that started supporting subpages
>
> v5.12   read support of blocksize<pagesize (subpage)
> v5.15   write support of blocksize<pagesize (subpage)
>

This is covered further down in the document. Though it does remind me
that I should rephrase some of it so that it doesn't say a default
mode is experimental. :)

>
> >   Requirements, limitations
> >   -------------------------
> > diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> > index ba7227b3..af0b9c03 100644
> > --- a/Documentation/mkfs.btrfs.rst
> > +++ b/Documentation/mkfs.btrfs.rst
> > @@ -116,10 +116,13 @@ OPTIONS
> >   -s|--sectorsize <size>
> >           Specify the sectorsize, the minimum data block allocation unit.
> >
> > -        The default value is the page size and is autodetected. If the sectorsize
> > -        differs from the page size, the created filesystem may not be mountable by the
> > -        running kernel. Therefore it is not recommended to use this option unless you
> > -        are going to mount it on a system with the appropriate page size.
> > +        The default value is 4KiB (4096). If larger page sizes (such as 64KiB [16384])
> > +        are used, the created filesystem will only mount on systems with a running kernel
> > +        running on a matching page size. Therefore it is not recommended to use this option
> > +        unless you are going to mount it on a system with the appropriate page size.
> > +
> > +        .. note::
> > +                Versions up to 6.3 set the sectorsize matching to the page size.
> >
>
>
> IMO this can be rewritten as below:
>
> By default, the value is 4KiB, but it can be manually set to match the
> system page size. However, if the sector size is different from the page
> size, the resulting filesystem may not be mountable by the current
> kernel, apart from the default 4KiB. Hence, it's not advisable to use
> this option unless you intend to mount it on a system with the suitable
> page size.
>
>
> Thanks, Anand
>
>
> >   -L|--label <string>
> >           Specify a label for the filesystem. The *string* should be less than 256
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index f5e34cbd..5e1834d7 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -1207,7 +1207,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >       }
> >
> >       if (!sectorsize)
> > -             sectorsize = (u32)sysconf(_SC_PAGESIZE);
> > +             sectorsize = (u32)SZ_4K;
> >       if (btrfs_check_sectorsize(sectorsize))
> >               goto error;
> >
>


-- 
真実はいつも一つ！/ Always, there's only one truth!
