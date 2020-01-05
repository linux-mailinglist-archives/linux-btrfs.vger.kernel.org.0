Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9651309A3
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 20:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgAETge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 14:36:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39449 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAETge (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 14:36:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so13195671wmj.4
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2020 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUOpUMKD9TKFnU+NxibOT418vyI+E4fpZ/UfPbpajAY=;
        b=c99d0BAjlbxQNgaKmCqP6iWdTtZsz53DRFz9jTSqNB6JZROFhP4kgYLqyqstxu0Q6n
         y4cEv4F18R7HhkPLfPMyBf44HsSW3eFdkrd3pCvsYCnhWG9x+BXLvSd+t2W63nNifPKH
         GpBR8NbZfThmbT3ueCsBLbLVKchgHzoXdaRoZdFVgotYY95wJAezRwaPwiQiE+esGp+G
         oajN4ZRifMlMXUB8AS8XkyFuLDpDPa2WSy9/YUtpk0Y2myPdu+Tj13M+4tTM+poKQql4
         SDYBoVsjOkpSJiYO55FFuI8nLQhOjZoXv/cCdghPv72wN4PJ8uvSSGyB7vIgZjEgtLn7
         4VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUOpUMKD9TKFnU+NxibOT418vyI+E4fpZ/UfPbpajAY=;
        b=ahdRJ6g6MyIESt8xJZtoVehSwUupz3zPmpLDH4wKyM2oYdPSictpiie8bertgPtWeN
         0VHj365RFnETPx0bZQqKEnQ1+uWnnNcDhVxpkxm+ALEy56ITGYUeIEDi4Zh7VYP58+gC
         yK+XWULfDZfCGDLzRdGnd85N4+01yl4eDvHJTv0Jzf7yENUWm9P9kWwNV8rpywUy098z
         89N02NR1khe94zNUMad3bNhkKYfRQanEPUtGeneA+fWtx+eHPwwcbX0EubnVLEHx22Fm
         yZQddZulu3liovuDRj1zd+esgShvemed+zUQud3oqvg1hb1NyUHR5jSsPlaoGuD0tZnH
         6lag==
X-Gm-Message-State: APjAAAVYdoEofliItnFMPwpWvTYuUKqHcp5xeKsmx6oz8UdxJ1CbDZ5p
        q69POSgzanOiEAStabiSW2KGiw2OI+sxEEavgJz7NQ==
X-Google-Smtp-Source: APXvYqxDAwx7xZS6BsQZXV9corccwDSn+wGi+Wd5rlxp8eRuokJrv2HLqakWdtjk7Fgms+e4HnBpaIKft45nws2tF/o=
X-Received: by 2002:a7b:cfc2:: with SMTP id f2mr30774935wmm.44.1578252992406;
 Sun, 05 Jan 2020 11:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com> <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com> <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com>
In-Reply-To: <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 5 Jan 2020 12:36:16 -0700
Message-ID: <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 5, 2020 at 12:18 PM Christian Wimmer
<telefonchris@icloud.com> wrote:
>
>
>
> > On 5. Jan 2020, at 15:50, Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Sun, Jan 5, 2020 at 7:17 AM Christian Wimmer <telefonchris@icloud.com> wrote:
> >>

> >> 2020-01-03T11:30:47.479028-03:00 linux-ze6w kernel: [1297857.324177] sda2: rw=2051, want=532656128, limit=419430400

> /dev/sda is the hard disc file that holds the  Linux:
>
> #fdisk -l
> Disk /dev/sda: 256 GiB, 274877906944 bytes, 536870912 sectors
> Disk model: Suse 15.1-0 SSD
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 4096 bytes
> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> Disklabel type: gpt
> Disk identifier: 186C0CD6-F3B8-471C-B2AF-AE3D325EC215
>
> Device         Start       End   Sectors  Size Type
> /dev/sda1       2048     18431     16384    8M BIOS boot
> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
> /dev/sda3  532674560 536870878   4196319    2G Linux swap


Why does the kernel want=532656128 but knows the limit=419430400? The
limit matches the GPT partition map.

What do you get for

btrfs insp dump-s /dev/sda2


> > This is a virtual drive inside the
> > guest VM? And is backed by a file on the Promise storage? What about
> > /dev/sdb? Same thing? You're only having a problem with /dev/sdb,
> > which contains a Btrfs file system.
>
> Actually I have only a problem with the /dev/sdb which is a hard disc file on my Promise storage. The sda2 complains but boots normally.

sda2 complains? You mean just the previously mentioned FITRIM I/O
failures? Or there's more?


>
> Regarding any logs. Which log files I should look at and how to display them?
> I looked at the /var/log/messages but did not find any related information.

Start with

systemctl status fstrim.timer
systemctl status fstrim.service

Find the location of the fstrim.service file and cat it, and post that
too. I want to know exactly what fstrim options it's using. Older
versions try to trim all file systems.

journalctl --since=-8d | grep fstrim

You don't have to post that output but you should see if fstrim has
been called on /dev/sdb any time in the past 8 days. By default
fstrim.timer if enabled, runs once per week.


-- 
Chris Murphy
