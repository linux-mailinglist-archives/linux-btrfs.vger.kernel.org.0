Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE7155F80
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 21:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGUWR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 15:22:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40175 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGUWR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 15:22:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so395706wru.7
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 12:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6AsgFeki4sBs6YPbgx0WqEWuC8p9l5nkMQfU8SqUDw=;
        b=br0oipOaG2H1Sk4jFc6iVlCpvQc/9feXYYO/ibNF2coOUIwWwmZfZCSDxW0X6je6P6
         OG5F+XqZKPDlY05NGv48ehWesFP8+DFvcH0cXOgCZXugJP20ozoMbzlfFu8YeHRawzj7
         MwcK/fprqnh/nJVzgsFVHLY8UnYI0le4iZKzst1J/Cy0fPQMm6JgxsH/H9f3YCj4AGgM
         rk2anN/Z7inJSURdC8ZtdPTu3Ep2o9v8NCa2Ivb7JpEjNkHyzQopnrtTeefKfniILlnX
         WPdQtEpQtjGjPzA9iMIewhHPUTLDs/HBUtNYs2vM+3Mexob5uxA69LXzy4xP8nJ8xy2i
         SiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6AsgFeki4sBs6YPbgx0WqEWuC8p9l5nkMQfU8SqUDw=;
        b=G9AE8pjRPrjKji588PyD+FCT3Q/OBAukU6aDtVjcXdiXdcwXZ3nyI4mfBoMBR5KGRx
         X/fC2YaMa9NL05KRrlCZpZfmzePkQNsVl9L9EzT1YRHrLEg6cKxtikWRFaliOMr64hQi
         YNwNJP22xlsU/FTfpP14DyqfoLTTz00jbw1cQjNIZPJUqb82ihTFgZ/Es7rbrKmEu8tk
         QIHVtfADvmQccw+FWRHAFJuhrdmmLhnDofRMAntncZg+i/xslqDhh2ewbD1TcHw8P03H
         Pv3F6nhEbGJTmeDj5eXnuX+X/YlwRM/Y5MmW4ktvI2iIaNzI4LCV2s7iEfdmuBvc6Q7C
         9Dwg==
X-Gm-Message-State: APjAAAUuuiDeGVZiGwkAgD7ydE1cRHsyClFyJkzw7ZokhgQmW0WpZpCg
        yJbKX2Fv9eUxsEla71220EY8sbrXWpMEgZgKUAOkEe9jwFifwQ==
X-Google-Smtp-Source: APXvYqyZl5jta8zbALBloqDleoZ+lPt9lREENsF5QZ+Wnxe/GEx1aDMyQUB3kGJuYwVmmy3BsvfDwdTyYGANJj0aHXs=
X-Received: by 2002:adf:ab14:: with SMTP id q20mr741884wrc.274.1581106935083;
 Fri, 07 Feb 2020 12:22:15 -0800 (PST)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
In-Reply-To: <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 7 Feb 2020 13:21:59 -0700
Message-ID: <CAJCQCtShJVH-mTQEQ--RHyJgMWw1R-YfeUQLp2rn3x+xOwJz+Q@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 7, 2020 at 10:52 AM John Hendy <jw.hendy@gmail.com> wrote:

> As an update, I'm now running off of a different drive (ssd, not the
> nvme) and I got the error again! I'm now inclined to think this might
> not be hardware after all, but something related to my setup or a bug
> with chromium.

Even if there's a Chromium bug, it should result in file system
corruption like what you're seeing.


> dmesg after trying to start chromium:
> - https://pastebin.com/CsCEQMJa

Could you post the entire dmesg, start to finish, for the boot in
which this first occurred?

This transid isn't realistic, in particular for a filesystem this new.

[   60.697438] BTRFS error (device dm-0): parent transid verify failed
on 202711384064 wanted 68719924810 found 448074
[   60.697457] BTRFS info (device dm-0): no csum found for inode 19064
start 2392064
[   60.697777] BTRFS warning (device dm-0): csum failed root 339 ino
19064 off 2392064 csum 0x8941f998 expected csum 0x00000000 mirror 1

Expected csum null? Are these files using chattr +C? Something like
this might help figure it out:

$ sudo btrfs insp inod -v 19064 /home
$ lsattr /path/to/that/file/

Report output for both.


> Thanks for any pointers, as it would now seem that my purchase of a
> new m2.sata may not buy my way out of this problem! While I didn't
> want to reinstall, at least new hardware is a simple fix. Now I'm
> worried there is a deeper issue bound to recur :(

Yep. And fixing Btrfs is not simple.

> > nvme0n1p3 is encrypted with dm-crypt/LUKS.

I don't think the problem is here, except that I sooner believe
there's a regression in dm-crypt or Btrfs with discards, than I
believe two different drives have discard related bugs.


> > The only thing I've stumbled on is that I have been mounting with
> > rd.luks.options=discard and that manually running fstrim is preferred.

This was the case for both the NVMe and SSD drives?

What was the kernel version this problem first appeared on with NVMe?
For the (new) SSD you're using 5.5.1, correct?

Can you correlate both corruption events to recent use of fstrim?

What are the make/model of both drives?

In the meantime, I suggest refreshing backups. Btrfs won't allow files
with checksums that it knows are corrupt to be copied to user space.
But it sounds like so far the only files affected are Chrome cache
files? If so this is relatively straight forward to get back to a
healthy file system. And then it's time to start iterating some of the
setup to find out what's causing the problem.


-- 
Chris Murphy
