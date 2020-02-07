Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3A6156187
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2020 00:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBGXR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 18:17:27 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42259 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgBGXR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 18:17:26 -0500
Received: by mail-wr1-f50.google.com with SMTP id k11so768980wrd.9
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zk0vgayZUo0RYGtKd2kJ+yh+aCmWalqYMaYTh3gi9bw=;
        b=LQcKesPU0JsrWLbxgzYVauFyo3+gtkiCHI6IAuvUQso585kM6cb6ycVU/sUoEVqO9k
         atuNzqqHwmtvYbs80vbGAZkosT/kpb2DhIj4gNmeIdLoL34Pa1tmMFUw5T3nxAuXNxt/
         MpAnmmAiLsEmFZfA2D46BoWxad+pOgkO8Pblx1q5GgWsk2g5ehf6MlHFjBximrENo01+
         HqYIDZYJlnZ6BnvMpF/DNKvKLWNB5Cx21KwCw5KEd8kP+5jCIPRkiPfsGxfzT7TnApsZ
         1SnfrEsdpqJuIJbEwVser/BScR9PV4mety8oXfXbASip4Jf6vCMZfZQ+5D/d8m4f415a
         0uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zk0vgayZUo0RYGtKd2kJ+yh+aCmWalqYMaYTh3gi9bw=;
        b=U0iiyr+pPujEEq+pKG3L54j4/VJ8X3vMxPxN0B8fND+WaulfNH6mjjqPjb2uc/OJIC
         1w5iOHrSCGhSTGmB/9mDDZl9fO4sbn3wdKMtxRovgWajl1fAGWHgsrFOSoGDYpVzThs1
         9bjaSieXi5FauLaq6Pkc/0KodEOsxhQ+jH/o03JfdWB8y1tLeRd3Zh/+om8bv401V/5V
         FCA/RHiLbk6xDI9JntzdyLjf5/n+nqmzRXUlPitpQO4uRAGEWMJUGDIAQ/Di7m/og2Yx
         +qEAkVOaaTTtBldA/lL7W0yAAGLGHf0DWKndAhF/SG6sGb8veVLn+cvBYEgYbm/rYwEm
         7xVg==
X-Gm-Message-State: APjAAAWYEVuqAIB1/K5+EdYMQaiYBxrf3+b85dN4l5htRqullytjwbIF
        luP0/RK59BxrAWWD+oYDNvGVA76OYWJlZe0JOJsQaQ==
X-Google-Smtp-Source: APXvYqz8AiDt2xaKIbelTTDjCSFbb0wzPS2hePzo1q9/tklC/TdhTI8cGENAPKhNun/Epl43R6h7E2hPUt12eRqYMus=
X-Received: by 2002:a5d:4a48:: with SMTP id v8mr1337483wrs.42.1581117442894;
 Fri, 07 Feb 2020 15:17:22 -0800 (PST)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <CAJCQCtShJVH-mTQEQ--RHyJgMWw1R-YfeUQLp2rn3x+xOwJz+Q@mail.gmail.com> <CA+M2ft88F8XfF+Ob8mvdPvgKEQx=q8xwfgiCjL+ACM3XVuAhbA@mail.gmail.com>
In-Reply-To: <CA+M2ft88F8XfF+Ob8mvdPvgKEQx=q8xwfgiCjL+ACM3XVuAhbA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 7 Feb 2020 16:17:06 -0700
Message-ID: <CAJCQCtRFchojvVBCPc5BGtd_o8V9YKHfoxmZJExxKwirkZO=Jg@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 7, 2020 at 3:31 PM John Hendy <jw.hendy@gmail.com> wrote:
>
> On Fri, Feb 7, 2020 at 2:22 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Fri, Feb 7, 2020 at 10:52 AM John Hendy <jw.hendy@gmail.com> wrote:
> >
> > > As an update, I'm now running off of a different drive (ssd, not the
> > > nvme) and I got the error again! I'm now inclined to think this might
> > > not be hardware after all, but something related to my setup or a bug
> > > with chromium.
> >
> > Even if there's a Chromium bug, it should result in file system
> > corruption like what you're seeing.
>
> I'm assuming you meant "*shouldn't* result in file system corruption"?

Ha! Yes, of course.


