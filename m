Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57C511D15
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiD0RxM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 13:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiD0RxJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 13:53:09 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AE346171
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 10:49:58 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h8so4013097iov.12
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNMTYrzckXLYP7m7U/rv3SAUbc4tV5RXSxhSPtx4E68=;
        b=Q+0yjIuGtMwWgS9jJpy6sM7vrQqLEXCkw2EaXZStnu5EZlVVardr+CRGS6HGdCZ/mZ
         b140KsWjV/uUuQLerx/Ytb9gWqTKWpFkuH14Z0DJaLSituFap16PRAD7HmMGBN6+O0SU
         gAZMNYfvwehjES4OQ1MBEtHwrmy/Af0KbjEfYqkw+0z+rUqg1+a1VuEwGZFgm8ZdDPXc
         e+m7XOVsVtZ9jXdLAfvgQFHq/oLkxQfD4Wlmb+MHMSP7+8LWTGxaHGb1ZaPe8ijEyavs
         gQYjLyR8bPGgXcOUL5lPAhdpwYuJKRODHZbDt4l2GHQ9robwoB9BjBPiG9pmH9pVlsNF
         2WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNMTYrzckXLYP7m7U/rv3SAUbc4tV5RXSxhSPtx4E68=;
        b=R+C4h9XfmhOdh7slb/h7FlSl4YlAEbDN+pr+gverf9mCXPRiW2QJizbOAMJiuIqJ9P
         eZ0cqzLeinySWt2jaF5E1gtpBpCA6YSCTvcUvk+oFTBT22gAKzrK4ybBEmgafY3bPie1
         GmjZjYmb+PAxF605NyeeWiYjq7ro9gOzYW/yoGly+f2NOpvGUfssVAHnc2glvM9exUVi
         vlLZjwo9miYDkhS/rlodvHISVEZFTtUyfGHWIJRFIb4DcM4qmNO+GlASGtCM8OVwefrC
         zh3GVSN2CVuiN3+94hP5a+qdj+Z+eb3oVMadT4or+fjMmL7BVcwJCq3dkgF3+KSAIr8+
         LaTw==
X-Gm-Message-State: AOAM53042OgBsuH4ULX94/HkXCGbxGxTPwrb/HsDrI5tFgeJLcelAO/Z
        aOu+hu1hSsUY34PV1g3bDFaTYdHNCtPOcBAkEzlE330lizM=
X-Google-Smtp-Source: ABdhPJzaXmDIzXUiWHAiudVJ+u+P4GEFIQpO6Q8gzxBI08UDSCPTbVu39w7gVEwZDAtn3M6vxrtqWQvdHtQ+mW/MMfk=
X-Received: by 2002:a05:6638:3795:b0:32a:f753:fd92 with SMTP id
 w21-20020a056638379500b0032af753fd92mr6074199jal.102.1651081796887; Wed, 27
 Apr 2022 10:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220424231446.GF29107@merlins.org> <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
 <20220425002415.GG29107@merlins.org> <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
 <20220426002804.GI29107@merlins.org> <20220426204326.GK12542@merlins.org>
 <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
 <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
 <20220427035451.GM29107@merlins.org> <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
 <20220427163423.GN29107@merlins.org>
In-Reply-To: <20220427163423.GN29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 27 Apr 2022 13:49:46 -0400
Message-ID: <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 12:34 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 27, 2022 at 10:44:26AM -0400, Josef Bacik wrote:
> > On Tue, Apr 26, 2022 at 11:54 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Tue, Apr 26, 2022 at 05:36:28PM -0400, Josef Bacik wrote:
> > > > On Tue, Apr 26, 2022 at 5:20 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > > >
> > > > > On Tue, Apr 26, 2022 at 4:43 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > > >
> > > > > > Generally would you say we're still on the right path and helping your
> > > > > > recovery tools getting better, or is it getting close or to the time
> > > > > > where I should restore from backups?
> > > > > >
> > > > >
> > > > > Yup sorry for the radio silence, loads of meetings today, but good
> > > > > news is I've reproduced your problem locally, so I'm trying to hammer
> > > > > it out.  I hope to have something useful for you today.  Thanks,
> > > >
> > > > Sigh I'm dumb as fuck, can you pull and re-run tree-recover just to
> > > > make sure any stupidity I've caused is undone, and then run rescue
> > > > init-extent-tree and then we can go from there?  Thanks,
> >
> > Ok back to this problem again, I've added some debugging.
> > Unfortunately the real bytenr is getting lost, so the new debugging
> > will print the actual bytenr we're trying to add, and then I can add
> > more targeted debugging to figure out whats going on.  Thanks,
>
> Small typo:
>   409 |  prinf("doing insert of %llu\n", key->objectid);
>         |  ^~~~~
>         |  printf
>
> Result:
> doing insert of 12233379401728
> Failed to find [7750833868800, 168, 262144]

Oh it's data, interesting.  Pushed some more debugging.  Thanks,

Josef
