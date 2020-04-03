Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1804219DBDC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbgDCQkt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 12:40:49 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:42365 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgDCQks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 12:40:48 -0400
Received: by mail-ua1-f46.google.com with SMTP id m18so2951389uap.9
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Apr 2020 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SmlscXw7fPshbnF/2ivHD9L2MI+bbMtBtPSQDHVmWxs=;
        b=XNix54QoD5W+KUWMYwh/I2aOBSdDM4EQHJMWy6TDahaAZnjF4q9U0KQXIjm3HvciMx
         IJ6qvgZrHlzBYXfACZwEg2T9eNO6J02cTrrvguYAM9KaC2f/eTy6IqNBaVol/65m1l7S
         6hjDkOljktXlQ8idk+umUcSjt+eiQcRI08tQfKmqBPU8fCYfaLg7F86RJEBpoYFEu/bB
         XQsZHUnJhDyV6r0nBP5NwWKsrPz4IOIBKPd8//1+YC2geLLDHGx1a+EZRBCi7Uvge6hv
         QdtAbocgV1Y6VidvHDpQo/KytUsjEjVJKTDiTz1aAZ3fRLena9yGd/uZanQditT9WZ4L
         JdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SmlscXw7fPshbnF/2ivHD9L2MI+bbMtBtPSQDHVmWxs=;
        b=dHRh9Mr4/9Knz1qj4jr2pvceyKITjs2Dl90LYHkvX5DhKOLUc4+u6IpKxQoFOBrA7/
         yLcz1SO3tfKmOnl33S317z76Al3c/af2LvWburIY8/mZui9PcdsSOLh1nES6pwFmaJsI
         8S0/16jnPxsY6LzO1d8xyIwBEXZHxRwJLhoY6uG/y/3aaD/l0+sfdX/Y7LUVBT086fOU
         2VfUolv7AXfPVrlo2IadQug/PSRX3ZsrQCl48/kdfu6Z5nIIpZsQ+4KUnJ9wMdP5MnQf
         bLaW1FD5qYquzUuGCibnS4gAN4MkFsu5aGicY4inng+RvA62F6ZX6NXfgoH/zZh2OZYj
         gqBQ==
X-Gm-Message-State: AGi0PuZZMV7biuwLGeL/sOaby9qIbmn5Bdj3TSPM0Wj67Zx9QCb3g0B4
        Md1A8OkL3Dgbq3xiyq5XjIww845m7c7sxiNEMfs=
X-Google-Smtp-Source: APiQypI4CZ25U+k+hikOjj6fJvgON0Askux/Kx6BBNvb4C1x/akj20U4XoVrasUu6o0FJAa2PccO8dbZt72mgXwrXJQ=
X-Received: by 2002:ab0:e5:: with SMTP id 92mr7270494uaj.83.1585932047307;
 Fri, 03 Apr 2020 09:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com> <CAL3q7H5sBk0kmtSQ_nuDnh1jWVTPfmWHbw7+UhJZ=NLgW0a0MA@mail.gmail.com>
 <fdec5521-d2a1-1a51-cd42-10fa5d006c91@gmx.com> <CAL3q7H6FCA2gW-0LS1Zh9Dnq29KCY6JhFJwPrEm_Ohvc+6r79A@mail.gmail.com>
 <c683620d-b817-f406-3a8e-7abbfcad14a0@gmx.com> <CAL3q7H7GXpnaK-jPQybi3PfoMJtr7gJQ0tha9fYG-he0vrzdXw@mail.gmail.com>
 <fb1a7773-8166-6ed5-8a63-d3ec86e1a70c@gmx.com> <f77f715b-2220-b65d-d42a-7aae81f274f9@gmx.com>
In-Reply-To: <f77f715b-2220-b65d-d42a-7aae81f274f9@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 3 Apr 2020 16:40:35 +0000
Message-ID: <CAL3q7H7z4OCY8zx4Y6TyMif_vHvtFXu-D1VCpoMpt+zkZ_ceow@mail.gmail.com>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 3, 2020 at 1:16 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> OK, attempt number 2.
>
> Now this time, without zero writing.
>
> The workflow would look like: (raid5 example)
> - Partial stripe write triggered
>
> - Raid56 reads out all data stripe and parity stripe
>   So far, the same routine as my previous purposal.
>
> - Re-calculate parity and compare.
>   If matches, the full stripe is fine, continue partial stripe update
>   routine.
>
>   If not matches, block any further write on the full stripe, inform
>   upper layer to start a scrub on the logical range of the full stripe.
>   Wait for that scrub to finish, then continue partial stripe update.
>
>   ^^^ This part is the most complex part AFAIK.

Since scrub figures out which extents are allocated for a stripe and
then does the checksum verification (for both metadata and data), it
triggers the same recovery path (raid56_parity_recover()) as the
regular read path when the validation fails (and it includes
validating the fsid on metadata extents, chunk tree uuid, bytenr). So
scrub should work out fine.

My initial idea, was actually only for the case of making the
previously missing device available again and then mount the fs in
non-degraded mode.
Every time a partial write was attempted, if it detected a device with
a generation (taken from the superblock in the device when the fs is
mounted)
lower than the generation of the other devices, we know it's a device
that was previously missing, and so trigger the recovery through the
same
API that is used by the validation path (raid56_parity_recover()),
which just reads the stripes of the other devices and reconstructs the
one for the
bad (previously missing) device. We have a stripe cache that caches
stripes for a while, so it wouldn't be too bad all the time.

The problem was for the case where we never mounted in degraded mode,
the stripe just got corrupted somehow, figuring out which stripe/s
is/are bad is just not possible. So it wasn't a complete solution.

Doing as you suggest, is a much better approach than any suggested before.
Sometimes it will be less expensive, when the stripes are in the cache
due to some previous write, leaving only the parity calculation and
check to do.

Running the scrub for the full stripe's range might work indeed. On my
previous tests (a modified btrfs/125) running a full scrub right after
the mount and before doing anything else seems to fix the problem.

>
>
> For full stripe update, we just update without any verification.
>
> Despite the complex in the repair routine, another problem is when we do
> partial stripe update on untouched range.
>
> In that case, we will trigger a scrub for every new full stripe, and
> downgrade the performance heavily.
>
> Ideas on this crazy idea number 2?

It's a much less crazy idea.

It brings some complications however, if a partial write is triggered
through a transaction commit and we need to run the scrub on the full
stripe, we need to take special care to not deadlock, since the
transaction pauses scrub. Would need to deal with the case of an
already running scrub, but this would likely be easier but slow
(request to pause and unpause after the repair).

Thanks

>
> Thanks,
> Qu
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
