Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA920C4F2
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jun 2020 02:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgF1AGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Jun 2020 20:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgF1AGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Jun 2020 20:06:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9FAC061794
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Jun 2020 17:06:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f9so6309447pfn.0
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Jun 2020 17:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=neifnYS4o/VkhgM4jUEE+/7fYouShTpYi1iXTubQynk=;
        b=CSoGWPyYuMRH7Sbmi94zKuOuxbBMaUENj5MmQe5ximIP6DTUXLn0+nfrmCnlTM68zN
         J61e76xxXZktgYYhCFrB5HdFWMMjvWKwBl4tscTbIz98aLZARbgfnDVZITPlJ2MdzKki
         xxm7P0rKrjxTDMMK+OxRUsxf4jZ1eSbqO54UVokBjOQatu5B5X2H+KnBlns08QBMGavH
         vFKDdtQQQ/6NXf9dmH4Sroeg63OOv9mjDp9+2VcRH63EogdcBM0I2No9+BzLTndCh+XZ
         VeEsaQCxgHq8e4olfDawDWAQbg/1PI26HbRAlSrwBc+JagW3tSfKYbyWJ0NhbfXZsI3a
         WSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=neifnYS4o/VkhgM4jUEE+/7fYouShTpYi1iXTubQynk=;
        b=Lv+5LGzLZZJS4zI/tKYACCZl0a4NvRgj3HWhxlHHiJBf8+WiXTD+OX39ViclV7Ryut
         F+U36mCF3WzP4VD5jc6KgqXow5Z6DZDeQxHi3BHKs98h9c9/DByTofA0cuFDNTS9L0dl
         cUw6jCmdXt3Y/fOP48gUW7IX4QcI+qlUdjn8D5LCPKfHERW1ryQ3ToiLubQeDsOqfCOv
         hKXF2TKNQLXQcnmW7XBDqZUwhzLHafS+86RS1wwffno0SqwA+MrzL4FtpnKYjuUtIn4k
         33ykkd+4OXnVbele9iwPIEC4cBKto2LIpNVJGXrlbvlDi29OVc6OZ6wVLZSAv5LO1C0b
         GgoA==
X-Gm-Message-State: AOAM530oYAi+eNmP/x/0q4ERI/Ru/MPxyAVuQ+EmoJCfhamPEaWG3Llp
        foKFmcGH9M2O52Hr+5eSl2wtxF6H
X-Google-Smtp-Source: ABdhPJwO+bZGY8N4qlap56yXgk4VPpGjQcyO70hfRXNmMFqn/eR0ooM0h0kLrshkULXZBWRoQp46gg==
X-Received: by 2002:a63:1f45:: with SMTP id q5mr4961988pgm.240.1593302811868;
        Sat, 27 Jun 2020 17:06:51 -0700 (PDT)
Received: from [192.168.178.53] (14-201-46-168.tpgi.com.au. [14.201.46.168])
        by smtp.gmail.com with ESMTPSA id fv7sm11307695pjb.22.2020.06.27.17.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 17:06:51 -0700 (PDT)
Subject: Re: How to use btrfs raid5 successfully(ish)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20200627032414.GX10769@hungrycats.org>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Message-ID: <cd123d15-cf94-69fd-5550-c18fd3bdaf5a@gmail.com>
Date:   Sun, 28 Jun 2020 10:06:48 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200627032414.GX10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the comprehensive reply Zygo!


