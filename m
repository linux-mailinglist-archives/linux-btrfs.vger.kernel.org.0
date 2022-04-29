Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C997E515302
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379433AbiD2Rzp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiD2Rzo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 13:55:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F3F50476
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 10:52:25 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e194so10498414iof.11
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPZghlb2EhKpWW22kPJRs0NSM0hWT63QATrLrP3FJSE=;
        b=kmYYVvJuJ3EFHqD+TcDhj8CcmsVbifFiGDdeecp7wv0ATG4BGm66wIIhGBAcNOwD88
         q5DDHXqvnNr2b/AkRmwEsY5CYBwh59qrcTCR9sRjkA28OB5Lb9XqeHOGh6l/9E7sDQG5
         Q+qcgzXsoOaFZ+z8yrA91RBUep9TqFWX+DlxGpNmCSd0Jh2AlUdOH7xc0g1KhI/P5gd9
         B31NA4MZuxFWemslbvQmneq3L3GebpKlBZO1k4eFRHYp3I58CvLtdg3w0PBkotGP3FTA
         BI7K7uAmxNijTBabZiPAqMSeWZkJsN59djugFjiL0O9pn7rgg85ZXFD9jWH3vbdVtt8W
         1jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPZghlb2EhKpWW22kPJRs0NSM0hWT63QATrLrP3FJSE=;
        b=FczM7/l1TT0Si/Nn52qd5+RE4RtgPhDhreX1Z1sJIplfqzrndS8woyvlvu1/OaW+xv
         xQra3aUv9E2gCxlhuF0e0bof7A4IMIrYEZDwtGpHqT+6W7OEM0P37X7VBDto5Z9O3rQC
         1Qjzx2VAVqB50GRsMJepUE8bKyviJiUmtRIwUNgSaa4DmvRPDEHknNXmFgrCyVq9aklm
         Q5kV/wvGRlEOXPohZdfgo47eZnoa8SnQ0OfFURn0TB9np5UuCrKM1Uu11fk1xhYPIO7k
         AbWf4fPhBNmrGUEJv93g8RshKxy/yJopO7E1SXmWvu2jpyg59tGwg7+YOPo8Wlbo62Fw
         hdzA==
X-Gm-Message-State: AOAM532aiLv4gqtrc6VDvuuSdUv+QiPcDNhDfRc5uOyMf4WOMRRCUgOO
        vSeXTz+zdLFTmmiKt9z6wp490n3Tfzd4dvyKw6ZLwR3VpK4m/w==
X-Google-Smtp-Source: ABdhPJxNxq0uOVKFjc4iUqMb/ErMZlK6roF5CNc/GywdCSc7qH/5ZxuqWOUFOL2GD8kk2Bb63ehMilgvtii0RyKYYqE=
X-Received: by 2002:a02:6010:0:b0:31a:6d4f:d9ca with SMTP id
 i16-20020a026010000000b0031a6d4fd9camr226133jac.46.1651254745059; Fri, 29 Apr
 2022 10:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220428222705.GX29107@merlins.org> <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
 <20220429005624.GY29107@merlins.org> <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
 <20220429013409.GD12542@merlins.org> <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
 <20220429040335.GE12542@merlins.org> <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
 <20220429151653.GF12542@merlins.org> <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
 <20220429171619.GG12542@merlins.org>
In-Reply-To: <20220429171619.GG12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 29 Apr 2022 13:52:13 -0400
Message-ID: <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
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

On Fri, Apr 29, 2022 at 1:16 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Apr 29, 2022 at 11:27:54AM -0400, Josef Bacik wrote:
> > > processed 999424 of 109035520 possible bytesWTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths
> > > inode ref info failed???
> > > elem_cnt 1 elem_missed 0 ret 0
> > > misc/add0/new/tv1/ST/testfile.avi
> > > Failed to find [10467695652864, 168, 8675328]
> > >
> > > Program received signal SIGSEGV, Segmentation fault.
> > > 0x000055555557bc5d in btrfs_buffer_uptodate (buf=buf@entry=0x555565529a60, parent_transid=parent_transid@entry=1619139)
> > >     at kernel-shared/disk-io.c:2235
> > > 2235            ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
> > >
> > > We're making progress, thanks. Is there a way to add a BUG_ON instead of
> > > the subsequent SEGV?
> >
> > Yup done.  Also it's because I'm looking for the key in "dumping
> > paths" higher up.  This one is weird because we only got one output,
> > so for this one you want
> >
> > -d "76300,108,0" -r 160494
>
> Not sure how you got those numbers, but sure. I think it worked, but it
> doesn't give any output saying so
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "76300,108,0" -r 160494 /dev/mapper/dshelf1
> FS_INFO IS 0x5563243d9600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x5563243d9600
>
> not sure it worked:
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
> processed 81920 of 109019136 possible bytesWTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths
> inode ref info failed???
> elem_cnt 1 elem_missed 0 ret 0
> misc/add0/new/tv1/ST/testfile.avi
> Failed to find [10467695652864, 168, 8675328]

It did, now we're on a different root, you can do

btrfs-corrupt-block -d "76300,108,0" -r 161197 <device>

And keep it rolling.  Thanks,

Josef
