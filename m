Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5529443163F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJRKjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 06:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhJRKjd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 06:39:33 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C298C06161C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 03:37:22 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id i22so2908999ual.10
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 03:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YO3L3te2RV0o8gR7qbf3cjIdIue2PVwJaV67BX6PmwI=;
        b=MzZvDeXHhRkNgQmwxv+L9DOVB4+dwjHUHmzVVludVyaMNIgKWWjUf2H5+a0DKpXUmi
         hzd6GltvaV9xzdy6Prda4/3eTfpVuOw5Fl+EHRLQNP1tKnpTf9fVs3ll2w0m9VbCw186
         Db0IcQvnSVBr0U0aImQLuFIxtNbEIKv5A46QTeAzKz5lapsNTJXGTj2ZdD37Cpv2vMLU
         7dl3BjmiAXKZH7RFiciEt8R1sjOxM0iRDqoOlOW5xK5RQskE72WOnOK1pwZTJ7zsc3B8
         cWFUVI5M5ZdLb0MjmH6dDIEYSppC81h19vRjhXLk1PDnQa/902AEHIVdI56kc/M44u5l
         N1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YO3L3te2RV0o8gR7qbf3cjIdIue2PVwJaV67BX6PmwI=;
        b=pDBYY9dU3HvzbNyQzy12QAKZpcSzRF6zixAG9TMoyzXdMl5VN/4VtmkOwvhheGiEcA
         oefnusJwTEAqE8AM5bzsFGbUjTh3j7Qx61723Q11PmTUzDM3dfBHFjxWVTPQ6S8fb+l6
         Q0mIC8s4f4JVmmQUMFml/oZNrdFaiZ88yMCiTZjy83cfWvWTA38XswOwtp4A1BWC79aM
         v1k0DP0u+u26trrcuhOeCmdOPZLJ8dWtm8iG1Cr4fvyN0tDLAxjdsx4sHW1nxdgrfzBh
         ctoMKdHww2NwfLylW4Kr2VGdfMKjj+pEZBCLPUsHmIgQMQq4yoS7R5U9tzIWDFrJNUa6
         Oj8w==
X-Gm-Message-State: AOAM532ZyHjbThIh7xaCY6GTHJZjXbrhUG7Khw4wI0jWUskTy0UhvJwT
        Q0OIe4eU4j1YJCSRjzpJI1FuYfk/mkC8EJEQ6JY=
X-Google-Smtp-Source: ABdhPJwDITHvv8frR/jufONSRRJNDNhejjMnpdSW6ZINlFurxH1dxuIZsz0x5ObPE44fmB/+6AJoZtvZTEYk28Q17Cc=
X-Received: by 2002:ab0:6c4b:: with SMTP id q11mr26287355uas.128.1634553441475;
 Mon, 18 Oct 2021 03:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2pq_Dhp7X0zRQhzbtMxKP8rC=Z8DvAaB33EF56jZHg0=+rA@mail.gmail.com>
 <637a43e5-4d6f-f69a-74e4-ae240880aa1b@gmx.com> <CAHB2pq_6Wb7H3zxvV33gm7j4nknAvPieNtFU_xFRWr4TZE=6cA@mail.gmail.com>
 <95cd0638-b070-6e92-0de7-bfe74e039684@gmx.com> <CAHB2pq_hmje4zEjf33KHiQe7TpGAsW+0mczgjZkVnkRnVW7z=g@mail.gmail.com>
 <32b91541-1b30-eb26-36d0-7a642172b547@suse.com> <20211018100846.GF30611@twin.jikos.cz>
In-Reply-To: <20211018100846.GF30611@twin.jikos.cz>
From:   James Harvey <jmsharvey771@gmail.com>
Date:   Mon, 18 Oct 2021 11:37:10 +0100
Message-ID: <CAHB2pq-7ADos4BVbATboA3CAM0DK2Gm9_26qpAAF+pdCFYWaJg@mail.gmail.com>
Subject: Re: csum failed, bad tree, block, IO failures. Is my drive dead or
 has my BTRFS broke itself?
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        James Harvey <jmsharvey771@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(Resending because I accidentally sent as HTML and forgot to mention something)

The checksum errors can also be detected at runtime during reads, I
was trying to get a directory from the server and it failed because of
checksum errors (luckily I have that directory backed up). It may only
affect one top-level directory, since the remaining backups I'm doing
haven't stopped for any other directories. I also saw a USB reset in
my logs, which may indicate a bad cable/connection/drive. Here's a bit
of my logs from that:

(loads of SFTP IO errors and btrfs errors above, same errors that I've
sent before)
Oct 18 00:22:06 James-Server kernel: sd 2:0:0:0: [sdb] tag#26
uas_eh_abort_handler 0 uas-tag 1 inflight: IN
Oct 18 00:22:06 James-Server kernel: sd 2:0:0:0: [sdb] tag#26 CDB:
Read(16) 88 00 00 00 00 04 7e c9 a9 80 00 00 00 20 00 00
Oct 18 00:22:06 James-Server kernel: scsi host2:
uas_eh_device_reset_handler start
Oct 18 00:22:06 James-Server kernel: usb 2-6: reset high-speed USB
device number 3 using xhci_hcd
Oct 18 00:22:07 James-Server kernel: scsi host2:
uas_eh_device_reset_handler success
Oct 18 00:22:07 James-Server kernel: btrfs_print_data_csum_error: 1586
callbacks suppressed
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 937984 csum 0x40832952 expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: btrfs_dev_stat_print_on_error:
1631 callbacks suppressed
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13530, gen 0
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 942080 csum 0x901404f8 expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13531, gen 0
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 946176 csum 0x0286f198 expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13532, gen 0
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 950272 csum 0x1ef344b7 expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13533, gen 0
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 954368 csum 0x8cfb460b expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13534, gen 0
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 958464 csum 0xb18f6951 expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13535, gen 0
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 962560 csum 0x99cdfa88 expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13536, gen 0
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 966656 csum 0x906c81a9 expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13537, gen 0
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 970752 csum 0xe6d4dd60 expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13538, gen 0
Oct 18 00:22:07 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 103336 off 974848 csum 0x1395994a expected csum
0x00000000 mirror 1
Oct 18 00:22:07 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 13539, gen 0

On Mon, 18 Oct 2021 at 11:09, David Sterba <dsterba@suse.cz> wrote:
>
> On Sun, Oct 17, 2021 at 08:00:59AM +0800, Qu Wenruo wrote:
> > On 2021/10/17 04:45, James Harvey wrote:
> > > Check hasn't done yet, but it's spit out about 1700 messages (tmux
> > > won't let me scroll up futher) that all look like this:
> >
> > Yeah, this means quite a lot of metadata are filled with garbage.
> >
> > I'm not sure why, but it doesn't like to be caused by btrfs itself.
>
> Agreed, this amount of garbage would be detected by other means
> (mismatching csums while the system is still in use or by
> pre-write/post-read tree checker). It's not bitflips, there are too many
> changes eg. in the bogus block offsets.
>
> Analyzing the actual data left on disk for some known pattern could at
> least give some hint what it was, eg. strings, file headers or raw
> pointers. Besides that a manual system check could prevent that in the
> future, so check cables, possible overheating, up to date
> kernel/firmware (in case it would be cause by other subsystems).
