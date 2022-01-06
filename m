Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C2F486AC9
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 21:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbiAFUCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 15:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiAFUCc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 15:02:32 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C254FC061245
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 12:02:31 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j83so10737134ybg.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jan 2022 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZvrXIIPHwUBPyq37qmVy81JgcesCt6EROsKJdXvwIc=;
        b=TS2P69E9uK5t7/trX+0WeI6kYDuMKMRDXtMGeBuVUruKb+OHOybx618RRHIgPCINXG
         XbLrThEscul17M5p82l23lXBi0q2w10HPUBV1q6YxjVS7GlV4q1HToBp+Wz9sQCUajCu
         ZhcA3utloruiOaXuF/ScKcuyHb312CaCCBXR5Nk3ucHHAq9N0ej9pNzFMbT6CDSE30+c
         lmAQaxviD+iiWbBVssyRpiUGqYlT3Z8m+v66mAIVLi6k/eLfXBgSIuRTumhqPJiFO2vi
         BijKtT65LuD59LaO5kS0B1IrNWhK0XwIhlcD0+gWnlqT9gzTbzo/BhaE5i3qGXONFdsW
         NITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZvrXIIPHwUBPyq37qmVy81JgcesCt6EROsKJdXvwIc=;
        b=iGAohcUXYJYd+5Dc+Y93bZ2eyI7NQeue8scohaypnu0SvB9wXqawbu9NV52YKHfFeD
         mjyH81vFDnvesaenZuMBgOQmK44WoviBhsdOyBZoUQugyF1gcxgYfckMxhps0OK11Qpm
         FR1y4vzgVnJLvJPq8l+eo6g9jEIPvCVCFY0Cw+dRCYoTyh5V09mu9tXlplvnw3cdlF67
         C4BSTGsoxReJ1a2pj/1t07vZaDpcESJui7Z5c2YsbPK/XdTRzQsIqEO8pttAiNQT0fNQ
         opvTVRtySkRcPz6n/I0wAgGsU11RMBFjMef0GQQUzaeCagZ4naBN+fBDF7hy6HjqBuLl
         KheA==
X-Gm-Message-State: AOAM532v6uRA9FZXlgIwthsnmXK+fFuN4TITC779MErzChD0Pr8JvVEs
        ipUyNJmSmzLOJt0FQJzslKgt7eXKGzlGo49/Ba5pSg==
X-Google-Smtp-Source: ABdhPJyDSfSb4juFZgUtwlMeD7Oa9QVGkWx+H5sgljFI2o7t2nMMQE9uVM7u6E7906a4Kh5HLpIdqQAU3GlFFpKlJ50=
X-Received: by 2002:a25:e705:: with SMTP id e5mr28312953ybh.618.1641499351029;
 Thu, 06 Jan 2022 12:02:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home> <20220105183407.GD14058@savella.carfax.org.uk>
 <CAL3q7H4ofLVoGA3YC6M8gdBuW9g2W-C644gXgr9Z+r4MZBJZGA@mail.gmail.com>
 <20220105213157.GE14058@savella.carfax.org.uk> <20220105213921.GF14058@savella.carfax.org.uk>
 <20220105215359.GG14058@savella.carfax.org.uk> <CAL3q7H538dogW0-5PR1+J7FCKNJX6vY2_7tEpazskCmL4dmxKA@mail.gmail.com>
 <20220106102056.GH14058@savella.carfax.org.uk> <CAL3q7H4d9t=gBXYB=OVnPDuEMdo1-jmJweJTEshvc=9AGDeaVQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4d9t=gBXYB=OVnPDuEMdo1-jmJweJTEshvc=9AGDeaVQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 6 Jan 2022 13:02:15 -0700
Message-ID: <CAJCQCtTKkhQ+7=NK_KYktvuRxL+3yYMxma9WjB5eAbc5upWGaQ@mail.gmail.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from suspend
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 6, 2022 at 3:28 AM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Thu, Jan 6, 2022 at 10:21 AM Hugo Mills <hugo@carfax.org.uk> wrote:
> >
> > > Yep, that's correct Hugo.
> > >
> > > Starting with 3.17, the example on the wiki needs an fsync on
> > > "file.tmp" after writing to it and before renaming it over "file".
> > > I.e. the full example should be:
> > >
> > > ****
> > > echo "oldcontent" > file
> > >
> > > # make sure oldcontent is on disk
> > > sync
> > >
> > > echo "newcontent" > file.tmp
> > > fsync file.tmp
> > > mv -f file.tmp file
> > >
> > > # *crash*
> > >
> > > Will give either
> > >
> > > file contains "newcontent"; file.tmp does not exist
> > > file contains "oldcontent"; file.tmp may contain "newcontent", be
> > > zero-length or not exists at all.
> > > ****
> >
> >    Since I can't find an "fsync" command line tool, I've rewritten the
> > example in more general terms, rather than tying it to a specific
> > implementation (such as a sequence of shell commands). I note that
> > we've got a near-duplicate entry in the FAQ, two items down ("What are
> > the crash guarantees of rename?"), that should probably be removed.
> >
> > Updated entry: https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_overwrite-by-rename.3F
> > Candidate for deletion: https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_rename.3F
>
> There's the xfs_io command from xfsprogs that can be used to trigger
> an fsync like this:  xfs_io -c fsync /path/to/file
> But it's probably not well known for non-developers.
>
> Anyway, as it is, it looks perfect to me, thanks!


I think it's OK to use pseudo-code. Folks will figure it out. So you
can just write it as fsync() and even if you're not using the exact
correct syntax it'll be understood.


-- 
Chris Murphy
