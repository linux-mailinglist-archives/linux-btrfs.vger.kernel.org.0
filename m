Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3021AAE8F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 00:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbfIEWdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 18:33:43 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37657 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388057AbfIEWdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Sep 2019 18:33:42 -0400
Received: by mail-wm1-f48.google.com with SMTP id r195so4871067wme.2
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2019 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kL8JPTVYR8ClCZhWJmSBU2KorTlXt3n/bzkaLjb2dos=;
        b=sRWqIbpCl4l2kL/7XKKILf/j3oyvJ9vCjLfdpR2ZesbXc5TNxOIQ8ol+hsAnjoALe+
         qdt9m2jjGCpL9n5MReY/kL9ZwySs+M56o7A7/9rgiK9pL7gyaRJSO2RvwrNdhm2PEv/1
         DO9PprVnUfyl5D1hmFbHXdNt2TFdJYDfeqQPDL94Wu4jCWjxEPh48ZEjgev1AH0PAd8j
         FTV+Hm/D7QRltB/ghKRY7JwLurk3vMW0puV6faGxhgkRhF5nwDJmGT63hTzbhzzQrYLG
         cReDGcHFaj538ee0vJglTY/EaUrMZ8CsW9jOpZWnFwF2NllWyVW7kyPAYuRd8DaztITY
         dp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kL8JPTVYR8ClCZhWJmSBU2KorTlXt3n/bzkaLjb2dos=;
        b=BBdkFA36pvCIMQbpSieR4Hhifze5g+u1ISkumJHOVh6Cx9C9jKsJ7xj/pIPsfLx1k3
         UmFg0woUAeyLQx8Vb+v358oDSb83OObH8qsp++xzp1pKPdu7i/qVIHShCPD8mczMleVi
         Thf5o9KvWJg/0GA7NrQ/lFUzpLiJLpIUHAZOi/lCPXh6VG1jnelYmB+6RIMl+q7H092H
         q33h1fNKZTxoeR03RILWGAVw8Inh/MIYrjyDnFevE9pCMoBqqp53/ZSb7EMR89ynAJuy
         j3F7jOAFiwjOpaKs+cuK4aPABf+BH+Oo5FAfz3aaXM2/91TI9rReMJtxKidmGO0Zh9eS
         Suaw==
X-Gm-Message-State: APjAAAX0wSr+QZw1wC84vQk/JGmkiJYoG4xL2DlUOYrkotVPDD//NWju
        2Az+Bqwy5qBzXRLf9ibcbCnqMp8jokJZ0QZjRhfFuVrQgPy2DA==
X-Google-Smtp-Source: APXvYqzN5Gd2Jucm4mbgaNtWa0vuEjc6WnApZtpwuRGD1SURPwf70GzwaWZIC7qgfNpQ8yf6/iDmu9+YEGU+VbofRLQ=
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr4581142wmj.106.1567722819695;
 Thu, 05 Sep 2019 15:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
 <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com> <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
 <51d54d67-bfd3-ee18-d612-330d07d9f714@liland.com> <CAJCQCtSAmCmonFBSBiMCrn+1X__WHDvHgLwWFyScvnfOGRD_4w@mail.gmail.com>
 <6d535ae3-fac4-8fca-4823-2eeceb80529c@liland.com>
In-Reply-To: <6d535ae3-fac4-8fca-4823-2eeceb80529c@liland.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 5 Sep 2019 16:33:28 -0600
Message-ID: <CAJCQCtQiw-DOPSpc=qdQa01=4iQHRq2gx-kR==uDduHUYn=sRw@mail.gmail.com>
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Edmund Urbani <edmund.urbani@liland.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 5, 2019 at 2:44 PM Edmund Urbani <edmund.urbani@liland.com> wrote:
>
> I did not need the degraded option. And so far I see no HW I/O errors in
> dmesg. I have encountered a few errors while copying files and found
> these in the log:
>
> [ 3560.273634] btrfs_print_data_csum_error: 50 callbacks suppressed
> [ 3560.273639] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0x98f94189 expected csum 0xcb3af09a mirror 1

Not a bit flip
0x98f94189
10011000111110010100000110001001
0xcb3af09a
11001011001110101111000010011010


> [ 3560.825942] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 2
> [ 3560.826588] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 3
> [ 3560.827813] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 4
> [ 3560.829063] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 5
> [ 3560.830366] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 6
> [ 3560.831559] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 7
> [ 3560.832998] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 8
> [ 3560.834649] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 9
> [ 3560.836188] BTRFS warning (device sdg1): csum failed root 262 ino
> 1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 10

Also not a bit flip.
0xc0248289
11000000001001001000001010001001
0xcb3af09a
11001011001110101111000010011010

I'm not sure what it means or suggests has happened, that all the
copies are wrong. Plausible with raid5 metadata. But seems unlikely
with raid6 metadata, and also with all devices accounted for.

The file itself is probably fine - these look like metadata
complaints. If you find the file this inode belongs to, either
duplicating it or deleting it is fine, should cause this bad leaf to
just go away. Make sure you delete the correct file, each subvolume
has its own list of inodes, this one is in subvol id 262.

>
> and also:
>
> [ 3889.813300] btree_readpage_end_io_hook: 1860 callbacks suppressed
> [ 3889.813304] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 0
> [ 3889.825732] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 12157064991241308972
> [ 3889.826375] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 12157064991241308972
> [ 3889.828149] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 12157064991241308972
> [ 3889.829649] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 12157064991241308972
> [ 3889.831592] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 12157064991241308972
> [ 3889.833436] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 12157064991241308972
> [ 3889.835458] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 12157064991241308972
> [ 3889.836968] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 12157064991241308972
> [ 3889.848545] BTRFS error (device sdg1): bad tree block start, want
> 34958548107264 have 12157064991241308972

I'm skeptical that a scrub will fix these things, because Btrfs is
passively scrubbing on reads, so any checksum mismatches should get
fixed up, if they can be fixed, from reconstruction, on the fly as
well as scrub. This is a different problem, I'm not sure how serious
it is.

I would still do the full scrub. And then unmount it and run 'btrfs
check --mode=lowmem'. On a file system of this size it will take a
long time. So maybe do it over a weekend

>
> I think that Input/output error btrfsck is showing is actually a
> filesystem checksum error and not triggered by faulty hardware (not
> anymore, I hope). If there actually are any more failing drives here, I
> will most likely do the ddrescue thing again. Currently there are no
> free SATA ports in that system to connect an additional drive, so I
> cannot simply add one (at least not without also installing an
> additional SATA controller).

I suggest start planning how to migrate the data to a new Btrfs
volume. If the problems can't be repaired, this becomes inevitable. A
reasonable strategy is to take read-only snapshots of each subvolume
you want to preserve. And either 'btrfs send/receive' or 'rsync' to
new storage. That way you can keep using the volume rw in the
meantime. Once that completes, do another read only snapshot of each
subvolume, and do an incremental 'send -p' or rsync to migrate the
much smaller changes.


-- 
Chris Murphy
