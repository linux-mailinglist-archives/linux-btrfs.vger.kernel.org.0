Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D06CAFDC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 22:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbfJCUSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 16:18:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33096 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfJCUSV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Oct 2019 16:18:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so7970418wme.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2019 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bB0KqYn9U3/jcQ+nLZFWsVeJcALh6T+ZTSsi4SY+N4A=;
        b=HycSVgoqDlwPGCakx/7sAWJFSQ3ARQWafa64BBx6zE53ULoAf5dUM/GsV0ENDiK74e
         uXG7rVb1cewNbQix8jqYOv32GtmwBZbFUZ6u1zdAULnzlPkvNQRvbeICR2U6cc+d3104
         M+zhO4n/LWrw7pHNUNOHWDP/dQnNjYVHsy0QpP5rx3RRMviQ/ObP2sslPrKhJDUykqFG
         BiMaxwE8CAXGFDShCKT9jmk/DFMlvp75ykpDMIWB0eW/gxuukkmaksYqlb46EA/w0rK7
         aOB/Kc1PMB7+BdV2hdVDwDtlzxakKm3C0PUyFdpBAkmHXcE8zqgWmRD7NWfg7L7+s1M8
         bE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bB0KqYn9U3/jcQ+nLZFWsVeJcALh6T+ZTSsi4SY+N4A=;
        b=OnHYItefyqgUWm5ANJ6EMOkfKOCBojMDrTdpreO9jhSXCV8s1YyFkEUGywUaOPOxuH
         BMMYT0oKDyJ+i4oPxSlSggbn959cCxp3HccduTqsM8afESQLOg3/GWZgTMWGfwo2b2S5
         6LHI0NnbJy69hztVYaW2gz2axn9q7MK8721Je8ksiDLLgozjeG10bMQ2UAkFwVzyhu2B
         slKLMJ3eHAB/jy+XiPPna35/pCZewxBxKk0YFvYQwll480OvcUlmvF751HyiaMpQ5m17
         8fjCuiotT/n6/Kym5vIr4oaNlKu8vvKg1oCUOMwgr0/N3MGyXgyEZBYenexdGIJDmIkk
         4jSQ==
X-Gm-Message-State: APjAAAW9iLvwFm9JUB2eTqyym/QrZO+ejjGC1GOhYbjBMiBFqLOIbYeP
        j32y2Vtn2tFYynGtbUspBOyIE/RXJIe2uEVHAyrvb0WrsPnPWA==
X-Google-Smtp-Source: APXvYqxQegZMvTbvUJUKZ/7e7vad+PsTGVaFa+I3vwZF/XCKRoIcaFAc6dzHv3T3SaP5X6o8AEO66wMzT7cSVeTc8nc=
X-Received: by 2002:a7b:c108:: with SMTP id w8mr8329438wmi.8.1570133898242;
 Thu, 03 Oct 2019 13:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <804e7e93a00dfe954222e4f8dc820a075d9ccb79.camel@render-wahnsinn.de>
 <0fdd1282-f370-b55e-0c3f-486ad8673bcd@suse.com> <3616237f8d39c87abcc9b118b8441cfecf36eeb6.camel@render-wahnsinn.de>
 <CAJCQCtQcKRN09wpbSmguNQ8bSq5VZEk2JNwLOWcsAK7YYJD2YA@mail.gmail.com>
 <273d41c4d05283aaa658d9c374e7c43199b0aac3.camel@render-wahnsinn.de> <498f23ebd3889618cb3faedf04c72ff059553121.camel@render-wahnsinn.de>
In-Reply-To: <498f23ebd3889618cb3faedf04c72ff059553121.camel@render-wahnsinn.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 3 Oct 2019 14:18:07 -0600
Message-ID: <CAJCQCtRGCqTOseT2PcHpSv=SOKZBt9trSMkkZ5-KSTZTW4dKog@mail.gmail.com>
Subject: Re: BTRFS Raid5 error during Scrub.
To:     Robert Krig <robert.krig@render-wahnsinn.de>
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 3, 2019 at 6:18 AM Robert Krig
<robert.krig@render-wahnsinn.de> wrote:
>
> By the way, how serious is the error I've encountered?
> I've run a second scrub in the meantime, it aborted when it came close
> to the end, just like the first time.
> If the files that are corrupt have been deleted is this error going to
> go away?

Maybe.


> > > > Opening filesystem to check...
> > > > Checking filesystem on /dev/sda
> > > > UUID: f7573191-664f-4540-a830-71ad654d9301
> > > > [1/7] checking root items                      (0:01:17 elapsed,
> > > > 5138533 items checked)
> > > > parent transid verify failed on 48781340082176 wanted 109181
> > > > found
> > > > 109008items checked)
> > > > parent transid verify failed on 48781340082176 wanted 109181
> > > > found
> > > > 109008
> > > > parent transid verify failed on 48781340082176 wanted 109181
> > > > found
> > > > 109008

These look suspiciously like the 5.2 regression:
https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u

You should either revert to a 5.1 kernel, or use 5.2.15+.

As far as I'm aware it's not possible to fix this kind of corruption,
so I suggest refreshing your backups while you can still mount this
file system, and prepare to create it from scratch.


> > > > Ignoring transid failure
> > > > leaf parent key incorrect 48781340082176
> > > > bad block 48781340082176
> > > > [2/7] checking extents                         (0:03:22 elapsed,
> > > > 1143429 items checked)
> > > > ERROR: errors found in extent allocation tree or chunk allocation

That's usually not a good sign.



> > > > [3/7] checking free space cache                (0:05:10 elapsed,
> > > > 7236
> > > > items checked)
> > > > parent transid verify failed on 48781340082176 wanted 109181
> > > > found
> > > > 109008ems checked)
> > > > Ignoring transid failure
> > > > root 15197 inode 81781 errors 1000, some csum missing48 elapsed,

That's inode 81781 in the subvolume with ID 15197. I'm not sure what
error 1000 is, but btrfs check is a bit fussy when it enounters files
that are marked +C (nocow) but have been compressed. This used to be
possible with older kernels when nocow files were defragmented while
the file system is mounted with compression enabled. If that sounds
like your use case, that might be what's going on here, and it's
actually a benign message. It's normal for nocow files to be missing
csums. To confirm you can use 'find /pathtosubvol/ -inum 81781' to
find the file, then lsattr it and see if +C is set.

You have a few options but the first thing is to refresh backups and
prepare to lose this file system:

a. bail now, and just create a new Btrfs from scratch and restore from backup
b. try 'btrfs check --repair' to see if the transid problems are fixed; if not
c. try 'btrfs check --repair --init-extent-tree' there's a good chance
this fails and makes things worse but probably faster to try than
restoring from backup

-- 
Chris Murphy
