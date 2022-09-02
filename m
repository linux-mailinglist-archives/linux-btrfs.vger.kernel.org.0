Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0715AAA41
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiIBIj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiIBIjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 04:39:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E633358
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 01:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E11B6B82A15
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 08:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A930AC433D6
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107961;
        bh=vHhC/ixBhWFL8oS/rSGrkRIHmfQKIcsHeuLLeEAIrXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=buhlk82SOd+CiFscSNYC41j6gsXTKTFgsMNOFrpyfffDlaV3LsB49dlwO6CtkofCQ
         BgeBieId/rr0hf2FRTtnIBB0/t/UbrNpX+VGrwi7DzSziTXhhA3KE292w9VGyjYqTx
         /Iz1FdZ27kirQwcaIOk6h84daKrbACILShgqzT8Zb0xAxSmTJPO6K8D5bnV9Jivbmc
         0Dv7tkP5M3dfnbO68CPIctNAhJI5asFYOZF9mghFRPbyB4wRV3SvG4Fslr7vDP01Am
         RmeOm994u4R+5WFL0NBLwv3pX5g/0XS+6rBCXM0+4ZUfAB82bqK5JAZLRCm1kogJwH
         g/KRUMnfd7jPA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11eb8b133fbso3266913fac.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 01:39:21 -0700 (PDT)
X-Gm-Message-State: ACgBeo1UogW9lhLIDY0sRCEvs79F97RaHfWFvYV6dHSF8U29focvj9Wd
        LIe8Y32ROkq0AnLJv7uZhSmint3n8rERaRCxBqg=
X-Google-Smtp-Source: AA6agR755LaxKJOUgjoalOrOwP5oVcE0MI+1nbyQHNQ4OIT5FR+VqSJJr6zPmzkkIp0hH3f3MeyRD9Oyyv0aOF634rA=
X-Received: by 2002:a05:6808:308c:b0:343:53c7:fbbb with SMTP id
 bl12-20020a056808308c00b0034353c7fbbbmr1422096oib.98.1662107960802; Fri, 02
 Sep 2022 01:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662022922.git.fdmanana@suse.com> <5bf31c02f5117ece6a1f4709af1c8b938f149d3e.1662022922.git.fdmanana@suse.com>
 <bea03117-d8b8-78f2-93a1-c1b81457b26e@gmx.com>
In-Reply-To: <bea03117-d8b8-78f2-93a1-c1b81457b26e@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 2 Sep 2022 09:38:44 +0100
X-Gmail-Original-Message-ID: <CAL3q7H56hh4Hp7J0Ngv_EFQg23SPexw9Csx5E4QqckZip-1efQ@mail.gmail.com>
Message-ID: <CAL3q7H56hh4Hp7J0Ngv_EFQg23SPexw9Csx5E4QqckZip-1efQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] btrfs: allow fiemap to be interruptible
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 1, 2022 at 11:42 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/9/1 21:18, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Doing fiemap on a file with a very large number of extents can take a very
> > long time, and we have reports of it being too slow (two recent examples
> > in the Link tags below), so make it interruptible.
> >
> > Link: https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
> > Link: https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Just one small question unrelated to the patch itself.
>
> Would it be possible that, introducing a new flag to skip SHARED flag
> check can further speed up the fiemap operation in btrfs?

Maybe, but given that fiemap is not btrfs specific, that's an
interface change that would have to be
discussed with all filesystem people.

>
> Thanks,
> Qu
> > ---
> >   fs/btrfs/extent_io.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 6e2143b6fba3..1260038eb47d 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -5694,6 +5694,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
> >                               ret = 0;
> >                       goto out_free;
> >               }
> > +
> > +             if (fatal_signal_pending(current)) {
> > +                     ret = -EINTR;
> > +                     goto out_free;
> > +             }
> >       }
> >   out_free:
> >       if (!ret)
