Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E13C11D135
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 16:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfLLPk0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 10:40:26 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:37801 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbfLLPk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 10:40:26 -0500
Received: by mail-ua1-f49.google.com with SMTP id f9so1073802ual.4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 07:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ra9WAv46oCrtT1QUcpAu/k98trn782Iq+DT8UIrMvME=;
        b=JVyMhUaw9RLq5ZVSpG+xXyb+rBaX91/ivXvPlFYYImhMm5/rcqt6dc4AZWVBU/RMgB
         UiFdHVNs3l58vzcPDkHvxbU0JiuRo4fYoGQ1WNzEAih0ySLfMpr6ZFXX8ru5FqwwyXOc
         NVAqWeWQlYixWEe0bfM7oH+3A1wYXtzxyUi+B70OYxfoY6dc5+SK7KZmI2XD/5CefgcS
         GlaSZaKSlPLhmE9/uW9vt269aseUTFhNgbn/wenbdSb0AXmaY3w5CDIU9lw6V4wyr4TX
         3rcgtBAuA4Uws8SFkVW/FrgGg+o/A9RZXkJUD1QMBHWJCkKEEGW+PubbfZ0N/vbLQfxl
         b3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ra9WAv46oCrtT1QUcpAu/k98trn782Iq+DT8UIrMvME=;
        b=jlopeFQ8y698lpb6G59CvDnBunBiwxZmqz8YJqbTbod4szi8fl/YGdb+UTELyo/sYb
         VePT14HHv4XCjPwyDliRFJGgIWtN4XWc83ATJF7o/IhaL3o5LKW/ByKJb1+EizNxJh0w
         WSTWuQw7d0jivCuw/tjcrDk0//dqGrOjF5nsGh2Qj11eMHUY0cj+Na73Lnvg9vN+yXPk
         mW0kMgkPgTWKbVejN/jJBSXEZNSZrcVOr5GUXw6BdwZF/vODaJUOrvnOsXBGEEj60OJG
         A6wXaTY1u5QVSi7OE9rlRkhZDm+u2XnRNPTzJaMri6Zzny1M7DJd9p285W7Xosw67b/V
         8niw==
X-Gm-Message-State: APjAAAWcag4kpspFkXSuxk9LKUU2Mr54EaxiMKW7FzkNQmVO27vnqfdf
        n7+x/B2fhZc53g0S5owlz+pABOYuxttBjIq5OVEM7CGjUyU=
X-Google-Smtp-Source: APXvYqxUI28dnZUoNdPVvhRFz5f6aUKnm1w3vUX495G7PMErlm8vvCw0u/U7ZLXt+qjfQXSMz6vBYSH2LmxjNqg5SXo=
X-Received: by 2002:ab0:3415:: with SMTP id z21mr9020128uap.9.1576165224076;
 Thu, 12 Dec 2019 07:40:24 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
 <20191211160000.GB14837@angband.pl>
In-Reply-To: <20191211160000.GB14837@angband.pl>
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Thu, 12 Dec 2019 18:40:12 +0300
Message-ID: <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl succeeds?
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for those quick replies. It took a bit to build some pieces of
this reply though.

I realized that I had made a huge mistake by relying on a backup
strategy by syncing valuable data between two computers on two sites
while completely ignoring such a disk failure that may happen on both
sites at the same interval of "btrfs scrub" examination. This is what
happened at the moment. (We are talking about more than 6 months. This
is of course a big period. Obviously not monitoring the filesystem for
this much time is my fault, I accept that, and lessons learned:
https://github.com/ceremcem/monitor-btrfs-disk)

My first action was determining the corrupted files. I was wondering
if insisting CouchDB on BTRFS would eventually cause a failure or not,
so this corrupted files list might help shedding the light on the
cause: https://gist.github.com/ceremcem/b507be2669682857f37039eb9655d7ad

My second action is, as there is only a disk present at the moment, to
convert the Single data profile to DUP (which I couldn't, due to
"Input/output error"s) in order to be able to fix any further
corruption. I'll replace the disk by two new disks in the meanwhile
and setup a RAID-1 with them.

While searching for "converting to DUP profile", I noticed that the
man page of btrfs explicitly states:

> In any case, a device that starts to misbehave and repairs from the DUP c=
opy should be replaced! DUP is not backup.

Based on that, the uncorrectable errors (in Single profile) also means
that we should replace the misbehaving disk.

> Try 'smartctl -t long', then wait some minutes (it will give you an
> estimate of how many), then look at the detailed self-test log output fro=
m
> 'smartctl -x'.  The long self-test usually reads all sectors on the disk
> and will quantify errors (giving UNC sector counts and locations).

I tried this one, however I couldn't interpret the results. Here is
the `smartctl -a /dev/sda` output:
https://gist.github.com/1a741135af10f6bebcaf6175c04594df

> You need to look at the specific error counts individually, as they
> indicate different problems.  There are 5 kinds of uncorrectable
> error:

`btrfs scrub` isn't giving us those kinds of details, or is it? How
can we get such a detailed report?

Thank you all for those detailed answers.

Adam Borowski <kilobyte@angband.pl>, 11 Ara 2019 =C3=87ar, 19:00 tarihinde
=C5=9Funu yazd=C4=B1:

>
> On Wed, Dec 11, 2019 at 04:11:05PM +0300, Cerem Cem ASLAN wrote:
> > This is the second time after a year that the server's disk throws
> > "INPUT OUTPUT ERROR" and "btrfs scrub" finds some uncorrectable errors
> > along with some corrected errors. However, "smartctl -x" displays
> > "SMART overall-health self-assessment test result: PASSED".
> >
> > Should we interpret "btrfs scrub"'s "uncorrectable error count" as
> > "time to replace the disk" or are those unrelated events?
>
> "btrfs scrub" operates on a higher layer, and can detect more errors, som=
e
> of which may have a cause elsewhere.  For example, dodgy memory very ofte=
n
> corrupts data this way; you can retry the scrub to see if the corruption
> happened during write (so the data is lost) or during read (so retrying
> should work).  In that case, you may want to test and/or replace your
> memory, motherboard, processor, etc.
>
> Or, the disk's firmware may fail to detect errors.  It's supposed to veri=
fy
> disk's internal checksum but detecting errors is another place where a do=
dgy
> manufacturer can shave some costs -- either intentionally, or by neglecti=
ng
> testing.
>
> Or, some buggy software (which may even include btrfs itself, albeit
> unlikely) might scribble on wrong areas of the disk.
>
> Or...
>
>
> Anyway, all you know for sure that you have _some_ breakage, which a
> filesystem without data checksums would fail to detect, allowing silent d=
ata
> corruption.  Finding the cause is another story.
>
>
> Meow!
> --
> =E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80 A MAP07 (=
Dead Simple) raspberry tincture recipe: 0.5l 95% alcohol,
> =E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 1kg raspb=
erries, 0.4kg sugar; put into a big jar for 1 month.
> =E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 Filter ou=
t and throw away the fruits (can dump them into a cake,
> =E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80 etc), let=
 the drink age at least 3-6 months.
