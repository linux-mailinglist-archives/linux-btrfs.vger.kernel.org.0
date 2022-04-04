Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6606C4F1C3B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376883AbiDDVZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379713AbiDDR4F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:56:05 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161F245BD
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:54:08 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g21so12197606iom.13
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5aXFOjsVwliGYhlBx1+QCDa1pQHtfy2+N5XXzrQtxMg=;
        b=cgXljmTb2YzfUu91m3Gr8Jbua/5PvNKZVVMOhdX7EaF2A8TRgLkobVuSiVuDL6rj9d
         ci/aH+Ivc4Zkzy3noXN/do9oIwgFVwDBUVhPvqDyp4DATpYnI7uoks26ju96mI6VS7bS
         TV6rzhnjo4kuovsQBiRUn5oOW4A0++bZYsaCVNcxBhNIC0KgKDdL4Rd7YTfyJDue50qY
         KCBLPW132ckjV2v/HRuBBoem1cZ3jFeBo0i1eGMG9gWEak/zcGV5RdRwWgm2vC8dxAun
         oLWXR78KgjMzuEyA89mX63FsoAXxVoi3hx44VqErfLAdsqZ3RuQ4tNkY3TpNyY5t4KJa
         kOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5aXFOjsVwliGYhlBx1+QCDa1pQHtfy2+N5XXzrQtxMg=;
        b=xkTKl/gwY/4zMjPMkO5bNk9ZWKn42ixK29leQcu1CNhulbDt96jVIFCU4bcl0uhtiF
         F1nDXrDBPQi+AHzwoc7R1dwo/FoPXSQR89xU+pf1TcOYpdg6HNQijpeWD0lhptqea/EF
         Kl4p2pcEqgrSxZVi6slgdGrN+gD/0Segl3rU/c1AlbKG/v9UIAspu261nV6cS0oaxvzD
         IgaVWPk6jGt4iLMcR9eRpal7LCPTlZKIClZUgCRis+PN+fSQqPLaIDV7W98Bxqv0LdrI
         Cc7KSNspr+chMGTDY6E623PmPy080UaZxd1xSKmeSpgybgCFcNVBhMqpt7jhXJpsw4rk
         3LCQ==
X-Gm-Message-State: AOAM531Kci2W8FyNKUPriXBUNbvT+7GP1Qjcrm0QvJSma6EY5bNWRBAp
        sBuM253n6lyn8kAraHMLqG+Y0TUuKmHIo80Zq06IpT2uvTHv0A==
X-Google-Smtp-Source: ABdhPJz36HiK2Osvz2blIJ/DBa7pVg5dEWWa0d3aUN99s7eEpq04YlJM7vAjRVqK6GYCWfrS24Bnk+7gkidgv28PrBw=
X-Received: by 2002:a05:6602:2bc4:b0:645:eb96:6495 with SMTP id
 s4-20020a0566022bc400b00645eb966495mr666594iov.166.1649094847368; Mon, 04 Apr
 2022 10:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220329171818.GD1314726@merlins.org> <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
 <20220330143944.GE14158@merlins.org> <20220331171927.GL1314726@merlins.org>
 <Ykoux6Oczf6+hmGg@localhost.localdomain> <20220404010101.GQ1314726@merlins.org>
 <20220404150858.GS1314726@merlins.org> <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
 <20220404174357.GT1314726@merlins.org>
In-Reply-To: <20220404174357.GT1314726@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 13:53:56 -0400
Message-ID: <CAEzrpqc7P7pxkdSw8eS-nCkn1h5ztQC7C=MewJdmT6Mr5OJX-A@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 4, 2022 at 1:44 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 01:18:48PM -0400, Josef Bacik wrote:
> > On Mon, Apr 4, 2022 at 11:09 AM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, Apr 03, 2022 at 06:01:01PM -0700, Marc MERLIN wrote:
> > > > gargamel:~# btrfs rescue chunk-recover /dev/mapper/dshelf1a
> > > > Scanning: 1509736448 in dev0
> > > >
> > > > I'll let this run, looks like it might take a while.
> > >
> > > 14h later, still going on. I'll update when it's done, it may take a few
> > > days.
> > > gargamel:~# btrfs rescue chunk-recover /dev/mapper/dshelf1a
> > > Scanning: 7049296592896 in dev0
> > >
> > > Please let me know about the backup chunk roots that all seemed to be
> > > the same and were apparently all pointing to the same corrupted version?
> >
> > Ok cool apparently we have code that does this already, can you do
> >
> > btrfs-find-root -o 3 /dev/whatever
> > and then use the bytenr's it finds like you did with the backup roots
>
> gargamel:~# btrfs-find-root -o 3 /dev/mapper/dshelf1a
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> leaf parent key incorrect 13577821667328
> WARNING: could not setup extent tree, skipping it
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> leaf parent key incorrect 13577821667328
> Couldn't setup device tree
> Superblock thinks the generation is 1600938
> Superblock thinks the level is 1
> Found tree root at 21069824 gen 1600938 level 1
> Well block 21053440(gen: 1822 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
> Well block 21004288(gen: 1692 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
> Well block 20987904(gen: 1443 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
> Well block 20971520(gen: 1293 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
> Well block 21037056(gen: 1170 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
> Well block 21020672(gen: 773 level: 0) seems good, but generation/level doesn't match, want gen: 1600938 level: 1
>
> Not a good sign I assume?
>

Can you do

btrfs check --chunk-bytenr 21053440 /dev/whatever

also I can't seem to find output from a normal btrfs check run, can I
see that as well?  I'm curious if we could just tell the super block
the right transid for this and everything would be ok.  Thanks,

Josef
