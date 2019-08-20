Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB996BDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 00:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfHTWAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 18:00:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33726 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTWAK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 18:00:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so102333wrr.0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 15:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0cvTSx0wm0tKyEQxsqO7chUs14RIW6r0yQWtguJCas=;
        b=sqStZIxAoaq8bEzCDyD6+Z8nbq0YV3dpjzT1lCOPZrFdxPwZU8JFqAo1x9baKiOUkR
         77jkuqFVha2OKvOxzDY0JrAYqiMSLoUMcq+akXXm6/JDPtenAAS9eIgSX1MVncsEk//H
         08ktEM9x5e12FGbp83XQVXDAUpD9EH+NU07HcpABI3DAZcB47XSGL2jYLPZwMZ1jX8Ib
         9m+6tD6szFqZNG6qS7F8PVHrHO5dXFThzbU8o8qm/Y5kQVKlft1RxT7ivCK4QGLt1GxT
         9aGYVt9UeyrMdK+0gcSP4kk4sSbX7eeqgPAp6fYjQVAdpU4//52iNQtpPKY0ddglU0gs
         s9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0cvTSx0wm0tKyEQxsqO7chUs14RIW6r0yQWtguJCas=;
        b=ok7U67ChC9FR9ddYYaSF5+DCrjXdPgJVXW8fDM6cyDrIyMcV8rSK0SlFwn8GdXPNO7
         p3P8ufPjLlc/D8Km2cPoYhSwz6+1Jc3MiaD2yf4WCSNwRMQ0hDAS7DLAHTyGD/nFCDuV
         D+mhqyfbtovZNQb+AB1oXAMe971U9+N/O26JPlFXnlhumzMMPwb6d4Gv2m75f0JA6vXg
         w9VfavmU8Ce9vHsxHbR959LV1hSrmx9DGSO13Keko/Na+SdQxDGbnhV2jff4mRmMhHHx
         RSZA8S5CzRYI6kU9ujb4qoiwRiqCOxKRS717BwpKaaj5qfvnh0EcfCDho/bQdh3my/h5
         aHmw==
X-Gm-Message-State: APjAAAXQ0rGmaf5pwx8pAwKViEOGm5wujoELEKmFBVUq9xC3ayK5Svcn
        3GLw4uSHx/3ps2ykylt2u6CH1VS1rwY3CYfzVQFSaKSNyjk/mA==
X-Google-Smtp-Source: APXvYqwoy7aZPYeo7B7cIdGo73YyVjrnFqRsEpkphSwuvMdeRAt4iAMu0Lf7r7DOoBYkwTckYiT4CGY3ihkQe+Ex9Zs=
X-Received: by 2002:a5d:494d:: with SMTP id r13mr35380571wrs.82.1566338407585;
 Tue, 20 Aug 2019 15:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
In-Reply-To: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 20 Aug 2019 15:59:56 -0600
Message-ID: <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
To:     Peter Chant <pete@petezilla.co.uk>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 20, 2019 at 3:10 PM Peter Chant <pete@petezilla.co.uk> wrote:
>
> Chasing IO errors.  BTRFS: error (device dm-2) in
> btrfs_run_delayed_refs:2907: errno=-5 IO failure
>
>
> I've just had an odd one.
>
> Over the last few days I've noticed a file system blocking, if that is
> the correct term, and this morning go read only.  This resulted in a lot
> of checksum errors.

That doesn't sound good. Checksum errors where? A complete start to
finish dmesg is most useful in this case.


>
> Having spotted the file system go read only in the logs and then noted
> the error message in the subject shortly after booting I assumed a
> hardware error and changed the SATA cable.  That had no effect so I
> isolated the disk and mounted the respective file system degraded.
> Shortly after mounting the degraded file system I had the same error
> again. So I unmounted the file system edited fstab and swapped the disk
> which I though originally had the error with the one now showing an error.

OK but we don't know anything from what you've told us about what and
whose error, so it's all speculation. Definitely a complete dmesg is
needed.

Or if running systemd-journald to persistent media, you can look up
that boot with journalctl --list-boots, and export just the kernel
messages portion with something like this:

journalctl -b -2 -k -o -short-monotonic > journalbtrfshang.txt

That's two boots back, kernel messages only, monotonic time stamp.

Also useful if you experience blocked tasks, like a kind of system
hang for 2 minutes sort of thing, is a sysrq+t and the simple version
is, as root

# echo 1 > /proc/sys/kernel/sysrq
# echo w > /proc/sysrq-trigger
# echo t > /proc/sysrq-trigger

Detailed version here:
https://fedoraproject.org/wiki/QA/Sysrq

That will dump a bunch of task info into kernel messages, and will be
found in dmesg or the above journalctl command. It's useful to have
the echo 1 setup before you reproduce the problem; and even more
useful to use remote ssh to type out the 2nd command so all you have
to do is hit return upon reproducing the hang - otherwise it can take
a long time to type it all out.


> Does this sound like a hardware error?  I have ordered a replacement
> drive, if it is not needed as a replacement I will put it into a
> homebrew NAS.
>
> I've hit the issue again.  Hopefully the system is up long enough to
> post this.
>
> I'm a bit worried that trying to track this down disconnecting a disk at
> a time I might hit the btrfs split brain issue.

WDC Reds have SCT ERC of I think 70 deciseconds by default which you
can check with 'smartctl -l scterc' for each drive. If it's hardware
related it probably isn't bad block related, and at least if the drive
is aware of the problem it'll report it via libata and you'll see such
messages in kernel messages.


-- 
Chris Murphy
