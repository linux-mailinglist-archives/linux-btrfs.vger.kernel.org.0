Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609A540BC69
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 01:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhIOAA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 20:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhIOAA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 20:00:29 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD3C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 16:59:11 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id v9so547249uak.1
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bc6hLVcvXP5hcxkvLUGbyOZHIKEb2fo24lWaWoURps=;
        b=bzGug+08c3PcJWkfZgLL7mqNBvgfe0XPa4T19y7tIBVvyfeQuOANqMUBHHlu/T39Uz
         SUk+F7AO4cgwag8y5U8F9ANoe3RCwF8NO9Ryvvp5VKvKP+k6PGzMQlm5Vj+11Gj9cnEQ
         OCcEIaN+pnS7HCqYsMmFcaju413qckskHZm7eCuc1f3RXmmUEZN1n7Q60EfimVynSlNV
         ytrxcqycdWFbqKek74hpiq96F5VouT7zeDVxAmflpOqKPm7B+iBfbUDLfzSvfgNyiTy5
         WnrSqUU5fm7AORi2xnMMMyerEtYGMFwDOsSP3JG0w5vq+QC8l4Rj7qJdA5AJkX8Az530
         gh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bc6hLVcvXP5hcxkvLUGbyOZHIKEb2fo24lWaWoURps=;
        b=KLOIPRwOGqaSQEVQ63KYxBVPLwYG6e5KgsuUh9Km9p9W2+OYZEzF6S55ncMv8VIFpM
         UZzHJXJHe3M/7k/clubjSuQFKptWhTVavsKwaAa8zXj3E6d51DcMIamQckNXbv0djIfs
         Xat/3Ii4mGkOPdezEebNi+seuoCQR4QgWGPc+yjD6fodE5pCLiVut//FUHt126YNk8r5
         hFc6wdm9AB2gGd59NavYul0IumWN4rX6LpDhty9muVtronUAASqINfAce8xkLtFTVtQi
         CL8vkAolyH3UKz9JQ+nyAzyIxSKFaamzYV66zEhUzxVSW2/SQn8XmEv0nvcybyvkzwrV
         GMZA==
X-Gm-Message-State: AOAM5339GYw+zansvo/P0oFsSo8LROXk780967qFGJ1LTJvW/w/OTShN
        ZnMCyrlxWoVaTTg5nVAuNaMRlWn2BYJvq370L8qdOTnH8WQ=
X-Google-Smtp-Source: ABdhPJyPk8vpRM37qdjEr00fKIdREVhgXIW7VG6HMWLUgDpJR26wvDWFsv/inGjr77jeMxLamlY38zpxvEoNK5l/0t8=
X-Received: by 2002:a9f:2315:: with SMTP id 21mr6652791uae.143.1631663950108;
 Tue, 14 Sep 2021 16:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
 <aed0ec2b-3fe0-3574-b7e5-24f2e3da27ce@gmx.com> <CAH5Ym4gd7UhT=cSAjb-zMQ3baU08+SzKnGmXmAVD_8FdhzqF9w@mail.gmail.com>
 <20210911042414.GJ29026@hungrycats.org> <CAH5Ym4jNgs1iJufbmCDOS6N=k+YH4nZTSQ7j-MrM3mp8M0Yn2g@mail.gmail.com>
 <20210911165634.GK29026@hungrycats.org> <CAH5Ym4isja5hs73ibcACH5cm00=F43cG+m_sNtFjkJ_oRZJT1g@mail.gmail.com>
 <20210912230719.GL29026@hungrycats.org>
In-Reply-To: <20210912230719.GL29026@hungrycats.org>
From:   Sam Edwards <cfsworks@gmail.com>
Date:   Tue, 14 Sep 2021 17:58:58 -0600
Message-ID: <CAH5Ym4jUf9jz1OOSn=QuAqMe936ub+Rde=RhTQGRJKx4VA2XPA@mail.gmail.com>
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 12, 2021 at 5:07 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> There is less than 256MB distance from the first to the last, but they
> occupy two separate 256MB-aligned regions (f800000000 and f810000000).
> If there is dup metadata then these blocks occupy four separate 256MB
> regions, as there is some space between duplicate regions (in logical
> address space).

Okay, I see. You were looking at alignment, not range. I didn't think
you were trying to determine LBA alignment because you were working
from offsets within the LUKS space, without the benefit of the
LUKS+partition offsets. (Adding in those offsets doesn't change the
alignment situation much, by the way.)

Oh, for what it's worth: I don't think there was dup metadata. I
didn't pass any flags to mkfs.btrfs when I built the filesystem (so it
should have used the SSD default of single), and when I was (manually,
scanning the LUKS volume) looking for duplicate metadata blocks to
test my misdirected writes guess, I didn't find any two blocks with
the same bytenr. I still have the filesystem image in case there's any
doubt. But it also may not be pertinent at this point.

> 256MB is far too large for a plausible erase block size, 1GB is even
> less likely.

Agreed - orders of magnitude too large, if you ask me. But I'm also
not discounting the possibility that the erase block size is big
enough to cover 256MiB worth of (SSD, not btrfs) metadata.

> That's not how write caches work--they are not giant FIFO queues.

Oh no, I think I didn't make myself clear. I wasn't suggesting
anything to do with the order of the write operations, nor trying to
indicate that I was confused about what I was seeing.

I feel bad now; you provided a good explanation of this stuff, and I
appreciate the time taken to type all of that out, but I also didn't
benefit from the explanation as I'm nowhere near as green to memory
consistency as I am to btrfs internals. (Maybe someone reading this
email thread in the future will find this info useful?)

