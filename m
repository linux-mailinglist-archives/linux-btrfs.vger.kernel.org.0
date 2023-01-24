Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BAE679DF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 16:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjAXPvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjAXPvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 10:51:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C43460BF
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 07:51:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b7so14329826wrt.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 07:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOd4v1qnG42wmEAKFj33Cj7/zghp0XISwEIt9LiqRFM=;
        b=SQqCJST7AOaOu55yxSKA6y143gcxyk2iEml/UFN/4yXsrXvKDBYm2GP46gHwiyrhRv
         dMytbj9Re+rr9+VwAE8OizXD/lEoZxm0gCAeC2Ch5hypxEiHDfQTtug1YI7WIwzjGZHl
         f+iUQgRg6VppHXHF2FW6t0aThiqj2fZSmYXEMM5POuJiliuDbir0bB0NK+86CzG/as1N
         KCZOjt4L1fUGSez1KzevUimzaJvPogQXKFd+ALDUJd+v0NpboyVEqJHa7l8uTQniH5V8
         iawBFQsd6eT2rkRCkq8ii9PxT2Er8MwaASGN6JQG6TNSWGj9FxYrE8kIdDDCf+Cuw1qH
         SN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOd4v1qnG42wmEAKFj33Cj7/zghp0XISwEIt9LiqRFM=;
        b=1Rx4vkPMO24UINSBLVwZXYySGdTTdmT979R+TRGjwOGjWhqqoU06NNZAY/cmlBEEyF
         UqxKSyYXQaTqsYp2XRwwhekTvhXI5SaK7kBu3vQRsqInTGNyIckCFkeyN5sflo23i+th
         9yrtH6v8UDAXN0IevJM+voB7qRahlwM9SWNilvvARq7WUngIg+/2YzODLmmSIgoICD7J
         k9oIaJXZgrSasRuu50425WEATkPNWMlP+CruWdXUirhifvyE4IeFqwUr3Hgjyc2omXNB
         2X3CQfohIMAEh9OSGGoWVT5y1zl7YaC8qV+/5bTuuj8XZqM+9ymwStiRf8GqdomHUMnf
         SAgQ==
X-Gm-Message-State: AFqh2krRhSYe+tkUsBeJ5Tx+HKyp84dx7RS4IXIQJRRQulnOtFmXaXGZ
        eKlIc5hIZn3qgYVVBGrbpnw=
X-Google-Smtp-Source: AMrXdXsYcsfVHoZ7ETOumabelOP6/hmNs+EU817fl1n9LKZm3MBbbayoR5rN0gjSrXmFTid3sD0EwQ==
X-Received: by 2002:a05:6000:a09:b0:2bd:e095:3f8f with SMTP id co9-20020a0560000a0900b002bde0953f8fmr27699299wrb.55.1674575467421;
        Tue, 24 Jan 2023 07:51:07 -0800 (PST)
Received: from localhost (ns3145504.ip-51-89-153.eu. [51.89.153.112])
        by smtp.gmail.com with ESMTPSA id m14-20020adffa0e000000b00287da7ee033sm2233435wrr.46.2023.01.24.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:51:06 -0800 (PST)
Date:   Tue, 24 Jan 2023 17:51:04 +0200
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: btrfs corruption, extent buffer leak
Message-ID: <Y8/+aOngUIC2ytGB@mail.gmail.com>
References: <Y8voyTXdnPDz8xwY@mail.gmail.com>
 <CAL3q7H5vjCrVEPVm0qySoXndBsnNDDT6H5VYMLORFxsZegXNpA@mail.gmail.com>
 <Y853dpWJQjUoBo4Q@mail.gmail.com>
 <CAL3q7H5auixGxxjALT0D3mFcq-Lj=s2yX-HPEgLk=XZbUTTqng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5auixGxxjALT0D3mFcq-Lj=s2yX-HPEgLk=XZbUTTqng@mail.gmail.com>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the advice!

On Mon, Jan 23, 2023 at 01:23:25PM +0000, Filipe Manana wrote:
> On Mon, Jan 23, 2023 at 12:03 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
> >
> > >
> > > https://lore.kernel.org/linux-btrfs/ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info/
> >
> > So it seems to be a known issue for 6.1. Is there any known workaround,
> > or should I downgrade the kernel? Is there any risk of running an older
> > kernel (and an older btrfs driver) on a filesystem that was driven by
> > 6.1?
> 
> You can temporarily downgrade to a 6.0 or older kernel if you want to.
> 
> >
> > > > Other than that, I couldn't list files in a directory two levels higher
> > > > than the file that I attempted to create.
> > >
> > > You couldn't list files while the fs was in RO state, or after
> > > rebooting? Or both?
> >
> > Only when it was in readonly. After rebooting, I could access that
> > directory again, and the contents seemed to be intact.
> >
> > > What happened exactly when attempting to list files? What error did you get?
> >
> > Sorry, I didn't write down the error code...
> >
> > ls didn't show any entries and just displayed one line with an error,
> > which I didn't save.
> >
> > > >
> > > > After rebooting from a live USB, I ran btrfs scrub (no errors found) and
> > > > btrfs check (some errors found):
> > > >
> > > > Opening filesystem to check...
> > > > Checking filesystem on /dev/mapper/root
> > > > UUID: ********-****-****-****-************
> > > > [1/7] checking root items
> > > > [2/7] checking extents
> > > > [3/7] checking free space tree
> > > > [4/7] checking fs roots
> > > > [5/7] checking only csums items (without verifying data)
> > > > [6/7] checking root refs
> > > > [7/7] checking quota groups
> > > > ERROR: failed to add qgroup relation, member=258 parent=71776119061217538: No such file or directory
> > > > ERROR: loading qgroups from disk: -2
> > > > ERROR: failed to check quota groups
> > >
> > > This is a different issue, it's the first time I see it, nothing
> > > related to the previous one. I'm adding Qu to CC since he knows
> > > qgroups much better than I do, and so he may have an idea.
> >
> > More info on this: after I rebooted and continued using the filesystem,
> > I started seeing these messages in dmesg:
> >
> > BTRFS warning (device dm-0): qgroup rescan is already in progress
> > BTRFS warning (device dm-0): qgroup rescan is already in progress
> > ...
> > BTRFS warning (device dm-0): qgroup rescan is already in progress
> > BTRFS info (device dm-0): qgroup scan completed (inconsistency flag cleared)
> >
> > These messages repeated multiple times, i.e. qgroup rescan was
> > apparently constantly triggered multiple times, and even after it was
> > completed, something retriggered it again and again.
> >
> > Then I removed a few hundreds of gigabytes of files, deleted most
> > subvolumes (there were several dozens of docker subvolumes), and I
> > noticed that quotas became disabled on this filesystem. I reenabled
> > quotas, rescanned qgroups, and the quota issue seems to be fixed: I no
> > longer see repeated rescans in dmesg, and btrfs check doesn't show any
> > errors now.
> 
> Disabling and re-enabling qgroups, or just rescanning, sometimes
> solves qgroup related problems.

