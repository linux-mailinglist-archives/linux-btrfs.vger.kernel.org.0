Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84ED520358
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbiEIROF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 13:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbiEIRNn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 13:13:43 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FFF1ED28F
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 10:09:49 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y11so9748298ilp.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vybbszrcoSrse+jFB5aH+y7IiYJX4ElqGwbjJN6CGS4=;
        b=ycjelJnwZsfA7qs0xzt+UJFPZYn8FLI6L0Io8vC6OzKkpzm9pt1cLxU79t8mBxgGZD
         BcJfWb5C8OHSEe+AskpFlar9mgvpuF7pbDb3I2EaowSbn7k/S643r4D4+emNE6TyGdTe
         xbnrxIrUGm9KKVxogBl2AUsDqLMn+nVKqfKN/rewOz6KHo7DC0VM1Hmj98x9MCzY/ivF
         c7kqJlDavuy3DSUhBKFMppr1Vn/jENYAGAbt4b2LwuunC6Ve//Bu17ngDYifSCf+/CYi
         1XpxErbCt6qOnm1BbNOYGsr43Qe7W2yC96fW2IOiBZFAZKq3scHlzx8ifgNBIWK4qZs9
         nmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vybbszrcoSrse+jFB5aH+y7IiYJX4ElqGwbjJN6CGS4=;
        b=GCl6hqhk5TCH+y1anYM9pmiodnuWE5SRh5E3O6kC3MXtqzk/EO0sHFj3dN566+wWr/
         y/U11Xv/WhB/qsjyK0YM4rfqewfWdmOnKNGe0+BHxnsj76eM/7QdwyxBOpSu3iAo/4Po
         jlqG6y6xvkgzu++PeBxSN/951WqTEbpsFAsadpAstmdOs9ifQYzDy7RTukRAgt48QFYy
         DrfXmji95qJKQtuVYiXiLsPjyUrkBAauUahg5MXZy9BMh9Ey6e3nwB8gFo9Y4B/Dm0+2
         d1yM+png8HaDwCOMpSqCWSKq7B4Oca7KS5h/Fdu3rtaVq+NhBhe4OkELtvo3IGh0ByUM
         00Ug==
X-Gm-Message-State: AOAM531zpxn59W2oK1ozWhIXzzqLDZiFIYtO0HdkagabGCieBdKcwnQI
        yje7ztjKUv+ER6PO3VujZ1hUIc0gN5Z+lKEZWdBsgfBqNBc=
X-Google-Smtp-Source: ABdhPJzQCv0hGImD5FMEm+Q5IPbZa27Pro7sojLuYDQPlGx1/wYEo+cpVkewmftu1pI7wk8fLSYhyDO67oSVWosSDDI=
X-Received: by 2002:a05:6e02:198e:b0:2cf:4a7a:faf8 with SMTP id
 g14-20020a056e02198e00b002cf4a7afaf8mr6721195ilf.206.1652116188259; Mon, 09
 May 2022 10:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220507193628.GO12542@merlins.org> <20220508194557.GP12542@merlins.org>
 <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
 <20220508205224.GQ12542@merlins.org> <20220508212050.GR12542@merlins.org>
 <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
 <20220508221444.GS12542@merlins.org> <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
 <20220509004635.GT12542@merlins.org> <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
 <20220509170054.GW12542@merlins.org>
In-Reply-To: <20220509170054.GW12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 9 May 2022 13:09:37 -0400
Message-ID: <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
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

On Mon, May 9, 2022 at 1:00 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 09, 2022 at 12:17:30PM -0400, Josef Bacik wrote:
> > On Sun, May 8, 2022 at 8:46 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, May 08, 2022 at 08:22:19PM -0400, Josef Bacik wrote:
> > > > On Sun, May 8, 2022 at 6:14 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > >
> > > > > On Sun, May 08, 2022 at 05:49:17PM -0400, Josef Bacik wrote:
> > > > > > Yeah this is the divide by 0, the error you posted earlier is likely
> > > > > > because of the code refactor I did to make the delete thing work.
> > > > > > I've added some more debugging to see if we're not deleting this
> > > > > > problem bytenr during the search for bad extents.  Thanks,
> > > > >
> > > >
> > > > Ooooh right this is the other problem, overlapping extents.  This is
> > > > going to be trickier to work out, I'll start writing it up, but I want
> > > > to make it automatic as well, so probably won't have anything until
> > > > the morning.  Thanks,
> > >
> > > Thanks for the heads up
> >
> > Ok I've pushed some code, but I'm sitting in a dealership so testing
> > was light.  I've added a 10 second pause before doing deletions from
> > the new code to give you time to spot check if the numbers look
> > insane.  It'll only do that 5 times, so if everything looks good it'll
> > just yolo delete stuff as it goes after 5 pauses.  Let me know if you
> > have trouble, thanks,
>
> Thanks.
> It worked for a while, and then failed in a new way?
>
> inserting block group 15837217947648
> inserting block group 15838291689472
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> searching 4 for bad extents
> processed 1032192 of 1064960 possible bytes, 96%
> searching 5 for bad extents
> processed 16384 of 10977280 possible bytes, 0%
> Found an overlapping extent orig [123032674304 123032702976] current [123032702976 123032731648]
> I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't

Ugh shit, I had an off by one error, that's not great.  I've fixed
that up and adjusted the debugging, lets see how that goes.  Thanks,

Josef
