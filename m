Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ACB1B65BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 22:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDWUtc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 16:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDWUtb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 16:49:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501BC09B042
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 13:49:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so8237494wrg.11
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f9agCalkskiilLE2UQ06QqFhKWDs0RXLWHCAYgagDj0=;
        b=XwOpQ2JAMxyodp6iBykpwkrkVPdZTE0Mkf1JUF5SJt5fjkbApj7AHb35YP/43ebxmU
         lLakHN0bYkUIEI6GVAxlemDHBODQrmQMpeb/gXXxxfKqGGnzwPijI0RjRYZoRZ/JkSqb
         BOra0wWUIG63RQSYgIeIJ+Mb7xg1D8lOBvu0aywUjwptg3TzhcOn0TjCrpCEig8qQ9hR
         Lj0DXyMUyVWpVRM4tns0gBhv8GRDp3kt5KV+FRqCyzkrKMl5DnRKzzihZZ7d5cdWdcu1
         7e3w5N2J5m3Uw+SoiM94SLHwKW3qUoNk5yMQqUXMTyKsm+745j+OMwWzWSCtmq2tUcqy
         2U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9agCalkskiilLE2UQ06QqFhKWDs0RXLWHCAYgagDj0=;
        b=GHJwuMT6ZIEePrL1d/qqPyE+YEvP0kyE2Iat0VlRjoEwa0uwIPrboV4ZRLeHTrYqUH
         eAaS21bI3rHvYQCLsMJgQ1z1y4B++sRSj+M94E+y1HjhtM8vOjYL/2ZRee9TwSxhWv55
         LTQBzxVq1V+OhjsTSm7g2nbbe9OpGbEma61tnDVnEbtAyIRzHJm2tJZ/sf/Tq1UMtg0R
         I+0s4HYojQDx1d18TyFMcnnynKROzEvpSSOKyDQUIRFGvwAfZ/MyWXbDX56JDvtqkwrN
         WPqDiOCcYqx9NlDRF09AQbbD1BB6pDd2hqB9rVCPKr9RsXROpbPSuGRsO7exq3B4+Vz3
         wmKg==
X-Gm-Message-State: AGi0PuayYFBgg0cJC/OlprsclOIUGUocxysspAWYBB2oKwyguFSsqvVP
        TPtbAqhKILGCwvsd3/oTnNOx9iYY0TloyON4aXgeqg==
X-Google-Smtp-Source: APiQypI6cw7rT24K8JmnVpTw8J/TqenGpMeMPh4gcRDJnHMnGKCzDiTmjbU3T7qwoJSpKo/ExM7eXWdhxWnLn/cYEtM=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr7020096wrc.42.1587674968828;
 Thu, 23 Apr 2020 13:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <03fdc397-4fca-335f-03d8-f93a96d92105@peter-speer.de>
 <CAJCQCtTnA6Dro2XwEm0S7ohUnf_CMGb7giHsBfh4_KtWE4vR6g@mail.gmail.com> <7019baf9-5064-4d16-a09a-5dc5672672de@peter-speer.de>
In-Reply-To: <7019baf9-5064-4d16-a09a-5dc5672672de@peter-speer.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 23 Apr 2020 14:49:12 -0600
Message-ID: <CAJCQCtRnRnvBkpoa+x4GXy83eya-z6bdDj0GgMkEhTHONuF7gg@mail.gmail.com>
Subject: Re: Recommended Partitioning & Subvolume Layout | Newbie Question
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 23, 2020 at 3:39 AM Stefanie Leisestreichler
<stefanie.leisestreichler@peter-speer.de> wrote:
>
>
>
> On 22.04.20 23:03, Chris Murphy wrote:
> > What's the gotcha? Well, my /var has been rolled back, and also the
> > systemd journal. OK so I could make /var/lib/libvirt and /var/log
> > subvolumes so they don't get snapshot and rolled back. What I tend to
> > do is put those in the top level of the file system, and have fstab
> > entries to mount them to the proper location during startup, that way
> > I don't have to worry about manually fixing things on a rollback.
>
> Thanks for your time and answer.
>
> I tend to lean on the fedora layout as far as my limited knowledge
> allows to calculate the impacts so far :-(
>
> I do not understand what is meant by the statement:> What I tend to do
> is put those in the top level of the file system

Practical answer: the top level of a Btrfs file system is what's
mounted without mount options. I usually put all subvolumes and
snapshots there, instead of nesting them. With exceptions.

Technical answer:
Following mkfs.btrfs, the default default subvolume is ID=5 (aliased
to ID=0). It's possible to change the default subvolume, so that mount
will instead directly mount a chosen subvolume. But by default, it's
ID 5, and this unnamed, undeletable, unmovable, but still
snapshottable subvolume is called the top-level of a Btrfs file system
because it's created at mkfs time and can't ever be moved or deleted.


> I guess the storage for the snapshots is meant. So if I understand right
> you have a directory /snapshots in the dir tree where they will be
> stored.

My usual preference is to keep any system snapshots outside the search
path of its parent. So I tend to not like the approach where snapshots
are stored in a hidden (begins with dot) directory.

Conversely, I recognize that for snapshots of *user* directories,
nesting might actually be really useful for the purpose of rollback,
or even "undelete" by reflink copying from a hidden snapshot.

Also, snapshot recursion on Btrfs ends at subvolumes. So even if you
don't intend to snapshot something, it can be useful to use a
subvolume instead of a directory. e.g. if /home/chris is a subvolume,
I might also create /home/chris/.cache as a subvolume (I don't usually
do this but I have done it, works fine). I would never snapshot
/home/chris/.cache so why make it a subvolume? When I snapshot
/home/chris, the resulting snapshot will not contain anything in
/home/chris/.cache because it is a subvolume. Therefore incremental
btrfs send/receive of /home/chris is smaller, because it omits the
cache directory (which happens to be a subvolume in this example).

This is a case where I do sometimes nest. If I ever had to rollback
/home/chris though, /home/chris/.cache is now a directory so I'd have
to remember to create a new .cache subvolume if I want to be
consistent about the strategy. Often I'm not consistent, hence I tend
toward not nesting.

There's no Btrfs performance or on-disk format reason for not nesting.
It's purely organizational and user space consequences.


>I know about the fact that a nested subvolume (subvolume in
> another subvolume) will not get snapshotted. But it is not clear to me
> if you are using this fact in your layout (make i.e. /var/log a separate
> subvolume) or not.

Sometimes. I'm not super consistent about it. Depends on the use case.
On the system that I use for a lot of testing and VM work, I tend to
make two adjustments to the default Fedora layout where only root and
home are on subvolumes.

a. I create a subvolume at the top level 'libvirtimages' with the
proper permission and selinux label; and then in fstab I use
subvol=libvirtimages to mount it at /var/lib/libvirt/images
b. Create a 'logs' subvolum at the top level and also use fstab to
mount it at /var/logs/

This way when I snapshot root, these things are not snapshot. When I
rollback root, these things automatically continue to mount in their
present state without respect to the rollback of root. Yes other
things do rollback still like everything in /etc, but i usually don't
care about that.

Also I usually keep /boot as a directory on the root subvolume, so it
gets rolled back at the same time. I've messed around with separate
boot subvolumes, and I think it's more useful for the use case where
you don't want a persistently mounted /boot and /boot/efi for security
reasons.

>Also it is not clear to me, why you put the snapshots
> in the top level of your filesystem.

If I nest them instead, I have to move them back into place if I do a
rollback, instead of letting fstab always put assembling things
correctly and automatically.


-- 
Chris Murphy
