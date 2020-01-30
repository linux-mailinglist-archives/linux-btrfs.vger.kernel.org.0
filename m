Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEAA14E345
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 20:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgA3Tb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 14:31:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43836 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3Tb6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 14:31:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so5541370wre.10
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 11:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EFzD9BLrxrFuvCxzZGWbhAoCVwQ6hTl/6Sc+APIovHE=;
        b=HD3zL/9g9uvTBqGORM8k1z0SnXAMLUu/xKVYEZaIVucp2cwg6IiZo1PG8p4zbXQs+j
         u8j3lI5uYDDozvpeQPb/rmRcm+kXGhj9ExJXb4zBMIwATbvgKdzC1ZXWhLjTVs2lFqwM
         VVXDPwJdSJTFpZucQY5JDT8pcpe4EBFh5PeSQDF2MVxZnwQ+fGTzgem91eInTTuEkupL
         eWp1oLZrRz7q+v6q3Wd4byCHYO9yHKMNg/sGpLmy7ytnpC6OaqSgbQpjVF4b+KEgu8wY
         mDLlh8r540dXG6DqfiQW1HU/JbC2EsvnPgAappA3UHI/rp9BuKL/gAMqB6p0VEDcSHGe
         gnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EFzD9BLrxrFuvCxzZGWbhAoCVwQ6hTl/6Sc+APIovHE=;
        b=rC9U6LGehPCFLb4DNtYftLqgpjY28mpWC7Jn9L2X4V/WCvilIXo7o5YIaRW/jPoQ2e
         NJX42p+icd04w6MU5y5blgk3V/1MlbZM8zFy7rSFMbtNdeb5//dTZH8HHTxvOcJkarmd
         8XbvIlSfPHFEsM7JfZeB3fprXEHc4oT9rqW0kRsP6AbvukFx529OurCoE5baJNj1fGA6
         Huayl1ai4RbHRaIMgMkpmkoyRNo4jukXmw2X/6qxIvthbhvVmWVrBT7xwbBCRfyzZKs3
         jOqrajnPNHh6jGBGaAsWAnKJvSgYo4uBIZP63H8rksQ3UFPa14jWwH9jDwePlpuDkT2S
         0sBQ==
X-Gm-Message-State: APjAAAXMy2KMsmvX9av5C9TCOPkFIL06bLdiy6cLtY/fkt4Eg8DhMGtc
        iCUq679tOkFgMQnkZG0UJPGNvu1YzK5xquYz8byWsQ==
X-Google-Smtp-Source: APXvYqwXVjjh1O/MJn2g7+6LOb9iVlXuOer/zZZKDSoawR2hSxj7P2EbY74Zfp/O3VCzeywB2HzbLMcKbXd817HXLn4=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr7044134wrp.236.1580412716317;
 Thu, 30 Jan 2020 11:31:56 -0800 (PST)
MIME-Version: 1.0
References: <112911984.cFFYNXyRg4@merkaba> <0102016ff2e7e3ad-6b776470-32f1-4b3d-9063-d3c96921df89-000000@eu-west-1.amazonses.com>
 <2049829.BAvHWrS4Fr@merkaba> <CAJCQCtSVqMBONCuwea_9i6xBkzOHSkCSoEAaDi2aH+-CLnNwBg@mail.gmail.com>
 <20200130171950.GZ3929@twin.jikos.cz>
In-Reply-To: <20200130171950.GZ3929@twin.jikos.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Jan 2020 12:31:40 -0700
Message-ID: <CAJCQCtSwJHR2+jEXY=eK41xR7Z0=+Jf5xhsD03Qvoh92bAHO6g@mail.gmail.com>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     David Sterba <dsterba@suse.cz>,
        Chris Murphy <lists@colorremedies.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 10:20 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jan 29, 2020 at 03:55:06PM -0700, Chris Murphy wrote:
> > On Wed, Jan 29, 2020 at 2:20 PM Martin Steigerwald <martin@lichtvoll.de> wrote:
> > >
> > > So if its just a cosmetic issue then I can wait for the patch to land in
> > > linux-stable. Or does it still need testing?
> >
> > I'm not seeing it in linux-next. A reasonable short term work around
> > is mount option 'metadata_ratio=1' and that's what needs more testing,
> > because it seems decently likely mortal users will need an easy work
> > around until a fix gets backported to stable. And that's gonna be a
> > while, me thinks.
>
> We're looking into some fix that could be backported, as it affects a
> long-term kernel (5.4).
>
> The fix
> https://lore.kernel.org/linux-btrfs/20200115034128.32889-1-wqu@suse.com/
> IMHO works by accident and is not good even as a workaround, only papers
> over the problem in some cases. The size of metadata over-reservation
> (caused by a change in the logic that estimates the 'over-' part) adds
> up to the global block reserve (that's permanent and as last resort
> reserve for deletion).
>
> In other words "we're making this larger by number A, so let's subtract
> some number B". The fix is to use A.
>
> > Is that mount option sufficient? Or does it take a filtered balance?
> > What's the most minimal balance needed? I'm hoping -dlimit=1
> >
> > I can't figure out a way to trigger this though, otherwise I'd be
> > doing more testing.
>
> I haven't checked but I think the suggested workarounds affect statfs as
> a side effect. Also as the reservations are temporary, the numbers
> change again after a sync.

Yeah I'm being careful to qualify to mortal users that any workarounds
are temporary and uncertain. I'm not even certain what the pattern is,
people with new file systems have hit it. A full balance seems to fix
it, and then soon after the problem happens again. I don't do any
balancing these days, for over a year now, so I wonder if that's why
I'm not seeing it.

But yeah a small number of people are hitting it, but it also stops
any program that does a free space check (presumably using statfs).

A more reliable/universal work around in the meantime is still useful;
in particular if it doesn't require changing mount options, or only
requires it temporarily (e.g. not added  to /etc/fstab, where it can
be forgotten for the life of that system).


-- 
Chris Murphy
