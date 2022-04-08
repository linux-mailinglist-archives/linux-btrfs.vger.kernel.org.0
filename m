Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4744F9E0F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 22:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiDHULv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiDHULu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 16:11:50 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1678C1CFFF
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 13:09:46 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h63so11895558iof.12
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Apr 2022 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKG1ik/AYLK6b/MP0w1iQHfZHLGfkbisG8AbHotVU10=;
        b=Byu7yjBjt/ECpyk1ZijPXGypcQAIZKjQ9o080yjxUJgOGmFneBBTIwJYFEHA7b38MQ
         VdHxYZHk+BtBj2e6Gif5WQW/o4ATdCrMRs76QEsMaltATtvAovkPHBRQwSVm6jpzTK5c
         N3NAOuc/ONsbFtG+OC2S1QOxAndBBFFy0S8mS+TXJpSfi/RwzV/vTFkHYN3CU+G7QX4V
         5uCHx/nIDYfCo4wxVDoaXz1SPZKFGi6xCvgSByHfw+84J6rsvEsknRgY/nQnKefd/DUk
         4p1S+BHhPQhjaPOhmKq+xS6qDQ2z1nrbD3t5SqkSAQ0G1EUd9edP+pWueJlTl3evHibh
         /0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKG1ik/AYLK6b/MP0w1iQHfZHLGfkbisG8AbHotVU10=;
        b=zQPbp0971HqvA+HNHwRZOtC5YEp2D9oa3mqeei95GXUztP5UAw8zx6a3DcdzzDz0/R
         7GAIJa6j8cOfcUcyKQY4WcAgF4yfJDpnluDzDyPFi4qVGKu9WiSSwD2l/+bAOUbbR6Z/
         sgHzSjHCKbmegLAlBUTfRCKPyfepPTRvNljpds5Pk91yCg6iRM4mutsp227vUM3aErpR
         9CWEwK8GvhxoFryYVX+Nd/+IEFzBTfyNVZyALfw5B2W9owGY01kD100QXZDiG1d9eaDc
         bODxS8kJmta4FpftwxxsVd9bfpVaDLepa/6oypM6NWozPdagyikRF+1DVCelYAD6eVj/
         rqPA==
X-Gm-Message-State: AOAM530fKz+UsLDB/3UR7JK4rCa1LuqbTGkZG1V0t3MTN2XfRjd0DyVV
        amRH2GSh7ZV0099HpTcajxzYzqQzNFIvKKGqcjSVgmH6Yqw=
X-Google-Smtp-Source: ABdhPJz2l2loMMtmsTX7KOmntfudIqApIgo0qixnEA8pP0/n0SPYrDyTKq6f8uW2OsNf/ccFdhkZ4haTpmR/VVZbnzA=
X-Received: by 2002:a02:9585:0:b0:324:202d:224e with SMTP id
 b5-20020a029585000000b00324202d224emr4947239jai.218.1649448585354; Fri, 08
 Apr 2022 13:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <11970220.O9o76ZdvQC@ananda> <20220407052022.GC25669@merlins.org>
 <20220407162951.GD25669@merlins.org> <CAEzrpqdeph1AM74habMeOg_VURv5AFvZZ-9aUM9ZVEkM+-3Xkg@mail.gmail.com>
 <CAEzrpqdjKE3ehKjEqWOuBHPuScpjDG+B7r81SP1Vd+G8RVK6rA@mail.gmail.com>
 <20220408102209.GG25669@merlins.org> <CAEzrpqf+64jMsWnddCuoiVPEWyHOK+U3cGJMHrFAdHRn2Vbd0g@mail.gmail.com>
In-Reply-To: <CAEzrpqf+64jMsWnddCuoiVPEWyHOK+U3cGJMHrFAdHRn2Vbd0g@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 8 Apr 2022 16:09:34 -0400
Message-ID: <CAEzrpqf1etZPKDrNexLLerdz3zXUai-zOfj8=LXzjbxdwiom0g@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 8, 2022 at 6:23 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Fri, Apr 8, 2022 at 6:22 AM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Thu, Apr 07, 2022 at 06:09:53PM -0400, Josef Bacik wrote:
> > > Just following up on this, I've got hungry kids, I'm about halfway
> > > through the new shit.  Depending on how much help kids need with
> > > homework I may have this done later tonight, or it'll be tomorrow
> > > morning.  Thanks,
> >
> > It finished after more than 24H, but that didn't seem to be enough, quite.
> > Hopefully we're getting closer, though :)
> >
>
> Yup we're getting there, I'm about 90% done with the new stuff, and
> that'll delete block pointers that we can't find good matches for.
>
> Also it'll cache the results of the disk wide search, so it'll have to
> do it once per root instead of for every bad block we find, which will
> drastically cut down on the runtime.  I'll let you know when it's
> ready, figure another hour or so.  Thanks,
>

Course the last 10% takes the longest, but I corrupted a local file
system and ran it to shake out all the stupid bugs.  Go ahead and pull
and run

./btrfs rescue tree-recover /dev/whatever

and then *hopefully* you can just run btrfs check --repair, but it may
fail out with a "btrfs unable to find ref byte", which is what I was
seeing locally.  I'm fixing that but it's tricky and may be a while.
If you hit that then go ahead and use --init-extent-tree
--init-csum-tree and let it ride.  Thanks,

Josef
