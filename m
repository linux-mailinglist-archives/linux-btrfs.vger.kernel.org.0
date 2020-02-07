Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D2156130
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 23:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGWbP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 17:31:15 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37348 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGWbP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 17:31:15 -0500
Received: by mail-ua1-f67.google.com with SMTP id h32so457101uah.4
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 14:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnQF3TA2DOGooE2RI+kBZtKFuTnc7lKbEpwuXC7rjLg=;
        b=mb39vvVeX+M8VvIMhMB07a7DLP/8/ACiBrE0LxzdR4Kr/9FATwMttiHV7G+AB50Aar
         fivHRButRMLfjvCUYto4t2xgRoJWg0LcK22tPwDVUJl09cCd8BdC6lAnFvQUrdn162AM
         zLKNqjEpXTMYs4wZnQMxGAJoBYOq2vof+2SEPV6rr2FASpKReEuK6NXJJ/84Oo7RpPIT
         pBv8eVRv9XjbuHQtGx1Fc8KVnpALJuCo4Kl+BsRjY8L9XPEJMTO4jUnPHqKr1Dh834ET
         A3+dUPqqK5qyzyojT/wqmh19iE5a7oZL+AwE5QFSLcFmFAugQ3Z1kefypD+LQDOwl20j
         NBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnQF3TA2DOGooE2RI+kBZtKFuTnc7lKbEpwuXC7rjLg=;
        b=k8S6x5B9mvG03yFep/+DP5JZ+9H8o5O5qA/o3PERNxulcJ8WnBKowUE3OnCMhP0I0H
         jz52S1AsGnHi1oByYv092fVLJ5MfO3BFRCPnkM7l8eBQOQ7Uha7V/x+UkJLayOoqh1L+
         M/M5n5kIJN8QISmxAZqemYkt/eK1T4X3OEwhh9IMtaZGaVUJ1Dv+SUU6cBkE+RxdhnVR
         dEbtbOWFkJH5+JTzxqgt6vIvTKVtWYeRy/gAuk8KcNZ+IDShlhzExP/UgAR7OLTInkwJ
         B7QQzbmrV/ZXfPI3vil5j4FrLnjw6WyY34yn9pLBx4DYLOn4cuGXJEMW82oQKXIXgLD1
         RneA==
X-Gm-Message-State: APjAAAUa/BqlZ5E0K7aYGQJr7CS/svXxE8o3RxDGIjcDi2e/fW3Nk/Iy
        Ln8HrEQgH2yO57P2HrtOyFcx16V2yiQPxGLr0icg+kO6Qa0=
X-Google-Smtp-Source: APXvYqyb7idFlGTUQpooobbisYTIg+6mjOzfhCxuXanCq1bI7aRxOFT+bDsOrNrbDwLKi53UPjKYrPb1H2YFb9lN/uo=
X-Received: by 2002:ab0:18a1:: with SMTP id t33mr638900uag.123.1581114674006;
 Fri, 07 Feb 2020 14:31:14 -0800 (PST)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com> <CAJCQCtShJVH-mTQEQ--RHyJgMWw1R-YfeUQLp2rn3x+xOwJz+Q@mail.gmail.com>
In-Reply-To: <CAJCQCtShJVH-mTQEQ--RHyJgMWw1R-YfeUQLp2rn3x+xOwJz+Q@mail.gmail.com>
From:   John Hendy <jw.hendy@gmail.com>
Date:   Fri, 7 Feb 2020 16:31:03 -0600
Message-ID: <CA+M2ft88F8XfF+Ob8mvdPvgKEQx=q8xwfgiCjL+ACM3XVuAhbA@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 7, 2020 at 2:22 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Fri, Feb 7, 2020 at 10:52 AM John Hendy <jw.hendy@gmail.com> wrote:
>
> > As an update, I'm now running off of a different drive (ssd, not the
> > nvme) and I got the error again! I'm now inclined to think this might
> > not be hardware after all, but something related to my setup or a bug
> > with chromium.
>
> Even if there's a Chromium bug, it should result in file system
> corruption like what you're seeing.

I'm assuming you meant "*shouldn't* result in file system corruption"?

>
> > dmesg after trying to start chromium:
> > - https://pastebin.com/CsCEQMJa
>
> Could you post the entire dmesg, start to finish, for the boot in
> which this first occurred?

Indeed. Just reproduced it:
- https://pastebin.com/UJ8gbgFE

Aside: is there a preferred way for sharing these? The page I read
about this list said text couldn't exceed 100kb, but my original
appears to have bounced and the dmesg alone is >100kb... Just want to
make sure pastebin is cool and am happy to use something
better/preferred.

> This transid isn't realistic, in particular for a filesystem this new.

