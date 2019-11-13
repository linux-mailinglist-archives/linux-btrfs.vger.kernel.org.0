Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E49FB717
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 19:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKMSSD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 13:18:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39083 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKMSSC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 13:18:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so3114397wmi.4
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2019 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eiT23YW7h7nPvt4r1xqB1yxB/IEFhiYNh8XYlVKE+IE=;
        b=QSaVPl49SS9xYC8eaz26RFO1qXbTYaVFRlvaoy2NBOCOBpv0lVQOFG9z1NtFrPnqGG
         eT1+WagWCybCqifDnPYZcwzuw/G37Tkch/1doLJ5w8QkIbYOzL7ItJ6fL6Mt3BbNeuqq
         yOWuFt8fkpWFk31V2aar4mJbumOE6JuEbYicDmWBXC4mwh/FCzzrHPvriqERFrPGQLqk
         vYcnL/P63bQw8ShVqWc4xVuOXHM+iKx7d7gWrx66HW2x7UlAG/MKzZkbrJPU66/HzBfO
         Xy4C9wCsh/RQ/DJ9eVqCd1RaGX1DbdyI0OoaeRqhlm8PSTPrgNjDpHEMqaHh94QBL9sT
         i2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eiT23YW7h7nPvt4r1xqB1yxB/IEFhiYNh8XYlVKE+IE=;
        b=CCIL5U6hv3tpsuv1JYoPm7pLbRltKlR9V41qwc0o8VZVTEerHJBwQXVrCE7ami7csN
         gZbIUlOSSR1iqdY+Tmxng4KA6xQwFTawK8CaaeonTXJjY/oNJ4iRiccckypT+Ab0R4DL
         mRK8ezAZKiC4xE1l/kq+uF/JuBBSqvoNzV6ugFH/afZGAB1ck12zUVS0vpnOveCzYNEb
         c6e+vJhD+lE6Krdwjfzd9EzrCa6G4N2/0LbAidlJQwokzwO+ulpvyUP6zebAKz24QGyU
         nRz/vyPtWEwh0ZOSarqH50UMmaeqkdigCdGK86FOoyZbzCeji9frctqs0enUFxud5zfe
         rw2A==
X-Gm-Message-State: APjAAAUX1CZ0Ck8Ewh7v48Cpj9GZ9LWLmYd0bMNb7y4HvKSxkyK+T0Qw
        AIB21Y+knLRFpMyZ4SachOfxu5kQ5Hi2dcmrxTp99/RjgPkCtQ==
X-Google-Smtp-Source: APXvYqz1zUnIeC4SieE7smw2DZR8PAiNCeVGHBWlnfKP9l3Rf4XgFBS360r4bTlto87RYeSO7QpDJETDsHMZn78A2q8=
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr3901235wma.66.1573669080970;
 Wed, 13 Nov 2019 10:18:00 -0800 (PST)
MIME-Version: 1.0
References: <1591390.YpsIS3gr9g@blindfold> <20191108220927.GR22121@hungrycats.org>
 <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at> <20191108222557.GT22121@hungrycats.org>
 <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at> <20191108233933.GU22121@hungrycats.org>
 <1389491920.79042.1573293642654.JavaMail.zimbra@nod.at>
