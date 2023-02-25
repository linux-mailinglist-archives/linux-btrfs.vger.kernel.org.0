Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFCD6A2A43
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Feb 2023 15:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBYONw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Feb 2023 09:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYONv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Feb 2023 09:13:51 -0500
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E7113C4
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Feb 2023 06:13:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 420E73F3F5;
        Sat, 25 Feb 2023 15:13:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.989
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 55eNxfc8pIjK; Sat, 25 Feb 2023 15:13:44 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id F2E583F346;
        Sat, 25 Feb 2023 15:13:43 +0100 (CET)
Received: from [192.168.0.122] (port=55434)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pVvJ0-000AmD-BV; Sat, 25 Feb 2023 15:13:43 +0100
Message-ID: <c7600f66-73d9-f97c-e974-1bba2d1004f3@tnonline.net>
Date:   Sat, 25 Feb 2023 15:13:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Can we get an override for NOCOW?
To:     "me@jse.io" <me@jse.io>, linux-btrfs@vger.kernel.org
References: <CAFMvigej75zkdCuAoWT5Z7G7Y9Tki9v2bC2dmbe0YnE7-+3CLg@mail.gmail.com>
Content-Language: sv-SE
From:   Forza <forza@tnonline.net>
In-Reply-To: <CAFMvigej75zkdCuAoWT5Z7G7Y9Tki9v2bC2dmbe0YnE7-+3CLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-02-18 19:52, me@jse.io wrote:
> Can we get a mount option or sysfs tunable that would allow admins to
> instruct Btrfs to ignore the NOCOW attribute?
> The issue with NOCOW is it disables everything in Btrfs that makes
> writes atomic and we don't have CSUMs. When Btrfs RAID is used, the
> non-atomic writes to a NOCOW range means there's a sort of "write
> hole" that exists on all RAID profiles that provide some redundancy --
> a window of time where one copy is out of sync with the other.
> Furthermore, there's no easy way to resync this when it goes out of
> sync. Scrub skips over NOCOW blocks on RAID1(c3/c4) and RAID10. While
> cp --reflink=never or balancing will choose only copy "at random" and
> rereplicate it, this can make things worse since you can have sporadic
> corruption spread throughout the file if the portion it rereplicated
> is older.
> 
> This could be massive if a disk drops from the array and reappears at
> a later time, you could have hours or days of out of sync data. Btrfs
> doesn't track a disk that drops as being out of sync and thus not
> trusting the nocow data on that disk until everything is resynced.
> 
> Additionally, any benefits of NOCOW are lost when snapshots are used,
> and when you try to use btrfs send/receive with nocow files, if a
> single block of data is changed in a NOCOW extent, send/receive will
> copy the entire extent over, duplicating the entire thing, which can
> be a significant amount of data after you send enough snapshots. So it
> breaks deduplicated backups this way.
> 
> To make matters worse imo, NOCOW is not an option admins choose.
> Instead, anyone in unprivileged userspace can set the NOCOW attribute
> on a file, making recovery harder if a disk fails. As much as it would
> be nice to trust users to make good choices for their data, everyone
> here should be well aware this is often never the case.
> 
>   Further, many userspace applications and daemons set the NOCOW
> attribute on directories/files as an optimization much to my chagrin
> where I want maximum resilience, even if it comes at a performance
> cost. Libvirt sets NOCOW by default on btrfs filesystems.
> Systemd-tmpfiles is also used by many packages to set NOCOW as an
> optimization, both for its log files by default, and many other
> packages use it too, like for postgresql and mariadb. I'm certain
> there are many other cases of this, it's just impossible for me to
> keep tabs on all of them.
> 
> And While it's true it's impossible to detect bitrot without csums,
> mitigations could be made to at least detect stale data. After all, MD
> and LVM RAID do since they are overwriting in nature. If a disk drops
> and reappears, that stale disk is resynced before it's trusted.
> Bitmaps are used to reduce the need to resync everything after a
> crash. Since this would be a lot of work though, and since COW+CSUMing
> is the only way to fully protect data, my request is to simply have an
> option to ignore NOCOW attributes. We already have the `nodatacow`
> mount option that forces NOCOW/chattr +C on files, so I don't think it
> would be much to ask for an opposite option. Since datacow is default,
> but allows optional NOCOW, could we also have an option like
> `datacow=always` that forces COW (and csuming assuming nocsums is set)
> on all files? This would not be the first mount option to have
> optional settings applied after =, like `discard` and `discard=async`,
> and it wouldn't break any existing setups since it's opt-in.
> 
> The reason I'm asking for this is because btrfs is supposed to be a
> CSUMing, COW filesystem. I use it specifically for these features, I
> would use something like ext4 or xfs if I didn't want that. As an
> admin, I do not want anyone else, package maintainers or users both,
> compromising data integrity especially since it's a chore to keep tabs
> on this. I need an option to easily block NOCOW. It would greatly
> increase the reliability of Btrfs RAID.
> 
> Kind regards,
> -Jonah

Hi,

I fully agree. This is something that many of us would like to see. It 
is often asked about on the #btrfs IRC channel as well.

Last year I opened a ticked on GitHub to not forget this
https://github.com/kdave/btrfs-progs/issues/481

Regards,
Forza
