Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5454066E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 07:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhIJFlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 01:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhIJFlC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 01:41:02 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51385C061574
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Sep 2021 22:39:52 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id o124so583883vsc.6
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Sep 2021 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=uqMhLqBMeTkDse2vwaUdXZUNRtkJHFaSBtc2C0jecaY=;
        b=V7zgliy0tx+ecBMtD8FT6caQ8a0Ny7Uh3TtO/JM8EchxNSBQ+C9Z4tZnvcaBC1Vkx4
         qRtBye3oFRX0vuXq3QUgK6U7SgqPWLxhJMmvBEblqU1gAsxw6ZdDB6TX28l0evreWAT1
         y7WbbDj9Rg4iQr6X5B7EaWIAGl2KjB04jewZInPbZDyTbCYj7HiPVYr64v3Y4qzB8YxV
         +c6ChwgokTkbeOmZs9XXP8w9Ffkl4MPYHhm8VNlL5wcKTz8EsjRmMjQKzqVTZFi7YyyH
         GQ3O1VcQXThSa+RizQeRJk73HYSBemvV3LfFL+a3aivUlhbm/AT9G+wlP3O62qHTpqH6
         bRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uqMhLqBMeTkDse2vwaUdXZUNRtkJHFaSBtc2C0jecaY=;
        b=jqP7PmP2Zy19UGyN6LtxeVeT5y8oUjWOW7Yir3sM3ht0WNkq1ObmJmUu3iWhS3Lpwe
         S9hgBwPUofKS2y+rYEkjCH5ogWB5e4H8nktRNJT3WQ9zBoJkZXjVIm+s+xtaFEfttTQH
         8v2OnVaZmdwNiSc7cFmif0aodn9mUicAi0EzrCZCInWD9MMlDY+op29fk1gwjqhaCrvW
         rI9Txamig3MtCObaKYSCDYX0zGGXD70nQxBv3bzYd2iMCKAQNctRRo9y6XfHdl6qGEa5
         wsgNhFywow7wmK7C1OUHOJmk8gMFXbyGcyc2t2lU6gliUJS74LLl/WC8Nebv9fk55AVr
         rG+A==
X-Gm-Message-State: AOAM530O0Cf2dwgHVzsHCVcFVBEcxPlzub0tIdEgJOd2VURc0vQd9Keo
        HgEWsipIfaXTn7umKtNqpnP2NgLTfpViBf6bKqPbrgeexe0=
X-Google-Smtp-Source: ABdhPJwlNpaNgkEZIVNfXkzbHEzolIKP8r1Q+02X+BgBfstQ3fYOX3etH+djDpy9D1NDKWG7hkrLLRf9b5ecmZ2/FNQ=
X-Received: by 2002:a05:6102:30a1:: with SMTP id y1mr3179702vsd.27.1631252391195;
 Thu, 09 Sep 2021 22:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
In-Reply-To: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
From:   Sam Edwards <cfsworks@gmail.com>
Date:   Thu, 9 Sep 2021 23:39:38 -0600
Message-ID: <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello again,

I've checked the hardware. The RAM tests out okay and SSD reads seem
consistent. I'd be very surprised if this was hardware failure,
though: the system isn't nearly old enough for degradation and I
haven't seen any of the tell-tale signs of defective hardware.

Also, if this was due to bit flips in the SSD, the dm-crypt layer
would amplify that across the 128-bit AES blocks (cipher mode is XTS).
I'm not seeing signs of that either.

I'm now pretty familiar with btrfs inspect-internal and have checked
the trees manually. Absolutely nothing looks corrupt, but several
leaf/node blocks are outdated. More interesting is the byte range of
blocks that were "rolled back": 1065332064256-1065565601792, by my
count. That fits pretty nicely in 256 MiB. This range is also not even
close to aligned on a 256 MiB boundary in LBA terms - even taking into
account luks and partition offsets. Thus this seems more like a
software cache that didn't get flushed rather than a SSD bug.

So, question: does the btrfs module use 256 MiB as a default size for
write-back cache pages anywhere? Or might this problem reside deeper
in the block storage system?

Also, for what it's worth: the last generation to be written before
these inconsistencies seems to be 66303. Files written as part of that
transaction have a birth date of Sep. 7. That's during the same boot
as the failure to read-only, which suggests that the cached buffer
wasn't merely "not saved before a previous shutdown" but rather
"discarded without being written back." Thoughts?

Cheers,
Sam


On Wed, Sep 8, 2021 at 6:47 PM Sam Edwards <cfsworks@gmail.com> wrote:
>
> Hello list,
>
> First, I should say that there's no urgency here on my part.
> Everything important is very well backed up, and even the
> "unimportant" files (various configs) seem readable. I imaged the
> partition without even attempting a repair. Normally, my inclination
> would be to shrug this off and recreate the filesystem.
>
> However, I'd like to help investigate the root cause, because:
> 1. This happened suspiciously soon (see my timeline in the link below)
> after upgrading to kernel 5.14.1, so may be a serious regression.
> 2. The filesystem was created less than 5 weeks ago, so the possible
> causes are relatively few.
> 3. My last successful btrfs scrub was just before upgrading to 5.14.1,
> hopefully narrowing possible root causes even more.
> 4. I have imaged the partition and am thus willing to attempt risky
> experimental repairs. (Mostly for the sake of reporting if they work.)
>
> Disk setup: NVMe SSD, GPT partition, dm-crypt, btrfs as root fs (no LVM)
> OS: Gentoo
> Earliest kernel ever used: 5.10.52-gentoo
> First kernel version used for "real" usage: 5.13.8
> Relevant information: See my Gist,
> https://gist.github.com/CFSworks/650280371fc266b2712d02aa2f4c24e8
> Misc. notes: I have run "fstrim /" on occasion, but don't have
> discards enabled automatically. I doubt TRIM is the culprit, but I
> can't rule it out.
>
> My primary hypothesis is that there's some write bug in Linux 5.14.1.
> I installed some package updates right before btrfs detected the
> problem, and most of the files in the `btrfs check` output look like
> they were created as part of those updates.
>
> My secondary hypothesis is that creating and/or using the swapfile
> caused some kind of silent corruption that didn't become a detectable
> issue until several further writes later.
>
> Let me know if there's anything else I should try/provide!
>
> Regards,
> Sam