In-Reply-To: <1389491920.79042.1573293642654.JavaMail.zimbra@nod.at>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 Nov 2019 18:17:25 +0000
Message-ID: <CAJCQCtTeqxxO=xAw5ogLORoNCvx7E7n0NQ4uF725bYX6vab25Q@mail.gmail.com>
Subject: Re: Decoding "unable to fixup (regular)" errors
To:     Richard Weinberger <richard@nod.at>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 9, 2019 at 10:00 AM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
> > An: "richard" <richard@nod.at>
> > CC: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> > Gesendet: Samstag, 9. November 2019 00:39:33
> > Betreff: Re: Decoding "unable to fixup (regular)" errors
>
> > On Fri, Nov 08, 2019 at 11:31:22PM +0100, Richard Weinberger wrote:
> >> ----- Urspr=C3=BCngliche Mail -----
> >> > Von: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
> >> > An: "richard" <richard@nod.at>
> >> > CC: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> >> > Gesendet: Freitag, 8. November 2019 23:25:57
> >> > Betreff: Re: Decoding "unable to fixup (regular)" errors
> >>
> >> > On Fri, Nov 08, 2019 at 11:21:56PM +0100, Richard Weinberger wrote:
> >> >> ----- Urspr=C3=BCngliche Mail -----
> >> >> > btrfs found corrupted data on md1.  You appear to be using btrfs
> >> >> > -dsingle on a single mdadm raid1 device, so no recovery is possib=
le
> >> >> > ("unable to fixup").
> >> >> >
> >> >> >> The system has ECC memory with md1 being a RAID1 which passes al=
l health checks.
> >> >> >
> >> >> > mdadm doesn't have any way to repair data corruption--it can find
> >> >> > differences, but it cannot identify which version of the data is =
correct.
> >> >> > If one of your drives is corrupting data without reporting IO err=
ors,
> >> >> > mdadm will simply copy the corruption to the other drive.  If one
> >> >> > drive is failing by intermittently injecting corrupted bits into =
reads
> >> >> > (e.g. because of a failure in the RAM on the drive control board)=
,
> >> >> > this behavior may not show up in mdadm health checks.
> >> >>
> >> >> Well, this is not cheap hardware...
> >> >> Possible, but not very likely IMHO
> >> >
> >> > Even the disks?  We see RAM failures in disk drive embedded boards f=
rom
> >> > time to time.
> >>
> >> Yes. Enterprise-Storage RAID-Edition disks (sorry for the marketing bu=
zzwords).
> >
> > Can you share the model numbers and firmware revisions?  There are a
> > lot of enterprise RE disks.  Not all of them work.
>
> Yes, will answer in a second mail. I found two more systems with such
> errors.

The original kernel used 4.12, should be sane. I've got Btrfs file
systems older than that in continuous use and haven't ever run into
corruptions that I didn't myself inject on purpose. The single data
point provided that makes me suspicious of a bug somewhere, possibly
not even in Btrfs or the drive, is that you have multiple systems
exhibiting this problem. That they are enterprise drives doesn't
itself significantly increase the likelihood it's a Btrfs bug rather
than a hardware bug, just because I've seen too many hardware bugs.
And Zygo has seen a whole lot more than I have.

I think Zygo's point of trying to isolate the cause of the problem is
what's important here. Assuming it's a Btrfs bug that somehow no one
else is experiencing, is going to take a huge amount of resources to
discover. Whereas assuming it's hardware related, or otherwise related
to the storage stack arragement, is a lot easier to isolate and test
against - process of elimination is faster. And that's the goal. Find
out exactly what's causing the corruption, because yeah, if it's a
Btrfs bug, it's an oh sh*t moment because it can affect quite a lot of
other instances than just the enterprise drives you're using.


> I didn't claim that my setup is perfect. What strikes me a little is that
> the only possible explanation from your side are super corner cases like
> silent data corruption within an enterprise disk, followed by silent fail=
ure
> of my RAID1, etc..
>
> I fully agree that such things *can* happen but it is not the most likely
> kind of failure.
> All devices are being checked by SMART. Sure, SMART could also be lying t=
o me, but...

I don't think Zygo is saying it's definitely not a Btrfs bug. I think
he's saying there is a much easier way to isolate where this bug is
coming from, than to assume it's Btrfs and therefore start digging
through a hundreds of millions of lines of code to find it, when no
one else has a reproducer and no idea where to even start looking for
it.

And the long standing Btrfs developers from the very beginning can
tell you about their experiences with very high end hardware being
caught in the act of silent data corruption that Btrfs exposed. This
is the same sort of things the ZFS developers also discovered ages ago
and keep on encountering often enough that even now ext4 and XFS do
metadata checksumming because it's such a known issue.

--=20
Chris Murphy
