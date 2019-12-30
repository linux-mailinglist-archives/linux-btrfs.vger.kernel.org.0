Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FAB12CD0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 06:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfL3Frf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 30 Dec 2019 00:47:35 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38893 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfL3Frf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 00:47:35 -0500
Received: by mail-ot1-f42.google.com with SMTP id d7so40524272otf.5
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 21:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cVaC9u4TZOb3yyqrJAyb2QrKYEKyplmmZ6fQ1tm9Nq4=;
        b=ody6QmJ5QeK42hjSa14Hke9inVQ7HAAOfr0CA+m4WhdV7ZI+FstN/D4glA3AKvBcX9
         IqCPFakaNY33naWQBVf73Ex6Bx97IO8uzzrl8h+a1xQqi+DYcIJpR5tOq/81D6UxjC9z
         VFRkUhAfMEQZ8QbYJ1qW8grWKjIPoY+MXBGM2DVBPnt9SQVBiwbXjtK/xdajnbNZM/gV
         RR3ikTRNUKmxR1mHdSnDrJ/ySSjmHB1JFL/JMJswS+4TrmKbG0jb1A8p6KQ0m44LIekT
         w/3UUqvm3RZlGGkY5GKX3W34UxtBRDT5ng93jx4qMKpq+nti6s+80J1DRy7Ez/kx+oRJ
         3XJA==
X-Gm-Message-State: APjAAAU8QkFNI3DjqNDUllQYyxnndFNBoDuVQu3C+6Iv6YxwWT1ZfrDL
        sAPTmY3WY/btZ7WOh90tokjMrHDGQVKN2QIRmAaT8hKRVHo/dg==
X-Google-Smtp-Source: APXvYqzagvlUo+Y+KciZ9IuU86O98dulZE1/y7bvwMKkHxGakt5xaKMGJyyrznAm4e31eezOL03LXKUmHHDUJ1HXEVE=
X-Received: by 2002:a05:6830:1cd3:: with SMTP id p19mr68524822otg.118.1577684854752;
 Sun, 29 Dec 2019 21:47:34 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com> <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com>
In-Reply-To: <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Sun, 29 Dec 2019 21:47:23 -0800
Message-ID: <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 9:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/30 下午1:36, Patrick Erley wrote:
> > (ugh, just realized gmail does top replies.  Sorry... will try to
> > figure out how to make gsuite behave like a sane mail client before my
> > next reply):
> >
> > here's btrfs check /dev/nvme0n1p2 (sda3, which is a mirror of it, has
> > exactly the same output)
> >
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > Opening filesystem to check...
> > Checking filesystem on /dev/nvme0n1p2
> > UUID: 815266d6-a8b9-4f63-a593-02fde178263f
> > found 89383137280 bytes used, no error found
> > total csum bytes: 85617340
> > total tree bytes: 1670774784
> > total fs tree bytes: 1451180032
> > total extent tree bytes: 107905024
> > btree space waste bytes: 413362851
> > file data blocks allocated: 90769887232
> >  referenced 88836960256
>
> It looks too good to be true, is the btrfs-progs v5.4? IIRC in v5.4 we
> should report inodes generation problems.

Hurray Bottom Reply?

/usr/src/initramfs/bin $ ./btrfs.static --version
btrfs-progs v5.4