Clarification, and apologies for the confusion:
- the m2.sata in my original post was my primary drive and had an
issue, then I wiped, mkfs.btrfs from scratch, reinstalled linux, etc.
and it happened again.

- the ssd I'm now running on was the former boot drive in my last
computer which I was using as a backup drive for /mnt/vault pool but
still had the old root fs. After the m2.sata failure, I started
booting from it. It is not a new fs but >2yrs old.

If you'd like, let's stick to troubleshooting the ssd for now.

> [   60.697438] BTRFS error (device dm-0): parent transid verify failed
> on 202711384064 wanted 68719924810 found 448074
> [   60.697457] BTRFS info (device dm-0): no csum found for inode 19064
> start 2392064
> [   60.697777] BTRFS warning (device dm-0): csum failed root 339 ino
> 19064 off 2392064 csum 0x8941f998 expected csum 0x00000000 mirror 1
>
> Expected csum null? Are these files using chattr +C? Something like
> this might help figure it out:
>
> $ sudo btrfs insp inod -v 19064 /home

$ sudo btrfs insp inod -v 19056 /home/jwhendy
ioctl ret=0, bytes_left=4039, bytes_missing=0, cnt=1, missed=0
/home/jwhendy/.config/chromium/Default/Cookies

> $ lsattr /path/to/that/file/

$ lsattr /home/jwhendy/.config/chromium/Default/Cookies
-------------------- /home/jwhendy/.config/chromium/Default/Cookies

> Report output for both.
>
>
> > Thanks for any pointers, as it would now seem that my purchase of a
> > new m2.sata may not buy my way out of this problem! While I didn't
> > want to reinstall, at least new hardware is a simple fix. Now I'm
> > worried there is a deeper issue bound to recur :(
>
> Yep. And fixing Btrfs is not simple.
>
> > > nvme0n1p3 is encrypted with dm-crypt/LUKS.
>
> I don't think the problem is here, except that I sooner believe
> there's a regression in dm-crypt or Btrfs with discards, than I
> believe two different drives have discard related bugs.
>
>
> > > The only thing I've stumbled on is that I have been mounting with
> > > rd.luks.options=discard and that manually running fstrim is preferred.
>
> This was the case for both the NVMe and SSD drives?

Yes, though I have turned that off for the SSD ever since I started
booting from it. That said, I realized that discard is still in my
fstab... is this a potential source of the transid/csum issues? I've
now removed that and am about to reboot after I send this.

$ cat /etc/fstab
/dev/mapper/luks-0712af67-3f01-4dde-9d45-194df9d29d14 on / type btrfs
(rw,relatime,compress=lzo,ssd,discard,space_cache,subvolid=263,subvol=/arch)
/dev/mapper/luks-0712af67-3f01-4dde-9d45-194df9d29d14 on /home/jwhendy
type btrfs (rw,relatime,compress=lzo,ssd,discard,space_cache,subvolid=339,subvol=/jwhendy)
/dev/mapper/luks-0712af67-3f01-4dde-9d45-194df9d29d14 on /mnt/vault
type btrfs (rw,relatime,compress=lzo,ssd,discard,space_cache,subvolid=265,subvol=/vault)

> What was the kernel version this problem first appeared on with NVMe?
> For the (new) SSD you're using 5.5.1, correct?

I just updated today which put me at 5.5.2, but in theory yes. And as
I went to check that I get an Input/Output error trying to check the
pacman log! Here's the dmesg with those new errors included:
- https://pastebin.com/QzYQ2RRg

I'm still mounted rw, but my gosh... what the heck is happening. The
output is for a different root/inode:

$ sudo btrfs insp inod -v 273 /
ioctl ret=0, bytes_left=4053, bytes_missing=0, cnt=1, missed=0
//var/log/pacman.log

Is the double // a concern for that file?

$ sudo lsattr /var/log/pacman.log
-------------------- /var/log/pacman.log

> Can you correlate both corruption events to recent use of fstrim?

I've never used fstrim manually on either drive.

> What are the make/model of both drives?

- ssd: Samsung 850 evo, 250G
- m2.sata: nvme Samsung 960 evo, 250G

> In the meantime, I suggest refreshing backups. Btrfs won't allow files
> with checksums that it knows are corrupt to be copied to user space.
> But it sounds like so far the only files affected are Chrome cache
> files? If so this is relatively straight forward to get back to a
> healthy file system. And then it's time to start iterating some of the
> setup to find out what's causing the problem.

So far, it seemed limited to chromium. I'm not sure about the new
input/output error trying to cat/grep on /var/log/pacman.log. I can
also ro my old drive just fine and have not done anything significant
on the new one. If/when we get to potential destructive operations,
I'll certainly re-up prior to doing those.

Really appreciate the help!
John

>
> --
> Chris Murphy
