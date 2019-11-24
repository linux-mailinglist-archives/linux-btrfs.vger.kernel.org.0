Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B11084AB
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2019 20:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKXTJ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Nov 2019 14:09:58 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45739 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfKXTJ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Nov 2019 14:09:58 -0500
Received: by mail-ed1-f49.google.com with SMTP id b5so10435979eds.12
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2019 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YCMNI1tTcZeYS/7ngT3LL90z4mQr0dBdwZCLMt7VkkY=;
        b=A+qrGCzn8VIwbLy4aHNJN5nDTshIuY4rZEdMqxXuh8YL6Spdy1ReVwnjeEqUSwcCm8
         /SAgbLB2PY95gsPrtKM7aAan30vZLMRr1aDdaHKzurVQ6R+/G99Qy+UhYzvY8u2J2BKt
         KyzI8ZxmMZ3mhW8grWIoQG/hpVoV3vFDbWxCNoUwi15qnjtzBccOryIVmlcXagzJ8XxO
         cF2K0dGp4gy+tIssI0mNu2Gchcn5Djgm/y4Lwv5jOWSgYtMi+5Ip1IkfeyNgblq7DKss
         5xldEv3gP8paF8/rV6QRLFu8vMUJdrq2CpCG6ZFqiYHbCpXL83er4IOMkw2QXg0gkmFW
         Uuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YCMNI1tTcZeYS/7ngT3LL90z4mQr0dBdwZCLMt7VkkY=;
        b=Vw+//5KBVUDNSJhio8uIdFcjotQ2P5m1LYrc36iFkqWbAKK6AGpp3m9/N4EcT0zaw9
         HxkzIxYG6odEPUvvbTZKdm7buGD9+Ruj5anpOHVIsid/Q8Ui8w78eFcLK0bp8zIK0Jip
         NGUFcBLxgG/YtuAZKNN/o957/fss1dtLjy9mKmV16Dpyq7HHKpaLFBUoBJZbdJ5743k+
         kp2BfU3kmFsqZSHF0Q+40aueHQe36IKgAbVCjxumZk54OhLdGNSwsL66kKXZZUYoHop5
         35VWUQH74DYJyCYEJ2oxDwFLV5NaxcB6fI4Lte086YS/i2Vr8cAgmEvVZewZyy4ei1vE
         8vKw==
X-Gm-Message-State: APjAAAV2fBYVyZTF4ZHati4iRx3sbIHYQYUKLugMCFyHvc54lDDuiQzB
        0DQoKYBmFWkwqCFtyJuIb9o77GuOozmswTnObPzYuAI=
X-Google-Smtp-Source: APXvYqyv7RopxpAPa5JnGyf6zhZvL4oXwoK+1HbY+Mr/qHSjBXg+7QLuN7/dw6+2oRTXAne5YAt9nQseFAIasrce1M4=
X-Received: by 2002:a17:906:6043:: with SMTP id p3mr33647300ejj.103.1574622595466;
 Sun, 24 Nov 2019 11:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com> <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
 <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com> <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
 <2b0f68d6-6d27-2f14-0b44-8a40abad6542@googlemail.com> <CAKbQEqFYhQBLK83uxp1gS9WNbTVkr535LvKyBbc=6ZCstmGP3Q@mail.gmail.com>
 <d362cbc6-2138-2efc-00d2-729549a03886@gmx.com> <CAKbQEqG362x12PyDUjiz96kGn15xZY_PRdAknS60kKvDDkKktw@mail.gmail.com>
 <75349379-56b2-7381-4201-dbf53e7a111b@gmx.com>
In-Reply-To: <75349379-56b2-7381-4201-dbf53e7a111b@gmx.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Sun, 24 Nov 2019 20:09:18 +0100
Message-ID: <CAKbQEqGoJcP9isUVW479wJMeXa=nNPdU_buNVRFK07LOn8D6Vg@mail.gmail.com>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am So., 24. Nov. 2019 um 01:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
> In short, unless you really need to know how many bytes each snapshots
> really takes, then disable qgroup.
>
> And BTW, for "many" subvolumes/snapshots, I guess we mean 20.
> 200 is already prone to cause problem, not only qgroups, but also send.
>
> So it's also recommended to reduce the number of snapshots.

I've disabled qgroups for now, we'll see how that goes. These are
personal desktops, they would have been nice to have, that's all.
Sadly that means that they probably won't work on any storage setup
complex enough for them to be really useful, either, yet.
If btrfs scales so badly with the number of subvolumes that having >20
at a time should be avoided, doesn't that kill a lot of interesting
use-cases? My "time machine" desktop setup, certainly, but anything
with a couple of users or VMs would chew through that 20 pretty
quickly, even before snapshots. Which leaves the LVM use-case
(snapshot, backup the snapshot, delete the snapshot).

> The slowdown happens in commit transaction, and with commit transaction,
> a lot of operation is blocked until current transaction is committed.
>
> That's why it blocks everything.
>
> We had tried our best to reduce the impact, but deletion is still a big
> problem, as it can cause tons of extents to change their owner, thus
> cause the problem.

Sure, but why does it *have to* block? Couldn't the intent to delete
the subvolume be committed, the metadata changes / actual deletion
happen at leisure? Yes, if qgroups are on, then the qgroup info will
be behind, but so what? At least I think that lax/lazy qgroups would
be a nice option to have.
Also, I still don't get why disabling qgroups, reenabling them and
doing a full rescan is lightning fast (and non-blocking), while just
leaving them on results in the observed behaviour.

Cheers,
C.
