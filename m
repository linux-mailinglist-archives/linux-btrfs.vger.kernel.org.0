Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260A912CD2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 07:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfL3GH3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 30 Dec 2019 01:07:29 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38581 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfL3GH2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 01:07:28 -0500
Received: by mail-ot1-f46.google.com with SMTP id d7so40576752otf.5
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 22:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jmJBewkXwymAf9FYyH1/3PS33D0LT+UXxk3L0EXo7GE=;
        b=fhIkLE8wiQuVePqqkcjpz2y2dou/pX1B1L5nKHhbwzWp/cFHAH84Wcd5kja7pEk5lT
         j0qpiHZaGizAyaGNGnos7z84OZ4CBitH3U2k7ktatYarozNboTQy3bImmmvoEvlFHlAV
         qbpUCTUpPbyg0ykXh//NIZghRTqOvLen8TQ4tWiqmDDUfgKsvgIisl0h12hVq1ZLAE5z
         8wDzWrj027GiPAyDbzl4usKKjR745rzUf8HRc+D7hYW6hYJgWHn8F19L6JO2KrZ23VLp
         3HXfYT/+vOq1gTNipGH9K8nrWUhbej4EC+JajaxM3xvdGxm0BSbKDxAIMVaj9BbNYq4y
         TWAg==
X-Gm-Message-State: APjAAAVzjtysHPuyYdxHCFkoQ0jmbj66BYbseFWw9O83TbQc0BuUWPNP
        rki6bsmdhctvHB5VZG4jM0o+8urlNF2dZVo7PVz3YKQprNMf6Q==
X-Google-Smtp-Source: APXvYqxjcFD5lCZs77CXChUEPYxtNQqhvMkT7N/PU4roW8OO3Q4PNgxMe84YeVfkwTPt1aKDJgR4/ibwV09A0uHatiY=
X-Received: by 2002:a05:6830:1cd3:: with SMTP id p19mr68599007otg.118.1577686047953;
 Sun, 29 Dec 2019 22:07:27 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com> <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com> <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com> <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com>
In-Reply-To: <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Sun, 29 Dec 2019 22:07:17 -0800
Message-ID: <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 9:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/30 下午1:50, Patrick Erley wrote:
> > On Sun, Dec 29, 2019 at 9:47 PM Patrick Erley <pat-lkml@erley.org> wrote:
> >>
> >> On Sun, Dec 29, 2019 at 9:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2019/12/30 下午1:36, Patrick Erley wrote:
> >>>> (ugh, just realized gmail does top replies.  Sorry... will try to
> >>>> figure out how to make gsuite behave like a sane mail client before my
> >>>> next reply):
> >>>>
> >>>> here's btrfs check /dev/nvme0n1p2 (sda3, which is a mirror of it, has
> >>>> exactly the same output)
> >>>>
> >>>> [1/7] checking root items
> >>>> [2/7] checking extents
> >>>> [3/7] checking free space cache
> >>>> [4/7] checking fs roots
> >>>> [5/7] checking only csums items (without verifying data)
> >>>> [6/7] checking root refs
> >>>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>>> Opening filesystem to check...
> >>>> Checking filesystem on /dev/nvme0n1p2
> >>>> UUID: 815266d6-a8b9-4f63-a593-02fde178263f
> >>>> found 89383137280 bytes used, no error found
> >>>> total csum bytes: 85617340
> >>>> total tree bytes: 1670774784
> >>>> total fs tree bytes: 1451180032
> >>>> total extent tree bytes: 107905024
> >>>> btree space waste bytes: 413362851
> >>>> file data blocks allocated: 90769887232
> >>>>  referenced 88836960256
> >>>
> >>> It looks too good to be true, is the btrfs-progs v5.4? IIRC in v5.4 we
> >>> should report inodes generation problems.
> >>
> >> Hurray Bottom Reply?
> >>
> >> /usr/src/initramfs/bin $ ./btrfs.static --version
> >> btrfs-progs v5.4
>
> This is strange.
>
>
> 6084adam|thinkpad|~$ btrfs check --mode=lowmem test.img
> Opening filesystem to check...
> Checking filesystem on test.img
> UUID: c6c6ddd2-01c1-47fc-b699-cacfae9d4bfd
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated
> [4/7] checking fs roots
> ERROR: invalid inode generation for ino 257, have 8858344568388091671
> expect [0, 9)
> ERROR: errors found in fs roots
> found 131072 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 131072
> total fs tree bytes: 32768
> total extent tree bytes: 16384
> btree space waste bytes: 123409
> file data blocks allocated: 0
>  referenced 0
> 6085adam|thinkpad|~$ btrfs --version
> btrfs-progs v5.4
>
> As expected, v5.4 should detect such problem without problem.
>
> Would you please provide extra tree dump to help us to determine what
> makes btrfs check unable to detect such problems?
>
> # btrfs ins dump-tree -b 303629811712 /dev/dm-1
anvil ~ # btrfs ins dump-tree -b 303629811712 /dev/nvme0n1p2
btrfs-progs v5.4
Invalid mapping for 303629811712-303629815808, got 476092633088-477166374912
Couldn't map the block 303629811712
Couldn't map the block 303629811712
bad tree block 303629811712, bytenr mismatch, want=303629811712, have=0
ERROR: failed to read tree block 303629811712
