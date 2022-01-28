Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E827F4A0006
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 19:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbiA1SXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 13:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbiA1SXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 13:23:47 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26FDC061714
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 10:23:46 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id x3so6162039ilm.3
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnSBHK/79npIMIohc8k8vI2H62WD1VUXtJ8hNGW2jns=;
        b=Qk4tHDm9bgvgt53WQUV1ivh/tFn3PYXvF7dBfbC3kk38HnmJHnNHXX4ewWLCTbLykH
         5cgNSmPVDrLJyFGRlY41+tkaHK8Zxebuk56dw+MlZewr1ZRqe7FSQgsV6wL3v0fEjjk5
         wMyHeQ4h1ADhJuAoOo2CREjo9q+MIAz2nM3+NKdPBhSc47qgCcV4PbeJi3cmu0gcENPD
         QcdnDpJB5cTN6+QAXiMbboD5a33/ItFTHQOxaG1QCso0sYYdsyNIG+4nUWlubUPZiQkO
         ZwBEAYeIRqFTCHkgs3mFndTOM2al1ITjeqqts1z7JD0tKVcESuAQFWmIE2MctmhXIwIs
         JW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnSBHK/79npIMIohc8k8vI2H62WD1VUXtJ8hNGW2jns=;
        b=TS1cOjJNiTu+XMtri92PzkxFufw8Dt5MjWZFBg7ckfP5IFBT/FCNOfGo4mWEmSmNtK
         AZ5O8inRDtvU9kszGTuRINe1PoN0VvgAPFbDZom89vy27Z+8LDwStIAK0aVkJ6P4Ho1r
         MKuEPAsEjXoXjw6gTsBa/ks8k+5KAQWr3xBDYexD+h0jndMt14dIrea/gIJt4o53HR0B
         LWdxBAAtgY53iiyz1IEJS3U5OTi47QlN4stC74y0jYdXmxvVJsszGOS+dm/PhgBp3fs2
         uNPYIaG1jtK0hmz0RWb6dqzAvMVPLjNANVl2sjtRnFK5tPTEedsvpOSto8YZ5oVnupiE
         bK0A==
X-Gm-Message-State: AOAM530ZMs7lqZ5Q6IwavnK2UITSomcbzDVI83EcQjT56pJZf6tiVnT6
        LUDErMaNverySWybWtEX6sdx3h9xfuE55CTtvw/HdAAe
X-Google-Smtp-Source: ABdhPJyA3gIR2Y+NyMp02ktDyrxM+NaWRGV+r7OliIECARVIvL2OMKBBawyFvTvzhMict+I65vi43bPf+YLqiu/VwFs=
X-Received: by 2002:a05:6e02:1a8d:: with SMTP id k13mr7196609ilv.0.1643394226006;
 Fri, 28 Jan 2022 10:23:46 -0800 (PST)
MIME-Version: 1.0
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com> <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
 <5e8303e3-64bf-f19a-6d42-e18ae62fd721@georgianit.com> <CAMthOuOnYUn_szauqRbx2yy_U+2Zrs5WUWmwKHLC5k3x13qKpA@mail.gmail.com>
 <a7e60083-7bbb-bc75-2916-7396e223463b@georgianit.com>
In-Reply-To: <a7e60083-7bbb-bc75-2916-7396e223463b@georgianit.com>
From:   Kai Krakow <hurikhan77+btrfs@gmail.com>
Date:   Fri, 28 Jan 2022 19:23:20 +0100
Message-ID: <CAMthOuPa5nmao1cvKf62CXOF5GZvGC84p650S947-YqaRe6i5Q@mail.gmail.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Fr., 28. Jan. 2022 um 19:09 Uhr schrieb Remi Gauvin <remi@georgianit.com>:
>
> On 2022-01-28 1:01 p.m., Kai Krakow wrote:
>
> >
> > Yeah, it's not better than traditional RAID but it's probably also not
> > worse.
>
> Oh, it's worse, it's much much worse.  Any time there is an interruption
> (power failure, or system crash) while a nocow file is being written,
> the two copies in Raid will be different.... *Which* copy is read at any
> given time can be a crap shot....

How is this different from mdraid or hardware raid then? These also
don't know the correct copy after partial or incomplete writes - and
return arbitrary data based on which mirror is chosen.


> Imagine if different database processes see a completed and a non
> completed transaction at the same time?

I never assumed something else. But database transactions should still
protect against this case: Either the transaction checksum matches -
or it doesn't. And any previous data should have been flushed properly
and verified already even before that last transaction becomes
current. A process won't see a completed and non-completed transaction
at the same time because it reads the data once, it cannot be
Schroedingers data.


> And there's no way to fix it other than full balance, (or copy re-write
> the file).. Even manaully running a scrub will not synchronize the mirrors.

How should it do it? Scrub doesn't know which one is the correct
mirror in that case. But that's not different from traditional RAID,
just that those will synchronize by overwriting what it thinks is the
older/out-of-sync mirror - which may not always be correct. We had
those cases many years back - both mdraid and hardware RAID.

The only difference here is that btrfs cannot actually buffer a write
to replay it after recovering from a crash - so there's a write hole
which proper hardware RAID may not have.
