Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080EC58299B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiG0P1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 11:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiG0P1C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 11:27:02 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359B043324
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 08:27:02 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ef5380669cso179173867b3.9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mQtRVqlsHskqipLJVKgL8giDFnRc54eVZvCYaGBKey0=;
        b=kwQyXBVrKzoV9IKjt6O7U+XSrBJBqp6y6oL9Cb2uneHZVksRglCF+0GjHdxkIccA62
         D3w+5YgI9M7CXAJGxJF1AjS7+6KRkJ72Ucfoqlkb2wEJB89cQxWKpqjIY6KX5oJkKQnQ
         g7Zb0v9nwdxcsUWB9LaJCOHJ4wqW9qGczzBWqZ3WFMleD22BTS1YC/iRVSy8DGUOA7yO
         2Xey0CNoEOOnU1415IX37VHOfQdQDjKJIKDjGoA2CiPOqLFXEhaqX7/6S9H3sFVpzjEV
         G1E893znmiDz4CvaqcIT9sZI14lOr8FOkj0fRU0YZNiFXAqrUw+4/GTEFEy0TsCymawB
         gPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mQtRVqlsHskqipLJVKgL8giDFnRc54eVZvCYaGBKey0=;
        b=rpf7OgSAqtfhlUUiZo32J/NK8kgVythlqiVsfPPnQU+UD96G60sg+v/tdsuFtprMKM
         kTZ4F57Z19XTFVXmWSsdEctohbUzf80v1tRaE+YnL+RURlpfrW4SpLRz0q6rmn+hMACT
         kvgqWfG37fA2YtJGMQRchFQsT70lC1sdbFDy9NRe8VSJ3G3TtZNv1LArHTcD9rog58sq
         0MBqMuGEEFRj5ImzBc/BS9zNc6axJof65hRpfolOog8cUSrskEHF/QrTFyOnQYmhBmKn
         2y2Dsil/e9XHW+H/r4VXb1sGf3AD1aAwehee0h8R3PP4BswiRdKTYRGEvkpnRmXP6gIl
         JJmA==
X-Gm-Message-State: AJIora+KqJGxIHFJDaQn7Nqtm4IHfY8W1+irQ9mWHYZVXbh4y+Q39C2v
        BF9zUSxHEKiIbw64CpAmtNlQwff9P5Uwqqb5tj0=
X-Google-Smtp-Source: AGRyM1seSitT3G6x6Ar0mYh33OE+D+/AJKHgnpJbaqBBXwb8v75yGLPh8HHnd4ESb3V+DLpW5ODSlsPsrwROV/5hiHI=
X-Received: by 2002:a81:78d:0:b0:2e5:d440:d921 with SMTP id
 135-20020a81078d000000b002e5d440d921mr19282450ywh.251.1658935621277; Wed, 27
 Jul 2022 08:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
 <20220725190811.GD13489@twin.jikos.cz> <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
 <20220726213628.GO13489@twin.jikos.cz> <fb723544-1c98-4275-a8f0-a250937675d6@www.fastmail.com>
 <68dc27f3-32a8-4a2a-bfcc-0cf26bca8fec@www.fastmail.com> <20220727145640.GS13489@suse.cz>
In-Reply-To: <20220727145640.GS13489@suse.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 27 Jul 2022 08:26:25 -0700
Message-ID: <CAEg-Je_jEt_ivC2o1CpUYdvDZHYgHpkuPEam9BPjt9OftVbkJg@mail.gmail.com>
Subject: Re: Using async discard by default with SSDs?
To:     dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 8:01 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jul 27, 2022 at 10:50:01AM -0400, Chris Murphy wrote:
> > On Tue, Jul 26, 2022, at 6:10 PM, Chris Murphy wrote:
> > > On Tue, Jul 26, 2022, at 5:36 PM, David Sterba wrote:
> > >> What is quickly here?
> > >
> > > Seconds, less than a minute, all the blocks pointed to by backup root=
s
> > > are empty (zeros).
> > >
> > >  The default timeout is set to 2 minutes and that's
> > >> what I've seen when testing that on a fresh filesystem.
> > >
> > > Ok I'll retest with 5.19 series. The last time I tested time to drive
> > > gc backup rootswas circa 5.8.
> >
> > With 5.19, backup roots remain available for a surprisingly long time,
> > definitely more than 2 minutes. It's not an exhaustive test, just a
> > dozen samples over a half hour, but I never once saw zeros returned.
> > Two out of those dozen, I saw the block already overwritten with a
> > leaf of a newer generation and a completely different owner (e.g. csum
> > tree written at the block address for the backup tree root)  - which
> > would make that backup root useless.
> >
> > What is a likely target kernel version to make discard=3Dasync the
> > default? The merge window for 5.20 closes August 14. Is 5.21 a
> > practical target?
>
> The changes for the next merge window are supposed to be done a week or
> two before it opens, but as this is a simple change I think I can
> squeeze it in.

It would definitely be nice to see this for 5.20. :)


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