> Indeed. Just reproduced it:
> - https://pastebin.com/UJ8gbgFE

[  126.656696] BTRFS info (device dm-0): turning on discard

I advise removing the discard mount option from /etc/fstab. This
obviates manual fstrim, and makes sure you can't correlate discards to
these problems.


> Aside: is there a preferred way for sharing these? The page I read
> about this list said text couldn't exceed 100kb, but my original
> appears to have bounced and the dmesg alone is >100kb... Just want to
> make sure pastebin is cool and am happy to use something
> better/preferred.

Everyone has their own convention. My preferred convention is to put
the entire dmesg up on google drive, unedited, and include the URL.
And then I extract excerpts I think are relevant and paste into the
email body. That way search engines can find relevant threads.

> Clarification, and apologies for the confusion:
> - the m2.sata in my original post was my primary drive and had an
> issue, then I wiped, mkfs.btrfs from scratch, reinstalled linux, etc.
> and it happened again.
>
> - the ssd I'm now running on was the former boot drive in my last
> computer which I was using as a backup drive for /mnt/vault pool but
> still had the old root fs. After the m2.sata failure, I started
> booting from it. It is not a new fs but >2yrs old.

Got it. Well it would be really bad luck but not impossible to have
two different drives with discard related firmware bugs. But the point
of going through the tedious work to prove this? Such devices will get
the relevant (mis)feature blacklisted in the kernel for that
make/model so that no one else experiences it.




>
> If you'd like, let's stick to troubleshooting the ssd for now.
>
> > [   60.697438] BTRFS error (device dm-0): parent transid verify failed
> > on 202711384064 wanted 68719924810 found 448074

448704 is reasonable for a 2 year old file system. I'm doubt 68719924810 is.


> $ lsattr /home/jwhendy/.config/chromium/Default/Cookies
> -------------------- /home/jwhendy/.config/chromium/Default/Cookies

No +C so these files should have csums.


> Yes, though I have turned that off for the SSD ever since I started
> booting from it. That said, I realized that discard is still in my
> fstab... is this a potential source of the transid/csum issues? I've
> now removed that and am about to reboot after I send this.

Maybe.


> I just updated today which put me at 5.5.2, but in theory yes. And as
> I went to check that I get an Input/Output error trying to check the
> pacman log! Here's the dmesg with those new errors included:
> - https://pastebin.com/QzYQ2RRg
>
> I'm still mounted rw, but my gosh... what the heck is happening. The
> output is for a different root/inode:

Understand that Btrfs is like a canary in the coal mine. It's *less*
tolerant of hardware problems than other file systems, because it
doesn't trust the hardware. Everything is checksummed. The instant
there's a problem, Btrfs will start complaining, and if it gets
confused it goes ro in order to stop spreading the corruption.


>
> $ sudo btrfs insp inod -v 273 /
> ioctl ret=0, bytes_left=4053, bytes_missing=0, cnt=1, missed=0
> //var/log/pacman.log
>
> Is the double // a concern for that file?

No it's just a convention.


> - ssd: Samsung 850 evo, 250G
> - m2.sata: nvme Samsung 960 evo, 250G

As a first step, stop using discard mount option. And delete all the
corrupt files by searching for other affected inodes. Once you're sure
they're all deleted, do a scrub and report back. If the scrub finds no
errors, then I suggest booting off install media and running 'btrfs
check --mode=lowmem' and reporting that output to the list also. Don't
use --repair even if there are reported problems.

A general rule is to change only one thing at a time when
troubleshooting. That way you have a much easier time finding the
source of the problem. I'm not sure how quickly this problem started
to happen, days or weeks? But you want to go for about that long,
unless the problem happens again, to prove whether any change solved
the problem. Ideally, you revert to the suspected setting that causes
the problem to try and prove it's the source, but that's tedious and
up to you. It's fine to just not ever use the discard mount option if
that's what's causing the problem.

I can't really estimate whether that could be defect in the SSD, or
firmware bug that's maybe fixed with a firmware update, or a Btrfs
regression bug. BTW, I think your laptop has a more recent firmware
update available. 01.31 Rev.A 13.5 MB Nov 8, 2019. Could it be
related? *shrug* No idea. But it's vaguely possible. More likely such
things are drive firmware related.

-- 
Chris Murphy
