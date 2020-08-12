Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9EE24242D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 05:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHLDDx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 23:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgHLDDw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 23:03:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12C6C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 20:03:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so621213wrc.7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 20:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yF5fZ71aLiLpINtE0BWHYTVgSvt03t5lj94Vf1hBqtM=;
        b=NWIuAM0gbEMcHwtSPPdLlJrwq5Bld8DCg4k56DABlzthz4JSrFZR6YvyW9G5eYwrRi
         8cJBdkk7xUWBIz5fjzUXt/rrRFf/ZTpiC4Yl5CiKOJfi/4/BwSf3fXggVqRj0OcmlEIB
         pjf1nODNN90MY83XdAWf1D1W/GvbZ+aFUh87GbrsbhZLe/OtQayu99bqD+0V7/hushpa
         sHWvQEp9R8GgktZp2LboNZH5Htg0J7EYWcfNwa0ce78G3Z9yLLJuvd2T8un6oRRff2IQ
         KJxMWLcamwHn6tVPmnrGslH6AuvtOuNaH7l2IS8Ihvr7crsdoVNkth5ChHAQ/GePy+CI
         nt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yF5fZ71aLiLpINtE0BWHYTVgSvt03t5lj94Vf1hBqtM=;
        b=kmT2qOBf6MIksEctnviyq4MIvqltBcFcs0p8eGzvm0MqZ5JZ2LQKYsx7CEDJrineCp
         0mzasnQ8hIMIAjKmW1HUfqMsDD3i54kn7zxZ5b8idIMgzPJDiY0Gv3v22lLigAVA6xgY
         0DKTNbOVt6oCQwt/JWMgQpkD+PjqrnP+Fbw8hb7/P8ht/Yfn2jDVNZAHrRa6wyWN3Y4V
         VkJs3FO9QHeXfkNMc7hEXpgAI1oNZkYtkwEmDoROkPDV14IJ93krAk3NIlwZyzaGnC20
         2jLAv+/F9R9WJDnk7xC+BmOUDWyGdw6qcQ7auAZvTa+TRdXv4luaHo4M+aW6xD9SqZnD
         x+yA==
X-Gm-Message-State: AOAM5326YeG39PdLY+A9l8k291Itx1Iq/3SRsCgXcRKaMj1bpdjstKO0
        L3n/GmROwy6w0AOzN1hrcAWkTuolqmypa+SdWGNt5TUy
X-Google-Smtp-Source: ABdhPJwc51wPqpWiklem9hNlo9cCK9QaKl7TfWkElRRFt64hdb/Y0kjvWuM/xIrJXzZUuoqX/1wDfVfwLroQ8S7rznE=
X-Received: by 2002:adf:f806:: with SMTP id s6mr8638003wrp.252.1597201430139;
 Tue, 11 Aug 2020 20:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
 <CAJCQCtReHKtyjHL2SXZXeZ4TwdXf-Ag2KysSS0Oan5ZDMzm8OQ@mail.gmail.com>
 <dc0bea2ee916ce4d1a53fe59869b7b7d8868f617.camel@dallalba.com.ar>
 <CAJCQCtSdJVw5o2hJ3OyE6-nvM2xpx=nRHLVNSgf9ydD2O--vMQ@mail.gmail.com> <d46401cf4af5c6ebc7cc7ce584570bc901978151.camel@dallalba.com.ar>
In-Reply-To: <d46401cf4af5c6ebc7cc7ce584570bc901978151.camel@dallalba.com.ar>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 11 Aug 2020 21:03:21 -0600
Message-ID: <CAJCQCtQ0_iNjW-VL6d5Mqc50pEBR+vDC3Z=W+xyD2xTXY_akXg@mail.gmail.com>
Subject: Re: raid10 corruption while removing failing disk
To:     =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 11, 2020 at 2:40 PM Agust=C3=ADn Dall=CA=BCAlba
<agustin@dallalba.com.ar> wrote:
>
> On Tue, 2020-08-11 at 13:17 -0600, Chris Murphy wrote:
> > That drive should have '/sys/block/sda/device/timeout' at least 120.
> > Although I've seen folks on linux-raid@ suggest 180. I don't know what
> > the actual maximum time for "deep recovery" these drives could have.
>
> I'll do this. Is there any reason not to set _every_ drive to 180s?

Arguably the drive should figure out WTF it wants to do with a command
within a second. Giving it 7 seconds to fail is quite a while. The
very idea a drive could seriously need 180 seconds to read one g.d.
sector and keep iterating on it to recover? It seems curious. The
rationale for 30s is that a drive taking that long to decide is
probably a drive that needs a link reset, which is what the SCSI
driver does when the timeout is reached. And yet that's obviously
wrong for a large number of consumer HDDs that have these lengthy
recoveries, by design.

The ideal timeout would be the one recommended by the manufacturer for
each make/model, i.e. our drive worse case, will either return data or
an error in X seconds. And you'd set the command timer to that number
+ 1. And it'd be fine to make it different per drive, because any
delay longer than that just means unnecessary waiting.


>As
> far as I can tell it doesn't really hurt to have the timeout be very
> long when the drives do support SCT ERC and if I simply write an udev
> rule that matches all disks I won't have to remember to do this again
> in the future.

If the drive supports configurable SCT ERC, you want to use that. Set
it to 7-10 seconds (the units for SCT ERC are deciseconds), and leave
the SCSI command timer set to a 30s default. It may not be great for
your workload to have an transient delay up to 3 minutes, but that
shouldn't happen in the first place if the sector data signal is good,
the reads should not be slow, they shouldn't need deep recovery.

As I think about it, you might instead of using a filtered balance,
put a spare in this system. And use 'btrfs replace' to replace drives,
round robin style. That'll perform better than balance, and gets you
back to a "normal" state much faster. Plus if you ever have a drive
failure, you've got a drive ready as a persistent replacement.



> > As the signal in a sector weakens, the reads get slower. You can
> > freshen the signal simply by rewriting data. Btrfs doesn't ever do
> > overwrites, but you can use 'btrfs balance' for this task. Once a year
> > seems reasonable, or as you notice reads becoming slower. And use a
> > filtered balance to avoid doing it all at once.
>
> I suspect it's the head that's damaged, not the sectors. I forgot to
> set the idle3 timer on this drive, which is a power saving "feature" of
> WD greens, to something reasonable for years and in the meantime the
> head has parked 1.7 million times. Keeping this in mind it sounds to me
> like a bad idea to write to it.

I see. If you think it's bad for reads, you could optionally do

# echo 1 > /sys/block/sda/device/delete

That'll just make it vanish. And then you could do a 'btrfs device
remove missing'. This is ordinarily riskier because it effectively
makes the array degraded. The effect of 'device remove missing' is to
reconstruct the missing data from the remaining drives. If all the
other drives are healthy, this would be a faster way to shrink the
file system by device removal.


> It's 16 hours I can run overnight vs 1 - 2 weeks of copying 4 TB of
> non-essential data over the Internet at 100 Mbps. I think I'll make
> sure there's two copies of the important stuff somewhere and take the
> risk.

Yeah.

How many changes are happening with this file system? IF it's a ton
you probably want a locally writable file system. If it's not a ton,
you could leave this Btrfs read-only, and overlayfs some other file
system on top of it to accept the small number of changes.

> Is it worse to do the --repair while degraded?

Not sure about degraded repairs. In particular I don't know how much
testing it gets.

>I'm sure the failing
> drive will manage to ruin the day if leave it connected, as I said it
> sometimes decides to hang forever.

Yeah that's not a great sign.

--
Chris Murphy
