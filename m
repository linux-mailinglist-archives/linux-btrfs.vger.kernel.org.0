Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEBF11394C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 02:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfLEB1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 20:27:17 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34652 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfLEB1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 20:27:17 -0500
Received: by mail-wr1-f43.google.com with SMTP id t2so1520613wrr.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 17:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+d+z/ALHKgPDxObNAvLa/MaJGtOrxaariS+mVw4O+I=;
        b=gOlhX+8btV2fDCFq5R4rjRRyXKAstn16Qa6X/U1FrotiFsiUzCXkI0yi1hELA2vDea
         hXd8MnaFBF5Mqf53N8uQWwj8p2eDMUjRIphj+QS1QTkczSjKMhsgJ0JxffFankjHTIRC
         Fl0PZF7gDrv8BUeOVCTIEQyO0YqHSCPDsS0a6aC+5kepIi0o6xhIPyc39nxDITu8Nw6P
         iMo/Jp6+SEfeofBRsXo6ViL23nob/QJbCPPxqJ4U/YBhyYTMLYUNQhMVtzAEQ7Zk6mqD
         QKaS+5SDRs7LdPRZ1hW8jYImp4VUnpf00kk0k+y3t1RWVKpJpYKvI2A3yQmflFAm+5rf
         VoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+d+z/ALHKgPDxObNAvLa/MaJGtOrxaariS+mVw4O+I=;
        b=VzMcZeyB2dfXGIplxfmUop7DqI2psYSsSl1BGKa2l1+vBwi76XfqgAtYAGK0UiIJ37
         DhFIsHUvRY8Av/jUeBLgtlmXvLrCRirBT+q1jScBQDhAGNhh8/fyBWfMYqftyRG4oZg4
         Ul0rf6LqXILHlFAs9d97EVhXXzKTq8ga6hOnGdKKWatxKPZQMX8KLKpE2Fv5oMOflKKQ
         JJjSHr5jlwA6gpkeWZQ4HpCR5VLwSCMyX1pquzXr/qX/kZWaM2S5tkRU1LLfQkqG97vZ
         GorCejEn7iBFWNmQKbCTz/3iOdv2QCcnhgwjcuZz/wFgFfA2y74yO05+B627ETWsJbFs
         uIfw==
X-Gm-Message-State: APjAAAVH+w7qUvOZ1fXKyxhivEgeQ3+iU+3WlKKBghrWDaJ5KduHBvEd
        E3sAfBVohIyWiUuA7bkmVEXGa3V1F7AgZcsDUuNYvg==
X-Google-Smtp-Source: APXvYqyUKL203xJ/A9EHfMRvWdq+w0O3PCKOM2c14IMWDWapYG5Hr1IcL4yQDaEUZuvnfYbG4YdCMgecLJh51ycyZNI=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr7240464wrn.101.1575509235238;
 Wed, 04 Dec 2019 17:27:15 -0800 (PST)
MIME-Version: 1.0
References: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net>
 <F7C74BD8-4505-4E74-81F2-EB0D603ABCEC@megacandy.net> <CAJCQCtRA2+X-ke4yJ4H8o49ZA9mSOFabLpNeXd=4ULDg99rFgQ@mail.gmail.com>
 <B154F1B0-C80A-4E7E-B105-B0E654279E28@megacandy.net> <CAJCQCtQW+-VyATVzi47vtBvN34Ev8j704tiQDVZKxHqT15qccw@mail.gmail.com>
 <0CE6AC6A-3D42-44E3-AA9F-AF05AF68897C@megacandy.net>
In-Reply-To: <0CE6AC6A-3D42-44E3-AA9F-AF05AF68897C@megacandy.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Dec 2019 18:26:59 -0700
Message-ID: <CAJCQCtRmmwaQUWTtHCfCv3kfUj__KKArx3DharsdTqFvz=+4zw@mail.gmail.com>
Subject: Re: Unrecoverable corruption after loss of cache
To:     Gard Vaaler <gardv@megacandy.net>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 4, 2019 at 5:34 PM Gard Vaaler <gardv@megacandy.net> wrote:
>
> > 4. des. 2019 kl. 22:09 skrev Chris Murphy <lists@colorremedies.com>:
> > There's a decent chance this is the cause of the problem. That kernel
> > does not have the fix for this bug:
> > https://www.spinics.net/lists/stable-commits/msg129532.html
> > https://bugzilla.redhat.com/show_bug.cgi?id=1751901
> >
> > As far as I'm aware the corruption isn't fixable. You might still be
> > able to mount the file system ro to get data out; if not then decent
> > chance you can extract data with btrfs restore, which is an offline
> > scraping tool, but it is a bit tedious to use.
> > https://btrfs.wiki.kernel.org/index.php/Restore
>
> That was my first thought too, but it seems too coincidental that I should happen across this bug at the same instant as my cache device failing. btrfs-restore doesn't like my filesystem either:

You know, I totally glossed over the cache device failing part of the
very first message 8-\ But yeah it would seem like the cache device
dropped a bunch of metadata. Really a lot more than I'd expect from
the aforementioned kernel bug. So chances are your suspicion is spot
on.

> > [liveuser@localhost-live btrfs-progs-5.4]$ sudo ./btrfs restore -Divvv /dev/bcache0 /mnt
> > This is a dry-run, no files are going to be restored
> > parent transid verify failed on 3719816445952 wanted 317513 found 313040
> > parent transid verify failed on 3719816445952 wanted 317513 found 308297
> > parent transid verify failed on 3719816445952 wanted 317513 found 313040
> > Ignoring transid failure
> > leaf parent key incorrect 3719816445952
> > Error searching -1

You might have to to try a lot of the btrfs-find-root block addresses
(start with highest transid working down) with btrfs restore -t option
to force it to use older roots. Maybe one of them will be intact. It's
also possible to isolate to a subvolume, if you have home on a
subvolume for example.

Unfortunately btrfs restore isn't a simple scraper, it doesn't
iterate. You have to do that part. It is tedious.


-- 
Chris Murphy