On 27/6/20 1:24 pm, Zygo Blaxell wrote:
> Here are some guidelines for users running btrfs raid5 arrays to
> survive single-disk failures without losing all the data.  Tested with
> kernel 5.4.41.
>
> This list is intended for users.  The developer version of
> this list (with references to detailed bug descriptions) is
> https://lore.kernel.org/linux-btrfs/20200627030614.GW10769@hungrycats.org/
>
> Most of this advice applies to raid6 as well.  btrfs raid5 is in such
> rough shape that I'm not bothering to test raid6 yet.
>
> 	- never use raid5 for metadata.
>
> Use raid1 for metadata (raid1c3 for raid6).  raid5 metadata is vulnerable
> to multiple known bugs that can each prevent successful recovery from
> disk failure or cause unrecoverable filesystem damage.
>
> 	- run scrubs often.
>
> Scrub can repair corrupted data before it is permanently lost.  Ordinary
> read and write operations on btrfs raid5 are not able to repair disk
> corruption in some cases.
>
> 	- run scrubs on one disk at a time.
>
> btrfs scrub is designed for mirrored and striped arrays.  'btrfs scrub'
> runs one kernel thread per disk, and that thread reads (and, when
> errors are detected and repair is possible, writes) to a single disk
> independently of all other disks.  When 'btrfs scrub' is used for a raid5
> array, it still runs a thread for each disk, but each thread reads data
> blocks from all disks in order to compute parity.  This is a performance
> disaster, as every disk is read and written competitively by each thread.
>
> To avoid these problems, run 'btrfs scrub start -B /dev/xxx' for each
> disk sequentially in the btrfs array, instead of 'btrfs scrub stat
> /mountpoint/filesystem'.  This will run much faster.
>
>          - ignore spurious IO errors on reads while the filesystem is
>          degraded.
>
> Due to a bug, the filesystem will report random spurious IO errors and
> csum failures on reads in raid5 degraded mode where no errors exist
> on disk.  This affects normal read operations, btrfs balance, and device
> remove, but not 'btrfs replace'.  Such errors should be ignored until
> 'btrfs replace' completes.
>
> This bug does not appear to affect writes, but it will make some data
> that was recently written unreadable until the array exits degraded mode.
>
> 	- device remove and balance will not be usable in degraded mode.
>
> 'device remove' and balance won't harm anything in degraded mode, but
> they will abort frequently due to the random spurious IO errors.
>
> 	- when a disk fails, use 'btrfs replace' to replace it.
>
> 'btrfs replace' is currently the only reliable way to get a btrfs raid5
> out of degraded mode.
>
> If you plan to use spare drives, do not add them to the filesystem before
> a disk failure.  You may not able to redistribute data from missing
> disks over existing disks with device remove.  Keep spare disks empty
> and activate them using 'btrfs replace' as active disks fail.
>
> 	- plan for the filesystem to be unusable during recovery.
>
> There is currently no solution for reliable operation of applications
> using a filesystem with raid5 data during a disk failure.  Data storage
> works to the extent I have been able to test it, but data retrieval is
> unreliable due to the spurious read error bug.
>
> Shut down any applications using the filesystem at the time of disk
> failure, and keep them down until the failed disk is fully replaced.
>
> 	- be prepared to reboot multiple times during disk replacement.
>
> 'btrfs replace' has some minor bugs that don't impact data, but do force
> kernel reboots due to hangs and stuck status flags.  Replace will restart
> automatically after a reboot when the filesystem is mounted again.
>
>          - spurious IO errors and csum failures will disappear when
> 	the filesystem is no longer in degraded mode, leaving only
> 	real IO errors and csum failures.
>
> Any read errors after btrfs replace is done (and maybe after an extra
> reboot to be sure replace is really done) are real data loss.  Sorry.
>
> 	- btrfs raid5 does not provide as complete protection against
> 	on-disk data corruption as btrfs raid1 does.
>
> When data corruption is present on disks (e.g. when a disk is temporarily
> disconnected and then reconnected), bugs in btrfs raid5 read and write
> code may fail to repair the corruption, resulting in permanent data loss.
>
> btrfs raid5 is quantitatively more robust against data corruption than
> ext4+mdadm (which cannot self-repair corruption at all), but not as
> reliable as btrfs raid1 (which can self-repair all single-disk corruptions
> detectable by csum check).
>
> 	- scrub and dev stats report data corruption on wrong devices
> 	in raid5.
>
> When there are csum failures, error counters of a random disk will be
> incremented, not necessarily the disk that contains the corrupted blocks.
> This makes it difficult or impossible to identify which disk in a raid5
> array is corrupting data.
>
> 	- scrub sometimes counts a csum error as a read error instead
> 	on raid5.
>
> Read and write errors are counted against the correct disk; however,
> there is some overlap in the read counter, which is a combination
> of true csum errors and false read failures.
>
> 	- errors during readahead operations are repaired without
> 	incrementing dev stats, discarding critical failure information.
>
> This is not just a raid5 bug, it affects all btrfs profiles.
>
> 	- what about write hole?
>
> There is a write hole issue on btrfs raid5, but it occurs much less often
> than the other known issues, and the other issues affect much more data
> per failure event.
