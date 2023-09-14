Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D97A06FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbjINONm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbjINONm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 10:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7873EB9
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694700770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY+CP7PPeTiKUsVVo6eXJmKy8GAfNBRK1WOF858s38U=;
        b=f83kOchQdd13U6BY1VCc6Ef6Nageu/d/K4OxftA/yV8mevOoc0wvOJyv/xx+/U5d6eRXEw
        8A2KZxiz02liWHlIlBy0qIZkOCILA9Ivu1ywbHGcRKb88ohArFC/9f2tc5C81AiEjD53Nc
        FZG0IQsOR1bQPk3IoX9VOr3gZypSwZI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-qXEKN-lGNDaXd2bqSps-Qw-1; Thu, 14 Sep 2023 10:12:49 -0400
X-MC-Unique: qXEKN-lGNDaXd2bqSps-Qw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c3d8bd4aa5so9399275ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 07:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694700768; x=1695305568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY+CP7PPeTiKUsVVo6eXJmKy8GAfNBRK1WOF858s38U=;
        b=J8E7r1aOtriG/3QWCfzonaen+im1ZOWhMZDhVT7Re8sMfK0ywGhjBnJoR05ZxFoaYK
         c7Ppjs3EfyWtAcLjZ9canL1eBuyT0jJE0gSmEh1xrGBvMmPaEhykt6HR/cfTc2OOsg5g
         ziNQW5fi9Afw0Jd4CbWVL/9OTKeNB0i+a1vokSXaCo0zynnuumueiczbSlIA5GrdNdyl
         I25OxZdxZYZ1yQ7T1DJ9xrq47pJqbhHT7U3bYtNqhaEq6I9cg+xWgGS+b4C/Wwyp00ut
         PUsekALmlQ7lOv3zzwoCrXE1RHbX0RKuJChB++th0A0GtOafaVBgHAR4cPTpg6ya4S3N
         ZbJQ==
X-Gm-Message-State: AOJu0YxCXRhWVyKepxbJ+fvHlmaR0YZS88ZGL2dJnF985tHXASPQwUiJ
        OLx54Es5P/74Hq3lwRIvuuFS51ESjzUINsBrEJUkIYW/QUokdL0yywDKyXwQkpeQzQq9+j+1U1A
        ikfpN9WorAXjcPevVtA3YOFM=
X-Received: by 2002:a17:903:228f:b0:1b6:a37a:65b7 with SMTP id b15-20020a170903228f00b001b6a37a65b7mr3047847plh.23.1694700768019;
        Thu, 14 Sep 2023 07:12:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwtA+krOmvQvdkFamgNOvi2/7jGd/KNpUwlKgmmW2LS8G67WN7u2rfcJ+WBhNxsKdv20HbKw==
X-Received: by 2002:a17:903:228f:b0:1b6:a37a:65b7 with SMTP id b15-20020a170903228f00b001b6a37a65b7mr3047820plh.23.1694700767651;
        Thu, 14 Sep 2023 07:12:47 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902694600b001b801044466sm1633010plt.114.2023.09.14.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:12:46 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:12:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs add more tests into the scrub group
Message-ID: <20230914141241.cflb23ydcr3a7xx4@zlang-mailbox>
References: <2fc42b09cdc710cc2ac83e3a1726b5f7b1d0af62.1693312237.git.anand.jain@oracle.com>
 <20230913163356.ngsh2ewut7wcevsw@zlang-mailbox>
 <56bb2f94-d29e-f27e-8209-bb61c8dabbd6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bb2f94-d29e-f27e-8209-bb61c8dabbd6@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 07:24:57AM +0800, Anand Jain wrote:
> 
> 
> On 9/14/23 00:33, Zorro Lang wrote:
> > On Tue, Aug 29, 2023 at 08:32:40PM +0800, Anand Jain wrote:
> > > I wanted to verify tests using the command "btrfs scrub start" and
> > > found that there are many more test cases using "btrfs scrub start"
> > > than what is listed in the group.list file. So, get them to the scrub
> > > group.
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > ---
> > >   tests/btrfs/011 | 2 +-
> > >   tests/btrfs/027 | 2 +-
> > >   tests/btrfs/060 | 2 +-
> > >   tests/btrfs/062 | 2 +-
> > >   tests/btrfs/063 | 2 +-
> > >   tests/btrfs/064 | 2 +-
> > >   tests/btrfs/065 | 2 +-
> > >   tests/btrfs/067 | 2 +-
> > >   tests/btrfs/068 | 2 +-
> > >   tests/btrfs/069 | 2 +-
> > >   tests/btrfs/070 | 2 +-
> > >   tests/btrfs/071 | 2 +-
> > >   tests/btrfs/074 | 2 +-
> > >   tests/btrfs/148 | 2 +-
> > >   tests/btrfs/195 | 2 +-
> > >   tests/btrfs/261 | 2 +-
> > >   16 files changed, 16 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/tests/btrfs/011 b/tests/btrfs/011
> > > index 852742ee8396..ff52ada94a17 100755
> > > --- a/tests/btrfs/011
> > > +++ b/tests/btrfs/011
> > > @@ -20,7 +20,7 @@
> > >   # performed, a btrfsck run, and finally the filesystem is remounted.
> > >   #
> > >   . ./common/preamble
> > > -_begin_fstest auto replace volume
> > > +_begin_fstest auto replace volume scrub
> > >   noise_pid=0
> > 
> > [snip]
> > 
> > >   # Import common functions.
> > >   . ./common/filter
> > > diff --git a/tests/btrfs/069 b/tests/btrfs/069
> > > index 6e798a2e5061..824ca3c3110b 100755
> > > --- a/tests/btrfs/069
> > > +++ b/tests/btrfs/069
> > > @@ -8,7 +8,7 @@
> > >   # running in background.
> > >   #
> > >   . ./common/preamble
> > > -_begin_fstest auto replace scrub volume
> > > +_begin_fstest auto replace scrub volume scrub
> > 
> > The btrfs/069 has been in "scrub" group, others looks good to me.
> > 
> 
> Oh no! Would you please remove this line and merge it?
> Or, I can fix it in the upcoming PR. Or, I can reroll this
> patch.
> Thank you!

I'll remove it when I merge it, don't worry.

Thanks,
Zorro

> 

