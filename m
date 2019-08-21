Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE38197DBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfHUOzC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 10:55:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43583 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfHUOzC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 10:55:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so1454856pld.10
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H4XtvXQvCzS5L6LGLong/qNYMYQOmuDo7oYECjyTBwA=;
        b=r/DJZpjRn8GLumWX2tI5Irc+vF88eLeHfnU9DmXtBOak9z99ZLc+O4dtgiap1YmOGl
         6To+sflCVgUzJ23uH5V8Ek4HWx5U+LK8VU0AMN7nxzMHb5tX/HabT/jpzv4a1M87mPLK
         FDoikslve+NKoj0sqSTDBCbQLltehBigRHVMaU3w70yCrmLW7+B6gXd32MFag27BGne0
         PPlM/CLVh7kB18j1Y43Yr78yL6ysLV+go4ezSBoi+WLjIpHnty1aJKKgQ+jW/MDR4NJI
         motgnesU8ER421XdmSkwaDiIeTlhxcCSymYHz9jhqNcv7s0aCVboxfpvjkTCGJdbuIIH
         IBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H4XtvXQvCzS5L6LGLong/qNYMYQOmuDo7oYECjyTBwA=;
        b=Tr9dBYBsYl7XrLgxIP6OWke1/Sqde5vBGiM0jAHSppgSb1Nat3JnAv0MdMoxCPc0ZN
         PmYvqXM5pSuCydgzrqVSNngMSw9bAzDIF/keotFEchsEEs9+sRkiNeyQVjOOofrUnGQ6
         +s+Ruxzsqo8khtm658aAKb9SWNP4vjgTeBOWHwqah1h/9grQeRE0YOiqcQHzvv3b347o
         usD595SdNUdcm5ERcpeOW+YwcDYLXqSAXlKWGW5qLOtvvJtD1pSQqHt0hjR3XER7y0l/
         jLFPLz7z2oxTCsc8UvZEanMB8YAr5vkAY7jYlVlWXZbpZJDKAivQadPbNQuqUiqgZuKG
         nlIA==
X-Gm-Message-State: APjAAAUMc9tgABStwUGbSo7WMeUrDr9c4pyWHIvwzw+FrYAP04v2Ri5G
        ufssWPNYb81MlqRvH5CbsUM7eqY4KSJW2jpbNpE=
X-Google-Smtp-Source: APXvYqyJqhtz067BFXJOyxJCohLFZxBsX4kqj6M/X8rr4To4iAHiTnq67P0Zl8a4zSuzKHgD9QS5QE4RfuQvQuhHgZ4=
X-Received: by 2002:a17:902:2ae9:: with SMTP id j96mr25141958plb.10.1566399301162;
 Wed, 21 Aug 2019 07:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABJoFDA-ZwF3ZDpajHo3288NcV+_NO5BAsXv7yTe_hqqRNv0PQ@mail.gmail.com>
 <f0574fc5-5343-5b9a-fda9-60ba947d88c9@suse.com>
In-Reply-To: <f0574fc5-5343-5b9a-fda9-60ba947d88c9@suse.com>
From:   David Radford <croxis@gmail.com>
Date:   Wed, 21 Aug 2019 07:54:50 -0700
Message-ID: <CABJoFDAuB7DsJtN2E1urTfjYxZ-pFDL-mxRxMzJVvXEyYVWuhQ@mail.gmail.com>
Subject: Re: Unable to mount, even in recovery, parent transid verify failed
 on raid 1
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 20, 2019 at 11:21 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 20.08.19 =D0=B3. 21:17 =D1=87., David Radford wrote:
> > I have two 2TB spinning disks with full disk btrfs in raid 1. I am
> > unable to mount the disks using any method I have found online. I've
> > attached what I hope are the relevant logs. I had to edit them down to
> > meet the file size limit.
> >
> > uname: Linux babylon 5.2.9-arch1-1-custom-btrfs #1 SMP PREEMPT Mon Aug
> > 19 06:41:35 PDT 2019 x86_64 GNU/Linux (Standard Arch Linux kernel
> > compiled with Qu's new rescue patch
> > https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D130637)
>
> SO what event predates this inability to mount? Did you experience any
> hard resets - system hangs etc that prompted you to reboot your machine?
> Have you changed your kernel recently ? There really isn't much to go on
> in here? At the very least DO NOT run any of the repair functionality in
> btrfs-progs just yet.

