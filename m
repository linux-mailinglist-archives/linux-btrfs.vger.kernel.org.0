Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C4412CD19
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 06:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfL3FvE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 30 Dec 2019 00:51:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37398 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfL3FvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 00:51:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so44952429otn.4
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 21:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eg4oHdC0/N7t6xtLqnq1qqe52o/kDIfnHJdXUXdaCu4=;
        b=pYrS1WtqglQJXE9vIGwbslcB/7+9BV+sLIMh9KMhF3DDwXNxzyZICJBXtDjG9jzvhD
         U9uCAnKCkefpO9aRPM72vs5ocl2FK5WWeItG3ZW2HHMUdJiZHWVzJJhwU3Au0xCQBQnF
         keZVKPvHXdMyLaFeveQj+v9H8/fak2buIJs3s0i7+e1OL9laPcecVh0krsoIDdN12RAA
         usEb+GcItILR+NXiqpv9mlJeiSRgZgnuAMQCAvMynikbaJ9AMN4sKYJIDvwS980QN+ZP
         /m96AOpovMmvItHCG0/+LMP9qtqqvYrgnBOEgnp2oJlcJdiGdf9frfT/EJ08WjyvMPFk
         ApnQ==
X-Gm-Message-State: APjAAAWY5SQ0UTEIITMK5uDo4P0/GbxkoS/dcfGexD8l9SmbGPKxL/Kx
        L5dpTc4B094uQqF9S6XwM9KoAHCJQjo/iJKWnr/woA==
X-Google-Smtp-Source: APXvYqxdyOJC9GzV8YXPYzLxh7UpVG5bDgkTPyiGP+2MM7W4x/KSDW5pHe2TNdXDVGM389u4KYIiS+TPTMNbU6aQJ0E=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr59984522otk.23.1577685063205;
 Sun, 29 Dec 2019 21:51:03 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com> <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com> <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
In-Reply-To: <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Sun, 29 Dec 2019 21:50:52 -0800
Message-ID: <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 9:47 PM Patrick Erley <pat-lkml@erley.org> wrote:
>
> On Sun, Dec 29, 2019 at 9:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2019/12/30 下午1:36, Patrick Erley wrote:
> > > (ugh, just realized gmail does top replies.  Sorry... will try to
> > > figure out how to make gsuite behave like a sane mail client before my
> > > next reply):
> > >
> > > here's btrfs check /dev/nvme0n1p2 (sda3, which is a mirror of it, has
> > > exactly the same output)
> > >
> > > [1/7] checking root items
> > > [2/7] checking extents
> > > [3/7] checking free space cache
> > > [4/7] checking fs roots
> > > [5/7] checking only csums items (without verifying data)
> > > [6/7] checking root refs
> > > [7/7] checking quota groups skipped (not enabled on this FS)
> > > Opening filesystem to check...
> > > Checking filesystem on /dev/nvme0n1p2
> > > UUID: 815266d6-a8b9-4f63-a593-02fde178263f
> > > found 89383137280 bytes used, no error found
> > > total csum bytes: 85617340
> > > total tree bytes: 1670774784
> > > total fs tree bytes: 1451180032
> > > total extent tree bytes: 107905024
> > > btree space waste bytes: 413362851
> > > file data blocks allocated: 90769887232
> > >  referenced 88836960256
> >
> > It looks too good to be true, is the btrfs-progs v5.4? IIRC in v5.4 we
> > should report inodes generation problems.
>
> Hurray Bottom Reply?
>
> /usr/src/initramfs/bin $ ./btrfs.static --version
> btrfs-progs v5.4

Dumb question, did I need to do that while booting a post 5.1 kernel?
I ran these while not having the filesystem mounted, but against
kernel 5.1.  I can easily repeat against 5.4.