Hopefully I can rephrase what I was saying more clearly:
During the incident, there was some x% chance of writes not taking
effect. (And since there are a few metadata checksum errors indicating
torn writes, I think I can safely say that x<100. Probably by a wide
margin, given there are only 9000 unique error items, which is much
less than your expectation of 60K.)
The part that first caught my eye was that, for writes *not* to chunk
1065173909504, x=0. i.e. the probability of loss was conditional on
LBA. Note that I am only using the chunk as a spatial grouping, not
saying that the chunk itself is to blame.
What then made me find this interesting (a better word is, perhaps,
"distinctive"), was that the pattern of writes lost during
transactions 66552, 66591, 66655, and 66684 all followed these very
same statistics.

That eliminates a whole class of bugs (because certain cache
replacement policies and/or data structures cannot follow this
pattern, so if the SSD uses one of those for its write cache, it means
the culprit can't be the write cache) while making others more likely
(e.g. if the SSD is not respecting flush and the write cache is
keeping pages in a hash table bucketed by the first N bits of LBA,
then this could easily be a failure of the write cache's hash table).

And if nothing else, it gives us a way to recognize this particular
problem, in case someone else shows up with similar errors.

> That often happens to drives as they fail.  Firmware reboots due to a
> bug in error handling code or hardware fault, and doesn't remember what
> was in its write cache.
>
> Also if there is a transport failure and the host resets the bus, the
> drive firmware might have its write cache forcibly erased before being
> able to write it.  The spec says that doesn't happen, but some vendors
> are demonstrably unable to follow spec.

If the problem is in the command queue block, then the writes are
being lost before the write cache is even involved.

> That's an SSD-specific restatement of #1 (failure to persist data before
> reporting successfully completed write to the host, and returning previous
> versions of data on later reads of the same address).

But then here the writes are being lost *after* the write cache is
involved. In case #1, I could just opt out of the write cache to get
my SSD working reliably again, but I can't opt out of LBA remapping
since it's required for the longevity of the drive.

> SSDs don't necessarily erase old blocks immediately--a large, empty or
> frequently discarded SSD might not erase old blocks for months.

The blocks weren't erased even after a few days of analysis. But case
#3 is really unlikely either way, because LBA mapper bugs should take
a *bunch* of stuff down with them.

> All of the above fit into the general category of "drive drops some
> writes, out of order, when some triggering failure occurs."

Yep -- although I would include the nearby LBAs condition in the
symptoms list. That's statistically significant, especially for SSD!
:)

> If you have
> access to the drive's firmware on github, you could check out the code,
> determine which bug is occurring, and send a pull request with the fix.
> If you don't, usually the practical solution is to choose a different
> drive vendor, unless you're ordering enough units to cause drive
> manufacturer shareholders to panic when you stop.

Oh man, there's sometimes drive firmware on GitHub?! I would be
pleasantly surprised to find my SSD's firmware there. Alas, a cursory
search suggests it isn't.

I didn't choose the drive; it's a whitelabel OEM unit. If I can't get
in touch with the vendor "officially" (which I probably can't), I'll
try getting the attention of the employee/contractor responsible for
maintaining the firmware. I've had moderate success with that in the
past. That's a large part of my motivation for nailing down exactly
*what* in the SSD is misbehaving (if indeed the SSD is misbehaving),
to maximize my chances that such a bug report is deemed "worth their
time." :)

> Yeah, if something horrible happened in the Linux 5.14 baremetal NVME
> hardware drivers or PCIe subsystem in general, then it could produce
> symptoms like these.  It wouldn't be the first time a regression in
> other parts of Linux was detected by a flood of btrfs errors.
>
> Device resets might trigger write cache losses and then all the above
> "firmware" symptoms (but the firmware is not at fault, it is getting
> disrupted by the host) (unless you are a stickler for the letter of the
> spec that says write cache must be immune to host action).

On the other hand, a problem that surfaces only with a new version of
Linux isn't _necessarily_ a regression in Linux. My working hypothesis
currently is that there's a corner-case in the SSD firmware, where
certain (perfectly cromulent) sequences of NVMe commands would trigger
this bug, and the reason it has never been detected in testing is that
the first NVMe driver in the world to hit the corner-case is the
version shipped in Linux 5.14, after the SSD was released. That'd be a
nice outcome since Linux can spare other users a similar fate with the
addition of a device quirk that avoids the corner-case.

But I haven't ruled out what you've said about a full-blown Linux
regression, or even just a problem that happens every few weeks (due
to some internal counter in the SSD overflowing, perhaps -- the
problem did manifest awfully soon after the 2^16th transaction, after
all). All possibilities remain open. :)

> Linux 5.14 btrfs on VMs seems OK.  I run tests continuously on new Linux
> kernels to detect btrfs and lvm regressions early, and nothing like this
> has happened on my humble fleet.  My test coverage is limited--it
> won't detect a baremetal NVME transport issue, as that's handled by the
> host kernel not the VM guest.

I wonder if there'd be some value in setting up PCIe passthrough
straight into the VM for some/all of your NVMe devices? Does your VM
host have an IOMMU to allow that? Any interest in me donating to you
my SSD (which is M.2) if I decide to replace it?

> Sound methodology.
> > Wish me luck,
> Good luck!

Thank you! And: start the clock. I've erased+rebuilt the filesystem
today and am continuing to use it as I was before. I'll be making a
second attempt at installing those package updates later as well.

If there are any other questions, I'll happily answer. Otherwise I
won't be following up unless/until I encounter more instances of this
bug. So, to anyone reading this list archive well in the future: if
this is the last message from me, it means the problem was one-off.
Sorry.

Signing off,
Sam
