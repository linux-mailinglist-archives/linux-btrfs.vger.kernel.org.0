Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC85B105757
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKUQpT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 11:45:19 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44735 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfKUQpT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 11:45:19 -0500
Received: by mail-ed1-f51.google.com with SMTP id a67so3342003edf.11
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=z8EEz7Pj+/k2jQgi0hT8uAxnvplrad2cPQhfiTH6oos=;
        b=iCFMySyFrvp/yzCgdmtSz6Kw6CvEz4yhyXd4PNQ8KFzPq/Sq+vkq7bEC2J2SYteOY9
         t2HNpU/daIcZZA+r/F/Q3ssytWTpmGPxECf4tYI+zyL27EG/f4w25Wz7PTK3i/qVdqJC
         vyymU6/ikE5oU/5+VJ6U6JfDkB/m9G9qvqd5ukI5/m7hk7P1mG1htMl3IY1HrVgvD822
         dGCXBn3kLZDciM/+YdZPBd0AY0yPx26f760JXIxJ+GSuZW4g3/tnVgl9+tZkGn9kfHcv
         lcEV4+tnyaIWQaBzHGrJLel/iLFtHb5SZl2zoWIlrmEPkzyUBxcv18ipWH+NnfkoOmaO
         TEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=z8EEz7Pj+/k2jQgi0hT8uAxnvplrad2cPQhfiTH6oos=;
        b=V02/dInzH6Ch07w+q3501IJjzKUztH1XS0UWvnza8B4maMFk9yjqbbO4Z3n3QQaKKL
         Og+uH1t1obsyql8g5KoB9P15rbLzq9HDcnCPzORW2ywAbo1oZMKo+8lUvCD+p5dFFEIj
         uqTyEjFaMAqEEUwgvWRUw/5fqQTvxGSWnNogiK3OTe1TSvSnaHWxfH2lnKu4URkEnhd9
         iDL9QoKHZazFWFM9OHmRCUUhya0kQ9UO+5F5BtbxQx5q8qqtZyPMuplEIkxCzqS9MxMN
         SaRrdJZFS8/SO//TYGwT3gMegkol7OV6s5HYXOaE7WiCoA9q2Wo9dQ3JZNFhlycqIe+n
         Hgww==
X-Gm-Message-State: APjAAAWMBhUlJfXRbRFxEfy4WbKOXBWUgL3K/GzxSo9eRb/RFcdTGS30
        sQd3g8s/AemMYxI60/eWtucFIfDckW3KCKxaJGwfWHY=
X-Google-Smtp-Source: APXvYqwXDf+JHz6+SNdLP+tazz52gX0tXumqxcZwxDBwLE8KXdXa5rjEtTTD+lZzuNj6QSXga/GnpMMvOXJLgbSqAWo=
X-Received: by 2002:a17:906:25c5:: with SMTP id n5mr14573732ejb.126.1574354717131;
 Thu, 21 Nov 2019 08:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com> <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com>
In-Reply-To: <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Thu, 21 Nov 2019 17:44:40 +0100
Message-ID: <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Mi., 20. Nov. 2019 um 18:59 Uhr schrieb Oliver Freyermuth
<o.freyermuth@googlemail.com>:
> So I'd say this is not normal.

Good to hear, that means it might be fixable. The alternative would be
to switch to Borg or restic, and I just don't feel comfortable with
deduplication relying solely on hashes, I'm a Luddite like that.

> The first thing you'd need to check is when exactly it happens

Currently 17 minutes past the hour, which is when my cron.hourly runs,
and that only runs btrbk. I can't say for certain if it happens every
hour, but I'm reasonably confident.

> btrbk logs the steps it is doing. Does it happen during the snapshotting, transferring, or deletion of snapshots?

It's just configured to snapshot & prune, no transfer. A central
backup server (grand name, for a white-box NAS) pulls the snapshots
each night and does its own pruning. I'm not sure how to tell when
exactly it happens, as I have not much agency while it is happening.

> Anything in the kernel log?

Nothing suspicious in btrbk.log, dmesg or the systemd journal. The
affected things just stop reacting, then continue as if nothing had
happened.

> Did you run a deduplication tool on the BTRFS volumes, or use quotas?

No to deduplication, maybe to quotas. It's possible that Timeshift
enables them, how can I check?

Just had another episode:
2019-11-21T17:17:01+0100 startup v0.26.0 - - - # btrbk command line
client, version 0.26.0
2019-11-21T17:17:01+0100 snapshot starting
/mnt/timeshift/backup/btrbk-snapshots/@.20191121T171701+0100
/mnt/timeshift/backup/@ - -
2019-11-21T17:17:01+0100 snapshot success
/mnt/timeshift/backup/btrbk-snapshots/@.20191121T171701+0100
/mnt/timeshift/backup/@ - -
2019-11-21T17:17:01+0100 snapshot starting
/mnt/timeshift/backup/btrbk-snapshots/@home.20191121T171701+0100
/mnt/timeshift/backup/@home - -
2019-11-21T17:17:01+0100 snapshot success
/mnt/timeshift/backup/btrbk-snapshots/@home.20191121T171701+0100
/mnt/timeshift/backup/@home - -
2019-11-21T17:17:01+0100 delete_snapshot starting
/mnt/timeshift/backup/btrbk-snapshots/@.20191119T161701+0100 - - -
2019-11-21T17:17:01+0100 delete_snapshot success
/mnt/timeshift/backup/btrbk-snapshots/@.20191119T161701+0100 - - -
2019-11-21T17:17:01+0100 delete_snapshot starting
/mnt/timeshift/backup/btrbk-snapshots/@home.20191119T161701+0100 - - -
2019-11-21T17:17:01+0100 delete_snapshot success
/mnt/timeshift/backup/btrbk-snapshots/@home.20191119T161701+0100 - - -
2019-11-21T17:17:01+0100 delete_snapshot starting
/mnt/timeshift/backup/btrbk-snapshots/@home-chris-.steam.20191119T161701+0100
- - -
2019-11-21T17:17:01+0100 delete_snapshot success
/mnt/timeshift/backup/btrbk-snapshots/@home-chris-.steam.20191119T161701+0100
- - -
2019-11-21T17:17:01+0100 finished success - - - -

I had a tail on the log, these came out in one go, no larger pauses.
At first I thought, just my luck, here I am lying in wait and of
course everything works, then the mini-freeze happened. CPU usage in
one core spiked during the freeze, but I couldn't switch tabs from the
graphs to the process list in gnome-system-monitor. Top it is, next
time.

Am Mi., 20. Nov. 2019 um 19:32 Uhr schrieb Chris Murphy
<lists@colorremedies.com>:
> What are the mount options?

defaults, which comes out as
rw,relatime,ssd,space_cache,subvolid=,subvol=, according to mount.

> And what's the workload immediate prior to the snapshot? Or does it always happen no matter the workload?

Can't guarantee "always", but ... This time I was in the process of
composing this e-Mail. A couple of things open, sure, Firefox, couple
of terminals, Signal, evince, deadbeat [stopped], but not doing
anything much. I'd call the workload "idle", especially fs-wise. Last
time I was typing at a bash prompt via gnome-terminal -- the input
wouldn't show or register until it was over. It's not only
i/o-intensive stuff that blocks.

Am Do., 21. Nov. 2019 um 02:51 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
> Are you using qgroup?

Not knowingly. If either Timeshift or btrbk enable them, it's possible.

Cheers,
C.