I noticed that after I use docker, a lot of stale qgroups appear. They
can be easily cleared with btrfs qgroup clear-stale, but I don't recall
seeing them before:

0/3026           0.00B        0.00B   <stale>
0/3027           0.00B        0.00B   <stale>
0/3028           0.00B        0.00B   <stale>
0/3029           0.00B        0.00B   <stale>
0/3030           0.00B        0.00B   <stale>
0/3031           0.00B        0.00B   <stale>
0/3032           0.00B        0.00B   <stale>
0/3033           0.00B        0.00B   <stale>
0/3034           0.00B        0.00B   <stale>
0/3035           0.00B        0.00B   <stale>
0/3036           0.00B        0.00B   <stale>
0/3037           0.00B        0.00B   <stale>

Is there some garbage-collecting mechanism that will remove them over
time? Is it normal to see them at all?

> 
> >
> > > > found 1211137126400 bytes used, error(s) found
> > > > total csum bytes: 1170686968
> > > > total tree bytes: 10738614272
> > > > total fs tree bytes: 8738439168
> > > > total extent tree bytes: 557547520
> > > > btree space waste bytes: 1726206798
> > > > file data blocks allocated: 1533753126912
> > > >  referenced 1324118478848
> > > > extent buffer leak: start 931127214080 len 16384
> > > > extent buffer leak: start 103570046976 len 16384
> > > >
> > > > The quota error and especially the extent buffer leak error don't look
> > > > good to me. However, the filesystem seem to mount properly, and so far I
> > > > didn't find any lost files (still looking). I don't know whether the
> > > > amount of free space is shown correctly.
> > > >
> > > > What should be my steps to fix these errors? I didn't try btrfs check
> > > > --repair yet, because of numerous warnings not to use it.
> > > >
> > > > Also, what is the approximate amount of the data lost due to this extent
> > > > buffer leak? Is 16384 the number of sectors or the number of bytes?
> > >
> > > Why do you think there's data loss?
> >
> > The error message looked scary, I thought it meant that some extents
> > with real data were leaked on the filesystem and became unreferenced.
> > The "BTRFS critical: corrupt leaf" message in dmesg, followed by
> > switching to readonly (a standard fallback when the filesystem is
> > seriously screwed up), also gave me confidence some data were lost.
> 
> Only data that was not yet flushed to disk (and not fsynced) could be
> lost, i.e. just like a sudden power failure.
> 
> And for metadata (file names, directories, xattrs, etc) only for
> changes done since the last transaction commit and not fsynced.
> By default, unless you use the mount option commix=xxx, transaction
> commits happen every 30 seconds, sometimes less
> as some fyncs may fallback to a transaction commit, or a snapshot was
> created, etc.
> 
> >
> > > The extent buffer leak is just a
> > > btrfs-progs thing, it means the code failed to release allocated
> > > memory - but once 'btrfs check' exits, the memory is released. This is
> > > likely happening due to the qgroups error, some error path is not
> > > freeing the memory.
> >
> > That's a relief to hear. I actually noticed that the "start" numbers
> > weren't consistent if I ran btrfs check multiple times. And this error
> > disappeared after fixing quotas, so it indeed seems to be related.
> >
> > I appreciate your help, thanks! What's the best thing to do in these
> > circumstances to minimize further damage? Should I recreate the
> > filesystem, or is it fine as it is? Should I downgrade the kernel for
> > now? If the first error repeats, is there any risk for data loss?
> 
> No, no need to recreate the filesystem.
> That was corruption detected during a fsync operation, and spitting
> the error and turning the fs to read-only mode only prevents any
> corruptions from being persisted.

Thanks for the explanation! It's nice to hear it wasn't persisted to the
disk - that was what I worried about.

> Just downgrade to a 6.0 kernel or older for now, until the relevant
> fixes land in a 6.1.x stable release.

Thanks for the advice!

> 
> >
> > >
> > > >
> > > > Thanks,
> > > > Max
