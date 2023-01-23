Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6311677C65
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jan 2023 14:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjAWNYK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Jan 2023 08:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAWNYJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Jan 2023 08:24:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF001244BE
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 05:24:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31302CE12B9
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 13:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C346C433EF
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674480242;
        bh=d2E1F1h39scEBfX2Y4yoPpxoGz9RMbDsUTEwE9coCPU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A+uhzcYvJMCbTCL5xfHJ6zF9YHJtZatSkqKUJyAFQO49iN62q/x9vrHDTVo3FO57N
         wqz7mbxgA2/ezANIsVKJ6Wd3lMy0LUNfMY++IsycprDHesd8MciuPJtKbI3RdSn3Qy
         58gHhj7jntaaRwAOjgODQa4KXJB+IWUVRTBSw9o53bpPQWHkSFCARs5OqXrIOL4O/j
         b5U0SKR04nt3PLSaethLzuKn0SBh6UU2IrTYG9CO2bsa4Oa3gCHbhhwvGlM7LuMNph
         1UnDywdG5oDnVv1jawOE/h/FeVqiRBLbSgUkeG+HeAbsuiDsSW8EzpNvCf+UyfqYLT
         Ak9l+HxOQ/hQw==
Received: by mail-oi1-f172.google.com with SMTP id r205so10308401oib.9
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 05:24:02 -0800 (PST)
X-Gm-Message-State: AFqh2kqvNBi2cHjEMrqaGG5ciSLWX0yxMJQLBNNmQYlTXjic5dVRWc7r
        RmP25RbEABjwBqRVKjBRUZNhIqjkZdJLC2zeXrM=
X-Google-Smtp-Source: AMrXdXt2G+Hv2PWQCi3lGf3crx/q0hMyvJ3E5FRa8eJawrHJ91heuKPSThuOmNwqIjL9Xnb6ovcsqeTkjn56C0v+esw=
X-Received: by 2002:aca:5882:0:b0:35b:75b:f3b9 with SMTP id
 m124-20020aca5882000000b0035b075bf3b9mr1260086oib.98.1674480241476; Mon, 23
 Jan 2023 05:24:01 -0800 (PST)
MIME-Version: 1.0
References: <Y8voyTXdnPDz8xwY@mail.gmail.com> <CAL3q7H5vjCrVEPVm0qySoXndBsnNDDT6H5VYMLORFxsZegXNpA@mail.gmail.com>
 <Y853dpWJQjUoBo4Q@mail.gmail.com>
In-Reply-To: <Y853dpWJQjUoBo4Q@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 23 Jan 2023 13:23:25 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5auixGxxjALT0D3mFcq-Lj=s2yX-HPEgLk=XZbUTTqng@mail.gmail.com>
Message-ID: <CAL3q7H5auixGxxjALT0D3mFcq-Lj=s2yX-HPEgLk=XZbUTTqng@mail.gmail.com>
Subject: Re: btrfs corruption, extent buffer leak
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 23, 2023 at 12:03 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
>
> >
> > https://lore.kernel.org/linux-btrfs/ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info/
>
> So it seems to be a known issue for 6.1. Is there any known workaround,
> or should I downgrade the kernel? Is there any risk of running an older
> kernel (and an older btrfs driver) on a filesystem that was driven by
> 6.1?

You can temporarily downgrade to a 6.0 or older kernel if you want to.

