Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA13C0C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 03:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbfFKBKa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 21:10:30 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50509 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbfFKBKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 21:10:30 -0400
Received: by mail-wm1-f51.google.com with SMTP id c66so1079990wmf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHZqsfh5YeO6UmGkKCqd4/e5xGIJFJzcN5KGppJxLwQ=;
        b=xmg7ysHUAwGAKt9NnNgqqJdRg1xxhv3SbBhli22n3Fbx8qwougoaqDayaWuR7hkmLQ
         zD7Dzo+D2eDaC/HkeeZloJoE2xDF7qPHf0f9KjEFzQjjkUDYvoyTgb1DZMINiRforl7h
         xwgG+i+2iRIdD46+BjcJKyOaOliukDcp1tePMs1/Tfqu0iAmVCFjLLdhozw9oAiooghU
         9iEBZnrYtkZfPiQfIHcHNKZrmxLfW9XGURBpVqyHzrlBj9k7e3AHA2SQrptkKiZ+bQLa
         9MUuMZX9XCoaBgXgzfGbCw8jIbItbkHUEoxNR1kc3m7O/uHyLYJ2DsWX8A/net3xmWJl
         710Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHZqsfh5YeO6UmGkKCqd4/e5xGIJFJzcN5KGppJxLwQ=;
        b=D0Jau/K1Gez8fG4OQEO39wr1ntxypEeVULPufnW/gFtokfUeRT+aAATksDviBS8vm/
         K5kPzcqSdgH1c/r5t1mKiIP1gj11sBByGYE07rPQU7aNqBbd7twX0WtKLwVz/CqfCYVe
         TDXPExBl2XxK0WqE+c1026LQsIKJSjJCV0r+U31BzdhUBus0nEoYjA6MVUPjuT2rEd0+
         MzzAzaYbHfv5G2nF6cdT8W4hLCD2bbk21RCa1Arciefy5xzT0LAFNW/iB28/CAtNWEMZ
         52Jws+zx0sD6Cb/v1OC+f8xYkBJ4MRJTnsglW1tOba2S78DdS4EglCXPeeNOz3XA/OGK
         Q4iQ==
X-Gm-Message-State: APjAAAVwxw9+yFo8DyvYEeRl2dvdqbtE3bi5vupF21Xc69V61GSb5VNv
        ahJhivvSfJFHhVaKDrLl2eH05VFVAhz6t92xnMp9su4QMrw=
X-Google-Smtp-Source: APXvYqzHw68TStb5wup3/xbcxbZ6v1Kpp+0gsFLjpzzEedkNy4timVW4D8R8UzXGuinlWWKCMqYFjEw/lzCMGShgzo0=
X-Received: by 2002:a1c:a997:: with SMTP id s145mr15184351wme.106.1560215428206;
 Mon, 10 Jun 2019 18:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
In-Reply-To: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 10 Jun 2019 19:10:17 -0600
Message-ID: <CAJCQCtSLVxVtArLHrx0XD6J1oWOowqAnOPzeWVx3J25O7vxFQw@mail.gmail.com>
Subject: Re: Issues with btrfs send/receive with parents
To:     Eric Mesa <eric@ericmesa.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 10, 2019 at 6:03 PM Eric Mesa <eric@ericmesa.com> wrote:

> When I did the btrfs send / receive for SSDHome it took 2.5 days to send
> ~500GiB over a 1GBps cable to the 3GBps drive in the server. It also had the
> error:
> ERROR: failed to clone extents to ermesa/.cache/krunner/
> bookmarkrunnerfirefoxfavdbfile.sqlite: Invalid argument

While there are distinct send and receive errors possible, I'm not
familiar with recognizing them. You can get a better idea what the
problem is with -vv or -vvv to get a more verbose error on the side
that's having the problem. My guess is this is a send error message.


>
> Let's say that snapshot A is a snapshot sent to the server without -p. It
> sends the entire 500GB for 18 hours.
>
> Then I do snapshot B. I send it with -p - takes 15 minutes or so depending on
> how much data I've added.
>
> Then I do snapshot C - and here I always get an error.

It's most useful if you show exact commands because actually it's not
always obvious to everyone what the logic should be and the error
handling doesn't always stop a user from doing something that doesn't
make a lot of sense. We need to know the name of the rw subvolume; the
command to snapshot it; the full send/receive command for that first
snapshot; the command for a subsequent snapshot; and the command to
incrementally send/receive it.




>
> And it always is something like:
>
> ERROR: link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/
> bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg==.jsonlz4 -> ermesa/.mozilla/
> firefox/n35gu0fb.default/bookmarkbackups/
> bookmarks-2019-06-08_679_I1bs5PtgsPwtyXvcvcRdSg==.jsonlz4 failed: No such file
> or directory


>
> It always involves either .cache or .mozilla - the types of files that are
> constantly changing.
>
> It doesn't matter if I do a defrag before snapshot C followed by the sync
> command. It seems that for SSDHome I can only do one full snap send and then
> one parent send.

I don't actually know the status of snapshot aware defragmentation. It
wasn't there, then it was there, then there were problems, and I think
it was pulled rather than fixed. But I don't remember really. I also
don't know if there's a difference between manual defragging and
autodefrag, because I don't use either one. I do use reflinks. And I
have done deduplication. And I don't have any send/receive failures. I
do sometimes see slow sections of send/receive.



>
> Again, so far it seems to be working fine with the other drives which seems to
> suggest to me that it's maybe not the version of my kernel or btrfs progs or
> anything else.

Do you remember the mkfs command for this file system? Or also helpful would be:

# btrfs insp dump-s -f /dev/X  ## for both send and receive side file
system (only one device from each Btrfs volume is needed), this will
give us an idea what the mkfs options were including feature flags.

> And dmesg.log is attached

[    6.949347] BTRFS info (device sdb1): enabling auto defrag

Could be related. And then also

[    9.906695] usb-storage 8-1.3:1.0: USB Mass Storage device detected
[    9.907006] scsi host7: usb-storage 8-1.3:1.0
[   10.950446] scsi 7:0:0:0: Direct-Access     B&N      NOOK
  0322 PQ: 0 ANSI: 2
[   10.951110] sd 7:0:0:0: Attached scsi generic sg7 type 0
[   10.951161] sd 7:0:0:0: Power-on or device reset occurred
[   10.952880] sd 7:0:0:0: [sdg] Attached SCSI removable disk
snip
[  267.794434] usb 9-1.1: reset SuperSpeed Gen 1 USB device number 3
using xhci_hcd
[  272.838054] usb 9-1.1: device descriptor read/8, error -110
[  272.941832] usb 9-1.1: reset SuperSpeed Gen 1 USB device number 3
using xhci_hcd
[  277.958049] usb 9-1.1: device descriptor read/8, error -110
[  278.236339] usb 9-1.1: reset SuperSpeed Gen 1 USB device number 3
using xhci_hcd


USB enclosed drives can be troublesome with any file system, expressly
because of these seemingly random reset that happen. I had the same
thing in an early form of my setup, and it did cause me problems that
Btrfs worked around. But I considered it untenable and fixed it with a
good quality self-powered USB hub (don't rely on bus power), or
perhaps more specifically one that comes with a high amp power
adapter. It needs to be able to drive all the drives in their
read/write usage, which for laptop drives is ~0.35A each.

You really shouldn't be getting link resets like the above, even
though I suspect it's unrelated to the current problem report.

-- 
Chris Murphy