As far as I know there were no hard resets, but I share my computer
with my 9 year old so I can't guarantee that. (I've been teaching him
how to take care of computers, but he is a kid).  I use arch linux and
I update about every other day, so I am sure there was an update. I
have been in 5.2.x for a while. I apologize that I don't have any more
concrete details. Thankfully btrfs restore is working except for the
files with the bad transid.

>
> >
> > btrfs-progs v5.2.1
> >
> > [root@babylon ~]# btrfs fi show
> > Label: 'linux'  uuid: 3fd368de-157c-4512-8985-2be93a21a371
> >     Total devices 1 FS bytes used 102.48GiB
> >     devid    1 size 119.24GiB used 110.31GiB path /dev/sdb1
> >
> > Label: none  uuid: 2507581c-dec0-4fdd-afe7-1f7c7ff66c6d (this is the
> > one unountable)
> >     Total devices 2 FS bytes used 1.54TiB
> >     devid    1 size 1.82TiB used 790.03GiB path /dev/sdc
> >     devid    2 size 1.82TiB used 790.03GiB path /dev/sdd
> >
> > mounting with usebackuproot and rescue=3Dskip_bg results in
> > [ 1088.130629] BTRFS info (device sdc): trying to use backup root at mo=
unt time
> > [ 1088.130633] BTRFS info (device sdc): disk space caching is enabled
> > [ 1088.130635] BTRFS info (device sdc): has skinny extents
> > [ 1088.135907] BTRFS error (device sdc): parent transid verify failed
> > on 30425088 wanted 18663 found 18664
> > [ 1088.151587] BTRFS error (device sdc): parent transid verify failed
> > on 30425088 wanted 18663 found 18664
> > [ 1088.151605] BTRFS warning (device sdc): failed to read root (objecti=
d=3D2): -5
> > [ 1088.151902] BTRFS error (device sdc): parent transid verify failed
> > on 30425088 wanted 18663 found 18664
> > [ 1088.152134] BTRFS error (device sdc): parent transid verify failed
> > on 30425088 wanted 18663 found 18664
> > [ 1088.152143] BTRFS warning (device sdc): failed to read root (objecti=
d=3D2): -5
> > [ 1088.152519] BTRFS error (device sdc): parent transid verify failed
> > on 30425088 wanted 18663 found 18664
> > [ 1088.152633] BTRFS error (device sdc): parent transid verify failed
> > on 30425088 wanted 18663 found 18664
> > [ 1088.152640] BTRFS warning (device sdc): failed to read root (objecti=
d=3D2): -5
> > [ 1088.153462] BTRFS error (device sdc): parent transid verify failed
> > on 343428399104 wanted 18163 found 19034
> > [ 1088.153690] BTRFS error (device sdc): parent transid verify failed
> > on 343428399104 wanted 18163 found 19034
> > [ 1088.153699] BTRFS warning (device sdc): failed to read root (objecti=
d=3D4): -5
> > [ 1088.154714] BTRFS error (device sdc): parent transid verify failed
> > on 343428399104 wanted 18163 found 19034
> > [ 1088.154915] BTRFS error (device sdc): parent transid verify failed
> > on 343428399104 wanted 18163 found 19034
> > [ 1088.154921] BTRFS warning (device sdc): failed to read root (objecti=
d=3D4): -5
> > [ 1088.261675] BTRFS error (device sdc): open_ctree failed
> >
> > btrfs-find-root log attached
> >
> > I do have partial backup but it is a little outdated and would really
> > appreciate help either fixing the filesystem, or finding out how to
> > recover it with as minimal loss as possible. Thank you for the help!
> >



--=20
- David - Proud to be saving the world since 1984