>
> > > Other than that, I couldn't list files in a directory two levels higher
> > > than the file that I attempted to create.
> >
> > You couldn't list files while the fs was in RO state, or after
> > rebooting? Or both?
>
> Only when it was in readonly. After rebooting, I could access that
> directory again, and the contents seemed to be intact.
>
> > What happened exactly when attempting to list files? What error did you get?
>
> Sorry, I didn't write down the error code...
>
> ls didn't show any entries and just displayed one line with an error,
> which I didn't save.
>
> > >
> > > After rebooting from a live USB, I ran btrfs scrub (no errors found) and
> > > btrfs check (some errors found):
> > >
> > > Opening filesystem to check...
> > > Checking filesystem on /dev/mapper/root
> > > UUID: ********-****-****-****-************
> > > [1/7] checking root items
> > > [2/7] checking extents
> > > [3/7] checking free space tree
> > > [4/7] checking fs roots
> > > [5/7] checking only csums items (without verifying data)
> > > [6/7] checking root refs
> > > [7/7] checking quota groups
> > > ERROR: failed to add qgroup relation, member=258 parent=71776119061217538: No such file or directory
> > > ERROR: loading qgroups from disk: -2
> > > ERROR: failed to check quota groups
> >
> > This is a different issue, it's the first time I see it, nothing
> > related to the previous one. I'm adding Qu to CC since he knows
> > qgroups much better than I do, and so he may have an idea.
>
> More info on this: after I rebooted and continued using the filesystem,
> I started seeing these messages in dmesg:
>
> BTRFS warning (device dm-0): qgroup rescan is already in progress
> BTRFS warning (device dm-0): qgroup rescan is already in progress
> ...
> BTRFS warning (device dm-0): qgroup rescan is already in progress
> BTRFS info (device dm-0): qgroup scan completed (inconsistency flag cleared)
>
> These messages repeated multiple times, i.e. qgroup rescan was
> apparently constantly triggered multiple times, and even after it was
> completed, something retriggered it again and again.
>
> Then I removed a few hundreds of gigabytes of files, deleted most
> subvolumes (there were several dozens of docker subvolumes), and I
> noticed that quotas became disabled on this filesystem. I reenabled
> quotas, rescanned qgroups, and the quota issue seems to be fixed: I no
> longer see repeated rescans in dmesg, and btrfs check doesn't show any
> errors now.

Disabling and re-enabling qgroups, or just rescanning, sometimes
solves qgroup related problems.

>
> > > found 1211137126400 bytes used, error(s) found
> > > total csum bytes: 1170686968
> > > total tree bytes: 10738614272
> > > total fs tree bytes: 8738439168
> > > total extent tree bytes: 557547520
> > > btree space waste bytes: 1726206798
> > > file data blocks allocated: 1533753126912
> > >  referenced 1324118478848
> > > extent buffer leak: start 931127214080 len 16384
> > > extent buffer leak: start 103570046976 len 16384
> > >
> > > The quota error and especially the extent buffer leak error don't look
> > > good to me. However, the filesystem seem to mount properly, and so far I
> > > didn't find any lost files (still looking). I don't know whether the
> > > amount of free space is shown correctly.
> > >
> > > What should be my steps to fix these errors? I didn't try btrfs check
> > > --repair yet, because of numerous warnings not to use it.
> > >
> > > Also, what is the approximate amount of the data lost due to this extent
> > > buffer leak? Is 16384 the number of sectors or the number of bytes?
> >
> > Why do you think there's data loss?
>
> The error message looked scary, I thought it meant that some extents
> with real data were leaked on the filesystem and became unreferenced.
> The "BTRFS critical: corrupt leaf" message in dmesg, followed by
> switching to readonly (a standard fallback when the filesystem is
> seriously screwed up), also gave me confidence some data were lost.

Only data that was not yet flushed to disk (and not fsynced) could be
lost, i.e. just like a sudden power failure.

And for metadata (file names, directories, xattrs, etc) only for
changes done since the last transaction commit and not fsynced.
By default, unless you use the mount option commix=xxx, transaction
commits happen every 30 seconds, sometimes less
as some fyncs may fallback to a transaction commit, or a snapshot was
created, etc.

>
> > The extent buffer leak is just a
> > btrfs-progs thing, it means the code failed to release allocated
> > memory - but once 'btrfs check' exits, the memory is released. This is
> > likely happening due to the qgroups error, some error path is not
> > freeing the memory.
>
> That's a relief to hear. I actually noticed that the "start" numbers
> weren't consistent if I ran btrfs check multiple times. And this error
> disappeared after fixing quotas, so it indeed seems to be related.
>
> I appreciate your help, thanks! What's the best thing to do in these
> circumstances to minimize further damage? Should I recreate the
> filesystem, or is it fine as it is? Should I downgrade the kernel for
> now? If the first error repeats, is there any risk for data loss?

No, no need to recreate the filesystem.
That was corruption detected during a fsync operation, and spitting
the error and turning the fs to read-only mode only prevents any
corruptions from being persisted.

Just downgrade to a 6.0 kernel or older for now, until the relevant
fixes land in a 6.1.x stable release.

>
> >
> > >
> > > Thanks,
> > > Max
