Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E58F512A48
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 06:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiD1EG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 00:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiD1EGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 00:06:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8CE986C2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 21:03:41 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g21so5253278iom.13
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 21:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muu3F1hFkmATCIbq7i5afIErLPNlG/dezHLNuykAiIE=;
        b=nmkCCjnm8IibKZozcvhrK5nnbWXFAH0D/CMFe/AT3K4kzngtNREIE3+Wr6OcZHQ7/g
         s8g38KOWJXrIH9YcCcQAZdEumU2YvXAxqy5bQo4ntN+W2zCv1STsrZ1ZC+o5dnMxUW7q
         jtxzgm6IofrZytdBWotkXS7OxMqzdwrpbWu1hfGNukFhWrg8hAwS5pYmNNJ39B8tSqog
         NE7+uSE+ZsACYmnvkvw4CJMWlYMn114SOLBDP7uA9PttJah/60zfipAjqM10CU4x6NP+
         0kFUFjGVw1eEtEH50bWEOtLdxsDOxFXXgWimhGgQWhfvOSYwACtNcqPcTx2lCwmoVa6O
         mbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muu3F1hFkmATCIbq7i5afIErLPNlG/dezHLNuykAiIE=;
        b=B7yO4FhMNhnCtsJacK/arRHTc+vYM04D1iJAOIOZc/o5fTNbfebZQ1oOw4iuSwHMyz
         +z6hxbYwMlwwm+t2v8/m+ODcHPRRP9Bu0P6TlZA0CIe/KnM3Fz7/StshG+oq1xbkzOEx
         1S6jFBFnUc789CU59cO5k3kDjFkekemVR+6K6vvi2m850t0W5lchOokVioz/CyOA9eo/
         K6xZRgaqhkYtaFL6/MCn1co5LlFFJd/aqp0SwKIO34b3bbhSaRj2fHrPY1Cr9D0V6IU7
         5WPzfaPHQ5O65S7ptzd+bESN8J3rKMr3S6IiMcWWtD0qKkOOlkhe5VN15lwN7oDUafjE
         cRSw==
X-Gm-Message-State: AOAM531RszL4UGgX1dZTy2r1gACUKnxM4o/afFWXj3Weagk/PA7ITexA
        ClFIt9WfH9XLyxRpuh3CSZPeDk8Hpqxkz456tT3Z8AEV/GM=
X-Google-Smtp-Source: ABdhPJw+kmwTjJKPK78PZmMteHtXoi4rF7TC82X6YaTZKwPVtozGtcwaTaS2EIhDmTKaM+m5YKQI1D7cm8pX/YgxD8M=
X-Received: by 2002:a05:6638:2501:b0:32b:b8e:634d with SMTP id
 v1-20020a056638250100b0032b0b8e634dmr4698966jat.281.1651118620727; Wed, 27
 Apr 2022 21:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org> <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org> <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
 <20220428001822.GZ12542@merlins.org> <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
 <20220428030002.GB12542@merlins.org> <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
 <20220428031131.GO29107@merlins.org>
In-Reply-To: <20220428031131.GO29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 28 Apr 2022 00:03:29 -0400
Message-ID: <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 11:11 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 27, 2022 at 11:08:02PM -0400, Josef Bacik wrote:
> > On Wed, Apr 27, 2022 at 11:00 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Wed, Apr 27, 2022 at 08:44:01PM -0400, Josef Bacik wrote:
> > > > Ok it should work now.  Thanks,
> > >
> > > Mmmh, it got worse, unfortunately
> > >
> >
> > Well not worse, just failed earlier because that's where the new code
> > is.  I think I just made a simple mistake, but I added some print'fs
> > just in case.  Thanks,
>
> That helped:
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 1474560 of 18446744073706422272 possible bytes
> Recording extents for root 4
> processed 1032192 of 1064960 possible bytes
> Recording extents for root 5
> processed 10960896 of 10977280 possible bytes
> Recording extents for root 7
> processed 1707278336 of 16545742848 possible byteskernel-shared/extent-tree.c:1193: insert_inline_extent_backref: BUG_ON `owner < BTRFS_FIRST_FREE_OBJECTID` triggered, value 1
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x2975e)[0x55555557d75e]
> /var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_inc_extent_ref+0x138)[0x55555557ed77]
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x8be01)[0x5555555dfe01]
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x8beab)[0x5555555dfeab]
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x8beab)[0x5555555dfeab]
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x8c116)[0x5555555e0116]
> /var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_init_extent_tree+0xe96)[0x5555555e1089]
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x83a43)[0x5555555d7a43]
> /var/local/src/btrfs-progs-josefbacik/btrfs(handle_command_group+0x49)[0x55555556c17b]
> /var/local/src/btrfs-progs-josefbacik/btrfs(main+0x94)[0x55555556c275]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7ffff78617fd]
> /var/local/src/btrfs-progs-josefbacik/btrfs(_start+0x2a)[0x55555556be1a]
>

Cool, we're pointing at the same block in different places in the same
tree.  I should make tree-recover catch that and fix it, but since
you're going to re-generate your csum tree anyway I've adjusted
init-extent-tree to just clear the csum tree too, lets see how far we
get with this.  Thanks,

Josef
