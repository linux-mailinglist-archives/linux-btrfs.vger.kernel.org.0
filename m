Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB269BB7C
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 19:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBRSxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 13:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBRSxQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 13:53:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10C610421
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 10:53:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z7so2345932edb.12
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 10:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CNKnXfMK1mwHhlM8YQBO2PbumHkv2/dp0egMJKjgyQE=;
        b=dbsoyDvP1PCdRl+AYoHSCAP7JSaMcgZxrW6Y00yVNH9OqGWXPM1FUY6tcARf5xApUf
         X2SMOhCU3+h3PBvAFkPoRXRsPWbppONqAgR7AHyCcS4ILh0/pyWuP1sU3GM5OCaU/boT
         zTIwk74wku5/leb+iRjC91f3Y/iCjd56hqEP7NLc08QlRhK/PHvucSul0jqjGAQQq+eH
         EzqDLeGCv+9nFC7WyCQjCXt4AXO+pee7YPbJBwL3xAhXHLJ05bphl1NIThVbtWmcqaH6
         RY27848e7+7AfGk2rMu7Q4IH5gIErNV0jxlKG+GH+5S+OZ9tOHGkzeXwfKRmZJgdUf8v
         +niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNKnXfMK1mwHhlM8YQBO2PbumHkv2/dp0egMJKjgyQE=;
        b=I1rtBEJaidNVdixCFXCfm3N4sgPlcXK2JcuzRHYaNzeh0dPPnEtiPtfm0GwoeBCZPM
         vnpDzDdhKv4Gifurwx2whR3SgoVUXyZMcU1wZ0WBgS09jMLLATsUA/JcWTygYPZu4V5C
         xKgGrINGk43zM+joMN1UZ25FfTJQd5/0aiI3l/8fhmNmPQqtNxuK1hJPEBI9S8ev2X0Z
         5QxCLlMhtGqyQe7QEkI6b35u2Q7w3kfuioSBIx8twGyF7agyTvhB7l7O4xY3fTrGptZ0
         A1ch49WwqhYsXGqceKplrNIBwW/ysgiBV9v5OlOkbWxrvbdHKBd3pOoYVh3qBWhXVREi
         LVzw==
X-Gm-Message-State: AO0yUKUD49PL6s/EBnr/C8IcihpdH3fqEeeVllQSXtWqOGD3hGiEk8Vk
        XTsTWDvSRPFQRmCn18Bo3T1sg/vjM9L7B00bET3/dOa5Mj60cw==
X-Google-Smtp-Source: AK7set+H19a61oZ0DWtElF5beUtvkMrxdwHRfcp2+tzRlcycU2GIKtQFTvXx4DhUU5x9yq4FMlBz9+hvgdDJlXxTMMg=
X-Received: by 2002:a50:c354:0:b0:4ad:7997:a47b with SMTP id
 q20-20020a50c354000000b004ad7997a47bmr403413edb.2.1676746393048; Sat, 18 Feb
 2023 10:53:13 -0800 (PST)
MIME-Version: 1.0
From:   "me@jse.io" <me@jse.io>
Date:   Sat, 18 Feb 2023 14:52:36 -0400
Message-ID: <CAFMvigej75zkdCuAoWT5Z7G7Y9Tki9v2bC2dmbe0YnE7-+3CLg@mail.gmail.com>
Subject: Can we get an override for NOCOW?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Can we get a mount option or sysfs tunable that would allow admins to
instruct Btrfs to ignore the NOCOW attribute?
The issue with NOCOW is it disables everything in Btrfs that makes
writes atomic and we don't have CSUMs. When Btrfs RAID is used, the
non-atomic writes to a NOCOW range means there's a sort of "write
hole" that exists on all RAID profiles that provide some redundancy --
a window of time where one copy is out of sync with the other.
Furthermore, there's no easy way to resync this when it goes out of
sync. Scrub skips over NOCOW blocks on RAID1(c3/c4) and RAID10. While
cp --reflink=never or balancing will choose only copy "at random" and
rereplicate it, this can make things worse since you can have sporadic
corruption spread throughout the file if the portion it rereplicated
is older.

This could be massive if a disk drops from the array and reappears at
a later time, you could have hours or days of out of sync data. Btrfs
doesn't track a disk that drops as being out of sync and thus not
trusting the nocow data on that disk until everything is resynced.

Additionally, any benefits of NOCOW are lost when snapshots are used,
and when you try to use btrfs send/receive with nocow files, if a
single block of data is changed in a NOCOW extent, send/receive will
copy the entire extent over, duplicating the entire thing, which can
be a significant amount of data after you send enough snapshots. So it
breaks deduplicated backups this way.

To make matters worse imo, NOCOW is not an option admins choose.
Instead, anyone in unprivileged userspace can set the NOCOW attribute
on a file, making recovery harder if a disk fails. As much as it would
be nice to trust users to make good choices for their data, everyone
here should be well aware this is often never the case.

 Further, many userspace applications and daemons set the NOCOW
attribute on directories/files as an optimization much to my chagrin
where I want maximum resilience, even if it comes at a performance
cost. Libvirt sets NOCOW by default on btrfs filesystems.
Systemd-tmpfiles is also used by many packages to set NOCOW as an
optimization, both for its log files by default, and many other
packages use it too, like for postgresql and mariadb. I'm certain
there are many other cases of this, it's just impossible for me to
keep tabs on all of them.

And While it's true it's impossible to detect bitrot without csums,
mitigations could be made to at least detect stale data. After all, MD
and LVM RAID do since they are overwriting in nature. If a disk drops
and reappears, that stale disk is resynced before it's trusted.
Bitmaps are used to reduce the need to resync everything after a
crash. Since this would be a lot of work though, and since COW+CSUMing
is the only way to fully protect data, my request is to simply have an
option to ignore NOCOW attributes. We already have the `nodatacow`
mount option that forces NOCOW/chattr +C on files, so I don't think it
would be much to ask for an opposite option. Since datacow is default,
but allows optional NOCOW, could we also have an option like
`datacow=always` that forces COW (and csuming assuming nocsums is set)
on all files? This would not be the first mount option to have
optional settings applied after =, like `discard` and `discard=async`,
and it wouldn't break any existing setups since it's opt-in.

The reason I'm asking for this is because btrfs is supposed to be a
CSUMing, COW filesystem. I use it specifically for these features, I
would use something like ext4 or xfs if I didn't want that. As an
admin, I do not want anyone else, package maintainers or users both,
compromising data integrity especially since it's a chore to keep tabs
on this. I need an option to easily block NOCOW. It would greatly
increase the reliability of Btrfs RAID.

Kind regards,
-Jonah
