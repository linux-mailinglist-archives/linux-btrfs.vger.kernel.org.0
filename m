Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0E486266
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 10:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiAFJv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 04:51:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55430 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbiAFJv4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 04:51:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0658DB81FEA
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 09:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A45C36AE5
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 09:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641462713;
        bh=YVjEnLqiKibm3eho1N5St3ctyYzcKjS023BSL2Uf8vw=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=nDxWurQZgmXfv7Ns2EZaiu70odBit1ce1dAykT7vgLfBD5cJu/wA6ac2GzPUo8nvK
         gLQR1cd5voowhbRgUMZG9A0dbThXvXEpopM6JN/cDhv41woebuLfywyDF152SEhfSU
         OLrNJeDkbPRGmIFd3wWaGVVseDqJPSAMuWRvzBL2D7S73FdpfIeyGn22zV5L9MO+Hq
         uOs733V4bbC+C1ZpqXCNm2eMHC+nii1Iry5nRwZ2k18zJKsVP7d3xqDbCqo8fP0qd2
         Z/sDniN9fTAjQKhqXst2g7+6V2DlSJiW3BdkAd3jkJJzwqsJfh7e6Nrgugkla+8VLZ
         YgcWM32o/WThQ==
Received: by mail-qt1-f180.google.com with SMTP id p19so1727087qtw.12
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jan 2022 01:51:53 -0800 (PST)
X-Gm-Message-State: AOAM53225cJ7FdRF1Kl/os4GLfSPJ7d3McVXAn7ius9i9hll/iT04q2l
        ckTwf2OxtAaPhYWSadSxUm0WEdgSKqQW5ugRZLE=
X-Google-Smtp-Source: ABdhPJxpgQXhFrythgLmp+QnDL9UT7L/Z3EzAcgndNnOG8I6mb6MSdkJ9DbmLXIvj9XED72CDufDcUcaXp75xh/i570=
X-Received: by 2002:a05:622a:1a87:: with SMTP id s7mr47978373qtc.304.1641462712796;
 Thu, 06 Jan 2022 01:51:52 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home> <20220105183407.GD14058@savella.carfax.org.uk>
 <CAL3q7H4ofLVoGA3YC6M8gdBuW9g2W-C644gXgr9Z+r4MZBJZGA@mail.gmail.com>
 <20220105213157.GE14058@savella.carfax.org.uk> <20220105213921.GF14058@savella.carfax.org.uk>
 <20220105215359.GG14058@savella.carfax.org.uk>
In-Reply-To: <20220105215359.GG14058@savella.carfax.org.uk>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 6 Jan 2022 09:51:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H538dogW0-5PR1+J7FCKNJX6vY2_7tEpazskCmL4dmxKA@mail.gmail.com>
Message-ID: <CAL3q7H538dogW0-5PR1+J7FCKNJX6vY2_7tEpazskCmL4dmxKA@mail.gmail.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from suspend
To:     Hugo Mills <hugo@carfax.org.uk>,
        Filipe Manana <fdmanana@kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 5, 2022 at 9:54 PM Hugo Mills <hugo@carfax.org.uk> wrote:
>
> On Wed, Jan 05, 2022 at 09:39:21PM +0000, Hugo Mills wrote:
> > On Wed, Jan 05, 2022 at 09:31:57PM +0000, Hugo Mills wrote:
> > > On Wed, Jan 05, 2022 at 08:38:37PM +0000, Filipe Manana wrote:
> > > > On Wed, Jan 5, 2022 at 6:34 PM Hugo Mills <hugo@carfax.org.uk> wrote:
> > > > >
> > > > >    Hi, Filipe,
> > > > >
> > > > > On Wed, Jan 05, 2022 at 06:04:38PM +0000, Filipe Manana wrote:
> > > > > > I don't think I have a wiki account enabled, but I'll see if I get that
> > > > > > updated soon.
> > > > >
> > > > >    If you can't (or don't want to), feel free to put the text you want
> > > > > to replace it with here, and I'll update the wiki for you...
> > > >
> > > > Hi Hugo,
> > > >
> > > > That would be great.
> > > > I don't have a concrete text, but as you are a native english speaker,
> > > > a version from you would sound better :)
> > > >
> > > > Perhaps just mention that as of kernel 3.17 (and maybe point to that
> > > > commit too), the behaviour is no longer guaranteed, and we can end up
> > > > getting a file of 0 bytes.
> > >
> > >    I'd rather not reinforce the wrong usage with an example of it. :)
> > > Better to document the correct usage...
> > >
> > > > So an explicit fsync on the file is needed (just like ext4 and other
> > > > filesystems).
> > >
> > >    At what point in the process does the fsync need to be done?
> > > Before/after/instead of the sync?
> >
> >    Hmm. That doesn't make sense, of course (sorry, it's late, I've had
> > a hard day). I'm guessing that the fsync needs to go after the write
> > of the new data and before the rename. Is there any other constraint
> > on what needs to be done to make this work safely?
>
>    Right, I think I've got it. Ping me in the morning if it's not
> correct.

Yep, that's correct Hugo.

Starting with 3.17, the example on the wiki needs an fsync on
"file.tmp" after writing to it and before renaming it over "file".
I.e. the full example should be:

****
echo "oldcontent" > file

# make sure oldcontent is on disk
sync

echo "newcontent" > file.tmp
fsync file.tmp
mv -f file.tmp file

# *crash*

Will give either

file contains "newcontent"; file.tmp does not exist
file contains "oldcontent"; file.tmp may contain "newcontent", be
zero-length or not exists at all.
****

>
>    Hugo.
>
> --
> Hugo Mills             | Great films about cricket: Monster's No-Ball
> hugo@... carfax.org.uk |
> http://carfax.org.uk/  |
> PGP: E2AB1DE4          |
