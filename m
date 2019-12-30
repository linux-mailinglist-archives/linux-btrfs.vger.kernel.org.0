Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45ACE12CCFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 06:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfL3FhI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 30 Dec 2019 00:37:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36759 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfL3FhI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 00:37:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id 19so32428536otz.3
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 21:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nM5UYDvJB39ednY8Wes1nAhu45Engm6QsEQvJqMifs8=;
        b=tXuYJCddBQI4N1KP3IddtbHFkCV4cNzzSCT5PfoCTkdTb6fOBueECjqDXWL30Q/vHq
         ssGD7JMED3MEgFRaZ8SdXiPZhJCQTM/6MeF00tzzK0KNITmozJ9OuGHqfrlJwB/UCSNX
         +9FLNu0GZjpuouGihBxoeAJB1Drl1Hjum/OqerOD3/DZw52mRI64Y5mtf3Y0W1x9LAvK
         46XzbeDyenhYfEex/lpHe+SkAE6bmDgDbf/FVfBBHmnKuzL8BJuEarLZWWbSclhhBmYB
         gYIm5oj5o1XK38o2HUwe2zZPby5+43x//B8SPkxZQ2yDzEio4D62PTGTeXo7RhcYCEOK
         8O8w==
X-Gm-Message-State: APjAAAVht7WdZctqKgBuLQxdKjzQv3FQCpc/Sv4waWrTCEIW9hihXaxb
        yyf0FItuV8W7lzHQzaSoQdSc8OtQWzAHtxUDUFF3HfGdv82tIA==
X-Google-Smtp-Source: APXvYqymwQsuZj53XnYAK+YDVU8lZo2q1fCS/oosZuFTtGBmros9zBkx0Npm60ojWiUROL412Uu+eTPyOmLQUR51GXM=
X-Received: by 2002:a05:6830:1cd3:: with SMTP id p19mr68487642otg.118.1577684227083;
 Sun, 29 Dec 2019 21:37:07 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com>
In-Reply-To: <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Sun, 29 Dec 2019 21:36:56 -0800
Message-ID: <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(ugh, just realized gmail does top replies.  Sorry... will try to
figure out how to make gsuite behave like a sane mail client before my
next reply):

here's btrfs check /dev/nvme0n1p2 (sda3, which is a mirror of it, has
exactly the same output)

[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 815266d6-a8b9-4f63-a593-02fde178263f
found 89383137280 bytes used, no error found
total csum bytes: 85617340
total tree bytes: 1670774784
total fs tree bytes: 1451180032
total extent tree bytes: 107905024
btree space waste bytes: 413362851
file data blocks allocated: 90769887232
 referenced 88836960256

And here's the 'lowmen' variant:

[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
ERROR: root 5 EXTENT_DATA[266 1409024] csum missing, have: 0, expected: 65536
ERROR: root 5 INODE[266] nbytes 1437696 not equal to extent_size 1503232
ERROR: root 5 EXTENT_DATA[4731008 4096] csum missing, have: 0, expected: 2093056
ERROR: root 5 EXTENT_DATA[4731008 2101248] csum missing, have: 0, expected: 8192
ERROR: root 5 INODE[4731008] nbytes 73728 not equal to extent_size 2174976
ERROR: root 5 EXTENT_DATA[4731012 4096] csum missing, have: 0, expected: 8192
ERROR: root 5 INODE[4731012] nbytes 8192 not equal to extent_size 16384
ERROR: root 5 EXTENT_DATA[6563647 8192] csum missing, have: 0, expected: 4096
ERROR: root 5 INODE[6563647] nbytes 12288 not equal to extent_size 16384
ERROR: root 5 EXTENT_DATA[7090739 131072] csum missing, have: 0, expected: 24576
ERROR: root 5 INODE[7090739] nbytes 139264 not equal to extent_size 163840
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 815266d6-a8b9-4f63-a593-02fde178263f
found 89383137280 bytes used, error(s) found
total csum bytes: 85617340
total tree bytes: 1670774784
total fs tree bytes: 1451180032
total extent tree bytes: 107905024
btree space waste bytes: 413362851
file data blocks allocated: 90769887232
 referenced 88836960256

On Sun, Dec 29, 2019 at 4:46 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/30 上午4:43, Patrick Erley wrote:
> > On a system where I've been tinkering with linux-next for years, my /
> > has got some errors.  When migrating from 5.1 to 5.2, I saw these
> > errors, but just ignored them and went back to 5.1, and continued my
> > tinkering.  Over the holidays, I decided to try to upgrade the kernel,
> > saw the errors again, and decided to look into them, finding the
> > tree-checker page on the kernel docs, and am writing this e-mail.
> >
> > My / does not contain anything sensitive or important, as /home and
> > /usr/src are both subvolumes on a separate larger drive.
> >
> > btrfs fi show:
> > Label: none  uuid: 815266d6-a8b9-4f63-a593-02fde178263f
> > Total devices 2 FS bytes used 93.81GiB
> > devid    1 size 115.12GiB used 115.11GiB path /dev/nvme0n1p2
> > devid    3 size 115.12GiB used 115.11GiB path /dev/sda3
> >
> > Label: none  uuid: 4bd97711-b63c-40cb-bfa5-aa9c2868cf98
> > Total devices 1 FS bytes used 536.48GiB
> > devid    1 size 834.63GiB used 833.59GiB path /dev/sda5
> >
> > Booting a more recent kernel, I get spammed with:
> > [    8.243899] BTRFS critical (device nvme0n1p2): corrupt leaf: root=5
> > block=303629811712 slot=30 ino=5380870, invalid inode generation: has
> > 13221446351398931016 expect [0, 2997884]
>
> Inode generation repair is introduced in v5.4. So feel free to use
> `btrfs check --repair` to repair such problems.
>
> But please run a `btrfs check` without --repair and paste the output,
> just in case there are extra problems which may screw up repair.
>
> Thanks,
> Qu
>
> > [    8.243902] BTRFS error (device nvme0n1p2): block=303629811712 read
> > time tree block corruption detected
> >
> > There are 6 corrupted inodes:
> > cat dmesg.foo  | grep "BTRFS critical" | sed -re
> > 's:.*block=([0-9]*).*ino=([0-9]+).*:\1 \2:' | sort | uniq
> > 303629811712 5380870
> > 303712501760 3277548
> > 303861395456 5909140
> > 304079065088 2228479
> > 304573444096 3539224
> > 305039556608 1442149
> >
> > and they all have the same value for the inode generation.  Before I
> > reboot into a livecd and btrfs check --repair, is there anything
> > interesting that a snapshot of the state would show?  I have 800gb
> > unpartitioned on the nvme, so backing up before is already in the
> > plans, and I could just as easily grab an image of the partitions
> > while I'm at it.
> >
>
